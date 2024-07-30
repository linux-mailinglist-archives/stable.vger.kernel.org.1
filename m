Return-Path: <stable+bounces-62828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BC94151E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4501C232F1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50991A2C05;
	Tue, 30 Jul 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbwII/pT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lfbQJcAB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404F1A0B15;
	Tue, 30 Jul 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352064; cv=none; b=WdvfS5UOUi/hlyCXhzcIx++QqrfE6h61OJj89azYruwIJ8EVSftgNR7rqqQBDeY5CSRVpC4x2uUBmW9S29xUjIYV8g+8UlXdjIU2yuzDz2P8EcHtGogQtt2hdFfbGGzZseAJXIGOLUr7eA6ObPzQtVpwaaa0AmYTTkFTgx3Xvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352064; c=relaxed/simple;
	bh=0vEHp4A4cdwoQ2NXtwvbDJ+K7DRuc7Cd0ke5pgmBak0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipTQ23KGy89Tz91JiZQ8zjYIL2jTLcnb+KTAplMcoCL64OuIN05IMdHGs3d/bWdYTA+HxJX9BbXh7zs8s2s38z7k6WV7q7kH5ZRUXVbITOO5qDiHtMWdf4M2T+IXSBHSZQmCog665edZNWhP5lXixRf19pbd+kFbO+vfsrK8s/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbwII/pT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lfbQJcAB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722352061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fpwPEpw3JPhRv9nBi1m3AsS0B+P8D+BFBm1aO7bI/bE=;
	b=KbwII/pTq8x8+n5OR+jcZaKlUYBbB6p32/ph+Tp9EVTYJ7YLcic2bejdbtMrAb3Cah9Lrf
	fSxktmAE6+QjoPUmaEc6IY/bE3pZm39L7xgbZi7K0m6iUB9LyN6wuOu6ajDLvOndETtAfe
	oVzTyLwEQTPQwx3eAZ7HIUOf5D/YZSO3+tz/WMxaTRtFg+2etA1/aw6Opijpws7vjbhxoT
	e27B1pFneznZRjgC+GQX8v6ciWJLLN1/eemDRV0M4VvsKmxTZU0GJrXWHEeiB8VSmyeElk
	CTtuFesifLLLGt3SIzjzMoC5AKeBhJt+qYTz/gtXvosqW93PfZs28VcS+taSOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722352061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fpwPEpw3JPhRv9nBi1m3AsS0B+P8D+BFBm1aO7bI/bE=;
	b=lfbQJcABo49SKHgsRCI3VbvBYJY/1C1r4+NcBjv+Kz6tCTlhv8/dHZ6SdJkHVKL/ZabQf2
	djXo+eroYdiME+BQ==
To: David Wang <00107082@163.com>, liaoyu15@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 stable@vger.kernel.org, x86@kernel.org
Subject: Re: [Regression] 6.11.0-rc1: BUG: using smp_processor_id() in
 preemptible when suspend the system
In-Reply-To: <20240730142557.4619-1-00107082@163.com>
References: <20240730142557.4619-1-00107082@163.com>
Date: Tue, 30 Jul 2024 17:07:41 +0200
Message-ID: <87ikwm7waq.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 22:25, David Wang wrote:
> When I suspend my system, via `systemctl suspend`, kernel BUG shows up in log:
>
>  kernel: [ 1734.412974] smpboot: CPU 2 is now offline
>  kernel: [ 1734.414952] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-sleep/4619
>  kernel: [ 1734.414957] caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0

The below should fix that.

Thanks,

        tglx
---
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(vo
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(in
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
 			tick_program_event(td->evtdev->next_event, 1);
 		}

