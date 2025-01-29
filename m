Return-Path: <stable+bounces-111189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F35A22171
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552AB3A567B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2041DED73;
	Wed, 29 Jan 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="N8S68H0b"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89C1E25E7
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167013; cv=none; b=OappRigNeriD4kCO/BDwXgT7K4dzY7OYbeNPiUIY50jLhdDrqy4M+ZSH/hLc3G39ZRTBMrLk/uv9Jp//dpcWKHjIkIO++rTrDDwFv2mgRavf+2LM8cMt0H+oPMNf5FRcJUdbmUP1hBus8/32X5Sla3f7lBawE2X/3xZaOPPvzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167013; c=relaxed/simple;
	bh=okZH+q4YD1t3OIIflyLcJJTMeC58Cjqakqn1/2/oMcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itsnFhmmJlj8AvMvfYXYF1vpznht+vNMMG/EwJXSNzlBqPb7f/MV2c8Ivd2zOhCy+ITMaHFTQscZV59p34YmyLKOzN07WTTSFhWevZG+5stojSbU9jHrT+PBhdtz0BYXTh0bon7OOfEKheyMS924EgrAAFn4xGXrbmmv3zKYvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=N8S68H0b; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202501291609577ce7c51ee9c55fe5a4
        for <stable@vger.kernel.org>;
        Wed, 29 Jan 2025 17:09:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QunAiQ74nN4ZiVjBmydkq6F14ND0+oatgL4zis00uzM=;
 b=N8S68H0bNNZYkkMCNY1ezAeh6S65T5Va3NKsxfMTxpnC4pAHbJG+S0n09WVD31PaNTuc2K
 DWT03qOY91DFueXkqSwL/QDh0r3q38cnyVchdkf9yDe1BVvwRpkZqYlL+5pWw+zOyqaECpnR
 wThresSHXBhD+yX1I28j8csIiLnPGrEj7CcUTJHprXJwnfXQI+ohdQNQkS/N7JNHBC4/W35t
 3MtPZPjro5vSAlf31YZje4AvSlhYGkx51XMNKkWALTZ4y9fCuaH8TEzl/OzBp6hHhxBFeipv
 hVMDSTmQFgOldpMTrVn0zbgBqkmY8xJDro6mfCZO5P1Go0xSAgZmPtyg==;
Message-ID: <b07a5022053314df7c756145068bf8653d077f18.camel@siemens.com>
Subject: Re: [PATCH 6.1] softirq: Allow raising SCHED_SOFTIRQ from
 SMP-call-function on RT kernel
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Felix Moessbauer
 <felix.moessbauer@siemens.com>
Date: Wed, 29 Jan 2025 17:09:56 +0100
In-Reply-To: <2025012928-muppet-amends-b460@gregkh>
References: <20250129153226.818485-1-florian.bezdeka@siemens.com>
	 <2025012926-rocker-crispy-f397@gregkh>
	 <2025012928-muppet-amends-b460@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2025-01-29 at 16:58 +0100, Greg KH wrote:
> On Wed, Jan 29, 2025 at 04:47:59PM +0100, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 04:32:26PM +0100, Florian Bezdeka wrote:
> > > From: K Prateek Nayak <kprateek.nayak@amd.com>
> > >=20
> > > commit 6675ce20046d149e1e1ffe7e9577947dee17aad5 upstream.
> > >=20
> > > do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
> > > WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function=
.
> > > Since do_softirq_post_smp_call_flush() is called with preempt disable=
d,
> > > raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
> > > longer preempt disabled sections.
> > >=20
> > > Since commit b2a02fc43a1f ("smp: Optimize
> > > send_call_function_single_ipi()") IPIs to an idle CPU in
> > > TIF_POLLING_NRFLAG mode can be optimized out by instead setting
> > > TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
> > > flush_smp_call_function_queue() in the idle-exit path to run the
> > > SMP-call-function.
> > >=20
> > > To trigger an idle load balancing, the scheduler queues
> > > nohz_csd_function() responsible for triggering an idle load balancing=
 on
> > > a target nohz idle CPU and sends an IPI. Only now, this IPI is optimi=
zed
> > > out and the SMP-call-function is executed from
> > > flush_smp_call_function_queue() in do_idle() which can raise a
> > > SCHED_SOFTIRQ to trigger the balancing.
> > >=20
> > > So far, this went undetected since, the need_resched() check in
> > > nohz_csd_function() would make it bail out of idle load balancing ear=
ly
> > > as the idle thread does not clear TIF_POLLING_NRFLAG before calling
> > > flush_smp_call_function_queue(). The need_resched() check was added w=
ith
> > > the intent to catch a new task wakeup, however, it has recently
> > > discovered to be unnecessary and will be removed in the subsequent
> > > commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
> > > flush_smp_call_function_queue() to trigger an idle load balance on an
> > > idle target in TIF_POLLING_NRFLAG mode.
> > >=20
> > > nohz_csd_function() bails out early if "idle_cpu()" check for the
> > > target CPU, and does not lock the target CPU's rq until the very end,
> > > once it has found tasks to run on the CPU and will not inhibit the
> > > wakeup of, or running of a newly woken up higher priority task. Accou=
nt
> > > for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised fr=
om
> > > flush_smp_call_function_queue().
> > >=20
> > > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@=
amd.com
> > > Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > ---
> > >=20
> > > Newer stable branches (6.12, 6.6) got this already, 5.10 and lower ar=
e
> > > not affected.
> > >=20
> > > The warning triggered for SCHED_SOFTIRQ under high network load while
> > > testing.
> >=20
> > But RT is not in the 6.1.y tree, right?  Or is it?  Why was it only
> > backported to 6.6.y and 6.12.y?
>=20
> And see:
> 	https://lore.kernel.org/r/d21a8129-e982-463f-af8b-07a14b6a674a@amd.com
> for why we added it to 6.12.y in the first place (I don't know why Sasha
> added it to 6.6.y...)

All versions down to 6.1 have the same problem. The same splat seen by
Prateek on 6.12 can happen in 6.6 (already fixed by Sasha) and 6.1 as
well. I think it was simply overlooked.

We did intensive testing on 6.1 these days. We can confirm that it
fixes the problem on 6.1 as well.

Does that help?

Best regards,
Florian


