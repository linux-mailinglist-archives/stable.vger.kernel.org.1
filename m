Return-Path: <stable+bounces-116613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B84A38B7B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 19:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B6C16CC79
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F301235BF4;
	Mon, 17 Feb 2025 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JnBMPZyv"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E079137C35;
	Mon, 17 Feb 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818170; cv=none; b=PJZOSz90cPK+SntlvDHXM6XKIVZ7+lfCkTax1K7OAD9JbvST6vYoU6ZE/0uDEbvD/yw50OkQSCiuv9vWIsfYvbKK5Hq3iA5goYtn1SScT46pKcm3Ohxi/A9fyYaTmFRt0jEfWKzmrVW70rvIplk7F4hIZB3+g4Vh896UL+Q6+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818170; c=relaxed/simple;
	bh=Qjc7TYtwuP5S8eF5xw8fAL1wSrrRYAT8EsRMIW3urrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6UvAn7AyfleMubnxa7TNMwFZl+8osPDfWEVNbNp2vgLVRvSp8p1kGYobciny02ABebcWHEFJkOTpZTHNX5v2NMmyYveR2SbArDIEOEEH4bgA/ojILv5n+deKeOjNdPFApFhPirMi5vsheQV8bIq2v/XHqElodcZzkod2OYIgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JnBMPZyv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LAJQ+WKaLn6Gl95bYJ40go1UYLyHIHVr8Un+ZxoOpuI=; b=JnBMPZyvFwZu2rvtTuaOKoUeyy
	TbQDDInNiHgNYIQH7tDgnEECz2UDh+8swtJyoSTftQAJrBIiyz4V/T7oRdAVim+bkYPUc4syERr6W
	hO5UCs74XE3PMUOzegOSXxpSNosvLpjvnqVYmi1mxN5dz3JnDvGvrOrR7qltWYW+5CNArx268BGfq
	BI4ZrFyWPk9X08+Zo75Bg4PEiLtKuwwpkUNeUbTivwQSa/W0852wxEiKXjuEaZb29GaNYWwKh77jw
	bYq25Bq+jocDzPDqdlQSnT+icnzJjbMJSVra4G8xInA7eXI0ggG5X2TA5bZVWDLoclRoacxtYPnHe
	JItzhFAQ==;
Received: from [187.106.40.249] (helo=[192.168.0.71])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tk6B8-006wsW-W2; Mon, 17 Feb 2025 19:49:21 +0100
Message-ID: <3bcf3eac-555c-6f30-8e32-b8c39967eefe@igalia.com>
Date: Mon, 17 Feb 2025 15:49:13 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Always save/restore TSC sched_clock on
 suspend/resume
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, rostedt@goodmis.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, stable@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <20250215210314.351480-1-gpiccoli@igalia.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250215210314.351480-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2025 17:58, Guilherme G. Piccoli wrote:
> TSC could be reset in deep ACPI sleep states, even with invariant TSC.
> That's the reason we have sched_clock() save/restore functions, to deal
> with this situation. But happens that such functions are guarded with a
> check for the stability of sched_clock - if not considered stable, the
> save/restore routines aren't executed.
> 
> On top of that, we have a clear comment on native_sched_clock() saying
> that *even* with TSC unstable, we continue using TSC for sched_clock due
> to its speed. In other words, if we have a situation of TSC getting
> detected as unstable, it marks the sched_clock as unstable as well,
> so subsequent S3 sleep cycles could bring bogus sched_clock values due
> to the lack of the save/restore mechanism, causing warnings like this:
> 
> [22.954918] ------------[ cut here ]------------
> [22.954923] Delta way too big! 18446743750843854390 ts=18446744072977390405 before=322133536015 after=322133536015 write stamp=18446744072977390405
> [22.954923] If you just came from a suspend/resume,
> [22.954923] please switch to the trace global clock:
> [22.954923]   echo global > /sys/kernel/tracing/trace_clock
> [22.954923] or add trace_clock=global to the kernel command line
> [22.954937] WARNING: CPU: 2 PID: 5728 at kernel/trace/ring_buffer.c:2890 rb_add_timestamp+0x193/0x1c0
> 
> Notice that the above was reproduced even with "trace_clock=global".
> 
> The fix for that is to _always_ save/restore the sched_clock on suspend
> cycle _if TSC is used_ as sched_clock - only if we fallback to jiffies
> the sched_clock_stable() check becomes relevant to save/restore the
> sched_clock.
> 

Hi folks, I would like to ask if possible to add the following tag:

Debugged-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Cascardo helped me a lot on debugging this issue but I forgot to add it
earlier, so nothing more fair than add it now!

Thanks,


Guilherme

> Cc: stable@vger.kernel.org
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> [...]

