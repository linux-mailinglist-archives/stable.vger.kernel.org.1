Return-Path: <stable+bounces-247038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMfKNlLoBGqnQQIAu9opvQ
	(envelope-from <stable+bounces-247038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139253AD9A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE757300B9DB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6B1F2380;
	Wed, 13 May 2026 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw9Rsze0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E23955C7
	for <stable@vger.kernel.org>; Wed, 13 May 2026 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706512; cv=none; b=rTXoMWFUtNC9qmQFGFsUWXc0P8JMKYANCYaqrCECbS6x8miyodGdgt3nVCROApqo5cDEDH6C+obQnriVsXOtRRXSMekBlyxZCQu8rxs4/VETjP2CZ2Khe/BbygxalGpFmUWg1dzZm3x7lKKl7DzC70g9CTP4X7NYk9EWDvfDSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706512; c=relaxed/simple;
	bh=QTnfFdk6Ou6qx4/NP97q2rkM2PR+aFaKRRwo++mRCeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCBiGLLagCSVRKb2sQY3JgJSbq0MBd/1gL0i2hOkGiOCsKewzLcHo7/Vg1NdkQ0jIwqO9OEBoAWfDeAf3GXM2DKhSXY2ZM+y2PnWhjsJ2xqdTAA+5xtxjbo0Qwoq396FL/yDqqx1qOiPphToPnu4ibwuHUU32Pqfe6b0spXfGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw9Rsze0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44e5624c053so4088299f8f.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706507; x=1779311307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoCZ/nzaYrByUCIKabpsWTVqU7hdllfpMNoIhC860eM=;
        b=bw9Rsze0QKCdizARKcG4bkhj7dsmWVj9e6dEdw5nFsyZ2QCgy0epj2c14MN03DriUW
         TZC5dQpOS32vvtCd3gYJvJAhC9G2NK0/aF+FTaM6uq6S2BMZ4lK5470fDgDKnkDrz+r1
         xJzOpLx9gUHV/DOoos5BSqHY1yxWH1FJuvBVYFunXxRRlD60t05gbZUJU/1thEtknbQQ
         G14Ooyegv8gg13PkK6tvHMJaFkUpjJlBArOcX8/dsnGul9uEF4glTenqG/0rYHfrF6kt
         1eKzGXs791wtXl3sD2Cd3s5xN0d0cx4RWtab5svcwsVPuPCVSgd5/I/HJMlBTcdqKshE
         yL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706507; x=1779311307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoCZ/nzaYrByUCIKabpsWTVqU7hdllfpMNoIhC860eM=;
        b=pDIL9kUN1YDiusc3vBNLaOq9ZJPMH9P33wox3k2r5qR3kQtbltHXUXD9hHC2ie4eOY
         cGSUlsNy9N2QS91htOcvbosM0RdjbWd3Tt+uF+Cg1P5mS7MIftBPoYjAmms6zuljGYiZ
         PhC6yNsrikuG/YpmwSczoFCOE+AP/e7dvXZbri0dmJtCVzwSE0wwhJvABrbhkn/V3rbr
         NdtqYByA7PBYcgnbXQQCU6uDIXwokUjRgMmNcxGpIhscEmZuBfha435OFKqoUeSA4eaF
         oWWWCpjSS+35dDnoNrqqb/CrYOTBfub/7CI54bHSVhvvEKqpYklR6K9HZr8jhvJ1JXtP
         sH9A==
X-Forwarded-Encrypted: i=1; AFNElJ+B9NLtRbuspz9KfXGi95WRmTmUtDHbLr6BT2XxOC6kPpvxzvPyC0vc4oHBX9b7gwrfLDwpw1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJOJIksDPhj/qbvUizzmuHmgAuuILur+4gcdM31f6vqFbpCSz
	ap4JBqG+0u0jAWR0jxGtq8djyh1pjwB+5g4JQaFfU+G0dsvG6bgarXz5
X-Gm-Gg: Acq92OFbrFHkhLu9+p+p8EaariDcBmOI60NPQ29B2vLU42TZVlNy4PqkZubhsPnuF43
	nQ0xmijKMCOMSfmJaj3xzFknpXf8ett5Ah5jNurouKsCmhjFPZSzwd4yJ8PhBrKeDrrJwP2IS3L
	sLmy9Z2Gm2al3CVJO61RGptckEFWvzfQog84HUwpp86K5PIxrpWMSnDkGjrNewQ20rqwb/FDzsS
	wOZTEfG+ciU2Dpzp+muBCGjFnmkoV+MUTcCL7Nq/MmumxUJLLyaf3HwEOZCfwPoUMOhm5X6xFgk
	DL9kPFSLsFYrfdJTbOkVrYGpLJfO4ObCDsLoV+gz7vu5/utMyTuuHfUlrBxCxj5KPJpH8t5VBMo
	kgiu4n6gPpdz4LhoWpWOAqRsjtH59/wkMvJh7oFRuCzXBZDWQVG9KXiXItvSjsEKSSQ9QPeMGyK
	mG+iHlTFL2AU8LSBBb5a4l1WUJAThIp0ieLmPqx8oG32/StG90tfg6OZeWMQ5i
X-Received: by 2002:a05:6000:40da:b0:44f:d9f8:c0e7 with SMTP id ffacd0b85a97d-45c77e635bfmr7157222f8f.5.1778706507141;
        Wed, 13 May 2026 14:08:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm1312367f8f.24.2026.05.13.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:08:26 -0700 (PDT)
Date: Wed, 13 May 2026 22:08:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Anastasia Tishchenko <sv3iry@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Stefan Berger <stefanb@linux.ibm.com>, Ignat Korchagin <ignat@linux.win>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] crypto: ecc - Fix carry overflow in vli
 multiplication
Message-ID: <20260513220825.0d10d80f@pumpkin>
In-Reply-To: <20260513123948.842-1-qingfang.deng@linux.dev>
References: <20260513105741.55534-1-sv3iry@gmail.com>
	<20260513123948.842-1-qingfang.deng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8139253AD9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247038-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.ibm.com,linux.win,gondor.apana.org.au,davemloft.net,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

On Wed, 13 May 2026 20:39:48 +0800
Qingfang Deng <qingfang.deng@linux.dev> wrote:

> On Wed, 13 May 2026 at 13:57:40 +0300, Anastasia Tishchenko wrote:
> > diff --git a/crypto/ecc.c b/crypto/ecc.c
> > index 43b0def3a225..6eb4d97a5f0d 100644
> > --- a/crypto/ecc.c
> > +++ b/crypto/ecc.c
> > @@ -393,14 +393,26 @@ static uint128_t mul_64_64(u64 left, u64 right)
> >  	return result;
> >  }
> >  
> > -static uint128_t add_128_128(uint128_t a, uint128_t b)
> > +/* Calculate addition with overflow checking. Returns true on wrap-around,
> > + * false otherwise.
> > + */
> > +static bool check_add_128_128_overflow(uint128_t *result, uint128_t a,
> > +				       uint128_t b)
> >  {
> > -	uint128_t result;
> > +	bool carry;
> >  
> > -	result.m_low = a.m_low + b.m_low;
> > -	result.m_high = a.m_high + b.m_high + (result.m_low < a.m_low);
> > +	result->m_low = a.m_low + b.m_low;
> > +	carry = (result->m_low < a.m_low);
> >  
> > -	return result;
> > +	result->m_high = a.m_high + b.m_high + carry;  
> 
> If CONFIG_ARCH_SUPPORTS_INT128 is defined, you can convert them to
> "unsigned __int128" as done in mul_64_64(), and use check_add_overflow()
> to get the carry.

Can you guarantee the compiler generates 'constant time' code for
any of this?
If you care then relying on compiler support for anything that might
generate a conditional jump isn't a good idea.

Just writing 'bitwise' arithmetic doesn't mean the compiler won't
use branches.
Even if you don't get one today, someone else might get one tomorrow.
IIRC even on x86 'x += (a < b)' can generate a branch rather than the
obvious 'cmp a, b; adc $0, x', or the longer cmov or setc sequences.

You pretty much have to use asm for anything that isn't trivial arithmetic.

-- David

> 
> > +
> > +	/* Using constant-time bitwise arithmetic to prevent timing
> > +	 * side-channels.
> > +	 */
> > +	carry = (result->m_high < a.m_high) |
> > +		((result->m_high == a.m_high) & carry);
> > +
> > +	return carry;
> >  }
> >    
> 
> Regards,
> Qingfang
> 


