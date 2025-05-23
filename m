Return-Path: <stable+bounces-146172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13432AC1DD3
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429537BAB24
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A75221D9A;
	Fri, 23 May 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a6nfq8v7"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2F20FAB0;
	Fri, 23 May 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986178; cv=none; b=jbIlOza5VCekcRZp71sSI8fsCCU/DX3S6xzCzX9RNm66ryjpiIGPGwQ2cVYc2blgoJOwzplZqJ+LbX3bdME3SrErjBMoy8sMPQNW4HasJHSSKiqUDPnW19d+CuyI/U6/kJ/oBy395RIFXuuQmYYjBO35gWS0d38fM4UEfR1/bwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986178; c=relaxed/simple;
	bh=nO5bS3m889863mTMqoB3Tw6lBy3U+hB0upXUCnQInyE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ji/qaHZNlGABG/dDF8QFmE12S/DnD/W74MILD7/JYjyGlUGdbKVnD4AUE+fhr2uhRLt2+q8LRytZJl9E/R9F+KKJR3jb/iA1leFYmDeYMYhJ0IYlzGQ3J6q1eVJm9yeA7eEeLGjjawXh7ET3AUt96FoImM5fjj6u1NZgxqg6CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=a6nfq8v7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54N7gK7d3364546
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 23 May 2025 00:42:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54N7gK7d3364546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1747986141;
	bh=aDMCxKnUjVpfH+Z6QVUbrzej9Ot/D3RMUg29EMy0pV4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=a6nfq8v7yVU7GUBZeX57FsM8kQJp4lMfy2951or1z87WQ0NyqOfcMsnBsViIqYhI/
	 cKG4UlJoJaGNhBH82P4+KWGW8WGExCQKoW3xTau2AuqX3YfZliudd4FVEZjhTq5UN4
	 iqCbwXygldOxihvlZK9lvAxP68N6Zt30wNfWl2bfScU9DEFln8vC+Y1dDqGS0Fk4kk
	 24v8hOCJWnREV76ALvQSU+G6HUy4Ti/QBOKNFwZumpaNz4DyQ4qNzpLAzWCEKSyraj
	 B6i9RjiMz1WWMz2Jq2h5LUK+cZhZ4NRQup3uyzdVf+FwWi8TmshXsHzlWKfixzcQTz
	 EdE4HPbTRehcQ==
Date: Fri, 23 May 2025 00:42:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_x86/fred/signal=3A_Pr?=
 =?US-ASCII?Q?event_single-step_upon_ERETU_completion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <97a86550-844d-41c8-bc5e-b3b7b20ef6c9@zytor.com>
References: <20250522171754.3082061-1-xin@zytor.com> <e4f1120b-0bff-4f01-8fe7-5e394a254020@intel.com> <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com> <97a86550-844d-41c8-bc5e-b3b7b20ef6c9@zytor.com>
Message-ID: <F535D469-6B77-47CC-8D04-FA6D8D7E937D@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 22, 2025 5:57:31 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 5/22/2025 10:53 AM, Andrew Cooper wrote:
>> This was a behaviour intentionally changed in FRED so traps wouldn't ge=
t
>> lost if an exception where to occur=2E
>>=20
>> What precise case is triggering this?
>
>Following is the test code:
>
>// SPDX-License-Identifier: GPL-2=2E0-or-later
>/*
> *  Copyright (C) 2025 Intel Corporation
> */
>#define _GNU_SOURCE
>
>#include <err=2Eh>
>#include <signal=2Eh>
>#include <stdio=2Eh>
>#include <stdlib=2Eh>
>#include <string=2Eh>
>#include <sys/ucontext=2Eh>
>
>static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *)=
, int flags)
>{
>	struct sigaction sa;
>
>	memset(&sa, 0, sizeof(sa));
>	sa=2Esa_sigaction =3D handler;
>	sa=2Esa_flags =3D SA_SIGINFO | flags;
>	sigemptyset(&sa=2Esa_mask);
>
>	if (sigaction(sig, &sa, 0))
>		err(1, "sigaction");
>
>	return;
>}
>
>static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>{
>	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
>	static unsigned long last_trap_ip;
>	static unsigned int loop_count_on_same_ip;
>
>	if (last_trap_ip =3D=3D ctx->uc_mcontext=2Egregs[REG_RIP]) {
>		printf("trapped on %016lx\n", last_trap_ip);
>
>		if (++loop_count_on_same_ip > 10) {
>			printf("trap loop detected, test failed\n");
>			exit(2);
>		}
>
>		return;
>	}
>
>	loop_count_on_same_ip =3D 0;
>	last_trap_ip =3D ctx->uc_mcontext=2Egregs[REG_RIP];
>	printf("trapped on %016lx\n", last_trap_ip);
>}
>
>int main(int argc, char *argv[])
>{
>	sethandler(SIGTRAP, sigtrap, 0);
>
>	asm volatile("push $0x302\n\t"
>		     "popf\n\t"
>		     "nop\n\t"
>		     "nop\n\t"
>		     "push $0x202\n\t"
>		     "popf\n\t");
>
>	printf("test passed\n");
>}
>
>
>W/o the fix when FRED enabled, I get:
>xin@fred-ubt:~$ =2E/lass_test
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trapped on 00000000004012fe
>trap loop detected, test failed
>
>
>W/ the fix when FRED enabled:
>[xin@dev ~]$ =2E/lass_test
>trapped on 00000000004012fe
>trapped on 00000000004012ff
>trapped on 0000000000401304
>trapped on 0000000000401305
>test passed
>
>Obviously the test passes on IDT=2E
>
>As Dave asked, I will integrate this test into selftests=2E
>
>Thanks!
>    Xin

Btw, make the test work on 32 bits as well (just a matter of using a diffe=
rent ucontext=2E) 

