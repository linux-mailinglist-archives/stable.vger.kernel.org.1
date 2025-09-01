Return-Path: <stable+bounces-176803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2FB3DCDD
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5D664E1B09
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60B42FDC50;
	Mon,  1 Sep 2025 08:46:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1C2FDC39;
	Mon,  1 Sep 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716361; cv=none; b=Hu5Vu+vK/CBibGPsocqPUAVfoTq8CpXQisS6WzEHyvIS9mpm8t7rvIGPO6MnB26XEf1JDiNSZ0h4ZDa21vtBmlXPUJFjR5p4SsnaKtM445zzfCX3quJ9nNYP8lr0RU8bt+q3R9lUGBWTA4zzO9du2czo1Txxx+fhCWXnnwmBVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716361; c=relaxed/simple;
	bh=ZE9gLmPnDqTqk06S/cgXtqlrzst3rOGf71E5ISS59so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2mPf/FQde89G4D+xye4CQ+3T445naqbQX78orqb+jAJ0LDvluEGU4LTJD4C2ofdMsPgQ/ZemvDP+QFJr6BINhYTndLT9OPXlcNUefkwWeSOQOV23aV3zu4moj0Daq9cowDSMeWXNLBdnEIy3egKoBmtdLVZcaiK0q85aG0QIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5449432a9d7so937432e0c.3;
        Mon, 01 Sep 2025 01:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716359; x=1757321159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu55cGC1shfZahu4nJqSCls01RHf6IMjgCiuEU3j5YM=;
        b=ir/r4JS8JFxzgC5DZ+MHcVU4YvM/1aSka/Mvcjh6B0kuvJkyZX0D81mBQvb0n12XOB
         QScHyADdO+aYSooezLcXUzvHs23o1blnsYEfwUNrtGw2gEAHTGQzRrcIR2o2m6muJDeb
         olod6Qg/5CjH9R4PX5fuOuYued747AbXyvZ9VVitSkjE4aHgDr16dgmNJEiXLjlST8uE
         gfzLil1IPelkeXHkzCOleGxtrE8vJvAG9ciC07qOoN48qJ1BiHJhuCQxFn7T+o/2Z05U
         kkK92TLcxLzr1bN7tBhvJM2pXTWc9wIiA1FBhO4LJniO0e5Pr9c24MTmiR0FozB+Ygqb
         jpzA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbl8oDldURgXWDKDZD1Dbfu40j7CiO+GtIGq7tDGr2nxBllP8Q1+ST2Q+wBpu86I0vtGMbkOe@vger.kernel.org, AJvYcCXOkxMDaeO96ECV1jNvulqNshv43O+YIMrK4ce9esLxVAdne0mPMoC4Pwig1N4AKZCg1hmaQ3bVPza+YVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLE8nko/uR9Sc6y+kxr7lU+zmL3g2aUX+KBwfDOrcW1Vt5TZj
	XLKbP+4S6cPcUVMlB+xEyLhzmTY0X3RDrGHu7mXjy10uaZSA4OfUOgDMBNYci72q
X-Gm-Gg: ASbGncsZGJDKDsYICVI8cZVhJdGwI/1OerVLrJTlhoqxYy27PCBPzK72auzXtApFENC
	f+qGJirrWHZigTEL0dKZpoEODaeXIfFGaBCVwBheAy2OE/FdvWImYBNUlJ4QwoMpDzALeLufODA
	dvbJD3A8UzlEs9p2T8oLma9ah3O5WKSUFLCX9MFrpuY6acgzlR82pmrdP4mH90qQn1lIecBQ3Gx
	NTn/pBD+9waFuBM5P/LB+YIW4qDjR6YhD6dHVTMVSebO5m9PVmsDB5L/9LB8EoQ5v1LV8Yuq6zb
	O/AXxRk7JW1mPI2X/B/wh8wEhWYtQgDdrmjSo4HLWnplsGmXfovbE/txXcwI1oDgD0vHubGfza5
	RkUT9PFIHKJ2E3eYs+jjWFDcJ5heIjsmKAEq4b9ANC63dJgdr+4jSk3nCKyK8
X-Google-Smtp-Source: AGHT+IHcZooVWVxwyGkP6ZWTx7PBgQXv31nIkfFRr939eowCZSPGt/0Z3GKO89bjAXvjNvm/0bRKrQ==
X-Received: by 2002:a05:6122:3c95:b0:53c:6d68:1cd6 with SMTP id 71dfb90a1353d-544a02b3eccmr1879793e0c.16.1756716358948;
        Mon, 01 Sep 2025 01:45:58 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544912c7125sm4144274e0c.5.2025.09.01.01.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:45:58 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8972e215df9so114033241.1;
        Mon, 01 Sep 2025 01:45:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1VakGci/qNw87b6L9bC/w09d3o8HmVgvqeGk1yG9rRt+XARKG0UrD9IqscLGZaKI7qp1TWNOe/GlpTwA=@vger.kernel.org, AJvYcCX7kBQ/fkLBn6Gq2X/A95ZXKDSzB9sSQ5FNTaSnL3x4SKIcNIZmexH8WNPO8VQq/Pl1povAFTEu@vger.kernel.org
X-Received: by 2002:a05:6102:162c:b0:51f:66fc:53b4 with SMTP id
 ada2fe7eead31-52b1bd28af5mr1710735137.30.1756716358063; Mon, 01 Sep 2025
 01:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev> <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev> <d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org>
 <d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev> <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
 <4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org> <cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
In-Reply-To: <cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 10:45:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
X-Gm-Features: Ac12FXyV9h1utoTEvCbocGnG0IAN7uIVG3x3Lc95GJw3v48XpvYZ_YA0jVY7Wlc
Message-ID: <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: Lance Yang <lance.yang@linux.dev>
Cc: Finn Thain <fthain@linux-m68k.org>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
	peterz@infradead.org, stable@vger.kernel.org, will@kernel.org, 
	Lance Yang <ioworker0@gmail.com>, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Lance,

On Thu, 28 Aug 2025 at 04:05, Lance Yang <lance.yang@linux.dev> wrote:
> On 2025/8/28 07:43, Finn Thain wrote:
> > On Mon, 25 Aug 2025, Lance Yang wrote:
> >> Same here, using a global static variable instead of a local one. The
> >> result is consistently misaligned.
> >>
> >> ```
> >> #include <linux/module.h>
> >> #include <linux/init.h>
> >>
> >> static struct __attribute__((packed)) test_container {
> >>      char padding[49];
> >>      struct mutex io_lock;
> >> } cont;
> >>
> >> static int __init alignment_init(void)
> >> {
> >>      pr_info("Container base address      : %px\n", &cont);
> >>      pr_info("io_lock member address      : %px\n", &cont.io_lock);
> >>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);
> >>      return 0;
> >> }
> >>
> >> static void __exit alignment_exit(void)
> >> {
> >>      pr_info("Module unloaded\n");
> >> }
> >>
> >> module_init(alignment_init);
> >> module_exit(alignment_exit);
> >> MODULE_LICENSE("GPL");
> >> MODULE_AUTHOR("x");
> >> MODULE_DESCRIPTION("x");
> >> ```
> >>
> >> Result from dmesg:
> >>
> >> ```
> >> [Mon Aug 25 19:33:28 2025] Container base address      : ffffffffc28f0940
> >> [Mon Aug 25 19:33:28 2025] io_lock member address      : ffffffffc28f0971
> >> [Mon Aug 25 19:33:28 2025] io_lock address offset mod 4: 1
> >> ```
> >>
> >
> > FTR, I was able to reproduce that result (i.e. static storage):
> >
> > [    0.320000] Container base address      : 0055d9d0
> > [    0.320000] io_lock member address      : 0055da01
> > [    0.320000] io_lock address offset mod 4: 1
> >
> > I think the experiments you sent previously would have demonstrated the
> > same result, except for the unpredictable base address that you sensibly
> > logged in this version.
>
> Thanks for taking the time to reproduce it!
>
> This proves the problem can happen in practice (e.g., with packed structs),
> so we need to ignore the unaligned pointers on the architectures that don't
> trap for now.

Putting locks inside a packed struct is definitely a Very Bad Idea
and a No Go.  Packed structs are meant to describe memory data and
MMIO register layouts, and must not contain control data for critical
sections.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

