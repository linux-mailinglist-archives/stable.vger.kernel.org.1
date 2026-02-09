Return-Path: <stable+bounces-215487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDqUMrn5iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:14:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA7111C11
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09DE2306B08E
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE9537C0FD;
	Mon,  9 Feb 2026 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2QgvcZaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219822750E6;
	Mon,  9 Feb 2026 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648957; cv=none; b=oCMuADVuq2EBVk/sfb+CseNmDU5cj8qpInxJBDRAOVbMeHaRbzQG1udFTUJIAdnllbJ2npaZoONYyZorc6EwDRbwr+6oa+16yl+ETNXsXTWdlcv3saGAcICZp5uM5kuEToETs+4R9zY1Y0RXMru9TQI4R7XyzV4BvOvCiGFOxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648957; c=relaxed/simple;
	bh=wuBAl2f9TKQqvrogeJTNyTTDXFS0hrVPxjJ4qhUJjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJsdp55dmZAsEi5jULDorq8x/4sNO8DYktugr4MjgadoZ0KS+LngXh7MSzt8ONXwSeNFjuaksfmsaHBHD1xlqj3MqfGp9LGomIZmudOMZDJ4uccKxf8c2X+46XTrIGx/OZ968a6gZMZZ/Wqk613QgybGJ6/0QyOXsSwmADbhY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2QgvcZaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F47C19422;
	Mon,  9 Feb 2026 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648957;
	bh=wuBAl2f9TKQqvrogeJTNyTTDXFS0hrVPxjJ4qhUJjUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2QgvcZaqNM2EJcdKZpTO6BmxjMM5nlBCWbreMgNAKskeTjq+BQ5V0TIMY40uC3u9Q
	 4WavficKpdwAAf2YRSBgqhf+axkMQcEHGnwiKMStxsHXMvFnjMzZfIt3mA9o9QK+bP
	 47OGxmpV3FkK2Ibw9/hX1MqPuevHjnqS0lOWljpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yipeng Zou <zouyipeng@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.15 22/75] timers: Fix NULL function pointer race in timer_shutdown_sync()
Date: Mon,  9 Feb 2026 15:24:19 +0100
Message-ID: <20260209142302.644935298@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215487-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,huawei.com:email,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2BEA7111C11
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yipeng Zou <zouyipeng@huawei.com>

commit 20739af07383e6eb1ec59dcd70b72ebfa9ac362c upstream.

There is a race condition between timer_shutdown_sync() and timer
expiration that can lead to hitting a WARN_ON in expire_timers().

The issue occurs when timer_shutdown_sync() clears the timer function
to NULL while the timer is still running on another CPU. The race
scenario looks like this:

CPU0					CPU1
					<SOFTIRQ>
					lock_timer_base()
					expire_timers()
					base->running_timer = timer;
					unlock_timer_base()
					[call_timer_fn enter]
					mod_timer()
					...
timer_shutdown_sync()
lock_timer_base()
// For now, will not detach the timer but only clear its function to NULL
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()
					[call_timer_fn exit]
					lock_timer_base()
					base->running_timer = NULL;
					unlock_timer_base()
					...
					// Now timer is pending while its function set to NULL.
					// next timer trigger
					<SOFTIRQ>
					expire_timers()
					WARN_ON_ONCE(!fn) // hit
					...
lock_timer_base()
// Now timer will detach
if (base->running_timer != timer)
	ret = detach_if_pending(timer, base, true);
if (shutdown)
	timer->function = NULL;
unlock_timer_base()

The problem is that timer_shutdown_sync() clears the timer function
regardless of whether the timer is currently running. This can leave a
pending timer with a NULL function pointer, which triggers the
WARN_ON_ONCE(!fn) check in expire_timers().

Fix this by only clearing the timer function when actually detaching the
timer. If the timer is running, leave the function pointer intact, which is
safe because the timer will be properly detached when it finishes running.

Fixes: 0cc04e80458a ("timers: Add shutdown mechanism to the internal functions")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251122093942.301559-1-zouyipeng@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1360,10 +1360,11 @@ static int __try_to_del_timer_sync(struc
 
 	base = lock_timer_base(timer, &flags);
 
-	if (base->running_timer != timer)
+	if (base->running_timer != timer) {
 		ret = detach_if_pending(timer, base, true);
-	if (shutdown)
-		timer->function = NULL;
+		if (shutdown)
+			timer->function = NULL;
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 



