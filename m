Return-Path: <stable+bounces-172890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2BB34CF0
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129231B21A3F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 20:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDA29A9FE;
	Mon, 25 Aug 2025 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS8WaGEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936C179BD;
	Mon, 25 Aug 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155329; cv=none; b=aQpbFQDPlKT7qHGylpJkwQEKu1CLzpyM8ZhbagmtTJ6wYiTI60wcKdM2TP0Cmz5KI4j/rBuVP6Pu8q+HbrVvD6XNqPxwOxqaR9nKWtP7gBhomlDyTuSk9fteC6rrWcyeMzRx5DC+0w6Kjj50ASWNoXPLLU6w9gmr3kiWXyukTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155329; c=relaxed/simple;
	bh=JM6i/BBkoJtcy4KbG3Msr7B8vft4lS33A3YMhIcPYPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs5cOOnkjHg7ny5iUG/yCZE3UXS1zNmXq5ym7Rl/7Jf+5ItTuqN72Yls1b55v0z1WDPCHAID6sFtsAAS7sW04T4XiyZwHSCZVRF/s8P1V5bSFEGObONqC27x4MKBqiH+zr7/5YQccNiEZogE2EjmKDIQw7OS+Rsp6mLkGmxUb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS8WaGEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E127FC4CEED;
	Mon, 25 Aug 2025 20:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756155328;
	bh=JM6i/BBkoJtcy4KbG3Msr7B8vft4lS33A3YMhIcPYPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS8WaGELzWx6JNeBXvzR0D1O5NKR6si6RJCL+ZYwcImmqVFMDQsGxpqpRGAXu/w4g
	 lmLP5U9zoF3WMgJYXOKu9j1UoBTpdEUb4B5S7WfWbohDRiA+N9vlWQQZU/g2Ae3Bke
	 LvfUa38rgtg33FGI0IXY8/jQa7orVNTV/kOb7a2dcwivnYgMQEae+tKYhlJ8b4XPLT
	 3zZQYh/BIYe9gnjsQxplQT2L+1nxOtxQbXs/5odvSarD8VW/V9WNpXrsuBbS13yq/u
	 1I4xF/1jFsn44qDR1JCPrNDChnsW6k/eRw4m7SdhEfcx3TlawnmRdccdYdmnSuBtoL
	 qh04vuA/JrdtQ==
Date: Mon, 25 Aug 2025 20:55:26 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	David Lebrun <dlebrun@google.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: sr: fix destroy of seg6_hmac_info to prevent
 HMAC data leak
Message-ID: <20250825205526.GA2130842@google.com>
References: <20250825190715.1690-1-andrea.mayer@uniroma2.it>
 <CANn89i+UTv8nJ=cc67iKky=MLXOnzF5XyVRsV-TMXz7wUQ6Yvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+UTv8nJ=cc67iKky=MLXOnzF5XyVRsV-TMXz7wUQ6Yvw@mail.gmail.com>

On Mon, Aug 25, 2025 at 12:33:26PM -0700, Eric Dumazet wrote:
> On Mon, Aug 25, 2025 at 12:08 PM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
> >
> > The seg6_hmac_info structure stores information related to SRv6 HMAC
> > configurations, including the secret key, HMAC ID, and hashing algorithm
> > used to authenticate and secure SRv6 packets.
> >
> > When a seg6_hmac_info object is no longer needed, it is destroyed via
> > seg6_hmac_info_del(), which eventually calls seg6_hinfo_release(). This
> > function uses kfree_rcu() to safely deallocate memory after an RCU grace
> > period has elapsed.
> > The kfree_rcu() releases memory without sanitization (e.g., zeroing out
> > the memory). Consequently, sensitive information such as the HMAC secret
> > and its length may remain in freed memory, potentially leading to data
> > leaks.
> >
> > To address this risk, we replaced kfree_rcu() with a custom RCU
> > callback, seg6_hinfo_free_callback_rcu(). Within this callback, we
> > explicitly sanitize the seg6_hmac_info object before deallocating it
> > safely using kfree_sensitive(). This approach ensures the memory is
> > securely freed and prevents potential HMAC info leaks.
> > Additionally, in the control path, we ensure proper cleanup of
> > seg6_hmac_info objects when seg6_hmac_info_add() fails: such objects are
> > freed using kfree_sensitive() instead of kfree().
> >
> > Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
> > Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> 
> Not sure if you are fixing a bug worth backports.

It can be considered a bug fix, or just hardening.  There are examples
of both ways for this same type of issue.  I think the patch is fine
as-is, though the commit message is a bit long.  Zeroizing crypto keys
is a best practice that the kernel tries to follow elsewhere for all
crypto keys, so this is nothing new.  The patch simply adds zeroization
before freeing for a struct that contains a key.

> >  static inline void seg6_hinfo_release(struct seg6_hmac_info *hinfo)
> >  {
> > -       kfree_rcu(hinfo, rcu);
> > +       call_rcu(&hinfo->rcu, seg6_hinfo_free_callback_rcu);
> >  }
> 
> If we worry a lot about sensitive data waiting too much in RCU land,
> perhaps use call_rcu_hurry() here ?

No, zeroization doesn't have stringent time constraints.  As long as it
happens eventually it is fine.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

