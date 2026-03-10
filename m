Return-Path: <stable+bounces-223782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMTDDzXQr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:03:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488C246E15
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A8B03061505
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8CA3D4120;
	Tue, 10 Mar 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Fx/rtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423833D4124
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129612; cv=none; b=gv23sDPo/0qcIBvZiAPxNV4ioQU7ZRBvz0Vth00ar47R5/gHGIHR6N/MgBlg4KWBB1KrVz+G1VlSX52vPASVIa+qyQ0XUPjP9BmQCyIJgeIjOU1wX8QhvbvuabqSyuLINuIhONS6TgNTFSkh6XrWdcp7pYbOPMPd6mxfLBHjG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129612; c=relaxed/simple;
	bh=1psb+i8PgITcl3ezHGYbCLbfijR3fK2v53fQmyavhKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dee/bP8Yl3Kvs5DVOMnw4jqfvuucMJ3kmtwgkd/aPXenjEk1ktYkq2LVKIZsFRfgPnX7BID/Vf/wtDQPua40BVGvA93I+aUXNCM4F/GqnsvICll+Ts+epQp96xFxAvNT3VqykSkpSQK7Jpviw0EPLkluFds+imibvQn32XjVE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Fx/rtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DD4C2BC9E
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773129612;
	bh=1psb+i8PgITcl3ezHGYbCLbfijR3fK2v53fQmyavhKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W/Fx/rtcytb6wVC31tuxtLa9fAfesKZ7e2f3oKnSAgYB/P9acmljVk3fWU9NxhD6n
	 xVYRQghqWLrHDmL9jgQIAtYzJ2rDlDRGfUdhYxg8mJMcRR5tl0ruA9nTxVUJnsLTE7
	 J8L/Herct9vMmLM4gG1ZQRmcKkjaM1lgvMQhrRR9BBb/0rtlqwqyIJ1P5XJ520UjMx
	 LzlNr/NKu+Ek9gzmvlfAWJ2WutvLVp6sihi/Gz4I4DR9doc2KcuQKW48Haoc40gyvw
	 IiSaza9sgl78T1w67rTbAdckRmi2azz9vQMuXpV8MpQig9UMFTlCqCmJr+KCHQd/GJ
	 Q88uupRSGdedQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso17616736a12.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:00:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLyvKq27gTJXPq8m+0fP363n1ZqnIqa8nSVOgXsv6cVBGbRrZc
	UJgskcfbVP03OmFAVioQE0vhDfFc32DB5pwrhrDRmBoWB0Ay6VD7bepqkWhDlFZzkAIf58YXAH3
	VsPp3Pzl3md60r7cVK+xwwH51UwltJps=
X-Received: by 2002:a05:6402:21c8:b0:662:b0cf:b997 with SMTP id
 4fb4d7f45d1cf-662b0cfbbdcmr1563652a12.16.1773129610352; Tue, 10 Mar 2026
 01:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308164226.20791-1-sashal@kernel.org>
In-Reply-To: <20260308164226.20791-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Mar 2026 15:59:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7GxtWRZyAT=kedLEMu=C5wH--NUzRjwi3DKXzUq+QZjA@mail.gmail.com>
X-Gm-Features: AaiRm52C7G-z1pB3zXQthf18qpZJ_0Hk9OPyho5Ex2_bCefBcutq4Ik4nggrVE0
Message-ID: <CAAhV-H7GxtWRZyAT=kedLEMu=C5wH--NUzRjwi3DKXzUq+QZjA@mail.gmail.com>
Subject: Re: Patch "LoongArch/orc: Use RCU in all users of __module_address()."
 has been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, bigeasy@linutronix.de, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1488C246E15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223782-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,infradead.org:email,linux.dev:email,linutronix.de:email,xen0n.name:email]
X-Rspamd-Action: no action

Hi, Sasha,

On Mon, Mar 9, 2026 at 12:42=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     LoongArch/orc: Use RCU in all users of __module_address().
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      loongarch-orc-use-rcu-in-all-users-of-__module_addre.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
Is this really needed in 6.12?

Huacai
>
>
> commit cb7c7e4265d8d6fbba83f1d4df9a028837702e06
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed Jan 8 10:04:47 2025 +0100
>
>     LoongArch/orc: Use RCU in all users of __module_address().
>
>     [ Upstream commit f99d27d9feb755aee9350fc89f57814d7e1b4880 ]
>
>     __module_address() can be invoked within a RCU section, there is no
>     requirement to have preemption disabled.
>
>     Replace the preempt_disable() section around __module_address() with
>     RCU.
>
>     Cc: Huacai Chen <chenhuacai@kernel.org>
>     Cc: WANG Xuerui <kernel@xen0n.name>
>     Cc: loongarch@lists.linux.dev
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Link: https://lore.kernel.org/r/20250108090457.512198-19-bigeasy@linu=
tronix.de
>     Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>     Stable-dep-of: 055c7e75190e ("LoongArch: Handle percpu handler addres=
s for ORC unwinder")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/u=
nwind_orc.c
> index 471652c0c8653..59809c3406c03 100644
> --- a/arch/loongarch/kernel/unwind_orc.c
> +++ b/arch/loongarch/kernel/unwind_orc.c
> @@ -399,7 +399,7 @@ bool unwind_next_frame(struct unwind_state *state)
>                 return false;
>
>         /* Don't let modules unload while we're reading their ORC data. *=
/
> -       preempt_disable();
> +       guard(rcu)();
>
>         if (is_entry_func(state->pc))
>                 goto end;
> @@ -514,14 +514,12 @@ bool unwind_next_frame(struct unwind_state *state)
>         if (!__kernel_text_address(state->pc))
>                 goto err;
>
> -       preempt_enable();
>         return true;
>
>  err:
>         state->error =3D true;
>
>  end:
> -       preempt_enable();
>         state->stack_info.type =3D STACK_TYPE_UNKNOWN;
>         return false;
>  }

