Return-Path: <stable+bounces-247689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCwyFpwJB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:55:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20554EDBA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 432CD30B887E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCF46AF0B;
	Fri, 15 May 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zZN7Gqy+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC544CAEC
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845572; cv=none; b=JRqg6zh+FvrscFC3tRipKAsrLCgtFs0FngLIS3NttZo2rafuSuzzGaR3vFDFQ5twgVhjSOdbvPA8YIbHQ1H/uPZ3o4vDRv0qRFPmUY7ZiAjeCWNxMtvmrmYp1XvWSDlfxbcetcE8CMi9oVVKADNkXp0FOykEF6Sf0VI3XxSqDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845572; c=relaxed/simple;
	bh=4VK4oXnlgxjBzxU9bb2HufvF2ufwQYe4aqVBcqfMIyI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CIxPGsfwkulQumHPZ1wiosfFW7msPUqMtLsfwZwsWJ8/otO8XwnbkDZwh5px3D7WwgEkdDH45PyXUT1f843NvwG8dTEimkHIrHn/H9w1wBYwCq7E8+Fp4sEdXPr37UViHjBcuWAVbxwVI3O7zLz13h7wbEHq0utITKuElFtaTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zZN7Gqy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D8BC2BCB0;
	Fri, 15 May 2026 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845571;
	bh=4VK4oXnlgxjBzxU9bb2HufvF2ufwQYe4aqVBcqfMIyI=;
	h=Subject:To:From:Date:From;
	b=zZN7Gqy+IqmAYqzVuSJo9/3Ko9MttLQlvjQHzP+s4+2K7eAKrESR89D7A+5BrR3Jr
	 FFeOITLScMcSJzM4+yhfkfxDrUpIpfrxwTXzGtpoflRsC8k8zhTyTgEG8Gd4zXOIHB
	 H5gRypEGGWJqBge53DTqh9zWzKIzyxO5C1qxEb9M=
Subject: patch "iio: adc: nxp-sar-adc: fix division by zero in write_raw" added to char-misc-linus
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:56 +0200
Message-ID: <2026051556-skiing-poison-e81b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F20554EDBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247689-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: adc: nxp-sar-adc: fix division by zero in write_raw

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a9aba21a539c668a66b58eeb08ad3909e5a54c2a Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Wed, 1 Apr 2026 18:29:24 +0300
Subject: iio: adc: nxp-sar-adc: fix division by zero in write_raw

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero or a negative value to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Also prevent unsigned integer underflow when the computed cycle count is
smaller than NXP_SAR_ADC_CONV_TIME, which would wrap the u32 inpsamp to
a huge value.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/nxp-sar-adc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 705dd7da1bd2..1711cae7d872 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -569,6 +569,9 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		/*
 		 * Configures the sample period duration in terms of the SAR
 		 * controller clock. The minimum acceptable value is 8.
@@ -577,7 +580,11 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 		 * sampling timing which gives us the number of cycles expected.
 		 * The value is 8-bit wide, consequently the max value is 0xFF.
 		 */
-		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
+		inpsamp = clk_get_rate(info->clk) / val;
+		if (inpsamp < NXP_SAR_ADC_CONV_TIME)
+			return -EINVAL;
+
+		inpsamp -= NXP_SAR_ADC_CONV_TIME;
 		nxp_sar_adc_conversion_timing_set(info, inpsamp);
 		return 0;
 
-- 
2.54.0



