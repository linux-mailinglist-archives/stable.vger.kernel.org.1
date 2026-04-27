Return-Path: <stable+bounces-241294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJXlKipL72lO/wAAu9opvQ
	(envelope-from <stable+bounces-241294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:40:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FA471DF9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF7023060328
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1030E0D4;
	Mon, 27 Apr 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkYYyZ9K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C130DECC
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289792; cv=none; b=hmUc03eAfNhN8X2K9mOdnNBZSz4XYjziCvCRCKoxCAizJJq00NSFU/2y1LPByGdOJ5F5LMwpivQ7uJHXtYN/xd1BQdVCxEyTk2hoZ47/ARcoF7YJc95EXwl2ukd93hZiqK9eANPrbvFlCZx/leSxEQQqveiMuaIt9DZ7S3Luick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289792; c=relaxed/simple;
	bh=zChRhxhXTe3rtLHF7cTVBBRIKAVNaXM/phPTRduFOmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3PQIhiqhLgt0fwQbG+1UNByZw7kwt+Hb3SJa1TLMpiH9s1lSuQDhMa+UdFWYxiUzUEjzlLZmPsLs3jx2pA87JbsIRxm9zRuU2gKKFOlrHfj4nXN3+IBv7rW27xut15RX+EqTFI/Kj381Wqv50zRM9wJQaVTVIxpUtpafaaJqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkYYyZ9K; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so890485e9.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777289789; x=1777894589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFQ7YWSxQTi8WSuVhErZPiSuizAww+UyP5IWNi9MsWE=;
        b=jkYYyZ9Kgb5wur7PN63WU0BruOD8dXQFrJwi1LMGPHxUErldTkquuoiBiaGwOgmr11
         FtqLOQyjzxbLprRZAfGesJjwf7sVJxRXm059qNQVWHe9ZsqVwe8ws3OZXO56rFYvabkE
         b1oct5BufbTkApOzdoa8HOkZHnQ/lRg+OanA0Z5g4wptpt8XtSqDWshUtJhtjiBkGjct
         1oMdwZ4hCucZ8tYS0ttinLjTnl7VwVKjvuBtpBeM7mKlnuuL5eYHqkvZC9NIvp8A1cbc
         RSxJsTKaRgue8iOkJQDFPi/xBtxEjYlNRVnFWsDAa7/tuqdsGRL2VttDoIaVZrl5hWwe
         maSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289789; x=1777894589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFQ7YWSxQTi8WSuVhErZPiSuizAww+UyP5IWNi9MsWE=;
        b=N8xYK36xKwbs6SHbFsN6kof6YxYOtl3VFOLcPH9mfgP3p3DzJlCoWTyeRHhCZPTnWY
         Dt3I5msPOB1POfo4yW3Ncp+dDyGQq++fXtaJVkCCJtD8fdJgQPn6ToqU/uLOM3/A9od3
         tiwt7WNFoezCFCbwK8X+svqaYzn6Va8LNhUEPf19QvVsLGgIiYwOGRQvth9qDlg8b9iM
         XR9FG2wmmnpDDtJ2EDXeZJ/FN5kSrdgXyGKq3rknXndWHjoU4pnbJhrSkEJJWtzbZQXT
         vm/eJDZ9kg1y5Vs5sEybHZ85DDeiGvXuN8I8cq8wU/NIMMvE01yEjFc7KzwvxP3g5LAA
         p6oA==
X-Forwarded-Encrypted: i=1; AFNElJ/jVJ5ZgCEZwmcBGUB1wUpzp8KLiydEMLs6Edv8mLtPzJQN7T0s1A4ldiQM7BmW5px6d47BVoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLr87zduVCJccKCWmmeFwxLaFq7B5VFuQOLat+dvcecyalYK1
	+bGZeMiNAGmSZVRp/y4KpV3qcvHsQboXdu9/KCBtjtjgZcgPswlk1/mf66jiYxHIeA==
X-Gm-Gg: AeBDieuZlWeN7aLNsOoDomC6UIoX+gkrX4RytYuxTtPkZfZ9RHWjnKxYIqj1cQ/z+xI
	1PmiDfaTzd/a4k9+zwueO8eIVLtbzSzib9x3D9foNqyo+Fi4fZ5BaEtYb7zb86k5ZBT9KWC2+Xi
	Pq9BC/JSo+yiGB96NTr6A1WWvNowQQwrPthciItdLzcFQw+Dl7sTjhS8B6q6vgYx1+tYp3rKK7r
	bYwg+861XrDbUXom/r9cNz6CNvIfXG3su/Efg/WaTx3niurwl7yZeqOuyRPY8thRGtJCtGwfW+7
	2YZPdKHiw/WxwZGsU3hd9iI8RcTijIHfi9v+75WWX/DqfRDa6+hTQ7U16ezRCegP0WEsks3Wz19
	D2r1JLsVeEw1rPNlAZ1/Alrszfe0Mtf2vnx350Cnxg5K9Z+snMQCfTiZNtULKl0fd8TPDKGudUM
	PoSykIcglpE1OR0VAj3HMCYyu3qi0GAT4nsGZaHRu5Hz6ZUBUVl0lAmqoAWJnha2incTPVDm1Cj
	aEfE02JLH52z6SHmXo=
X-Received: by 2002:a05:600c:35c7:b0:48a:5aa3:ac1e with SMTP id 5b1f17b1804b1-48a5aa3ade2mr8143875e9.3.1777289788273;
        Mon, 27 Apr 2026 04:36:28 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a575ad67asm400794425e9.2.2026.04.27.04.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:36:27 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:36:23 +0000
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
Message-ID: <ae9KN9nkOgDYJcGP@google.com>
References: <20260422102540.1433704-1-sebastianene@google.com>
 <86bjfb18v1.wl-maz@kernel.org>
 <aejOu98q1lEZoFfW@google.com>
 <20260422-jolly-curassow-of-amplitude-25fbaf@sudeepholla>
 <aenjvY5VJxFye52e@google.com>
 <20260423-just-mega-starfish-22309c@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-just-mega-starfish-22309c@sudeepholla>
X-Rspamd-Queue-Id: 099FA471DF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-241294-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 10:55:34AM +0100, Sudeep Holla wrote:
> On Thu, Apr 23, 2026 at 09:17:49AM +0000, Sebastian Ene wrote:
> > On Wed, Apr 22, 2026 at 08:29:06PM +0100, Sudeep Holla wrote:
> 
> [...]
> 
> > Hello Sudeep,
> > 
> > > That's just the current choice in the driver and can be changed in the future.
> > > 
> > > > and makes use of the same assumption in: ffa_mem_desc_offset().
> > > > https://elixir.bootlin.com/linux/v7.0/source/include/linux/arm_ffa.h#L448
> > > 
> > > Again this is just in the transmit path of the message the driver is
> > > constructing and hence it is a simple choice rather than wrong assumption.
> > >
> > > > The later one seems wrong IMO. because we should compute the offset
> > > > based on the value stored in ep_mem_offset and not adding it up with
> > > > sizeof(struct ffa_mem_region).
> > > > 
> > > 
> > > Sorry what am I missing as the driver is building these descriptors to
> > > send it across to SPMC, we are populating the field and it will be 0
> > > before it is initialised
> > 
> > Right, what I meant is having something like this since this function is not limited
> > to the driver scope and using it from other components would imply relying on the
> > assumption: 'ep_mem_offset == sizeof(struct ffa_mem_region)'. We will also have to validate
> > that the `ep_mem_offset` doesn't point outside of the mailbox designated buffer.
> > 
> 
> Sure, we can extend the function itself or add addition helper to get the
> functionality you are looking for the validation.
> 

Thanks, would it be ok to BUG_ON if the offset is out of range here ?
(we would probably have to pass the size of the buf as well in this
function)

> > ---
> > diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> > index 81e603839c4a..62d67dae8b70 100644
> > --- a/include/linux/arm_ffa.h
> > +++ b/include/linux/arm_ffa.h
> > @@ -445,7 +445,7 @@ ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
> >         if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(ffa_version))
> >                 offset += offsetof(struct ffa_mem_region, ep_mem_offset);
> >         else
> > -               offset += sizeof(struct ffa_mem_region);
> > +               offset += buf->ep_mem_offset;
> >
> >         return offset;
> >  }
> > ---
> > 
> > And then move `ffa_mem_region_additional_setup` to be called earlier before `ffa_mem_desc_offset`:
> > (so that it can setup the value for ep_mem_offset)
> > 
> > ---
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index f2f94d4d533e..66de59c88aff 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -691,6 +691,8 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
> >         mem_region->flags = args->flags;
> >         mem_region->sender_id = drv_info->vm_id;
> >         mem_region->attributes = ffa_memory_attributes_get(func_id);
> > +
> > +       ffa_mem_region_additional_setup(drv_info->version, mem_region);
> 
> Ah this could do the trick. I need to check if all the usages are covered
> though.
>

I looked a bit at the call paths and I think we can use it like this.
Please let me know if you found it differently. I would like to re-spin
another version of this patch.


> >         composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
> >                                                drv_info->version);
> >  
> > @@ -708,7 +710,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
> >         }
> >         mem_region->handle = 0;
> >         mem_region->ep_count = args->nattrs;
> > -       ffa_mem_region_additional_setup(drv_info->version, mem_region);
> > ---
> > 
> > > 
> > > > Maybe this should be the fix instead and not the one in pKVM ? What do
> > > > you think ?
> > > > 
> > > 
> > > Can you share the diff you have in mind to understand your concern better
> > > or are you referring to this patch itself.
> > 
> > Sure, please let me know if you think this is wrong. I might have misunderstood it. 
> > 
> 
> Nope, the patch helped to understand it quicker. Thanks for that.
> 
> > > 
> > > > The current implementation in pKVM makes use of the
> > > > ffa_mem_desc_offset() to validate the first EMAD. If a compromised host
> > > > places an EMAD at a different offset than sizeof(struct ffa_mem_region),
> > > > then pKVM will not validate that EMAD.
> > > >
> > > 
> > > Calling the host as compromised if it chooses a different offset seems bit
> > > of extreme here. I am no sure if I am missing to understand something here.
> > > 
> > 
> > Sorry for not explaining it, in pKVM model we don't trust the host kernel so
> > we can assume that everything that doesn't pass the hypervisor validation(in
> > this case the ff-a memory transaction) can be a potential attack that wants
> > to compromise EL2.
> > 
> 
> I am aware of the principle in general, but this example with different offset
> can't be assumed as comprised host if the offset + size is well within the
> Tx buffer size boundaries. That should be the way for you to cross check for
> any compromise IHMO.
>

I agree, it cannot be assumed as a compromised host it can be perferctly
normal with another driver that places it at a different offset; that's
why I suggested patching ffa_mem_desc_offset instead and doing the
ep_mem_offset validation there.

> -- 
> Regards,
> Sudeep

Thanks,
Sebastian

