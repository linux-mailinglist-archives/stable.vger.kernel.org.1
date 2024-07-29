Return-Path: <stable+bounces-62579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6885093F8EA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5281F22C0E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC515380A;
	Mon, 29 Jul 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4HGTTfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53941C6D;
	Mon, 29 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265286; cv=none; b=bssZUygN6yt9kCSpHW4pm4Md7Lp1qf5PW3iIQw2iS6DGf71KMBZxXqV1OX5xTKRKmKdTULx7Gu2i5T/MJ5To4asZsJPgJRUJcPokhXp6M9UfnDa5skUF+09Z51VdB8mG0adfxQMV2q4Exsh46M8n/d9XS6P+KB0CkoAnJWSCgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265286; c=relaxed/simple;
	bh=3S/aA5lZazb/IORTIfCGNSidj934UTv5nyka8N3+Cs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juUjZEX/CHip2U9qGb59Cf5MmDXgRfblPFT4qTh6wgswgtauED4Cc9TWhgHPD8VTM+C5ywotcaAP7+Uk1WG5ZrEnqV4laapYYO5y1kzHq+X2zigNH3KUmyeF30fj7vmsigroRuZlz/gLmNDZ6SKplEcSwEWD8fjf6KCByvvilMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4HGTTfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B510AC32786;
	Mon, 29 Jul 2024 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722265285;
	bh=3S/aA5lZazb/IORTIfCGNSidj934UTv5nyka8N3+Cs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4HGTTfSLPo3muEIKY7XZwOcIa4Ot2N6uWffNwzvGbsMK3O7eUNtBdgEqFteDIo1C
	 6bTLEXOfa5EXC13nc+7T85z9yov+ynOxv6ivRWtn7TnPxfPBJrn0qWATqRTrnRaQXu
	 l/Y9iEeoVa1/c+/0qrwlHt72t5wOF0lLMHK1lbdBLlefNGEEQ0erZ8hi2IpT/EMkqr
	 Jkg/uRMgaAqjDr+EfFOfXMUaqMUpPHA8vKlXgINvDy+FPiiiA45U+xg+XH6EeEisZV
	 5O0LEuYIGEJGc/WF6tZepof4tlJfiUECVSE7lBrU2pmTUR9fx3+l1d3VttvVH8SYmI
	 xZ4T9pgiCpYOA==
Date: Mon, 29 Jul 2024 08:01:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, pabeni@redhat.com, idosch@nvidia.com,
 jiri@resnulli.us, amcohen@nvidia.com, horms@kernel.org,
 lirongqing@baidu.com, juntong.deng@outlook.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 08/27] rtnetlink: move rtnl_lock handling
 out of af_netlink
Message-ID: <20240729080123.7b66ce47@kernel.org>
In-Reply-To: <20240728005329.1723272-8-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
	<20240728005329.1723272-8-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jul 2024 20:52:51 -0400 Sasha Levin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> [ Upstream commit 5380d64f8d766576ac5c0f627418b2d0e1d2641f ]
> 
> Now that we have an intermediate layer of code for handling
> rtnl-level netlink dump quirks, we can move the rtnl_lock
> taking there.
> 
> For dump handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE we can
> avoid taking rtnl_lock just to generate NLM_DONE, once again.

Not really a fix, FWIW, but not scary either so your call.

