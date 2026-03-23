Return-Path: <stable+bounces-229993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PbGNkuIwWn+TgQAu9opvQ
	(envelope-from <stable+bounces-229993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:36:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 812BB2FB62F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE7F7301B792
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4112E040D;
	Mon, 23 Mar 2026 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cPKUnUUw"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958D2DEA7B;
	Mon, 23 Mar 2026 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290990; cv=none; b=teQGU5BDHC/QGG9JUifdgFi5/4VF0wMHCB3SktbGbJylV/3C3yxrtA1QrPgkcr/b174XZzyG5fT4C8g4COhgjsMuHGQF2f+ELDk/O8anNygnmBd78JPHBgyqqTxa1+2IOKZ998l6au22ncvj7UCEZMZ9Y1B1ti7xFNKsIGyO1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290990; c=relaxed/simple;
	bh=hl6X1HK0MVHB85xw9EAy9uyX8KPSXSWQpDivXp/F078=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnJa94IT2/tJwD6Z1qcQRQAkUJheF84b4kyEqr0Mu+x0gHxst8hqGSDEIBN45/qq29ZwEaS2J3RvX1ier4JZDYabD5V1UgGjzFPx0o61AzEJudGdWrnDTfmstLzxzpLfpdJi/wfj9/O5yYmVyms40nxW99HaHdMWoEcDjkj4YXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cPKUnUUw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=cD48I22UPGx57jyUUL+qOghGNHAJydJTw3sMS1pSeI0=; b=cPKUnUUwkeFEhEgctNdBpHoIDB
	1knOio2bdLJZD2QgyS15lzFRZGe+xeqmCWVQP6EQuuJX9lerqhBy6pK6n0EQftWQxUIHzAvb51CeP
	tYiDngYGDRWEc1/07mJmWfCNRmZELdyGffPz+tIohJEc1goTL6zi95l3qgGlOhdr+Fjo3y1Ti/iSn
	TddLVIWTQ7g1DGPN8PcVdz633HgtmiXAIl41W2gnaJgpZJG7TYuDFnSZG/R9O8tFkMY44yeONzc2Q
	7LoZBiV1eEg2EajEfqpSn60NQ/luMsZMZ+1KuQktsZ5qbXL38pTafUyEBEcL7XML9HoJaSXByMDY2
	ND6jUhng==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <aurel32@debian.org>)
	id 1w4k8a-007jEE-JZ; Mon, 23 Mar 2026 18:36:27 +0000
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurel32@debian.org>)
	id 1w4k8T-0000000C72f-3Y9W;
	Mon, 23 Mar 2026 19:36:21 +0100
Date: Mon, 23 Mar 2026 19:36:21 +0100
From: Aurelien Jarno <aurel32@debian.org>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more
 robust
Message-ID: <acGIJXccO5JVlrGh@aurel32.net>
Mail-Followup-To: Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tianrui Zhao <zhaotianrui@loongson.cn>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
References: <20260322135346.3720577-1-chenhuacai@loongson.cn>
 <676198e5-78e4-ab41-e447-4a9d24655890@loongson.cn>
 <CAAhV-H7rFtju3k=NYkAy6-O7f8U=CTNiryu2_Kr57pScjeH-yQ@mail.gmail.com>
 <696c5177-4a89-f0d0-c305-c1581e72aa3d@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <696c5177-4a89-f0d0-c305-c1581e72aa3d@loongson.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Debian-User: aurel32
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aurel32@debian.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-229993-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Queue-Id: 812BB2FB62F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 2026-03-23 15:56, Bibo Mao wrote:
>=20
>=20
> On 2026/3/23 =E4=B8=8B=E5=8D=883:08, Huacai Chen wrote:
> > On Mon, Mar 23, 2026 at 11:16=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> > >=20
> > >=20
> > >=20
> > > On 2026/3/22 =E4=B8=8B=E5=8D=889:53, Huacai Chen wrote:
> > > > kvm_get_vcpu_by_cpuid() takes a cpuid parameter whose type is int, =
so
> > > > cpuid can be negative. Let kvm_get_vcpu_by_cpuid() return NULL for =
this
> > > > case so as to make it more robust.
> > > >=20
> > > > This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
> > > >=20
> > > > Cc: <stable@vger.kernel.org>
> > > > Fixes: 73516e9da512adc ("LoongArch: KVM: Add vcpu mapping from phys=
ical cpuid")
> > > > Reported-by: Aurelien Jarno <aurel32@debian.org>
> > > > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >    arch/loongarch/kvm/vcpu.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> > > > index 8ffd50a470e6..831f381a8fd1 100644
> > > > --- a/arch/loongarch/kvm/vcpu.c
> > > > +++ b/arch/loongarch/kvm/vcpu.c
> > > > @@ -588,6 +588,9 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct k=
vm *kvm, int cpuid)
> > > >    {
> > > >        struct kvm_phyid_map *map;
> > > >=20
> > > > +     if (cpuid < 0)
> > > > +             return NULL;
> > > > +
> > > >        if (cpuid >=3D KVM_MAX_PHYID)
> > > >                return NULL;
> > > >=20
> > > >=20
> > >=20
> > > if (cpuid < 0 || cpuid >=3D KVM_MAX_PHYID)?
> > > however both are OK for me.
> > I use a similar style as kvm_get_vcpu_by_id(). :)
> >=20
> > But there is another warning which can't be solved by this series (and
> > I doubt whether it can be solved unless revert 01a8e68396a6d51f5b).
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
>=20
> what is the kernel config file with bug
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1131431
>=20

I have just sent the kernel config to the bug report.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

