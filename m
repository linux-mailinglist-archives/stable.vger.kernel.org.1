Return-Path: <stable+bounces-247692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP1ONLEQB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:25:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57054F7E7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 178233079976
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124E45BD57;
	Fri, 15 May 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBQYLz1k"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA842EEBD
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845582; cv=none; b=R3bbGT0tNIGQInP2MrIJ9Yz/AvxtPETEW55fcuy+eVb9OaRfKLUKVE/9AuLXt3NRJJZrmTvDsYHXLz8CQouK53KnRLprWgbkA23jzaA0QfHHMnDRam7tjocNhPO3F90+UKFf6jwJNz+hSLy8PHj87DIkrwU6pfj15rx6zJH73K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845582; c=relaxed/simple;
	bh=jq0lVFwHg/uA0iAl2huniaqeTN2pyvpjOS4OKOGP22Y=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rV8paObtwazJ78BdkK1TKD2DqHFIehzKPIGFwDOufDV1XRcVOm3L5xpjNgMtDBr2FBu2DMk0uL1qMBLU+3JYIoo8WIJ4JYeCJXipwI3wgM3wH6x5Xsx5P1EB2KK5HFKGeOu9xBTiS2w2Pdir+g8KithvuRho0zMVX3M5eS00R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBQYLz1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEFBC2BCB8;
	Fri, 15 May 2026 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845582;
	bh=jq0lVFwHg/uA0iAl2huniaqeTN2pyvpjOS4OKOGP22Y=;
	h=Subject:To:From:Date:From;
	b=GBQYLz1kinJRoE1cI/Dq8uwD8e02rOwtMx1ebedzP79hjdKjlQ+V4SXbJebGtqGvU
	 IN9/KO618SCKS3vX+WLfKvzA/fFsrodmFhmLqt17p6498Zbm5WXGaC9e2heIpijTHy
	 55+cL/fGYD1n+i3ObBiOAHXf/slYE1Ncg1yi62UQ=
Subject: patch "iio: adc: nxp-sar-adc: zero-initialize dma_slave_config" added to char-misc-linus
To: shuvampandey1@gmail.com,Stable@vger.kernel.org,dlechner@baylibre.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:57 +0200
Message-ID: <2026051557-hatless-unlivable-d608@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB57054F7E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247692-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,baylibre.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: adc: nxp-sar-adc: zero-initialize dma_slave_config

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8ce176501f836634f9c0419c0820140f968e9dc5 Mon Sep 17 00:00:00 2001
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Mon, 6 Apr 2026 15:38:24 +0545
Subject: iio: adc: nxp-sar-adc: zero-initialize dma_slave_config

nxp_sar_adc_start_cyclic_dma() only fills the RX-side members of
dma_slave_config before passing it to dmaengine_slave_config().

Zero-initialize the structure so unused members do not contain stack
garbage. Some DMA engines consult optional dma_slave_config fields, so
leaving them uninitialized can cause DMA setup failures.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/nxp-sar-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 1711cae7d872..8f4ed3db94f0 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -676,7 +676,7 @@ static void nxp_sar_adc_dma_cb(void *data)
 static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
 {
 	struct nxp_sar_adc *info = iio_priv(indio_dev);
-	struct dma_slave_config config;
+	struct dma_slave_config config = { };
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
-- 
2.54.0



