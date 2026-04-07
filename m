Return-Path: <stable+bounces-233644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCyhC5oc1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:02:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFF3B0936
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A27423032794
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79035837C;
	Tue,  7 Apr 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJWC1FfX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AC352C4F
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574070; cv=none; b=euSyAX/FOEiVyaAOia1HLKZoWdTZOJLN9SqKp9MF7vsLz1O1itTtvChn2Grbh2NZRPI6t7Um74j1gIR8cM5A7ddU3Nn9F6YO4o5uLipbBteNvtqWwocGRma/IK0Tah4AQpswUm3LqiDuG9m4+TrT0k+dt38er8HSCmrCcPkoiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574070; c=relaxed/simple;
	bh=wmcNw6eEVvVhfEVqJwTotfE/7e+Z+TudWMgFwN7An9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bwUnzq+yq1M3aN+Q6Eg/rCcTOPWFyhJq7ST3HSRbseb5wqr6r4q/1SLPhBJ2zpi7P3GpVhJT+nlvmy/IqKCHcy842q3usHwaImIJbT+/6YDha5wo5DIgFbFdNzKg2Fn3r9b8JTQRhKMubERV7ukD6vUU2Oijp8rYd0D79X5NEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJWC1FfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24509C116C6;
	Tue,  7 Apr 2026 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574070;
	bh=wmcNw6eEVvVhfEVqJwTotfE/7e+Z+TudWMgFwN7An9g=;
	h=Subject:To:Cc:From:Date:From;
	b=DJWC1FfX1Dy/fnOiZ/K3c/BLE3kkRqTVD3PUvxAZu1tmg2SvTiAtesbPF5LcSXk71
	 AI79SgFgyNOSVDHbHd/fc1y7lpQTkL0OHeMpvJEuXOW0LWM743TCC3fsfXtLekg/Mg
	 jJFXCMBxeOPpWCT0mdFow/w99T7Pz4A/QE5GCUYQ=
Subject: FAILED: patch "[PATCH] iio: adc: ti-adc161s626: fix buffer read on big-endian" failed to apply to 5.10-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:01:00 +0200
Message-ID: <2026040700-cylinder-stunning-dc4d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233644-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,huawei.com:email,scan.data:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,baylibre.com:email]
X-Rspamd-Queue-Id: 7BAFF3B0936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 24869650dff34a6fc8fd1cc91b2058a72f9abc95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040700-cylinder-stunning-dc4d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24869650dff34a6fc8fd1cc91b2058a72f9abc95 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 18:13:31 -0500
Subject: [PATCH] iio: adc: ti-adc161s626: fix buffer read on big-endian

Rework ti_adc_trigger_handler() to properly handle data on big-endian
architectures. The scan data format is 16-bit CPU-endian, so we can't
cast it to a int * on big-endian and expect it to work. Instead, we
introduce a local int variable to read the data into, and then copy it
to the buffer.

Since the buffer isn't passed to any SPI functions, we don't need it to
be DMA-safe. So we can drop it from the driver data struct and just
use stack memory for the scan data.

Since there is only one data value (plus timestamp), we don't need an
array and can just declare a struct with the correct data type instead.

Also fix alignment of iio_get_time_ns() to ( while we are touching this.

Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 28aa6b80160c..42968d96572b 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -70,8 +70,6 @@ struct ti_adc_data {
 
 	u8 read_size;
 	u8 shift;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ti_adc_read_measurement(struct ti_adc_data *data,
@@ -114,15 +112,20 @@ static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ti_adc_data *data = iio_priv(indio_dev);
-	int ret;
+	struct {
+		s16 data;
+		aligned_s64 timestamp;
+	} scan = { };
+	int ret, val;
 
-	ret = ti_adc_read_measurement(data, &indio_dev->channels[0],
-				     (int *) &data->buffer);
-	if (!ret)
-		iio_push_to_buffers_with_timestamp(indio_dev,
-					data->buffer,
-					iio_get_time_ns(indio_dev));
+	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);
+	if (ret)
+		goto exit_notify_done;
 
+	scan.data = val;
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+
+ exit_notify_done:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;


