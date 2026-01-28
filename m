Return-Path: <stable+bounces-211979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDhsA78gemmv2wEAu9opvQ
	(envelope-from <stable+bounces-211979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79CA307D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF1A3006164
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544663612FC;
	Wed, 28 Jan 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkw3jZG/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790223D2A3
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611450; cv=none; b=BSST5HFkKFmkDvzwIqzArCGiZAS0z2qHI6ctQErI/S/X0FeN7qi5Oq41Ziq8tlw0q0YOl70sm0i3p6J29i2k0EqFOVKlXRDyeXJ10YbpC7H9CztS+gGeSAWaXpoibPWKBcF9lLQBUaBTE7EV8RKkc5XbNrpJE5c/JNzIq0RguLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611450; c=relaxed/simple;
	bh=Eifm+5IJG2WQcz8KqADEZNqgSy4azlf0NZp9PbMUSwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oCoHZ6XQmoSpj9CDiIY5Rqw2xDXuNQbz5E9/oieYMZUkkGtfHuGy2BhmHY/pCn0MhqxC73cDNAWAas72//3jlp+OnRvMR7rvPgZTCicnMDcmEDxTxvfSYwgBZfUxmeCObF+/SHB2P3NiRqXfr8Ygz+fG28Bq9oP+8xtCdOIr0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkw3jZG/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7a98ba326so13745355ad.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769611448; x=1770216248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvJo/tir+J2/AtqQsUlOrgU1ueJuDktH3Ssw+42VW2E=;
        b=fkw3jZG/5wB85wEo1RZZ3fYxv7dBYcsfBtHVq3y3+WalADv3UMVIHozQRLFyN1pCUl
         QhFh1fWiSeFxq0zWdZRj+2x5amcGP+tLBgrFfg83PBsADUm4xzjQj8CrPFFJuDeSoPmA
         7wBF0tANtae6xUBuu0xrDMWvjTmh8yJQzgUn3Cz7UXOxH36UWIa33P1zk5iwHPfxWMec
         U3IKotg2cvAEWWqhpimJQfzTq5t1C8L+yoLyf85kinm7T19ufWegMBYXqYBdxa5lU6MB
         9iylyLvKsh5X7wSmppgqkdUZo1Mm4SLlh8hN627HXdTuJGBhInme6MFS4YppnyPG3kiT
         UC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769611448; x=1770216248;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cvJo/tir+J2/AtqQsUlOrgU1ueJuDktH3Ssw+42VW2E=;
        b=BhnOMgL/OLcAsZ/zlYKIDz//Aq6h2oLDOklVzm8PA3qnSbxmawd8P8DXOLjRrztjNj
         ur8aFhDMGKvQkI1qO6/W4LodlcBr1zJJXoWDqCRO0y8CAnrXuEAsLi/g5JeosMVUgZ3R
         F3y25DMuvKq96CiC+b8/EGO2bWpJn8Aj4/CEOxz476bdrpNbTwU2Q+AnEGwC5WHdNhGa
         /58Io5eBiYldwmFKK6VvD+1XvuHeNHPy8Dnr7T/CWKtpVIVSSZjgR7uTOOxlcM6LJDhQ
         khIazeN60IXQVrJyadINJ71UQBs/zh70wGKDOmNmvTsc7Hfamk9PsgVdrrmaPKpg+fEq
         XQpA==
X-Forwarded-Encrypted: i=1; AJvYcCVkyL6Tnk2mmoJxJq8bFTTxIVnMjuocAv3dblBvAax68I5meNSN6T3ezloTbg75IjqohkHoCdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5oUqdXBbi9eaUfdzU8Dk7uWbo701yp1YUvI7ejMhoE9rqxgq
	w6JFneEaCNHnTX9IuOblZ/1Y5aHdG9DKbOvO3L6hGBSC514eylt2F+7VRNquyAyO2ZnMyZ9BEwz
	PEhNilQ==
X-Received: from plbmj14.prod.google.com ([2002:a17:903:2b8e:b0:2a0:de6a:ac6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:2a0:eaf5:5cd8
 with SMTP id d9443c01a7336-2a871267ae6mr39141105ad.9.1769611448055; Wed, 28
 Jan 2026 06:44:08 -0800 (PST)
Date: Wed, 28 Jan 2026 06:44:06 -0800
In-Reply-To: <ea294969d05fc9c37e72053d7343e11fa9ffdded.camel@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123125657.3384063-1-khushit.shah@nutanix.com>
 <feb11efd6bfbc5e7d5f6f430f40d4df5544f1d39.camel@infradead.org>
 <aXkyz3IbBOphjNEi@google.com> <ea294969d05fc9c37e72053d7343e11fa9ffdded.camel@infradead.org>
Message-ID: <aXogtqrZMehORg2L@google.com>
Subject: Re: [PATCH v6] KVM: x86: Add x2APIC "features" to control EOI
 broadcast suppression
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Khushit Shah <khushit.shah@nutanix.com>, pbonzini@redhat.com, kai.huang@intel.com, 
	mingo@redhat.com, x86@kernel.org, bp@alien8.de, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	dave.hansen@linux.intel.com, tglx@linutronix.de, jon@nutanix.com, 
	shaju.abraham@nutanix.com, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211979-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F79CA307D
X-Rspamd-Action: no action

On Tue, Jan 27, 2026, David Woodhouse wrote:
> On Tue, 2026-01-27 at 13:49 -0800, Sean Christopherson wrote:
> >=20
> > Nope, we should be good on that front, kvm->arch.irqchip_mode can't be =
changed
> > once its set.=C2=A0 I.e. the irqchip_split() check could get a false ne=
gative if it's
> > racing with KVM_CREATE_IRQCHIP, but it can't get a false positive and t=
hus
> > incorrectly allow KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST.
>=20
> Ah, so userspace which checks all the kernel's capabilities *first*
> will not see KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST advertised,
> because it needs to enable KVM_CAP_SPLIT_IRQCHIP first?

Only if userspace creates a VM and uses that to check capabilities, in whic=
h case
KVM is 100% right to say that KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST isn'=
t
supported.  If userspace checks the system-scoped ioctl, i.e. with @kvm=3DN=
ULL, it
will see KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST.

> I guess that's tolerable=C2=B9 but the documentation could make it cleare=
r,
> perhaps? I can see VMMs silently failing to detect the feature because
> they just don't set split-irqchip before checking for it?=20

Hmm, if we want to improve that particular documentation, then we should do=
 so
in the description of KVM_CHECK_EXTENSION itself, which currently says:=20

  Based on their initialization different VMs may have different capabiliti=
es.
  It is thus encouraged to use the vm ioctl to query for capabilities (avai=
lable
  with KVM_CAP_CHECK_EXTENSION_VM on the vm fd)

Because there multiple capabilities that are conditionally supported based =
on
the VM type/configuration, i.e. this behavior isn't novel.

> =C2=B9 although I still kind of hate it and would have preferred to have =
the
>   I/O APIC patch; userspace still has to intentionally *enable* that
>   combination. But OK, I've reluctantly conceded that.

Eh, VM really should be returning '0' for the check for all KVM_CAP_X2APIC_=
API,
and disallowing the capability, if the VM doesn't have an in-kernel local A=
PIC.
Because enabling any of the KVM_X2APIC_API_* options without a local APIC d=
oesn't
actually do anything.

I say that because I'd be very tempted to "fix" that by restricting new fla=
gs to
VMs with irqchip_in_kernel(), at which point userspace needs to get the ord=
ering
right anyways.

