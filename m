Return-Path: <stable+bounces-172778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314CB3361B
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 08:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1B4805D4
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7E1FF7C7;
	Mon, 25 Aug 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdur1+Rh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B828F4;
	Mon, 25 Aug 2025 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101761; cv=none; b=qm8oOc2xQjYaL7phmaXirsVnYGuad3T+/KYw2Q1LPoAonJxEK4YjhDRgrpl/zdKsWAeW8AWKt6o0lSXVuHByYEL8/L23J8eIDB/lgWPRRN12hpWxWlnhECzc/USYvEkN7m93LTDr4YW7Tr0JRG1KAk6Z+Y97qGpAlJfY3By8B+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101761; c=relaxed/simple;
	bh=Q8hj22B2MpR2JFzyBxlgxl1D95+tk574OJ1xEorYG0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaG+Sn6MrHbKhtSiJ2cnaN2TQa4xOBPRgfeLH/4dQgy9UdsshSiWtqpkOIPtcM5ePWYXApNZBVuz7xwGvEEvrpDvZarOinJ55Db/EKCB960IHRAkQx1O9iXKBNvWMwvfV/lb9QPWCq0+tFj3i7PXYqLwceZTnedUDa5AkxWGG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdur1+Rh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so20770985e9.0;
        Sun, 24 Aug 2025 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101758; x=1756706558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DyuRX2zEK/K9xsQep6iSkKr0C42JRzdyda0+bFIm3s=;
        b=Vdur1+RhS8SeqRrstYn/deq/2RXEjAEPnuZnGt1lu9+29hPsTgehasBWvlwa3kL+hm
         Lna3LaI4xBo3v6mF2e5WYAVQTKr45Gn0Sn4tE8agfnYdNIyEM7PltIr+0KgknHCtSF+R
         S79rRgBTR0AXgxR7xbLO27mK46Oi6CTII99Y4AxEsFhvQoGF55Z4no3q97uujpVstmwR
         wIHUcMHAsQE3LOj/hwAoe4GffAAOKquVF/ZJCHhWpzHq+dcqB90XQKK1Bymx1cw8bCYV
         54pfXzDFnQAJ+ZMjSM0/oen/uYo4yF6RjmxQ9F3Hw/yLyGb0IcxQ+COgpKTlKXaNXsCk
         hIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101758; x=1756706558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DyuRX2zEK/K9xsQep6iSkKr0C42JRzdyda0+bFIm3s=;
        b=UDJf/ZcF/rn0Tmoby9hFm26H/yhsdjLJ3hz1bslpA6im+QqwJIYQJe5NraptsHKjQQ
         DLglVJr6VsUuIFC6fkaC6PswKyXm36BJCGH7APZ/MkFAKRjEDehEDRXxlQfnl1bz3PRb
         28sO2lOCI6QCwJ8nl8SdKWnDfwMmtAlsZ743KIF7vE1rTIa0VJyxzUsGz7PzR+y8CC+N
         h7/t1C4N6EnXxJIw/zC5MiXObXEOcGMpu8L+jb69w7DTC+b2rk3Uibm/ZEMbvh07ddHG
         Ef1ElweUVYln6peXPKbNPFfG9hkS6a5ZRgiWgU34uG+g/38loECvn9XfhdxCYUu9T3nG
         sWRA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQ+6zV1ueklpOlabzUkvP/U6X+szXOhmwGwhzlHwU5T0pkiV+O5mi/EL8JvKcaEK/ecolIsY=@vger.kernel.org, AJvYcCXLzhIJUq1xMHfYVCiY71OQhlOlWw0CiRPYAnQ3B8pH0EBMoYduPpyGN2wpuKy1T7vsIBpcG0UA@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0eP2Nr9Q7iO/qQpYWJHCMb9iQ46s4eQhAl2wzm/B6UdQffcI
	E/+Ot4sRmFFlm0tJQAIsgPO3yptJ1itV5SZJ/Ha+ZSQU6iORKNqCG99wzUbvTCEY
X-Gm-Gg: ASbGnctPxy+ncjlFd5rCoer9xI2AoUVV9QfgMeCCUw+fORZ/vaogB0DO/cRw9OHhanR
	Am6I42Czs46IiHQaqCO1JqRMoACL+NVXr1n490u5gw8m6Phh1jmM7J5HQWr3U8x1II/YfMT4/o+
	cHqdoeJL63pPkaQHglL2/+gU8QWIqukQlpntO1Wh48DCwQbi9Az3q7cL1O9Sa9Uh8NZYbOsoqdJ
	fnIGNyM4zF9FF3cTdkUgeE08b3ylJsUFEe+WH5f/+MPcN/Vnmvy2y6DoDfv/JGq4xgomaxYf+QR
	xcjJ7ZUPkLDayPeTz6igMhZ8QrScQzYwqzOfwrekJrnNmmasF/9hccLtmuCgmD5mlLkwOBl+rm5
	TWGAQFo8TqlBjU4RQ+5Mw3/Y8iTihVfAQ2gw=
X-Google-Smtp-Source: AGHT+IGNTe6zPGTVY8MUfMP/Fkn+/GW7mAVSeut+h3YojmOGNkurifYNNXvSOJwskSim/u4d8P6+2w==
X-Received: by 2002:a05:600c:4e8f:b0:459:e370:d065 with SMTP id 5b1f17b1804b1-45b5179f623mr82250875e9.15.1756101758296;
        Sun, 24 Aug 2025 23:02:38 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5744e9b1sm93229695e9.11.2025.08.24.23.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:02:37 -0700 (PDT)
Date: Mon, 25 Aug 2025 08:02:29 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Brett Sheffield <brett@librecast.net>,
	Brett A C Sheffield <bacs@librecast.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <20250825060229-oscmaes92@gmail.com>
References: <20250822165231.4353-4-bacs@librecast.net>
 <20250822183250.2a9cb92c@kernel.org>
 <aKmzB57MKbpXh-_Z@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKmzB57MKbpXh-_Z@karahi.gladserv.com>

On Sat, Aug 23, 2025 at 02:24:39PM +0200, Brett Sheffield wrote:
> On 2025-08-22 18:32, Jakub Kicinski wrote:
> > Thanks for bisecting and fixing!
> > 
> > > The broadcast_pmtu.sh selftest provided with the original patch still
> > > passes with this patch applied.
> > 
> > Hm, yes, AFACT we're losing PMTU discovery but perhaps original commit
> > wasn't concerned with that. Hopefully Oscar can comment.
> 
> Indeed. This takes it back to the previous behaviour.
> 
> > On Fri, 22 Aug 2025 16:50:51 +0000 Brett A C Sheffield wrote:
> > > +		if (type == RTN_BROADCAST) {
> > > +			/* ensure MTU value for broadcast routes is retained */
> > > +			ip_dst_init_metrics(&rth->dst, res->fi->fib_metrics);
> > 
> > You need to check if res->fi is actually set before using it
> 
> Ah, yes.  Fixed.
> 
> > Could you add a selftest / test case for the scenario we broke?
> > selftests can be in C / bash / Python. If bash hopefully socat
> > can be used to repro, cause it looks like wakeonlan is not very
> > widely packaged.
> 
> Self-test added using socat as requested. If you want this wrapped in namespaces
> etc. let me know. I started doing that, but decided a simpler test without
> requiring root was better and cleaner.
> 
> Thanks for the review Jakub.  v2 patches sent.
> 
> Cheers,
> 
> 
> Brett
> -- 
> Brett Sheffield (he/him)
> Librecast - Decentralising the Internet with Multicast
> https://librecast.net/
> https://blog.brettsheffield.com/

Replying to you both.

I missed this regression when I tested the blamed commit. Glad this surfaced quickly.

Just to clarify, the issue isn't that the destination address is "mangled".
The removal of fi = NULL inadvertently causes a gateway to be assigned to
local broadcast packets (see the call to rt_set_nexthop), which results in the
observed regression. __mkroute_output is still correct for directed broadcast packets
due to them having their own routes in the local table. The regression can easily be
fixed by setting the fib info to NULL for lbcast packets.

The submitted selftest only fails if a default gateway is configured, but does not
set one up. I'll submit my own patches to fix the regression and improve the
selftest shortly.

Oscar

