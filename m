Return-Path: <stable+bounces-47773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DC8D5D18
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0FFB25041
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E27155753;
	Fri, 31 May 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="utrtNOcK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuXE9kF5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70801155758;
	Fri, 31 May 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145290; cv=none; b=rk6DZNeihB2V/KrejvYR6wTLThsKe+hVXGt/r0aHvBVlTqv1f2d6AOtsZuPo0Il1F4iW8xgSuhz5FR1jSQ0DVMzGrltLKdgBif/HGjJ07adevU/1fjwCejJ+SmrD2uBbXSPiINgQLQViTC359Vs8rVrXMRMGj+2uOP84cfQWmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145290; c=relaxed/simple;
	bh=JdlUKVnQHdBhLsigzhKmmvx4nG6tXoqKcqP+AuaMCJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiWQQph/2gNMbZxjosM6Sj9neq7nM64t66oqQihAhNgZV9zsxPpYoCcwNZKD5CxTiseX4gqzyzH5Q08VvqCoTK8lLUu8wyR2YW5JlTW3NRU/yTeTHtz8/PKZq+rZfsx3lqFOAdowCu2lMrlJhzCbcQdnvxcaW4SO/wtblrbFYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=utrtNOcK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuXE9kF5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717145287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXvvMh1Hn6JVKx2vaH4EvGqjKobEVXjHp1AvPSqQ9OM=;
	b=utrtNOcKXaPqDDibgul4DUQHDxevjrjGutMPrFukbliI/BtJDz3lqT3aiUDxpADBrd15cA
	5mvA7y7RnFlbF+jSz0YIxADrl4Qm3C/GfjnUlcta7PWQxqhjZFz6JC6aRtttXcd+N10EhG
	KbuMQXILKy5WDaXd7Z8/kyxnGWliYc8skigbSpnJTDRjBkbro0BG9UBvtt37r/FspaB9HC
	NWD6osJXEbiRZmNzFcFxA3YN4rPWy3XyqARCCIurnJ0mmQ1BIEi/jie6ZohT+ancNCUvRU
	PrinWK4d4251Ci0vvAr9C2NMXHovEm7ZKYh3WafyTdEiDomcf3IUdGM7JguXJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717145287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fXvvMh1Hn6JVKx2vaH4EvGqjKobEVXjHp1AvPSqQ9OM=;
	b=AuXE9kF5jeRqLsY8hXfazEpyu41TpNl8BClH/sthQzykvVTNDaZ4w3fwN6+3beCJvZUpqf
	5DttzRaFNYGfYJBA==
To: Christian Heusel <christian@heusel.eu>
Cc: Peter Schneider <pschneider1968@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
Date: Fri, 31 May 2024 10:48:04 +0200
Message-ID: <87cyp28j0b.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian!

On Fri, May 31 2024 at 10:16, Christian Heusel wrote:
>> One of the reporters in the Arch Bugtracker with an Intel Core i7-7700k
>> has tested a modified version of this fix[0] with the static change
>> reversed on top of the 6.9.2 stable kernel and reports that the patch
>> does not fix the issue for them. I have attached their output for the
>> patched (dmesg6.9.2-1.5.log) and nonpatched (dmesg6.9.2-1.log) kernel.
>> 
>> Should we also get them to test the mainline version or do you need any
>> other debug output?

Can I get:

    - dmesg from 6.8.y kernel
    - output of cpuid -r
    - content of /sys/kernel/debug/x86/topo/cpus/* (on 6.9.y)

please?

Thanks,

        tglx

