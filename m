Return-Path: <stable+bounces-108027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBFA0647F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDD3A56AB
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C32010EE;
	Wed,  8 Jan 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="OvEVT7bO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000919AD8C
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361233; cv=none; b=rtPM+WF+ztnnYCR130b5vkCMNuPF6qSlF9bncwHQGIwqLffOWywwguMqX0wN/I3QKm0sDV3syYiAxQ2pFb+gDAm1XvT+Q6al2wvf5acA5U+7uZgkiJxoWEeSWUbKW3ouTmbMfbiGYeil/bLGSS7BOxcQUeB8RvEMpl5crHKQgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361233; c=relaxed/simple;
	bh=8XYY+fT/2EsiWml7NrJYk4QVDwJCFRViQqgP2kD7R3g=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=gOQhCkkx+O//u7J6k3bxmEfCXbsNo/0Fg9ZWZxqaR5r38tPEuh/tmsc7FxwE5fbJcPghlAlkNPqRoRZBvxdCQEbexebPPmwsHjDgxcEkMTpu8eWbSBRovZB6Jca1adUVZmoQ03NYtRDH3JJ6KM8+LpcUgCswMrDtCzIih01z6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=OvEVT7bO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216634dd574so353265ad.2
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 10:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1736361230; x=1736966030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6FJheiVMvYWbCZKeg+7lI1bloWoKQoRBO5Nx0WyBg0=;
        b=OvEVT7bOemg7BnzMi97zeqV6gKX92YLRYWJwrrFZ/GE5qujN09CI1H3v2rkg0ouraW
         TK/KSLM8FVuRt5T1Fm2V+/l64ZzHC55rAoxmd91OMONKI+Zf7odRjqGj2V2CJgCkwnb4
         9BgYarTCwCjqAVPLaF3XCmJuQn0NObpcu3EKjiaLMwwsWEf7s0dIVjvUrWXdnxwom0sC
         eyIQ6yLvKgTiG0yCAM9SFbofpTk2GuBGbWuTFkTrrcJtQHW148YIvvPPZCGIkn6gBXdU
         RMi/KgBH//AaDwaaxCl/hDWmiM5LiuUjuethiV8mk29Ycf453G7tiAhMLg+36E/QALMo
         uL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736361230; x=1736966030;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6FJheiVMvYWbCZKeg+7lI1bloWoKQoRBO5Nx0WyBg0=;
        b=isFd1/dEtiwYQXrsAwAWD+o0jzBN6FNAYHLcfLFZIgoWwd/tXzQrh+vjhFfD5+wLLA
         XkzqlBUi9f4SH4B3plZ9Kz60Dw+35ZGklw5LiOvVva50aljKF6o9+gHpD3p7Ur0uuQ0r
         SUFWQdZWFe/5WEc1Sd14bBAFp+cv6n1QPKcSRqRjsMZVRKovXMu0y6WA6RGe1GUJOURZ
         sXlDBMgHwlTXiMF3/KuR3aUXez56+8QQL0HiW1fIhGJcvbzYTfvTyMtQBzEsy0hb/2Jw
         Stakt5XF12BZ8TnSXpIsb8Gy+FkEBPQ3rSo+fgDHzzPeSZ35u//1VDEfhtD7+5THyLcV
         AqoA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfu48mSEeAQdOIVhJ0cph0/GfCcJXh7D530yAe02VxqhN7dMc8uZ0BsRtEDzyIb9VzLgEYYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR+poiL3+Q0MUm8d8vdmH9oTAj5IRCGZiIZkgV/D/BKGYDbNX0
	Afp34yf9zOUiPEn9Umlt8DIZeyJMZnRnSN5mkoeNZ2XrLF5MhEwgIvhru+FNHDY=
X-Gm-Gg: ASbGnctg43ZxChkRihSF3Kmnw91Hz68IW6OEoMTAM1fwduRreoTur3W063N+41lXMOJ
	Qt8iXTVyg4l9necuND6WgT5hAMLO1ViUeWIlwEYDZwEdiPnhAHhDLoojeahOl2QnZ8r1DqSV09z
	MEQ69Y3OozuAllVhBmC+HsN6nCeuS2FOCfjAsAa5a3T9I96q3IQ99IXtdcD4O5Iyg/7vgKLQHLy
	4NwligKg4XeRcHYeQIfA4f9YCPbLT0HXWQ4Q4UHQJYLIPEPXujTQg==
X-Google-Smtp-Source: AGHT+IFKQu0S/CxhJlRsO9R5dWJhdMzsAi48BU6f7VdxPORJFw2Mpt41vvc11YkSWn0R04UjSSxdQA==
X-Received: by 2002:a05:6a20:e687:b0:1e5:b082:e38f with SMTP id adf61e73a8af0-1e88d0edb23mr6353414637.45.1736361230145;
        Wed, 08 Jan 2025 10:33:50 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815810sm36665771b3a.29.2025.01.08.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:33:49 -0800 (PST)
Date: Wed, 08 Jan 2025 10:33:49 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2025 10:33:47 PST (-0800)
Subject:     Re: [PATCH] riscv: Fix sleeping in invalid context in die()
In-Reply-To: <20241120085045.LJ5b7oh9@linutronix.de>
CC: namcao@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>, schwab@suse.de, songshuaishuai@tinylab.org,
  coelacanthushex@gmail.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bigeasy@linutronix.de
Message-ID: <mhng-ff90cb6e-3386-426a-a858-038b6ef33b1b@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 00:50:45 PST (-0800), bigeasy@linutronix.de wrote:
> On 2024-11-18 10:13:33 [+0100], Nam Cao wrote:
>> die() can be called in exception handler, and therefore cannot sleep.
>> However, die() takes spinlock_t which can sleep with PREEMPT_RT enabled.
>> That causes the following warning:
>>
>> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 285, name: mutex
>> preempt_count: 110001, expected: 0
>> RCU nest depth: 0, expected: 0
>> CPU: 0 UID: 0 PID: 285 Comm: mutex Not tainted 6.12.0-rc7-00022-ge19049cf7d56-dirty #234
>> Hardware name: riscv-virtio,qemu (DT)
>> Call Trace:
>>     dump_backtrace+0x1c/0x24
>>     show_stack+0x2c/0x38
>>     dump_stack_lvl+0x5a/0x72
>>     dump_stack+0x14/0x1c
>>     __might_resched+0x130/0x13a
>>     rt_spin_lock+0x2a/0x5c
>>     die+0x24/0x112
>>     do_trap_insn_illegal+0xa0/0xea
>>     _new_vmalloc_restore_context_a0+0xcc/0xd8
>> Oops - illegal instruction [#1]
>>
>> Switch to use raw_spinlock_t, which does not sleep even with PREEMPT_RT
>> enabled.
>>
>> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> Cc: stable@vger.kernel.org
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> The die_lock() is probably do let one CPU die at a time. On x86 there is
> support for for recursive die so if it happens, you don't spin on the
> die_lock and see nothing. Not sure if this is a thing.

Looks like the RISC-V code is pretty much the same as the arm64 code, so 
it probably just came from there.  I don't really know what the right 
answer is here...

>
> Sebastian

