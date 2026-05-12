Return-Path: <stable+bounces-245592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A/KKFcwA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6A521AAA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26703016276
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1C372060;
	Tue, 12 May 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yHa26XUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CD3E1716
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593206; cv=none; b=DCTMQ9R6y64JH9HywUo5sWi5reAOZxGY9TZUj/k8Pkj8qhE8WuNWTlfGmfFmIlZ8F3ui7XkqEibIKQ85hzhxS1E7IDPRe9x8USwRzX2UI8iWaD1H6B4iY1q0f9zfGABoQFhRqFSpetXB9NUKL2rs6LA+tNWLO2KBo7spNwgMvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593206; c=relaxed/simple;
	bh=LLFkZB9tsc6/Ig3vshS0IZ9QCnchxhLs79Z48yFvBwU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gzuDC1ecuMGIICjP+8TwvzZWKXQVcSzWpySVBdmvtOxD2Rtw8geY7xIRAYY3vId1HTxtYSD1kab2XeSRsZmCICUEuJE3HLkg5QPnquzM0OD/O9lpI4/HaMlY9Cka0m2F2VD2QbUNynZY6E0/AEZMG44rQhSbg9MuDQqy3oQn7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yHa26XUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276EAC2BCB0;
	Tue, 12 May 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593206;
	bh=LLFkZB9tsc6/Ig3vshS0IZ9QCnchxhLs79Z48yFvBwU=;
	h=Subject:To:Cc:From:Date:From;
	b=yHa26XUXM6AhXUwdvcosS+PVfrZPqSVe7xQes2R14zSNQ+pKo3UosV5VCp+7pLuGR
	 piUE4vXLu+F9lb71nKopT8w897QFw2zysuWClyIm73qPZjc8CXwy1y/y4SqEvXCke0
	 IbJMXe1Px1/xAc2w+2w+1XVGW255wPxI0rooWBv0=
Subject: FAILED: patch "[PATCH] EDAC/versalnet: Fix device name memory leak" failed to apply to 6.18-stable tree
To: ptsm@linux.microsoft.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:40:03 +0200
Message-ID: <2026051203-jasmine-payment-6259@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18E6A521AAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245592-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,alien8.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8cf5dd235eff6008cb04c3d8064d2acfa90616f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051203-jasmine-payment-6259@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cf5dd235eff6008cb04c3d8064d2acfa90616f1 Mon Sep 17 00:00:00 2001
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Date: Wed, 1 Apr 2026 04:18:56 -0700
Subject: [PATCH] EDAC/versalnet: Fix device name memory leak

The device name allocated via kzalloc() in init_one_mc() is assigned to
dev->init_name but never freed on the normal removal path.  device_register()
copies init_name and then sets dev->init_name to NULL, so the name pointer
becomes unreachable from the device. Thus leaking memory.

Use a stack-local char array instead of using kzalloc() for name.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260401111856.2342975-1-ptsm@linux.microsoft.com

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index ec1315582414..97ec05d68bbb 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -777,9 +777,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
+	char name[MC_NAME_LEN];
 	struct device *dev;
 	enum dev_type dt;
-	char *name;
 	int rc;
 
 	config = priv->adec[CONF + i * ADEC_NUM];
@@ -813,13 +813,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	layers[1].is_virt_csrow = false;
 
 	rc = -ENOMEM;
-	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
-	if (!name)
-		return rc;
-
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto err_name_free;
+		return rc;
 
 	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
 	if (!mci) {
@@ -858,8 +854,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	edac_mc_free(mci);
 err_dev_free:
 	kfree(dev);
-err_name_free:
-	kfree(name);
 
 	return rc;
 }


