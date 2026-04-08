Return-Path: <stable+bounces-235182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDHvOQur1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F613C2DC7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104263070361
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E473D411F;
	Wed,  8 Apr 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sk/o1QFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AD37F01B;
	Wed,  8 Apr 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674780; cv=none; b=VykYxNDSgmXJKQopCz+vxQGDcMzPBtgn0leYajTOMqxEyCdTdOW9lBlg4KS4HkNzhnKkDmQSr8omgBWAl2g8Gz8kCrSBIcpQ17/4SUwUEBbVbyE8QnqCWmek3rg8Fg6JFW6txAkq3Is2aSF3yl/Wi28UrI0/Ctu3oMoZa8of92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674780; c=relaxed/simple;
	bh=R7jRdxzexwoTEfU7g1kGo0H8GGUDeFQ37KjAmedmvJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuAvmVQEgnHM2gTVewhQMDYGuJAF5u5OEFiKRz7JAV6loR22XZctQTXcMbsJiTC4kuSp2Wya5oZlTPxCJGPvlUTpKL7u5GJbpmRWolAhdzGpuGrvcofTYLsRVnRsW+l1gDZurI9re2YjB6w4sMSbY6vSI96jnf8jmBM6gwkwaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sk/o1QFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CF1C19421;
	Wed,  8 Apr 2026 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674780;
	bh=R7jRdxzexwoTEfU7g1kGo0H8GGUDeFQ37KjAmedmvJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sk/o1QFno52+9SErwPNvjRr9qIq357+ZCGt1SE97zW1gR5jZFy0u32y/0TgjEpsF3
	 BHDaE0GMd98PjxlGuQ7lvLJRy4d41EHQ2dBhKP6oyhgQzVMl9mfPASBlFfKjAYwTzi
	 gRZVKh9Dcw0sCGhn3xLld3wJtWx7ivhJV29vs9UA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 230/311] iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only
Date: Wed,  8 Apr 2026 20:03:50 +0200
Message-ID: <20260408175947.986046642@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235182-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 53F613C2DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

commit 679c04c10d65d32a3f269e696b22912ff0a001b9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6
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



