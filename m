Return-Path: <stable+bounces-238339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBA6MtsY4WmmpAAAu9opvQ
	(envelope-from <stable+bounces-238339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:14:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38046412727
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D218B303FDD4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6D31D730;
	Thu, 16 Apr 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot+kKNVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5314E2F2;
	Thu, 16 Apr 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359634; cv=none; b=C9jo9H5TWuxmbG5RpyqX5/JFZ2VlUfGxV/rxXgGoRYPYi3/ckymyERiEzvhyFVCZ82icsZUNG49FuS15mxR/XPvxSIYyjntSZ6RvA+U9NNQbH2mMt4YsmDSCRjiJvaDyxazcv/YMkYIypV5ezc5HCRTvGQmLcg8s+3v7hDlQXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359634; c=relaxed/simple;
	bh=bJJnwIqGgN/xbz1eE9VEZDGKUIy6M0vd1On7Is6eFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4wj9V601IjUw0KZVAYRr+whFfzD4xRD5so/eiDM1F8lDqcR3TW5igE3w/bKIs3o/lN+8ySIOhGlW1MNGdgelAVM4COp/jb2WzSKfDzRQ9CIxHXUCS/nwvLU2QsXdFu0oTQ1Pf6QAdt0UAC8jUhW8eSE1U2KHfmrO6RQLyezZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot+kKNVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7216FC2BCAF;
	Thu, 16 Apr 2026 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776359633;
	bh=bJJnwIqGgN/xbz1eE9VEZDGKUIy6M0vd1On7Is6eFjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot+kKNVTkgSEY/NdD/vI6f0xBKHo8Py6GQW1pXDEh3M/7Q/OwJ6HZ8hopNSqBUI/X
	 ag/LSrtSnsukdkgcKwWS3ArQaDxJU0xJlEaFd6ZTdQt68sHB7/M0Tpkvd5bQlvIdZL
	 LW3SpuZmKFIR0jtNddMsLQCw/zKGpW3JGR/VKIfdxID4rM5DZ4jGRPAyAmwjhDKoxL
	 TyhE3LH0AADiHcciCPqfybG32LDUeXUGykiWAB/bCsDS2WjXBOJrc7duJlEKAC/SUI
	 vxtBGmuK6C4+83EiKKwACA3HWHV44Je8NtiyorYGblvruzjh62v1fr7PCW+U6IYlud
	 WJPIFmqiGvj1g==
Date: Thu, 16 Apr 2026 18:13:49 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source
 pruning
Message-ID: <20260416171349.GC863718@horms.kernel.org>
References: <20260413182427.298513-1-michael.bommarito@gmail.com>
 <20260415161720.GN772670@horms.kernel.org>
 <CAJJ9bXwQyd-cZ0h_FCNj29GZYpXyCBu444VhLGLZkf1bWYqoKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXwQyd-cZ0h_FCNj29GZYpXyCBu444VhLGLZkf1bWYqoKQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238339-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38046412727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:30:45PM -0400, Michael Bommarito wrote:
> On Wed, Apr 15, 2026 at 12:17 PM Simon Horman <horms@kernel.org> wrote:
> > Sashiko flags a number of issues in the same function that
> > do not seem related to your patch.
> >
> > I'd suggest looking over them if you are interested in
> > follow-up work in this area.
> 
> Sure, I'd be happy to keep going here if you're open to more hardening
> patches.

Speaking for myself: I'm happy to review patches that correct bugs.

I'm also happy to review patches that otherwise improve the code.
But I think the Intel people might be able to provide better guidance here.

Please be aware of the Netdev guidance on cleanups:

> 
> Two Qs for you:
> 
> 1. Do you want smaller patches for each or bigger method-level patches?

The general rule of thumb is one patch per problem.
Personally, I prefer small patches.

> 
> 2. Anything on my list below that you would *not* want me touching?
> I'll combine with anything I can find from your Sashiko items

...

>     3. line 2769
>        rule:   semgrep signed-int-as-size-param-kmalloc
>        match:  q_vector = kzalloc(size, GFP_KERNEL)  (signed size)
>        status: untriaged
> 
>     4. line 3452
>        rule:   semgrep signed-int-as-size-param-kmalloc
>        match:  tx_ring->tx_buffer_info = vmalloc(size)  (signed size)
>        status: untriaged
> 
>     5. line 3530
>        rule:   semgrep signed-int-as-size-param-kmalloc
>        match:  rx_ring->rx_buffer_info = vmalloc(size)  (signed size)
>        status: untriaged

I didn't look closely, but: I am a little skeptical that these signed size
problems are worth fixing; while the other items on your list look worth
fixing to me.

...

