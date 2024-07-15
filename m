Return-Path: <stable+bounces-59364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B207931900
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 19:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE04B20BB9
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40C3B295;
	Mon, 15 Jul 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgSP+ynl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC117BB4
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063565; cv=none; b=kpymuZ2LvGItFc63+ReCFUiVi7ZnYylfsUydtzxi9/45lERM0G0wKoh/Sdu7GtGa35KR+IJ880fB6BDZjkWoCT6V3LCTyXjg8xdu5n9iUddzgW7lftXlcfhbtHGgbJ5hfcBupEZWVKe9vyh/7qKHl3Oxdkpm5l3ow8UMXRxYTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063565; c=relaxed/simple;
	bh=e4UsLlcsZ+Xq+XJSubh6fDPlQcSi9RrRLw337z42nmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEwIgavk142irfTi9ay1AegYsZ1LBbPygxnqdWK9CoOrT+UiMUdB/ojWUpArDDuI+MnlA9MoSlsfqzWhhD7dEvgxb4f2A1RRw6nBnDeZntUYsHKKXrg/AnjNFbJJ5j+DGdA2SV681woY+2g+guq7rEQxmy8I/DSvWUsBGu1fcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgSP+ynl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA636C32782;
	Mon, 15 Jul 2024 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721063565;
	bh=e4UsLlcsZ+Xq+XJSubh6fDPlQcSi9RrRLw337z42nmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgSP+ynlXSFopp1qd9mQBmp+MRpbqapK00pOkvXwB/pMpD6J/466JyBMPyS0sIum7
	 IpURfW/hMxuNuHQ0o4MZEx3r/7de0nr5y7K4VbAzCHUZ12Q1fsNNyEuw8YqJuHrDlf
	 4M8t+zTxaGWZ2rq8L9Jbmx8/qd7CCHPV+RLm7f2I=
Date: Mon, 15 Jul 2024 19:12:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: merge regions aggressively
 when max_nr_regions" failed to apply to 5.15-stable tree
Message-ID: <2024071532-pebble-jailhouse-48b2@gregkh>
References: <2024071546-swerve-grew-de52@gregkh>
 <20240715170209.74009-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715170209.74009-1-sj@kernel.org>

On Mon, Jul 15, 2024 at 10:02:09AM -0700, SeongJae Park wrote:
> Hi Greg,
> 
> On Mon, 15 Jul 2024 13:34:47 +0200 <gregkh@linuxfoundation.org> wrote:
> 
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
> > git cherry-pick -x 310d6c15e9104c99d5d9d0ff8e5383a79da7d5e6
> 
> Similar to the failure of this patch for 6.1.y, I cannot reproduce the conflict
> on my setup.  Attaching the patch for successfully cherry-picked one on my
> machine for any possible case.

Same issue as 6.1, it breaks the build :(


