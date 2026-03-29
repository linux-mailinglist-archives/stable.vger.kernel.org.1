Return-Path: <stable+bounces-230931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A7cHcIpyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB58352421
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ACF5301C5AF
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A21375AAC;
	Sun, 29 Mar 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sQXrqfsQ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E882FD7D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790955; cv=none; b=SmdIg7mfszDdxKbLzZT0W6bdV2URaXfkE6LTE4EWIcWbZbHhDJjIVHHUHH/qhkpbTRu43OmTSoeCiADieGya7nMWAA5sruMs4B1prKt9O4KFJXx+aab9uNK9p+AOPKnvSDy88G3CegbDiUpxRFgTkJvONqsAZ5ytSv7Z6VVxYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790955; c=relaxed/simple;
	bh=99eBEOxUNJRMhfk54vtx0DIHj3apKlyCgFlOmb+ulQU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=HQXLmx0EJ6R1Zru+IJgm1FfJVjo07vweLSsxUHthDsY4ntpPOQRbS/f7kjFo4G8kL0dRKhMezPG+6lvOArq3MIja8pYHh5xl5a14Rs64/BRehDPi3mFbtdlQ2Z+KPyvEmHbktZE3iK0rp4Onq5fR2+7b86XO9EXaKHhg0+esBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sQXrqfsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0760FC116C6;
	Sun, 29 Mar 2026 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790955;
	bh=99eBEOxUNJRMhfk54vtx0DIHj3apKlyCgFlOmb+ulQU=;
	h=Subject:To:From:Date:From;
	b=sQXrqfsQGXxlOTrHCiHOyU0J2UixhnVQDCg3/aT1j9Hx8nHiks52wrrq/iKa9e+BT
	 Je/HoYoMordkvDRDun8Gtz307eG4NFFLll3aOfyWSXFMtW4ETrsR4XVe4eneFQIfM4
	 72M9aqsXxQGNNKd/vgMqo40geo765bslBcGFpNRc=
Subject: patch "iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger mode" added to char-misc-linus
To: ustc.gu@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:17 +0200
Message-ID: <2026032916-muster-refusal-5305@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230931-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEB58352421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 2452969ca1081fea6bd9ab7ad5e168a5d11f28ec Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 22 Feb 2026 17:45:39 +0800
Subject: iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger mode

The DMA channel was requested in nxp_sar_adc_buffer_postenable() but
was only released in nxp_sar_adc_buffer_software_do_predisable().
This caused a DMA channel resource leak when operating in trigger mode.

Fix this by moving dma_request_chan() from
nxp_sar_adc_buffer_postenable() into
nxp_sar_adc_buffer_software_do_postenable(), ensuring the DMA channel
is only requested in software mode.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9efa883c277d..58103bf16aff 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -718,6 +718,10 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
 	struct nxp_sar_adc *info = iio_priv(indio_dev);
 	int ret;
 
+	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
+	if (IS_ERR(info->dma_chan))
+		return PTR_ERR(info->dma_chan);
+
 	nxp_sar_adc_dma_channels_enable(info, *indio_dev->active_scan_mask);
 
 	nxp_sar_adc_dma_cfg(info, true);
@@ -738,6 +742,7 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
 out_dma_channels_disable:
 	nxp_sar_adc_dma_cfg(info, false);
 	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
+	dma_release_channel(info->dma_chan);
 
 	return ret;
 }
@@ -765,10 +770,6 @@ static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned long channel;
 	int ret;
 
-	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
-	if (IS_ERR(info->dma_chan))
-		return PTR_ERR(info->dma_chan);
-
 	info->channels_used = 0;
 
 	/*
-- 
2.53.0



