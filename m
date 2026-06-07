Return-Path: <stable+bounces-261397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MTSKLVBJJWqVGAIAu9opvQ
	(envelope-from <stable+bounces-261397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6264FD18
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MT2QcDMo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261397-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261397-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35649302BBF6
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC41329391;
	Sun,  7 Jun 2026 10:33:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4021FE47B;
	Sun,  7 Jun 2026 10:33:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828391; cv=none; b=O8TPqp5gzjaW3GVYYzVJnWFLz0b1GtM9mbOLmi9BlhyoP1IEn1hndF5AsUiRO1ptoqcm5zE1dGmxio/6VutdPBAYANx8FyEwEo0cHcDjeSBuymypKzFvFfVBLhkuzaCBy76V9ZkP2qqctJ4+e29SFE9CbRxhtSfodFkKTwkfjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828391; c=relaxed/simple;
	bh=lmeLzQgkFiaQhyUiPS/Ljd6/jFNQviXabzyd/3djmCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK4mRHpOqoit0ecENDP1oHJgY3gyrdo3e6RjksZieJi9R2Bl6gG9Y3wGrIAOI3z8AQlS05uCRguodOhb2zjanTd5tc1yzI4e6TyCCQqiclLYi1uvNMZi/pvKysSXayhmG2OWYXokSmsmHLbfEhRnQbHJ8KIa3y1tsTCxiDYRQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MT2QcDMo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6771F00893;
	Sun,  7 Jun 2026 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828390;
	bh=tsdIKZuZ9grmxN3oKCMpQEGmQQB3yOKlSzl0AQ98y+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MT2QcDMoEs7oylBLZluxIT4mT0L0XbXNRxz1VrzR4m7zwlAf1tGOR5p0ErTr7j2Z9
	 IllNNqD/RyQBeZZaiLF5gD06cAWBY3zt0cri5paDG/pZ36H0PkxYOzeEBp/EFSM06Y
	 EXH16Vh3XShElP89fdzPs6bW+WClDWdy8t9B+mmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.18 155/315] iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings
Date: Sun,  7 Jun 2026 11:59:02 +0200
Message-ID: <20260607095733.293258399@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kimseer.paller@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DB6264FD18

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kim Seer Paller <kimseer.paller@analog.com>

commit ebd250c2581ec46c64c73fdfa918c9a7f757505e upstream.

The AD3531/AD3531R has different output operating modes from the
AD3530/AD3530R. According to the AD3531/AD3531R datasheet, the
powerdown modes are:
  01: 500 Ohm output impedance
  10: 3.85 kOhm output impedance
  11: 16 kOhm output impedance

The driver currently uses the AD3530R modes (1k, 7.7k, 32k) for all
variants, which is incorrect for AD3531/AD3531R.

Add AD3531R-specific powerdown mode strings and assign them to the
AD3531/AD3531R chip variants.

Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad3530r.c |   54 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -108,6 +108,12 @@ static const char * const ad3530r_powerd
 	"32kohm_to_gnd",
 };
 
+static const char * const ad3531r_powerdown_modes[] = {
+	"500ohm_to_gnd",
+	"3.85kohm_to_gnd",
+	"16kohm_to_gnd",
+};
+
 static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
@@ -136,6 +142,13 @@ static const struct iio_enum ad3530r_pow
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static const struct iio_enum ad3531r_powerdown_mode_enum = {
+	.items = ad3531r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad3531r_powerdown_modes),
+	.get = ad3530r_get_powerdown_mode,
+	.set = ad3530r_set_powerdown_mode,
+};
+
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 					 uintptr_t private,
 					 const struct iio_chan_spec *chan,
@@ -279,7 +292,20 @@ static const struct iio_chan_spec_ext_in
 	{ }
 };
 
-#define AD3530R_CHAN(_chan)					\
+static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad3530r_get_dac_powerdown,
+		.write = ad3530r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3531r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3531r_powerdown_mode_enum),
+	{ }
+};
+
+#define AD3530R_CHAN(_chan, _ext_info)				\
 {								\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -287,25 +313,25 @@ static const struct iio_chan_spec_ext_in
 	.output = 1,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			      BIT(IIO_CHAN_INFO_SCALE),		\
-	.ext_info = ad3530r_ext_info,				\
+	.ext_info = _ext_info,					\
 }
 
 static const struct iio_chan_spec ad3530r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
-	AD3530R_CHAN(4),
-	AD3530R_CHAN(5),
-	AD3530R_CHAN(6),
-	AD3530R_CHAN(7),
+	AD3530R_CHAN(0, ad3530r_ext_info),
+	AD3530R_CHAN(1, ad3530r_ext_info),
+	AD3530R_CHAN(2, ad3530r_ext_info),
+	AD3530R_CHAN(3, ad3530r_ext_info),
+	AD3530R_CHAN(4, ad3530r_ext_info),
+	AD3530R_CHAN(5, ad3530r_ext_info),
+	AD3530R_CHAN(6, ad3530r_ext_info),
+	AD3530R_CHAN(7, ad3530r_ext_info),
 };
 
 static const struct iio_chan_spec ad3531r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
+	AD3530R_CHAN(0, ad3531r_ext_info),
+	AD3530R_CHAN(1, ad3531r_ext_info),
+	AD3530R_CHAN(2, ad3531r_ext_info),
+	AD3530R_CHAN(3, ad3531r_ext_info),
 };
 
 static const struct ad3530r_chip_info ad3530_chip = {



