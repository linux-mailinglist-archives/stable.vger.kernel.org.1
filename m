Return-Path: <stable+bounces-220198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOFmDAAuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE611C55FE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 237B130E54D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EB4CA286;
	Sat, 28 Feb 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fADaQdch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F34CA27C;
	Sat, 28 Feb 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300104; cv=none; b=DWeWbiT0cbSHW2tqpZ1bzolfVOfKyUAve7CkHIOkLijgacJMLrLOO1nH/8oChRp14nOfmWs8XXpjrYfhwKtnPgsYYfCRF78gjqHENb5Aao0P+tSXb3nOtsmh9dFbXhtFpvmVeiRUt1ae+MZJEFfncaS5q59+KNc0iVUuQoeGrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300104; c=relaxed/simple;
	bh=xaIgGtio2hQ3S0ThiGuPtYQV1KuDGEDcRMPFl0mXZ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWqJmkAfFPZ4RVBOhAsWDGWAgMxKQZZMO9s3VuMKeji+IcOACRpTeU2l4ufDMkoUVCp8LiMVKVkDLCUORjTnPOOpwBx5hhisK013M3dlFNzjn0msWq7mhkDAeH88VWbLEdMvRPRrenpfcF8HBaRfI+3fIYDJ299Sj3GLwwM3eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fADaQdch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D76C19424;
	Sat, 28 Feb 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300104;
	bh=xaIgGtio2hQ3S0ThiGuPtYQV1KuDGEDcRMPFl0mXZ0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fADaQdch841eACSrppRDy049WI5w7SujVVmdgoJkI908v5jbO1wM10czymyUCfnT3
	 JBOLAcjHQh0DVHrG9oJ4xYVqjfDPFBHwQYOxwJh3qMZCRR/D6QtACkugTSdizmCzAo
	 zGY0QRW5s1DfyCvBBLkkkaAo1peHs1K/7jN1VPZy7e2QjyhSvFuTqGUxjzHG6BvFnR
	 7EM6k++qQF7dIbnktEGAwq034Br4xFu/hO6Kzds6yK0fgKOS/K1LvH1W7utFxPJe8x
	 PWAQDxP3kkZykqf5Aeq4hUj7vBWMunxS4VbckCkwa9v9Q3JtDMnVzaj+p3LMQ+lpm9
	 2u947hU3YOV6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 120/844] x86/sev: Use kfree_sensitive() when freeing a SNP message descriptor
Date: Sat, 28 Feb 2026 12:20:33 -0500
Message-ID: <20260228173244.1509663-121-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220198-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,msgid.link:url,intel.com:email,inria.fr:email]
X-Rspamd-Queue-Id: BFE611C55FE
X-Rspamd-Action: no action

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit af05e558988ed004a20fc4de7d0f80cfbba663f0 ]

Use the proper helper instead of an open-coded variant.

Closes: https://lore.kernel.org/r/202512202235.WHPQkLZu-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/20260112114147.GBaWTd-8HSy_Xp4S3X@fat_crate.local
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/coco/sev/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 9ae3b11754e65..c8ddb9febe3d9 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2008,8 +2008,7 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 	iounmap((__force void __iomem *)mdesc->secrets);
 
-	memset(mdesc, 0, sizeof(*mdesc));
-	kfree(mdesc);
+	kfree_sensitive(mdesc);
 }
 EXPORT_SYMBOL_GPL(snp_msg_free);
 
-- 
2.51.0


