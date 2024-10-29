Return-Path: <stable+bounces-89156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213D9B40A6
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 03:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A85B218D5
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 02:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8912E1E0;
	Tue, 29 Oct 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fKY1u0tT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F24400
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170357; cv=none; b=QoNd6eSOaOXFFMSBOcFtTccOK/hEvtNmnjFgcabszmROHb+XC+rxoH36CrOyuKwIeS1Tfbh6XmgHToHzK5mQn/nM6eK+JDB7m049EGI6/Cz9GDdLtM68djLUYj7wHpu4FChP3f4YsltQEtRyPLxWsXAj3Hc05KaGl0Dku92H2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170357; c=relaxed/simple;
	bh=/30j8m/4TwI+cAFWd4X7nt4B8VSmsRYpx7HC4ohV6r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tItEeNOHG0RILkJ8erk0Lxo88z0CihdIcvasCdCD7ua4lKgnWIFR12uC5MFiOdr87e9weo24jjSt5p+t0b7nopNUK3bFWfk0jXA6gRu+hA0BS7llbwlFmpoTqfMgrsORryxFwEi2LCu5NpNDpmyHW9lCKOS5Z7KIAjYxq3f+IkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fKY1u0tT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B145DC4CEC3;
	Tue, 29 Oct 2024 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730170357;
	bh=/30j8m/4TwI+cAFWd4X7nt4B8VSmsRYpx7HC4ohV6r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKY1u0tTKAD0Ax48m3hfBzUt6LJbXAyADmx5UPgRREGnLpoOgc8tPGE9HEl/Ox7G+
	 hygHpObaNUchR8pK6dsi1B7ACMLcNsQjjJNilaYllsl+14ZXuOurbij2xrKE8BMZf+
	 Z7aBjmEK9lfB3k2VqAJBJjm2alTByHdtKmzAcIsw=
Date: Tue, 29 Oct 2024 03:52:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bob.beckett@collabora.com, hch@lst.de, kbusch@kernel.org,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <2024102948-granddad-exchange-3c05@gregkh>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029024236.2702721-1-gwendal@chromium.org>

On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> is a NMVe to eMMC bridge, that can be used with different eMMC
> memory devices.
> The NVMe device name contains the eMMC device name, for instance:
> `BAYHUB SanDisk-DA4128-91904055-128GB`
> 
> The bridge is known to work with many eMMC devices, we need to limit
> the queue depth once we know which eMMC device is behind the bridge.
> 
> Fixes: commit 83bdfcbdbe5d ("nvme-pci: qdepth 1 quirk")

Nit, no need for "commit" here, and no blank line after this one.

thanks,

greg k-h

