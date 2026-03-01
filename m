Return-Path: <stable+bounces-222410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GgHCzvdo2l5QQUAu9opvQ
	(envelope-from <stable+bounces-222410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:31:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D81CEA0C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C36F330101C3
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4563CB;
	Sun,  1 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbunPj0n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0302EE262
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346677; cv=none; b=UxVDD5ZbemAYQKsyEw5VTEvAekezJGcCtlvUSsbLYthuTBGX7CKOqkBLOY7mBaMznttm9E/33WgUtVK1biVoaatJaoDVAr5/8u1Tpo0gPHGFgPYgaeyhkrbHy+EqnWaueQjrVwbFgBjMpt3hxdnC3VbsPbNTBCoZZexCSSjJ6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346677; c=relaxed/simple;
	bh=PdqmIItn7OjJRkJ5j5P7b5Mdc37I02Ft+oe+RbqG8+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEdBop/hiTPOMEFaMHTgotT9l4pRH+Md+uwctrCQBcuy65ePfBAAlnF+BZRSe2mEF8hfW3U9Xub3JZgDrKy8hU8plTy3urOQwNZ11s0x030N1SBMujnWkUPLc4TKCvsO+5zJ6mrwQ1Zri8uQLam7DFPvklxe58OQLWILI3CfIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbunPj0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA52C4AF0B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346677;
	bh=PdqmIItn7OjJRkJ5j5P7b5Mdc37I02Ft+oe+RbqG8+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cbunPj0n1yijfP4XTXz5jtY/yyBObbPi7iHgKvOClnFXG437iip/OlmS/2/jsvg/+
	 vRu3h/WHSHfz7i0PWW1kfjjYYwR96spvfo21fmXtjzbt2aPc7hluQgDwKARgg6r2qR
	 PAWi3FVNKKoWHzcr+qLuQw7QuHlEzCqKAlSP9QjvphpzJ8LryHY/oSBXSdHRcAajyb
	 zupYyZwkaG/qvcH5WKjFwTr8SA7n9Tcmy6JmZYNxEZDxiwQ1S1bWQixv13efuoXZ8z
	 l42ybIujMpgdThO8kq6dfKumIKT6teR8/HBXBkwGtEPXUyZ4ZwmunK5AZAnv2t6Adb
	 9T8WfDHPg0Ckw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a43a512b0so3797781a12.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:31:17 -0800 (PST)
X-Gm-Message-State: AOJu0YwQ47l2DyH3VTcEuNCC3seTOyPSSPRV8qSB7DT02mtBXWFdnV+0
	5AIKOzYeAnz0AAg63NkNtKhP+amuW7U5HQUDT/ZWc+PgU5UHC+iEYGQrcxM8ZVqyMs5aGlkCjno
	MRxG+IWQ23aaVUzZbXT0Z092/k0GbdSw=
X-Received: by 2002:a05:6402:4311:b0:65c:20dc:9048 with SMTP id
 4fb4d7f45d1cf-65fdd6bda94mr5301723a12.4.1772346676002; Sat, 28 Feb 2026
 22:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012742.1685273-1-sashal@kernel.org>
In-Reply-To: <20260301012742.1685273-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:31:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5VAkxas275gJGJ4QZnowHLaudCea-0b6vVWue+RsrsRw@mail.gmail.com>
X-Gm-Features: AaiRm511xbNzsL4e3JTZLPyHggpwCk9m0t5nQotR9TkBrHdgW952N0qV2qHFiPo
Message-ID: <CAAhV-H5VAkxas275gJGJ4QZnowHLaudCea-0b6vVWue+RsrsRw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Guard percpu handler under
 !CONFIG_PREEMPT_RT" failed to apply to 6.12-stable tree
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AF8D81CEA0C
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.12

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

