Return-Path: <stable+bounces-222729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP6MJE8MpmkJJgAAu9opvQ
	(envelope-from <stable+bounces-222729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:16:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034701E521F
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F41332E5D3
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B2371CE1;
	Mon,  2 Mar 2026 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH2ct0S9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8B33F5B7;
	Mon,  2 Mar 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486678; cv=none; b=L/JsgWZFKHk1oQhxVdVLpceE65J5TzfVnMxeInii05eYGHM5lOrKHuGEhuelGQo/zMHkciL/TS4p4UhWpYnljESTPrb5SmYmud9FjfZebdOchD4XG06l/AHJZnSuTRxuD063kAJrTlwWC1z9g34DGZ7Ut443LD6b1ONnQb9J4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486678; c=relaxed/simple;
	bh=2Cfkijj60alvXH5PPm4F14EP0ye+11LCUdDUZbJ1uKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeZIiH3ogaMJRr1I+qhYe3R81InOYRUVCMcLnvBnFiIujdCOSTQfZmq3F/IWvGI+GYqJNiaseRmuH3gEtqphfSkgvsz3unUhtt9TYxrRS3jYi37Q6Mz/GV/kSac9Lg60V7Lqp7CB2x8GXn1Ix6GxPtUpaCgg8Su1Oni+ywSJAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uH2ct0S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4412C19423;
	Mon,  2 Mar 2026 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772486678;
	bh=2Cfkijj60alvXH5PPm4F14EP0ye+11LCUdDUZbJ1uKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uH2ct0S9vThZrVYPTo1AjSucjyZYdGuzlYMo05oHkUUY5kG3ZAIutgb6FypGcHUAz
	 MkXU8HIrMPUt1d3gNCI9ii9UNBrKW/Ny1OItVX6gDP6IEeR68jtBmq9jBZzHnjfohe
	 ybXawuYnEHk79HsO9CWtuVis0sVbpU8eU8bmo33mC1p43VAwHpk4faGXWFdQ514QrH
	 /qbWA8GPtbOsAQBeD0TFF+YAEFMidWMEPqTLszAH80QsR3QQnyD8MbHZZ1zmj4gaC0
	 lJTbg/7rANC5j1w1t35t9Z3/ZUw7ZOYPOFmL+txxIkQT9TDQYQvVkE38WQ5O4bNIUP
	 lOJKQUkcREDAA==
Date: Mon, 2 Mar 2026 13:24:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/tcp-ao: Fix MAC comparison to be constant-time
Message-ID: <20260302212436.GB2143@quark>
References: <20260302203600.13561-1-ebiggers@kernel.org>
 <CAJwJo6Yt9v8pscqFB7mfuHGhwNSOE2no4Y5fu8o67atn=EtnUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6Yt9v8pscqFB7mfuHGhwNSOE2no4Y5fu8o67atn=EtnUA@mail.gmail.com>
X-Rspamd-Queue-Id: 034701E521F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222729-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:59:50PM +0000, Dmitry Safonov wrote:
> On Mon, 2 Mar 2026 at 20:36, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > To prevent timing attacks, MACs need to be compared in constant
> > time.  Use the appropriate helper function for this.
> >
> > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> > Cc: stable@vger.kernel.org
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Thanks, Eric, LGTM.
> 
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Could you also send a similar patch for TCP-MD5?
> tcp_inbound_md5_hash(), tcp_v{4,6}_send_reset() would need the same change.

Already done, it was the first one I sent:
https://lore.kernel.org/netdev/20260302203409.13388-1-ebiggers@kernel.org/

- Eric

