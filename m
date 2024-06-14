Return-Path: <stable+bounces-52136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F02908342
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 07:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2691F21F20
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 05:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6313C3C9;
	Fri, 14 Jun 2024 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="pN48lbYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHXG2ldK"
X-Original-To: stable@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076926ADE;
	Fri, 14 Jun 2024 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342291; cv=none; b=kBXxSqQya5ChaLJkv3IkedTk4K2YxL+JnliaAmHX6X+uh2h25XapHJhkLUEbJ1j+ylPif8xJqTHKVFq7IdCnkJAGE05sg32JgC+AAOmZON2tmbhKV4yo4TKsAwqEJuraAopjer9dDYFIYphAwL/4Ymlm8QJdHv69rXOR5oYS1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342291; c=relaxed/simple;
	bh=juVv7rNlbtfr1exivJzn7GDEcB0KT6upcWHiyB1cYAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqn0kJ54cGRr8imHnAKuigel69ZaVjSRVelvg59iWPgXDNq8YFPGTG2wg92hLEqN7Fj89sXMSC5eQZHXi3zWlHSuv4bQallf37CV9XsExHvaY2zXz3rFSvM0Xd6cup1hz8JXvQbBHf4w25CDVOiYyhJhQ9MLF7LEs0pXGl3kkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=pN48lbYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHXG2ldK; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B9D7C1C000CE;
	Fri, 14 Jun 2024 01:18:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Jun 2024 01:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718342286; x=1718428686; bh=jw15wvUM0b
	UrXsSDBYWa6+RoE33b/QZPiR64fBVK6+Y=; b=pN48lbYw23Z5K391upOCzqWSYY
	WGbz/Fmuv1KnyTIXmx6E3E0ZUTF8TceVaTAat0vKTtokHBw3cqUpXF3XPFoKOy+Y
	qOsBth0dhNVoqwWNfeWZ6VnAs+gEi5LNzO3XXf/SpW0vyPJN2iwCbm4AhRVFWRHX
	gmQFSm51WZkIOQgnGx/zM2PlOjSzQU+k7L9cOvd0zWx8NZH3Oom4TWRNISPqXwMP
	YxnZKDpMTjqpp3qPf3DmrRu8rFsKMYsLzzUZq3XkHDyBqjKMRu0m8BpXk9hfgxpK
	aIh3WtfXYtCw4L2vbFTUVKcGO/K1H6wflcAT9pF48mGsZb9fGu/VlGTlLw3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718342286; x=1718428686; bh=jw15wvUM0bUrXsSDBYWa6+RoE33b
	/QZPiR64fBVK6+Y=; b=NHXG2ldKaj6rnp4/pCopGMZHdoWGK3zfiExhTXOru3wR
	SNHwMlXJMbot3HjgaYXxAt86fiA/Z+QqMvOl885BjsvuBWN67O/VoLt/P0TaGsm8
	nUI4XaA102cbGl958b9+iNH4nfu8HV9x0sbBSsWrR9Z4OZBMj4ZWQlR5eZV4qfd3
	cKoGboytqngbOjNMLtL/2BS69cf84rkJkN62T4H3ENHVLmqep1EwBnF8cjIhCcM/
	rDHMDHhalfrMn5QtqYLlkfkm9c2iK2Ok0LITU3N19eBH/m+liDr9VycubtZHAz5Y
	dEDu85bYQTrg7IahoXixFOcX3gdhnJbFi/6uM1Gn9g==
X-ME-Sender: <xms:jdJrZj5ejZeADd-0pwhJcIJrKDHHY6pbMuh826fxfc46Cb6WWVtHbg>
    <xme:jdJrZo7w-nZnhCf5gj0VLEz6h0C0hteAsbxDl76moTmFp8xlOlsnMhUd9ObkTEnYa
    7gSNRJfJ7sqcg>
X-ME-Received: <xmr:jdJrZqdYQPvGqdkH4P2QafjhIb9FsRBKdItiGl3MR0tBSNFhayD0ADJsq7SAfMHCJqoTwvKqRwDvS9vppeUZQP35Clb6p9QOegxYag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:jdJrZkI145oHE3Z13HQqwhGVV8gHziGG19TPJ1wmjBzInEDwcauVDw>
    <xmx:jdJrZnK9sqV-3dkpNN_aIf2p9GZWPi_2jeV1kgY6JcqVl_LejUBfqQ>
    <xmx:jdJrZtyxTSVAivsb2Mb-criVgbFAF3qbKUZe9EfBQ_r4fjjO2WtY5w>
    <xmx:jdJrZjL0TeHeNMuXO1BjpPp_LfiBzkunTXQ81x0GVU6Jt8wv1jhfIg>
    <xmx:jtJrZifC113D3dVEVXqG8X41aiDi8-NsdxAnPthj2_gUmWpJxsmi6ZJG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 01:18:04 -0400 (EDT)
Date: Fri, 14 Jun 2024 07:18:01 +0200
From: Greg KH <greg@kroah.com>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Tom Murphy <murphyt7@tcd.ie>,
	Saravana Kannan <saravanak@google.com>,
	Joerg Roedel <jroedel@suse.de>, kernel-team@android.com,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] iommu/dma: Trace bounce buffer usage when mapping
 buffers
Message-ID: <2024061450-pueblo-recipient-d4a6@gregkh>
References: <2024012226-unmanned-marshy-5819@gregkh>
 <20240122203758.1435127-1-isaacmanjarres@google.com>
 <ZmrKZYJ0+z3mRZXx@hu-bibekkum-hyd.qualcomm.com>
 <2024061311-washable-ranch-abc5@gregkh>
 <3c5034e9-d834-4ebe-a03d-1a222f8f22ac@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5034e9-d834-4ebe-a03d-1a222f8f22ac@quicinc.com>

On Thu, Jun 13, 2024 at 11:10:57PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 6/13/2024 4:45 PM, Greg KH wrote:
> > On Thu, Jun 13, 2024 at 04:01:01PM +0530, Bibek Kumar Patro wrote:
> > > On Mon, Jan 22, 2024 at 12:37:54PM -0800, Isaac J. Manjarres wrote:
> > > > When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
> > > > use bounce buffers") was introduced, it did not add the logic
> > > > for tracing the bounce buffer usage from iommu_dma_map_page().
> > > > 
> > > > All of the users of swiotlb_tbl_map_single() trace their bounce
> > > > buffer usage, except iommu_dma_map_page(). This makes it difficult
> > > > to track SWIOTLB usage from that function. Thus, trace bounce buffer
> > > > usage from iommu_dma_map_page().
> > > > 
> > > > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > > > Cc: stable@vger.kernel.org # v5.15+
> > > > Cc: Tom Murphy <murphyt7@tcd.ie>
> > > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > > Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
> > > > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > > > (cherry picked from commit a63c357b9fd56ad5fe64616f5b22835252c6a76a)
> > > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > > > ---
> > > >   drivers/iommu/dma-iommu.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > index 48c6f7ff4aef..8cd63e6ccd2c 100644
> > > > --- a/drivers/iommu/dma-iommu.c
> > > > +++ b/drivers/iommu/dma-iommu.c
> > > > @@ -25,6 +25,7 @@
> > > >   #include <linux/vmalloc.h>
> > > >   #include <linux/crash_dump.h>
> > > >   #include <linux/dma-direct.h>
> > > > +#include <trace/events/swiotlb.h>
> > > >   struct iommu_dma_msi_page {
> > > >   	struct list_head	list;
> > > > @@ -817,6 +818,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> > > >   		void *padding_start;
> > > >   		size_t padding_size, aligned_size;
> > > > +		trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
> > > > +
> > > 
> > > Hi, this backported patch trying to access swiotlb_force variable is
> > > causing a build conflict where CONFIG_SWIOTLB is not enabled.
> > > 
> > > In file included from kernel/drivers/iommu/dma-iommu.c:28:
> > > kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> > >                   enum swiotlb_force swiotlb_force),
> > >                        ^
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > >                        ^
> > > In file included from kernel/drivers/iommu/dma-iommu.c:28:
> > > kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > >                        ^
> > > In file included from kernel/drivers/iommu/dma-iommu.c:28:
> > > kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > >                        ^
> > > In file included from kernel/drivers/iommu/dma-iommu.c:28:
> > > kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > >                        ^
> > > kernel/drivers/iommu/dma-iommu.c:865:42: error: argument type 'enum SWIOTLB_NO_FORCE' is incomplete
> > >                                         trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
> > >                                                                                ^~~~~~~~~~~~~
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > >                        ^~~~~~~~~~~~~~~~
> > > kernel/include/trace/events/swiotlb.h:15:9: note: forward declaration of 'enum SWIOTLB_NO_FORCE'
> > > enum swiotlb_force swiotlb_force),
> > >       ^
> > > kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> > > #define swiotlb_force SWIOTLB_NO_FORCE
> > > 
> > > --------------------------------------------------------------------------------------------------------------------------------------------------
> > > 
> > > I have a simple proposed fix which can resolve this compile time conflict when CONFIG_SWIOTLB is disabled.
> > > 
> > > --- a/include/trace/events/swiotlb.h
> > > +++ b/include/trace/events/swiotlb.h
> > > @@ -7,6 +7,7 @@
> > > 
> > >   #include <linux/tracepoint.h>
> > > 
> > > +#ifdef CONFIG_SWIOTLB
> > >   TRACE_EVENT(swiotlb_bounced,
> > > 
> > >          TP_PROTO(struct device *dev,
> > > @@ -43,6 +44,9 @@ TRACE_EVENT(swiotlb_bounced,
> > >                          { SWIOTLB_FORCE,        "FORCE" },
> > >                          { SWIOTLB_NO_FORCE,     "NO_FORCE" }))
> > >   );
> > > +#else
> > > +#define trace_swiotlb_bounced(dev, phys, size, swiotlb_force)
> > > +#endif /* CONFIG_SWIOTLB */
> > > 
> > >   #endif /*  _TRACE_SWIOTLB_H */
> > > 
> > > 
> > 
> > Why not just take whatever change upstream fixes this instead of a
> > one-off change?
> > 
> 
> I am currently checking the history on swiotlb_force and how it's
> removed in latest kernel versions. If those changes are applicable on
> this stable branch can we explore backporting those instead of this one-
> off change ?

Please backport what is in the tree already.

