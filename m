Return-Path: <stable+bounces-188196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159CBF2689
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC918A80A7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F22877DC;
	Mon, 20 Oct 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtwLAQe8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFB28504F;
	Mon, 20 Oct 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977541; cv=none; b=Fr6ca3JdZKO26f6VXQ05JnSlrJV5lhAQrxQso6IpG7id734a/HUVHzwH2J3ZNbyZwi+DWevjuOjjJ+uYRBmRWgz6wptd9V47PCA7FwHSesRN0ocTaqqJzl3hsGvgG2+ElOwEnWjK64su/bLJH4Klf75D5O+6NlVyVRq0yuM5bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977541; c=relaxed/simple;
	bh=2fCD68FP5djrJsM6kZpUHk2l3yLTY5/lJIRPxRZ9gFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XahQeChaPyXePlgJpkyWtSIDkEdVxyODMx/80iTc+iUwZR+7p6zCfMtBMvvwSyr3gK9PAg42lktrrnGaJr0AjBpjy0Orn+OwC6KUooh/ur6qda9s2mkHwe5G51rRgOqB0Z75Y71cTnB0mrlvZPnPnInhVT7uV6kjpGgs/dTlYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtwLAQe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD0C4CEF9;
	Mon, 20 Oct 2025 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977540;
	bh=2fCD68FP5djrJsM6kZpUHk2l3yLTY5/lJIRPxRZ9gFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UtwLAQe8QnamdN1I0lcSM7oJvaCd4A5QTyQr6cAtPOVbJYPfdTKVXZMMClO/ie7q9
	 lWSE8cY8B5lE5jHvPH7YBerLAGAT1rvsoFAyqMBifl71CCCcOLgpTyFM1OosfDaBLW
	 9B7tT+CwNJENbOXKV2ItqyuXF5iQeqZI98UtVFdqcDUY8OGDAxlmrvjfDPYz1OU+2t
	 sclgw9ur0FfVUzlzWAooKk54KYyk3Dokif1RDGbTbX6IjXRMwYUmFXVs+qfTT4inBx
	 x0dmpC+9MGhff0tBdhvElxfbyMOghs8tWZtcKO9UMRSyIAhIqaZRLaC3NVxTxZQqMS
	 Uxhyupcm5P5Ew==
Message-ID: <5b398571-0a1a-4d4e-a6f7-e091866443df@kernel.org>
Date: Mon, 20 Oct 2025 18:25:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 8/8] mptcp: reset blackhole on success with
 non-loopback ifaces
Content-Language: en-GB, fr-BE
To: Sasha Levin <sashal@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, MPTCP Linux <mptcp@lists.linux.dev>
References: <2025101604-chamber-playhouse-5278@gregkh>
 <20251020154409.1823664-1-sashal@kernel.org>
 <20251020154409.1823664-8-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251020154409.1823664-8-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha, Greg,

On 20/10/2025 17:44, Sasha Levin wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> [ Upstream commit 833d4313bc1e9e194814917d23e8874d6b651649 ]

The backport of this whole series for v6.12, containing these commits...

- e7b9ecce562c ("tcp: convert to dev_net_rcu()")
- 15492700ac41 ("tcp: cache RTAX_QUICKACK metric in a hot cache line")
- 88fe14253e18 ("net: dst: add four helpers to annotate data-races
  around dst->dev")
- a74fc62eec15 ("ipv4: adopt dst_dev, skb_dst_dev and
  skb_dst_dev_net[_rcu]")
- 1dbf1d590d10 ("net: Add locking to protect skb->dev access in
  ip_output")
- 108a86c71c93 ("mptcp: Call dst_release() in mptcp_active_enable().")
- 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
  mptcp_active_enable().")
- 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback
  ifaces")

... looks good to me, if that's also OK for Eric and/or Kuniyuki.



Please note that these commits should also help to backport a few more
fixes from Kuniyuki from this series:

  https://lore.kernel.org/20250916214758.650211-1-kuniyu@google.com

- 3d3466878afd ("smc: Fix use-after-free in __pnet_find_base_ndev().")
- 935d783e5de9 ("smc: Use __sk_dst_get() and dst_dev_rcu() in in
  smc_clc_prfx_set().")
- 235f81045c00 ("smc: Use __sk_dst_get() and dst_dev_rcu() in
  smc_clc_prfx_match().")
- 0b0e4d51c655 ("smc: Use __sk_dst_get() and dst_dev_rcu() in
  smc_vlan_by_tcpsk().")
- c65f27b9c3be ("tls: Use __sk_dst_get() and dst_dev_rcu() in
  get_netdev_for_sock().")

And also eventually commit b62a59c18b69 ("tcp: use dst_dev_rcu() in
tcp_fastopen_active_disable_ofo_check()") from Eric.

(I don't know who will initiate these backports.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


