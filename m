Return-Path: <stable+bounces-36105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E302B899BDB
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 13:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E3F1F226C0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECF16C680;
	Fri,  5 Apr 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jkZSrbZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEGJkXV2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B316C456
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316439; cv=none; b=u+zJY0PNgUqvz1IfnKoQWcU2GWKx1NFcOvj0SkZeOwIyNQhoxMb+PUnhlqv+bWuGwNLI4PaE3Sryf5N6XYkUFLd16cN5adiJwYTiGQ/0MddFz+mtP8cQzK+Wx73bpA5uLuPKxwY+If9bMAwFXMiXNyj+sfE6Np+WEqRQzBmTtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316439; c=relaxed/simple;
	bh=Phmp4VJ9w3wmQTE69fyL+y1+SzSbJ+ByEzdUkqu0T64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FxsAdtB6PJWauRa6ZBpcmS6LVCBalx3gcRqM/aDPILHl3aEhJST87yI/ozTSrF4iv60U0+Zf5sS1uhRaHvJVPjMh9Zgc7uTH3YYmVMpDfUdF6DOWqsP64rzGYWk0+OdO1cmNwhsrwS3O6v5zyQGTNeCbsGlZGcdUb1QuwXVqzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jkZSrbZk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEGJkXV2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712316430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpu0g7bekk7q1LAKvClnzME1lm4aa63iVd9ffNzSwg0=;
	b=jkZSrbZk1vtaMmmfHLrWJzKcvvO16H5VBJG/EM/s86pIw9Qxe4uGrGYYdbGfkr+VxqLTWB
	5TW1OS3aI+KYQC9IWZqm72b9yGxmJZnb7v1s3mA38vpjMy4SXxHSOgEOYo6oiy+7YDPJUe
	91XySocGBdpoCHevJodrTo2zqNP5k34FuG+kPctwrll2JOkhfSYXGE5lh5jqmcQf1xKMaZ
	FnUQPInLRvu58D9mrHmI6UeaEJmfIdHYxx7/zxSV/NoClNys0GXZv1oOoQINUjQkhiaGy8
	EoyyJdIxjlS+54iPZRPrqGj8zqBncCQYVaRD88GHqC9jY4AqQsr+yI2znIqlsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712316430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpu0g7bekk7q1LAKvClnzME1lm4aa63iVd9ffNzSwg0=;
	b=WEGJkXV2DNLONVHxAY9UfuL2Ppt+cax8nCnJIT0LLfiMNrKB0dV+bltymsK4U5xVeJzvJ2
	lZKKCkG1lej1+4Cg==
To: Wolfgang Walter <linux@stwm.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to
 "x86/mpparse: Register APIC address only once"
In-Reply-To: <899b7c1419a064a2b721b78eade06659@stwm.de>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
 <899b7c1419a064a2b721b78eade06659@stwm.de>
Date: Fri, 05 Apr 2024 13:27:09 +0200
Message-ID: <87y19s82ya.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 12:35, Wolfgang Walter wrote:
> Am 2024-04-04 17:57, schrieb Greg Kroah-Hartman:
>> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
>> 
> It is not an issue with 6.9-rc1. 6.9-rc1 just boots fine.

Bah. That's my fault.

So before the topology evaluation rework landed in the 6.9 merge window
this eventual double registration was harmless and only happening for a
particular set of AMD machines. The topo rework restructured the whole
procedure and caused the new warnings to trigger.

So the Fixes tag I added to that commit was pointing at the wrong place
and this needs to be reverted from all pre 6.9 stable kernels.

Sorry for the inconvenience.

Thanks,

        tglx

