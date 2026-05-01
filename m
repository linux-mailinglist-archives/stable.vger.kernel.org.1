Return-Path: <stable+bounces-242346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBGSHYKU9Gk7CgIAu9opvQ
	(envelope-from <stable+bounces-242346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:54:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 800EC4AC25E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B74EF3008695
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD138CFF1;
	Fri,  1 May 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecOgmafA"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12E64A8D
	for <Stable@vger.kernel.org>; Fri,  1 May 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636475; cv=none; b=oNiP3LnnkLIdrxVX/v/+amP8qXlM7RM89o/VOsGv3UmRSKBtGLgunJXj4CYFol9yvHB8rP86KuMr8eZDK7Iko4xRIWNR72Nhdek5m6s2UmQnDCTl2pC5ga6q4lLqeWsbiEcFLF/m3nA9AkNY+ruMQ+U3XF60VWH21Rh1ocC6e0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636475; c=relaxed/simple;
	bh=CPPYSEVcRxvwrqe+u8OAjnP6NKEjZtakPswvwpm8/9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EDZsuN1UHExdnxQd/I1Xq+Wmso/YtDeV7EJtAb8WcDO/fniNbFdR8qcenW0ziHrvPo9hNNfrkmO0zjIhkCwjuPb8iTykMYlZRtL52mVUXHnrcrPsp1B8XqkQy2hmWGNjXPf4ssoyc030U7bZSrmP9fpCh9gUUcbyZ3YmRdWMiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecOgmafA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5ADC2BCB4;
	Fri,  1 May 2026 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777636475;
	bh=CPPYSEVcRxvwrqe+u8OAjnP6NKEjZtakPswvwpm8/9Y=;
	h=Subject:To:Cc:From:Date:From;
	b=ecOgmafACxlDYmPetg9PSGFEQpc9ZeKh12e5ikjoh5oWzfTttsLN2BbyW3/II+Bvt
	 hRIZJtyxz0PFP6owiei08vbxw7f8uN2I7Ox1lkmU5O90rHstWStQqpUgTkREdo4+iG
	 CKSOHf0/9F6CbqoFgDbP96Krucaj0oCLYBws/QSA=
Subject: FAILED: patch "[PATCH] iio: frequency: admv1013: fix NULL pointer dereference on str" failed to apply to 6.12-stable tree
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:54:24 +0200
Message-ID: <2026050124-kiwi-tapeless-d419@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 800EC4AC25E
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242346-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,analog.com:email,intel.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aac0a51b16700b403a55b67ba495de021db78763
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050124-kiwi-tapeless-d419@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aac0a51b16700b403a55b67ba495de021db78763 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Thu, 5 Mar 2026 11:14:48 +0200
Subject: [PATCH] iio: frequency: admv1013: fix NULL pointer dereference on str
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


