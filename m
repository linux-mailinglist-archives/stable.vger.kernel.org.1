Return-Path: <stable+bounces-222421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEn6OUrho2lYRAUAu9opvQ
	(envelope-from <stable+bounces-222421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:48:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 482FB1CEAE3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0045F300F5F8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E523D7CF;
	Sun,  1 Mar 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt7FjxrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271521B9F5
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347705; cv=none; b=IKZ6aUWUV2Un76Ok5VPKN7UVTfF5a1mBbnC9vWzFxJ4Fp5fd6DJK3RQh9J6YcVDPG/+T521q0k/tobhxjYKnzOe2tkg7ZQNd50qt6L3g5JUqEHfi+igz9cUwp9UTgZRoTVFEfMSqD8oZYtkWRrSJ47AYMGbt5/P0dg7m0RPUKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347705; c=relaxed/simple;
	bh=OhQEegzcESI5yzIkY00Hkpo4/iw3Ao8n9nc1rF53/k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZOBk7syF+b035NKmlK8qJ0gP3L2bto46M5HE5bDH2CO7Jg1HrTdLQYn9LA7Sbul/vTsEWSxGx+Yin+U0Fo8Fz77MScb0+MPnAPLajvcprwTTdx0O3CBu10o62pDxkmzy8GWgAiFnHm4Dq5pGxbRKWkC4lpt3UVkejZCRRq2ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt7FjxrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69C0C2BC9E
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347704;
	bh=OhQEegzcESI5yzIkY00Hkpo4/iw3Ao8n9nc1rF53/k0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bt7FjxrAvMKIFnnvDPVNf0GTNfcVOOGNa+2nmuHUACNEzz/ToyoaoY681k7OPfnjk
	 BBCx+UB0UiGBBkMpY6hdNqLrr4eVODsAQHhUI30S8HRvlU/YI1+K+7pWpClc8xhtJ0
	 UUwGYdxFxu4Jlu5PYjKC249p/jD+XUHTlXdnHSt5KhH8iL+p51JD9FGL6FulDIzMyo
	 gRyR3KqK6QDWG9srHgeN28TEfoQH8ejr+QDfPyjoItGgv82gGhlXJqFTAiLpzQprBP
	 HPw9bQqaLf3CgWxm2SdhH9dRY+CgHbAFqCg3mglb4sCX3LIpsZ4oqNuX4ORwiR3YRU
	 ie5/ArvDCsZ/g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7eeso4845797a12.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:48:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwIo/dsWrcGJPxnfHH9V0/SOfk46sQFitBef2JaICiTU3wIiImW
	kKlk9TRc4saHfYr9hdBcVajq0wz/p5nZbosTcN7BkkeMsCTfkGVDnfKCm4+Z5zOfQs4bMiuI2U5
	IMUh1ohqgCnpV9xKsu8uXZtn9UuB5D6o=
X-Received: by 2002:a05:6402:444c:b0:65f:8d21:68df with SMTP id
 4fb4d7f45d1cf-65fddcecec2mr3612892a12.19.1772347703372; Sat, 28 Feb 2026
 22:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301014635.1709598-1-sashal@kernel.org>
In-Reply-To: <20260301014635.1709598-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:48:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wsaRPBYQmiaQ+Xg3OfK3NGD7yuZpcd7_gbKwp+Xwjsw@mail.gmail.com>
X-Gm-Features: AaiRm51ZhyQUutbkYR5HycQdxmYheIhSiBvvpxr7lnsFxgCwLEW68AQyt5DHqNk
Message-ID: <CAAhV-H4wsaRPBYQmiaQ+Xg3OfK3NGD7yuZpcd7_gbKwp+Xwjsw@mail.gmail.com>
Subject: Re: FAILED: Patch "LoongArch: Make cpumask_of_node() robust against
 NUMA_NO_NODE" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, john.g.garry@oracle.com, 
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 482FB1CEAE3
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:46=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I'm very confused because it can be applied and already here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-6.1

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

