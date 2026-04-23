Return-Path: <stable+bounces-240447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOOZFhfk6WlQmgIAu9opvQ
	(envelope-from <stable+bounces-240447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:19:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C337F44F3AB
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D9923071704
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3A3E3DA1;
	Thu, 23 Apr 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AN52BcQO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6432DD60E
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935881; cv=none; b=kg+Av7ZTuilHfgQSqlXKaIDISJMDtWQafTCtPrF4NviOIxyTgIULho6S1w0NPDqH7V5Kz0+1Gr67eJZc40NowHX+eP11PCj9vcKK8HcXwhHSwGyFBrRqpRmORKmBy8ArseNICdGW6af+h6oTUbXNgysRbv34H7Nfu3IwG6imfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935881; c=relaxed/simple;
	bh=AZoirHf/5mE5YFev+nodzuKCTioKK86YrjX4J7mCnGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9zxoagX1vxCVHWfdHZqTxe1h8T8k+w+PDYKagu/na3OC0oJBzxu3iOtZxkobpoKJwpdQhmY3lxtP5QdjqwHNk4MmU7cokvYY1LX614JhCwcttW9X6Pnldvv079Vvxe6w3N1CNfZ6xY9N/EeRjWAcj758G/K22S79e8+ZF060c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AN52BcQO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso49598a12.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776935874; x=1777540674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzw3UnIwHGir8Kj1NlO4m24J9zaCTTh7cxmm2qnVabM=;
        b=AN52BcQO4Oym4EIS/ybTJU4X0xMmH97zeiNTelL37EawZBYdiu86sX1EIB3vYscAo0
         Vcjf64iWxDZFRIgV+BUgPXwjn17ZxWf3x0zvD8PbwUSQdwsXOHXwx6QOZbBNlv+1eTfZ
         JlZSD8s8hyn9KGC5pumgaqIdPFAm9lkg81pMdNii3VqCoQ6kBqRfR1xVL79QIEpjYl3N
         KcS7eoYW3iXshaW0YENjeMePfK0vTCHe9LT2oLzygIfBJzJwOQaLeBDNqxkOWERekKAc
         yRP5mUdzoFDc7O8zjImnYAlKZo+/Gx9l3am2T7A/2JNf7Lh4hZbZweFdIPcyWM0FVNm3
         6nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776935874; x=1777540674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzw3UnIwHGir8Kj1NlO4m24J9zaCTTh7cxmm2qnVabM=;
        b=gKPOKjMyFrUrO5udhYUUffDn3AJGTNiCZevi28A/M+QivBGC0eKIa9DAnnN5FMJJv1
         J3BxIzBuFcSD7nBJHUrU8YVKP4w5cmGA/93lqKG27CSEVpx1Jpsp67gUY/5A/8kTKPMf
         lzBtXl7Zf4XobsfjeGBVy4nvcC+KyxFMgTMx4gTz2w/6WoYulg4LGMjlQwOlCUdS41xC
         wgH5xpXbC8E4NSSlw/qMVTLYLvnqSFZOM5dI18Z3M7u2BeNr6boxpzWAF/J24EYgrjrT
         vZNHeqQmCRpVxBKOZrZ/PLoq0FpXef4PFY63BNFRqUlo4sY7zjZtejug0fTQFZz8eBML
         osqg==
X-Forwarded-Encrypted: i=1; AFNElJ9vsafAFleMcUAiDfBU8Na8OB3zt5E2wlEl90BYQHIjZ36s4wuWVqTBJZRq/GlvWBzOE0gVIUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+PunnvJzwKrFJQFv09y1afkls2ySx4XKJxwWkIdQs703EX7B
	yKPiHSVwqmHYD3yHmcIA03MSlNdnagZdZOqd9hbVqWS5Nczg7ti4q3NCPSHeo5aN3+t/85+TqQY
	t4cRNlGFB
X-Gm-Gg: AeBDievqZ2nO3/KFaTvuvGwMfRlVmwfCjvbT0sMPFwvKt/ksUkEpdvcJqIPB7sFyYzO
	GyBZAx9Jao0X9CHQVdVsyUSqxWw72FOZrvnb8B8XxeG0j43XbuUZaQLJQOG5L8GDOhzSOwfJYYL
	BO9nZHI4lQUOkqc4D0WaD5iOPLSwQVmBu1ytnNYr7kwREIKWgtxVqMFPsZNEKiPMoaJdO/vmfFi
	a5vc5+dRb/RBnBYQUuLmgSNIq4s6MYf0VAIrJPUmjcJM9WtYx53VprJVYoQUgOb5MIj37+E7c+u
	6JL17T5AfGubqIf0HTs6fs9CaX1+jx5XS5v5tVjZVZvtCL1EMO4gF835Xv3pJnzK5Y6LyoYeNv8
	E3xzoE9+FjmzGaw8dpWL7q/WQ020fEe5giaSoW/lQvC7YPfyFh80/ql2ifSSsR+9qx4ychwEGnv
	94yN1L3q97jVGpLPtlx6c3/D8k80kffU0gTj4emPhsVBSn9KNsqMGrEXTZcEce+pWZmwums/wYR
	yBT9Ut/tlvgmluufL4=
X-Received: by 2002:a05:6402:3085:b0:671:dad9:8caf with SMTP id 4fb4d7f45d1cf-6744ed5f907mr227247a12.5.1776935873820;
        Thu, 23 Apr 2026 02:17:53 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e49sm655436766b.10.2026.04.23.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:17:53 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:17:49 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, oupton@kernel.org, will@kernel.org,
	ayrton@google.com, catalin.marinas@arm.com, joey.gouly@arm.com,
	korneld@google.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	android-kvm@google.com, mrigendra.chaubey@gmail.com,
	perlarsen@google.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Validate the FF-A memory access descriptor
 placement
Message-ID: <aenjvY5VJxFye52e@google.com>
References: <20260422102540.1433704-1-sebastianene@google.com>
 <86bjfb18v1.wl-maz@kernel.org>
 <aejOu98q1lEZoFfW@google.com>
 <20260422-jolly-curassow-of-amplitude-25fbaf@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-jolly-curassow-of-amplitude-25fbaf@sudeepholla>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-240447-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: C337F44F3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 08:29:06PM +0100, Sudeep Holla wrote:
> On Wed, Apr 22, 2026 at 01:35:55PM +0000, Sebastian Ene wrote:
> > On Wed, Apr 22, 2026 at 01:24:02PM +0100, Marc Zyngier wrote:
> > > On Wed, 22 Apr 2026 11:25:40 +0100,
> > > Sebastian Ene <sebastianene@google.com> wrote:
> > > > 
> > > > Prevent the pKVM hypervisor from making assumptions that the
> > > > endpoint memory access descriptor (EMAD) comes right after the
> > > > FF-A memory region header and enforce a strict placement for it
> > > > when validating an FF-A memory lend/share transaction.
> > 
> > Hello Marc,
> > 
> > > 
> > > As I read this, you want to remove a bad assumption...
> > > 
> > > > 
> > > > Prior to FF-A version 1.1 the header of the memory region
> > > > didn't contain an offset to the endpoint memory access descriptor.
> > > > The layout of a memory transaction looks like this:
> > > > 
> > > >   Field name				| Offset
> > > > 					 -- 0
> > > > [ Header (ffa_mem_region)               |__ ep_mem_offset
> > > >   EMAD 1 (ffa_mem_region_attributes)	|
> > > > ]
> > > > 
> > > > Reject the host from specifying a memory access descriptor offset
> > > > that is different than the size of the memory region header.
> > > 
> > > And yet you decide that you want to enforce this assumption. I don't
> > > understand how you arrive to this conclusion.
> > > 
> > > Looking at the spec, it appears that the offset is *designed* to allow
> > > a gap between the header and the EMAD. Refusing to handle a it seems to be a
> > > violation of the spec.
> > > 
> > > What am I missing?
> > 
> > While the spec allows the gap to be variable (since version 1.1), the
> > arm ff-a driver places it at a fixed position in:
> > ffa_mem_region_additional_setup() 
> > https://elixir.bootlin.com/linux/v7.0/source/drivers/firmware/arm_ffa/driver.c#L671
> > 
> 

Hello Sudeep,

> That's just the current choice in the driver and can be changed in the future.
> 
> > and makes use of the same assumption in: ffa_mem_desc_offset().
> > https://elixir.bootlin.com/linux/v7.0/source/include/linux/arm_ffa.h#L448
> 
> Again this is just in the transmit path of the message the driver is
> constructing and hence it is a simple choice rather than wrong assumption.
>
> > The later one seems wrong IMO. because we should compute the offset
> > based on the value stored in ep_mem_offset and not adding it up with
> > sizeof(struct ffa_mem_region).
> > 
> 
> Sorry what am I missing as the driver is building these descriptors to
> send it across to SPMC, we are populating the field and it will be 0
> before it is initialised

Right, what I meant is having something like this since this function is not limited
to the driver scope and using it from other components would imply relying on the
assumption: 'ep_mem_offset == sizeof(struct ffa_mem_region)'. We will also have to validate
that the `ep_mem_offset` doesn't point outside of the mailbox designated buffer.

---
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 81e603839c4a..62d67dae8b70 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -445,7 +445,7 @@ ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
        if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(ffa_version))
                offset += offsetof(struct ffa_mem_region, ep_mem_offset);
        else
-               offset += sizeof(struct ffa_mem_region);
+               offset += buf->ep_mem_offset;
 
        return offset;
 }
---

And then move `ffa_mem_region_additional_setup` to be called earlier before `ffa_mem_desc_offset`:
(so that it can setup the value for ep_mem_offset)

---
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f2f94d4d533e..66de59c88aff 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -691,6 +691,8 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
        mem_region->flags = args->flags;
        mem_region->sender_id = drv_info->vm_id;
        mem_region->attributes = ffa_memory_attributes_get(func_id);
+
+       ffa_mem_region_additional_setup(drv_info->version, mem_region);
        composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
                                               drv_info->version);
 
@@ -708,7 +710,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
        }
        mem_region->handle = 0;
        mem_region->ep_count = args->nattrs;
-       ffa_mem_region_additional_setup(drv_info->version, mem_region);
---

> 
> > Maybe this should be the fix instead and not the one in pKVM ? What do
> > you think ?
> > 
> 
> Can you share the diff you have in mind to understand your concern better
> or are you referring to this patch itself.

Sure, please let me know if you think this is wrong. I might have misunderstood it. 

> 
> > The current implementation in pKVM makes use of the
> > ffa_mem_desc_offset() to validate the first EMAD. If a compromised host
> > places an EMAD at a different offset than sizeof(struct ffa_mem_region),
> > then pKVM will not validate that EMAD.
> >
> 
> Calling the host as compromised if it chooses a different offset seems bit
> of extreme here. I am no sure if I am missing to understand something here.
> 

Sorry for not explaining it, in pKVM model we don't trust the host kernel so we can assume that
everything that doesn't pass the hypervisor validation(in this case the ff-a memory transaction)
can be a potential attack that wants to compromise EL2.

> -- 
> Regards,
> Sudeep

Thanks,
Sebastian

