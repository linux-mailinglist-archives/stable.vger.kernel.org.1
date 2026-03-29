Return-Path: <stable+bounces-230918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNuMGxInyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4923352329
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EE930233C9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651236492B;
	Sun, 29 Mar 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCHjIDf6"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D75280A5A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790365; cv=none; b=ollN4/xIVHiw+Y0FwHGAYwxy97pJHPz9zFLaxWumEVEuZv07LfnP1j8yeybHKnDCD2Gbl+LtBfl4GX8xwcTBt5k3FYvBhXd38Ybhtecg76IyMPTTk+3zZoE2UhpwNNT3Eb16SuxFHi++xM3w585oPji4zo3td8ha0rc00wNLp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790365; c=relaxed/simple;
	bh=PWPT0GsUVpkYDMOzlyxhjdytK1lqV1xZsoEUi4qlsIo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Rm4wTe5TXE4pQ4juFoyh30iNI0dDUnMJsLyTyl4W9vBbxdZ97EHqJCISeKiPbFPLVu90WJTFGATrOv8uoxOiRBmP3rEHf4HwU4j1EMCCpsrRAY63bmVlf7TXEOuiQvvHMkrTjJ0TdJA8X1sXgK9nOgf+uXGFeix3B94Y0pq5F+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCHjIDf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD31C19423;
	Sun, 29 Mar 2026 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790365;
	bh=PWPT0GsUVpkYDMOzlyxhjdytK1lqV1xZsoEUi4qlsIo=;
	h=Subject:To:From:Date:From;
	b=eCHjIDf6WIgEfqSYtVwty2V4yE5b481+PxO5LZHwgAUwualNREkOA63IFCC60TCfq
	 uxO6PlGIevk+oU3y2N3ULcRkIPj4PX69tKXWA8bU8YpFHfue8886h/Kr+2gJuS3whM
	 uwqO4WVV8h8Hg6G6Y9dfoWD+AvBaoaw/jWoTt5lE=
Subject: patch "iio: imu: adis16550: fix swapped gyro/accel filter functions" added to char-misc-linus
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,robert.budai@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:17 +0200
Message-ID: <2026032917-dipped-oxidize-8a2b@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230918-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,analog.com:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4923352329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: imu: adis16550: fix swapped gyro/accel filter functions

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ea7e2e43d768102e2601dbbda42041c78d7a99f9 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 27 Feb 2026 14:20:46 +0200
Subject: iio: imu: adis16550: fix swapped gyro/accel filter functions

The low-pass filter handlers for IIO_ANGL_VEL and IIO_ACCEL call each
other's filter functions in both read_raw and write_raw. Swap them so
each channel type uses its correct filter accessor.

Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Acked-by: Robert Budai <robert.budai@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 28f0dbd0226c..1f2af506f4bd 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -643,12 +643,12 @@ static int adis16550_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			ret = adis16550_get_accl_filter_freq(st, val);
+			ret = adis16550_get_gyro_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
 		case IIO_ACCEL:
-			ret = adis16550_get_gyro_filter_freq(st, val);
+			ret = adis16550_get_accl_filter_freq(st, val);
 			if (ret)
 				return ret;
 			return IIO_VAL_INT;
@@ -681,9 +681,9 @@ static int adis16550_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			return adis16550_set_accl_filter_freq(st, val);
-		case IIO_ACCEL:
 			return adis16550_set_gyro_filter_freq(st, val);
+		case IIO_ACCEL:
+			return adis16550_set_accl_filter_freq(st, val);
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0



