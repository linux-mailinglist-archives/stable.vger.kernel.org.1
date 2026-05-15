Return-Path: <stable+bounces-247371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JU8NRmwBmqnmwIAu9opvQ
	(envelope-from <stable+bounces-247371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EC549974
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693743054302
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7E33066E;
	Fri, 15 May 2026 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YG0M5A+n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AE3093BB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823122; cv=none; b=erKGaBRGOTbCDRRVbgGdTa2NOPFu/upsbYydEPzzIsgPc5qRkYjy1PSZgKu4UGxp7OIfl2BQS536RNYA4mS+j0YYDnHJwylUz3U2YSffhcNRJQe98rnVmylII5Hjg/GA1azptrERNdF3VHbV/mwhhCusm/FEgFZN2Vd2hbQYEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823122; c=relaxed/simple;
	bh=n61AWDvBP4mk7oK3BmF+RUQqQcL+YUM3fAQt/UTfr8w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Okt5r5cYjzczZrIrT/kGHLC8mit4uDmmk6YlBzWocmbR2Wn7nA2xQNFkvhJbLIU5OBMiXYXGc/BdXA2jvdFWNZlMIWPZBp1CGho0r9ereYs1hGA/oOACMlFipRdPw15ABXXlxh3r4bO701F6ilIlB7nz1e82YWRsVhgZwaT1Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YG0M5A+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749D4C2BCB0;
	Fri, 15 May 2026 05:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823122;
	bh=n61AWDvBP4mk7oK3BmF+RUQqQcL+YUM3fAQt/UTfr8w=;
	h=Subject:To:Cc:From:Date:From;
	b=YG0M5A+ne9h1KtGCDDNRsU+Jg67cwfB4XZD6v81ixEx+S3DqhbYdgsLpUJ+FfZvXx
	 EP46YXjKlHNCpi7R2xCo4bPbH7T92B1wwn0hc/8fQC8anNF/0+dopTyExIVLg9CTv7
	 /VuzkXVhljmFOpiyuSAjaP/w4ZZba2whSHoa4CLw=
Subject: FAILED: patch "[PATCH] spi: meson-spicc: fix controller deregistration" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:31:54 +0200
Message-ID: <2026051554-playing-earmuff-72d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B5EC549974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247371-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 77953c76bec9af4191f8692a10225dd816208718
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051554-playing-earmuff-72d0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


