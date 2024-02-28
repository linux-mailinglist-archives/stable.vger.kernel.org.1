Return-Path: <stable+bounces-25410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7386B652
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA61B1F29278
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354115CD42;
	Wed, 28 Feb 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/N62xO+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399715D5DE
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142388; cv=none; b=PXioXrNjRB/nG3kG0LMOfA1hm2dyOF7xzeUwdRwg0C8F3xj/QFLGC7HR1etjLbIYJr85WSRnqWptp093+JHISovkXYWC15elNeDeJnn/9EyughhlIgwoZlreE0+4A1wh522UFoqGTO5uJOstyw2pct6dzdgfZfJjX8F5e2wrKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142388; c=relaxed/simple;
	bh=5LL6WGSdPxxAJpu8nK2XpD1UPa3fDqynvf5qXRX67us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh0L8BiTYeQ7B4gLusH+bDaDdTZONZJxCvI0hYD2YQK8yqIK4usj8brtEP+KLw2RSBlcQGXWfLb8vsrV41WUWnqYkzlesVHczvbtYPMTiMJB0uDP/A7GVDmKQUt5eSr/Lk5MIlIGEVhfYufRfMqQKrvZWovaviWbcM9Z27GWFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/N62xO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60804C433F1;
	Wed, 28 Feb 2024 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709142387;
	bh=5LL6WGSdPxxAJpu8nK2XpD1UPa3fDqynvf5qXRX67us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C/N62xO+mbkRexw7z3+YBnO+N/RRVju3uZnlANoV9mGwAaKI+4GmHbelrjnSKrTHl
	 ITqiUycHuRN1uQkFOo3t8l12XckUQk6nwC9e9Ly67890E4Pb0c/uQsF+CY+YP9d8PL
	 r/4Iy2xbNYDpME9WS8TLTvqB46cD/GRNtES3J8dWMSw6Sw2uiH9Ebe7g/QnDDp6Cp4
	 Mxrpl/xgEZP34TNslZxFF+kiHH8dMvcxtii/jnFFILHkqU8FEEiPOdJCow5UvCjIum
	 kzDhtORTYm2GYM6vLupOrVyiGezRsv+rr0IbDW5sXVqOhYk9L2JcEC+ahEXxZKHztM
	 bsZdAXj8pjGCA==
Message-ID: <a9a7b0d9-ca9a-4233-b8b2-95bcdb7ab53c@kernel.org>
Date: Wed, 28 Feb 2024 18:46:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mptcp: fix data races on local_id" failed
 to apply to 5.15-stable tree
Content-Language: en-GB, fr-BE
To: gregkh@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net,
 martineau@kernel.org
Cc: stable@vger.kernel.org
References: <2024022610-approval-winking-e3d7@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024022610-approval-winking-e3d7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 26/02/2024 14:17, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.

(...)

> Possible dependencies:
> 
> a7cfe7766370 ("mptcp: fix data races on local_id")
> 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
> f1f26512a9bf ("mptcp: use plain bool instead of custom binary enum")
> 1e07938e29c5 ("net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}")
> 1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
> fce68b03086f ("mptcp: add scheduled in mptcp_subflow_context")
> 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> 740ebe35bd3f ("mptcp: add struct mptcp_sched_ops")
> a7384f391875 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

(...)

> From a7cfe776637004a4c938fde78be4bd608c32c3ef Mon Sep 17 00:00:00 2001
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Thu, 15 Feb 2024 19:25:31 +0100
> Subject: [PATCH] mptcp: fix data races on local_id
> 
> The local address id is accessed lockless by the NL PM, add
> all the required ONCE annotation. There is a caveat: the local
> id can be initialized late in the subflow life-cycle, and its
> validity is controlled by the local_id_valid flag.
> 
> Remove such flag and encode the validity in the local_id field
> itself with negative value before initialization. That allows
> accessing the field consistently with a single read operation.

FYI, because of the various conflicts, and because the issue seems
unlikely is quite harmless -- e.g. a duplicated subflow is created --, I
think it is better not to try to backport this patch to v5.15 and older.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

