Return-Path: <stable+bounces-172285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C01B30DFE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20C2564BC0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB52E1F06;
	Fri, 22 Aug 2025 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XK1q/p7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741102E1EE3
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 05:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840693; cv=none; b=jOiO30SMID+UlLzGni50KlSvLUnpLqpokmohOTNzF0uopkCBLy/8jIA6ZcyIptLLPGBx2k22xV3bfYChlOIVQR47kwBjxYahTKXueTQ6yyT0iQMApl6uNJYRt1UQ3rVp43/li5QvUJaFZzA8YBFEjjqc8/mQnLRgXDOYaRiZ1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840693; c=relaxed/simple;
	bh=GdtgRIk6DlfRGNU6pNWNSPjZAk1h9p7VNbcyswngZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9XY7eBdIFRXDAdlelgK8ewi4H+fq3+QNBIKDVANe90O05o8Pyxl1bcOFGWhvW8AqR40kfpkiWJwScWwcA8G4EzfTKWMl9G5GgG5BI2Nj8iJslLQLRhzCj5L1792ZWAKKGhmRdvmtb0KTUOXqcgLquwcZY7od2A4Sh5vWjOxRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XK1q/p7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF27C4CEF1;
	Fri, 22 Aug 2025 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755840693;
	bh=GdtgRIk6DlfRGNU6pNWNSPjZAk1h9p7VNbcyswngZsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XK1q/p7eBIXXwXRiAQr9aMPGtqT0Pj3R+iM5LMrDHROyDzpU5pSZjFrnLSE98REXq
	 yNBdR6I5Cu7t+u5rV9xMJ1C0AHWJJ14KcBmTlvxVxtmjgk57XibUqaxX5Jm2zILcKY
	 Gu1F1bw3gKrmBlb8sbIlP6jXj1MnrF499rpzXvts=
Date: Fri, 22 Aug 2025 07:31:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org, "Patni, Archana" <archana.patni@intel.com>,
	bvanassche@acm.org, martin.petersen@oracle.com
Subject: Re: FAILED: patch "[PATCH] scsi: ufs: ufs-pci: Fix default runtime
 and system PM levels" failed to apply to 5.15-stable tree
Message-ID: <2025082259-achiness-exterior-aebe@gregkh>
References: <2025082102-levitate-simple-9760@gregkh>
 <0bff6489-402b-4c4f-bd7f-fe8ff526f91b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bff6489-402b-4c4f-bd7f-fe8ff526f91b@intel.com>

On Fri, Aug 22, 2025 at 08:10:39AM +0300, Adrian Hunter wrote:
> On 21/08/2025 16:09, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1
> 
> This works for me even though ufshcd-pci.c has moved since then
> from drivers/scsi/ufs/ to drivers/ufs/host/
> 
>   $ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
>   From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>    * branch                      linux-5.15.y -> FETCH_HEAD
>   $ git checkout FETCH_HEAD
>   HEAD is now at c79648372d02 Linux 5.15.189
>   $ git show --stat 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1 | grep ufshcd-pci.c
>    drivers/ufs/host/ufshcd-pci.c | 15 ++++++++++++++-
>   $ git cherry-pick -x 6de7435e6b81fe52c0ab4c7e181f6b5decd18eb1
>   Auto-merging drivers/scsi/ufs/ufshcd-pci.c
>   [detached HEAD 15aa885c945e] scsi: ufs: ufs-pci: Fix default runtime and system PM levels
>    Date: Wed Jul 23 19:58:50 2025 +0300
>    1 file changed, 14 insertions(+), 1 deletion(-)
>   $ git show --stat HEAD | grep ufshcd-pci.c
>    drivers/scsi/ufs/ufshcd-pci.c | 15 ++++++++++++++-
> 
> Please note 4428ddea832cfdb63e476eb2e5c8feb5d36057fe works too:
> 
>   $ git cherry-pick -x 4428ddea832cfdb63e476eb2e5c8feb5d36057fe
>   Auto-merging drivers/scsi/ufs/ufshcd-pci.c
>   [detached HEAD 9b324ade6f64] scsi: ufs: ufs-pci: Fix hibernate state transition for Intel MTL-like host controllers
>    Author: Archana Patni <archana.patni@intel.com>
>    Date: Wed Jul 23 19:58:49 2025 +0300
>    1 file changed, 27 insertions(+)

I don't use cherry-pick, so if a file moves it's hard to detect at
times.  Can you send me the patch that you have properly generated (and
built-tested)?

thanks,

greg k-h

