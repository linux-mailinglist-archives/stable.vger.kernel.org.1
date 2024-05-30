Return-Path: <stable+bounces-47682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A58D4711
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB792850B6
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52CA14F131;
	Thu, 30 May 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLiXbJ5k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9gO2GsiN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7E176AB8;
	Thu, 30 May 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057815; cv=none; b=svVDW8tpQe9iDRNBPAZwXIQPhGB/QYS4MzBtXgu9esZaG41Sa0bD5ZE64RxBjYYw/dU01uK8r1Sc9p0K5siMbMUkRrGIlmemZVAaoKtf1DgsINrrFPiUAyRiDWAHXrBgJYxpjTM2L52g+5ZWGNlZ9/3kOy7E4DSE8DzEPMpY3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057815; c=relaxed/simple;
	bh=MvdkkCKPSepl91Y7804RHqMcNOXEkytlMBE1ugKuISI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vk+JEnINf+3Cn6S6T8lPiNXD1nnHm1HV8YSGd6M8cQmSH8PxbaxqxcLlw01MhbiK4yqDBjk9rJNXtmMp2vTfOxpvQHsIRO6Jx32Ltu4UJweTIQXi30VojOxW/hVb7gwmsU9m5PfTx+cciXtWW6PQJmAKNePUPmSGRUkVWsoMoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLiXbJ5k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9gO2GsiN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717057812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPLYtheb57Rblm9GDh2pb6WDY4geRPaBbhxs9rtzT8Y=;
	b=KLiXbJ5kVOu3neydHnHQVL+J8kVUVKtyY8TxS1nD9omXKtTUWM0JyIb0h9gB8lULE3IvGn
	UjAzYScGJS08NL0WEoUgZfF42H5kD+3qSASisrsIyufFWT9qdkYvLLlbhsWcx8XeJ5txUs
	IzfSHyPS6wZtkfZuqoKn6oUQpomf9GCU8mTiAdW8K6b1FDXEz3KxJDygooUV1k8FpsC3Kj
	DEzEAQmvzOEzw5hWFosu2o3r/QaVG+626sQc4dlfH+tceb5tHcUas4Hh+gvLmR64txHmWa
	5VxU/rYiw41OEClVVK4MCwwjkdQmld4Y4Ddrfd0+LcNwcbA8koKnpN3xu6FfaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717057812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wPLYtheb57Rblm9GDh2pb6WDY4geRPaBbhxs9rtzT8Y=;
	b=9gO2GsiNU0j80SYgjCU5ZMvX9PLfCkhd8juQRmDqn3rfO80GTDojdfoxa2KY0+53FX4Jd/
	FYTbnDYWwPwxf2Cg==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
Date: Thu, 30 May 2024 10:30:09 +0200
Message-ID: <87zfs78zxq.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter!

On Mon, May 27 2024 at 23:15, Peter Schneider wrote:

Thanks for providing all the information!

> I want to add one thing: there is a log entry in the dmesg output of a "bad" kernel, which 
> I initially overlooked, because it is way up, and I noticed this just now. I guess this 
> might be relevant:
>
> [    1.683564] [Firmware Bug]: CPU0: Topology domain 0 shift 1 != 5

Yes. That's absolutely related. I can see what goes wrong, but I have
absolutely no idea how that happens.

Can you please apply the debug patch below ad provide the full dmesg
after boot?

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -65,6 +65,7 @@ static void parse_legacy(struct topo_sca
 		cores <<= smt_shift;
 	}
 
+	pr_info("Legacy: %u %u %u\n", c->cpuid_level, smt_shift, core_shift);
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
 }
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -72,6 +72,9 @@ static inline bool topo_subleaf(struct t
 
 	cpuid_subleaf(leaf, subleaf, &sl);
 
+	pr_info("L:%0x %0x %0x S:%u N:%u T:%u\n", leaf, subleaf, sl.level, sl.x2apic_shift,
+		sl.num_processors, sl.type);
+
 	if (!sl.num_processors || sl.type == INVALID_TYPE)
 		return false;
 
@@ -97,6 +100,7 @@ static inline bool topo_subleaf(struct t
 			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
 	}
 
+	pr_info("D: %u\n", dom);
 	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
 	return true;
 }

