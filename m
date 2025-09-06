Return-Path: <stable+bounces-177945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC8B46BBA
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14844A03B47
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9255143756;
	Sat,  6 Sep 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izSGVuFA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028811E572F;
	Sat,  6 Sep 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158989; cv=none; b=qZjD2tj6M/GxLL4JrwfEEb/aDU0/J3CsupOblMKK/qOLmD/iWI+i0wzD0ojO2Paz9P2sLiikeklBjPBjUlk/Hqa5FVT0ETCmQ0eFJzmhn59/dV3JfjUTShE2VENie7FH0LL8J8p5bn6IsJliEzXRL0h/gq0n1REZatoL/0h1sMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158989; c=relaxed/simple;
	bh=nnHzgbiteTdO6Dn6POP6E6R5puQz4UN8iAYaejuBUyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opvFp8xZORYVUQIjdDH0kHpg67OBr/yjR2Qc2p0VLGLllEjhtzsWARfL4FwOYdmQDHEHYpD1f4LHbFBhAUShbz/gu3M+fr6aKbhvJQ95WnQRAatY1rHYEIEpVZQQV5J4vEUtHXkRFua67a7Z29W0UwQcXK763G7wynCYf6K7ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izSGVuFA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7d485173so19325185e9.0;
        Sat, 06 Sep 2025 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757158986; x=1757763786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX0gUaO70jVaoVg831tZPUyT1i7m1025KT/B0Hoa7H8=;
        b=izSGVuFAAGWSNCCDzqIHbHER5WCCLuMGaQQjeORdEHQ2yGvZ+nI7x7omXdPvyvbW9M
         rdUdVo0fPxG17rfpsckAqNNkDljLiavrGAT4cJeb1j++APqlVeZx1AQ0i0Z0SuxIIFZj
         vRjNgREoWUR3bDrE9fb3xh8P9YL9kaiE80kzCvVElgjrhtxq00OmK+KjNoLaqQTKTALF
         uP3cVugPKy2MpO7cuIM+QYDeurxWyhD6oVti0wQ9ThyulD8r0CB/81dQSwg5XHN5cpGr
         3uk0Qn+jQkdl2/2x8F1Umn0RnLS+WatIG99Jnrlve4GPau83xqPDUbGnqVPGeSZcZ3Lq
         s6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757158986; x=1757763786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX0gUaO70jVaoVg831tZPUyT1i7m1025KT/B0Hoa7H8=;
        b=ERZv92LWN6tNm5zhMk7Lpp6tTWlgAQOjMc21EDyxDmU1hQ8vLbepW2bVANqXgbr9sa
         I53cxTNJCtKVvP0AawwBU39ricnGCrTKPD8ArsOXGOvgLvbET2BjifVjZxIfATch1WqY
         fP5cB7iYHrhC2/lKK2n4w6wH4O8w7fP6BfFhEHabKSBDbPCfYndRKrybF5s1Gbh6WYRO
         lQqQ2hp/QKXHw7jXTLdqxwg9CBwXI4GcRH3g0AcnDZIthZnk2LusB/5KmbBHM4OvGGVU
         ytqcaWanl+0CBYGVfb4lILPYCJotqaMSat3EDfgBoeMMb1RQh/d5w5noBTEInZ9kIC/v
         0tFA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q+d3LgNmJFdOgTrsfx2EMrovaCjHi0Wvp8jgqNduXdOMhN9M7Jjhemvjk6c7qLsRwcZEAa30GoW/hZs=@vger.kernel.org, AJvYcCXHtOFSeID7E63N6MrwcpBgnI+rGdk3L8dycHzawfGExbnf8u0QRHoBUA3BCorNwY85eQrlF0Xu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvku9FcFOu/37tCuj9A62oT7/g8+rEZMMvfv35dlp7YrTlrWzW
	qF06fLwUWLz/QH63BwYiFPCpVqt1/Wjuy2D6m/6zxPMprYYkecWIByy9
X-Gm-Gg: ASbGncuIN8IwKZmJuBBgorDtp2ERViUXCfuCNgesRcmMw6D0j1W77wHKv6979o65ixo
	XdWfa6cvcbJJXFJBZ/SNZx7wRks5C0grbwLrz5UV68/e4up9wVmWjiaJzgUVeIhUP8k07Z6azAh
	FTD4VzhIkoyldzrmQZQoFI41ql6NFjOqXF4ZJV/xkvw4tvvTK0q0fLvW+lfXynY9mpiCsX+5Gkm
	KxHHD2tvJtIKvqSay+mdyGrDDWxuXZ3ZdmmVBQAxiaq0dgztr0k/QsiCR4eKRuOAueTnSIvLXF3
	R3jT2MC5iZN0NuyXGhMchqLVbhFpW2WInt7FtvZ/qzzb8VmAVHIaiLfPgN+uM93BJ2502NMrcl/
	R3tZ2TCqFmXcdYr1R6FjUpeLPH3epHA/LPTRaGJfyahMhzHZOjiNaD/uZZqL6Y2TW4wjkRyNmbN
	c=
X-Google-Smtp-Source: AGHT+IGQxryV+OqAci4zzJWd4jBsJHSl1Za8Pl683cpc6xoQVU8fxwCG7Jv66hj2eCX32tlAbKw3ig==
X-Received: by 2002:a05:600c:358a:b0:45b:9322:43fc with SMTP id 5b1f17b1804b1-45ddded6b98mr14323965e9.29.1757158985919;
        Sat, 06 Sep 2025 04:43:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm61063435e9.7.2025.09.06.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 04:43:05 -0700 (PDT)
Date: Sat, 6 Sep 2025 12:43:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lance Yang <lance.yang@linux.dev>, Finn Thain <fthain@linux-m68k.org>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, oak@helsinkinet.fi, peterz@infradead.org,
 stable@vger.kernel.org, will@kernel.org, Lance Yang <ioworker0@gmail.com>,
 linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250906124304.6dc17f1f@pumpkin>
In-Reply-To: <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
	<20250825032743.80641-1-ioworker0@gmail.com>
	<c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
	<96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
	<5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
	<4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
	<d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org>
	<d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev>
	<30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
	<4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org>
	<cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
	<CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 10:45:46 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Lance,
> 
> On Thu, 28 Aug 2025 at 04:05, Lance Yang <lance.yang@linux.dev> wrote:
> > On 2025/8/28 07:43, Finn Thain wrote:  
> > > On Mon, 25 Aug 2025, Lance Yang wrote:  
> > >> Same here, using a global static variable instead of a local one. The
> > >> result is consistently misaligned.
> > >>
> > >> ```
> > >> #include <linux/module.h>
> > >> #include <linux/init.h>
> > >>
> > >> static struct __attribute__((packed)) test_container {
> > >>      char padding[49];
> > >>      struct mutex io_lock;
> > >> } cont;
> > >>
> > >> static int __init alignment_init(void)
> > >> {
> > >>      pr_info("Container base address      : %px\n", &cont);
> > >>      pr_info("io_lock member address      : %px\n", &cont.io_lock);
> > >>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
> > >>      return 0;
> > >> }
> > >>
> > >> static void __exit alignment_exit(void)
> > >> {
> > >>      pr_info("Module unloaded\n");
> > >> }
> > >>
> > >> module_init(alignment_init);
> > >> module_exit(alignment_exit);
> > >> MODULE_LICENSE("GPL");
> > >> MODULE_AUTHOR("x");
> > >> MODULE_DESCRIPTION("x");
> > >> ```
> > >>
> > >> Result from dmesg:
> > >>
> > >> ```
> > >> [Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
> > >> [Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
> > >> [Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
> > >> ```
> > >>  
> > >
> > > FTR, I was able to reproduce that result (i.e. static storage):
> > >
> > > [    0.320000] Container base address      : 0055d9d0
> > > [    0.320000] io_lock member address      : 0055da01
> > > [    0.320000] io_lock address offset mod 4: 1
> > >
> > > I think the experiments you sent previously would have demonstrated the
> > > same result, except for the unpredictable base address that you sensibly
> > > logged in this version.  
> >
> > Thanks for taking the time to reproduce it!
> >
> > This proves the problem can happen in practice (e.g., with packed structs),
> > so we need to ignore the unaligned pointers on the architectures that don't
> > trap for now.  
> 
> Putting locks inside a packed struct is definitely a Very Bad Idea
> and a No Go.  Packed structs are meant to describe memory data and
> MMIO register layouts, and must not contain control data for critical
> sections.

Even for MMIO register layouts you don't (usually) want 'packed'.
You may need to add explicit padding, and an 'error if padded' attribute
you be useful.
Sometimes you have (eg) a 64bit item on a 32bit boundary, marking the
member 'packed' will remove the gap before it - usually what is wanted.

In reality pretty much nothing should be 'packed'.

	David.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


