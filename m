Return-Path: <stable+bounces-139695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC6AAA94E4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A833C189B8A5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E504258CE8;
	Mon,  5 May 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIrzXPAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D159258CF6
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453162; cv=none; b=gOhHZj+xrMqLE17jO5O8h/Pmmq7B8YE8q6cU1vEDjfhwVsqBjrZCknjYs8qPzJc5Q6TUpIJbHvj+XrRlFewi4Bkz9F9eljLCGzi1RIlxrvvjTH7aFYc7OKF0kf5hSDjuL7Q6K5443fymm98wp1/bDrWrEXpspMB4y9lLxYS6BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453162; c=relaxed/simple;
	bh=+XnJru/fgLTrWSfB+5GusDvzW4aIQsemEbLWCDHXTyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpxzVFdCicnSKZdORTJ9fUGCzENvYtotzGdb9XykXdCbvPNg3UefPDsKFmOYDQeFWTHymJ/7aqXrjsp5jgzVW87E6R7PkqHCqUVSk0+psyfLGp9UifWrQqoP3o9/Cg0dnoUijV+dAOwo7k2bfrVlXeCbaZkHpIlhNxRA0gFD0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIrzXPAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDCBC4CEE4;
	Mon,  5 May 2025 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746453161;
	bh=+XnJru/fgLTrWSfB+5GusDvzW4aIQsemEbLWCDHXTyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIrzXPAe/LOuQvatxhCWawq1e0a6xUXLZtrsVfyUdwauaLeJi8nqvtDRk6NOPNa9P
	 vLSvhxz4pU0IQlid2lYgrLLfnNdd/YEPQNTigl+603j4asvR+vWLi+vdi7zFVhHSbu
	 vRWYfNg4RofxVlAhTSsjpuxzp6Gxf5aLAPoiv8sU=
Date: Mon, 5 May 2025 15:52:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jack Wang <jinpu.wang@ionos.com>, Wang Yugui <wangyugui@e16-tech.com>,
	stable@vger.kernel.org, wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <2025050555-overhung-jiffy-6b63@gregkh>
References: <2025050500-unchain-tricking-a90e@gregkh>
 <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
 <2025050554-reply-surging-929d@gregkh>
 <6f78e096-cb32-4056-a65a-50c27825d0e1@flourine.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f78e096-cb32-4056-a65a-50c27825d0e1@flourine.local>

On Mon, May 05, 2025 at 03:40:51PM +0200, Daniel Wagner wrote:
> On Mon, May 05, 2025 at 03:28:22PM +0200, Greg KH wrote:
> > On Mon, May 05, 2025 at 01:36:52PM +0200, Jack Wang wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > In linux-6.12.y, commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")
> > > was pulled in as depandency, the fix a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> > > should have just used 1452e9b470c9 ("blk-mq: introduce blk_mq_map_hw_queues")
> > > as Fixes, not the other conversion IMO.
> > 
> > What "other conversion"?  Sorry, I do not understand, did we take a
> > patch we shouldn't have, or did we miss a patch we should have applied?
> 
> If I understand the situation correctly, the problem is that v6.14.25
> ships commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with
> blk_mq_map_hw_queues") which introduced a regression for certain virtio
> configurations. The fixup patch is:
> 
> a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> 

But commit a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
says it fixes commit a5665c3d150c ("virtio: blk/scsi: replace
blk_mq_virtio_map_queues with blk_mq_map_hw_queues"), which is ONLY in
the 6.14 tree.

Which is why we didn't pull it into the stable tree here.  Is that
commit just not marked properly?  Will it cause problems if it is
backported?

thanks,

greg k-h

