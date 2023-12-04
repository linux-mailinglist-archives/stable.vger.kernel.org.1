Return-Path: <stable+bounces-3980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193718042EC
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B844B20BD2
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 23:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792903AC0F;
	Mon,  4 Dec 2023 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v5/Ey+r9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09E393;
	Mon,  4 Dec 2023 23:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D17C433C7;
	Mon,  4 Dec 2023 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701734143;
	bh=uVTUmGDOmFsVPIS9YpIyI/1ETQQbLq2C9vA3aKMy1Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v5/Ey+r9ILVqU0CicEZ1hN+IwF46I0t8FDhjD99cPAqJXUQOjaiVzh2PfuT7H9DVR
	 qIkjvFIqdnmi0NoX+7B8h+hELO7SvuwM9vjsxyalwd5H1kGgWRaM9EznqZmfwS+rmt
	 xQ7CnZde4VE/8/5GKNsGgjkAvIyDseV9FDVE/AyY=
Date: Tue, 5 Dec 2023 08:55:39 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	mario.limonciello@amd.com, regressions@lists.linux.dev,
	regressions@leemhuis.info, Basavaraj.Natikar@amd.com,
	pmenzel@molgen.mpg.de, bugs-a21@moonlit-rail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "xhci: Enable RPM on controllers that support
 low-power states"
Message-ID: <2023120521-dusk-handwrite-cea3@gregkh>
References: <3d3b8fd3-a1b9-9793-b709-eda447ebd1ab@linux.intel.com>
 <20231204100859.1332772-1-mathias.nyman@linux.intel.com>
 <070b3ce1-815c-4f3d-af09-e02cda8f9bf0@amd.com>
 <db579656-5700-d99b-f1eb-c1e27749eb7b@linux.intel.com>
 <f28b4e98-dd9b-458e-8a72-a9da3c0727cd@amd.com>
 <273a8811-f34e-dbe7-c301-bb796ddcced1@linux.intel.com>
 <e0781c30-a22e-40b5-a387-bae92672c2cd@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0781c30-a22e-40b5-a387-bae92672c2cd@amd.com>

On Mon, Dec 04, 2023 at 08:59:35PM +0530, Basavaraj Natikar wrote:
> 
> On 12/4/2023 8:36 PM, Mathias Nyman wrote:
> > On 4.12.2023 16.49, Basavaraj Natikar wrote:
> >>
> >> On 12/4/2023 7:52 PM, Mathias Nyman wrote:
> >>> On 4.12.2023 12.49, Basavaraj Natikar wrote:
> >>>>
> >>>> On 12/4/2023 3:38 PM, Mathias Nyman wrote:
> >>>>> This reverts commit a5d6264b638efeca35eff72177fd28d149e0764b.
> >>>>>
> >>>>> This patch was an attempt to solve issues seen when enabling
> >>>>> runtime PM
> >>>>> as default for all AMD 1.1 xHC hosts. see commit 4baf12181509
> >>>>> ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
> >>>>
> >>>> AFAK, only 4baf12181509 commit has regression on AMD xHc 1.1 below is
> >>>> not regression
> >>>> patch and its unrelated to AMD xHC 1.1.
> >>>>
> >>>> Only [PATCH 2/2] Revert "xhci: Loosen RPM as default policy to cover
> >>>> for AMD xHC 1.1"
> >>>> alone in this series solves regression issues.
> >>>>
> >>>
> >>> Patch a5d6264b638e ("xhci: Enable RPM on controllers that support
> >>> low-power states")
> >>> was originally not supposed to go to stable. It was added later as it
> >>> solved some
> >>> cases triggered by 4baf12181509 ("xhci: Loosen RPM as default policy
> >>> to cover for AMD xHC 1.1")
> >>> see:
> >>> https://lore.kernel.org/linux-usb/5993222.lOV4Wx5bFT@natalenko.name/
> >>>
> >>> Turns out it wasn't enough.
> >>>
> >>> If we now revert 4baf12181509 "xhci: Loosen RPM as default policy to
> >>> cover for AMD xHC 1.1"
> >>> I still think it makes sense to also revert a5d6264b638e.
> >>> Especially from the stable kernels.
> >>
> >> Yes , a5d6264b638e still solves other issues if underlying hardware
> >> doesn't support RPM
> >> if we revert a5d6264b638e on stable releases then new issues (not
> >> related to regression)
> >> other than AMD xHC 1.1 controllers including xHC 1.2 will still exist
> >> on stable releases.
> >
> > Ok, got it, so a5d6264b638e also solves other issues than those
> > exposed by 4baf12181509.
> > And that one (a5d6264b638) should originally have been marked for stable.
> >
> > So only revert 4baf12181509, PATCH 2/2 in this series
> 
> Thank you, that is correct.

So just take patch 2/2 here, or will someone be sending me a new patch?

thanks,

greg k-h

