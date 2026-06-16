Return-Path: <stable+bounces-264246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FbLdLU1yMWowjgUAu9opvQ
	(envelope-from <stable+bounces-264246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D496918BC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NgI6yFLZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264246-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264246-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 623DE308E749
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30410364024;
	Tue, 16 Jun 2026 15:48:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D612EEE68;
	Tue, 16 Jun 2026 15:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624912; cv=none; b=mC68JN+zL8MNrQDSEsts5+01zrMYLGTISDJ3zQ5A66kKkrds7bjLiAD8SXATzMVmR2FuVSWrRFxy5CbpfRnkPvQLHH3/I5Hw6bM8g4nHurKe0enBHqrLBt7OW9WI7JL6FVRLKPQA62yaOZ+WcYUzgyM74Z97c6X8WXQweWRZzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624912; c=relaxed/simple;
	bh=gLgXgLq6UtVLLEWFBcXym6NRDplnCAMhxNmLmvOupyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgS6xLdCXAKZ+mShxa7q6donLeo1e7BonKP8+SHap+1p8kDpUprCoVQzHJnvvmbT+2oHgzDQfxnFDWPkY0gFQv6tTQrZr47iMfxDWmidnFMeJn7w/av3eft4Njp9TQD8YjCqUgNDjLTOe9NeKZolsBO+/DIoPAPRFRti8tkXWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NgI6yFLZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7B81F00A3A;
	Tue, 16 Jun 2026 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624910;
	bh=Gt0jkjuIUrkVE8f+Fcl+CI2FdmCUnwh5lobH9LKIy8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgI6yFLZjdivknFmGsGNz8bSCK0ovoCq5gyAm7akM40Uhvo7ayFnGvbQBwMRx0DV/
	 6ak+9O73wWl9Dyq5TheyalkX23TvFQ0xMM6PO5TZbgoMzuV4+0Rd0o59rcCLdDqzxn
	 PxJgU2JON6l0Y5lUkWUr5CUbaCQP/aL6gViY+PXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6.18 007/325] i2c: dev: prevent integer overflow in I2C_TIMEOUT ioctl
Date: Tue, 16 Jun 2026 20:26:43 +0530
Message-ID: <20260616145058.182148696@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264246-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:25181214217@stu.xidian.edu.cn,m:wsa+renesas@sang-engineering.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sang-engineering.com:email,xidian.edu.cn:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50D496918BC

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

commit 617eb7c0961a8dfcfc811844a6396e406b2923ea upstream.

While fuzzing with Syzkaller, a persistent `schedule_timeout: wrong
timeout value` warning was observed, accompanied by SMBus controller
state machine corruption.

The I2C_TIMEOUT ioctl accepts a user-provided timeout in multiples of
10 ms. The user argument is checked against INT_MAX, but it is
subsequently multiplied by 10 before being passed to msecs_to_jiffies().

A malicious user can pass a large value (e.g., 429496729) that passes
the `arg > INT_MAX` check but overflows when multiplied by 10. This
results in a truncated 32-bit unsigned value that bypasses the
internal `(int)m < 0` check in `msecs_to_jiffies()`.

The truncated value is then assigned to `client->adapter->timeout`
(a signed 32-bit int), which is reinterpreted as a negative number.
When passed to wait_for_completion_timeout(), this negative value
undergoes sign extension to a 64-bit unsigned long, triggering the
`schedule_timeout` warning and causing premature returns. This leaves
the SMBus state machine in an unrecoverable state, constituting a
local Denial of Service (DoS).

Fix this by bounding the user argument to `INT_MAX / 10`.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
[wsa: move the comment as well]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-dev.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -487,12 +487,13 @@ static long i2cdev_ioctl(struct file *fi
 		client->adapter->retries = arg;
 		break;
 	case I2C_TIMEOUT:
-		if (arg > INT_MAX)
+		/*
+		 * For historical reasons, user-space sets the timeout value in
+		 * units of 10 ms.
+		 */
+		if (arg > INT_MAX / 10)
 			return -EINVAL;
 
-		/* For historical reasons, user-space sets the timeout
-		 * value in units of 10 ms.
-		 */
 		client->adapter->timeout = msecs_to_jiffies(arg * 10);
 		break;
 	default:



