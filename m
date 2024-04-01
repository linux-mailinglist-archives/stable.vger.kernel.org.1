Return-Path: <stable+bounces-33949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A514893C5D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8474B1C212FE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0574344391;
	Mon,  1 Apr 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnn/Pdzl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC41E524
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983154; cv=none; b=W+rGiNLp9Oqg3Mrt87vFXqcKlSvUTJAiM1g3NNmswU3HLqbXeDXdTYvEHDoUwoUMBU9EcLSE3Uw0JdIUZcSWEQ61IohSHuKigN6Tz+rcf15SCQOVGcyVH5QmpnVFTpVDQ/pq92PBgPVID+jKdUcpmXM1iQAQXCwsM/0XaddJelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983154; c=relaxed/simple;
	bh=Wz0trSLkKvxQa4fGUTLQqN02pTZQ2+LXy0UdReRTcHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC5leZVlucB/9bU8Z1qQpBViBw2KrsqYv/HtnE5/c0TnZJMLrgjWuVITjPnPMlQuawXY/+0YT2C+Y6rWrzOCG27sdNLjIKg/3fhw1yTmtsc/Hq5pOfT671JS7kMe5XYSdmuhQ9j9YJCLfOZnqQ2DXysM1gWu0dPAPg4nmnbkWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnn/Pdzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897CC433C7;
	Mon,  1 Apr 2024 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711983154;
	bh=Wz0trSLkKvxQa4fGUTLQqN02pTZQ2+LXy0UdReRTcHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wnn/Pdzlr2c1dtW2X5x2zPYuUocGqiGBYNVwX84nB6o/lSGlQClOC+HN0FIpMmhou
	 pCHqyejrqlkYEEzWttoRZLyN9qXBOZGVHrLa/Uhfs0nr+4LmsjPIhfZKZGcwjZBz1l
	 eNkbw7dFL+Pgha7EMXNb1lK370xOF7AAg2D9TBvg=
Date: Mon, 1 Apr 2024 16:52:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: stable@vger.kernel.org, samsun1006219@gmail.com, xrivendell7@gmail.com
Subject: Re: FAILED: patch "[PATCH] USB: core: Fix deadlock in
 usb_deauthorize_interface()" failed to apply to 4.19-stable tree
Message-ID: <2024040119-uncommon-premises-62a4@gregkh>
References: <2024040157-entrench-clicker-d3df@gregkh>
 <40fa743b-97cc-4172-96eb-1d55a54784aa@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fa743b-97cc-4172-96eb-1d55a54784aa@rowland.harvard.edu>

On Mon, Apr 01, 2024 at 09:59:14AM -0400, Alan Stern wrote:
> On Mon, Apr 01, 2024 at 11:42:57AM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 4.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 80ba43e9f799cbdd83842fc27db667289b3150f5
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040157-entrench-clicker-d3df@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 80ba43e9f799 ("USB: core: Fix deadlock in usb_deauthorize_interface()")
> > 
> > thanks,
> > 
> > greg k-h
> 
> Here is the back-ported version of the patch.  It was necessary to change
> kstrtobool to strtobool.
> 
> This should apply to the -stable kernels from 4.19 up to 6.1.

Thanks, now queued up!

greg k-h

