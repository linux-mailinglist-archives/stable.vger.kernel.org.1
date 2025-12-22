Return-Path: <stable+bounces-203226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC86CD69B1
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93100300E45D
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3732D435;
	Mon, 22 Dec 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndj/EVSh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC430FF37
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418408; cv=none; b=WTTQ49QGEasN2yNsbbVZ/Wr5IjcH6/VQokTEl4x3tqqwWsyr6ZXfa/x40e0uk/asnrIwKNlZmnusEqnOy+u7JtjJUP7fNfAAVBu4nlSzjhnWxfDrTSWGGlWCWBO8wqzqlBFGfuis69ArcRkc40jMVs/rzshNjXvpaBigc5kEQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418408; c=relaxed/simple;
	bh=CeKVUtrnCs9OCHg7v9G5b0rOqPaP/CgOIPSNBpDS9TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxnuUSGxMfMdPEfyAg7DuUa0J2lLXzz43juA9zUUpZxDVmu1wn71BO3XBdcQYusdbNVmyf3HtfB3/F2F094kqcmgOnVDYOtNG3GdrNJL+v2ocmNuucxRlrh8LpWU6UgOJNvkLEBkualikXCaYVkFdI/BL79u2+2qyZFUW9l65SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndj/EVSh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ba92341f38so4613667b3a.0
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 07:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766418406; x=1767023206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bv2gntJgBXtiu31zWj5aMqoO8tc0JdlMD+qDh291wic=;
        b=ndj/EVShs6kKCoY335q4UfZaS2yxo/HAF79R3lh3LF56/rmgtdsJxuuguMAG4yEKue
         lhI7BazuX/F3h6i71FKoMZnS7BglDeAbNPSmBNkz0HFH4CJkjZ/kuEOzfa5NhKa8UtpZ
         DiY0cdu14cpgbbz7PbrzuGRkgpeHrIgyGfoqNxbJOAS1YUtyNLQ9N0QUQ6gfL7e46VDS
         BZNhgvVldufdVOF3IPHgaifjel4Mlu0X+AMkQKNCKJiYAmBuZw0pdo2gXU5gmZJW9jUZ
         J6W1uVwnKYWopDJzOzAVqKdo6trg7svXXr3iyqT2HWlwyg+M5RaR5OVQ1pkkHxaIqaET
         XV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766418406; x=1767023206;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bv2gntJgBXtiu31zWj5aMqoO8tc0JdlMD+qDh291wic=;
        b=p5kLQdFV4bNqe+nfF5VBQHIs/bLIHNrkRop07a77O2JQas7znz0CxPD7b5cF3wa/dq
         bnGAGtkSz0c0tBYasvE0XAbwbsNX5hE1JIsewdmcc6PowGvinqKfo3oUd3pQTzkibMxR
         MC/bCXKM621iNwVHQnKjU9IZ3h2WVHk/UjvoGDjc+NB1Jr/74E5XVkZicbPJ73h3kI8O
         HECvUoVfOjURZEWN24Kt5j9ML/sLwytbsOx7ComQXrvBN/9347zgeDwvbz41OM0UTq3b
         wiun5ivttcYt67ZcZrhtTWa1WedCk+TCTZBL0dVlOVeophRpc44Z1z7CTeLmrLcAHM7p
         Ojyg==
X-Forwarded-Encrypted: i=1; AJvYcCWFwnBKOUKEAgtWlqEGe9tPtpoS6bjIeM7JgdUrIbt5lOkwEYFIkZmqxHsSKf5wKPODcCNN5cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPd/Ek7iSa6wnEZGG+RENkrkCQecOEP6E8Y61meGjuVBjYgh3
	gjZx94alHRSH+IFXAB3EZ+lflov2o/f9w4YJqFj5DuNoI1DXl3CTIPtj3jvrCfnZV65F8nGf2sm
	E8mXmjA==
X-Google-Smtp-Source: AGHT+IGvLBoGsXVzBr3m/Do0woX/jUwcUSCQPKj8JoQh4+EdFhAiTc99FBbRBZXfb91qRfmoWJoeFEq2Qbw=
X-Received: from pfuj2.prod.google.com ([2002:a05:6a00:1302:b0:7e5:5121:f943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca8:b0:7e8:43f5:bd51
 with SMTP id d2e1a72fcca58-7ff676624demr9901855b3a.61.1766418406100; Mon, 22
 Dec 2025 07:46:46 -0800 (PST)
Date: Mon, 22 Dec 2025 07:46:44 -0800
In-Reply-To: <190f226a-a92f-4dab-ad7a-f7ea22e6a976@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219010131.12659-1-ariadne@ariadne.space> <dbe68678-0bc4-483f-aef3-e4c7462bcaff@vates.tech>
 <aUWNlTAmbSTXsBDE@google.com> <190f226a-a92f-4dab-ad7a-f7ea22e6a976@vates.tech>
Message-ID: <aUln5DdCMcvhJzl9@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
From: Sean Christopherson <seanjc@google.com>
To: Teddy Astie <teddy.astie@vates.tech>
Cc: Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, 
	kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, 
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	xen-devel@lists.xenproject.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025, Teddy Astie wrote:
> Le 19/12/2025 =C3=A0 18:40, Sean Christopherson a =C3=A9crit=C2=A0:
> > On Fri, Dec 19, 2025, Teddy Astie wrote:
> >>> @@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(v=
oid)
> >>>    	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> >>>    		return 0;
> >>>
> >>> +	/* Xen PV domU cannot access hardware directly, so bail for domU ca=
se */
> >>> +	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain()=
)
> >>> +		return 0;
> >>> +
> >>>    	addr =3D ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(val=
ue));
> >>>    	if (!addr)
> >>>    		return 0;
> >>
> >> Such MMIO only has a meaning in a physical machine, but the feature
> >> check is bogus as being on Zen arch is not enough for ensuring this.
> >>
> >> I think this also translates in most hypervisors with odd reset codes
> >> being reported; without being specific to Xen PV (Zen CPU is
> >> unfortunately not enough to ensuring such MMIO exists).
> >>
> >> Aside that, attempting unexpected MMIO in a SEV-ES/SNP guest can cause
> >> weird problems since they may not handled MMIO-NAE and could lead the
> >> hypervisor to crash the guest instead (unexpected NPF).
> >
> > IMO, terminating an SEV-ES+ guest because it accesses an unknown MMIO r=
ange is
> > unequivocally a hypervisor bug.
>=20
> Terminating may be a bit excessive, but the hypervisor can respond #GP
> to either unexpected MMIO-NAE and NPF-AE if it doesn't know how to deal
> with this MMIO/NPF (xAPIC has a similar behavior when it is disabled).

Maybe with a very liberal interpretation of AMD specs, e.g. to mimic the re=
served
HyperTransport region behavior.  Defining a virtual platform/bus that #GPs =
on
accesses to any "unknown" MMIO region would be incredibly hostile behavior =
for
a hypervisor.

> > The right behavior there is to configure a reserved NPT entry
> > to reflect the access into the guest as a #VC.
>=20
> I'm not sure this is the best approach, that would allow the guest to
> trick the hypervisor into making a unbounded amount of reserved entries.

No, the maximum number of reserved entries is bounded by the number of vCPU=
s in
the VM, because each reserved entry only needs to exist long enough to refe=
ct
the access into the guest.  Recycling NPT page tables after every MMIO-NAE =
would
be comically agressively, but it's very doable for a hypervisor to set a re=
asonable
limit on the number of NPT page tables it creates for a VM.

