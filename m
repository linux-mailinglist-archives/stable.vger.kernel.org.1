Return-Path: <stable+bounces-222415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id obJfH4/fo2lPQwUAu9opvQ
	(envelope-from <stable+bounces-222415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:41:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B9B1CEA7C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C549301D306
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C47316195;
	Sun,  1 Mar 2026 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnohbxpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16132D3A86
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347275; cv=none; b=Xy16tcQPqVrllKAaz6ZxTlLiQcjAxUh35mHw1SYCBalCwyv+tk3woaDm+sP36YcY5+QLwBAxOCroUM6NoXTS6qKxfRzdS+LOjAfE0czphWTQFw3QfypFilk0uSPgqm+5Yddte3BfgY0VjJ5AjlkhLhO0nCXZBK8JqxNcWcIbV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347275; c=relaxed/simple;
	bh=9PidwZoO0K0ElaJZE1asLblg7xI5QtCXK76VcYMp46w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4wwbJiGy0lbPLh2WrSAwKtxQatrgMjeiaiYdgvKlStOTwq4TWXYVi4cQO5xM0IR0JJqiKOoO+lqS0RAROVka/nv95vJ/1uzTCO4RNctWxBKiDzy0xHXFsfTlLXZHPM4+Mzhkq4I4cWDVGLJFIfh296VKMiBe116J8xd62irhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnohbxpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30FEC4AF09
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347274;
	bh=9PidwZoO0K0ElaJZE1asLblg7xI5QtCXK76VcYMp46w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EnohbxpLq2C17gVTDCvldVO5EZI4qd7U1HOiexNkNyO+gwZwyTxL/aFnwvm/Bqg25
	 VSu8deXWfi6ZJj8DIKAZGHbjT8nQCNcFcENIPxDGirpic/S5Es8NORX82nZ2DPDnxW
	 jQYe15RqElyBipD7JYtQT8eOB8WwO8E667IJT4G1ycWPdPy67a2JiMkgO6lRgZwchw
	 848piUvKPrsnoprnYuT7GpaAfuYqc057bi5h6HnTr/K5rSVsRV/ovJaBkqRZmYesSV
	 D3oYSSx50LFosSOJcdNA+0xhD08yH+6HocCkVyNJ18pk6meSyhtQEUZkaT6OOJ9F8S
	 rBs4x0waB6bow==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so5553506a12.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:41:14 -0800 (PST)
X-Gm-Message-State: AOJu0YyUTPe9HG+2dcQzj/mTiqOpJXp83BIlT/9yLIF6I3jORuBdMRYA
	phwc8tS6WYc0y04zeyGGDaqlEDelhqOEgbN4lFZDS6Gh4wI3ffq1Kd1dj1ZJEyiWEf3134xNffx
	VfKzsNUb6URRzGmdS8GUo5H4qB1rfz8E=
X-Received: by 2002:a17:906:7315:b0:b93:8460:4a7 with SMTP id
 a640c23a62f3a-b938460083emr438321166b.56.1772347273247; Sat, 28 Feb 2026
 22:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013757.1698242-1-sashal@kernel.org>
In-Reply-To: <20260301013757.1698242-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:41:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5PBM7JvQi=T-6V-GTy-G_mgv++EoeX3wonXKZVGjGTXw@mail.gmail.com>
X-Gm-Features: AaiRm52dDL9Wc5w76No4BeUQn9WDn8j-fnTCKmqGGjLx17up9eTfgMPxI2JjYsk
Message-ID: <CAAhV-H5PBM7JvQi=T-6V-GTy-G_mgv++EoeX3wonXKZVGjGTXw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Make cpumask_of_node() robust against
 NUMA_NO_NODE" failed to apply to 6.6-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, john.g.garry@oracle.com, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222415-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: C7B9B1CEA7C
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:37=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
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
> From 94b0c831eda778ae9e4f2164a8b3de485d8977bb Mon Sep 17 00:00:00 2001
> From: John Garry <john.g.garry@oracle.com>
> Date: Tue, 10 Feb 2026 19:31:12 +0800
> Subject: [PATCH] LoongArch: Make cpumask_of_node() robust against NUMA_NO=
_NODE
>
> The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE -
> which is a valid index - so add a check for this.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/inclu=
de/asm/topology.h
> index f06e7ff25bb7c..6b79d6183085a 100644
> --- a/arch/loongarch/include/asm/topology.h
> +++ b/arch/loongarch/include/asm/topology.h
> @@ -12,7 +12,7 @@
>
>  extern cpumask_t cpus_on_node[];
>
> -#define cpumask_of_node(node)  (&cpus_on_node[node])
> +#define cpumask_of_node(node)  ((node) =3D=3D NUMA_NO_NODE ? cpu_all_mas=
k : &cpus_on_node[node])
>
>  struct pci_bus;
>  extern int pcibus_to_node(struct pci_bus *);
> --
> 2.51.0
>
>
>
>
>

