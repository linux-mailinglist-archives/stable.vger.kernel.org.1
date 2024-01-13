Return-Path: <stable+bounces-10623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38C82CABB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3331C21EBB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D17E8;
	Sat, 13 Jan 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOi+Rn7L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB37E6
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23688C433F1;
	Sat, 13 Jan 2024 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705137326;
	bh=f4fLp7N7mf9Td2BdZzR6GPxrDKaNL96mkmFgasZgxSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOi+Rn7LqV3aXaDi2UGmLN4l6/DdzLnZVO4bQNfA6k/hfJrNJUA/pgpD49UwPE53a
	 f/OLZizewJORLVZFFyFMO7V4R5LbE08PBlveeaoY9IioJeAqukWdg7n47wcTccm71q
	 O3CH6selJ0qwXf5cq/g8TeuOvHaMckKVu1dU1qqQ=
Date: Sat, 13 Jan 2024 10:15:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cengiz Can <cengiz.can@canonical.com>
Cc: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>, stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y] netfilter: nf_tables: Reject tables of unsupported
 family
Message-ID: <2024011304-pout-pegboard-461e@gregkh>
References: <20240112015436.1117482-1-cengiz.can@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112015436.1117482-1-cengiz.can@canonical.com>

On Fri, Jan 12, 2024 at 04:54:35AM +0300, Cengiz Can wrote:
> From: Phil Sutter <phil@nwl.cc>
> 
> commit f1082dd31fe461d482d69da2a8eccfeb7bf07ac2 upstream.
> 
> An nftables family is merely a hollow container, its family just a
> number and such not reliant on compile-time options other than nftables
> support itself. Add an artificial check so attempts at using a family
> the kernel can't support fail as early as possible. This helps user
> space detect kernels which lack e.g. NFPROTO_INET.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
> ---
>  net/netfilter/nf_tables_api.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Any specific reason you sent this to us for inclusion _AFTER_ you posted
to oss-security, notifying the world of the issue?

Anyway, I have queued them up already from that report, and just now got
to these patches in my queue, making me a little bit less grumpy, but
not a lot.  Please be more considerate next time.

greg k-h

