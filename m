Return-Path: <stable+bounces-172693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F2B32DEB
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FCE24462D
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF2246333;
	Sun, 24 Aug 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTGbV9DL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540624676B
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019292; cv=none; b=mg5n4nhtipbU5C/Mb41WpZDXcIxGxWyvpC7gBdmxa4qs1D129r7v7SQxq4wXQUcg8Wq/pcOyUt57VnJo1njVnTGC7VJMkR6fZBfzL7kWfq/mXaVt4kl+ayygUASYu8nPC0ZKDtg0R3be4rN31M6zuUDGCrosN18HxOY6391GeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019292; c=relaxed/simple;
	bh=RVi5rw3ygisCNDJ0WHx5Xri4Lm5WxorDO5e3gTAJsoQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UxxoXkvi/TPIXQG+OrFDeP7xD5aBS/HlUyeuyCZRGWwmTJax/Ij8NTRZifaWTOEvcqGjG5rnLoYK8UZcTqI/b4Fb42znaTGYFxz0QReEJIhgORZMW879kW2MVgpgRNXe5yb2yyQK3Dgda0Q7a5L1/ByLqKeLvxQMv0wNCWkgq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTGbV9DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF30C4CEEB;
	Sun, 24 Aug 2025 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756019292;
	bh=RVi5rw3ygisCNDJ0WHx5Xri4Lm5WxorDO5e3gTAJsoQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MTGbV9DLtw8GKXJ0TKDOp7lRNAlkpECbLYyyF5Q7sN0yIQUxtPA2BvcLiMAuE5gSA
	 fvLpbScggdIyhcdthDtff/uyVExzho2LdgOsVYfeT9nvz6FaWD8tnMuwFL3szKD1dg
	 OGBbDpQgb6NXlDNgmsUj/G4KWTBAEi81sq+aFYvgjiz87vkBfJ6eq6+mO/EMlyttv2
	 H53pfCFfED85H38fKueDvkyoSVLMRJN15sKd7fUwI4RH+vurCemzaqt7/i6MW1ogpN
	 gPokGfrUNn/X3VhcBUxzAPStVV3/LGGZR0A2ShxUHttLWAgDOU0aD/9jqr82RuMSYb
	 HM6xuRbRdYMPA==
Date: Sun, 24 Aug 2025 09:08:06 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Message-ID: <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org>
In-Reply-To: <2025082442-relatable-obstinate-7f10@gregkh>
References: <2025082230-overlay-latitude-1a75@gregkh> <20250823143406.2247894-1-sashal@kernel.org> <2025082442-relatable-obstinate-7f10@gregkh>
Subject: Re: [PATCH 6.1.y] mptcp: remove duplicate sk_reset_timer call
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <e39b9a56-90c5-4379-bc6a-22a719c67848@kernel.org>

Hi Greg, Sasha,

24 Aug 2025 09:02:56 Greg KH <gregkh@linuxfoundation.org>:

> On Sat, Aug 23, 2025 at 10:34:06AM -0400, Sasha Levin wrote:
>> From: Geliang Tang <geliang@kernel.org>
>>
>> [ Upstream commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be ]
>>
>> sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
>>
>> Simplify the code by using a 'goto' statement to eliminate the
>> duplication.
>>
>> Note that this is not a fix, but it will help backporting the following
>> patch. The same "Fixes" tag has been added for this reason.
>>
>> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> [ adjusted function location from pm.c to pm_netlink.c ]
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>> net/mptcp/pm_netlink.c | 5 ++---
>> 1 file changed, 2 insertions(+), 3 deletions(-)
>
> Didn't apply cleanly :(

I don't know if it is the reason, but I sent the same patches on Friday:

https://lore.kernel.org/20250822141124.49727-5-matttbe@kernel.org/T

Cheers,
Matt

