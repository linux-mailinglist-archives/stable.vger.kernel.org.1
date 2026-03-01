Return-Path: <stable+bounces-222417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KORAK+7fo2lPQwUAu9opvQ
	(envelope-from <stable+bounces-222417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:42:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDB1CEA9C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AD7301D33E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985930B539;
	Sun,  1 Mar 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KtZv9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0263148B4
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347369; cv=none; b=YumvIiXZM31WET/kICKdB5EoiGu/cJeOkQVmfbiJq+RhuHhuyOF9yngch3DGfy67Q9e6wW7+2lDalvmgf295XNwe45r30RuJVdqYyyWXhd7TW5od+wzgk6nz6S2Ec+4Sf2LywyYtwpp6lSmJiT0jOtg8vI5g3B6B+k9qNYRtUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347369; c=relaxed/simple;
	bh=gOsLOEfkRMnTNQ6/obOibNRWcQoVeBEacmidZUBspHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChiWHGIzhSZrNEGMfHBto/BJbo0qeoFnDBWXpWlejjUXAlfyN6enOD+VDUvfMYResah3717BciQzlw5Y6y+UTfhdY1lDkC5VmIasXGUHez/SY3tsk3Q6M5UPazvBgcbiNKlQ4WiebglbWTEiq0++VMyJ+sM8eWCKl+BubCfXtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KtZv9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A3C4AF09
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347369;
	bh=gOsLOEfkRMnTNQ6/obOibNRWcQoVeBEacmidZUBspHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X4KtZv9PQnSZJLRiA6BjaEWcT5IsNKn7+6k5rA8DX4Mas5HtSZWQ5Jcji5DOtZMj0
	 4CDyAmPotfmxEk9JUlaUkNCiWFNGL7TZE9PRu0mbMmp+/n5T23P5//M6oe0Kauekej
	 XQA0ZjfJW3vSceBeMakHUEvVKlWO851460mKSC92pC5/LxmY7/c+WuJuIkjGv13PM3
	 IvJHobx7lbvIfqcQblH/7yJhekgg32Yy9Eld8fcyajmid+5VWTnK1gWWNvIH5MH8Zd
	 VtOtfjtmPRYGSRqa8uoSbr3hMOrixUQ9lTlqaBWm5Leop7GW4T0RK4RVgrrRcfnBCF
	 8bFCU7UcfZLcQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65fa79f5c98so5763584a12.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:42:49 -0800 (PST)
X-Gm-Message-State: AOJu0YzxuYFKzXzUJnUccFW660ChuHWxGpOpfrZJOdjm79pLYbzIL3hm
	z+HOiXXavg2ibQcCD92Qo+vmDKF9FcM53yM+S/X4o6bX9Y7/U0Wbmz7x3AQ/yJe5wYCarmMe403
	/rtAT6lRmDNkk0iKiT17Is/nEOtXsukc=
X-Received: by 2002:a05:6402:a2c5:10b0:65a:4207:fbf0 with SMTP id
 4fb4d7f45d1cf-65fab735585mr5254076a12.15.1772347367821; Sat, 28 Feb 2026
 22:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013806.1698436-1-sashal@kernel.org>
In-Reply-To: <20260301013806.1698436-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:42:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4h5n+Ccjc=rwsz+1Bv4DCg94GiZGD2420+jDLB45mxWw@mail.gmail.com>
X-Gm-Features: AaiRm52ewdaatNPIHb6_ElITT_wi8yEOEupcJIIH3B1YMtqMIPVoK17eV3mZ5a0
Message-ID: <CAAhV-H4h5n+Ccjc=rwsz+1Bv4DCg94GiZGD2420+jDLB45mxWw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Guard percpu handler under
 !CONFIG_PREEMPT_RT" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, yangtiezhu@loongson.cn, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10DDB1CEA9C
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:38=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.6

Huacai

>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From 70b0faae3590c628a98a627a10e5d211310169d4 Mon Sep 17 00:00:00 2001
> From: Tiezhu Yang <yangtiezhu@loongson.cn>
> Date: Tue, 10 Feb 2026 19:31:13 +0800
> Subject: [PATCH] LoongArch: Guard percpu handler under !CONFIG_PREEMPT_RT
>
> After commit 88fd2b70120d ("LoongArch: Fix sleeping in atomic context for
> PREEMPT_RT"), it should guard percpu handler under !CONFIG_PREEMPT_RT to
> avoid redundant operations.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/unwind_prologue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/ker=
nel/unwind_prologue.c
> index 729e775bd40dd..ee1c29686ab05 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -65,7 +65,7 @@ static inline bool scan_handlers(unsigned long entry_of=
fset)
>
>  static inline bool fix_exception(unsigned long pc)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
>         int cpu;
>
>         for_each_possible_cpu(cpu) {
> --
> 2.51.0
>
>
>
>
>

