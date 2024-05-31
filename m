Return-Path: <stable+bounces-47804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA4E8D65A5
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AC1287AD7
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86E763FC;
	Fri, 31 May 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJEIrs2f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X272vt9j"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6933080;
	Fri, 31 May 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169106; cv=none; b=K2bivyYDpYqi12ZToRqagjMe+CgOltc4dy4H6cy792dFUPMnZ+Fs3kAZc6c7FAoTda4hcytTv89Q0OEHfIaC/T7oMt32ERqQfXGR0cI9IqbAROXNCxWAP04KvD6k3k3Z7VAVCq/kr4Z40ven2yl88E32HLT8iR2Ef30h/KkT+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169106; c=relaxed/simple;
	bh=pF4Mixxdrq0cYOpR+ClRxFtubx/s2XmY9q7iP3NxDqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhMfiOf8EswM+Nfze70YQzG/8jfEsM48yllLfZ+xCWUlL+eXFT9bOqhVf6p+/VrMlEy5p/Qwb3Em7X/5x/Enisr/qvGemjIQCTAihX/xbYwh944gVFMA70yMBqinqnteiUV6Fl6P1Yv5e6waEq+siU17jw5PfDLT9iuoNaEMYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJEIrs2f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X272vt9j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717169102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBAiXgC5x6K/2E25MmGwn9JeI87ahIu7LD3cMl3AcgI=;
	b=pJEIrs2fQMNn+nGI1rBaVPcWTQOUXi7P4atPxxPoRH2Fim0kO4PPoHNaW2EglMy/KdNQWf
	yAmJNeXfL9KrLIcPRb9Ma54ySvg5VFzVDKFlJCh7ZgpKKeyf2ElJVCP4NQuX1H12dkfN7L
	J5AqlHjH20FdGBi/tKGR0J6THLXH2NVEpAYbo3pag912MyCCB5HQkk8KstB0KY8+2MO109
	AKbJbLySvpgPs73pDglKLGxgBmqGvx9ms68b1RzoIOlsZ1VWsST15OzWW+gYmC87VUc2hX
	cm290au9wvRPlhry5e2iC0/gE/3lAwG+2Gv/3/M583XOXSLE0qeHqLcVFxK9Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717169102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBAiXgC5x6K/2E25MmGwn9JeI87ahIu7LD3cMl3AcgI=;
	b=X272vt9jZHCuUxIPlGP7h16QUfr6QWEuUYpJNrjFH+d/k/xNcbO61KHjTne81u5i5EyzD1
	6pQNFx81D9aLOhCg==
To: Christian Heusel <christian@heusel.eu>
Cc: Peter Schneider <pschneider1968@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <43c15a7b-6f43-410e-800e-2ebec87ea762@heusel.eu>
References: <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu> <87cyp28j0b.ffs@tglx>
 <875xuu8hx0.ffs@tglx> <b42363ac-31ef-4b1a-9164-67c0e0af3768@heusel.eu>
 <87sexy6qt9.ffs@tglx> <43c15a7b-6f43-410e-800e-2ebec87ea762@heusel.eu>
Date: Fri, 31 May 2024 17:25:00 +0200
Message-ID: <87plt26m2b.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 31 2024 at 16:29, Christian Heusel wrote:

P-Cores are consistent:

> CPU 0:
>    0x0000000b 0x01: eax=0x00000006 ebx=0x0000000c ecx=0x00000201 edx=0x00000000

>    0x0000001f 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000000

E-Cores are not:

> CPU 4:
>    0x0000000b 0x01: eax=0x00000006 ebx=0x0000000c ecx=0x00000201 edx=0x00000010

>    0x0000001f 0x01: eax=0x00000007 ebx=0x0000000c ecx=0x00000201 edx=0x00000010

As the topology is evaluated from CPU0 CPUID leaf 0x1f it's obvious that
CPU4...11 will trigger the sanity checks because their CPUID leaf 0x1f
subleaf 1 entries are bogus.

IOW it's a firmware bug and there is nothing the kernel will and can do
about it except what it does already: complaining about the inconsistency.

Thanks for providing all the information!

       tglx


