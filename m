Return-Path: <stable+bounces-225614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDe2AQMwuGmvaAEAu9opvQ
	(envelope-from <stable+bounces-225614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:29:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D229D681
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B723033F98
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E99336EE1;
	Mon, 16 Mar 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYt29tYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239042C375A;
	Mon, 16 Mar 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678429; cv=none; b=kVlLZ636r76ZF1frnmLTrcc1Tt1Bn8lmnBPp1kZRPT2Ad4SGZikVRlBFe4mwTgXwhBqit0OCr+Yep8iGr4FZfwWeM5Ust3F5uxaUxwQyXwLcYgVn7/gWCliaJeX7frtV51ANlxlyF3e36Hjcs4xFMf6vdVAmW+gSio3PVypaz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678429; c=relaxed/simple;
	bh=D7ir28HxqgZVVuv+H8f05mPzZEmFxVTr4ETWI9qZkCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNKc+uZCY43YOibfNc4Ft2fUP2bGw1hArfrEG45UxlZiWkKFEbYlNo6/cDf1GzrIXe7gpQz/NZdZ83W51pkERpF1LxPp4lOCBx0FNku7bfi6+q8P8mbjDM+Ako6KO9D2ysPMxKJT8BUPlvD+aNuJFQA5TA4s6IAdmrPnaM2bKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYt29tYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54079C19421;
	Mon, 16 Mar 2026 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773678428;
	bh=D7ir28HxqgZVVuv+H8f05mPzZEmFxVTr4ETWI9qZkCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYt29tYu/MsLg1zpQeTCxW6Eg5SiX5wo/cc779MKKAJ0JDJ6sGKZFurU1URN9rJSH
	 AjkTdx+qHKHL0ljEtwy26IykDujFpm56WZ/APfJLBKrJ/NkYfo8JdB9tJms6ckQ/xJ
	 mi32xaVIMqTmw1qdlX+JeGfG5rTaVracbCCNBYIs=
Date: Mon, 16 Mar 2026 17:27:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>
Subject: Re: Patch "rust: dma: use pointer projection infra for
 `dma_{read,write}` macro" has been added to the 6.19-stable tree
Message-ID: <2026031640-grueling-java-61f9@gregkh>
References: <20260315144041.25312-1-sashal@kernel.org>
 <DH3FT8ZMGH0T.2NA5M5351UP2L@garyguo.net>
 <2026031639-duplicity-playroom-7b3f@gregkh>
 <DH4CD4IAYRS1.1P5BTFC6U3LBP@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH4CD4IAYRS1.1P5BTFC6U3LBP@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225614-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[garyguo.net,vger.kernel.org,google.com,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,kernel.org,protonmail.com,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8B3D229D681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:19:25PM +0100, Danilo Krummrich wrote:
> On Mon Mar 16, 2026 at 3:00 PM CET, Greg KH wrote:
> > On Sun, Mar 15, 2026 at 02:48:52PM +0000, Gary Guo wrote:
> >> On Sun Mar 15, 2026 at 2:40 PM GMT, Sasha Levin wrote:
> >> > This is a note to let you know that I've just added the patch titled
> >> >
> >> >     rust: dma: use pointer projection infra for `dma_{read,write}` macro
> >> >
> >> > to the 6.19-stable tree which can be found at:
> >> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >> >
> >> > The filename of the patch is:
> >> >      rust-dma-use-pointer-projection-infra-for-dma_-read-.patch
> >> > and it can be found in the queue-6.19 subdirectory.
> >> 
> >> Hi Sasha,
> >> 
> >> commit 08da98f18f4f ("rust: ptr: add `KnownSize` trait to support DST size info
> >> extraction") and commit f41941aab3ac ("rust: ptr: add projection
> >> infrastructure") are dependencies of this fix.
> >> 
> >> It doesn't look like these commits are currently being picked. They're needed
> >> for building.
> >> 
> >> They're part of the same series: https://lore.kernel.org/rust-for-linux/20260302164239.284084-1-gary@kernel.org/
> >
> > Yeah, this breaks the build on my systems.  I'll go drop this patch for
> > now, and if you want these in the stable trees, can you provide a
> > backported series of them?
> 
> The DMA soundness fix, as a potential bug, is probably not crucial to backport.
> 
> There are two nova-core fixes on top of it. One of them fixes a UB condition
> reading from and writing to a DMA buffer, the other one is a potential stack
> overflow.
> 
> nova-core is still work in progress, so I'm not too worried about this as far as
> stable trees are concerned.
> 
> I think we usually backport soundness fixes anyway, plus everything should apply
> without conflicts, so it probably doesn't hurt to pick them up regardless.
> 
> I can send a separate series if preferred.

I've dropped all the nova-core patches from the queue as well.  If you
think they are needed in 6.19.y, please send backports.

thanks,

greg k-h

