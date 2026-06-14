Return-Path: <stable+bounces-263041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRJ9KUJDLmocrgQAu9opvQ
	(envelope-from <stable+bounces-263041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:59:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D4680701
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BeR91IQx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263041-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263041-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D37DC3001F99
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D22F12AB;
	Sun, 14 Jun 2026 05:59:23 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5F247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:59:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416763; cv=none; b=jEqC8KkdZTFh7b4xGyC59t4+Zd2xWbBRIgN+c5Ya752eJdE0ZS/1UmlxmhvsOu6Obz1a3lP0GipgMTxPzU+6zaTqBHW3GD/JnbhFcdZY/ReolpMSit5HOuFInl4Nj8jsMwMNEw5U3fuQRRWVWQfnxdSnCFVI9z+kjo4cuEcacEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416763; c=relaxed/simple;
	bh=bzoGLHGT8BC6somPNqv/QPG+p4u8sNTUBYUy8+eZxQ4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Y9xK5wV57iyUBJaKim//N7WAi2EHQWlXMo+iIbGtInB0gJvTLVXq/5OLByzwxf0tHAR8Qd7eZuJpveMFDH/f8tsROIosJU4EfCbAhVfcVulQvWHCboVU4CeosAtzwvhhjrZfwgu5v4hKDyl8/PTGDUqS4aOAiRRMLN3I+7KpldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BeR91IQx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94DB1F000E9;
	Sun, 14 Jun 2026 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416762;
	bh=TP29BrXLz1EgApjyrErb4DQwDMQ597w2KSS11AzuIyk=;
	h=Subject:To:From:Date;
	b=BeR91IQx2RyXsfMrYD10SCDvjRvRkfsnstRglmIGOtj2+G3a41EjCJ5NGuMNkyCzp
	 pelh3oqV6cXvUEhPzT7rlNj2AsSjh7SvebMvS1xUQTvlIBUJW9h898M5qbLXdMGKYM
	 KtOQyVa2zq1kk/uzeYbR7gfZvsrGlTEQ0RJqiTDY=
Subject: patch "iio: chemical: scd30: Cleanup initializations and fix sign-extension" added to char-misc-testing
To: m32285159@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:24 +0200
Message-ID: <2026061424-mumbling-bonding-07c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:m32285159@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A75D4680701


This is a note to let you know that I've just added the patch titled

    iio: chemical: scd30: Cleanup initializations and fix sign-extension

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 60d877910a43c305b5165131b258a17b1d772d57 Mon Sep 17 00:00:00 2001
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 26 May 2026 17:55:24 -0500
Subject: iio: chemical: scd30: Cleanup initializations and fix sign-extension
 bug

Include linux/bitfield.h for FIELD_GET().

Create new macros for bit manipulation in combination with manual bit
manipulation being replaced with FIELD_GET().

The current variable declaration and initializations are barely readable
and use comma separations across multiple lines. Refactor the
initializations so that mantissa and exp have separate declarations and
sign gets initialized later.

In addition (and due to the nature of the cleanup), fix a sign-extension
bug where, float32 would get bitwise anded with ~BIT(31)
(which is 0xFFFFFFFF7FFFFFFF) which corrupted the exponent.

Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.com
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 11d6bc1b63e6..d02f2de42327 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
+
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -43,6 +45,11 @@
 #define SCD30_TEMP_OFFSET_MAX 655360
 #define SCD30_EXTRA_TIMEOUT_PER_S 250
 
+/* Floating point arithmetic macros */
+#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
+#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
+#define SCD30_FLOAT_SIGN_MSK BIT(31)
+
 enum {
 	SCD30_CONC,
 	SCD30_TEMP,
@@ -89,10 +96,14 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
+	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
+
+	if (float32 & SCD30_FLOAT_SIGN_MSK)
+		sign = -1;
+	else
+		sign = 1;
 
 	/* special case 0 */
 	if (!exp && !mantissa)
-- 
2.54.0



