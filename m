Return-Path: <stable+bounces-95380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10DD9D87F1
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF47B2830B
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0BF191F9E;
	Mon, 25 Nov 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wky8rANr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B218F5E;
	Mon, 25 Nov 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541658; cv=none; b=UmioEaUka3PS6m6chEv3wEch2S9E/RbnmsU/RtyIfwZ5zpjoCtrBBpZN6XX10rGL77+in8214hkcb2qiACicKYdJG2NQefKfl7nlv8q+G09uqHyvyDMW0CyJ/qO2STQpke1s5Yvfbap8uHuUGsH8Tfz4yQ5z2MZaODsR/Fukj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541658; c=relaxed/simple;
	bh=E5TXh9YOcQFKHtQwrOuvWT+AoBr1cww5+PqFRLtGInU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5sre89RzUl8+ZD7Wv/dxgP8sXoTkwhwEy+4xOEHjOplk/w8KVCpLM+WVk/U/wS8QaQMLfT1KXcZ1eq9FcYwgXSS78WgdBqd3S+eZD7Cnqz0epwTg4zixE85FqcSdNCAq5vMTlf85qganhe2gQkuleHYYrYSEZ9X6gvI/knLOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wky8rANr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C20C4CECE;
	Mon, 25 Nov 2024 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732541657;
	bh=E5TXh9YOcQFKHtQwrOuvWT+AoBr1cww5+PqFRLtGInU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wky8rANrJvu6LCwFi5rVTc+3Jq2ewwllmzSAhiIKIQdA2nD4sncIA4GDukGY9Lhd0
	 m1GYkUUGTjLabt4nGvfCUtirHj5r26H7/WkpY/4lpV4gEDBo8ZWc7JtjiiCeJDRe09
	 fD59l2yPlGdxh6w0bCCQpGXLC0Lj+vx7id6csYY/8XZ+PxFuLavMIl9cpfyr3JdOJy
	 Jo3emNh4Vt+aG9me2JPV5fcriU06nltXsyyzE424eejLZLCHQ7XhVwRHYRE6+sMSzK
	 dO7shyy4ouatXvxbnX6+G1WXv2yY28y93oVumlqkMTNZEL1PHGbBqSw1DMSl26k5NT
	 V9mUCG/L4wHrA==
Date: Mon, 25 Nov 2024 08:34:15 -0500
From: Sasha Levin <sashal@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	will@kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 3/5] locking/ww_mutex: Adjust to lockdep
 nest_lock requirements
Message-ID: <Z0R81y3MDp4xxMmg@sashalap>
References: <20241124124623.3337983-1-sashal@kernel.org>
 <20241124124623.3337983-3-sashal@kernel.org>
 <65ace546a7d55c2d6170ca88a48d3de402db2645.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ace546a7d55c2d6170ca88a48d3de402db2645.camel@linux.intel.com>

On Mon, Nov 25, 2024 at 11:06:38AM +0100, Thomas Hellström wrote:
>On Sun, 2024-11-24 at 07:46 -0500, Sasha Levin wrote:
>> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>
>> [ Upstream commit 823a566221a5639f6c69424897218e5d6431a970 ]
>>
>> When using mutex_acquire_nest() with a nest_lock, lockdep refcounts
>> the
>> number of acquired lockdep_maps of mutexes of the same class, and
>> also
>> keeps a pointer to the first acquired lockdep_map of a class. That
>> pointer
>> is then used for various comparison-, printing- and checking
>> purposes,
>> but there is no mechanism to actively ensure that lockdep_map stays
>> in
>> memory. Instead, a warning is printed if the lockdep_map is freed and
>> there are still held locks of the same lock class, even if the
>> lockdep_map
>> itself has been released.
>>
>> In the context of WW/WD transactions that means that if a user
>> unlocks
>> and frees a ww_mutex from within an ongoing ww transaction, and that
>> mutex happens to be the first ww_mutex grabbed in the transaction,
>> such a warning is printed and there might be a risk of a UAF.
>>
>> Note that this is only problem when lockdep is enabled and affects
>> only
>> dereferences of struct lockdep_map.
>>
>> Adjust to this by adding a fake lockdep_map to the acquired context
>> and
>> make sure it is the first acquired lockdep map of the associated
>> ww_mutex class. Then hold it for the duration of the WW/WD
>> transaction.
>>
>> This has the side effect that trying to lock a ww mutex *without* a
>> ww_acquire_context but where a such context has been acquire, we'd
>> see
>> a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
>> modify that particular test to not acquire a ww_acquire_context if it
>> is not going to be used.
>>
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link:
>> https://lkml.kernel.org/r/20241009092031.6356-1-thomas.hellstrom@linux.intel.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>It looks like the last version was not picked for this patch.
>
>https://lore.kernel.org/all/172918113162.1279674.6570518059490493206@2413ebb6fbb6/T/
>
>The version in this autosel patch regresses the locking api selftests
>and should not be backported. Same for the corresponding backports for
>6.11 and 6.6. Let me know if I should reply separately to those.

This is what ended up landing upstream...

I can drop it from the autosel queue, but if this has issues then you
should also fix it up upstream.

-- 
Thanks,
Sasha

