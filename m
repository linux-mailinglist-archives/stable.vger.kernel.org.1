Return-Path: <stable+bounces-58187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17841929910
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F531F2157E
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27F3CF51;
	Sun,  7 Jul 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjSw73es"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA03FBB2;
	Sun,  7 Jul 2024 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371614; cv=none; b=Si/4EmthsWoVXjsvrL50U9JLROKcOZ6OAfifYOlHpf6wAg53TEGFGHv6pHw2/6EiW0R1jjRpeJ1HrsK1Dm/2O0zojaR7fFslvzzDYPZBsUXmSwW0myQDRSCLSm3LKmBjy5TCM9du17oe6x8y1q4sWI0HhRcMqR1KTe88u+2QYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371614; c=relaxed/simple;
	bh=TcY99PhVj3Sil4uOX04B+/dXddJJozx8SjrmahT3UUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeofs2vPzXLRwC79cKJnC+06933ztnaXsWXReLoRHPdYbwOpkA0fQ0GWPCiALrTWuqFX0jjbL1dPcHNHPYy2U+aSUNGtWgtyhZXzAhF0NsraP4yI+DFFCL0f4A3bnWI8EW7jWG6y/hVla1BA94y2WrKH5/GrEx3HkdrxUdu2qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjSw73es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F6FC3277B;
	Sun,  7 Jul 2024 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371614;
	bh=TcY99PhVj3Sil4uOX04B+/dXddJJozx8SjrmahT3UUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qjSw73esEf9ZoZFWGkXfzS9yObpXb4yms3SBiek/rF4t8RIVJQqilVEARkq2ZAFTw
	 IC5/y87hyTrHwg/J5i9HatpKXW+J8NsV/JF9CTT/A5TSCsNNY7bHtEybae+KR7Uj5G
	 7CecHg3+Wf0phy/+5YgHUAtPy1lLxZrWuS3RTqINIP4nRrUW3QFZCh7w3YfCWNgPMD
	 HRlE4bvZ0mggYz4ut04tn8/RCx57BmC/+n2uKEoI8ghUjx4AD50ig0BlTYTCkoqd1/
	 aNkp02PH/Ui1dZ+IcTscMfIYsDQm+oNo8Puki4V+TFZ1eu19kTiJXOQIccCi1pcUKb
	 y5k8fcBugTu2Q==
Message-ID: <94d193ae-c91a-4b7c-aa02-f905000c01db@kernel.org>
Date: Sun, 7 Jul 2024 11:00:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/4] ipv6: take care of scope when choosing the src
 addr
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-4-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240705145302.1717632-4-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
> When the source address is selected, the scope must be checked. For
> example, if a loopback address is assigned to the vrf device, it must not
> be chosen for packets sent outside.
> 
> CC: stable@vger.kernel.org
> Fixes: afbac6010aec ("net: ipv6: Address selection needs to consider L3 domains")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/ipv6/addrconf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


