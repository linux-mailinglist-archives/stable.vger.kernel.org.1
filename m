Return-Path: <stable+bounces-247335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NIjHdqtBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E988C54981A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5BA2301F4A2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AB31716D;
	Fri, 15 May 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uc5W3Z3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E822868B4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822612; cv=none; b=Hb2J+Q+Hj4cAhnHGcjV63eKZ4QUjjgdf0+/j6WqPsB1W+sPLMty5SFd9FVFyKjhEe2/l9Rv+YMhgcv4dOrjUAZZJPyNVfb0APifTmRoVGWcBvtz3gj1ex4KIZJT1zr4AODYf81oNorK8Vay3SIcLQ54rm7IVdItUwr4wm4qJ6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822612; c=relaxed/simple;
	bh=PTDmn+VErWkeFbnmm/prNrLM8Af7yGsqDmYhZYlo2I4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DFYj6yyTEzsATvV9Zh3KB5xPnwUQm62tM7xTQ8gvRJzJFHM99LlYPWRrN/VxBQ5BvAUayzVeynQOIX9/WywdbRKgEQKx9mf07BuPDf7ddhyEPGxcyiwtFy0eF5vJwUCm4NIHvX8MDaQ8zBguJa7hTjd7aRD8ZKQdDvP6TuIlnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uc5W3Z3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344EC2BCB0;
	Fri, 15 May 2026 05:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778822611;
	bh=PTDmn+VErWkeFbnmm/prNrLM8Af7yGsqDmYhZYlo2I4=;
	h=Subject:To:Cc:From:Date:From;
	b=uc5W3Z3MiP2xgaaFk3la3/b/Vvhwiuyro/KEPKD5GXBtnn5gdKBQTi3ulqLMohUut
	 7d7fzpNbwYCXIQ9sa5mThITop6cV9H4Y3NDP799O8zbQxFBan33jnc6qj2ZdETjlYa
	 ZBXcrT8r2B5nG5i8pDfhhMeLaJ7fk47NRpMPxlnM=
Subject: FAILED: patch "[PATCH] HID: pidff: Fix integer overflow in pidff_rescale" failed to apply to 5.10-stable tree
To: tomasz.pakula.oficjalny@gmail.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:23:23 +0200
Message-ID: <2026051523-jolly-unwired-ab88@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E988C54981A
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247335-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 48d1677779ad6816978ad4a4f7588aec5ec960fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051523-jolly-unwired-ab88@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


