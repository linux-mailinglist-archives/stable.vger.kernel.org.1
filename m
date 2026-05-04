Return-Path: <stable+bounces-243436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHGZDjOp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23D24BEC45
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 491AD30193B9
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5883D5645;
	Mon,  4 May 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvigqtRp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E03A7F4C;
	Mon,  4 May 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903879; cv=none; b=avwcxfzYQiUev2QCOuinHy1SK9Fxb2wPxUOSh8ak5F8AtxA35uq5xhsBl5cnVQu+Xhb302bc+Wu5T3TH75C7nWFdhVFRC0WyJkvjFdqgCMspJWTL23Vv4NcWfvS94ZUY6jg+KrXrnDwtSopN9wVKL6H3G0JIJWoXnUu5HuUpDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903879; c=relaxed/simple;
	bh=Yc2l4jFcW2a8oueqCEQM4jmkrnzVnr/OGdPahHHCEyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emdDgYlsGhDKhRMa/4Gl2W2unILW9wwzlzSEdyFaKW6HADqXkl7bUfX1BiguXxwBlN0497q8qmY3y9SS+gOMR5I8b1WscjS4NppeRt/JcpmvM8QiVM8pWwv4HWClVJidrgYhY8yTnolHtZBWoKwcRqf2Kp3o/vwL59sWAFC+7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvigqtRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B80C2BCB8;
	Mon,  4 May 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903879;
	bh=Yc2l4jFcW2a8oueqCEQM4jmkrnzVnr/OGdPahHHCEyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvigqtRpb18nFdlXykCfxpFv+2NHcQj8mxjvFimF8SjBSlIb2ZtKBAi+zfrBMCAsJ
	 5ni3tAzcaBVHlA1N0ixAgWUF3GuJ6bZmwlBP/iTsUXpqfdCCEY3UoCruCMEUSRSlUm
	 w24SeRrdL7vvElc7fK6xYld2NZ4rvLkRBQiSEmP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Azizcan=20Da=C5=9Ftan?= <azizcan.d@mileniumsec.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 098/275] io_uring/poll: ensure EPOLL_ONESHOT is propagated for EPOLL_URING_WAKE
Date: Mon,  4 May 2026 15:50:38 +0200
Message-ID: <20260504135146.559050091@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A23D24BEC45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243436-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mileniumsec.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -412,8 +412,10 @@ static int io_poll_wake(struct wait_queu
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



