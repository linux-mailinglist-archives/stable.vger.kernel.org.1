Return-Path: <stable+bounces-23495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F971861616
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491F61C226B2
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596682882;
	Fri, 23 Feb 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FG9P0lYO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEfyWC+n"
X-Original-To: stable@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDC7D411;
	Fri, 23 Feb 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702898; cv=none; b=eRXgZ7c2bXOTXZUVTqZ/Na+Z30CEMfEdTGtZ1sAskKzFXL0M6Y2eqU+zw/y5Jcp9eTCIismjx7xL7S9PB4g+K6jIZnQ/IPpmyfWm7eHbXJjbVcTZkVRlroWjKWSkPB8iQVuV9e8qMDgNKMA883dQWHcTICCdLl5i1RYWcqXtbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702898; c=relaxed/simple;
	bh=Z9k3RKyGjDR4pf8xZftyzWj0wlnTJxesI6Ak4a3lrhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KseI/G05ltCs+Q9LH7bwEIhcXmq469u7DyAb2A7Eoo8SkurMJk9+TaAGZd/Tx+XuJ4Hhy26ATSagnRetxtAsECxVsaPdHlFxcmACZJVXlU29x73fPwiycNrBYGcwVOsvV2Kvi8CygxMrsY3VBjWbFGoIa0pG8rHVkMlw7tF3Nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FG9P0lYO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QEfyWC+n; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 6F6C520010F;
	Fri, 23 Feb 2024 10:41:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 23 Feb 2024 10:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708702895; x=1708710095; bh=ROzGyJO6Sz
	TNly3NhVW5ayW320GWgGQJnuRmV7EOHzA=; b=FG9P0lYOzKneSEHWeDnnTMN1T9
	HWphlhaj+IHnoctLFctAobbfl2/1oi8sL6FBxnLFy1CRDewOgjuIZl3nV11Iz6gy
	sFU1ofSo4WL2xFawSvELF4ffV8CtV+QJXsZk3VC5dn8ZwtK5rNyDOJCoKDU7C1r6
	soeb0L/YLLZhRHxanuzT7Y/weo1w20wJjujetDVoqiNKwG5oO2uqeNrymXfeWDOx
	NvehLL0TRvBFbsGIea5X/IHeOqDS5p0AOEA3TS9QsJIP+QhX6buRe2jcz0VNj53x
	HYgnyqZinjV9CEqpSMOi89IKuRk7W/Zp43aooU/oE2E5F514vgxCAOrSNbLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708702895; x=1708710095; bh=ROzGyJO6SzTNly3NhVW5ayW320GW
	gGQJnuRmV7EOHzA=; b=QEfyWC+nzZaziFgD2ZCNXE3fxnX66sj0MHK+RpryvzDg
	KTUwvI+99Vi5t4nJ3H2tU6Tzj19DRSa/SxAjBYsTaZFU5h3a/YVgk0LgmGRfLpe1
	VP0G2tOnkhk30Kf7Vp/8iuLCZDUCyS0uDIZ9xHu/cHxYnxAhJsG4ywBdf2S8UNN1
	moE3TngNj4FhDYKFBimMjHriVhJPoZ+tVjxefYQJRX4dXK0P9EhygWml+KYm4fxT
	1jP9d+2P3ZoVdfIBv57fsMjv8gaV9w2M3Emvg35ZN7gIMm3R2AOVMVbT8D6kYmyS
	OYU/C4k15PnFKrLNaPsaRd0vmf8ikLy3LaC2TbyRGQ==
X-ME-Sender: <xms:r7zYZUnBKV_ukLxBKZERCFr3OGKCeuaOZ-ffGv-XNtgfLiYSGpjvgg>
    <xme:r7zYZT3-sM0Y2Qzn7JWZLhJX3aR3p9ECDH7sAdOhU8pHyaxScwNbsY9Wdgm2_Byft
    myU-hZ7lK9EKA>
X-ME-Received: <xmr:r7zYZSpmY9ZQY-CwyVd8Jz3FKab1DeIJoirMJHIyman1LjpOsee_rwn2NOIK-NPVr2LETq9PtogXT0DsoXkawIwktVsDGViDfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeefteevud
    ejvdeiheehvdeutdeffeejuefgueehueeikedvhfegvdekgeffgefgvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhmrghrtgdrihhnfhhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:r7zYZQmot3UXtS_xcgFaMFOdkCdctgE-ymJFCwxo96FSB_inOps1aQ>
    <xmx:r7zYZS1muhJDN3aQpyUhDCULEtq7l6MEGC0wHWwX6Up4lV1o4NHCnA>
    <xmx:r7zYZXuLjCmfGkoRDMyqbI4mTCR4KfizOdaGgs2uJXev-Al8_HY4Gw>
    <xmx:r7zYZV8X9NBqjJhSkuhQklhNU2yl6fq1FThPbHwQjrrE3W10AzfJiN05Fk0>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Feb 2024 10:41:34 -0500 (EST)
Date: Fri, 23 Feb 2024 16:41:28 +0100
From: Greg KH <greg@kroah.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support" has been added to the 5.10-stable tree
Message-ID: <2024022310-cradling-entourage-9f94@gregkh>
References: <20240220012839.518852-1-sashal@kernel.org>
 <ZdRnnp2ql+jRghlZ@x1-carbon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRnnp2ql+jRghlZ@x1-carbon>

On Tue, Feb 20, 2024 at 08:49:35AM +0000, Niklas Cassel wrote:
> On Mon, Feb 19, 2024 at 08:28:39PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      pci-dwc-endpoint-fix-dw_pcie_ep_raise_msix_irq-align.patch
> > and it can be found in the queue-5.10 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hello stable maintainers,
> 
> I notice that upstream commit:
> 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> 
> has been backported (as it should) to:
> 5.10: https://marc.info/?l=linux-stable-commits&m=170839241818847&w=2 (only queued so far)
> 5.15: https://lore.kernel.org/stable/20240122235754.541847685@linuxfoundation.org/
> 6.1:  https://lore.kernel.org/stable/20240122235802.692374956@linuxfoundation.org/
> 6.6:  https://lore.kernel.org/stable/20240122235824.991665077@linuxfoundation.org/
> 6.7:  https://lore.kernel.org/stable/20240122235832.684822707@linuxfoundation.org/
> 
> Unfortunately, while this commit fixed a bug, it introduced another bug.
> 
> 
> This "another bug" is fixed in upstream commit:
> b5d1b4b46f85 ("PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()")
> 
> This fix has been backported to:
> 6.7: https://marc.info/?l=linux-stable-commits&m=170836979506847&w=2 (only queued so far)
> 
> But needs to be backported to 5.10, 5.15, 6.1, 6.6, 6.7.
> 
> It does not apply without conflicts, so I've attached two backported versions.
> (There was a minor conflict with the headers.)
> 
> backport-all-but-5_10.patch - for 5.15, 6.1, 6.6, 6.7
> backport-5_10.patch - for 5.10

For some reason this was applied to 5.10.y, but not the other branches,
our fault!

The other one is now queued up, thanks.

greg k-h

