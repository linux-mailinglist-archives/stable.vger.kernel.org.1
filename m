Return-Path: <stable+bounces-126695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58164A71514
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87B5173D10
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5A1C84DE;
	Wed, 26 Mar 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rf6cLOBm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0A1AE876
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985929; cv=none; b=BC2Fw3n8cUBGjlp7w2A6PZvLZ042KZ5bVevWOOS6AK7KgWo0imUgoLn2H0ImR2Px3r/QTw7feaogwH5zeozR4jxhhivzIwFccfSY+E+GTV8DTvQTYzAzVRE/C2FMe0f8bmWnpYOArRMbIXOiLCaNczU0GVc5qfXcvNO4Q+ppD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985929; c=relaxed/simple;
	bh=TeVLOGY3oC6jCtD+U4GHaV57vwWRjlfcCuYfEofJ1cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7P6ME54JUMRFwkKjuPOGJzum1t2D7/qDSAk4dNPh9U6uOCcqIpFUAjikCfMHHmNUI9p4y2YihvW4jb/gDqbujdhzwNFM3DSVAyhLMSXz9dNGzQWz0coF6K3+e1pxrrToi0asnaGi56my60rzpEcfeoPhoYWpmyhtq9a1lUUZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rf6cLOBm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so64407595e9.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 03:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742985926; x=1743590726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj9IC/ITgYzbYCPda8r17Blt5shGufVre2k2P1fl+Zg=;
        b=Rf6cLOBm2LT4kG7FUEtbHDMHqRpDu3hUHaVNqmEhDsHYclnqNzEZvb0b0HY1wv26h1
         6yy2GwKowcvXSgwc4xL/941kLdtbraL1AvOgIe5NhcZ7cxkiYxSa7onBlsRIHVGu24N1
         DywHjXvpO1oZX0tpiX90KIqbBT1hh/A3BtnjPWUxfNPXfdAcXpTxKdh9aiVL/lTYUWS9
         k6ONO/nXw5+sGIdQZXjQ1cXxJ0Y8Xm+LMAroGiIREy4qkbQ9LIokB0aeHUVsEnoj26vp
         NVJPf5TgLbR0suYhEngCWQetLaPHIPo26+ZoN8FQe/4da+0v0LaltsyD6nwVc/+JXrX8
         LcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742985926; x=1743590726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj9IC/ITgYzbYCPda8r17Blt5shGufVre2k2P1fl+Zg=;
        b=F39cGTAcPyGRB6h4kqYaD8f5+8voBY1PtBduuSW/JGyuvFZb8DDkgzC0/v2xPkyXvU
         8tLHa53nRjPhB8oKgB/kXFrg/kFGIT5HX5nh+PE+1TNwpUIVGHs7ZMYQee6zAYCAk08D
         w/ly5hD6F4e9VtqdFuaGOotLRJ5i9yq+yu4ofr7wom1aXfuQHofFw9FCpLsalxUzI+Dd
         DN1xNKS699cc43TjLP66VKTaTbHJPilIZbZqfJGEHT6rh5HBYiYqUVqMA3NpXjO0/Jn0
         ZdyOd+ti4g3xUPADvAXjcfSyGDYL/0Yq/HRyGrvdcTcKZjP3QUEDFAMLPdQhYMyUDSYM
         JnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrsprplAFPDD/zf1hjaYR7EF7XlPJJdb3g9t/dPllC1f8qWDtf3iKMKWfHWUZc5PDFg3oFx3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/K5kRDNBJ2JU85GLksw0G6tCacFUr/4SwO9yhRRdANBGoLARE
	an7CITa7WszbK3jksJ1Inm0ArzYyMA/J6uXbpYSbapjCcMjDd7lRFBqdWMO4DA==
X-Gm-Gg: ASbGncttQaJDA3CAVuUgcrX98hu1F5tkKh2r1cYPqB+neA1rvy15/kAo42slLa5OCiE
	HJKmyDIDBQldyt4cLDta5CLVejyHP3+JKP+pCkFPilZ+PjUKJjKvCBLpmbYCE+J9IbJqV+Zpumv
	eVq2J7mWtjrpOhi7hxZkWT3b2ydAEcw4NO8Bbo3mbeg8XafAnT04LDc6hliXR2dCM2hIrbQSW2D
	Cdwa/v/TUGYNfyglIBlBKVGGPqsouRhs1QJdQ0l12/5mrmtLoA0Yyg7EghGmBAynAgeKkVPJUI+
	o46YLRDt2yzduirf5UG7K4PspzafFcD0QfD1pS9lyUrHCLlZ2fJWaOLZUEmchcufsafmJVblkxH
	j4wk=
X-Google-Smtp-Source: AGHT+IFBLSf5Cc3mFyYZdvuynNJIpSKOy4KRKa6vJr8hwGbWkLycXjgd1M0s6yReqROa/HVWBrx5NA==
X-Received: by 2002:a05:600c:34cc:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43d5f8b9236mr144487305e9.3.1742985925530;
        Wed, 26 Mar 2025 03:45:25 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995611sm16697147f8f.15.2025.03.26.03.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:45:24 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:45:20 +0000
From: Keir Fraser <keirf@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mops: Do not dereference src reg for a set
 operation
Message-ID: <Z-PawJpGJRcSTMnc@google.com>
References: <20250326070255.2567981-1-keirf@google.com>
 <Z-PWZ98oNna6nVu1@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-PWZ98oNna6nVu1@J2N7QTR9R3>

On Wed, Mar 26, 2025 at 10:26:47AM +0000, Mark Rutland wrote:
> On Wed, Mar 26, 2025 at 07:02:55AM +0000, Keir Fraser wrote:
> > The register is not defined and reading it can result in a UBSAN
> > out-of-bounds array access error, specifically when the srcreg field
> > value is 31.
> 
> I'm assuming this is for a MOPS exception taken from a SET* sequence
> with XZR as the source?

Yes.

> It'd be nice to say that explicitly, as this is the only case where any
> of the src/dst/size fields in the ESR can be reported as 31. In all
> other cases where a CPY* or SET* instruction takes register 31 as an
> argument, the behaviour is CONSTRAINED UNPREDICTABLE and cannot generate
> a MOPS exception.

Okay, will do.

> Note that in ARM DDI 0487 L.a there's a bug where:
> 
> * The prose says that SET* taking XZR as a src is CONSTRAINED
>   UNPREDICTABLE, per K1.2.17.1.1 linked from C6.2.332.
> 
>   The title for the K1.2.17.1.1 is "Memory Copy and Memory Set CPY*",
>   which looks like an editing error.
> 
> * The pseudocode is explicit that the CONSTRAINED UNPREDICTABLE
>   behaviours differ for CPY* and SET* per J1.1.3.121
>   CheckCPYConstrainedUnpredictable() and J1.1.3.125
>   CheckSETConstrainedUnpredictable().
> 
> ... and I'll go file a ticket about that soon if someone doesn't beat me
> to it.
> 
> > Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> Looks like this should have:
> 
> Fixes: 2de451a329cf662b ("KVM: arm64: Add handler for MOPS exceptions")
> 
> Prior to that, the code in do_el0_mops() was benign as the use of
> pt_regs_read_reg() prevented the out-of-bounds access. It'd also be nice
> to note that in the commit message.

I will add this too. And Marc's reviewed-by. And re-send as v2. Thanks!

 Keir

> Mark.
> 
> > Signed-off-by: Keir Fraser <keirf@google.com>
> > ---
> >  arch/arm64/include/asm/traps.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> > index d780d1bd2eac..82cf1f879c61 100644
> > --- a/arch/arm64/include/asm/traps.h
> > +++ b/arch/arm64/include/asm/traps.h
> > @@ -109,10 +109,9 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
> >  	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
> >  	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
> >  	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
> > -	unsigned long dst, src, size;
> > +	unsigned long dst, size;
> >  
> >  	dst = regs->regs[dstreg];
> > -	src = regs->regs[srcreg];
> >  	size = regs->regs[sizereg];
> >  
> >  	/*
> > @@ -129,6 +128,7 @@ static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned lon
> >  		}
> >  	} else {
> >  		/* CPY* instruction */
> > +		unsigned long src = regs->regs[srcreg];
> >  		if (!(option_a ^ wrong_option)) {
> >  			/* Format is from Option B */
> >  			if (regs->pstate & PSR_N_BIT) {
> > -- 
> > 2.49.0.395.g12beb8f557-goog
> > 

