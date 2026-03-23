Return-Path: <stable+bounces-227892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mERiID/owGl6OQQAu9opvQ
	(envelope-from <stable+bounces-227892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:14:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23462ED5B1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E778305BFE0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683535DA4A;
	Mon, 23 Mar 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3s7iWR8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FE29D26E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249709; cv=none; b=BJng4Uf62Ic9yiIBLs4QmUl2qXAE3QOLV4MAhiGdeiWtky6oworJmD3pBYUVLwWiWxSVyyejBIciDMMwYmsM585SDngHOMnwWKM8vIWWRNs59wY3Tdi2cQV9BSE5PKGlNHr7vtKgmqqmZTeeD2MY0mhjWtKhuxVALm/Ayh2mk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249709; c=relaxed/simple;
	bh=I7JQd27zGB4Ebig8E/VetdYeJzIIxW73/4qeDzntcGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAZR68i2rUWsjMOpk8Pxr0qKL0lVnmij4gEPnKbvOh2vGQrgrS2BG27GTTULHFEnQ5yqU621ibSyugglQyuWAntsiOyISQ+8cRec1Bz2Rw9xw2rLw8iOo6uTh05l0wVMHtmcQvEEfDyTzfi6C7+ntWJUGIO6OljSgHcbsmDN500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3s7iWR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA4EC2BC9E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774249709;
	bh=I7JQd27zGB4Ebig8E/VetdYeJzIIxW73/4qeDzntcGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D3s7iWR89wZfyatx1Fh5dUeZdUxS8P6DQQ3ZkW5I1Q65GQ8H1LdtlByB19m7kQDJ3
	 4JoJL885zZGoy7sJla+xMexKeiefAJCYQ2/CZ9eJqy2LsEb+qLuuDoTFCs/pIQ6F2+
	 pksprdLMfEjbQCW0y3VrBuEEseA3I9xFAaBHNwE8xE00pu46A7ey8vFoA+qWCy9JMw
	 3vSlC2vjUm5o8ke5+N/Ay2pK6l9jRXuctaTt4i1d9KlT32MStteP8oT8RcHyeLp3P6
	 AGLaUfBMnEcdSHg4McTGbte01FosRCJJfZ0mQ7B4IUWN4sJ4wuJBs/IB1p/AdFgV9M
	 sMUDNrIWdCXoA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b982d56dac4so290387166b.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 00:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPPJJsb4kZaZsnrb5I6bmH/58BQObRiLs/4GG4qFhLg+9rvtQBJq1u0Dyyy0uCh2fQRIbYqmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7A0h4UHHUZy3UekhWlyE6YSnnKE3AxxHl0hSSb5QvJKLkt/61
	BWpa5ZYATwlOJhuMzo9zIF8koYUc7SQoU4WZbGilL4iwHISgBv0hlHHF2IF89ViWpuGPEL4AfBI
	1E50OlT6lQLKzE1MJMPLkw02eiLl02XI=
X-Received: by 2002:a17:907:86a7:b0:b98:3b5d:e147 with SMTP id
 a640c23a62f3a-b983b5df9a2mr718350666b.3.1774249707731; Mon, 23 Mar 2026
 00:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322135346.3720577-1-chenhuacai@loongson.cn> <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
In-Reply-To: <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 23 Mar 2026 15:08:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
X-Gm-Features: AaiRm50Nqh46-k27BJ4OMuRIjKm603Sh-BaWcnA_C07nYZe0hy1pIZa-KVIqTeA
Message-ID: <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Aurelien Jarno <aurel32@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227892-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,loongson.cn:email]
X-Rspamd-Queue-Id: F23462ED5B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
>
>
> On 2026/3/22 =E4=B8=8B=E5=8D=889:53, Huacai Chen wrote:
> > kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, so
> > cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for this
> > case so as to make it more robust.
> >
> > This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from physical=
 cpuid")
> > Reported-by: Aurelien Jarno <aurel32@debian.org>
> > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kvm/vcpu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > index 8ffd50a470e6..831f381a8fd1 100644
> > --- a/arch/loongarch/kvm/vcpu.c
> > +++ b/arch/loongarch/kvm/vcpu.c
> > @@ -588,6 +588,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *=
kvm, int cpuid)
> >   {
> >       struct kvm_phyid_map *map;
> >
> > +     if (cpuid < 0)
> > +             return NULL;
> > +
> >       if (cpuid >=3D KVM_MAX_PHYID)
> >               return NULL;
> >
> >
>
> if (cpuid < 0 || cpuid >=3D KVM_MAX_PHYID)?
> however both are OK for me.
I use a similar style as kvm_get_vcpu_by_id(). :)

But there is another warning which can't be solved by this series (and
I doubt whether it can be solved unless revert 01a8e68396a6d51f5b).
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431

Huacai

>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>

