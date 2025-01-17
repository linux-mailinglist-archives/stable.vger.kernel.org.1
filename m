Return-Path: <stable+bounces-109357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD941A14F1A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF63A5C3E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313B1FDE3A;
	Fri, 17 Jan 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q27UYcB3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8AB1F8AD3;
	Fri, 17 Jan 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116465; cv=none; b=XYWHxpmKce9HRglQsWQ5uPFr4kkgXN5C0jYUxOmLcgWcvedWAJ0XQSvCTrzYDiAZq+1zTxCteEJdmiLkQrZ8S8SbHI4KwGhb1faA46jCDhs7fIehWNy+T6Gmg5jmvDQgpbnkZbk8cWQM1VPLZZOFg4ywi5oxF2fXewl6Iu1iqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116465; c=relaxed/simple;
	bh=tkk39BsqUGO++Mom1wWdpAE+rVS/3G/WptLUCPNW6mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwuGniqLhNg4XOtk4fQ31CWata0BPk2jYga0IJNUkEYBRzL0o9qC1pQWKoU2fj0yAveVGeL04T/xmI/6qHshoI+wbonZOK4PCpdT0vW03toOTRdj1V+EjC8QDiY/09v/4Kj/VpRjtiRdXCcy+HSpTdALboE3jHtQe0RjfWmG6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q27UYcB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1420C4CEDD;
	Fri, 17 Jan 2025 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737116465;
	bh=tkk39BsqUGO++Mom1wWdpAE+rVS/3G/WptLUCPNW6mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q27UYcB3hSejZaM5AxDXnSb6Epaog8gNXMDp9o+/cKjDLFL50CtP6aiIDDyAD+2bo
	 +dymranqQi4fO2ry16eNqG2mWnIRH1622z8p4Fb0TBTBu0QW21T+XRe4T+lr0wbj2W
	 iHyAJnlcJQZIU0Mgjw+lNucUct1Dpr9uc4cm+R/U=
Date: Fri, 17 Jan 2025 13:21:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 182/189] drm/xe/oa: Separate batch submission from
 waiting for completion
Message-ID: <2025011731-unable-visibly-462d@gregkh>
References: <20250115103606.357764746@linuxfoundation.org>
 <20250115103613.670557960@linuxfoundation.org>
 <85tta0djlo.wl-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85tta0djlo.wl-ashutosh.dixit@intel.com>

On Wed, Jan 15, 2025 at 10:20:51AM -0800, Dixit, Ashutosh wrote:
> On Wed, 15 Jan 2025 02:37:58 -0800, Greg Kroah-Hartman wrote:
> >
> 
> Hi Greg,
> 
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/xe/oa: Separate batch submission from waiting for completion
> >
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-xe-oa-separate-batch-submission-from-waiting-for.patch
> > and it can be found in the queue-6.12 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> I am writing about 3 emails I received (including this one) about 3 commits
> being added to stable. These are the 3 commits I am referring to (all
> commit SHA's refer to Linus' tree and first commit is at the bottom,
> everywhere in this email):
> 
>     2fb4350a283af drm/xe/oa: Add input fence dependencies
>     c8507a25cebd1 drm/xe/oa/uapi: Define and parse OA sync properties
>     dddcb19ad4d4b drm/xe/oa: Separate batch submission from waiting for completion
> 
> Apparently these are added to stable to avoid conflicts with this commit:
> 
>     f0ed39830e606 xe/oa: Fix query mode of operation for OAR/OAC
> 
> However, the 3 commits are part of a 7 commit series and are incomplete in
> themeselves and will break userspace. So we should add the remaining 4
> commits of the series to stable too. Thes are the ones:
> 
>     85d3f9e84e062 drm/xe/oa: Allow only certain property changes from config
>     9920c8b88c5cf drm/xe/oa: Add syncs support to OA config ioctl
>     cc4e6994d5a23 drm/xe/oa: Move functions up so they can be reused for config ioctl
>     343dd246fd9b5 drm/xe/oa: Signal output fences
> 
> The above list can be generated by running the following in Linus' tree:
> 
>     git log --oneline -- drivers/gpu/drm/xe/xe_oa.c

For now I've just dropped all of these commits, can someone send a
series in the correct order, or a properly backported fix of the
original bugfix, and we can take them that way.

thanks,

greg k-h

