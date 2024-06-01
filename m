Return-Path: <stable+bounces-47823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503A8D6FAF
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F101C20EC9
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F4150999;
	Sat,  1 Jun 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHpjK5Ze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8515098B;
	Sat,  1 Jun 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244102; cv=none; b=efOnF/ZKAiRQCjj9Q5a9sUMQeGe8/INV9tpbMXjLsMvQawLFAa2eEPwsY9b2aMd2gDFFzryH0A8WCBPsokb21Pv/1VVvJ0RLOijRiR2QmLpi+wuLLrWs+wqJi/r8EnVzTebEn3D/N7StOZuXqcQkQdhrEpxW9c9wETw38ZChpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244102; c=relaxed/simple;
	bh=vcVNQET1Ou8ZFeBFz69a2SOS5V8abshMfVybYk+Krfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhwYHXCVYpqebi3CC26aNEd+7GDJ7BmB7Uj+X1rIFnF2ie8wPkGZ1DEKKx5SAnA7mvT1KY6SFN16kolIqHZrcHWOgNPcIjHz1L1+ItjLN4ECzNqsfti/tGPsUhMVoC+uQDBVSlzIgkjrFZNZYst37dasIDIoZ6pJpnvyWPQU7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHpjK5Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCAEC116B1;
	Sat,  1 Jun 2024 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717244101;
	bh=vcVNQET1Ou8ZFeBFz69a2SOS5V8abshMfVybYk+Krfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHpjK5ZeebdryEm2BRaWzYaWhptl/kaIjxtrOm0NmEkj3IKek3Lo5ub0a+n2DBYyZ
	 CKqPP7twOY0J0B3gF2c9ldR4hGrWds+e5PviuHbhIC+KILJNE2CF0jHm3nICiEMJAT
	 tbR4g5HnZXHI66V8F0exQUCvn+25O2clDzX52biUzUQ8/ylK6eFPhT7+i324Nay38E
	 ME0+FNd3iqdL3sKnhn99MdJkiCuAIAcjxxGsvr/37Rh61Y6i8HuGsHTq1/Mz0+YwtX
	 aKD8kQTvjSKkkuVfaSi18LcvlxHWJo4Xlt5DD8LV3ZFJORRrsiJmm9yBsfFI8B3tyV
	 myC2siGiWKrlQ==
Date: Sat, 1 Jun 2024 13:14:57 +0100
From: Simon Horman <horms@kernel.org>
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/tcp: Don't consider TCP_CLOSE in
 TCP_AO_ESTABLISHED
Message-ID: <20240601121457.GI491852@kernel.org>
References: <20240529-tcp_ao-sk_state-v1-1-d69b5d323c52@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-tcp_ao-sk_state-v1-1-d69b5d323c52@gmail.com>

On Wed, May 29, 2024 at 06:29:32PM +0100, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> TCP_CLOSE may or may not have current/rnext keys and should not be
> considered "established". The fast-path for TCP_CLOSE is
> SKB_DROP_REASON_TCP_CLOSE. This is what tcp_rcv_state_process() does
> anyways. Add an early drop path to not spend any time verifying
> segment signatures for sockets in TCP_CLOSE state.
> 
> Cc: stable@vger.kernel.org # v6.7
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

...

> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 781b67a52571..37c42b63ff99 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -933,6 +933,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
>  	struct tcp_ao_key *key;
>  	__be32 sisn, disn;
>  	u8 *traffic_key;
> +	int state;
>  	u32 sne = 0;

Hi Dimitry,

It's probably not a good reason to respon this patch, but if you do make a
v2 for some other reason, please consider reverse xmas tree order -
longest line to shortest for local variable declarations - here.

I'll leave actual review of this patch to others.

...

