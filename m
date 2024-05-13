Return-Path: <stable+bounces-43607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8498C3D6C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E52C1C21465
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09449147C84;
	Mon, 13 May 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlQp728V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A6146A88;
	Mon, 13 May 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589589; cv=none; b=JgUaPwC1Xp1DIkVazCf3OTpq0ewqmDqzfmCchgWATKCuj6ukA8JSVRmuQ9gf3/xTvbRFGmIFZjE8mc1kCbtm9ea/dcrrIv/TbhyEobSp9Xa+iVo3Ei8N1nTsKi3HU10j4ZC9hea5tH2aSmiqpRRYSAXbVUaYievDBiNCBWtAMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589589; c=relaxed/simple;
	bh=5ag6RZqSwg5OtXaCZ6GbKdBP1Mvi3n7cJyPCPZfT01w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLostTnf5roW/4syHbV0eBKlEH09PlEh+DoWn5K5Id2kZTd8czgVbuT/hdpEvjz9QxllxEqtnv+DsWO6Gw4eFitHb+Trh4vGyk6FGCB6i88vWQvikISExmHBhl3kIA3OnAb6jtVXvE1eCnAYpdiQT5KzH/ivoxCO5dfWH90j0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlQp728V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DDCC113CC;
	Mon, 13 May 2024 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715589589;
	bh=5ag6RZqSwg5OtXaCZ6GbKdBP1Mvi3n7cJyPCPZfT01w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlQp728VesZOcv+umUchWNrc1Z3D8b4XA4vXUXJM630rfmDMRkV1WUi/hoB9VotTh
	 lW8llfr2Mw2aQD4Ty4r0TkMS/Zp295Cmay6CeX8gljM/KYfsNt9sd1i0gSvtEzuxQi
	 MbJcgZFa3S+DKAb44vCEn0RWiXQWihfY5LIsNrNk=
Date: Mon, 13 May 2024 10:39:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, abhishekpandit@chromium.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: Patch "usb: typec: ucsi: Limit read size on v1.2" has been added
 to the 6.1-stable tree
Message-ID: <2024051331-cannon-seismic-c4d2@gregkh>
References: <20240509173633.559123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509173633.559123-1-sashal@kernel.org>

On Thu, May 09, 2024 at 01:36:33PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     usb: typec: ucsi: Limit read size on v1.2
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      usb-typec-ucsi-limit-read-size-on-v1.2.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This breaks the build on 6.1 kernels, so I'm dropping it for now.

thanks,

greg k-h

