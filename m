Return-Path: <stable+bounces-204340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE8ACEBF46
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B7323021E48
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F23168F2;
	Wed, 31 Dec 2025 12:22:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B0313E2E
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183752; cv=none; b=YA1aHhAeC0K0RKvIsMlyE0CtaAb20ZsUH//X/AM03PsR2stvKKrjgHwdVCxR/AR7ZUW2LCTouPzBivCTBoeRSmBAGEfORCdHY+L0yqO/SOvFajV9m1K7Y6V1Fw/RsAcuwxIYbIdCHC95oO2Sz5RfYA1n7ykwrENNA/QPCRGNnUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183752; c=relaxed/simple;
	bh=dwTFABPGxJYfXw3t2TFwGWbGG4o5xq9aIlx7TKxMEH0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ob6bhpjHGpPq3R0PiXEv8GQ8jygvxHVY7riQcnzGB1WCNqFzvfwlvz7Sj3fLmoiylUvRVpVJ5eCnS6eIVGev83w1lbn+PGYXdfL0dED1AnB0SCjAzI4Uu2VWJzyh0YkCkPQyumYDsUkF2eXryoCloft/vagxlZUAEPVVpE12CqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07ecd7.dip0.t-ipconnect.de [91.7.236.215])
	by mail.itouring.de (Postfix) with ESMTPSA id ED0E71F24;
	Wed, 31 Dec 2025 13:22:25 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 0CBCF601D6001;
	Wed, 31 Dec 2025 13:22:25 +0100 (CET)
Subject: Re: Please add 127b90315ca0 ("sched/proxy: Yield the donor task") to
 6.12.y / 6.18.y
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Fernand Sieber <sieberf@amazon.com>
References: <04b82346-c38a-08e2-49d5-d64981eb7dae@applied-asynchrony.com>
 <20251231074543.64FC.409509F4@e16-tech.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <a81eabf5-db23-ba13-2a33-268d75f03681@applied-asynchrony.com>
Date: Wed, 31 Dec 2025 13:22:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251231074543.64FC.409509F4@e16-tech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-12-31 00:45, Wang Yugui wrote:
>> So please add 127b90315ca0 ("sched/proxy: Yield the donor task")
>> to 6.18.y/6.12.y. I know we're already in 6.18.3-rc1, but the
>> crasher seems reproducible.
> 
> Failed to apply 127b90315ca0 ("sched/proxy: Yield the donor task")
> to 6.12.y, because  the 'donor task‘ is a feature of 6.13.
> 
> commit af0c8b2bf67b25756f27644936e74fd9a6273bd2
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Oct 9 16:53:40 2024 -0700
> 
>      sched: Split scheduler and execution contexts
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/12/31

Since I no longer use 6.12 I was not sure if 6.12 is really affected due
to gradual proxy execution rollout and possible backports, but I guess
now we know. Thank you for the clarification. :)

cheers
Holger

