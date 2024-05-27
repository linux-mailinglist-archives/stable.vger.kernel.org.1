Return-Path: <stable+bounces-46307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7928D0105
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788F91F245AD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF215DBC1;
	Mon, 27 May 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V80RB05h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jtOYQRC/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFA1E868;
	Mon, 27 May 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815670; cv=none; b=oeeYnr/dK/ovKG2DRaZH6FxWBuyuP8gL9nYv0q1VQpC03jo9tRowbTU1DnUQd3hCMJlSpilGm3miviGB1wfJy0BL63rjG6/DN+BlTibovXOsyM71ivLh6jP73LprugU2G9uPQq1Qsz6VIrCX+E8ldLl1mYzQImulOzCVEwsmlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815670; c=relaxed/simple;
	bh=WBeKzcT7QA+/fnXDXCYwSNn0meQBV2vn6l/XT5ZZpA0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=I3D5BREaN2ZR9UfpEtbGoFfcuBTtJXI0Y6jST5HmWywtmbKC+7KIaeQHP+JDevmSLB3n5TFLSdeDvPDPFbeFk+9cvB3BNlO3nsev9buDuocryw2EWyL4Pq6KQtZdEb6CoiiACPZEGM+bRG3yYr7VeZ0jvzE4czib9PPezW6fTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V80RB05h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jtOYQRC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716815667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xxElKbcPssOZBHxdC0FuLluzRnaZ3UGv1xVFtotYrBE=;
	b=V80RB05hjUNqEEzn6JhW7xc7+8gSWxKv9i9A9HJU9ZySeQri124ZZBoGVaL5RmBogjaQpX
	65WjB7+UJaK/dr75fpkQcuONFVZ2+nI3NvJ+2WAk392GLt5zHVJxxkHijMtSSO5otac4bZ
	AMME10WCzK0NxoBR5B+JYQjbkGgGkGQTvuWGQg8JcB1BFAavHvpi4oDHjQTdvLRPLeR7HE
	Z4SJMgpdew+DUwSXA0zKdrEkAedqv1t769Eyn1qpbtnjdD/AIuZeUSN9w5kGtSCntDZhU2
	RXDMuzu0POfT9+BnKv/rZbr40fCcJe+bxW4iMkefgKwrFfKarT+x712+pkPb7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716815667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xxElKbcPssOZBHxdC0FuLluzRnaZ3UGv1xVFtotYrBE=;
	b=jtOYQRC/13Ol3nCO2Koaj9xvH+YrhVuRSyKPNHuyHVm4SwMHpTsChefXpEqQwH70mSw6GH
	WKEOhzVOOfMh33DA==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <fd3f73dc-a86f-4bcf-9c60-43556a21eb42@googlemail.com>
Date: Mon, 27 May 2024 15:14:26 +0200
Message-ID: <877cffcs7h.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 09:29, Peter Schneider wrote:
> This is coming from an older server machine: 2-socket Ivy Bridge Xeon E5-2697 v2 (24C/48T) 
> in an Asus Z9PE-D16/2L motherboard (Intel C-602A chipset); BIOS patched to the latest 
> available from Asus. All memory slots occupied, so 256 GB RAM in total.
>
>  From a "good boot", e.g. kernel 6.8.11, dmesg output looks like this:
>
> [    1.823797] smpboot: x86: Booting SMP configuration:
> [    1.823799] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> [    1.827514] .... node  #1, CPUs:   #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> [    0.011462] smpboot: CPU 12 Converting physical 0 to logical die 1
>
> [    1.875532] .... node  #0, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> [    1.882453] .... node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47
> [    1.887532] MDS CPU bug present and SMT on, data leak possible. See 
> https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    1.933640] smp: Brought up 2 nodes, 48 CPUs
> [    1.933640] smpboot: Max logical packages: 2
> [    1.933640] smpboot: Total of 48 processors activated (259199.61 BogoMIPS)
>
>
>  From a "bad" boot, e.g. kernel 6.9.2, dmesg output has these messages in it:
>
> [    1.785937] smpboot: x86: Booting SMP configuration:
> [    1.785939] .... node  #0, CPUs:        #4
> [    1.786215] .... node  #1, CPUs:   #12 #16

Yuck. That does not make any sense.

> [    1.797547] .... node  #0, CPUs:    #1  #2  #3  #5  #6  #7  #8  #9 #10 #11
> [    1.801858] .... node  #1, CPUs:   #13 #14 #15 #17 #18 #19 #20 #21 #22 #23
> [    1.804687] .... node  #0, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> [    1.810728] .... node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47

> However the machine boots, and except from these strange messages, I cannot detect any 
> other abnormal behaviour. It is running ~15 QEMU/KVM virtual machines just fine. Because 
> these messages look unusual and a bit scary though, I have bisected the issue, to be able 
> to report it here. The first bad commit I found is this one:

Ok. So as the machine is booting, can you please provide the output of:

 cat /sys/kernel/debug/x86/topo/cpus/*

on the 6.9 kernel and 

 cat /proc/cpuinfo

for both 6.8 and 6.9?

Thanks,

        tglx

