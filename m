Return-Path: <stable+bounces-146144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D2AC1903
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D4C4E7B72
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 00:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DBC20297F;
	Fri, 23 May 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ihKSeQkN"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7459AD24;
	Fri, 23 May 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747961927; cv=none; b=m8f2znCNr5mRRz2+mCK34Ap+WUok1oRsyO0f27bVxI2uX/ViJ1xuhobTFfdveNuwe9QuLodFVFjPDUm+qCWU9nfQSv8pOkjMPPpJ4BExo1WoP09RL6NxpK+GLSsG+RZSKVWkKxcB+bBmNMW0P4r85QK55DSQJIYchazT9Wgsm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747961927; c=relaxed/simple;
	bh=G3lDgalSES4+LUeMJSVcq2Vx7YAnMSifKDBUKcnxS90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4voYlqKjm2SUrQ6XNcgRMBrH8656EW5dolfMxrqP6Ki3Zn8+HG1OEIHr1C/6c/U5vINZ6wIZ6tHHx59yKUNYpL3O7a0/lUkOks4FQ8Q6KlHZ3ou9xKSIG54CYYsX8znObrW8GxtW8g76RsxP6+TigCxcF8Ye/zZi71+3+42CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ihKSeQkN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54N0vVCN3229952
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 May 2025 17:57:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54N0vVCN3229952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747961853;
	bh=hLCy7IahoOH+nrCcvZn3wBZZBx3mRCPW8+yytgbmYQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ihKSeQkNPrDweyMMjCBfaJhlyRciuvUlfc8SB/DlqpiHjoItCE5lKKDlZXgy4ERzw
	 1nm9VfJ7NFhJPibwdALiazQfGVv2qJKEtpqINUZEyvXcK/dImDUgLLK5Zs88RCzHXd
	 z90CHhiqmdhJv6r0GE4LkQ6N89TrpMnDMYdp0tM/B3ABEqhzn0eXWufmcxrwXznVhq
	 t6B96xiMQWiwQotC4Y6Idy6oJe7SoCBZSPSXuW6oza3ueZ8Bu5ivApj78Hcwj4Gxq9
	 qcUJF3abmIDUavsjQq2kisAj6nagLuTUhiUZ3bqZtzp9QYuPpUp0S6/8p3frf/GpB5
	 ERObCGKHWKoKQ==
Message-ID: <97a86550-844d-41c8-bc5e-b3b7b20ef6c9@zytor.com>
Date: Thu, 22 May 2025 17:57:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, stable@vger.kernel.org
References: <20250522171754.3082061-1-xin@zytor.com>
 <e4f1120b-0bff-4f01-8fe7-5e394a254020@intel.com>
 <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/2025 10:53 AM, Andrew Cooper wrote:
> This was a behaviour intentionally changed in FRED so traps wouldn't get
> lost if an exception where to occur.
> 
> What precise case is triggering this?

Following is the test code:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
  *  Copyright (C) 2025 Intel Corporation
  */
#define _GNU_SOURCE

#include <err.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ucontext.h>

static void sethandler(int sig, void (*handler)(int, siginfo_t *, void 
*), int flags)
{
	struct sigaction sa;

	memset(&sa, 0, sizeof(sa));
	sa.sa_sigaction = handler;
	sa.sa_flags = SA_SIGINFO | flags;
	sigemptyset(&sa.sa_mask);

	if (sigaction(sig, &sa, 0))
		err(1, "sigaction");

	return;
}

static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
{
	ucontext_t *ctx = (ucontext_t *)ctx_void;
	static unsigned long last_trap_ip;
	static unsigned int loop_count_on_same_ip;

	if (last_trap_ip == ctx->uc_mcontext.gregs[REG_RIP]) {
		printf("trapped on %016lx\n", last_trap_ip);

		if (++loop_count_on_same_ip > 10) {
			printf("trap loop detected, test failed\n");
			exit(2);
		}

		return;
	}

	loop_count_on_same_ip = 0;
	last_trap_ip = ctx->uc_mcontext.gregs[REG_RIP];
	printf("trapped on %016lx\n", last_trap_ip);
}

int main(int argc, char *argv[])
{
	sethandler(SIGTRAP, sigtrap, 0);

	asm volatile("push $0x302\n\t"
		     "popf\n\t"
		     "nop\n\t"
		     "nop\n\t"
		     "push $0x202\n\t"
		     "popf\n\t");

	printf("test passed\n");
}


W/o the fix when FRED enabled, I get:
xin@fred-ubt:~$ ./lass_test
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trapped on 00000000004012fe
trap loop detected, test failed


W/ the fix when FRED enabled:
[xin@dev ~]$ ./lass_test
trapped on 00000000004012fe
trapped on 00000000004012ff
trapped on 0000000000401304
trapped on 0000000000401305
test passed

Obviously the test passes on IDT.

As Dave asked, I will integrate this test into selftests.

Thanks!
     Xin

