Return-Path: <stable+bounces-89171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD549B4352
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 08:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA359B211D1
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FF202643;
	Tue, 29 Oct 2024 07:41:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102B18FDDF
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187684; cv=none; b=CguwmGpXWOji5DJnm1XeSSCLlsLgXEK7MKAnJYlSG4NxFEVrnsvQ4fl31QD2vV6UxohSAIhFD5/kAmCx8Uh49aKuCuxsDRFdMYBCr+i36Nr3MJbDhLrQoLvef/2Ut+KlsMvh+VVUd2jAxfqXAtAJsOW0K/gFhMVFpGMah2H1DFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187684; c=relaxed/simple;
	bh=tWDC3FYx1OLn7JGDHSep/0g1oTF1pj7uA9waY2HoDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtV1Ws6oNzsnlRLkjlDGeUpZVfInvJM7/Ro42T/ulrdl9ymkSIS2ofSt0EGCdvelepxm70K6U+/7c9ikt4ExhKhWu6wQUT5eqGW9c/ZIrB27w/6GKIP928OyL7wOWEfqI9FIquk1Nf/yyyOLWwSzbAP4wKZqITlvHquDBxsqJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDE85227A88; Tue, 29 Oct 2024 08:41:17 +0100 (CET)
Date: Tue, 29 Oct 2024 08:41:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bob.beckett@collabora.com, hch@lst.de, kbusch@kernel.org,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <20241029074117.GB22316@lst.de>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com> <20241029024236.2702721-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029024236.2702721-1-gwendal@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> is a NMVe to eMMC bridge, that can be used with different eMMC
> memory devices.

Holy f**k, what an awful idea..

> The NVMe device name contains the eMMC device name, for instance:
> `BAYHUB SanDisk-DA4128-91904055-128GB`
> 
> The bridge is known to work with many eMMC devices, we need to limit
> the queue depth once we know which eMMC device is behind the bridge.

Please work with Tobert to quirk based on the identify data for "his"
device to keep it quirked instead of regressing it.

