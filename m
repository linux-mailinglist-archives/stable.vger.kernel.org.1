Return-Path: <stable+bounces-41441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A229F8B251D
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B51F2178E
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00714B07D;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2IsKDSw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12214AD23;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059034; cv=none; b=t1B5l+bZzXHQa8NxRuJgQkudiguUrxMMU63SvOfALfHWxjzock599TQCm9dEySUn242f/86nT9b1Zlq9euPTlklqwXGKAXXavNlj9drw+uD97et9Zl1hwoXeqrBn4tElkpDTiPEQbDVHMBe7Y7+mxnKNaX9GShk6ohMdBJwg01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059034; c=relaxed/simple;
	bh=VbGjhgWWdlPSkjyt2SJM8eeCw83uswTP11eIKLdpQUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZndsTpqKL9lqqlVZYfAZejou3s6cnjdfnvsgZenjjUcU69ByKwikKb70tAVT2NrAYUDIEwKsNqSZQnaYdIQbAC4UboDEBxLyhI7onfDnUu0GAFPmvDWKuPVIgu4UTAoCSzT6iZ1dSD77waGZl6e98YOAfAqNeVr4tAF02q3rtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2IsKDSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3259DC2BD11;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059034;
	bh=VbGjhgWWdlPSkjyt2SJM8eeCw83uswTP11eIKLdpQUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B2IsKDSwn4W7fm1+FcErufXYoUi8FaTVTAorecr6g/Y/2B/XjCgLepp4Bv6F4QCXE
	 9m6jqP1fu2Cm9LHCYWYDpAQk+r/Obp02Mu5DnYExoZElasGPPQV7VfBpfj96KOV+Y1
	 wjUS0o+XET9V252Y/tYrrjCb1URI5Az5oxGP6nsYMIVjeWFjXI0+MVE8VRbBxbGdrA
	 nEW97W28yEKT9lFhQhKp+jmXDHeat3H+HTZ8S7HQ6jPtKm0zADZAlyTx7iz9YIN2i1
	 bX+RS2sufGJq8efZmMXRtWKAUf+xQ6Xkb+1hEVMPU8dWJar+yyAljVzlSatt9bgd2x
	 y3uPvum4zzBOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 212F8CF21C2;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] Fix isolation of broadcast traffic and unmatched
 unicast traffic with MACsec offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405903413.5824.688163186689727867.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:30:34 +0000
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, gal@nvidia.com,
 tariqt@nvidia.com, sd@queasysnail.net, yossiku@nvidia.com,
 bpoirier@nvidia.com, cratiu@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 11:13:01 -0700 you wrote:
> Some device drivers support devices that enable them to annotate whether a
> Rx skb refers to a packet that was processed by the MACsec offloading
> functionality of the device. Logic in the Rx handling for MACsec offload
> does not utilize this information to preemptively avoid forwarding to the
> macsec netdev currently. Because of this, things like multicast messages or
> unicast messages with an unmatched destination address such as ARP requests
> are forwarded to the macsec netdev whether the message received was MACsec
> encrypted or not. The goal of this patch series is to improve the Rx
> handling for MACsec offload for devices capable of annotating skbs received
> that were decrypted by the NIC offload for MACsec.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
    https://git.kernel.org/netdev/net/c/475747a19316
  - [net,v3,2/4] ethernet: Add helper for assigning packet type when dest address does not match device address
    https://git.kernel.org/netdev/net/c/6e159fd653d7
  - [net,v3,3/4] macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
    https://git.kernel.org/netdev/net/c/642c984dd0e3
  - [net,v3,4/4] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
    https://git.kernel.org/netdev/net/c/39d26a8f2efc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



