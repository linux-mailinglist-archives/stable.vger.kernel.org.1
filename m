Return-Path: <stable+bounces-28496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B8881696
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 18:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5921F2454E
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD246A00B;
	Wed, 20 Mar 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gveCcuVZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42B42057
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955837; cv=none; b=NJp6PecpAE94x43BP1R8WGt0V/yMK7N1Wsr4yNqcNFgYHyxNcDwNHaYXhjFAR1kY2kZ49lar44Ruj2HfjbOqg7b568DpebUvooesZWnVt/whhJDbuTI7sUF4aQaYxU6EqWtYwLCxkyQTSuP0nlrnVyE/Rnzvw9l8q6YeldsTsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955837; c=relaxed/simple;
	bh=kKtBTClajNiE+hQVth4TVFu1pqCTIAOQ5/7sxtplWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVFniYryuhuGhqrrUlN+BEIGIOusVLAwKdS+0pMy1QtDtXIekY2xVSSO7Rgxux3toVtcfyuLrTivBtBnwn3YluHVCSLiABKOKJMvzqjLaTfgM8PSJE0O6f8+Sd3pbKaS+uhWQ8hlV5MUSuz/3GuMIfp9cOXOeZPF+Q4mykj3rEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gveCcuVZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.129.161] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 130AD20B74C0;
	Wed, 20 Mar 2024 10:30:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 130AD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710955830;
	bh=fSlVtU2BQGlipYL2cCxd/6wRkwACBD+WgpCM1Ei+Di4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gveCcuVZRk7Xfgue55ZkRnoCh1JtUWFNL7u5fq1PqRqMsPc6VpjYxPTC1wzt/za2e
	 oL6oIQKumCbCoymdeAYWWPkJWCrtEcVyQDAhQ4Y3X+mNhEMB+g2J5DRlmGj4CGinTP
	 oA1s4QTPIXHQidebqe5+FtJUx9SQL+ZrNgSB6T1Q=
Message-ID: <de88a013-8536-45c0-9344-5692fb3f0648@linux.microsoft.com>
Date: Wed, 20 Mar 2024 10:30:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] ACPI: CPPC: Use access_width over bit_width for
 system memory accesses
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Jarred White <jarredwhite@linux.microsoft.com>
References: <6df99ad6-0402-4dcf-9a1c-7259436768dd@linux.microsoft.com>
 <ZfsDWPWr2FIz6eX4@sashalap>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <ZfsDWPWr2FIz6eX4@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/2024 8:40 AM, Sasha Levin wrote:
> On Tue, Mar 19, 2024 at 09:38:03AM -0700, Easwar Hariharan wrote:
>> Hi Greg, Sasha,
>>
>> commit 2f4a4d63a193be6fd530d180bb13c3592052904c upstream is marked for 5.15+ with CC: stable@vger.kernel.org, but the
>> application will fail with a merge conflict due to missing intermediate feature patches. When you apply the patch to 5.15,
>> could you take the backport below instead?
> 
> Hey Easwar,
> 
> Thanks for the early heads-up, but we can only take it after it's been
> in a released version (which should happen next week).
> 

Thanks for the guidance on merge window policy, I just wasn't sure if I would get a "FAILED" email this week 
and thought I could be a bit proactive with the fix.

- Easwar

