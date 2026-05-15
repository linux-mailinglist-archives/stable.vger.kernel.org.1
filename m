Return-Path: <stable+bounces-248493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDrxKd5WB2pVzQIAu9opvQ
	(envelope-from <stable+bounces-248493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902F554F91
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80628322ED48
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D43EFFD8;
	Fri, 15 May 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t8BA57q/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C857355049;
	Fri, 15 May 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861871; cv=none; b=JtGYbyOjK1HvgfGGZu7LfsUzNR7S4Ap5SAQ+bBOpMqwvQlSQXKrguuydrwEP7dRZw1kA7U5h/s8HKoXsHEKMxM4oevifFWC40uFk6wRHjWLmltokx3/qVQJ+ywqm36xoJ8LDTKJeLnNJKfLMNyzAI4KpkqYZMKyPdx9aiWOcIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861871; c=relaxed/simple;
	bh=3isiY8IXmzc1jzHU80f9aXVLWrFq1Map4NVQqzRmd4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnMj5AzlkI1BSLAlb/PhYViCa41VFCdKFQ5e33e5qG3tnOzxU0P2iwyoAT+0p9w9XEOK6D4+0bMDLzjk5ox5kN5w4k8V6Fhpwb8DPAHfnVmVpgFLZw/B62E2gwTTnBPaJQnBVVoA77RRZpGI7lxvrldfQz2djdNYuIstro5HBHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t8BA57q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29ABC2BCB0;
	Fri, 15 May 2026 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861871;
	bh=3isiY8IXmzc1jzHU80f9aXVLWrFq1Map4NVQqzRmd4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8BA57q/cGYW0xFlbbSmJPLkfmERxzcmIJgWXVZ+p8irFxkANozkc7MY3REQVg/7K
	 R88iUOAXHyYlhpEjrgYCj1lowDOKj3pVXfU6X9THziqysCCQJigSF+JnDMa2m/MO2s
	 q9Jv3i66Xz3iUQmHUEnwkj3ry8sn2eKDsNwlDoNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.18 006/188] HID: pidff: Fix integer overflow in pidff_rescale
Date: Fri, 15 May 2026 17:47:03 +0200
Message-ID: <20260515154657.448924056@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5902F554F91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

commit 48d1677779ad6816978ad4a4f7588aec5ec960fe upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/usbhid/hid-pidff.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -11,6 +11,7 @@
 #include "hid-pidff.h"
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -325,8 +326,10 @@ static s32 pidff_clamp(s32 i, struct hid
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



