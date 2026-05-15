Return-Path: <stable+bounces-247703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNpEGpUQB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:24:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EF454F7B2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4403431629C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F2547DF9C;
	Fri, 15 May 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s+ju9aim"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4547DD63
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845624; cv=none; b=dWZrfxLQvg8CORfISt5b4nK+5EfPr34PTIUBiBjypPTogQ4YrNFZ/FCo1I8r6Uo495Swz1MVh4xUo0pys5OhLFWqJYx25ktFB7oZBylBPCNYnaqhuvDUZYhfTTi3sVZAePJmObcstcBRRLgeiW4nZ15AMr3pghBNWKzYjA6qIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845624; c=relaxed/simple;
	bh=5pvThc9d+Y9OzuBE6moktGDgG6lf4LjUVwo2LC20VKc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Y4Azn6usNm0nSLCKhJUHYu6y/fIUyYz+o1xiXDXUK5QEgBH2+XBSMRlL4LrKJxtj28W/JCIfYYwMakjjd3sPWG1klDKBs6qqLncYjYUDobKHftSxZ2JetqPx3RNZckDqQnSbcUlWFM6rg/3LHoRnbOD4LJehahCTDkqxQdyY1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s+ju9aim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FFFC2BCB0;
	Fri, 15 May 2026 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845623;
	bh=5pvThc9d+Y9OzuBE6moktGDgG6lf4LjUVwo2LC20VKc=;
	h=Subject:To:From:Date:From;
	b=s+ju9aimFvvAPosbpCnUwwpOtGXeOGfW43xuk33at7WWykUKY9Y8kKAWketVfLXAf
	 9tJpcKhBvUVhSdCWgFLktWT9kKQfL2H50OiB/OaC3a1T+hEk90V6jpjJEJJfaZIDZl
	 B9o/E+1wuvfMl9BzdawAa/N4L4ncqL+OAdMAbkR4=
Subject: patch "iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings" added to char-misc-linus
To: kimseer.paller@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:46:01 +0200
Message-ID: <2026051501-waged-broaden-1012@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12EF454F7B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247703-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From ebd250c2581ec46c64c73fdfa918c9a7f757505e Mon Sep 17 00:00:00 2001
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 5 May 2026 12:34:32 +0800
Subject: iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode strings

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
---
 drivers/iio/dac/ad3530r.c | 54 +++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index b97b46090d80..d9db3226ecd6 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -105,6 +105,12 @@ static const char * const ad3530r_powerdown_modes[] = {
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
@@ -133,6 +139,13 @@ static const struct iio_enum ad3530r_powerdown_mode_enum = {
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
@@ -276,7 +289,20 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
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
@@ -284,25 +310,25 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
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
-- 
2.54.0



