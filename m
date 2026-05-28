Return-Path: <stable+bounces-255223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKeEHmWeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE95F78E1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2C7E301482F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB413F6C2C;
	Thu, 28 May 2026 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc33oHFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAC34040F
	for <stable@vger.kernel.org>; Thu, 28 May 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998307; cv=none; b=iF7s6WXAqyhaSRHsbRkD2WchMjLO6R+V46ExSuAqpDOH2e0rheDSpg6SOodOWsFgTBrPDV6OTvP3ZbFEyE5MdDu3JEiABDcbPGLa6hbScGWqRxKTiNQ1nURe7WiIkyiLqbC2o7V4YSztZcmRtIfJcaAO4E0KYt+KloLSszR0NzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998307; c=relaxed/simple;
	bh=WTTIpQ7jQ/NRd9fEiQtD8QkYgfCehLlyMwVPbgSShLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxOh5pcCxDdHlUR0hBvk/Q9qOMp8R241IdvdD+RcQvoQUTR3OzhOv3eq0XRwR55P0aQSHUvYIKuVMcdoZ1J7QZj7YRRb25b5+hkhMjZkTHV9h3WRrvMcKpFMARiLzNu0i8kfKRq+BJuxO8pqPxXwnYBIVdrQKVZz7bWUh3w0OHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc33oHFL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso40586155e9.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779998304; x=1780603104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea+7QZi8CgY0HmyJuCQXCsEGJlQb2tlTWQbckXtNEc0=;
        b=Sc33oHFLCylxQ93c5qdbKt8LyUhpd646ZgF6BDcksrwu4z7ieIt16M94UGcwXSVcCw
         JDzarArm4suWHXq9GlWuWmPeSKG4NwIv5CW6HO4sDWYFu8cPoBpIHuW4pgcWhIkVods5
         RfnJmVrux/qQymYkabi6HMAw33T8APN/yS0kNPuDzqfxC/c5UuqiK8SfBCEgu+2l4XdX
         3fXaa/SyO3FJSYVkxaMIvZY4DLt4vdc+6ijBx/qEcjICScC08CrmXf9FRWod+nD0lrSm
         DIYsOZSKUIoxynqdEdFBPRcId2Ci10IRdX5sW5r/nyTai6U6Q7pKDqYZoAka4LtZ1xYn
         3vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779998304; x=1780603104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ea+7QZi8CgY0HmyJuCQXCsEGJlQb2tlTWQbckXtNEc0=;
        b=SftQKDTsBrESC0noD6+cA2v6cokGNvctlglfrvdTV3zHGpQz8Wk+YQhXLPsX7x9R1g
         TEs25wKr5EGTeJd1KEGhr2WtGUaNUKZrWeztkx8yBdGY1L+pjEdP1etv52dSdU/luQjX
         tWV3bVd9866RhnvwLR8lxIozIBVu0Lx+4jtrthBWpCt/oiKr6H7fMsgPwB6Ltk1S/5dv
         lZUjorfgH3geot97iB0koX1q0eOfQ6zXK2Qa7HZuHqTaGu/8lT2/hDl9d3rTKAJVRtBH
         bj3dowCjNTKSqeqW930qPoZ7M2bbCfQb/XAvkK+aZcSlnizSMl/Bje6HO9mHjm2Rk8NW
         iUiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jRF9VAaldDIMBwfVYVp6gO2zbWgcy0JnCwnmjawJGaT2+1aFd10aqLlad0KDX22Sd9SWhezk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Us2EHOkwvSW4YYM4UqD6FL2tdrQIRahQsu75eXtdcUIGsdKC
	Q0stm+2eFGUkWLGthc8PYvGRE3lvT8dv88a5ZiGSBIM7BxbRSvhKqGAd
X-Gm-Gg: Acq92OG9VIPB+Tb8ocMOCXpttWEaIiTA7sSlRomGOzrFHgIAb8T36qwvPaZpduV20A5
	RRV4Pqm/R5JFKD5GlpcDPmTpeIy3rj8rWt3pC8ZDFKhN0r5kx0KeYBj7M300Od2WggLzw5v0g4J
	8V73fAtmTtWD7Zen4isENzwWa12yB0Y3+PQBhEoTZ3GrWu5YeujYG80zD1Inef156FW3gBpB6ij
	1ijGwjNVE8TCrjh7c8ZWXa+VKUZkMaD24rMBDXcVllBtnSOO69lwl8wJVxSmq/otyD3rrixH95O
	rmyDw9dhlHgIlBY9bZKALWQY4s7Qga7A5pn1M/bmWHx8jarTJ4EV1lbOkb02+sJ2p764Y22t0jg
	6Ad95+0P5kUIFWVdpzjNI90jfviXJw8rGIz76tPj+hEejPiwqdXYm43ARN9a9qaEdfmIqgnVZ0H
	p4+YzNJa2KP7FNGs3dhzBeZEFFZ77Hr3baYUZ2Ic3uv8DR3Hq/GcaM4RwTtcU9AINj/Ew0FVeXR
	uHXGTnAJQ==
X-Received: by 2002:a05:600d:8496:20b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-4909bfcc3bcmr676545e9.19.1779998303798;
        Thu, 28 May 2026 12:58:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49091d57c0dsm93170965e9.0.2026.05.28.12.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:58:23 -0700 (PDT)
Date: Thu, 28 May 2026 20:58:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
 <kai.huang@intel.com>, Sean Christopherson <seanjc@google.com>, Borys
 Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Message-ID: <20260528205822.26840d6e@pumpkin>
In-Reply-To: <ahgUBLjBRGhxULu3@thinkstation>
References: <20260527120544.2903923-1-kas@kernel.org>
	<20260527120544.2903923-3-kas@kernel.org>
	<5ed6121c-314e-4cf0-9a11-b0661c87c694@intel.com>
	<ahgUBLjBRGhxULu3@thinkstation>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255223-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48DE95F78E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 11:14:38 +0100
Kiryl Shutsemau <kas@kernel.org> wrote:

> On Wed, May 27, 2026 at 10:45:28AM -0700, Dave Hansen wrote:
> > On 5/27/26 05:05, Kiryl Shutsemau (Meta) wrote:
> > ...  
> > > -	/* Update part of the register affected by the emulated instruction */
> > > -	regs->ax &= ~mask;
> > > +	/*
> > > +	 * IN writes the result into a sub-register of RAX. Only the
> > > +	 * 32-bit form zero-extends; the smaller forms leave the upper
> > > +	 * bits untouched:
> > > +	 *
> > > +	 *   insn  dest  size  bits written     bits preserved
> > > +	 *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
> > > +	 *   inw   AX    2     RAX[15: 0]       RAX[63:16]
> > > +	 *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
> > > +	 *
> > > +	 * 'mask' only covers the low 'size' bytes, which is exactly the
> > > +	 * range affected for size 1 and 2. For size 4 the write also
> > > +	 * clears RAX[63:32], so widen the clear-mask.
> > > +	 */
> > > +	if (size == 4)
> > > +		regs->ax = 0;
> > > +	else
> > > +		regs->ax &= ~mask;
> > > +  
> > 
> > Is there any way we could do this with fewer comments and more code?
> > 
> > I mean, there's only three cases. Why have;
> > 
> > 	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
> > 
> > When there are only 3 possible cases:
> > 
> > 	1 => 0xf
> > 	2 => 0xff
> > 	4 => 0xffff
> > 
> > and one of those cases needs a special case on top of it.
> > 
> > Maybe something like this?
> > 
> > 	/* Clear out part of RAX so part of args.r11 can be OR'd in: */
> > 	switch (size) {
> > 	case 1:
> > 		/* inb consumes lower 8 bits of r11: */
> > 		regs->ax &= ~GENMASK_ULL(7, 0);
> > 		args.r11 &=  GENMASK_ULL(7, 0);
> > 		break;
> > 	case 2:
> > 		/* inw consumes lower 16 bits of r11: */
> > 		regs->ax &= ~GENMASK_ULL(15, 0);
> > 		args.r11 &=  GENMASK_ULL(15, 0);
> > 		break;
> > 	case 4:
> > 		/* inl is weird and zeros the whole register: */
> > 		regs->ax &= ~GENMASK_ULL(63, 0);
> > 		/* But only consumes 32-bits from r11: */
> > 		args.r11 &=  GENMASK_ULL(31, 0);
> > 		break;
> > 	default:
> > 		/* Probable TDX module bug. Illegal in[bwl] size: */
> > 		WARN_ON_ONCE(1);
> > 		success = 0;
> > 	}
> > 
> > 	if (success)
> > 		regs->ax |= args.r11;
> > 
> > It might need a temporary variable for args.r11, but you get the point.
> > That's basically the data from the comment but written as code.  
> 
> I hate how verbose it is. All these GENMASK_ULL() make it hard to
> follow.
> 
> What about the patch below. Inspired by kvm's assign_register().
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 65119362f9a2..460b9fbabf14 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,8 +693,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  		.r13 = PORT_READ,
>  		.r14 = port,
>  	};
> -	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
> +	u32 val;
>  
>  	/*
>  	 * Emulate the I/O read via hypercall. More info about ABI can be found
> @@ -703,10 +703,33 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  	 */
>  	success = !__tdx_hypercall(&args);
>  
> -	/* Update part of the register affected by the emulated instruction */
> -	regs->ax &= ~mask;
>  	if (success)
> -		regs->ax |= args.r11 & mask;
> +		val = args.r11;
> +	else
> +		val = 0;
> +
> +	/*
> +	 * IN writes the result into a sub-register of RAX.
> +	 *
> +	 * Only the 32-bit form zero-extends; the smaller forms leave
> +	 * the upper bits untouched.
> +	 */
> +	switch (size) {
> +	case 1:
> +		*(u8 *)&regs->ax = (u8)val;
> +		break;
> +	case 2:
> +		*(u16 *)&regs->ax = (u16)val;
> +		break;
> +	case 4:
> +		/* zero-extended */
> +		regs->ax = val;
> +		break;
> +	default:
> +		/* Probable TDX module bug. Illegal in[bwl] size. */
> +		WARN_ON_ONCE(1);
> +		break;
> +	}

Just write it as normal arithmetic code:

	/* IN writes the result into a sub-register of RAX. */
	switch (size) {
	case 1:
		regs->ax = (regs->ax & ~0xfful) | (val & 0xff);
		break;
	case 2:
		regs->ax = (regs->ax & ~0xfffful) | (val & 0xffff);
		break;
	case 4:
	default:
		/* 32bit 'INB' will zero the high bits. */
		regs->ax = val
		break;
	}

Succinct, obvious and readable.

-- David


>  
>  	return success;
>  }


