Return-Path: <stable+bounces-265868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f4VpBZuRMWrYmwUAu9opvQ
	(envelope-from <stable+bounces-265868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:10:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A2693DBF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=q4XxK+WS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265868-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265868-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C8743001FBA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99D3D525E;
	Tue, 16 Jun 2026 18:10:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60353CC324;
	Tue, 16 Jun 2026 18:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633424; cv=none; b=cQvHXTJrmrRhSvC2Bf+t7hhzWr/zZQrmlSSL8v7PtxGeKXw9A124OfFYpMVes1w1flTwh0/cIlRrQ/p6GGQGSTCgsmtoEEeyI/e8+e1S/Toddjmh5IrdQVzEDshMvEIW4NpwgKq+BOl0PFDoVY8/7f/qA4QURXs1y+qHE1+B76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633424; c=relaxed/simple;
	bh=71JVXa4954h0JzuwjS0WUn4j8rxxPFE2Lf5IIWC1huM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gec+QPi/FxQ22dILyx+Yel1/vQMPL05S24F1J1VzK3bHwa8ZqdHUph0FiuSStVP2p4ckQC27c6ccr3bZXTuIh5OwX4LDaBX9ysfON9KpIi9eZA3fkuB01o2vv9Ltf0O6pz6dP5XKDFd1K/VdS1byB2+n8opQd4SsCu9Imq/8p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4XxK+WS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935261F000E9;
	Tue, 16 Jun 2026 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633423;
	bh=eEfj5n1S5ORVDBmmFa0FRrDKDVE63d5Xeq9eTKScUeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q4XxK+WSbcGIn9SQGCtdgsyVw3pg5yo6xa/7AkTCUZKz0qN4kV/EsuCiqEhA15CcJ
	 WGu23WbEZ8FpUDGK8EkdHG1i6iKSNN59uhdAUBkJOqU99G3pMcnb7wtt7IzFWK3J8v
	 T5PZWTeLpBQR8TW0lChqUQ33KanViMNLnGfPIRLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Advait Dhamorikar <advaitd@mechasystems.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5.15 076/411] iio: magnetometer: st_magn: fix default DRDY pin selection for LIS2MDL
Date: Tue, 16 Jun 2026 20:25:14 +0530
Message-ID: <20260616145104.316116351@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265868-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:advaitd@mechasystems.com,m:andriy.shevchenko@intel.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,intel.com:email,mechasystems.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 042A2693DBF

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Advait Dhamorikar <advaitd@mechasystems.com>

commit 49f79cd28f1e3333cbe0d616ce59ead0b24bf34e upstream.

The device tree binding for st,lis2mdl does not support
st,drdy-int-pin property. However, when no platform data is provided
and the property is absent, the driver falls back to default_magn_pdata
which hardcodes drdy_int_pin = 2. This causes
`st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
sensor settings have no INT2 DRDY mask defined.

Fix this by checking the sensor's INT2 DRDY mask availability at
probe time and selecting the appropriate default pin. Sensors that
do not support INT2 DRDY will default to INT1, while all others
retain the existing default of INT2.

Fixes: 38934daf7b5c ("iio: magnetometer: st_magn: Provide default platform data")
Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/st_magn_core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -504,6 +504,11 @@ static const struct st_sensors_platform_
 	.drdy_int_pin = 2,
 };
 
+/* LIS2MDL only supports DRDY on INT1 */
+static const struct st_sensors_platform_data alt_magn_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -632,8 +637,12 @@ int st_magn_common_probe(struct iio_dev
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	if (!pdata) {
+		if (mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)



