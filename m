Return-Path: <stable+bounces-272703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nC2uK9B+Tmp9NwIAu9opvQ
	(envelope-from <stable+bounces-272703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:46:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10C728D9B
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:46:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bPEQ80D4;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272703-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272703-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5432C30205F9
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A643710B;
	Wed,  8 Jul 2026 16:40:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A2435EFA
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528834; cv=none; b=q4xFaM3+FfeRxp6tfv8Ud90rypP4n/YU2yYpQPxZJcMhK1nureAYw+IEWvKOvftpeJVIyz9Z/OD4d5dD/KebvBcclOfvV4/HYgBzXaIVhFzhUbgQgVyKUWivw+hfBUCipSQzPKt8DRNl+vcT2OK9Xn4OgEJkCO10NQsoNS9JFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528834; c=relaxed/simple;
	bh=c/XEaNKYNrF1l/hWu7ALmwJ52AsqFo535mfE2TQPLXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6RzNQuc2q3UN7lye0g/yhyu0k3GmlT0U9SU13vZ+/7Y1NrVrpP2jVvdIgoRIY4y17BhnbuVotZ8E/up+iFD6yT2C0zrqX6kXBNdRP7GLfd5R8hLuj0iOSETQBVrVsD7y0UxS9A4S/N8XnS1HiKSMaqaY8aqFtS8C0b27UcFmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPEQ80D4; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478a1ec69fso16475b3a.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528831; x=1784133631; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=bPEQ80D4x2/kMzYcInPE1ZZ3/vm8Bh7JoCfvDDRUsfSF3FHF6+tYyUV8ncxkDukZ5e
         5EYmPfqSbBmo4HMsPzGvrgbPukkmh2+nhpmxuwrH2B5GQkHgUhMvPpzY2PxEx9jR7ssu
         0HHvbl+SESnmvTTgdRyUdi0QrVxpK9+URO39XbXV+dkjwlmrxJNTQ7fGaAfYAwiVnZMK
         W6GudAbYh0yGFLTQ3LKRWlL3O5W7CeIcJDVYgSX/l9M7ni0f+nSz+MFdNKWW67oOBd2g
         5PY2MEQG9TzPnBxK9Wkc1GCVNpfwywXw2rdeMtTxd/jt6VExGml/+1/6IAr21oU9nKe1
         2/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528831; x=1784133631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=RDg7cjC+4fcNSM2iPK96/xJmnPpMI/Vh8eZzZU3tve+NeVoF4CcK496dsAWTbjneQl
         0W6mkUYhJzee8+UJsPcGPtuYoB5qOe5fJGg14RHTbvZBO2RCR7UlScB+uOGzmMGwX4Ws
         cXYEWwpUn1SoS2NjtWw4EP3wN9JfhOWnuA4k4nBmi3pmPWWJ10hrLJ/W5HP1PJVHutBW
         EfO+l4q9TuPcJSNpZ7kN9N7iyo/UjUPRJuCI4w9lWm3yxR1bBPUHK1VTNhV8sne/4v0h
         GGzfaG4YyufGDJnkm9Vy+TZifozq/Od6QFaHNF4D24JCHSy3wXYqsHDHdU2fXabX4rHI
         nwQw==
X-Gm-Message-State: AOJu0Yytcssu6qyljuAchFUWAksgcg+kZq17XrDE3KgeLFfyf1ZegbyE
	q/GMx/kG2dWek/pbsYJNf75fl6HCaf9vvle5EO6cG4LH7EiYg427Hhb/njvR3QFAjRSF8jmswDO
	KC0wE1A==
X-Received: from pfbmy25-n1.prod.google.com ([2002:a05:6a00:6d59:10b0:847:9499:46c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9487:b0:848:4b27:36a3
 with SMTP id d2e1a72fcca58-8484b274223mr1645594b3a.72.1783528831076; Wed, 08
 Jul 2026 09:40:31 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:40:30 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Message-ID: <ak59frQUBl9Gs3Qn@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272703-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leixiang@kylinos.cn,m:stable@vger.kernel.org,m:maddy@linux.ibm.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:paulus@ozlabs.org,m:warrier@linux.vnet.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,ozlabs.org,linux.vnet.ibm.com,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E10C728D9B

On Mon, Jun 22, 2026, leixiang wrote:
> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
> fallible setup and never clear it on error.  The bypass manager doesn't
> register a producer whose add_producer() failed -- producer->eventfd is
> left NULL, so the later unregister early-returns and del_producer() is
> never called -- so nothing ever drops the pointer.
> 
> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
> when the vector is disabled, after which a routing update dereferences the
> dangling pointer via kvm_arch_update_irqfd_routing().
> 
> Nullify irqfd->producer on the error paths.
> 
> Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
> Cc: stable@vger.kernel.org
> Signed-off-by: leixiang <leixiang@kylinos.cn>

Please post the PPC patch as a separate patch.  x86 and PPC are separate maintainer
domains and the backports will likely need to go to different LTS kernels.

I'll grab/extract the x86 change from here (and I'll massage the changelog as
appropriate).

> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>  arch/x86/kvm/irq.c           | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..14919b76fb32 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>  	irqfd->producer = prod;
> 
>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
> -	if (ret)
> +	if (ret) {
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +		irqfd->producer = NULL;
> +	}

Unlike x86, AFAICT there's no need to set irqfd->producer before configuring
the passthru/bypass stuff.  So I think that fix could be this?

diff --git arch/powerpc/kvm/book3s_hv.c arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..ff7b25629125 100644
--- arch/powerpc/kvm/book3s_hv.c
+++ arch/powerpc/kvm/book3s_hv.c
@@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
        struct kvm_kernel_irqfd *irqfd =
                container_of(cons, struct kvm_kernel_irqfd, consumer);
 
-       irqfd->producer = prod;
-
        ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
        if (ret)
                pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
                        prod->irq, irqfd->gsi, ret);
+       else
+               irqfd->producer = prod;
 
        return ret;
 }

