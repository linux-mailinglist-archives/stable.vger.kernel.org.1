Return-Path: <stable+bounces-274509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RhIBHnaDVmqQ7wAAu9opvQ
	(envelope-from <stable+bounces-274509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D209A757EBB
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DMUDT1ov;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274509-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274509-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1508B300FF9F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A3377ABA;
	Tue, 14 Jul 2026 18:43:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4041A93A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054623; cv=none; b=dPhsICbGl140j4kBjzeb/YvTZ2yOcLqWxDELIkTj+sJX7Mz4c9Gets1rDqfuSVlBgiKYBF+2X2rdKD8iXfsOnMjAe1/mGLtLJK066WAF429GmIVZTMlspaUT8WNQeGrUfxCwE4kGDrmeC6EK8NB5LJRyiImaIpIAxgLbMNoTflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054623; c=relaxed/simple;
	bh=0Cxt8qE06Or/jQL8clXHIMUHQkQVbLUBxaPpYh+HO6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cEr1CRqH66EBPZL0elYIp5g17mmIwV7N7PYK/0s5gcHsOYbbaz+hfQzb4kjtWfGDTk3kB03l0Xm6Gh8t3XJwX3ohwAqdJAdn/M14oARXL6j0DV2TwKINGTm1K5OYz/Ror6vFrakM4uj6m1R5ti7N/L87jcQG9tsvhPaPObSihHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMUDT1ov; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84877b362f6so7613184b3a.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054615; x=1784659415; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=DMUDT1ovU2EeL+NddwKYGRCPCweeER39Iu9QEfk0M1UzJHwT85hdhiTSoOq5FV73de
         vUoHeld5mZZ/zhrWmk4e39o/JyVS6Zjs5wPFFnaU6NaIK7LurEwP6MJGR9b0IQ6qK/Q2
         ErVkTTraghHEGl1qMbIyWv9gUtd6DfoGrTJjp0nwv8cSleIZSOVgHXyLYYGoh27viJpq
         ElWZNGoWaoRH9Q4f56gcNNRyXWvu8VQ+O+m1sXqZ8x9cq9WMMDG/r0XGPQScz1IBu9y8
         vxQOae3pKbYGKt3ynLd/FxUcd6+Vu+sTq+FzWGKHPmNPGA7BXOiRZyF4GEq9UmX+he3E
         os6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054615; x=1784659415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=fFwQTmiI2gjtJ38dUtQxO2w+cQI5G/9Wd6BcL6PRoOQeJ85K5zuyp1l/TYHDERAsyy
         6oK9tPwpsUf/nN6RzgVWsGS9Bzpq1sTJKkU0Dm/7oGWNoERdumZf5Akk58plPnClXgJ4
         wXozzAKIcEbc+B+l1YN67TRB2jqKltzK6dOx2woVJduSix7QCpwD3canKrDrDKXzjatv
         8pmnPUwBpj7KJW9pxJcX/f8vT8I0GgUIZSWjT8Fe7b5shRbmaF913D61GPVo0ePaJYsT
         tHAhX1s5sbcMdNXLvjCIwEbUnUHHedMh/y6iH7uV5Sz8I23o0WaG7iVnjN9dREEat0D4
         YUzQ==
X-Gm-Message-State: AOJu0YyP7GsMAQH6byqSb0/rq7gQaWuFQ9zPx30EBM9ewVxEUMoRoQNM
	65XY1diShzJa/GozazsUrnp1QtfHAKSDV1jtmV30wr8PhCYikr/i0tdeXgfKJe5+z540PnRxG22
	d1rZVMA==
X-Received: from pfnw16.prod.google.com ([2002:aa7:8590:0:b0:848:57f0:bf20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d55:b0:845:4fec:3f8f
 with SMTP id d2e1a72fcca58-84a55894653mr3684533b3a.40.1784054614662; Tue, 14
 Jul 2026 11:43:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:09 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405354318.3120836.11122335012620649935.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:leixiang@kylinos.cn,m:stable@vger.kernel.org,m:maddy@linux.ibm.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:paulus@ozlabs.org,m:warrier@linux.vnet.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,ozlabs.org,linux.vnet.ibm.com,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D209A757EBB

On Mon, 22 Jun 2026 15:51:01 +0800, leixiang wrote:
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
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Nullify irqfd->producer when add_producer() fails
      https://github.com/kvm-x86/linux/commit/ed446e8aa894

--
https://github.com/kvm-x86/linux/tree/next

