Return-Path: <stable+bounces-168381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A1B234D6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9569A681FE5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0B2FF16C;
	Tue, 12 Aug 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToKiGSrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE122FE579;
	Tue, 12 Aug 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023989; cv=none; b=iUtZ8Gx5gx9R+N7PDcGMsjnnk8iSWosCK7KShiD5lMg5SlAMdKxEY5GGXjlh8TlDrxljgCdZhKy7czimOB7IZwefsvO2TqSH1ov5Jq1EKeadSk5ejGirC62x8c+oz6AIB7r9yxmEb1/nDzte0K9v//hUl3hU412dBei4lZsDix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023989; c=relaxed/simple;
	bh=wENkP5XZhWqQNCgMSaXJB+MK2zcRyhhmBEV6Du2/jAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg5xH3oKy9Gv1rrzGD35AqEzZjqcOIwkhcIcRzXYrLJalFc3FfzAfZxGK2CcRDoo54isIIwZXwjI05qtrlIfkM6dJwsAyNzAztj846R/4DEwyV/5R4XuVFW8+BY9BIJmypXq6riVKZyv2XszlH5iFY5FHI1MjPP4wBsjxMCUC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToKiGSrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E5C4CEF0;
	Tue, 12 Aug 2025 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023988;
	bh=wENkP5XZhWqQNCgMSaXJB+MK2zcRyhhmBEV6Du2/jAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToKiGSrRkFkrW3aDDdqONdCkDclx6Ep1ZPxay3GheVsGsrMR/Qc5wt/kcihltXlJt
	 ZZQ825kd0t7TYuowjTxxbkPmkuS62Y9pix/IA+3cnDD+wzeqDNZKSihoankf6jPefS
	 AkE3yWaWPt87MgULCuhpnQv73JBR+VgwH4NLnQVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 207/627] um: rtc: Avoid shadowing err in uml_rtc_start()
Date: Tue, 12 Aug 2025 19:28:22 +0200
Message-ID: <20250812173427.158460715@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 4c916e3b224a02019b3cc3983a15f32bfd9a22df ]

Remove the declaration of 'err' inside the 'if (timetravel)' block,
as it would otherwise be unavailable outside that block, potentially
leading to uml_rtc_start() returning an uninitialized value.

Fixes: dde8b58d5127 ("um: add a pseudo RTC")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250708090403.1067440-5-tiwei.bie@linux.dev
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/rtc_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
index 51e79f3148cd..67912fcf7b28 100644
--- a/arch/um/drivers/rtc_user.c
+++ b/arch/um/drivers/rtc_user.c
@@ -28,7 +28,7 @@ int uml_rtc_start(bool timetravel)
 	int err;
 
 	if (timetravel) {
-		int err = os_pipe(uml_rtc_irq_fds, 1, 1);
+		err = os_pipe(uml_rtc_irq_fds, 1, 1);
 		if (err)
 			goto fail;
 	} else {
-- 
2.39.5




