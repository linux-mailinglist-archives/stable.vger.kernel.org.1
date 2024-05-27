Return-Path: <stable+bounces-46471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F388D05B5
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8801F27159
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F70161B58;
	Mon, 27 May 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZqUrYaCR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XhigBucf"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99436161B7C
	for <stable@vger.kernel.org>; Mon, 27 May 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822068; cv=none; b=B9lTT9AybnVpUxzaK+0/Tgq4PTultCaskdT5bPKme72TjJ3Pd/sP6QbeILVLF4odH8wmIOSUpZetWPHTJhfEytjDBzBcv2NLDSYPXWmYyWDiRBUQNPQj7tIqqooiNrp+caATYlfXEPKTg+wNpo78omvtBsEnoY54xbDYBazr/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822068; c=relaxed/simple;
	bh=EVhJcjl6XAhszzrgGYGIKJav7WyG+0MSoyHN3ppak2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJdBW7rts6kpYoSWZyYAwOsuv36CBXLiS2t6pemsqGhhQrKAepx/0Bb5rl0FPVS92yEyxgkYA7JbPZCL3m3HD2WTmLxWkrs619A7wnFWDwPsc819Q6ZAWbaiYv/6fIuv/tlYXoAnhqS+lSW84H40u3+Jl1AxerZSVuoU+rzMr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZqUrYaCR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XhigBucf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716822064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6HJNxD8+WmFeUBZh0tEce3JmTfcscnrPTvYzZD7Xyw=;
	b=ZqUrYaCRFIlJLZLHXcpIvwu/iB4Hi0uJ+OzCAx60qZp5VxSjiWqrWNvUqw6hCvJKUL0NRl
	/zR29lREaoans2H2HRbr8l9Cqkcmv2/a+/QybD2pF3EX9pRIMJduRa8BQ/j2x+VEAKnHn9
	51PfRmU9p+XjOVL1t2KpiPV8e4UgcV7kfFSUjvxanqqT0cxBtSKSq3D4fgBTpgCJeCTF8+
	INo2xztxdZ2ts5SDzGde6IjkjragLUHbxxP/xwno/X6uKF2X9kWDpJA12FvJw4si2bGUYx
	artD50+4TKa+kSp7rXmHTIg4B8zG5PYyR8ugAmKN0dLlB1pLEZ/o6XgDz6jQog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716822064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6HJNxD8+WmFeUBZh0tEce3JmTfcscnrPTvYzZD7Xyw=;
	b=XhigBucfPdhUpvxdfsy92Tk4uMTfZ8+prclZhlZNMplVHT+2ErQeIm3pQCMmeB9/XZrz+z
	96XWwLZunaTrhVAw==
To: Tim Teichmann <teichmanntim@outlook.de>, Christian Heusel
 <christian@heusel.eu>
Cc: regressions@lists.linux.dev, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
In-Reply-To: <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
 <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
Date: Mon, 27 May 2024 17:01:04 +0200
Message-ID: <874jajcn9r.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tim!

On Mon, May 27 2024 at 14:35, Tim Teichmann wrote:
> On 27/05/2024 12:06, Thomas Gleixner wrote:
>> Christian! On Sat, May 25 2024 at 02:12, Christian Heusel wrote:
>>> On 24/05/25 12:24AM, Thomas Gleixner wrote:
>>>> Can you please provide the full boot log as the information which 
>>>> leads up to the symptom is obviously more interesting than the 
>>>> symptom itself. 
>>> I have attached the full dmesg of an example of a bad boot (from 
>>> doing the bisection), sorry that I missed that when putting together 
>>> the initial report! 
>> Thanks for the data. Can you please provide the output of # cat 
>> /proc/cpuinfo from a working kernel? Thanks, tglx 
>
> Right here is the output of

Thanks for this. Can you also provide the output of:

# cpuid -r

please?

Thanks,

        tglx

