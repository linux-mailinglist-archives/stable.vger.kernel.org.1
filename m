Return-Path: <stable+bounces-64028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886AE941BD2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E68DB265F9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C118990A;
	Tue, 30 Jul 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PeSaeTyj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A517D8BB;
	Tue, 30 Jul 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358744; cv=none; b=G5fpVAeMuKChUSUPD94Tg7wM3PhRIYdDWxJ2eIwZwUEQ4XXB6bxZ6PaxMzb00JiSHMHK7ytKCQm4cYkHOpccqrGXNzlVpBnQuJqVGBoAQtnovSHBOoCVkk1X5GcYUEQNnqajFJvk6f9Q4DlSaxi0p1Ji6Dw+AzQUEO34aBHLdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358744; c=relaxed/simple;
	bh=DEfxtJ8WDI+pjkCDishJShdodQFX8cXdxVtQYWSt188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdMswDTr6Dy4sxVdt7FJRlWMN7j7GCSQkxUUpBkKe2D4fRF1Cua/AuuQC86zd0l58lUqFd1CdVF2L2PESOrtgxbgby50RaSKq9/ogvef7fQlf7l4u/3W4c2Q6N1gE3FZNRCAZK9pj6hJzehvYVra+Mef5Xl9/wE1NgBozvoiTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PeSaeTyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F2C32782;
	Tue, 30 Jul 2024 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358744;
	bh=DEfxtJ8WDI+pjkCDishJShdodQFX8cXdxVtQYWSt188=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PeSaeTyjB8W+IpPP77UHfw47hLSq/rxC3dniAoIJ8r9QOzbc8nvsKNhk7DNiamNQh
	 VjZEHipjAmokYEuvRiH+OLOErcU+s6aDwJG2p36j7FbMacHHBwNPMR2NshSVA/Nh90
	 NJQu7yxNkvInF3qG1kv0+fOjNUG+qegWjqz1sN8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 418/440] mISDN: Fix a use after free in hfcmulti_tx()
Date: Tue, 30 Jul 2024 17:50:51 +0200
Message-ID: <20240730151632.112991020@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 61ab751451f5ebd0b98e02276a44e23a10110402 ]

Don't dereference *sp after calling dev_kfree_skb(*sp).

Fixes: af69fb3a8ffa ("Add mISDN HFC multiport driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/mISDN/hfcmulti.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index e840609c50eb7..2063afffd0853 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -1931,7 +1931,7 @@ hfcmulti_dtmf(struct hfc_multi *hc)
 static void
 hfcmulti_tx(struct hfc_multi *hc, int ch)
 {
-	int i, ii, temp, len = 0;
+	int i, ii, temp, tmp_len, len = 0;
 	int Zspace, z1, z2; /* must be int for calculation */
 	int Fspace, f1, f2;
 	u_char *d;
@@ -2152,14 +2152,15 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
 		HFC_wait_nodebug(hc);
 	}
 
+	tmp_len = (*sp)->len;
 	dev_kfree_skb(*sp);
 	/* check for next frame */
 	if (bch && get_next_bframe(bch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 	if (dch && get_next_dframe(dch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 
-- 
2.43.0




