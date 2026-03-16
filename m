Return-Path: <stable+bounces-225544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAc0KxYNuGkWYQEAu9opvQ
	(envelope-from <stable+bounces-225544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:00:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DC29AE9D
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006F1301DAD5
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F39339B94D;
	Mon, 16 Mar 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GEfYk8KH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179D280A5B;
	Mon, 16 Mar 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669618; cv=none; b=kc+H/v2M6iDJgiKzqHqqaSUZnJ87gvEdphN0PIz9G5Zs3VUCX7HhB7vG8OrQ23Pv87eGYg4Hp/tHR1BI2/PPkAVyqdGt9af4PhZlJH47IbOCofABJ3JgmnidVvBUOQ7W4I8lw1bbPzp/mD1XG0rrYSTKpI71VQGV7TLQQK2Aabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669618; c=relaxed/simple;
	bh=x38VKQGhBnKIwfNWbrj99HKBfUSLFjXy3N6yDwz6tOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbMG0CmnD9BeH68xTc9FsW/WIbE23Q+7XQzPZuq0ueMAxETnQduhPalnv8GImLApUPaGQMuwrBRb/QoAh9YOEvmUy3KNyR8a/mxmzfbXwUDg00ehvoGraGdlWOrCKMp53k2u5+qy8DOQqlN4RQGwrKiToiWWQAfFpBbL9J6NhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GEfYk8KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29229C19425;
	Mon, 16 Mar 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773669617;
	bh=x38VKQGhBnKIwfNWbrj99HKBfUSLFjXy3N6yDwz6tOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEfYk8KHJR6lSfdkLrg5PuWbyDkE8tiF70JwF3dSUSJsI0LCoggSxIvZMSxPKCp/T
	 hpD6FmtVCf1XmeQkddomaoHlQuUQcU3JPX7gi5UuzSb879sOHpEtINLYj8RpQG8ZI3
	 BplcKHB92risyVSc/vLyKFVZ8hRpJBtQgprNe1Vw=
Date: Mon, 16 Mar 2026 15:00:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Guo <gary@garyguo.net>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
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
Message-ID: <2026031639-duplicity-playroom-7b3f@gregkh>
References: <20260315144041.25312-1-sashal@kernel.org>
 <DH3FT8ZMGH0T.2NA5M5351UP2L@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH3FT8ZMGH0T.2NA5M5351UP2L@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-225544-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,nvidia.com,gmail.com,ffwll.ch,collabora.com,arm.com,protonmail.com,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F2DC29AE9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 02:48:52PM +0000, Gary Guo wrote:
> On Sun Mar 15, 2026 at 2:40 PM GMT, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     rust: dma: use pointer projection infra for `dma_{read,write}` macro
> >
> > to the 6.19-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      rust-dma-use-pointer-projection-infra-for-dma_-read-.patch
> > and it can be found in the queue-6.19 subdirectory.
> 
> Hi Sasha,
> 
> commit 08da98f18f4f ("rust: ptr: add `KnownSize` trait to support DST size info
> extraction") and commit f41941aab3ac ("rust: ptr: add projection
> infrastructure") are dependencies of this fix.
> 
> It doesn't look like these commits are currently being picked. They're needed
> for building.
> 
> They're part of the same series: https://lore.kernel.org/rust-for-linux/20260302164239.284084-1-gary@kernel.org/

Yeah, this breaks the build on my systems.  I'll go drop this patch for
now, and if you want these in the stable trees, can you provide a
backported series of them?

thanks,

greg k-h

