Return-Path: <stable+bounces-89242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095199B528B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2432283646
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9471FBF50;
	Tue, 29 Oct 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhdEUCup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC77190486
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229396; cv=none; b=Andf1IC/TOzRKcEH9wqFxXmFoJdwMRNSKVKozyQGmdwz2kbrAu2FKEkMkP1C7DxpEHTL8GCe/PxOMnqEUkfq/iRzmy2fw00/ooQqasC6IBMmpAlngF+/NFboo2LEbaxnsbi+aKiq+5kXRE+iTNdfMgwW4VsCUPu6h+Cl9rs2kOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229396; c=relaxed/simple;
	bh=R0tF8vC5j1/G4YXdwi/1Noa2d4Yl4mwDKVNkuCsDCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUab48fLEvqqoPnIsoQwpNExKGze7f5bPiahobr52OtQSD9j7X1JdreeMdkDBu9Xkxv+YpyU8HPc9Wwz6mz28uGmGXtDxFP0L1j1XP3ZMLlh5J8K1IVCEoqZQ68xOZyPG5MS3K/LwPyM+S47E68SQviKBfy8GHDEEBKXu0CK5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhdEUCup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF2C4CECD;
	Tue, 29 Oct 2024 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730229396;
	bh=R0tF8vC5j1/G4YXdwi/1Noa2d4Yl4mwDKVNkuCsDCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhdEUCupdItxcq0dmqfjSNmi0/Dca6AVKIdRebwMdgqKMJ5YDNNslbRGMVU5uXbUW
	 nTopo9kg7HFLbwz02Pa5O1VgGZuYxlNMgX1Cm/XlSVvf7gO374D48LidFP92bDV1IE
	 L7hdG2vd8jsztBCGJzH/7EPTKnBSTwbXqOTk4zFJeudauEBoeaOw5ljVtlfTTG6X7E
	 /GZZL3s8R2ZK1e1ao9frvouHQlPEIw0FA9Jzbh9ho2Xz3imRi9QIPWjtpP700QGBDP
	 UZ3V43Fc6YOQ5MLzxm1M0rTfMabc6DRmYwLJrJyfLSlY6fxaufKxMS1AIxzKvWvTjQ
	 A1+NK/OH5aVHg==
Date: Tue, 29 Oct 2024 13:16:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, bob.beckett@collabora.com,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org>
 <20241029074117.GB22316@lst.de>
 <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>

On Tue, Oct 29, 2024 at 11:58:40AM -0700, Gwendal Grignou wrote:
> On Tue, Oct 29, 2024 at 12:41 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> > > is a NMVe to eMMC bridge, that can be used with different eMMC
> > > memory devices.
> >
> > Holy f**k, what an awful idea..
> >
> > > The NVMe device name contains the eMMC device name, for instance:
> > > `BAYHUB SanDisk-DA4128-91904055-128GB`
> > >
> > > The bridge is known to work with many eMMC devices, we need to limit
> > > the queue depth once we know which eMMC device is behind the bridge.
> >
> > Please work with Tobert to quirk based on the identify data for "his"
> > device to keep it quirked instead of regressing it.
> 
> The issue is we would need to base the quirk on the model name
> (subsys->model) that is not available in `nvme_id_table`. Beside,
> `q_depth` is set in `nvme_pci_enable`, called at probe time before
> calling `nvme_init_ctrl_finish` that will indirectly populate
> `subsys`.
> 
> Bob, to address the data corruption problem from user space, adding a
> udev rule to set `queue/nr_requests` to 1 when `device/model` matches
> the device used in the Steam Deck would most likely be too late in the
> boot process, wouldn't it?

I think that is too late. There's the module parameter,
'nvme.io_queue_depth=2', that accomplishes the same thing as this quirk,
if adding kernel parameters isn't too inconvenient to use here.

Alternatively, you could put the quirk in the core_quirks, which do take
a model name. The pci driver would have to move this check until after
init_ctrl_finish, as you noticed, but that looks okay to do. We just
need to be careful to update both dev->q_depth and ctrl->sqsize after
the "finish".

