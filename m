Return-Path: <stable+bounces-258148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEGNCLokG2pm/ggAu9opvQ
	(envelope-from <stable+bounces-258148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:56:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E20F610AC3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDDDD305FB32
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648773BFE4D;
	Sat, 30 May 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trlAbQqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C434104B;
	Sat, 30 May 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163377; cv=none; b=SJm+guhDS+ZXrV7LDEHT6LhWQNacQ7n3CB8PgTf7PoH1Zu0dUyirbDYGExEPU9IIrk5/KFbkNG4MUzbFeo/kFyaVl4hBVJHbqJOtrTuVKO0vqEBpMl68iWDg2nVvxDzNOrevpGqxfSAhcyOg2P0SEWQR2s/9fcAu/U3mFRI4ApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163377; c=relaxed/simple;
	bh=eYsB0TP20xMEtN4QvOtR2j+iRIQ6R60YeTo0ZhpPHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6eCrtbdhXB9FRvyp0GLyfBh5n+cLwXVeZnt7bgmdusae5y2YpDzSFv/BY8QtT4NWdderX4tf6O9eWbHXNf3Wo3fP6J1N+cH9pKly+P4EYUK8Bsg6zMMN4sgPlc48xJtdXd2viAsgcQSu6nGIrN2C2YkPFOrHlazlo099BKGV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trlAbQqz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2631F00893;
	Sat, 30 May 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163376;
	bh=joNV/H4aVe019ONANTVsP3n9lG5q+uxYwhy6Nk6HsiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=trlAbQqz57BZVr4522Nx7ylT/UW7KAua0IBrX/EL9v/Jxi8XuFERDbEmTAMLAVCTP
	 tYaoM1xh90K3XCervQ4PDLzaEnSKi3VvDxCBOVaJLemXEihU3LB0Qsu7o80zYXgVzK
	 1KXtdKfLPI8rd7IW+qmKDY7q0n2GyKxZesm2BfEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 240/776] io_uring/poll: fix EPOLL_URING_WAKE sometimes not being honored
Date: Sat, 30 May 2026 17:59:14 +0200
Message-ID: <20260530160246.734881731@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258148-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,kernel.dk:email]
X-Rspamd-Queue-Id: 8E20F610AC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Rather than do the masking  only when we jump straight to execution,
mark it as EPOLLONESHOT regardless. This ensures it doesn't get lost.
And just kill the poll entry upfront, if marked. This is an optimization
in later kernels, but it's actually required on the older kernels to
note the EPOLL_URING_WAKE mask correctly.

Fixes: ccf06b5a981c ("io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 38decfc1a914a..4f1dda7d68c22 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5794,14 +5794,19 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & poll->events))
 		return 0;
 
+	/*
+	 * If we trigger a multishot poll off our own wakeup path,
+	 * disable multishot as there is a circular dependency between
+	 * CQ posting and triggering the event.
+	 */
+	if (mask & EPOLL_URING_WAKE)
+		poll->events |= EPOLLONESHOT;
+
 	if (io_poll_get_ownership(req)) {
-		/*
-		 * If we trigger a multishot poll off our own wakeup path,
-		 * disable multishot as there is a circular dependency between
-		 * CQ posting and triggering the event.
-		 */
-		if (mask & EPOLL_URING_WAKE)
-			poll->events |= EPOLLONESHOT;
+		if (mask && poll->events & EPOLLONESHOT) {
+			list_del_init(&poll->wait.entry);
+			smp_store_release(&poll->head, NULL);
+		}
 
 		__io_poll_execute(req, mask);
 	}
-- 
2.53.0




