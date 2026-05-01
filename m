Return-Path: <stable+bounces-242319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HbAKNmJ9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A44ABE81
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FA2301176C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613238F250;
	Fri,  1 May 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1aojGP7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8F36E476
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633751; cv=none; b=dVNHGGutIuDJzaRcT/soYwbcOlWkdUekgEUQ7NYzIQvPfLoMwnEHcDenGT8cexXzLjGEW9JRuNZ0MHfoXtaStqM+UY9v0yVR8U9igoK5xUcSjTRPE82Q02JDPVT+sp21DhSUPDJXm60qDkBRdp/zWhfWc08cw2E9ts0Nusbgdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633751; c=relaxed/simple;
	bh=a4dvIQaOvP0nOBeItAlVVNFjT7YPKNl5hhbSKOZVJrg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ew87Fl/KGlfcdvP79tzmkq+emWp/lPFzQolJtHSVITXmZTaUlpSyqcgCAul52TE23+QKSPrUTZ2tXpHDArWC+LekniVIAm8HWgbPMD7PNYSS23Nw7vqozfTl1PCefBu51NWcWFfg21781WTxAGbA+h7c6mSdrKULk57hq0Z0xLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1aojGP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A273FC2BCB4;
	Fri,  1 May 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777633751;
	bh=a4dvIQaOvP0nOBeItAlVVNFjT7YPKNl5hhbSKOZVJrg=;
	h=Subject:To:Cc:From:Date:From;
	b=K1aojGP71SUg45F47npcHbjRLRiuQ6hp7qc0VAfwOVmL/4OuPAJ1A+DtiSgasKiXI
	 zh++o3ido9W4roye6/qo+nN//hEoGY3L9sKoFvJXbtYMeJ5XJMoZyADBuUFjyWfAN+
	 gWjNmqczLYW0xwDEJ5YAgwC+iOhHFomSGm9Zch5I=
Subject: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is propagated for" failed to apply to 5.10-stable tree
To: axboe@kernel.dk,azizcan.d@mileniumsec.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:09:00 +0200
Message-ID: <2026050100-hamlet-outshoot-27c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 413A44ABE81
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242319-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,mileniumsec.com:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-hamlet-outshoot-27c4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 21 Apr 2026 13:24:33 -0600
Subject: [PATCH] io_uring/poll: ensure EPOLL_ONESHOT is propagated for
 EPOLL_URING_WAKE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit:

aacf2f9f382c ("io_uring: fix req->apoll_events")

fixed an issue where poll->events and req->apoll_events weren't
synchronized, but then when the commit referenced in Fixes got added,
it didn't ensure the same thing.

If we mask in EPOLLONESHOT in the regular EPOLL_URING_WAKE path, then
ensure it's done for both. Including a link to the original report
below, even though it's mostly nonsense. But it includes a reproducer
that does show that IORING_CQE_F_MORE is set in the previous CQE,
while no more CQEs will be generated for this request. Just ignore
anything that pretends this is security related in any way, it's just
the typical AI nonsense.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/io-uring/CAM0zi7yQzF3eKncgHo4iVM5yFLAjsiob_ucqyWKs=hyd_GqiMg@mail.gmail.com/
Reported-by: Azizcan Daştan <azizcan.d@mileniumsec.com>
Fixes: 4464853277d0 ("io_uring: pass in EPOLL_URING_WAKE for eventfd signaling and wakeups")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/poll.c b/io_uring/poll.c
index 6834e2db937e..0204affdc308 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -417,8 +417,10 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		 * disable multishot as there is a circular dependency between
 		 * CQ posting and triggering the event.
 		 */
-		if (mask & EPOLL_URING_WAKE)
+		if (mask & EPOLL_URING_WAKE) {
 			poll->events |= EPOLLONESHOT;
+			req->apoll_events |= EPOLLONESHOT;
+		}
 
 		/* optional, saves extra locking for removal in tw handler */
 		if (mask && poll->events & EPOLLONESHOT) {


