Return-Path: <stable+bounces-9271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C68230AE
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2731C23799
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D61A73F;
	Wed,  3 Jan 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWO8kaBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD731B26E;
	Wed,  3 Jan 2024 15:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7673FC433C7;
	Wed,  3 Jan 2024 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704296310;
	bh=j4CKFm4QyoiuZcjYsJJZiQW0OE/euYVulADdZIAEL1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWO8kaBYwn1a66Tbdr8uOQXpPdSaCYuu/lYqEtzX3gdI2ZE6GorSXwAdT++E8Dh6X
	 Yfb4jhy7k1ase4KReKPVGR4jybyWatsdTmO4AmBrZzUwp7xA0p9xDCkJC3D9ovLgyo
	 +GGKfZ3XstirY1uJDLfJr6Oj4o1q96Ld+qJXjNpsIjRkQCHrk/j7B7TErDghU5SKGI
	 rmbOuu0UsDahbZfK+IodTYC1Zrum7oTlm6HqLWJg2h8jf8rLyTq4EAREU4msGrbWmy
	 soMU4njy6cPcODss5dTXRNBsRXxsV6Rlc/bGuZwN4SieXvkWgWmK3o8T9fmSIz3KtX
	 zTL/NUubenr6g==
Message-ID: <37a6dd80-6914-4865-967a-9dfa90f1adea@kernel.org>
Date: Wed, 3 Jan 2024 08:38:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] rtnetlink: allow to set iface down before
 enslaving it
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-2-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240103094846.2397083-2-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/24 2:48 AM, Nicolas Dichtel wrote:
> The below commit adds support for:
>> ip link set dummy0 down
>> ip link set dummy0 master bond0 up
> 
> but breaks the opposite:
>> ip link set dummy0 up
>> ip link set dummy0 master bond0 down
> 
> Let's add a workaround to have both commands working.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Acked-by: Phil Sutter <phil@nwl.cc>
> ---
>  net/core/rtnetlink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


