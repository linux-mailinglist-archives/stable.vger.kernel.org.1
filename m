Return-Path: <stable+bounces-230905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M8xLLcmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAB73522B0
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D7383016814
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32301372692;
	Sun, 29 Mar 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWiJ7r+z"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A82FD7D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790310; cv=none; b=IzMETVSoYfYhz2+rUaLc+ybZMxgwRmBD7qfPPE/t3WBmYt+Vg/WmD7Iwa5eSBzM9HSIqNhRQ9eHX+XZX74chZL9VbUIAWuY+bMLeMo5J9nEuCMSAPv2Q0+p9oUk90AGXFHGhn5NuTxXNJjbDKO26FuRm/lXgUlgn06bYTigzDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790310; c=relaxed/simple;
	bh=eUObXkDO0aaz6HjqfsxXWTSIM8Y7Ab5GY101jzmGRTU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=pS3i/CUMm1D5Mt9+PIpNv0pXBoClSlRVitllqeYbs0Febd3zu8waVuqP2Zcy9JX16VyZzoq8BNVYf8yBHy81z+wUYGeSjZhzT74wxEPQq3HyQMsYCCyuRt7aSNpdScXHoQfFG8HkMFO+RBidw8tRyjA/1ttNcyMzyLordA+DVEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWiJ7r+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741F6C116C6;
	Sun, 29 Mar 2026 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790309;
	bh=eUObXkDO0aaz6HjqfsxXWTSIM8Y7Ab5GY101jzmGRTU=;
	h=Subject:To:From:Date:From;
	b=CWiJ7r+zY1hgCbzbH7sQ0et9hFUfmx0EM4ZMZSWVueVUeEzKU8nwx5rOc+IETsn9K
	 B79N8ZdwuYroY3aox4rV6KBc6w5VUxqKS8p9VavrkBrEByE0ZobMQ/qkR6aN826Mjk
	 pLMgceSzHoGrZuE9xa1UOeT9dO465l5y2vUF7AA8=
Subject: patch "iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer" added to char-misc-linus
To: flavra@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:10 +0200
Message-ID: <2026032910-slain-appendix-8c5a@gregkh>
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
	TAGGED_FROM(0.00)[bounces-230905-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,baylibre.com:email]
X-Rspamd-Queue-Id: 4CAB73522B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 679c04c10d65d32a3f269e696b22912ff0a001b9 Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Wed, 25 Feb 2026 11:06:01 +0100
Subject: iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer
 only

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

The motivation for being able to set a buffer frequency different from the
sensor sampling frequency is to support use cases that need accurate event
detection (which requires a high sampling frequency) while retrieving
sensor data at low frequency. Since all the supported event types are
generated from acceleration data only, do not create the buffer sampling
frequency attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1ee2fc5f5f1f..5b28a3ffcc3d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = i == ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.53.0



