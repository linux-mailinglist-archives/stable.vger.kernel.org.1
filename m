Return-Path: <stable+bounces-139701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4FAA9591
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDF3A5FA2
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9801F4184;
	Mon,  5 May 2025 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z41/N4EF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35C77111
	for <stable@vger.kernel.org>; Mon,  5 May 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454881; cv=none; b=a68TApIw//HzpLyHPnsFYHO5PNfe/Nn9l1Bm/hpl1dYcFm6MYJPkko/IbmYFSBhHnc6RJQs0bX0rSjwT3144TXW1BcrAPJZdmfV8C9KbDO2mheHFpl2XGeoJRk38iaPUIlR8dav0P8SWITiPByQBIVY6R5Qaj1ov08/zBi1VVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454881; c=relaxed/simple;
	bh=ukXEdZw9YlAH6F3MSohRVnDzG8TfTO5KUjs/S2Zu0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXkGl4phG97DtzbgKuF9zrCySllpZtJhYeQqfSIrM/fIuh3qEsBYLX8CWUfSBF1uSu01WH4f3rODB6YJD6XejSi4cRb/AiHujy7sJFK6XmqvF5+gsjEmUHFT6Ss0u2NzRvYdUiT2YPlXqiFOFGRS2LYjbG3EroUpcgUA3p4LgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z41/N4EF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483CCC4CEE4;
	Mon,  5 May 2025 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746454880;
	bh=ukXEdZw9YlAH6F3MSohRVnDzG8TfTO5KUjs/S2Zu0S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z41/N4EFoFeH6uujMlx/wc0mIQ1F8wGn0YCaQkVMJPWSd4GaIQ/KRtgC/dPMsG1Pw
	 5KQHEQWUgLoLtm2EUySD2Hmq5AyzgpBElydcGxpLUdgnZsuO97TyIy0+h/dzn1uzp4
	 GCkOgh7ttQGWTcXwrE4o1oMVrSIlYYV2eqEN1Y30=
Date: Mon, 5 May 2025 16:21:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jack Wang <jinpu.wang@ionos.com>, Wang Yugui <wangyugui@e16-tech.com>,
	stable@vger.kernel.org, wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <2025050507-devourer-semifinal-4967@gregkh>
References: <2025050500-unchain-tricking-a90e@gregkh>
 <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
 <2025050554-reply-surging-929d@gregkh>
 <6f78e096-cb32-4056-a65a-50c27825d0e1@flourine.local>
 <2025050555-overhung-jiffy-6b63@gregkh>
 <98959a8c-67d7-49f0-bb65-80169b32b70c@flourine.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98959a8c-67d7-49f0-bb65-80169b32b70c@flourine.local>

On Mon, May 05, 2025 at 04:05:58PM +0200, Daniel Wagner wrote:
> On Mon, May 05, 2025 at 03:52:38PM +0200, Greg KH wrote:
> > But commit a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> > says it fixes commit a5665c3d150c ("virtio: blk/scsi: replace
> > blk_mq_virtio_map_queues with blk_mq_map_hw_queues"), which is ONLY in
> > the 6.14 tree.
> > 
> > Which is why we didn't pull it into the stable tree here.  Is that
> > commit just not marked properly?  Will it cause problems if it is
> > backported?
> 
> The stack trace for this report is from a system which has a
> megaraid_sas HBA. I did some testing with this HBA but somehow I
> didn't run into the problem. Thus the Fixes is just not complete, it
> misses
> 
> Fixes: bd326a5ad639 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")
> 
> Sorry about that.

No problem, thanks for letting me know, now queued up.

greg k-h

