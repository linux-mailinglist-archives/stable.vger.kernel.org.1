Return-Path: <stable+bounces-8680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4881FB6F
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE66B213A2
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8D10960;
	Thu, 28 Dec 2023 22:01:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAADC10A01
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rIyQn-0001hj-Fg; Thu, 28 Dec 2023 23:00:45 +0100
Date: Thu, 28 Dec 2023 23:00:45 +0100
From: Florian Westphal <fw@strlen.de>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, security@kernel.org,
	Kevin Rich <kevinrich1337@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] netfilter/nf_tables: fix UAF in catchall element removal
Message-ID: <20231228220045.GA598@breakpoint.cc>
References: <20231228143737.17712-1-wander@redhat.com>
 <CAHk-=wg1VJR4WFT4VhEqXgE14dogJe9kbpYGBZdtai3ORomfOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1VJR4WFT4VhEqXgE14dogJe9kbpYGBZdtai3ORomfOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> On Thu, 28 Dec 2023 at 06:38, Wander Lairson Costa <wander@redhat.com> wrote:
> >
> > If the catchall element is gc'd when the pipapo set is removed, the element
> > can be deactivated twice.
> >
> > When a set is deleted, the nft_map_deactivate() is called to deactivate the
> > data of the set elements [1].
> 
> Please send this to the netdev list and netfilter-devel, it's already
> on a public list thanks to the stable cc.
> 
> Pablo & al - see
> 
>     https://lore.kernel.org/all/20231228143737.17712-1-wander@redhat.com/
> 
> for the original full email.

Thanks.  I suspect the correct fix is

https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=7315dc1e122c85ffdfc8defffbb8f8b616c2eb1a

which missed the last pre-holiday-shutdown net pull request and
is thus still only in nf.git.

