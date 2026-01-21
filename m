Return-Path: <stable+bounces-210783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHE9HYgBcWmgbAAAu9opvQ
	(envelope-from <stable+bounces-210783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:40:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF95A06D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9EDFA2F89F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5B4A5AE1;
	Wed, 21 Jan 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knTBMt3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAAB3A4ADA
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009052; cv=none; b=oCBKah+l7umx6ZbmQanRllpZ6I1HtCZBkWclaGmxPEVdG3OGg/0cbVPhELsD7bBLx37caXUqf83Ii3fh+ONzTF5Xb3jnffNMnzTXgnpDsLgd2HLQv9LQPNUXGHA7ky1c11aCvLhnNEE7NXFz5kg2esXcluhr6i+4HoYbhlVgSqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009052; c=relaxed/simple;
	bh=b9+vKk6fpV0/bfqxdUsLvysdweB8xoV3mUdDKnwkal8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mw0D/VSkh8r7v9fTdeJa+Wq46AMwI92z29V/mqYxf4SJcX/mjQnixXiJASMX524bJqNXXPvxtiKvWvuh2DW0aj+8lKhF0HMjw0V5a5ajt9VLGioBq0YbxnL+m4MS/HEu9EOTC4hHt2JRsKNsghW4xvbfdNKDFMNL+BivOw4b+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knTBMt3o; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8722f32507so1102954066b.2
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769009048; x=1769613848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6ajID+rZne5e9R1dVGqHhj4CO0LeAgc7DZ9dTnxDK0=;
        b=knTBMt3odII/25kJggLyyj6nIvWblTMsAy2Etcd87xS9NQ3rCAnNFrCWD7tHQsXFiP
         JZuvynboodQzy7lVd6toCUMqb4JGiVzryYyoBbJOzOhIEqn44NE4nlPq6i7AYdUzRMRk
         MvYr37Re+1Cu7L7rtyVLLshu6naDreNLRVao12dnRImBeTfbRieQP6FnAsA9hcErZw1i
         +2xDj42CtDuIC6FqGxulJLKkV6jJESjvgzBN4w2hokPrPqyh7VQ7uSJpb56MKjoFvovg
         Sy56optuw7dpl8aSCQaFcUdBBNltsHGOfBwM5LPcfHrhidi91Ly0a0lAbITNWzx2svRc
         2RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009048; x=1769613848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6ajID+rZne5e9R1dVGqHhj4CO0LeAgc7DZ9dTnxDK0=;
        b=VRGw946EjSqAcS4DO0ey5XBnAwBYbaD6d1hyX5m71sh1mpEVoK3x4BS+GiGvSuREeN
         Rz0X8eUoZwK4hO5ayM0Xo0AnInAJhtS+pS3hVQ3Jg/iZ2K0CPL6lxCitwzWC20vdYdAB
         8FMVRWUuFVE/sTyXvk3pExB0/nxxF0cFis1rgeivcL+Lr7vQAwMX3w1+24d1yW7mzHvy
         pjg3YShJvHnUIZrzukMLG56aVNjQnU5qSJFMJZzormDzve1vJw4MgYcVo+3coXMD91Xm
         HDz9KJ6NdF1+opxEq4+AA9XnxGzIRbTz8Bs/r/yU+rEtBsu+15SaGnoOA7+EnymcYWUS
         8P5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOjwo/tBnssrFAhb7xzhcW+dbvaDo+ycAm1xOcQsZ5wmShr5wSbxyRPH6RziFKsb1HPEEDMTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxq/jUnVoSCo0jXiCno3J8j1VoNDMyJ/sqvHAnkOMGOBRe9z1Q
	pDO2/AE2Wq0wzX0m65Ig+ENeUXJozFOAOBF7xKoAEhnBXshFnbrXD0j6/2a3DwDfBc+niPIpQtR
	aAV9Gl8sKRaQPAd/XCw==
X-Received: from ejbjy30.prod.google.com ([2002:a17:906:cade:b0:b86:fedc:879f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c22:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b8796bc4f7emr1728663866b.58.1769009047796;
 Wed, 21 Jan 2026 07:24:07 -0800 (PST)
Date: Wed, 21 Jan 2026 15:24:06 +0000
In-Reply-To: <20260121145005.120507-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121145005.120507-1-cmllamas@google.com>
Message-ID: <aXDvlhDvCpzf62KH@google.com>
Subject: Re: [PATCH] binder: fix UAF in binder_netlink_report()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Li Li <dualli@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-210783-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D1BF95A06D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 02:50:04PM +0000, Carlos Llamas wrote:
> Oneway transactions sent to frozen targets via binder_proc_transaction()
> return a BR_TRANSACTION_PENDING_FROZEN error but they are still treated
> as successful since the target is expected to thaw at some point. It is
> then not safe to access 't' after BR_TRANSACTION_PENDING_FROZEN errors
> as the transaction could have been consumed by the now thawed target.
> 
> This is the case for binder_netlink_report() which derreferences 't'
> after a pending frozen error, as pointed out by the following KASAN
> report:
> 
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in binder_netlink_report.isra.0+0x694/0x6c8
>   Read of size 8 at addr ffff00000f98ba38 by task binder-util/522
> 
>   CPU: 4 UID: 0 PID: 522 Comm: binder-util Not tainted 6.19.0-rc6-00015-gc03e9c42ae8f #1 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    binder_netlink_report.isra.0+0x694/0x6c8
>    binder_transaction+0x66e4/0x79b8
>    binder_thread_write+0xab4/0x4440
>    binder_ioctl+0x1fd4/0x2940
>    [...]
> 
>   Allocated by task 522:
>    __kmalloc_cache_noprof+0x17c/0x50c
>    binder_transaction+0x584/0x79b8
>    binder_thread_write+0xab4/0x4440
>    binder_ioctl+0x1fd4/0x2940
>    [...]
> 
>   Freed by task 488:
>    kfree+0x1d0/0x420
>    binder_free_transaction+0x150/0x234
>    binder_thread_read+0x2d08/0x3ce4
>    binder_ioctl+0x488/0x2940
>    [...]
>   ==================================================================
> 
> Instead, make a transaction copy so the data can be safely accessed by
> binder_netlink_report() after a pending frozen error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 535fc881c8da..70dc63a6e06a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3780,6 +3780,14 @@ static void binder_transaction(struct binder_proc *proc,
>  			goto err_dead_proc_or_thread;
>  		}
>  	} else {
> +		/*
> +		 * Make a transaction copy. It is not safe to access 't' after
> +		 * binder_proc_transaction() reported a pending frozen. The
> +		 * target could thaw and consume the transaction at any point.
> +		 * Instead, use a safe 't_copy' for binder_netlink_report().
> +		 */
> +		struct binder_transaction t_copy = *t;
> +
>  		BUG_ON(target_node == NULL);
>  		BUG_ON(t->buffer->async_transaction != 1);
>  		return_error = binder_proc_transaction(t, target_proc, NULL);
> @@ -3790,7 +3798,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		 */
>  		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
>  			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> -			binder_netlink_report(proc, t, tr->data_size,
> +			binder_netlink_report(proc, &t_copy, tr->data_size,

Erm, this solution seems dangerous to me. You access t->to_proc and
t->to_thread inside binder_netlink_report(), and if t has been freed,
could the same apply to t->to_proc or t->to_thread?

After looking a bit more: I can see now that you do call

	if (target_thread)
		binder_thread_dec_tmpref(target_thread);
	binder_proc_dec_tmpref(target_proc);
	if (target_node)
		binder_dec_node_tmpref(target_node);

after this ... so I guess it can't go wrong in this particular way.

But I'm concerned that we will add fields in the future where this is
not the case. For example, let's say that tomorrow I want to include
t->buffer->clear_on_free in the printed data. If the transaction is
freed, then t->buffer might also be freed.

Alice

