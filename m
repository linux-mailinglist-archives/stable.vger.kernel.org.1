Return-Path: <stable+bounces-247554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNpRKOncBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1854BA1B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4B13011588
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E93E4C6E;
	Fri, 15 May 2026 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oE6ySI41"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172073932EE
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833980; cv=none; b=SzfTnEhUqe0g9MNTv3zAJC0WJpkhNFMSIrpOE5xT8x+MRuTPco1zSyIWcDAmGmHDTd++6eX3qD9i0hTCDOnm56iL1KhHuuIYuJHpkZwgI2yrnSTQrlu5iQLsyKdGcJDPwWzDiZp1/Ow/CS1hEpanaS5ALxzH62v2U4jric7CnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833980; c=relaxed/simple;
	bh=ctfzlbCq1R7RIGSe9utlj/udN8+zrYNimqmiGX2cRjE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GVuqO3owxXdedTjfkRcqVK2fatb6Nd8unKRtdYMR0ljuptsP6QM6SMC0P/kh2Lrtk18rsBZUDZlYA4kmDH6YtgyOd8k9JPCTplqyfHCENX+7l87j81PML20lstMa55vSTfmkSEjOkl32URDoKmIN62WPfjZjhXVQOhkouz+sl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oE6ySI41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADD8C2BCB0;
	Fri, 15 May 2026 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833980;
	bh=ctfzlbCq1R7RIGSe9utlj/udN8+zrYNimqmiGX2cRjE=;
	h=Subject:To:Cc:From:Date:From;
	b=oE6ySI41vcl+im3Su9vnZvv8W6yFCWFAInXjJ1ljESuPwtZDPq4dWURWysvtrhiO4
	 K6KoYcD3QHbXap9GWIAAr+/s1hvfQXKIvTKRS9rP9qTY5UGPej/undy9PpKFvJ8pfm
	 J/KPtWJtmeTcDdFxxA8Bj1zilJSnGvf/b0a0aZJ4=
Subject: FAILED: patch "[PATCH] spi: cadence: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,harinik@xilinx.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:32:56 +0200
Message-ID: <2026051556-silliness-brigade-7a9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CB1854BA1B
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
	TAGGED_FROM(0.00)[bounces-247554-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xilinx.com:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 666fa7e9ca98e71c880086ca24147ae843f1ed6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051556-silliness-brigade-7a9d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 666fa7e9ca98e71c880086ca24147ae843f1ed6e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:12 +0200
Subject: [PATCH] spi: cadence: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: c474b3866546 ("spi: Add driver for Cadence SPI controller")
Cc: stable@vger.kernel.org	# 3.16
Cc: Harini Katakam <harinik@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index caa7a57e6d27..08d7dabe818d 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -777,6 +777,10 @@ static void cdns_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	if (!spi_controller_is_target(ctlr)) {
@@ -784,7 +788,7 @@ static void cdns_spi_remove(struct platform_device *pdev)
 		pm_runtime_set_suspended(&pdev->dev);
 	}
 
-	spi_unregister_controller(ctlr);
+	spi_controller_put(ctlr);
 }
 
 /**


