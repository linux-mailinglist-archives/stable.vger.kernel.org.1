Return-Path: <stable+bounces-83600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08999B71E
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 23:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BCF1F21D78
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB542137750;
	Sat, 12 Oct 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUbEZod6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC512C549
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728767121; cv=none; b=CsKCUncjvyoiCBoxmQIqxUqUtoraZ22o+Eddt4c/tZ3OgQTrWTDyLN4ROsO1waDS/uIdmhvWZfzqLhtzMQ3wXSQ8+Dfg9O+X4dgOwEHoZeTsajelmJGOkfaynFVUOvnrczbTlDK2nsMqHu4veJdkgnEfCUmdt8JosG6eh9/v4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728767121; c=relaxed/simple;
	bh=xSY62ssdfWEkMQ4af/3EM7KfyGoPiG7svrPvEmt//S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxSpcXSqzPiTTUDz6xuGScFHmZqVo3XM6a5SgrkZ534u+g3liToCcTOj2+eb9Qz96EHpbPelYvFLAS9zfO1TgwQGgiWwEkws2G9/CNzA9XrdPGtFkvAC6X7A0KGhOqw+zDNL1Z2Y5ZY2+bIUjoMrMfzuj/qvNrH0oO0TEtiKZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUbEZod6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CCBC4CEC6;
	Sat, 12 Oct 2024 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728767121;
	bh=xSY62ssdfWEkMQ4af/3EM7KfyGoPiG7svrPvEmt//S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUbEZod60HUuQKIRUxB4aTNG9XWxDIhNa4/oofyTeu8cmnaevcN7xxWIL7wM/Zd6r
	 vfmtjjSKfbHOi6ylohxXuLl7CMHgj/FMZaSTPtWsa1GyUF7fm7ktCIPCtBFTKppILe
	 rJKbi1o5sAPSvNfS6UHf34lOLgSKDToGX56ttMz5rIWCvp52M4Tu4DkA25XPEqf7mx
	 sHEbO3y1SXfPFW82QqPfTcXKklkqINH8d8nX/vaiZchcvjWzYP9yvBxwoH7qTn3pnH
	 uRp+oYgdLjXKndjy0sZLlGBmkEEkYVekLWRc1v1Uf91vvh9S8RVbLAK2vRLmxsYl5j
	 9EksCpMLWZIFA==
Date: Sat, 12 Oct 2024 17:05:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: gregkh@linuxfoundation.org, zhiguo.niu@unisoc.com, boqun.feng@gmail.com,
	bvanassche@acm.org, longman@redhat.com, paulmck@kernel.org,
	xuewen.yan@unisoc.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] lockdep: fix deadlock issue between
 lockdep and rcu" failed to apply to 5.4-stable tree
Message-ID: <Zwrkj6GC2wT11kb3@sashalap>
References: <2024100226-unselfish-triangle-e5eb@gregkh>
 <ZwgdAXfbCDYmc8hd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZwgdAXfbCDYmc8hd@google.com>

On Thu, Oct 10, 2024 at 06:29:21PM +0000, Carlos Llamas wrote:
>On Wed, Oct 02, 2024 at 12:07:26PM +0200, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 5.4-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x a6f88ac32c6e63e69c595bfae220d8641704c9b7
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100226-unselfish-triangle-e5eb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
>>
>> Possible dependencies:
>>
>> a6f88ac32c6e ("lockdep: fix deadlock issue between lockdep and rcu")
>> 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
>> 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
>> 10476e630422 ("locking/lockdep: Fix bad recursion pattern")
>> 25016bd7f4ca ("locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()")
>>
>> thanks,
>>
>> greg k-h
>
>These 3 commits are the actual dependencies:
>
>[1] 61cc4534b655 ("locking/lockdep: Avoid potential access of invalid memory in lock_class")
>[2] 248efb2158f1 ("locking/lockdep: Rework lockdep_lock")
>[3] 10476e630422 ("locking/lockdep: Fix bad recursion pattern")
>
>It seems to me that [1] and [3] are fixes we would also want in 5.4.
>Possibly also [2] just to make the cherry-picks cleaner. If there are no
>objections I can send a patchset for linux-5.4.y with all 4?

SGTM!

-- 
Thanks,
Sasha

