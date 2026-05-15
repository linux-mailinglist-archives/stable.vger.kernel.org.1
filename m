Return-Path: <stable+bounces-247369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOC0IQ6wBmqnmwIAu9opvQ
	(envelope-from <stable+bounces-247369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272A54996D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D9F30474DF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8FC3093BB;
	Fri, 15 May 2026 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJXFTeSX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032283F4132
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823118; cv=none; b=NYzIIgl21NWT8fg1Zv8mTigkeHpBMgBBCKE6PLlOtHkDlNrpsme7F7y/oHuZXSUJ1C2JvosJJkV5Yxov8h9pPHNfgTl8kMd7hA+BB231doVonMCo4AjxkDV9C3hvc86spIavS0ElOfgEJ711UGNbe5uTd2uY1VvpdUKjUhmHmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823118; c=relaxed/simple;
	bh=h0gBCodRFlbNdxg5q6NJ/qBFaV3BGKbcqa2/lv5KHa8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OwbnLVdsh1LWIlHgi2gcxf0zJd+7Qca2pmbaGUlhIn/mo268jqqDU5G9L8lo4ubHwKNVM1NRy38gc+glpp49xi8XWhzwocy8MGbR5hcc6Zj8GnkEUYjbZOldyswvSnOpr0zTDjn+rDyCfzBuiYzjaXl3mjYPHSla3KEZ/vgHCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJXFTeSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A195C2BCB0;
	Fri, 15 May 2026 05:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823117;
	bh=h0gBCodRFlbNdxg5q6NJ/qBFaV3BGKbcqa2/lv5KHa8=;
	h=Subject:To:Cc:From:Date:From;
	b=CJXFTeSX+H1vMk6NyLSmyZP5Xf7bfGd2z5mSHsyfShUT3ccZFtJonNjwsPXljVRSK
	 RZ3/yEynUSE+ap8pRmd7xf9n68guCvUzuCU9GA3+sKJrDqZ8Ok7dmSlgatm0cyplGx
	 UNjup3Ud32wtxjWq3xs0DTN79yjloksYKoH9jmSU=
Subject: FAILED: patch "[PATCH] spi: meson-spicc: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:31:54 +0200
Message-ID: <2026051554-mutilator-emoticon-370a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2272A54996D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247369-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 77953c76bec9af4191f8692a10225dd816208718
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051554-mutilator-emoticon-370a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77953c76bec9af4191f8692a10225dd816208718 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:16 +0200
Subject: [PATCH] spi: meson-spicc: fix controller deregistration

Make sure to deregister the controller before disabling it to allow SPI
device drivers to do I/O during deregistration.

Fixes: 454fa271bc4e ("spi: Add Meson SPICC driver")
Cc: stable@vger.kernel.org	# 4.13
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-18-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 57768da3205d..b80f9f457b66 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -1081,7 +1081,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "spi registration failed\n");
 		goto out_host;
@@ -1099,8 +1099,14 @@ static void meson_spicc_remove(struct platform_device *pdev)
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
+	spi_controller_get(spicc->host);
+
+	spi_unregister_controller(spicc->host);
+
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
+
+	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {


