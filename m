Return-Path: <stable+bounces-70358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87A960B8F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372BA28695A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871D1BCA17;
	Tue, 27 Aug 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SLehL7/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810A45028
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764456; cv=none; b=VeaujQkf92azpLKrWtbxgIv8mZK1YkwtlcT4MWNiaOh87UFFP646e3N2hmh7osf/Vh/MJDEMVE9Wt7H/g5GVvDo8L2dQ5/fpE/IQAZrD4GHxd2viYGiTshtois1FZmCFNO3QjIx57fMuMo1Ga+AfFTe8LNtCRekyzsMfytzVnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764456; c=relaxed/simple;
	bh=VCFZWFFqHFuYiIYsNIyn3G9HuQm1/LcyO/cKhlI6Ah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMbEGH2mLk5ghH363F1WfaRicXftJ9V3ORRPNAIh66AhUBSje+QmGY8WUrrHbZm6+yResSMqHB1+okxpOaxAGfOr1xkQh2l9Lo8xZmgXJtlrXFJWh6xJ4+FEX2sdbz6GvYw/rmDoX00dfgO5yLDT8p250IqoMT8QppDQy10Sd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SLehL7/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452A7C61040;
	Tue, 27 Aug 2024 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764455;
	bh=VCFZWFFqHFuYiIYsNIyn3G9HuQm1/LcyO/cKhlI6Ah4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLehL7/MRmYutamTJY0ZxApQffHwWkr57ogyyjXXBS3CdMAz7beZkyobv9H7ofsC8
	 smeizc0h7ZZlsLM5sr05WPzKTJ7oV3MJI8oTisuuH1Ysjc/YAAjv5k0oXmCHcVqORh
	 xspnPHZbvgpW599nmkrH/zWeVhJB1ELVM2mv4FAQ=
Date: Tue, 27 Aug 2024 15:14:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>
Cc: stable@vger.kernel.org, sth@linux.ibm.com
Subject: Re: [PATCH] Revert "s390/dasd: Establish DMA alignment"
Message-ID: <2024082702-scoff-panning-4a8a@gregkh>
References: <2024082014-riverbed-glutton-ae33@gregkh>
 <20240820141307.2869182-1-hoeppner@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820141307.2869182-1-hoeppner@linux.ibm.com>

On Tue, Aug 20, 2024 at 04:13:07PM +0200, Jan Höppner wrote:
> This reverts commit bc792884b76f ("s390/dasd: Establish DMA alignment").
> 
> Quoting the original commit:
>     linux-next commit bf8d08532bc1 ("iomap: add support for dma aligned
>     direct-io") changes the alignment requirement to come from the block
>     device rather than the block size, and the default alignment
>     requirement is 512-byte boundaries. Since DASD I/O has page
>     alignments for IDAW/TIDAW requests, let's override this value to
>     restore the expected behavior.
> 
> I mentioned TIDAW, but that was wrong. TIDAWs have no distinct alignment
> requirement (per p. 15-70 of POPS SA22-7832-13):
> 
>    Unless otherwise specified, TIDAWs may designate
>    a block of main storage on any boundary and length
>    up to 4K bytes, provided the specified block does not
>    cross a 4 K-byte boundary.
> 
> IDAWs do, but the original commit neglected that while ECKD DASD are
> typically formatted in 4096-byte blocks, they don't HAVE to be. Formatting
> an ECKD volume with smaller blocks is permitted (dasdfmt -b xxx), and the
> problematic commit enforces alignment properties to such a device that
> will result in errors, such as:
> 
>    [test@host ~]# lsdasd -l a367 | grep blksz
>      blksz:				512
>    [test@host ~]# mkfs.xfs -f /dev/disk/by-path/ccw-0.0.a367-part1
>    meta-data=/dev/dasdc1            isize=512    agcount=4, agsize=230075 blks
>             =                       sectsz=512   attr=2, projid32bit=1
>             =                       crc=1        finobt=1, sparse=1, rmapbt=1
>             =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
>    data     =                       bsize=4096   blocks=920299, imaxpct=25
>             =                       sunit=0      swidth=0 blks
>    naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>    log      =internal log           bsize=4096   blocks=16384, version=2
>             =                       sectsz=512   sunit=0 blks, lazy-count=1
>    realtime =none                   extsz=4096   blocks=0, rtextents=0
>    error reading existing superblock: Invalid argument
>    mkfs.xfs: pwrite failed: Invalid argument
>    libxfs_bwrite: write failed on (unknown) bno 0x70565c/0x100, err=22
>    mkfs.xfs: Releasing dirty buffer to free list!
>    found dirty buffer (bulk) on free list!
>    mkfs.xfs: pwrite failed: Invalid argument
>    ...snipped...
> 
> The original commit omitted the FBA discipline for just this reason,
> but the formatted block size of the other disciplines was overlooked.
> The solution to all of this is to revert to the original behavior,
> such that the block size can be respected.
> 
> But what of the original problem? That was manifested with a direct-io
> QEMU guest, where QEMU itself was changed a month or two later with
> commit 25474d90aa ("block: use the request length for iov alignment")
> such that the blamed kernel commit is unnecessary.
> 
> Note: This is an adapted version of the original upstream commit
> 2a07bb64d801 ("s390/dasd: Remove DMA alignment").
> 
> Cc: stable@vger.kernel.org # 6.0+
> Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_diag.c | 1 -
>  drivers/s390/block/dasd_eckd.c | 1 -
>  2 files changed, 2 deletions(-)
> 

Now queued up, thanks.

greg k-h

