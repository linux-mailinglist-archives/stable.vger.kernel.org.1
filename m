Return-Path: <stable+bounces-67504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB4950873
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD84B2354B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5119F46C;
	Tue, 13 Aug 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="WTq/3soM"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02C19EEA4
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561536; cv=none; b=r2uOMvY0CqjoSIFTCe1UJzD92bB3M9Qag7EVV2QQzlebt1gR1+OKOvCGOdLEYYccvZU7m1uuMmPCJH60UYKexuxNl2utmCQLj3l/vujNJDIKKyuomYlrYXmDl+pvV4LDEGNyOjfVEX8OT+G2fwqD+7t79UghAPnqzDD4rCnMAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561536; c=relaxed/simple;
	bh=kTpXdxzroFSgbIsFrE360Owkl7seIditzzIjeuS4eho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx7FBQESw8odTAwsivBisS7qGqDN+o+sn03+JncRTeGzqG4BSoIPLsMR2oE/VW0nimxNd8V0fszHmflrhwjJTsmUGnJFAVrDSnAfl2nZLibvGvTDukPxtcpV6aktgtG+AZFYP2hBK5D0HdtacsRX2jdDfUYZZ3GoPl5WZMHWdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=WTq/3soM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Message-ID: <ef63bf73-18fc-471a-a8a0-c1eedcc47491@holm.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1723561530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnHW7TTDdCA8zU1Z5ULCGl64SaCeP5gQoJdh/7OfhBI=;
	b=WTq/3soMD9ONG+ZTvK6rBkip13UXkb3KiYVeGtA8fphk2tqsmqxyJV2ibtmX8UN4qutHBM
	JayfQfX+qZgFZFLl4+Y5u3w7Ym/23aCMj/LhHtwNhXlHtidgigCEhpuqyz8HHR9bKtymon
	CCQ7z3ZhibT09g2e8KstuFmidy47V7OF+GE0chywTAGmDCf++EgpO5rg52EDjnUL1LLGWq
	Mpbdi0VqqHTlC6eQsw33p37P18A59gMM8YkPBMDm7IxjdrltnZkIHiaN0KjrnJYCS/tepg
	sjs6iJZ5wMPGwkwwaLSrUI4grnRy8UxBA0Ty5xJNZQRiOvSFaWHp6uysPKwCUA==
Date: Tue, 13 Aug 2024 17:05:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.10 257/263] drm/amd/display: Defer handling mst up
 request in resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
References: <20240812160146.517184156@linuxfoundation.org>
 <20240812160156.489958533@linuxfoundation.org>
 <235aa62e-271e-4e2b-b308-e29b561d6419@holm.dev>
 <2024081345-eggnog-unease-7b3c@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kevin Holm <kevin@holm.dev>
In-Reply-To: <2024081345-eggnog-unease-7b3c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/13/24 16:21, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 02:56:18PM +0200, Kevin Holm wrote:
>>
>> On 8/12/24 18:04, Greg Kroah-Hartman wrote:
>>> 6.10-stable review patch.  If anyone has any objections, please let me know.
>> This patch seems to cause problems with my external screens not getting a signal
>> after my laptop wakes up from sleep.
>>
>> The problem occurs on my Lenovo P14s Gen 2 (type 21A0) connected to a lenovo
>> usb-c dock (type 40AS) with two 4k display port screens connected. My Laptop
>> screen wakes up normally, the two external displays are still detected by my
>> system and shown in the kde system settings, but they show no image.
>>
>> The problem only occurs after putting my system to sleep, not on first boot.
>>
>> I didn't do a full git bisect, I only tested the full rc and then a build a
>> kernel with this patch reverted, reverting only this patch solved the problem.
> 
> Is this also an issue in 6.11-rc3?

No, with 6.11-rc3 my monitors work as expected both on boot and when waking up
from sleep.

~kevin

> thanks,
> 
> greg k-h


