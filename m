Return-Path: <stable+bounces-159248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B267AAF5B11
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AF44E6CB5
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7582F5315;
	Wed,  2 Jul 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izZ5eMFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEA139D
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466326; cv=none; b=MraO8HfSuhX3IYT97gfnTerq4WPVYzf8vKmFneDu4WE5TMrFOv2GN3HVzvyASevHsDfxpGzNDqRNEOSSU2XLWKQ5WoIKCQL0P5AfNwSVH/nutOx0ZOlecOboAGsvVw7tZmI7SXp6u4R+/ho8Dt/ZpGSt1H+gdVMmkMdZuadwpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466326; c=relaxed/simple;
	bh=cQaiJ03Z/OWONMG4n84ptbzKHS42B4Kz1C4qz91uXGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOrjrbdSqWnzNx6dFhCkTM3MY12I/SoAOVkv50RnjY2RjesNjDRrO/rJeVlUSxO5PZcOKRrVZpZPHIYykCZWRftEGeUnmpvZMDS5bLOSFZgflbUPLlhn0jVD42IyT7yCN9d2onSwVNeDx8buPknHeRkspwWM4fzl/DAayfA9S7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izZ5eMFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86119C4CEE7;
	Wed,  2 Jul 2025 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751466325;
	bh=cQaiJ03Z/OWONMG4n84ptbzKHS42B4Kz1C4qz91uXGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izZ5eMFKgQl3LSJkac8ndhjv7fG5OZw+q+E9VW5PBT6xOQg7hmNLslScEPU1lRFez
	 lX3VGbQ3DrR9I4LjXNXevEtExOkp0+wzsH28kyToCtUk31ODSHRkzTT1qRn6K1J49i
	 QZEmuUpxbowD3b7XUlP4yTJxqPIbIRYs5F7NFnWM=
Date: Wed, 2 Jul 2025 16:25:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] nvme: always punt polled uring_cmd end_io
 work to task_work" failed to apply to 6.6-stable tree
Message-ID: <2025070213-grain-dingo-3e67@gregkh>
References: <2025062012-skydiver-undergrad-6e0f@gregkh>
 <9f95ec1e-88fe-4760-9ecd-31c01c722516@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f95ec1e-88fe-4760-9ecd-31c01c722516@kernel.dk>

On Fri, Jun 27, 2025 at 10:33:22AM -0600, Jens Axboe wrote:
> On 6/20/25 9:10 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9ce6c9875f3e995be5fd720b65835291f8a609b1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-skydiver-undergrad-6e0f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Here's one for 6.6-stable.

Now queued up, thanks.

greg k-h

