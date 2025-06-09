Return-Path: <stable+bounces-151997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1959AD193E
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D10B168DA4
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A3C281361;
	Mon,  9 Jun 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf9/6ci4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA11F4727;
	Mon,  9 Jun 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455276; cv=none; b=IdQT1Qo3UJBqKgxcWqZl5FzmZtIEV7G/UYcSEMHRXSldxFpIKDNKJIO/kAETatvQ7sVktVf0ud7/AdsYEBzxoFeCNxeaNUpSmKaLEcUrgdnzpJ/jdpcIU4PST/EUwmbLVMC/QaUAmV+XILVa36dW2v56D0Fz9QM+swB2ZGUt4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455276; c=relaxed/simple;
	bh=yE2+holMnj+pvDkpHX6iTuIHRO70HVZSRuO84atG99Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxmNyhLejzL+Pd+VeARRIUU3i3+NfZRPA6PdR0Su6bsjDett182YjQnIvZDjY2b4/sxSjT797XXJ3/t8pfraZymbcfok3lwg6iksvXQ7rK52Zo/qwbUb4C5v+jWE02/OCWqKhy/0HGWWEoiigEKUXYSUmW523bRYa/ZQyajd+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf9/6ci4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c336fcdaaso31997075ad.3;
        Mon, 09 Jun 2025 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749455275; x=1750060075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kY5E9GhMCxeYg4qZouwVn58CZ9Wsm2ox4St53MlOt1w=;
        b=Yf9/6ci4REYHJkBhuJumvWAs2POncJJSpxh+jkKwfM66RpQaywhbV6D4ezQyZYrzby
         VcJzZh+X2pmBZDhrHHzdVFEthMKSe1U5oc4BqKeDk9+OR8cIt4tdFAfPTIho5xgGrFyq
         x6RSnDdJDq4jbm6JYBzizY9qkcU1jXbtY+h4Y498pHkkJzNXQbF8IJ9XbIN1IlKydDss
         GA8A0515RotV5QAABjzjG/YbXe5/GP4r9dI7K6Ysw3tYube4tdG2/r42DBgVwxfFCSxD
         w/+37N8IDqkDOt+ahEjhGZIjKzJFLi2G0H8GK0/prySQi2hUfCQtA5mVtoafKzU2EYRN
         P1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455275; x=1750060075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kY5E9GhMCxeYg4qZouwVn58CZ9Wsm2ox4St53MlOt1w=;
        b=BpTdQg9tLJ7KsNxrqr6rP85G0PWosXPBhrwG5TVjuIZXZzPjUPr1jHV096oDQryXQg
         hJDgourK4U+Y2DY+8p9jbdMcGrg7ESKKU7bMYiGtX6kerg93b0dxEaTzpf2hbrPeeqMr
         yaOBZvs4/UJ/nJ5hPZM5+zrymu67AnRUQjCBNX+XPh7+ZIEEi6O6Y+haAXhpyrkBgTo5
         Evart2NB9wAFgsjemIN16ODQsZ1P0tDbwAckiN1XuHeOs8D9ThSi0YtQ8jXUUpjbCNnN
         z3dHJo3hTU+cDsXB8IrsTNUuWll+5QPeELYAWvgbv1/hy8soF45+ZWyfbcFRjZHLkHzL
         dYdA==
X-Forwarded-Encrypted: i=1; AJvYcCU2SB6S52+vGbHu34f9g9xSqctLQur3egQlGlgCSQDOE6NAS1PX/Nu/n9UocKzLrP9HWaKnu9DyOERXBkQ=@vger.kernel.org, AJvYcCV+gGPLXdXPaTW1c6Jay2UGVrIJvD0/XZTy1kElwTREjlxzUG7doRlUzioU+Z1yWxZFjcYuNGn9@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1p87U8hlJgKXd745GFyx8uh//RD+KRqFvv0FAbhaNWtb7ia0
	J3SgI62rR6hNLx37R1bNJR8atj8in6aW3TflR+aCi4AI9FWy4QO6ecfSX1aFEQ==
X-Gm-Gg: ASbGncudy+/P5S+ers193xvO5rwtLUqbk/wjNJ5RE9zri9/6zClejBXTsBe0RLrMile
	jLPpseVk2ejSHsluEjZwASmd/6XiDNYPwxymCtT+gN+CyWkNoUQobjRAE+4kLxo6UIwF6WFfWKa
	/MzjmdzYrcEXwM1IuKoM6UqJHvwADkf2IBAhCICr/U8Ee3XlnZpoxtMG63zUX4swjN3Y83mQZMr
	Fhwd0KbffgaXT2CSbokV0FYAqsnG+jDv/V2zc1Tb0k37CuSeKJ6hIYFZ9epcmdylBMK7SOBXvzW
	n5vfLFGmCJa3dKjYqz+j2b5FacJNBSmB3uazzu8qxIfjuaxgfYOCEsh1qcQtdWuoMjU=
X-Google-Smtp-Source: AGHT+IHGla7RcCc5QrwRK5NzP4Mp/GrpGFt+26Z3UKBM8alswk7MzBTuCO4YyLLqcf8HX8uRkw7JGw==
X-Received: by 2002:a17:903:188:b0:234:8c64:7885 with SMTP id d9443c01a7336-23601dd8ab7mr167350355ad.53.1749455274561;
        Mon, 09 Jun 2025 00:47:54 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:3f10:324:b9a8:3187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b12801esm5117320a91.29.2025.06.09.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:47:53 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:47:49 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again
Message-ID: <aEaRpf_sHip9wH3G@vaxr-BM6660-BM6360>
References: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>
 <aEL5SIIMxmnrzbDA@yury>
 <20250606162758-f8393c93-0510-4d95-a5f8-caaf065b227a@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606162758-f8393c93-0510-4d95-a5f8-caaf065b227a@linutronix.de>

On Fri, Jun 06, 2025 at 04:32:22PM +0200, Thomas Weißschuh wrote:
> On Fri, Jun 06, 2025 at 10:20:56AM -0400, Yury Norov wrote:
> > On Fri, Jun 06, 2025 at 10:23:57AM +0200, Thomas Weißschuh wrote:
> > > Commit 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > did not take in account that the usage of BITS_PER_LONG in __GENMASK() was
> > > changed to __BITS_PER_LONG for UAPI-safety in
> > > commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
> > > BITS_PER_LONG can not be used in UAPI headers as it derives from the kernel
> > > configuration and not from the current compiler invocation.
> > > When building compat userspace code or a compat vDSO its value will be
> > > incorrect.
> > > 
> > > Switch back to __BITS_PER_LONG.
> > > 
> > > Fixes: 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > 
> > Thanks Thomas. I applied it in bitmap-for-next. Is that issue critical
> > enough for you to send a pull request in -rc2?
> 
> I have some patches that depend on it. These will probably end up in linux-next
> soonish and would then break there.
> 
> So having it in -rc2 would be nice.
> 
> 
> Thanks

Hi Thomas,

Thanks for pointing out the problem, may I ask in what config would
cause "BITS_PER_LONG" to work incorrectly ?

I would love to test the difference between them and see what I can get,
thanks.

Best regards,
I Hsin Cheng


