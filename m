Return-Path: <stable+bounces-50516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E2906ACF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829971C23349
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF049141987;
	Thu, 13 Jun 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fP9ojm/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaMZADIa"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121813C9C0;
	Thu, 13 Jun 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277334; cv=none; b=Ud2+dqIm1Yk6BInrYIgzsOtb0oc2874TtkxvBFpj+Azfa2ZfQzH7242P8BZJtJxFPUdHXXlXyawJ+zjVmQe0783YF7/TPb/GJe5SJFPljyNM5id7PnSw+zJUl5l3UOCChKH5KS4KH07B4JBFS55WtVmQbgMKS8nSnoVn8o+M3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277334; c=relaxed/simple;
	bh=0rqa/fHwKGmnIoA1MtAA/yL/+W5i/RGmhNKvuI9ctHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp/DJ/wITRstiOfMtPvzu2Y/wD6AXw789KpWke3qXyovFRcdvKTOdRYzRQAsOL+qUvByQ8Em4BvegJpoEr3+U08Ieoz1zy3yIC5yoK4/jnID4V0HsbScZOs4PPTAnyWHj3yrHD165vIhMwv3usmchXP4NuMKZKlRIdRLGPK4ybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fP9ojm/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaMZADIa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EDD461380518;
	Thu, 13 Jun 2024 07:15:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718277330; x=1718363730; bh=0Wxo1KWcaI
	+Qb9/p5w1SxDBWK8h/US2u4Q60jeymu50=; b=fP9ojm/DwGMBXctq/uO9wegv76
	RzY7j06fgUwARiysF8orJZGzEPSVmfNezQa5WHITvUG013du2Z0c+5H2y352QEzF
	V1Jk5Ff7XwrKDLmdWrFppkJlZzy8Vmsqe9OFMvBrxCyBjMs4QKwqopTldilQ8ZEy
	a8UsHXsm3Tj828Ma41C7tKxBLDnr66qBay/lv5Yu4YSknJn50CdkPQq0KPDT4kui
	d+pimju3AbaAedbTdzBItePj7EazVPxwvspYtVAn9dtolMdJUXwcUa9fBnSqDKg1
	6/2aPfSZWwtWuoEbFzin2GjEToxpbO6OO20C4ee8nWqOGFnH3riDTr276LxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718277330; x=1718363730; bh=0Wxo1KWcaI+Qb9/p5w1SxDBWK8h/
	US2u4Q60jeymu50=; b=TaMZADIaDJzwTWJsRLoJfHNJkNC4PLbPjwEnEIb9HlUb
	xUTLW+1n76zW1KG4xMgUk7BTP9BUHsQejV3iWxSQBEA67Qph7xw6BNnUaYcdELGM
	Ag/mtIc+icHNmJQC3Ho0ZbdbBBD7Ix2TPNNTJ1dkpcYcdFb3JoFf7dPsSlmeQHDx
	OOzBvSfhghNivYzFi6Meqiq5VOQdVAvM20KFcB1TLoq40O+d5HMwnrQ2ZHQ4Artm
	u5yTOgJ5svDygC84KTnS+g4RU4IaN3UcDrL2blW3GkLA2aUuqNheH4sN0JJ4qFE+
	BX/dEKNDQyX5lYTY/uZPQlyiu7R2KUOmcxvb0bZQQQ==
X-ME-Sender: <xms:0tRqZm3HNRTpEm5nBwBgN1Ak0AqeSRZz0MG7icE9ipZ5lHMEkHB6kg>
    <xme:0tRqZpHzg5Jf3c96O_GQ_Dr509vwIPH3wvr986hbLiBwhiTmu7lbfNW519DvYrb-t
    QmtPAZIOjwA0A>
X-ME-Received: <xmr:0tRqZu5SDy4zxNZj_EDOKXWr-fEyZj-BrbDbUGCrQK1JXYFwYIWYwII3IwI48sgNkovq8RayhDuMvppbAKsdTTeF05U9QwBiMLQkvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:0tRqZn2PU30OTVsKUWc_94Sg0FkdxCju0vnA1FkDjIVwGclLgHQl8w>
    <xmx:0tRqZpEq_ljdRTUml0Ck-kpXYizKwKF4Ip-fj46KBqu-HQwxqoDVYw>
    <xmx:0tRqZg8CCbvoYLYLQt9bmmoy6_owdQH8KYrMpSgfjFWI7ZB3Dp5zyQ>
    <xmx:0tRqZunrIBXyEkw6wK1khvhZp-xeNYJ_PKWEBAaMOC2LFG9jI5_hUg>
    <xmx:0tRqZsYqExcfM26dwx2qj05Bett4hOmuVv4o6Kz1b6TmzuoxngSMyu-C>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 07:15:29 -0400 (EDT)
Date: Thu, 13 Jun 2024 13:15:27 +0200
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
Message-ID: <2024061311-washable-ranch-abc5@gregkh>
References: <2024012226-unmanned-marshy-5819@gregkh>
 <20240122203758.1435127-1-isaacmanjarres@google.com>
 <ZmrKZYJ0+z3mRZXx@hu-bibekkum-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmrKZYJ0+z3mRZXx@hu-bibekkum-hyd.qualcomm.com>

On Thu, Jun 13, 2024 at 04:01:01PM +0530, Bibek Kumar Patro wrote:
> On Mon, Jan 22, 2024 at 12:37:54PM -0800, Isaac J. Manjarres wrote:
> > When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
> > use bounce buffers") was introduced, it did not add the logic
> > for tracing the bounce buffer usage from iommu_dma_map_page().
> > 
> > All of the users of swiotlb_tbl_map_single() trace their bounce
> > buffer usage, except iommu_dma_map_page(). This makes it difficult
> > to track SWIOTLB usage from that function. Thus, trace bounce buffer
> > usage from iommu_dma_map_page().
> > 
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Cc: stable@vger.kernel.org # v5.15+
> > Cc: Tom Murphy <murphyt7@tcd.ie>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > (cherry picked from commit a63c357b9fd56ad5fe64616f5b22835252c6a76a)
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >  drivers/iommu/dma-iommu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 48c6f7ff4aef..8cd63e6ccd2c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/crash_dump.h>
> >  #include <linux/dma-direct.h>
> > +#include <trace/events/swiotlb.h>
> >  
> >  struct iommu_dma_msi_page {
> >  	struct list_head	list;
> > @@ -817,6 +818,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >  		void *padding_start;
> >  		size_t padding_size, aligned_size;
> >  
> > +		trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
> > +
> 
> Hi, this backported patch trying to access swiotlb_force variable is
> causing a build conflict where CONFIG_SWIOTLB is not enabled.
> 
> In file included from kernel/drivers/iommu/dma-iommu.c:28:
> kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
>                  enum swiotlb_force swiotlb_force),
>                       ^
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
>                       ^
> In file included from kernel/drivers/iommu/dma-iommu.c:28:
> kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
>                       ^
> In file included from kernel/drivers/iommu/dma-iommu.c:28:
> kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
>                       ^
> In file included from kernel/drivers/iommu/dma-iommu.c:28:
> kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
>                       ^
> kernel/drivers/iommu/dma-iommu.c:865:42: error: argument type 'enum SWIOTLB_NO_FORCE' is incomplete
>                                        trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
>                                                                               ^~~~~~~~~~~~~
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
>                       ^~~~~~~~~~~~~~~~
> kernel/include/trace/events/swiotlb.h:15:9: note: forward declaration of 'enum SWIOTLB_NO_FORCE'
> enum swiotlb_force swiotlb_force),
>      ^
> kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
> #define swiotlb_force SWIOTLB_NO_FORCE
> 
> --------------------------------------------------------------------------------------------------------------------------------------------------
> 
> I have a simple proposed fix which can resolve this compile time conflict when CONFIG_SWIOTLB is disabled.
> 
> --- a/include/trace/events/swiotlb.h
> +++ b/include/trace/events/swiotlb.h
> @@ -7,6 +7,7 @@
> 
>  #include <linux/tracepoint.h>
> 
> +#ifdef CONFIG_SWIOTLB
>  TRACE_EVENT(swiotlb_bounced,
> 
>         TP_PROTO(struct device *dev,
> @@ -43,6 +44,9 @@ TRACE_EVENT(swiotlb_bounced,
>                         { SWIOTLB_FORCE,        "FORCE" },
>                         { SWIOTLB_NO_FORCE,     "NO_FORCE" }))
>  );
> +#else
> +#define trace_swiotlb_bounced(dev, phys, size, swiotlb_force)
> +#endif /* CONFIG_SWIOTLB */
> 
>  #endif /*  _TRACE_SWIOTLB_H */
> 
> 

Why not just take whatever change upstream fixes this instead of a
one-off change?

thanks

greg k-h

