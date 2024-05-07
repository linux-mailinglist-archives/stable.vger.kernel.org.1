Return-Path: <stable+bounces-43190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A78BE6D8
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A91F235EC
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7DE16130A;
	Tue,  7 May 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAtEwbjk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3E15F414;
	Tue,  7 May 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094172; cv=none; b=VA2rkXYSjKda4I0+v/TmeV5/Vu339vfLvLClGet9qKQIQWVxE3xi3rkoIc0BHjch8udMYXRl76xCgJH6F50HIDnWMcOXokLI89J0eSfC63jMEACIyHE5L9VhrydRfrfTSJ+fPD+xr3YftqqSrsQgL34n5bMhyZjmYiNbeAtMf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094172; c=relaxed/simple;
	bh=gn0W/1EWIXO6epjS/6/rnHSMUoGl5NRWDPejbySshu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac8mBN8M1WPZxaoX5AMauvpjEix5fF2UHXySVXPE57jfQtnWaVH9eA3eQRzhjYD5sy+nrEt6Jt2vQlglzhxXz5kiJy6ks8e7/hNIG4j2nPdxrMCILyzYbtsaZ1C/uAqqctOtHUjjy52n0bi6reen2GjAM+dyeiLJbZBTZoL0Nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAtEwbjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4497C2BBFC;
	Tue,  7 May 2024 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094172;
	bh=gn0W/1EWIXO6epjS/6/rnHSMUoGl5NRWDPejbySshu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAtEwbjkyVKi5gGkBXntmdl65SXUOd/ocHNPLfbZH0uu//BIdPEjMJl1iR9b8NFVv
	 jyvQdQlNKHj2CbJ6aj/uRY8Na6DGekQyuOM0r5SQF5F1wVJkROMqLCRhV6ARHgf3x4
	 CncsB1TaB8SHoh0VMpHC+nyO7ck63NvE1fF4YESYTeQGofHStWAGlRKTIjYXbgxYB2
	 znJXYXv8S2aPWemIfg21ELrI7Fd2+lQKay7PwSpF8C4wpNyqmrcsLZXw7oppq5DDhu
	 WS7+w9Q7SWyNmmJ+0Zp3O16EZcCnHss39qgzwLMNIC84zoXGgV6cHObNZ+V6j3L99A
	 +dDTpk8a2teWQ==
Date: Tue, 7 May 2024 09:02:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
Message-ID: <ZjpCmj4sf68Wlck_@kbusch-mbp.dhcp.thefacebook.com>
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422162822.3539156-1-sean.anderson@linux.dev>

On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
> support, all commands time out resulting in the following message:
> 
> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
> 
> These timeouts cause the boot to take an excessively-long time (over 20
> minutes) while the initial command queue is flushed.
> 
> Address this by adding a quirk for drives with buggy MSIs. The lspci
> output for this device (recorded on a system with MSI-X support) is:
> 
> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
> 	Subsystem: Sandisk Corp Device 5008
> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 3
> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [c0] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
> 	Capabilities: [1b8] Latency Tolerance Reporting
> 	Capabilities: [300] Secondary PCI Express
> 	Capabilities: [900] L1 PM Substates
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Thanks, applied to nvme-6.9.

