Return-Path: <stable+bounces-116506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6904A3707B
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751A01893F7A
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94ED1EA7DD;
	Sat, 15 Feb 2025 19:58:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5915696E
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739649489; cv=none; b=ovzfRrMkRPAaejyszuHY9D8pnqR87RbGqJ/puD6jKS+x97rhm+FPZLC24M3AGrkgPLe/Ct9ty0BQy0LzRwyqJyHagzjW8cyh11T1DKAbn79WgOguOZ3pTT5RPuT8q1ddmNM7O3w1leIcm1BNfP1jEZXNIv8vGJlpZXGiD7yjwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739649489; c=relaxed/simple;
	bh=8Agr4LCJvMont3sOn0Fa6/PrKDLRic6lEVvoPBKxio0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hOWRPdlbxuqBAuzqmD4creoOONJXWRMPwb/NSmFFZJ0jUu3V3eqdQ+EF/n9za0K3pSH+hpuFypghljHIqKZQ2hSA7F6d3IfhJ9Q0+wVJZJnlAVC32TvJO/yuVKzbE9ANXzP4cCWV21Jnsd+FN+23R/22+lh6O0Sfb/dC7UarwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd71dc.dip0.t-ipconnect.de [93.221.113.220])
	by mail.itouring.de (Postfix) with ESMTPSA id 364FB12566F;
	Sat, 15 Feb 2025 20:57:57 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id DD9136018E4C0;
	Sat, 15 Feb 2025 20:57:56 +0100 (CET)
Subject: Re: Suspend failures (was [PATCH 6.13 000/443] 6.13.3-rc1 review)
To: Waiman Long <llong@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Phil Auld <pauld@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
 <012c4a3a-ead8-4bba-8ec9-5d5297bbd60c@redhat.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <905eb8ab-2635-e030-b671-ab045b55f24c@applied-asynchrony.com>
Date: Sat, 15 Feb 2025 20:57:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <012c4a3a-ead8-4bba-8ec9-5d5297bbd60c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2025-02-15 02:35, Waiman Long wrote:
<snip>

> Commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> earlier for hotplug") is the last patch of the 3 patch series.
> 
>   1) commit 41d4200b7103 ("sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes")
>   2) commit d4742f6ed7ea ("sched/deadline: Correctly account for allocated bandwidth during hotplug")
>   3) commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> 
> It looks like 6.13.3-rc1 has patches 2 and 3, but not patch 1. It is
> possible that patch 3 has a dependency on patch 1. My suggestion is
> to either take patch 1 as well or none of them.
  
Now that we have 6.13.3-rc3 passing all tests I got curious and applied
the whole series again. And voila: suspend works reliably (3 out of 3).
Mystery solved.

So Greg, feel free to add the whole 3-part series in the next round.

cheers
Holger

