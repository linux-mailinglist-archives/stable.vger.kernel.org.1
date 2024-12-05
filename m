Return-Path: <stable+bounces-98704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038749E4BAB
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 02:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A90428626C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324C61FFE;
	Thu,  5 Dec 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaXIHxmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FD14286;
	Thu,  5 Dec 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361235; cv=none; b=AQjz8+1YbD/X2fiXdZj1MZoy0+z0RNDZ9kATeUVitMcPnvCWZCnvIcWHX2W5ScqnAbuHbF/bwJjWNkzH4RzPllHHMxspDYajx47U8pRjbfTIuThjmf+Z6c3rsA5DsIGmq7VKlp4yz+l2vfzOxsjdD7/E+xZhzG4K0uyKwjVbcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361235; c=relaxed/simple;
	bh=3VfDxlcE8yFxXY59qEiQsyJF7h0mIJ5Z2wg79rfO+Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJsPQZZdufTBZNHKtc4kH86cmR642CleHMMYrzETFwK+vP0AeMyA5jbRQYRfUASXZGlPFN4wdeQ6sUpe2fu+VAie7+mPYP17OZ34eTnHxaXWOzEDJwO8F3u40oOY/UWOD26D4qVOs/Jb/3oo6g5DQltv9eSru+wyP1kWS8X9gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaXIHxmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D55C4CED2;
	Thu,  5 Dec 2024 01:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733361233;
	bh=3VfDxlcE8yFxXY59qEiQsyJF7h0mIJ5Z2wg79rfO+Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaXIHxmcxsL44N2kme3qQxu8Swy8AWe8TwMG/1c0JpnJ9Guw5FNz6lScn9mcMw1QI
	 F3AfuxXxuADk7itmJ86+ZW5HzPzvdZjmhsgI16WCGxaxzzpSblCYXEdFZhWfP3+1F6
	 QZrW1xhVrro8fbiGQLJjcZ2nY1Lry000Lde8jQaDIbpdkkwbbwgtne+FYNLB4FJ8al
	 iFoD88s9HkioBAsOym0n+D+vTvfwWCLmSqXt3jgfMNKfzG6mKGkM5ofeUwjVYOGjoA
	 BsmAG1c8Vht6jzNbKLigze7rpHTc7N5ucDlru8EQphA/Rn7t8UyT3Swz8gCN2+Yztp
	 OPfR36/luH3IQ==
Date: Wed, 4 Dec 2024 17:13:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
Message-ID: <20241204171351.52b8bb36@kernel.org>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:
> 2. Inet-diag allocates netlink message for sockets in
>    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
>    .idiag_get_aux_size(), that pre-calculates the needed space for
>    TCP-diag related information. But as neither socket lock nor
>    rcu_readlock() are held between allocation and the actual TCP
>    info filling, the TCP-related space requirement may change before
>    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
>    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
>    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().

Hi Eric! 

This was posted while you were away -- any thoughts or recommendation on
how to address the required nl message size changing? Or other problems
pointed out by Dmitry? My suggestion in the subthread is to re-dump
with a fixed, large buffer on EMSGSIZE, but that's not super clean..

