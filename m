Return-Path: <stable+bounces-74123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2935A972ADE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8810284D49
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1417C9EB;
	Tue, 10 Sep 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M628pSPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4D282E2
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953613; cv=none; b=NTBqBDo/nSu2UCj4OGNstPk+iKDkFoJ4ITQboHVu8o2soVwPKJA9znvP4GIPK/OXzzmF0W519RZO575TUe/E9Yw7liwZgBUl3hqjkXaR4V8FZiVRDVestVA+PeMPVjNglh/w9K4ck/oNNcPdZPSp8RpLHhSPCsNeW0Z+0jpzMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953613; c=relaxed/simple;
	bh=egdQG7ysKHOIfyVr3fMZoLN4xnT4+psasmyFhs5fPB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfcokzJfuDZiszK9VGgTbVYj9RiPSpZlfiNLpfXiFxbF4jW41BE58yxm7zqNEXERGTgOR+M3V31//ZqjiX4zpYX8m9M2BoLVAji8wFO3LdS/u7Nb6AiLs6b3xQIuv8Si4g/dOb0Znwlw39r2W5gffjv4Bw2laHWskSo6lsbzROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M628pSPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76715C4CEC3;
	Tue, 10 Sep 2024 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725953612;
	bh=egdQG7ysKHOIfyVr3fMZoLN4xnT4+psasmyFhs5fPB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M628pSPrgRuKE7hLwTO53N4NriHKooAcEfLiduEdBvMW0NexfD0eAFdVpzVFUjTT6
	 RecklpIxGuLfY2Y5iWU5AmrFUwQtM3igwb+OgesLsqYW1v0WMPetX33M7TgojFY7EV
	 maNW+DLCivV+ECPjRFG8zXdGMmiz31ZaFm2+YUbI=
Date: Tue, 10 Sep 2024 09:33:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: sh8267.baek@samsung.com, ritesh.list@gmail.com, ulf.hansson@linaro.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mmc: cqhci: Fix checking of CQHCI_HALT
 state" failed to apply to 5.10-stable tree
Message-ID: <2024091016-diner-collide-5edc@gregkh>
References: <2024090852-importer-unadorned-f55b@gregkh>
 <d1d85600-1d80-438d-be24-14c51ec3e576@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d85600-1d80-438d-be24-14c51ec3e576@intel.com>

On Mon, Sep 09, 2024 at 08:15:41AM +0300, Adrian Hunter wrote:
> On 8/09/24 14:28, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
> 
> The file name changed from cqhci.c to cqhci-core.c but git 2.43.0
> seems to handle it:
> 
> $ git version
> git version 2.43.0
> $ git log --oneline | head -1
> b57d01c66f40 Linux 5.10.225
> $ git cherry-pick -x aea62c744a9ae2a8247c54ec42138405216414da
> Auto-merging drivers/mmc/host/cqhci.c
> [detached HEAD dd4085252f0d] mmc: cqhci: Fix checking of CQHCI_HALT state
>  Author: Seunghwan Baek <sh8267.baek@samsung.com>
>  Date: Thu Aug 29 15:18:22 2024 +0900
>  1 file changed, 1 insertion(+), 1 deletion(-)

Note, we don't use git to apply backports like this, but I used it to
create the "raw" diff now, thanks!

greg k-h

