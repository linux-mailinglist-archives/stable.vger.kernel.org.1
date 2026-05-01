Return-Path: <stable+bounces-242245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XDzkDMxt9GlcBQIAu9opvQ
	(envelope-from <stable+bounces-242245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:09:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826D4AB2A2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA5B33008CAC
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BC37DEA9;
	Fri,  1 May 2026 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Hc9LBJ2Z"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736937D126
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626564; cv=none; b=rMN8afPuJ1NhPWskH1CUiRvOqH/0vaeVxGkqhxFxTpA2mGVytPfCkg2pVSl4ADLH6SZHYhIQjC9kbOcjagPiv22s3R9TDMVvBx3azfxkPnsfx1GcSp9u8NbR/HMsjHaKPbMq6vLrnEQFMUlNMhSlBi9e1GKKEgfoP3w4qz7vu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626564; c=relaxed/simple;
	bh=xdtE/DCkochWviPR4LA8Fpn5j454tT/ivRr7H1oKanI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AuS2jru0e+Ko8x63wB5NjJ50+AkQUN1BKYeuKrmZKOC0uuXv/G67zCP2K6iam2RlQSx1cvH0I2+kfL+0BySKmHQBd89nb2jXxNNwoTbOnyZU1baJMPD08X+kteeNzJyhEWSD5HVUGwMQ7VNk4T0gDMMgMHkdeOYFLiv/uSE5SHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Hc9LBJ2Z; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id BD60640ACE03;
	Fri,  1 May 2026 08:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BD60640ACE03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1777625658;
	bh=NwIekQkMHoKLiqQPg0K6ummhL2Oz3biAx42coufr5V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hc9LBJ2Za3CK5zQv9X3SQBx56j6b0/vUIsyCG2/K/r+PcYcvTz6hA10sw9R1dWa//
	 EG9eg29FyeBC4DxTj3TRnztG6Hk+EZ58NeRFeFt0u6aghGQrV1EYf51Eo1OFPi3J25
	 jMYmqz8n6AUSKnoAPJKqhDfWj5BvRvffdNPh7a8w=
Date: Fri, 1 May 2026 11:54:18 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben@decadent.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
Message-ID: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
X-Rspamd-Queue-Id: 1826D4AB2A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242245-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ispras.ru:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email]

Hi Jens,

the patch has some issues even after "[PATCH 2/2] io_uring/poll: fix
backport of io_poll_add() changes" has been applied.  Please see below.

Jens Axboe wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Commit 84230ad2d2afbf0c44c32967e525c0ad92e26b4e upstream.
> 
> When the core of io_uring was updated to handle completions
> consistently and with fixed return codes, the POLL_REMOVE opcode
> with updates got slightly broken. If a POLL_ADD is pending and
> then POLL_REMOVE is used to update the events of that request, if that
> update causes the POLL_ADD to now trigger, then that completion is lost
> and a CQE is never posted.
> 
> Additionally, ensure that if an update does cause an existing POLL_ADD
> to complete, that the completion value isn't always overwritten with
> -ECANCELED. For that case, whatever io_poll_add() set the value to
> should just be retained.
> 
> Cc: stable@vger.kernel.org
> Fixes: 97b388d70b53 ("io_uring: handle completions in the core")

This commit is not present in 5.10/5.15 in any form, to my mind.  That
is, io_uring changes were imported in big chunks there without preserving
upstream git history in some places but still I can't find whether the
changes of the mentioned Fixes-commit are present in those old kernels.

So either the Fixes tag is not completely correct or this patch can just
be reverted from 5.10/5.15 stables.

> Reported-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
> Tested-by: syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  io_uring/io_uring.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -5980,7 +5980,7 @@ static int io_poll_add_prep(struct io_ki
>  	return 0;
>  }
>  
> -static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
> +static int __io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	struct io_poll_iocb *poll = &req->poll;
>  	struct io_poll_table ipt;
> @@ -5992,11 +5992,21 @@ static int io_poll_add(struct io_kiocb *
>  	if (!ret && ipt.error)
>  		req_set_fail(req);
>  	ret = ret ?: ipt.error;
> -	if (ret)
> +	if (ret > 0) {
>  		__io_req_complete(req, issue_flags, ret, 0);
> +		return ret;
> +	}
>  	return 0;
>  }
>  
> +static int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	int ret;
> +
> +	ret = __io_poll_add(req, issue_flags);
> +	return ret < 0 ? ret : 0;
> +}
> +
>  static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>  {
>  	struct io_ring_ctx *ctx = req->ctx;
> @@ -6012,6 +6022,7 @@ static int io_poll_update(struct io_kioc
>  		ret = preq ? -EALREADY : -ENOENT;
>  		goto out;
>  	}
> +	preq->result = -ECANCELED;
>  	spin_unlock(&ctx->completion_lock);
>  
>  	if (req->poll_update.update_events || req->poll_update.update_user_data) {
> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
>  		if (req->poll_update.update_user_data)
>  			preq->user_data = req->poll_update.new_user_data;
>  
> -		ret2 = io_poll_add(preq, issue_flags);
> +		ret2 = __io_poll_add(preq, issue_flags);
>  		/* successfully updated, don't complete poll request */
>  		if (!ret2)
>  			goto out;
> +		preq->result = ret2;
> +
>  	}
> -	req_set_fail(preq);
> -	io_req_complete(preq, -ECANCELED);
> +	if (preq->result < 0)
> +		req_set_fail(preq);
> +	io_req_complete(preq, preq->result);

preq->result is of unsigned type in 5.10/5.15 kernels so the check for
negative values is a no-op here.  Also as Ben pointed out in the initial
report, __io_poll_add() already does complete a request if it returns
non-zero result.  Not sure if completing it twice is good.  The extra
patch from this thread doesn't address these issues.

I wonder whether these lines may be moved in the else-branch here like

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8b0dfea96ee0..1e3835bdaa9f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6036,10 +6036,10 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
                        goto out;
                preq->result = ret2;
 
-       }
-       if (preq->result < 0)
+       } else {
                req_set_fail(preq);
-       io_req_complete(preq, preq->result);
+               io_req_complete(preq, preq->result);
+       }
 out:
        /* complete update request, we're done with it */
        io_req_complete(req, ret);


but, again, then the __io_poll_add() surrounding logic doesn't become
clear enough:

	ret2 = __io_poll_add(preq, issue_flags);
	/* successfully updated, don't complete poll request */
	if (!ret2)
		goto out;
	preq->result = ret2;


Thus currently I'm for reverting this patch if there is no bug it might
fix in 5.10/5.15.


Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

--
Thanks,
Fedor

