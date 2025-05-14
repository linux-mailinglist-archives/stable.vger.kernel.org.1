Return-Path: <stable+bounces-144355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197ACAB6879
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F64A0CBA
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7726A0E0;
	Wed, 14 May 2025 10:13:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24A21D3F2
	for <stable@vger.kernel.org>; Wed, 14 May 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217615; cv=none; b=j0YKLAW3HM6H58oY/HAH4DEPNPm9bRUUALw1V5LybxFg/exf/5BKsjiyimqj/1IAeLUjZlUvvXzto4jLo6nf/sePyThBHmEY5wHB42viWWQnNxPT0EHRVfJmjFZAGbH7fQM7AcMdF6UQkeuhQOixw7pXeDHs9TWvkX5QlG4sUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217615; c=relaxed/simple;
	bh=zA/Op2WhVwa+YJh13Me/K+2PifEg3Rh+BH/uTvWrv5U=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kN3djumsy43JAAMwi/ct3fZRGQZsYyKbtJTBiGwbrGe1SLgkVo39DxMQduLxF+vCoAFWeQjYobopq/ovG6Qtrsd4LctHkp8s5onw02VuU2rdf2NvMnjFE69qBP3iilrI4ixIvlpf4KSJERYbxLM1Ns9rkI7cOuq8ywRVO+/9Zzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 5EF3F12500D;
	Wed, 14 May 2025 12:13:29 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 1C8946018BE80;
	Wed, 14 May 2025 12:13:29 +0200 (CEST)
Subject: Re: 6.14.7-rc1: undefined reference to
 `__x86_indirect_its_thunk_array' when CONFIG_CPU_MITIGATIONS is off
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f88e97c3-aaa0-a24f-3ef6-f6da38706839@applied-asynchrony.com>
Date: Wed, 14 May 2025 12:13:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

cc: peterz

On 2025-05-14 09:45, Holger Hoffstätte wrote:
> While trying to build 6.14.7-rc1 with CONFIG_CPU_MITIGATIONS unset:
> 
>    LD      .tmp_vmlinux1
> ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
> /tmp/linux-6.14.7/arch/x86/net/bpf_jit_comp.c:660:(.text+0x97e): undefined reference to `__x86_indirect_its_thunk_array'
> make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> make[1]: *** [/tmp/linux-6.14.7/Makefile:1234: vmlinux] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> - applying 9f35e33144ae aka "x86/its: Fix build errors when CONFIG_MODULES=n"
> did not help
> 
> - mainline at 9f35e33144ae does not have this problem (same config)
> 
> Are we missing a commit in stable?

It seems commit e52c1dc7455d ("x86/its: FineIBT-paranoid vs ITS") [1]
is missing in the stable queue. It replaces the direct array reference
in bpf_jit_comp.c:emit_indirect_jump() with a mostly-empty function stub
when !CONFIG_MITIGATION_ITS, which is why mainline built and -stable
does not.

Unfortunately it does not seem to apply on top of 6.14.7-rc1 at all.
Any good suggestions?

thanks
Holger

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e52c1dc7455d32c8a55f9949d300e5e87d011fa6

