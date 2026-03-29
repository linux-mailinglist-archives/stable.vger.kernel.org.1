Return-Path: <stable+bounces-230889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IaSJtwhyWkuvAUAu9opvQ
	(envelope-from <stable+bounces-230889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:58:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCAD352095
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B129A300FB7C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F083603EC;
	Sun, 29 Mar 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g24geXau"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE336CDE9
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789079; cv=none; b=VCT/Mr87M+eVm2FHJu+oGPhfWyFAqliS+rECQUTf6yjwBZlcankzHBa5jmJ/DG332YBCPKUpI2iKJj75bt85NKblXmkumdr+FrkRxeIuP/QtxBAAfsjuqUgYXyfJWgfibzDkFwLL0Gj+0rSDwp35OlMh6fbW20uvj8XVN0xlkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789079; c=relaxed/simple;
	bh=ogiKZpvukDqcXZ878rFGqXwGPOxZuw927vVH9HfwF0k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LC4IlcS2FJk3f8+ONz05vu4zfxuEB6oIL+rA/LmazM3Y85gT37/BPEubp9tHKus8Yp6Q+0TrlVBdgZcz9rRHdQLktH5kjVkQHvgkEMTsmWWHAkeFQ7y6jMXcIa70jDFvfLzO0u821TQXP/h6QxQ+7HMJstwUXFOFtXt0RDiYkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g24geXau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36862C2BC9E;
	Sun, 29 Mar 2026 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774789079;
	bh=ogiKZpvukDqcXZ878rFGqXwGPOxZuw927vVH9HfwF0k=;
	h=Subject:To:From:Date:From;
	b=g24geXaubbbfZilcbEDOfKBtQ15fvDyrQik6YJ40OzES1qqBgPu6geeS9DuwnTvEj
	 g1ilGovpolc63MHDRQor/r7Foew8sKdGV4dErVqb67n3hNYrbgYqGLPoYyxgsXedB5
	 nUq4d97ivwR5SGF1brSyDJOUmNw+szKaZLqxVgOA=
Subject: patch "iio: frequency: admv1013: fix NULL pointer dereference on str" added to char-misc-testing
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:42:04 +0200
Message-ID: <2026032904-canteen-amazingly-c40b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230889-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,huawei.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DCAD352095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: frequency: admv1013: fix NULL pointer dereference on str

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From aac0a51b16700b403a55b67ba495de021db78763 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 5 Mar 2026 11:14:48 +0200
Subject: iio: frequency: admv1013: fix NULL pointer dereference on str
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When device_property_read_string() fails, str is left uninitialized
but the code falls through to strcmp(str, ...), dereferencing a garbage
pointer. Replace manual read/strcmp with
device_property_match_property_string() and consolidate the SE mode
enums into a single sequential enum, mapping to hardware register
values via a switch consistent with other bitfields in the driver.

Several cleanup patches have been applied to this driver recently so
this will need a manual backport.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/frequency/admv1013.c | 65 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9202443ef445..b852378b3f68 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -85,9 +85,9 @@ enum {
 };
 
 enum {
-	ADMV1013_SE_MODE_POS = 6,
-	ADMV1013_SE_MODE_NEG = 9,
-	ADMV1013_SE_MODE_DIFF = 12
+	ADMV1013_SE_MODE_POS,
+	ADMV1013_SE_MODE_NEG,
+	ADMV1013_SE_MODE_DIFF,
 };
 
 struct admv1013_state {
@@ -468,10 +468,23 @@ static int admv1013_init(struct admv1013_state *st, int vcm_uv)
 	if (ret)
 		return ret;
 
-	data = FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode);
+	switch (st->quad_se_mode) {
+	case ADMV1013_SE_MODE_POS:
+		data = 6;
+		break;
+	case ADMV1013_SE_MODE_NEG:
+		data = 9;
+		break;
+	case ADMV1013_SE_MODE_DIFF:
+		data = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
-					 ADMV1013_QUAD_SE_MODE_MSK, data);
+					 ADMV1013_QUAD_SE_MODE_MSK,
+					 FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, data));
 	if (ret)
 		return ret;
 
@@ -512,37 +525,33 @@ static void admv1013_powerdown(void *data)
 	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk, enable_reg);
 }
 
+static const char * const admv1013_input_modes[] = {
+	[ADMV1013_IQ_MODE] = "iq",
+	[ADMV1013_IF_MODE] = "if",
+};
+
+static const char * const admv1013_quad_se_modes[] = {
+	[ADMV1013_SE_MODE_POS] = "se-pos",
+	[ADMV1013_SE_MODE_NEG] = "se-neg",
+	[ADMV1013_SE_MODE_DIFF] = "diff",
+};
+
 static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
-	const char *str;
 	struct device *dev = &st->spi->dev;
 
 	st->det_en = device_property_read_bool(dev, "adi,detector-enable");
 
-	ret = device_property_read_string(dev, "adi,input-mode", &str);
-	if (ret)
-		st->input_mode = ADMV1013_IQ_MODE;
+	ret = device_property_match_property_string(dev, "adi,input-mode",
+						    admv1013_input_modes,
+						    ARRAY_SIZE(admv1013_input_modes));
+	st->input_mode = ret >= 0 ? ret : ADMV1013_IQ_MODE;
 
-	if (!strcmp(str, "iq"))
-		st->input_mode = ADMV1013_IQ_MODE;
-	else if (!strcmp(str, "if"))
-		st->input_mode = ADMV1013_IF_MODE;
-	else
-		return -EINVAL;
-
-	ret = device_property_read_string(dev, "adi,quad-se-mode", &str);
-	if (ret)
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-
-	if (!strcmp(str, "diff"))
-		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
-	else if (!strcmp(str, "se-pos"))
-		st->quad_se_mode = ADMV1013_SE_MODE_POS;
-	else if (!strcmp(str, "se-neg"))
-		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
-	else
-		return -EINVAL;
+	ret = device_property_match_property_string(dev, "adi,quad-se-mode",
+						    admv1013_quad_se_modes,
+						    ARRAY_SIZE(admv1013_quad_se_modes));
+	st->quad_se_mode = ret >= 0 ? ret : ADMV1013_SE_MODE_DIFF;
 
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(admv1013_vcc_regs),
-- 
2.53.0



