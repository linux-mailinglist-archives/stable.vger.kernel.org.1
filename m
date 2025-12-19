Return-Path: <stable+bounces-203102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C347ECD0E4E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB2E307929F
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437C36B05B;
	Fri, 19 Dec 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mv/YEEph"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA336B057
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159799; cv=none; b=ZeIn8mVr3RMZ2i2ci5M4d46fZuDUD+K/R7Qwnso3u2qese8rDI/a4Y7NdVQn9jna5ejGpBH2AiyU5JKwKu1nrMwUk3EpQYOZ4+4wPH2HRN8Gdn0RdlLTba9DI9/M+HqAFfZKWVaf2nLW1z46SqfvQiQswZ3KKdybCVozXumlxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159799; c=relaxed/simple;
	bh=BCfq1sPC8zJlN38d7ugohDIyHGPm9Ul05BmqUVEKpMs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QiaoYrH7Ez14VBKiV9G0pICK6XK6VowiPJRysd/t5CytnnM8s8sMGRKrI5/hT5Tk229cibbZ4YonE5UcrgA+iYqQsqPNjIU7DcrRQJk1eukDguzy3lOcK4s39jQcSwNe0/uMnTn20Fbg+yCLRjglIgkxkXOQ90Sskl73pZ8HNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mv/YEEph; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766159795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc3v+gETzmXyCKJzI7in9efvxgfKV9X68r+h/s/HAHw=;
	b=mv/YEEphH7naEiiPDOlXVnh6ERVsyUFgqJDIt6iMeq5brfSqGVWLIeDkryNRw3z23UZfva
	z21HuWNWXw9ZeS8xiBenVJHfRLeiSmb73QbK8GiCc+R844uDnQ+P1OrC0medabcQCs18Kx
	yuIpC1LMKjjadw4KSKsc2jYxPtGhOgM=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] cpufreq: amd_freq_sensitivity: Fix sensitivity clamping
 in amd_powersave_bias_target
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20251202190904.27c9bc06@pumpkin>
Date: Fri, 19 Dec 2025 16:55:02 +0100
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thomas Renninger <trenn@suse.de>,
 Borislav Petkov <bp@suse.de>,
 Jacob Shin <jacob.shin@amd.com>,
 stable@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3F396FA4-8DB6-451E-BF58-02646808FC3B@linux.dev>
References: <20251202124427.418165-2-thorsten.blum@linux.dev>
 <20251202190904.27c9bc06@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2. Dec 2025, at 20:09, David Laight wrote:
> On Tue,  2 Dec 2025 13:44:28 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
>> The local variable 'sensitivity' was never clamped to 0 or
>> POWERSAVE_BIAS_MAX because the return value of clamp() was not used. Fix
>> this by assigning the clamped value back to 'sensitivity'.
> 
> This actually makes no difference
> (assuming od_tuners->powersave_bias <= POWERSAVE_BIAS_MAX).
> The only use of 'sensitivity' is the test at the end of the diff.
> 
> So I think you could just delete the line.

The local variable 'sensitivity' is an 'int', while '->powersave_bias'
is an 'unsigned int'. If 'sensitivity' were ever negative, it would be
converted to an 'unsigned int', producing an incorrect result. That's
probably what the clamping was meant to prevent.

However, calculating 'sensitivity' can be simplified from:

	sensitivity = POWERSAVE_BIAS_MAX -
		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);

to:

	sensitivity = POWERSAVE_BIAS_MAX * d_actual / d_reference;

which makes it clearer that, in practice, 'sensitivity' is never
negative. How about simplifying the formula as above, changing
'sensitivity' to 'unsigned int', and removing the clamping?

Thanks,
Thorsten


