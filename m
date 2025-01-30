Return-Path: <stable+bounces-111735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694A9A234A7
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1493A68B0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CF1F0E43;
	Thu, 30 Jan 2025 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g9FRBouu"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644A1F0E31;
	Thu, 30 Jan 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738265112; cv=none; b=Bk8rwpKFucMZqay533RDjnFjbtBCDqJr+Sb3+JBQ5YnB6gEVyw6X+ZODsP6u/mTAaObNfMz1znR04p1s/5VFgI37qEHZw1YWQSFywcXEslTITLnrmAftnj1gIQ42w9UvU6MBaeUBKdbySqrPJ7aD6mGNVWRqbhC3iCFfEnlzOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738265112; c=relaxed/simple;
	bh=18EYZOBDXNsu3dP9llIaKkawzOK0pE4vgmfpNqOdGZY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MjCfLGgrGz/LVkjUa3eScGEZDIO/MgDlT5wpdX6zPtx/L7RcjedzZWU/4AkmaKQ1eV070PU1CYJw1rdiGpYOm+EYgQ+UsLOc15w0iQjZY0xXzPP5U7D/Sxlf4J6so1rf5aNxabQ+/qgeMNNCEG41CXrtcROE35YDz/KYkxaxXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g9FRBouu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.198] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2DDE2109CFC;
	Thu, 30 Jan 2025 11:25:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2DDE2109CFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738265111;
	bh=FRQDNQ5jqHLRQEmoSH6eZ1ATi7j8pDr2J26ff5bsINM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g9FRBouuEG05Rz3vThtVHfIoZ7df+Mf9dLJr0M6zOPV/Dy8Q+S7kzz/daKQsV5+Ly
	 sDPsFfe4qkmiiOvFsixJt/OtCn9oYJj3mArxJGKj4tPIzRfN+YmGhXjgyMH6AP2e6w
	 RJ00en0W07m10GepoRKJPoHId0ydj5c0PjJdZLpo=
Message-ID: <085b4f6b-0399-4b77-a2af-9bf2e19e5f62@linux.microsoft.com>
Date: Thu, 30 Jan 2025 11:25:10 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 eahariha@linux.microsoft.com, stable@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] jiffies: Cast to unsigned long for secs_to_jiffies()
 conversion
To: Thomas Gleixner <tglx@linutronix.de>
References: <20250130184320.69553-1-eahariha@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250130184320.69553-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/2025 10:43 AM, Easwar Hariharan wrote:
> While converting users of msecs_to_jiffies(), lkp reported that some
> range checks would always be true because of the mismatch between the
> implied int value of secs_to_jiffies() vs the unsigned long
> return value of the msecs_to_jiffies() calls it was replacing. Fix this
> by casting secs_to_jiffies() values as unsigned long.
> 
> Fixes: b35108a51cf7ba ("jiffies: Define secs_to_jiffies()")
> CC: stable@vger.kernel.org # 6.12+

Sorry, this should be 6.13+ since secs_to_jiffies() was introduced in
6.13-rc1, not 6.12-rc1. I was mislead by git describe output. Let me
send this as a v2.

Thanks,
Easwar (he/him)

