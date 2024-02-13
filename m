Return-Path: <stable+bounces-19705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067B853067
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F111F22D78
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7F3D994;
	Tue, 13 Feb 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2MEDRpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAF3D971
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826807; cv=none; b=NJEIOxo1bF7GBpjgz0YiPkRrNpytbRyTIMsRQLTYeFItIQ27fLO55Xg2v4VQHwYwgOHJSpfkSOjCLyKXcCcaJ4TPa7UiQEo1eUZhdZFF4UqW4Fm4cOYPtw/0DGu7zyVwL2cE4fH9rmcDMwFgkbfzALiBCt1bKYagpOjtGGk2sHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826807; c=relaxed/simple;
	bh=mY95AT+CYoGsbt+K6KCYklkdDC6Nc+GrFAFZ4GJk5DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLy2oSeQvCtsjsG1cSu/7Q/OiDgozU1EMGjfRRC/kAMJf/CDR0lG8/ZBXNTnGvFFoTDdsQaUzlLf3CciwVOBoo6tvbODtZQae91xU8q8tPdPSy19Zr3K4e2V8H1fzodfUWpoFd66qT9k4iLeKJmURHL/y7OCu3uL1a0Wjd3KSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2MEDRpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9959C433C7;
	Tue, 13 Feb 2024 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707826807;
	bh=mY95AT+CYoGsbt+K6KCYklkdDC6Nc+GrFAFZ4GJk5DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2MEDRpzU23YTa9fEZrGoDDegxJh0reXULnH7JqLtJUviPAlc6EhlcYpcgKqlO4AJ
	 2kjnCn1Fy5SgG8bdRXpfYhJfNSfYd53GwyZDhSD3zqzLhP2UmxvlALlJh4j0QTh8kN
	 9vgFY5zpF0DYJZJyJZCFrsGOQVXdkcgYog32rwhEsPZZdpKUg7MqSfjWDH4rl0R7+b
	 iC9XaAXRAWVtDdja9a8j1dU19+P1ocqm8GCapYMUBWxW7hmyCUInVur2yx4ncHLpmd
	 GK5/1Vk70x1+Dyf11dv+oEztb3uyT8uW0ivKgOfgbJo7kmhjmToyXJtDq4kWqd03ed
	 Da2w5NFtrwYLA==
Date: Tue, 13 Feb 2024 07:20:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com,
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com,
	carnil@debian.org
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
Message-ID: <ZctedYIYhNlX_HAz@sashalap>
References: <20240209162658.70763-2-jrife@google.com>
 <ZcZ0Tb13ZG9knz_P@sashalap>
 <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com>
 <Zcj17ysVY9kU8xVs@sashalap>
 <CADKFtnRk9HG0=SPhqCG-72eG8Hb4dMoWjUCV6Wur_uQgGKEWPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADKFtnRk9HG0=SPhqCG-72eG8Hb4dMoWjUCV6Wur_uQgGKEWPQ@mail.gmail.com>

On Sun, Feb 11, 2024 at 09:30:02AM -0800, Jordan Rife wrote:
>Sasha,
>
>OK, fair enough. I will send out another patch to backport c51c9cd ("fs:
>>> >dlm: don't put dlm_local_addrs on heap") to 6.1.

Already queued up, thanks :)

-- 
Thanks,
Sasha

