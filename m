Return-Path: <stable+bounces-172571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD39FB3282E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AAEAA2B29
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D5242D7A;
	Sat, 23 Aug 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCVULJdZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B081F099C;
	Sat, 23 Aug 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755944365; cv=none; b=jFUHq1NQHAvEZ+GMicSg5+/gsfxw0WPIOhn+blNkw9nIH1pEaEPbocwTDWDh2ycUQV5bYg5NKBZmE0De5bJ965I0U5AGU3hFMid+qudjVODjJMJUr5NuFD955DcQtubGRS3mkeu7y3k08M+51AtGMjyDNhNhpWDDJmLnt1DtsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755944365; c=relaxed/simple;
	bh=i3bNeq76DInU/44MB2DrYiy2xn3RltylrA2iTK5shkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGQs0Ih9pHIbsR1Z4F0W2Xgw6jAKkItEZto5xzWMajaZdHt50yJLKwBFTuLyosf+Bb7o0DASYQDsliCaW6Lz9zNZFu1YZZrsdK81EnKQqAmtcj/ie+YwuprZ1hUxwwaMHrh5ut7NV2Dft08GG0QtQz09OYoIXsXcd+ZJC8UAtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCVULJdZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24622df0d95so14331995ad.2;
        Sat, 23 Aug 2025 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755944363; x=1756549163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i3bNeq76DInU/44MB2DrYiy2xn3RltylrA2iTK5shkA=;
        b=RCVULJdZ+9McSa5PPpuCcOvVDkYcs/8KQYJ2NZIp8hL9AYPbTTZJTnQV2wy5qL0//N
         OR+tNe73bQ6REP5Dja2bwZisBh6Cd0YecB4aHrKsMqN8kku+4BquVDPtqR2vF+PrghwG
         Prg4+pnP92yysm8gaNQD6H7DjYW5a0vkKXhms7H1lAZ4zRf9NEBy7fPrARPh2z/UDraz
         4nfDZbYrDHXiBJuav5sBD4i0/2TEUYqsnNRlGXCbkCZE/9oWlUp+UDSbYGJylAJmq6cL
         l4mE8aVUrL/UKXY9gtvn8S5M5Fp8Vbkbmf2UBemTnzRGvufLdUpqh4IXQoUr37VVd/dU
         ITIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755944363; x=1756549163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3bNeq76DInU/44MB2DrYiy2xn3RltylrA2iTK5shkA=;
        b=Y56BtYclq30q34fZsZLBcgFoyIKEMoZxlRK0L5I7e1uac3pyYDuqx0+el03K7xehPH
         QT600ukfZC7sPQEjf4VxObQxcHVtAD+VHooRFuZoc/nFgh5cVT3rg3bUU1TMysfKvp4w
         Q0Vl3n42FMiXANzrff8LKo+Oel3ZIkNFj1Hv+rNDyAxTu5brFe8Hnvx5thk6JVnc27Ka
         n2c2JFmr1Q5kuNieJ9p7uSWdCCG7ywFLcbWMMrLwp7HiNJvl9Nj2IQ9mGi/LDNmvFHAI
         D/y/l4b9FWRTYea0wrPZ5PwXB2GGICqFCZaIQR0cr0PLxgDPjbn/jGu+JKsaMazmB1YO
         jKCw==
X-Forwarded-Encrypted: i=1; AJvYcCUqs6CPjJV0gqqed3wOsIh0tRkYPyYqzFv0+CfHC3LFTTJ/unXOrydrbug2j17+dyfuKKeAAz0V10fSBxA=@vger.kernel.org, AJvYcCVjr7QYZMel7MFcoOfOvwU0Pjqr7qynNxIcAdc7mqROfeavwURWvMiELUfdsXm7j8h+wC0INsf5@vger.kernel.org, AJvYcCWlk/ezp35UyhcWQuIbOiS63eODlcALmgj8hCPmYKeC8xWCWo46RNL9wFzmtyQQwRR1h42fjlHL@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIXx2xYh4pZG3m799bAprSjwbXWT8MXLvNht0oX94vLru1hWp
	EvpKc6gUtCeoZGfI5R3iWoSFThhZf2Vflzlxt/k+qzfQO8MmLF/4r+5s16fVmy5/YTb0nmbrDiX
	Y+o/kqHybgJXCZnF205F/bIUbcx/XMw==
X-Gm-Gg: ASbGnct3nytF0kuCHS7rq6uXsy9qHUOkxPVuRXLGgoL563J9CeOc16TAaoNYdQZkjcc
	0vWKBorSx83eEiyqwY4skQpwmJs5KOK3xhR+f7bWMmB9G4dUcL8znTZmii9ldrMksmN/SDmh3MR
	gs6UWClOOI2wuWXAKBThbLLr4mgTPsXWdSwIJg1cSSHTu2+A37rzbb4CRkZTE3JdAmB79A1RTiC
	Kalc/bhsAfjTtyyu658LjMZl4R6/4Cw56eRxcb8O2zhdb2JLmnVFHTMjwljC2gyEDVUQ1hoGvb/
	PQw02PbzciDmFa542l4=
X-Google-Smtp-Source: AGHT+IEYMFWj0FL0uCPdJzf97Uc8oUJXuFu5K/HGbgNgO7KK8RRwBHRJq1RL3WKhQC5RPuxOzDxLBceUqwQzmSM5qdY=
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id
 d9443c01a7336-2462ee8e8f4mr92525815ad.26.1755944363424; Sat, 23 Aug 2025
 03:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjTZvZkDr8N18ocZ8jNND_4DwKqr-PV4BBXB60+=WXPF3vn=Q@mail.gmail.com>
 <20250823020152.1651585-1-wangzijie1@honor.com>
In-Reply-To: <20250823020152.1651585-1-wangzijie1@honor.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sat, 23 Aug 2025 11:19:12 +0100
X-Gm-Features: Ac12FXykPxxFJofTeeBDuGRSjKfJOOEaaMqE6mhQGLLLKx4ljImdahcB8S89iAM
Message-ID: <CALjTZvYybts62hbLoHQyGm+xhZvT9QfUN39gbDbugF7Tr_++QA@mail.gmail.com>
Subject: Re: [REGRESSION, BISECTED] IPv6 RA is broken with Linux 6.12.42+
To: wangzijie <wangzijie1@honor.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	openwrt-devel@lists.openwrt.org, stable@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi, Wangzijie,


On Sat, 23 Aug 2025 at 03:01, wangzijie <wangzijie1@honor.com> wrote:
>
> Hi Rui,
> Thanks. I have submitted a patch and I think it can fix this.
> https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

I can confirm your patch fixes the IPv6 RA issue in OpenWrt. It's thus

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>


Kind regards,

Rui Salvaterra

