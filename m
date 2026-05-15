Return-Path: <stable+bounces-247332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMeRBsqtBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055E549804
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1112E3018D44
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD631716D;
	Fri, 15 May 2026 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkzVK9kz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568692868B4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822598; cv=none; b=gp6inq37+Dtf2Imhm2wV4xv1EjGjMtxwmySWF5uKjn6gGvtTxRgW+BcxDgTUaJ3qtVG+K5/NUk+NTxsZtNjvUQPHCfludcNO8NnIoZ7AqgzwDW3UN5tz5gSZJaWeHfF219woitZ6mh/FjlxNTCUFg8U6Rwday6hG6b6DFWIY/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822598; c=relaxed/simple;
	bh=MUIRh2NGQPwmb91a3XH4yT7nW/U0OlRcuyyByS8i8ik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jf9AQkO9xt82i0lKKQIfEbgXRJKeDt/SSXirHLp+vOCRYvCmUtDP3tIPeLbcNhqFHOyJYUGRH9x/w6jy3rUeclVxcI1YCfi4BqX3fUmEOdOWA+t6vuXk7w+7k+EAmbrIM38Y0Jme/jifYsDFF7bDn4dNdMvHYcLNMunlIMcZYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkzVK9kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB5BC2BCB0;
	Fri, 15 May 2026 05:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778822598;
	bh=MUIRh2NGQPwmb91a3XH4yT7nW/U0OlRcuyyByS8i8ik=;
	h=Subject:To:Cc:From:Date:From;
	b=VkzVK9kzLtldgYslLw6325rANkaWdBSXyIUlIMIezEUxIn6Vwf7dJj8TDTl6+EqDu
	 DmrrLAhCdN5qtwm+gVMsnz56gllDe5uCExinjyHk+pvmz0C71+aNbRX5iNE1glP0TU
	 aIiQcwnQ5uXR4zY3DmpyR0994DCN9eCxXMZ5b144=
Subject: FAILED: patch "[PATCH] HID: pidff: Fix integer overflow in pidff_rescale" failed to apply to 6.12-stable tree
To: tomasz.pakula.oficjalny@gmail.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:23:22 +0200
Message-ID: <2026051522-deflate-sulfur-8341@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6055E549804
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247332-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 48d1677779ad6816978ad4a4f7588aec5ec960fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051522-deflate-sulfur-8341@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48d1677779ad6816978ad4a4f7588aec5ec960fe Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Sun, 10 May 2026 14:23:52 +0200
Subject: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rescaling values close to the max (U16_MAX) temporarily creates values
that exceed the s32 range. This caused value overflow in case when, for
example, a periodic effect phase was higer than 180 degrees. In turn,
rescale function could return values outised of the logical range of the
HID field.

Fix by using 64 bit signed integer to store the value during calculation
but still return only 32 bit integer.

Closes: https://github.com/JacKeTUs/universal-pidff/issues/116
Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: stable@vger.kernel.org
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index aee8a4443305..c45f182d0448 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -11,6 +11,7 @@
 #include "hid-pidff.h"
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/stringify.h>
@@ -326,8 +327,10 @@ static s32 pidff_clamp(s32 i, struct hid_field *field)
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
-	return i * (field->logical_maximum - field->logical_minimum) / max +
-	       field->logical_minimum;
+	/* 64 bits needed for big values during rescale */
+	s64 result = field->logical_maximum - field->logical_minimum;
+
+	return div_s64(result * i, max) + field->logical_minimum;
 }
 
 /*


