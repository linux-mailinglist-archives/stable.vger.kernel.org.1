Return-Path: <stable+bounces-242535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD0VKh8g9WnWIgIAu9opvQ
	(envelope-from <stable+bounces-242535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:50:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9C4AFDCE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06876300E26D
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A25355F30;
	Fri,  1 May 2026 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pFNTJG5n"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA2EEC3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672219; cv=none; b=TqbWKeY/k0fiaR1Vjc87vjlGiTvBD3KuM7DCQOUQeqZjMjK8RQM0iVAhSAYcniufXuYmkP4wfso2SUcuMO6hsOkQfy9AbiY8hITB84T8FWNj06miYkLNOBvXGeHKd+a59yR+zwqAruXxf1/HopGMzb9v4CfgwUqs9sF5goY+z5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672219; c=relaxed/simple;
	bh=HH97UMfj5/LOVdmhyYY9G6Cq7AEVij3y+h4CtjA1AXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orZ0+ZZqmr2BvevL6TPRpMv1MxYeyUpjTr64HEq1yOJo5Z0LL81bs7bppgf2E9KqKjzJcN77yfVc1ao4R/rsanlTjNwjzcKt5DPLPMlZCYLB6hCWd6QQZYxXN67eKU2XSDWja657yc2NeVewUfe6yTjvVXeh1B4DlsZ/p5iMWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pFNTJG5n; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 694A345F7990;
	Fri,  1 May 2026 21:50:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 694A345F7990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1777672214;
	bh=3sE/6hOxpoIGj9ehFzQMDomY+sVfft3Ah0FMn+p1sCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFNTJG5nnQ162RMuAvzztzOpmdZBoEpBELHRjI3ioU2m1rEtKH/f02Qfvd+zDGNMi
	 TxDWyJgLklA0lJ6ZS/0DcC4LNBONqKFBH8qcpkJj8ysd3bjrStvBdJfPd6Ut4T3hin
	 b/svkyAMdVSTB+08Y+Sf8vuBSSlzy/rxeWrJppXY=
Date: Sat, 2 May 2026 00:50:14 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben@decadent.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
Message-ID: <20260502003658-e04f382bc8ed201a99b573e0-pchelkin@ispras>
References: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
X-Rspamd-Queue-Id: D0F9C4AFDCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Fri, 01. May 15:33, Jens Axboe wrote:
> >> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
> >>  		if (req->poll_update.update_user_data)
> >>  			preq->user_data = req->poll_update.new_user_data;
> >>  
> >> -		ret2 = io_poll_add(preq, issue_flags);
> >> +		ret2 = __io_poll_add(preq, issue_flags);
> >>  		/* successfully updated, don't complete poll request */
> >>  		if (!ret2)
> >>  			goto out;
> >> +		preq->result = ret2;
> >> +
> >>  	}
> >> -	req_set_fail(preq);
> >> -	io_req_complete(preq, -ECANCELED);
> >> +	if (preq->result < 0)
> >> +		req_set_fail(preq);
> >> +	io_req_complete(preq, preq->result);
> 
> This should all be handled in the fixup patch - yes this one ended up
> being broken, but that's why there's the followup fix.
> 
> Now this is all pretty broken because some patches ended up in 5.15 and
> some in 5.10 and honestly I've almost lost track at this point. Sasha
> spotted some that were dropped in some broken commit from Greg. For
> 5.15, the two attached are what I recently asked for to be added. 5.10
> should ALWAYS get the exact same patches as 5.15, because of the whole
> sale backport that was done years ago. I always ask for that explicitly
> in the emails. But looks like that wasn't always done...
> 
> 5.10 doesn't look like it ever got what is sha
> 349ef5d2e7bfb292e7000e6041a984ab56eccf28 in 5.15-stable, hence the fixup
> can be merged with queueing that backport.
> 
> Sigh...

Oh, for the fixup patch - it is in the 5.10-queue (or at least was when I
wrote up report today).  It was taken into consideration.  The concern
for the Fixes tag is resolved now by you, thanks for clarification.

But that `if (preq->result) < 0` thing is not covered by the fixup patch.
This check is not correct in 5.10/5.15 because preq->result is unsigned.

Taken that double complete is OK (I had doubts about that), the following
change should do the job now:

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8b0dfea96ee0..b17a26b1b5e1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6006,7 +6006,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
 {
        struct io_ring_ctx *ctx = req->ctx;
        struct io_kiocb *preq;
-       int ret2, ret = 0;
+       int ret2 = -ECANCELED, ret = 0;
 
        io_ring_submit_lock(ctx, !(issue_flags & IO_URING_F_NONBLOCK));
 
@@ -6037,7 +6037,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
                preq->result = ret2;
 
        }
-       if (preq->result < 0)
+       if (ret2 < 0)
                req_set_fail(preq);
        io_req_complete(preq, preq->result);
 out:


The fixup patch may be updated with this if the changes look OK.

--
Thanks,
Fedor

