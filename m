Return-Path: <stable+bounces-210886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC/4ILg6cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:44:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABE5D836
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8255084130B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0DC33D4EC;
	Wed, 21 Jan 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBnC3edH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8479255248;
	Wed, 21 Jan 2026 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019717; cv=none; b=VMTfKo6xfx05ybkKZdhvsBwA085DKuTrZnAr3jhYF7Hdko1OYD9drXEhyJB/rDJDniGFLfOgMH4IfOaxZBZaUdP2P+N485GOT3yVG2aTCnbqrVLcE+w2fdZA73w171jfuZFLKLwQd9RSLc6z6Tf+Ye6V6YRVME9NpMjTy7cJHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019717; c=relaxed/simple;
	bh=+eUyhK5csae7gmybA4ghPhptsTxrB9MH772UDiToYbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro/Nn6a/F8/k3uOYTRPauK+bH6upGMemUUBF1xm0USyKZ1fUoio9SBUDqZrIrQkYchNfhJQfwBOt+JHLejN6GDFdopeIjuXR4N+SYq1nBbfQmWx1n9ExfBk/bg1S64j4lamlhBc4+jIVnXVvCI0yU8otKAi/r483nTaWi+X7CgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CBnC3edH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AA7C16AAE;
	Wed, 21 Jan 2026 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019717;
	bh=+eUyhK5csae7gmybA4ghPhptsTxrB9MH772UDiToYbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBnC3edHmlR7JLn1az7OpRJBYsqkjd7GEFXjE0c2vLrYYtFPEHpx2iMDa/8cEB9Gi
	 d5HzmcwvbSgBTR9lBCeySUSc5pN9tGnelXuewuVTYgGNeTxWopHe+Fs1MD/T70qKun
	 x68Ud4ylBKPms7LVxLvZNOG9y3vK0onoK2hSpTBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 6.12 086/139] hrtimer: Fix softirq base check in update_needs_ipi()
Date: Wed, 21 Jan 2026 19:15:34 +0100
Message-ID: <20260121181414.553480990@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-210886-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,linutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 41ABE5D836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit 05dc4a9fc8b36d4c99d76bbc02aa9ec0132de4c2 upstream.

The 'clockid' field is not the correct way to check for a softirq base.

Fix the check to correctly compare the base type instead of the clockid.

Fixes: 1e7f7fbcd40c ("hrtimer: Avoid more SMP function calls in clock_was_set()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260107-hrtimer-clock-base-check-v1-1-afb5dbce94a1@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/hrtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -931,7 +931,7 @@ static bool update_needs_ipi(struct hrti
 			return true;
 
 		/* Extra check for softirq clock bases */
-		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+		if (base->index < HRTIMER_BASE_MONOTONIC_SOFT)
 			continue;
 		if (cpu_base->softirq_activated)
 			continue;



