Return-Path: <stable+bounces-46579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619818D09DD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C130C1F2230A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B5C15F41E;
	Mon, 27 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="NF2zGiD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+KejV9p"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E1D518
	for <stable@vger.kernel.org>; Mon, 27 May 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834503; cv=none; b=sPtMqomyxxRnldIysw1iHz8clKBsJ576w/3iMQZ9lQVI8N7la2T4gH7IfazRCt9e+I5TqUwT6LvgUcmGwvIqcQptOM2ebPDdfYcOFL5V34tvtmowjBxuVJbDbCDZZXowyoRKIVukGqC4O6/HSlv3vnqdQLyMgVjDEZldeHlso1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834503; c=relaxed/simple;
	bh=Ox1nJk45QT3Sn3Xrl+HfAESkAXb3vhHkMLwAX9f5rpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKZ96o8Raj3aZ1BPgAwCiRDie7mmnDjKTLRroUzilAmY8xo5ziRJyFDUP3yR71zg26Yh/1pvW4B41EHePQow70sc7fENJIblv8oNLVZK5GChaP0n39Qoq9h+y11P1wv49AGnlCqWGPYQyT1fGDihStpLeXM4ZaL69DnhsiJcx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=NF2zGiD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+KejV9p; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 622061C000D6;
	Mon, 27 May 2024 14:28:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 May 2024 14:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1716834500;
	 x=1716920900; bh=UILUDka+HtwC6NcmLu88fj5FJMbKC/78RnTBbK9O4Wc=; b=
	NF2zGiD5l3CE/vgEYm2biVKukAH1rFGlxFe03fNJzv0lRa1t2eF9If1/SXJpsk3x
	w2phYHMYfpTwJp2DHdkPefxajs0lE5J081ROeNQhOp7TlN8FLWHyBAkzM9B0ushx
	kj8sKtZlvjVxdhJHjU8eJE8HTml+mHf2K20Nio/RQQZ3dpyHABBHxKv6qDGhFdd8
	Yxt5EaSh9/lpXSzeshTrd+me6/KBH67SRhr05n6fx3GQvG8lBuo0gxhLGlnIlILU
	93t92RtQgYJzAQhiZofnVU2ZeEmRf3xdQz6cl1THQkzR/kOohPChryP+FVvhRUgd
	B98e7DYrbuu1IpYg8wFakg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716834500; x=
	1716920900; bh=UILUDka+HtwC6NcmLu88fj5FJMbKC/78RnTBbK9O4Wc=; b=h
	+KejV9pwVazuQBc4eZmrRhzQrO5ixwexf744h9sHR09ZW2if7SX4CNlTtTolFdST
	ZuUtqh598Gs9ErVNiabJfFcxB4saS1os2evkcPhGB6N+PI/c4NpYjk50DX63bYG6
	+4h0CNqHEDTDA7fupAPXCGsMOElOAozFp/6IcpEE7SPqqgVNfSbaj2ZABGzd5fbQ
	cJw3mHSGW+ndnTUskd79MgdzFJrFLRqytKF2/NmdtiblGoae4R384LcTq3uNYud4
	GZpUhw/qtbQXA/LKWuyME5ZfUhAMQhnGn7j1H564MZuPspefOt+ue9RaqVpgAOGb
	cVW21MABhwZOI4ZYtrwVg==
X-ME-Sender: <xms:w9BUZjLFbe5gMoAJxyHeFIHdoeQT34Nj7FXoOIRvSWaP1JTP-weQpg>
    <xme:w9BUZnL-9ZEDt4X4FmFclB6w8IetnEnOGX8Piguf5xHcrnHLkO7RcXM-zk4EB0_vV
    vGjvQg7OXKT-w>
X-ME-Received: <xmr:w9BUZrsa0Izu1xwHfanoRlwYs4JkruJ_QdNbXDfsbcFXt3KrPRoQIMs6Ax2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:w9BUZsbP5v9v4gQrJ-NhkNSvx7eF5SRz7wSbKGo5uJEgxXAqZiGRew>
    <xmx:w9BUZqYfvs5yee_GP6zH-l98HLzR2EXtX-p5uDZb0G0X4d3eI5JLJA>
    <xmx:w9BUZgA6UXlzHhU_rPc__4HYsjrnasv0DZx-dLV-gn327UvQ8wCCqA>
    <xmx:w9BUZoZDT4whjojiKh-z5hnBtKrQMoWJ2uFWFMw2wE9f1MY9EtDb0w>
    <xmx:xNBUZhV9d6JBjBcbqUOlw1AyVZb6t7R5M1nSdbHLzHrAc-Q0ayve4Jc7>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 14:28:19 -0400 (EDT)
Date: Mon, 27 May 2024 20:28:23 +0200
From: Greg KH <greg@kroah.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Patch "nilfs2: make superblock data array index computation
 sparse friendly" has been added to the 6.9-stable tree
Message-ID: <2024052714-dislocate-evoke-e2de@gregkh>
References: <20240526172110.3470368-1-sashal@kernel.org>
 <CAKFNMo=kyzbvfLrTv8JhuY=e7-fkjtpL3DvcQ1r+RUPPeC4S9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMo=kyzbvfLrTv8JhuY=e7-fkjtpL3DvcQ1r+RUPPeC4S9A@mail.gmail.com>

On Mon, May 27, 2024 at 09:53:45AM +0900, Ryusuke Konishi wrote:
> On Mon, May 27, 2024 at 2:21 AM Sasha Levin wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     nilfs2: make superblock data array index computation sparse friendly
> >
> > to the 6.9-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      nilfs2-make-superblock-data-array-index-computation-.patch
> > and it can be found in the queue-6.9 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> >
> > commit 5017482ff3b29550015cce7f81279dc69aefd6fe
> > Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > Date:   Tue Apr 30 17:00:19 2024 +0900
> >
> >     nilfs2: make superblock data array index computation sparse friendly
> >
> >     [ Upstream commit 91d743a9c8299de1fc1b47428d8bb4c85face00f ]
> >
> >     Upon running sparse, "warning: dubious: x & !y" is output at an array
> >     index calculation within nilfs_load_super_block().
> >
> >     The calculation is not wrong, but to eliminate the sparse warning, replace
> >     it with an equivalent calculation.
> >
> >     Also, add a comment to make it easier to understand what the unintuitive
> >     array index calculation is doing and whether it's correct.
> >
> >     Link: https://lkml.kernel.org/r/20240430080019.4242-3-konishi.ryusuke@gmail.com
> >     Fixes: e339ad31f599 ("nilfs2: introduce secondary super block")
> >     Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >     Cc: Bart Van Assche <bvanassche@acm.org>
> >     Cc: Jens Axboe <axboe@kernel.dk>
> >     Cc: kernel test robot <lkp@intel.com>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
> > index 2ae2c1bbf6d17..adbc6e87471ab 100644
> > --- a/fs/nilfs2/the_nilfs.c
> > +++ b/fs/nilfs2/the_nilfs.c
> > @@ -592,7 +592,7 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
> >         struct nilfs_super_block **sbp = nilfs->ns_sbp;
> >         struct buffer_head **sbh = nilfs->ns_sbh;
> >         u64 sb2off, devsize = bdev_nr_bytes(nilfs->ns_bdev);
> > -       int valid[2], swp = 0;
> > +       int valid[2], swp = 0, older;
> >
> >         if (devsize < NILFS_SEG_MIN_BLOCKS * NILFS_MIN_BLOCK_SIZE + 4096) {
> >                 nilfs_err(sb, "device size too small");
> > @@ -648,9 +648,25 @@ static int nilfs_load_super_block(struct the_nilfs *nilfs,
> >         if (swp)
> >                 nilfs_swap_super_block(nilfs);
> >
> > +       /*
> > +        * Calculate the array index of the older superblock data.
> > +        * If one has been dropped, set index 0 pointing to the remaining one,
> > +        * otherwise set index 1 pointing to the old one (including if both
> > +        * are the same).
> > +        *
> > +        *  Divided case             valid[0]  valid[1]  swp  ->  older
> > +        *  -------------------------------------------------------------
> > +        *  Both SBs are invalid        0         0       N/A (Error)
> > +        *  SB1 is invalid              0         1       1         0
> > +        *  SB2 is invalid              1         0       0         0
> > +        *  SB2 is newer                1         1       1         0
> > +        *  SB2 is older or the same    1         1       0         1
> > +        */
> > +       older = valid[1] ^ swp;
> > +
> >         nilfs->ns_sbwcount = 0;
> >         nilfs->ns_sbwtime = le64_to_cpu(sbp[0]->s_wtime);
> > -       nilfs->ns_prot_seq = le64_to_cpu(sbp[valid[1] & !swp]->s_last_seq);
> > +       nilfs->ns_prot_seq = le64_to_cpu(sbp[older]->s_last_seq);
> >         *sbpp = sbp[0];
> >         return 0;
> >  }
> 
> This commit fixes the sparse warning output by build "make C=1" with
> the sparse check, but does not fix any operational bugs.
> 
> Therefore, if fixing a harmless sparse warning does not meet the
> requirements for backporting to stable trees (I assume it does),
> please drop it as it is a false positive pickup.  Sorry if the
> "Fixes:" tag is confusing.
> 
> The same goes for the same patch queued to other stable-trees.

Now dropped, thanks!

greg k-h

