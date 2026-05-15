Return-Path: <stable+bounces-248047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBsMLBZHB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:17:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41641552F37
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B2532CA78A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53006305683;
	Fri, 15 May 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZuXHwoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAE305674;
	Fri, 15 May 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860733; cv=none; b=S22p/7/KAUMuGo+A8NrPwYtca0kP+jqPJZ4rxGpUHPTncvtk4WREtOe5YzHvBE6GM5hovFTywZRGQKruNgDudcU9monFgdw7RQ0ndlFGiOqRSiLx/o53P6AwwAYPw1nEko9OFD7v0pAwWypCA+vSaTuMopUXuu6N2v8v8JCocm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860733; c=relaxed/simple;
	bh=k8Q+HDYhy4qqrey62m13/6qM9ZjNtt3anRNYv+vxjcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/QlbwoVcnKTBConEsB5oZxuOGbKhOLvtD1SuRuG2eaR1grjtap0f5La91hjp64QePH/sqW4sBBcnL1E36eJZLTk+hIK+DBlkM27jCYljzcrFBuh98gksRWskfCOADoiAqFbStlJ5XdfjwCS5zHsXXOUjSTr5glB8PZZ7yaecxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZuXHwoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD4AC2BCB0;
	Fri, 15 May 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860733;
	bh=k8Q+HDYhy4qqrey62m13/6qM9ZjNtt3anRNYv+vxjcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZuXHwoYipwujHsUl+5CUuEviD1nl29u4+qcc5UeXJcHGFTUKYI0gipbBW1RMF7mJ
	 GlaemjSRDpd79yhiLQi68Un8Dvfd6E/YeGRt7G3XJ3ma8s3awvUX20Ckk7E9EU5Ky9
	 NFO41HromPZ7jxL0aee6nANw8cvKGlP2r8Cw9KjM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Azizcan=20Da=C5=9Ftan?= <azizcan.d@mileniumsec.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 057/474] io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
Date: Fri, 15 May 2026 17:42:46 +0200
Message-ID: <20260515154716.278601437@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 41641552F37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248047-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,mileniumsec.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/poll.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -441,8 +441,10 @@ static int io_poll_wake(struct wait_queu
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



