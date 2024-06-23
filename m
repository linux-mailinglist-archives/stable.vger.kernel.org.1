Return-Path: <stable+bounces-54962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25968913EA7
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 23:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A5C1C209CA
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0F18509D;
	Sun, 23 Jun 2024 21:58:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEF1849CE;
	Sun, 23 Jun 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179884; cv=none; b=MLRQ0fXTIJNSAJlfLt+RdIgtPN2x2BwXy5C+GVEVyMxwLN2XeDb8wqbWmVo2WatpdVTD0wlHnuWlEE0Rs93JR1riHiT1AnJ2uEhElK7pDopgnLQ4YNDDWlJXGfxiikZ3mUkHnCRktWXc1+yxMMvD3QfzzxNtZ4DLAKNMAwpapzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179884; c=relaxed/simple;
	bh=g6FRmbQRjC4YW86HK1lKpuGjNs8PkM/22/4DIckfKeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUphqBeA1VfN+Lx+Jv9Icco9yDVQM8M6fVaD+LtSYrM1bnjZCMvNHJrA+yoYUqts6u0ObSQO2HqRDbGPTqZB7AkMWG5yaMIuUqQbqCVvvyPpzB5D7Q0dEUYVid3E1uTSdbyxeYSH28hXWxP+q6kY8dmMCTZJ1g265U2lgxjHbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=54496 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sLVDe-003w0v-Mq; Sun, 23 Jun 2024 23:57:56 +0200
Date: Sun, 23 Jun 2024 23:57:53 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	kadlec@netfilter.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "netfilter: ipset: Fix race between namespace cleanup and
 gc in the list:set type" has been added to the 6.9-stable tree
Message-ID: <ZniaYe9C8Ys_2IfM@calendula>
References: <20240617113341.2561910-1-sashal@kernel.org>
 <ZnA0cgegIgvcg26v@calendula>
 <2024061900-precise-underuse-d4f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024061900-precise-underuse-d4f4@gregkh>
X-Spam-Score: -1.9 (-)

Hi Greg,

On Wed, Jun 19, 2024 at 12:57:15PM +0200, Greg KH wrote:
> On Mon, Jun 17, 2024 at 03:04:50PM +0200, Pablo Neira Ayuso wrote:
> > Hi Sasha,
> > 
> > This fix requires a follow up to silence a RCU suspicious usage warning.
> > 
> > Please, hold on until end of the week with this.
> > 
> > I will get back to you with a reminder if it helps.
> 
> Dropped from all queues, please resend it when you feel it is ready to
> be added.

commit 8ecd06277a7664f4ef018abae3abd3451d64e7a6
Author: Jozsef Kadlecsik <kadlec@netfilter.org>
Date:   Mon Jun 17 11:18:15 2024 +0200

    netfilter: ipset: Fix suspicious rcu_dereference_protected()

is now upstream, which provides the incremental fix for:

commit 4e7aaa6b82d63e8ddcbfb56b4fd3d014ca586f10
Author: Jozsef Kadlecsik <kadlec@netfilter.org>
Date:   Tue Jun 4 15:58:03 2024 +0200

    netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type

These two patches can now be queued up to -stable.

Thanks

