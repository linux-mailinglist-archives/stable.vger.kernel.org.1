Return-Path: <stable+bounces-208367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E726CD1FB76
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D5643016782
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CF39E160;
	Wed, 14 Jan 2026 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLY2zqft"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15339C63E
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404113; cv=none; b=sIegX9nkvLWw5uV3L0FU6D2uf84WjLZBrge4b+y99HEEh8FiLPrP+eMRkxLecedfL8xl0r/qbWnBA/JWDeOQlakxITvWogpxbp9HXCTK87Z0TZJvCSQYCpzgmEUsNUD5N5n6nCh/Suvvi4bVl4nWOJa8F6c32LuWJ4yXzloynHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404113; c=relaxed/simple;
	bh=+61og6uMxgSmno3yVQ3OVIk7mMzk8d6px6uRQZkpJN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSYL/gOuvpaSKeaMz6OGRDPfVDM/u1iEO7MMBtaIhomDKH7+vxBzkPMERNBNarZZnnNSAA1jeeQKsTqS9P+TCfYBHrvLfmBS0I2a61ZFVZBrs++zLwxwsVFz+cxd/Ymox26kS+qlNxbbPCCk/qw3zUuTrsgGnIdn9YKpW0q74rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLY2zqft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C8DC4CEF7;
	Wed, 14 Jan 2026 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404112;
	bh=+61og6uMxgSmno3yVQ3OVIk7mMzk8d6px6uRQZkpJN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLY2zqftEqzdVvCtB/sv1ditE5JYzFYHeoy53VDmVh+GjeJVCM25UdiMB1K3qu8QU
	 +PFQxNpT0s/emuPwoHZ/7hrMY+icdCJirxtVmlh6i93mYCMozmMAW0o9/TJ8MiYUwS
	 DoLECHwOTay8j1ckSS8WkTBfIbYRU48Rm2PoU9mXkpt4AHXxWy6o5SaC6Mdd65qOTU
	 B2Be0GCNMCjyWpX0eeWwMdwhpOqWjFkm8irmrjUXXuRnJA0Mce/msAB6m3XS74bzB0
	 Z33GpIoHHL85NZhOEy0K8MtMMpparY3lgfxkcLUoAsM25eRQHffvxTwwbo87TmewgG
	 CuVv8x50uWSXQ==
Date: Wed, 14 Jan 2026 08:21:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, jmeneghi@redhat.com, wagi@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	james.smart@broadcom.com, hare@suse.de, shinichiro.kawasaki@wdc.com,
	wenxiong@linux.ibm.com, nnmlinux@linux.ibm.com, emilne@redhat.com,
	mlombard@redhat.com, gjoyce@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix PCIe subsystem reset controller state
 transition
Message-ID: <aWe0ja2rCpRFQEke@kbusch-mbp>
References: <20260114072416.1901394-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260114072416.1901394-1-nilay@linux.ibm.com>

On Wed, Jan 14, 2026 at 12:54:13PM +0530, Nilay Shroff wrote:
> The commit d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING
> state") disallows controller state transitions directly from RESETTING
> to LIVE. However, the NVMe PCIe subsystem reset path relies on this
> transition to recover the controller on PowerPC (PPC) systems.
> 
> On PPC systems, issuing a subsystem reset causes a temporary loss of
> communication with the NVMe adapter. A subsequent PCIe MMIO read then
> triggers EEH recovery, which restores the PCIe link and brings the
> controller back online. For EEH recovery to proceed correctly, the
> controller must transition back to the LIVE state.
> 
> Due to the changes introduced by commit d2fe192348f9 ("nvme: only allow
> entering LIVE from CONNECTING state"), the controller can no longer
> transition directly from RESETTING to LIVE. As a result, EEH recovery
> exits prematurely, leaving the controller stuck in the RESETTING state.
> 
> Fix this by explicitly transitioning the controller state from RESETTING
> to CONNECTING and then to LIVE. This satisfies the updated state
> transition rules and allows the controller to be successfully recovered
> on PPC systems following a PCIe subsystem reset.

Thanks, applied to nvme-6.19.

