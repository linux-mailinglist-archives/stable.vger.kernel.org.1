Return-Path: <stable+bounces-83721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209CE99BF11
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3531F259F9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EE85260;
	Mon, 14 Oct 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL6GLHfE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8B804
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728879153; cv=none; b=HemGGadrINo5ACihhebFNlXFpO2kBSenZveWnRf/d+1ReJdIS3u6eepteOGW+BRIgrueRg6YyqpaTpfI+2A10cgq7HMCpG0pqfHAC0xY98chvykJezvA41LMdUTPkBAy0y8At2nJBS5W2pTbQLwjPKHhlFFF/ajgDEM82kJGmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728879153; c=relaxed/simple;
	bh=RIQXMzexzGIQ4bTGfFfCCt+ia1WE3jl0+awUhyXq2HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ0OFM5pAykUj8Hr7PgkG9ukpmdoP+tUr1WgcwQ5Sd2cUQ/tPMWk4SfRJ0poAWe1nNoeGFXg6zv0G1nUZLRAOtsNU7uFQby/3YFnO7m+9HLvZZrm3QORUfghclsYdN8piDNkHh8tV2EEyN+J3WMERqHfbYwq1VUbbqiY20QYiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL6GLHfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0518CC4CECE;
	Mon, 14 Oct 2024 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728879153;
	bh=RIQXMzexzGIQ4bTGfFfCCt+ia1WE3jl0+awUhyXq2HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lL6GLHfEaH2+TcAm6Q4DuyXJO/sorKNdBQbE0MGjnSzFghPRknWpD17ZXAFt4lPaY
	 lG69eUgB8TiBy+eW+NrCWXRzSlGXPdI1W60BwF2zsVhcirq6VT4mNlkul0LcxSZoW7
	 H2HxgCohzH2KnLt0BjVzs4wjiCqaB68rr4xRYULC21rMg5J2pWuq4WWGkdbjzum//y
	 UNiSOK8ysaywJkP/Hgsk94/vBr3CU1cAbfWqeBu9eHyovuxIzSXd/jzSA8XEvG8Jhy
	 TihQX1/lvP2GatZFv7bnzTFLJEY6kSBfg0qUqQ3A9L7sTjGM4zdJjmonPamccm3+Ap
	 VG1jf2zH/F8ZA==
Date: Mon, 14 Oct 2024 00:12:30 -0400
From: Sasha Levin <sashal@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, boqun.feng@gmail.com, bvanassche@acm.org,
	gregkh@linuxfoundation.org, longman@redhat.com, paulmck@kernel.org,
	xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com,
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp,
	peterz@infradead.org
Subject: Re: [PATCH 5.4.y 0/4] lockdep: deadlock fix and dependencies
Message-ID: <ZwyaLiOEz9OS4oet@sashalap>
References: <20241012232244.2768048-1-cmllamas@google.com>
 <ZwvX3kxg6OoarzW9@sashalap>
 <ZwvnXnLRLCiNhfmk@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwvnXnLRLCiNhfmk@google.com>

On Sun, Oct 13, 2024 at 03:29:34PM +0000, Carlos Llamas wrote:
>On Sun, Oct 13, 2024 at 10:23:26AM -0400, Sasha Levin wrote:
>> On Sat, Oct 12, 2024 at 11:22:40PM +0000, Carlos Llamas wrote:
>> > This patchset adds the dependencies to apply commit a6f88ac32c6e
>> > ("lockdep: fix deadlock issue between lockdep and rcu") to the
>> > 5.4-stable tree. See the "FAILED" report at [1].
>> >
>> > Note the dependencies actually fix a UAF and a bad recursion pattern.
>> > Thus it makes sense to also backport them.
>>
>> Hm, it does not seem to apply on 5.4 for me. Could you please take a
>> look?
>
>I'm not sure where the disconnect is, I am able to do ...
>
>$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
>$ git fetch FETCH_HEAD
>$ b4 shazam https://lore.kernel.org/all/20241012232244.2768048-1-cmllamas@google.com/
>
>... with no issues. I don't have anything on my gitconfig that would
>change the default behavior of `git am` or `git cherry-pick` either.
>
>Anything else I should try or look into?

Sorry, my bad, now queued up.

-- 
Thanks,
Sasha

