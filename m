Return-Path: <stable+bounces-222408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5yHmD/jco2l5QQUAu9opvQ
	(envelope-from <stable+bounces-222408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:30:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA791CE9FD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECA4B3007B32
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD942E22B5;
	Sun,  1 Mar 2026 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsznyLx7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5127470
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346610; cv=none; b=MmwZeJmBOtg5FwCseYm2cpDnLQ7tlp5LgmhdrhBP2QFNJLgVrdKB1UkRbdzTCsirFAHSCtQRSqCSE5+3theNhbxAoExvZV4kQqMJa5J3aEYxnx8zcteTiB95ziXZXEYKKoX5cHcRYHSD0f1K89SPOzTcOWrktfO0p8nRG57DEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346610; c=relaxed/simple;
	bh=isAkMY5xLEvuyv0ACpWczwrAEWOhgfE4drkaGkr+nJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK8mYMrYsDXMksC7fHesVf4UUuaJGqr27AtJWBhXURQ0ESLJ7OkkTWg9OEewMTRKn2MUljl/HU19NjhCD6f0o6rHIfX0fFn/5OKxrvHCf0JicJWl6bhb+3H2pZtR/3sU5s9+EsNlGc4oJbVUZx3TdNh8mO4TGUBT6UegUo85+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsznyLx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F31C2BCAF
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772346609;
	bh=isAkMY5xLEvuyv0ACpWczwrAEWOhgfE4drkaGkr+nJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KsznyLx7mDqHqIMv88Gs2ZYDwcthATtCtViiIthl2tqaVmxZ78t4tUmyhq3tSroXx
	 zKCGnuaNohLebCcaK56Y3q+G03itoCwQRAJbhZn4y7uRPJllgoV+RDiCaM11yV3Y36
	 cwhu7jY9aPeuNnQyoRYcCu/2tgOH1daSF7k4Zx/wREG7+u8zig/ufs3MKyrK9cmvMV
	 Q0TxnW64N8StmFrS90HGHiyjFv5IwAnYMxTdC7/w0JFY46YZMNGslVKt4UY++t2H3H
	 nfcEgVm67sraf7zvqVt5ELshud9TwDJ5aiuXb6OI35VkItX81OTpeombMsic/UcklL
	 XWB6u+lxoh5Ig==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so5548395a12.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:30:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yxw+u8bQBcYoStrb6En4jpD/0vpkNhFTaWfVSx6qv0wMG9xP/R/
	9ePz31BSn5gXtxWo/Ud1yAojx0AK1vgxjXRIuNn0DFCmH8kzNGubHvv+NlVhdKaVeX0LUj3lVKl
	fUAAup1mnxT33eO9Hg1c/tiCgjAAa6hc=
X-Received: by 2002:a05:6402:27c9:b0:65c:972:7085 with SMTP id
 4fb4d7f45d1cf-65fddaf6c47mr5131604a12.18.1772346607163; Sat, 28 Feb 2026
 22:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012730.1685022-1-sashal@kernel.org>
In-Reply-To: <20260301012730.1685022-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:29:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5b7MHvW-eB4rfMoZBPDR-bTt+xYBq-pqe7VVf=9N+PRQ@mail.gmail.com>
X-Gm-Features: AaiRm50rwQMqz8Y6FgxjFys-UELMehhIJVhXrh0UUnegmJ_nzMcX6gZ0ojDjBkI
Message-ID: <CAAhV-H5b7MHvW-eB4rfMoZBPDR-bTt+xYBq-pqe7VVf=9N+PRQ@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Make cpumask_of_node() robust against
 NUMA_NO_NODE" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, john.g.garry@oracle.com, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222408-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email]
X-Rspamd-Queue-Id: 2EA791CE9FD
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

