Return-Path: <stable+bounces-23850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1C868B65
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F218228775D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE813540A;
	Tue, 27 Feb 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XE6c1ym6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E11353F9
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024136; cv=none; b=hfbiXM9ijN/Liw/99rD76z/Lx21EEx6u2rNIia0387YPxU24/GYmuKPDSTKLQWCGbozbB+Kjz1cBMTZNm7w++O5o40OuOASiLpmUTvOaRw6gPJQqFrkUvN4/zott5u4l/8cR5NBr5jHKxAxrnuqBKqvm2wzimEPjJpNxD6tS0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024136; c=relaxed/simple;
	bh=X17/VvrTRdEyRy6j9qMljKzrkFMhkPyOmOxYnul1HAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGfcN2K/oAwW/2Hk+K4J8Mg0GqVGwU9za+CusDj5j4Jc6PSY1Cx+2EmZyEWpvNWNgeIkUgeD2Ie2d8nHm2Q2DWPOWWc6q/PmfLNZvYAOp6HY3Rj/8IB/WbA5R2dii/SefR7a2BqjOp+hjbB6ddcwadMKxwaepMh1UDa7GnR1Yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XE6c1ym6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777E5C433C7;
	Tue, 27 Feb 2024 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024136;
	bh=X17/VvrTRdEyRy6j9qMljKzrkFMhkPyOmOxYnul1HAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XE6c1ym6GjruqsPIoiNNdkXUe04Lfq4N1pz0CUFc49mSXllOpdzWd/uFL6Y1Lhy6C
	 mhzH62TYssc7W3IGaqdE83hOTuMFy2/WqsiiX5YQCMeWPOEKntj7lXd1a2dG4CXl6k
	 nKIFi1ED3FqNE8CP965PiyIeU+M+PTGrLWsQr8m0=
Date: Tue, 27 Feb 2024 09:55:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org, nphamcs@gmail.com, stable@vger.kernel.org,
	zhouchengming@bytedance.com
Subject: Re: FAILED: patch "[PATCH] mm: zswap: fix missing folio cleanup in
 writeback race path" failed to apply to 6.7-stable tree
Message-ID: <2024022709-autism-nanometer-2a41@gregkh>
References: <2024022610-amino-basically-add3@gregkh>
 <Zd0Ova7x3114k9_Z@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd0Ova7x3114k9_Z@google.com>

On Mon, Feb 26, 2024 at 10:20:45PM +0000, Yosry Ahmed wrote:
> On Mon, Feb 26, 2024 at 11:30:10AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.7-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x e3b63e966cac0bf78aaa1efede1827a252815a1d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022610-amino-basically-add3@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..
> 
> First time sending backports to stable. I think I slightly butchered the
> 6.1 and 6.6 patches. The first one has an extra `Change-Id` footer and
> no additional `Signed-off-by` (although my original one exists), while
> the latter has no 6.6.y prefix. I think I got 6.7 right tho :)
> 
> Greg, please let me know if I need to resend the backports for 6.1
> and/or 6.6, and sorry for any inconvenience.

Yes, please do, I have no idea what branches any of these are for :(

Please give me a hint somehow...

thanks,

greg k-h

