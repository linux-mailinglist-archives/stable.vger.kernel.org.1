Return-Path: <stable+bounces-103709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00259EF91D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725BC189CFD2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30922248B8;
	Thu, 12 Dec 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijd9DpZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA7222D7C;
	Thu, 12 Dec 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025370; cv=none; b=ArCpG5GJZ5b9qfCS3L1Wyru5d3Nh6MGCNmfFoENV9k4smJdZ6Mls98pEmgl01w5+bCTdrB9mqV6za5CHw3SyP6xLwcNJpvFR32D1j8MvuMdwFGT9sDRfYhQgLhLFaauJP9hr/botICUvHl4yAdHqrSeJv0o0Mpi1ELEXiyPVloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025370; c=relaxed/simple;
	bh=5BPWmb3fKRByaaRgCUKenxInYLPv0LBnGUy886yJe1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAiLUx8awOBCd/gaj5/TVq7L18Z1Bh31LHff5Dn1nEmKijt3iNw/9GY+0YsRqY+JMUTTR6l85WEggQ860je5RYKgWwsK7Dn7k43cGipG7amrDTTO3IPK1jQayeWDHslSaCJg/allvy/e5ym+m3iwW1RPaumYiVMTaMtuT6UQOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijd9DpZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7F2C4CEF9;
	Thu, 12 Dec 2024 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025370;
	bh=5BPWmb3fKRByaaRgCUKenxInYLPv0LBnGUy886yJe1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijd9DpZsEeMIuyezk80cmtkKR0+MSmptcMDwh3To1rS4Cu29rfpUg9y3A6MMh9NXK
	 TBVmxNnMDc6dTWxuqeyDKPZ9G1idW2VYy/+T8+WiysYk8KS9sw7xkqTmCDgiOe78E0
	 YyNharCp4ziJOChsn/SLsqIjoW/JrnD5omn1/+l4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	chao liu <liuzgyid@outlook.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 140/321] apparmor: fix Do simple duplicate message elimination
Date: Thu, 12 Dec 2024 16:00:58 +0100
Message-ID: <20241212144235.510860534@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: chao liu <liuzgyid@outlook.com>

[ Upstream commit 9b897132424fe76bf6c61f22f9cf12af7f1d1e6a ]

Multiple profiles shared 'ent->caps', so some logs missed.

Fixes: 0ed3b28ab8bf ("AppArmor: mediation of non file objects")
Signed-off-by: chao liu <liuzgyid@outlook.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index deccea8654ad8..1b13fd89d5a9f 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -94,6 +94,8 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
 		return error;
 	} else {
 		aa_put_profile(ent->profile);
+		if (profile != ent->profile)
+			cap_clear(ent->caps);
 		ent->profile = aa_get_profile(profile);
 		cap_raise(ent->caps, cap);
 	}
-- 
2.43.0




