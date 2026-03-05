Return-Path: <stable+bounces-223204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A1EADqPqWni/gAAu9opvQ
	(envelope-from <stable+bounces-223204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:12:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9593A2130E5
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B1E1303902F
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDC3624B5;
	Thu,  5 Mar 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTp7og/v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFA388E55
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719925; cv=none; b=ZAMEgj3GEYBgjMkfVAnsO2RFZIEUl9gMK9PZi0p/d+vcV30DsUeO6P1dKXItoG5JRV6xyaPhlh68jUeN+IM/hDCF66ULAZT88UgTozmfuDuk+7zc8QTZZdK01AYCbSb4fsHOoosvhiLzljig8+EYumfON1aDMxmh3cuhFt6YZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719925; c=relaxed/simple;
	bh=p6cda8gwAdAAGyR02N1Oyd8t27rj5MT9uqJH5Ytv4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIqE7wmRkUgJbdBL2hG75wKCqQluFzV389XooYRu5NLkMuMTCsyCS17675Ch104JJ055HqZzchn8wSX9PZLviChbulTGpTjuRlOJhqV+DQlGvkVkGvQejylWNXlvXXQpvKAemnR6GFByntl7k3IXLRqtVz0nKT/XVMFJ0nY1dbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTp7og/v; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4837907f535so73745595e9.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719921; x=1773324721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UkoccNiiVN6XYrJgBoUTBAcjdNHogB3l/e5XXL5DvA=;
        b=aTp7og/vQopC2QzktMmy1IvQbEGwzMcqL96X026+7ZgD7pOq1NnMGTvFwwnrem1Orv
         fijNfv570wcy+Z1nLWDm+Ao5/VwfAMOe9SXnxilXT7U0Qi/+mDTu3pqjy7i6LXYhGqw1
         Pku3klVLnJpSxFf8DLbvfWexfkWGuvX6jDYsOgCx537TUYpFzJuvKXvI7nONgOw/US5Z
         ro8WM2cH/F7g26szfweo9PqN1OBjp7S5aHY0ixPSaul0rQBxx6iMeQ2EFtuGqQ8k37vH
         fKQY4gpKH9FALFm2olAyLTI2mE/uPVWVbifBJzKyae/2RWIM6ByHaZUlGOEy9KZ4L7Ub
         zHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719921; x=1773324721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/UkoccNiiVN6XYrJgBoUTBAcjdNHogB3l/e5XXL5DvA=;
        b=w9DQT2CJR1KOap7oLk0paijCgtec2zJt8TQYOHKdL53RFJGAl5Cz1ErZjs0m89GpF0
         HGIWs1oqNDajlcZcCbaU15HHYvZGDXf0iYuq3ncnvzkoPRt5gVt7bs2O+q+bj3AuvTqf
         NIG7X8mLL/iT1KIRVaA2EFSLAfH+v4J9xzWregi/gCtqGBo5sXhKHPXgCeSQLWcISvtE
         IELab1RZWE0wmLS1sFyAXAtG7wUDmxUXXj18IFG+xO+b6FcBZbVVTgKA8Vci/kj2RVOP
         7fCur/IZj08hxCuHrCuYjhKA1U4eMw4g7uiGqUm5/lupLgHjczzPNd5iwnzKHLLm5O1m
         Zgtg==
X-Forwarded-Encrypted: i=1; AJvYcCX5rziCUtNTd1fM46WIxSZcaaxaqmtgUJlz51Z/uPMBNXC1Qd0N3tvxo2WiV8Nkf2u6FnFinIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH6H4Q3CijMweXnAvT1rQhKHaTxlAF3wEjRt9IADsssN9jjNG
	gpuIfCSsxmkTwz1Mukx0QOPsvy17KhuXV8rtxmCrlh6lgF6YvfELqMfL
X-Gm-Gg: ATEYQzybN4z54qsMK/yyXmJnWVzoZMKDfDCf3hnu7kDXpxdXp7aXbE4BVWODj3GeQ5q
	i7sGo1phd06Jt4sXdOIMof8H+chCigNzJMjvROHACG8YXxYUbP+LhMmgQw0s3MCTWbT3kyha7lr
	t9UcrbDFtPZ3wXz6L3U8qrhKCTN7FcFh3TkrvsPBcFYfTgIVcI7No7SViVsDzSBjHbbrE1wPNSY
	f4EW49uyHYiMxygEoJMw++PcehGGwvuWTt7MH9HMjGRmVgCLvMwff81TuThG3vPiFYOfxyO6lsS
	/6xGPP6mhAQlUO+GMln3NOYVKEpDdRpRiImT/StQ7iuq6Hntu+lEpuhIN6m69o6AIFZU5zvL5zV
	AGiFaodw5h759dwYDdvXZNqx/mZ3NREAuObJhevPxuuOx8ASTX9g+yKMbI8i55Xs1wg0FwSy56v
	ONhH1+6qwjZ04SQoKqoK5EFK85m8wJevfFlX25UH5Iiz9nGmMU4/PCT5Hnn5RtQxHS
X-Received: by 2002:a05:600c:1c18:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-48519871aa4mr120621275e9.16.1772719920989;
        Thu, 05 Mar 2026 06:12:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm32648235e9.20.2026.03.05.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:12:00 -0800 (PST)
Date: Thu, 5 Mar 2026 14:11:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: <me@ziyao.cc>, <andrew.cooper3@citrix.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
 <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
 <stable@vger.kernel.org>, <tglx@kernel.org>, <x86@kernel.org>, David Wang
 <davidwang@zhaoxin.com>, <lukelin@viacpu.com>,
 <brucechang@via-alliance.com>, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
 <cooperyan@zhaoxin.com>, <benjaminpan@viatech.com>,
 <TimGuo-oc@zhaoxin.com>, <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on
 Zhaoxin C4600
Message-ID: <20260305141158.294ee1e9@pumpkin>
In-Reply-To: <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
References: <20260228173704.62460-1-me@ziyao.cc>
	<70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9593A2130E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223204-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 17:03:07 +0800
Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> wrote:

> Thank you for submitting the patch to fix the Zhaoxin CPU issue.
> 
> After internal clarification, we have confirmed that this is an
> issue with the ZX-C CPU ucode:
> When modifying CR4.FSGSBASE bit 16, the ucode propagates its
> value to another MSR register. During execution of FSGSBASE-related
> instructions, the hardware actually checks whether this MSR
> register's bit is set to determine whether to generate a #UD
> exception.
> When the CPU enters SMM mode and then returns via RSM, the CR4
> register is restored but the value of CR4.FSGSBASE is not
> re-propagated to the MSR register.
> As a result, after enabling CR4.FSGSBASE, once the CPU goes
> through SMM mode, executing FSGSBASE-related instructions will
> trigger a #UD exception.
> 
> This issue exists only on ZX-C CPUs, which have two different
> CPU vendor IDs and distinct FMS values. The following patch can
> be used to identify ZX-C CPUs and properly handle this issue:
> 
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -201,6 +201,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
>          set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>   #endif
> 
> +       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {

The '>= 14' looks odd to me.
It implies it all worked, got broken, and will never be fixed.
I'd also add a 1-line comment, something like:
		/* CR4.FSGSBASE not copied to MSR on return from SMM mode. */

	David

> +               pr_warn_once("CPU has broken FSGSBASE support; clear 
> FSGSBASE feature\n");
> +               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +       }
> +
>          init_ia32_feat_ctl(c);
>   }
> 
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> index 031379b7d4fa..6a2d6df307ee 100644
> --- a/arch/x86/kernel/cpu/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -89,6 +89,11 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
>          set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>   #endif
> 
> +       if (c->x86 == 6 && c->x86_model == 25 && c->x86_stepping <= 3) {
> +               pr_warn_once("CPU has broken FSGSBASE support; clear 
> FSGSBASE feature\n");
> +               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +       }
> +
>          init_ia32_feat_ctl(c);
>   }
> 
> Sincerely
> TonyWWang-oc
> 


