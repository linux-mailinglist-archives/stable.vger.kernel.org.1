Return-Path: <stable+bounces-85063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B03B99D54E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 19:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302EA1F24D47
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFF1BFE10;
	Mon, 14 Oct 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1iKYJpb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16774B5AE;
	Mon, 14 Oct 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925813; cv=none; b=QcwN60DjX/FhifH+ilekk7tHfIcIHafSG52jhP6DFjfmArQKj0BVJ2wc/CjAeo/+gKUfzLG2FQFT92+HDZWK8CS8pWz4DJ2woYYxL6VGnmw0x1bRZUSYqrKXwedWkCn4yoLf7TTaMT01XGAyU5pgiZqPMwvgruOs81iVoy5yPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925813; c=relaxed/simple;
	bh=hI45y9RXbredZJP5T/T5WpcvQbveovMSTU61tMPu7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mQ492/AS5ohazUGZwKlWWRMprwNkDdZhYfss4snuw3iaIXu7gQFjeOfRS0yOxegrnS2nCkP3Ws2Ye6WSQqbVqOo7wr4s3ypNQvXOTkXpEnHP+LX9/mI5PkeTqJjM/EbW4C2D165/YOMHfqXxAZxq2nNZLEKGjTq1iLRn2pqPLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1iKYJpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC79C4CEC3;
	Mon, 14 Oct 2024 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925813;
	bh=hI45y9RXbredZJP5T/T5WpcvQbveovMSTU61tMPu7g8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H1iKYJpbUmDpK4UNNZgLaEd4W3tSDaFtR0EKfGXOrBhVdfMdMCdm9/2IH1KqJ6uY6
	 iou1Z+QwOynvdppzZmPsx7bIiuX9e4A6uy5kKQIG9AyRqGfkqlDtMtCeqSMHYoYJ/n
	 HjOb84HK3vbdEASaR0cxGZ1CulEValhgzIF3rWOdgcTK0amqoewK9lZlq9ZwgX1Vlz
	 nJWtX28rgedOvLBDFYeH12Kxr3VAR5qQtAs109akYJk6NmBq12gDOGuNtJDYTFcOVs
	 ObcajDNP5dXuZDkv+WsRkXOQT4Zr3wSqYyJnapeXsuCOax26a2AWpnqQztZ1umJw31
	 H8Br8a5UkzOfA==
Date: Mon, 14 Oct 2024 12:10:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marcin =?utf-8?B?TWlyb3PFgmF3?= <marcin@mejor.pl>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect pci_for_each_dma_alias()
 for non-PCI devices
Message-ID: <20241014171011.GA612212@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81fb7bb-4a80-4c45-b9fa-5fc485e134ca@linux.intel.com>

[+cc Marcin]

On Mon, Oct 14, 2024 at 09:39:20AM +0800, Baolu Lu wrote:
> On 2024/10/12 11:07, Lu Baolu wrote:
> > Previously, the domain_context_clear() function incorrectly called
> > pci_for_each_dma_alias() to set up context entries for non-PCI devices.
> > This could lead to kernel hangs or other unexpected behavior.
> > 
> > Add a check to only call pci_for_each_dma_alias() for PCI devices. For
> > non-PCI devices, domain_context_clear_one() is called directly.
> > 
> > Reported-by: Todd Brandt<todd.e.brandt@intel.com>
> > Closes:https://bugzilla.kernel.org/show_bug.cgi?id=219363
> > Fixes: 9a16ab9d6402 ("iommu/vt-d: Make context clearing consistent with context mapping")
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Queued for v6.12-rc.

Please include information about Marcin's report as well (assuming it
is the same problem).  Marcin did a LOT of work to report and bisect
this, so both should be acknowledged here.

See https://bugzilla.kernel.org/show_bug.cgi?id=219349

Bjorn

