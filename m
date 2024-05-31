Return-Path: <stable+bounces-47774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A78D5DE3
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CB3B25BB7
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB40A1420D0;
	Fri, 31 May 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5Nd9uOs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4iODCH1i"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71578C7E;
	Fri, 31 May 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146704; cv=none; b=Zvn/DR1EHSlH178FxzyVQLYk5w8yUL8Z1qFErS7JvwD4U+qQkYK+u2wM4/iRl7jwbhFPWdLNKQgvBO3Icmw8HG5+Ah5GoxweZfl2ORudif7QNsfuY+pdKOUbDEBI0JY+CyctCM2QTR4wpMV9fbvPvmZi1FigNBslGwWbvEtZQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146704; c=relaxed/simple;
	bh=3MKARfDmtI2u29OtqOPhdYMoaiEH48p6RYJTh3QxfXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDCHrQROEow+R5fdfwcIJZYwMfU5YEnM40TJuHtnwpkI3DMs5eP8LiRqhxgUsyI2bh4IlXAIXEuJmWcDPn3cDrKaoo7rc3n6AvUPFobvb1io9svhCTVx770qHibngxfCTFVNFjNxE3ptuIHjaKHWQO97upMpNdWyZWDBB89HdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5Nd9uOs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4iODCH1i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717146701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4tAbLrn87lubgmSwcqSrkzH+jbS/RnpUcK1nCwo9UI=;
	b=W5Nd9uOsBusdsFPOogLbTJSbJQfL3TzPTLvlLUTClpQVzdia94h/2qSgn37XGEiEBxAD5R
	gAtoVlflxBMDwbTv0DMONZccCkhN0I20HAVIzJYLOek3rzr7Ns3vkYz8T69C4bQaYkM6zv
	A3wuDUd2/LQycqHm3TVRCDX2D4krBi7XennaZ1T7ghjRGVyAU1U5+MBlJiRLwGTcKgthl6
	VzcqJQwxOyfhQlc+uKJoqeuyAtuYYw+yyOJsSNO6XlrELy6jE8qDauP1Vu/gHCHQHSpD60
	q0ik3toGn99nwOppkPXdSgZNtQSYoa38xCTM9hiaaScIgDGexAN3KoRZBuvu1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717146701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4tAbLrn87lubgmSwcqSrkzH+jbS/RnpUcK1nCwo9UI=;
	b=4iODCH1id724KVSLj6r8kirf0aErz4+hzh35lExxWE65tokMy9UQCoCDol01d7GZkTDjDh
	rfshM0bR9NPopBCw==
To: Christian Heusel <christian@heusel.eu>
Cc: Peter Schneider <pschneider1968@googlemail.com>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <87cyp28j0b.ffs@tglx>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
 <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu> <87cyp28j0b.ffs@tglx>
Date: Fri, 31 May 2024 11:11:39 +0200
Message-ID: <875xuu8hx0.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 31 2024 at 10:48, Thomas Gleixner wrote:

> Christian!
>
> On Fri, May 31 2024 at 10:16, Christian Heusel wrote:
>>> One of the reporters in the Arch Bugtracker with an Intel Core i7-7700k
>>> has tested a modified version of this fix[0] with the static change
>>> reversed on top of the 6.9.2 stable kernel and reports that the patch
>>> does not fix the issue for them. I have attached their output for the
>>> patched (dmesg6.9.2-1.5.log) and nonpatched (dmesg6.9.2-1.log) kernel.
>>> 
>>> Should we also get them to test the mainline version or do you need any
>>> other debug output?
>
> Can I get:
>
>     - dmesg from 6.8.y kernel
>     - output of cpuid -r
>     - content of /sys/kernel/debug/x86/topo/cpus/* (on 6.9.y)
>
> please?

It seems there are two different issues here. The dmesg you provided is
from a i7-1255U, which is a hybrid CPU. The i7-7700k has 4 cores (8
threads) and there is not necessarily the same root cause.

Thanks,

        tglx

