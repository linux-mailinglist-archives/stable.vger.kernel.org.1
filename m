Return-Path: <stable+bounces-212340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH5QBGcwemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB27A48C6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA1D3076528
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8830BBBC;
	Wed, 28 Jan 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TcovvTXg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF562301465;
	Wed, 28 Jan 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615190; cv=none; b=R/CvV2qBdGHNN+ycv9bQ/U21Mw5WB9YJSOMNYVDEYt1YGENhoTS3HEb1hpYBWwZfIKTg6T6zuRQWbwec2IS2GoKXJ7kn552YuhWRPSy0Dm2TsWJyraPpLUWq6qI+3u6NvIaylcqdrlphrhWRtc88UYNSHedgAuxSOrN6SmG2QXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615190; c=relaxed/simple;
	bh=J+suWZdfrLZI8+hvGqgdXAm4n3+XUryg8+LGLBVJTR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rv9yw9IwR2gktC5j9DhmvgViMNEGv6TKjLVeZ53JGY/cubgGRkNdI6UK2hbm9UBz0HuzM3R0i72mjT0noNXUu/l+i54XfmFCdkO4Ci7+RJFTBRtwRgQtgeCnhGFdh5bGLCERTmrnFlA1EOfeXlybIsVCn6ixJdH8ea4SvmFcdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TcovvTXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003B2C4CEF7;
	Wed, 28 Jan 2026 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615190;
	bh=J+suWZdfrLZI8+hvGqgdXAm4n3+XUryg8+LGLBVJTR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcovvTXgFcby5Ht5ETaXovcTcNLFsp4B++jOtgPu1biJjwtoQ9o5x4ohh+QnJwoO2
	 xb3evBuI9caNQj+PIH+5UBJRNkTcbtIcmJKNspp4G7gPy1CQG+yR/2SNFJtK9/K2HO
	 Ihxg/s69iFdUC0TCGgacYxj8xQOX+o+SnVRGSSgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Markus Koeniger <markus.koeniger@liebherr.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 105/169] iio: accel: iis328dq: fix gain values
Date: Wed, 28 Jan 2026 16:23:08 +0100
Message-ID: <20260128145337.787092575@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212340-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,liebherr.com:email]
X-Rspamd-Queue-Id: 9AB27A48C6
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Koeniger <markus.koeniger@liebherr.com>

commit b8f15d1df2e73322e2112de21a4a7f3553c7fb60 upstream.

The sensors IIS328DQ and H3LIS331DL share one configuration but
H3LIS331DL has different gain parameters, configs therefore
need to be split up.
The gain parameters for the IIS328DQ are 0.98, 1.95 and 3.91,
depending on the selected measurement range.

See sensor manuals, chapter 2.1 "mechanical characteristics",
parameter "Sensitivity".

Datasheet: https://www.st.com/resource/en/datasheet/iis328dq.pdf
Datasheet: https://www.st.com/resource/en/datasheet/h3lis331dl.pdf
Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/st_accel_core.c |   72 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,7 +517,6 @@ static const struct st_sensor_settings s
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = H3LIS331DL_ACCEL_DEV_NAME,
-			[1] = IIS328DQ_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
@@ -561,6 +560,77 @@ static const struct st_sensor_settings s
 				},
 			},
 		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x22,
+			.mask_ihl = 0x80,
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
+	{
+		.wai = 0x32,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = IIS328DQ_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0x18,
+			.odr_avl = {
+				{ .hz = 50, .value = 0x00, },
+				{ .hz = 100, .value = 0x01, },
+				{ .hz = 400, .value = 0x02, },
+				{ .hz = 1000, .value = 0x03, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0x20,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_100G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(980),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_200G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(1950),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_400G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(3910),
+				},
+			},
+		},
 		.bdu = {
 			.addr = 0x23,
 			.mask = 0x80,



