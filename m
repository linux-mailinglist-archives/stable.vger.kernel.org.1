Return-Path: <stable+bounces-88272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596929B24B2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3A1F21552
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C318CBF1;
	Mon, 28 Oct 2024 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bwTKL/Uz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4QawYVM"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393617C220;
	Mon, 28 Oct 2024 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094815; cv=none; b=JODkyygOrzV0lCAgWlXejYKTtKnS++gcEiUHjjisChZpEgktvsdtlfqmIdikKJu9OtzV3ZDf/z0yro9CxiRS3nW4Ct7kHtt6FM4JJ1bkeezBYYFvWcy0BkLFC9bs+3j5uqfx69a7iKwlQb5d8oiMJJPAcU3szfcbnDBHfssps5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094815; c=relaxed/simple;
	bh=XD95aT/HEa8/oIBTDsHhoqhW4wYiGefiT1b4IOVZRgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeR+6TLca3In0DZoCs2nenUqoe34Y6Oj4pTeybqjpK80oOMUR9N/d4QiCcoRodM0kioPb3sCg2y7kreEMxHiysqc73/mqL5vaPa4ijglvAxNJSC17oETk7EyI/fYz3TAVwDma2/wKIu4HIJMZSbqv3NIUXXTN79HEI7l+9ECNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=bwTKL/Uz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4QawYVM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BFBB41380190;
	Mon, 28 Oct 2024 01:53:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Oct 2024 01:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730094811; x=1730181211; bh=wJXBqFFjUE
	otInM6pA8j00ZxIPLSXZBy6Be328bDoU4=; b=bwTKL/UzGqH9yY08ZBxQ+gvKcB
	3B65LDwGx4mfcYvuIqrO3S76iOb5u01giwk6AvkfNtbvrl5L6XwJd0lSmggKT2st
	7pPq3h47cE4fRNFeZGR5EiyYyn5isuTMfXtTD3kQFQ2HPs6MfvRmK7QXVM5iNX5y
	BFVt1Phkb+kkou0FefS37nDc5fiNf0+Yf6K2I5r0ji1v5ZLsHwficudpbQUasg5Z
	IlX/iGGdQBDsXAl4g+248gDJGhJYF7wyWQUtyXwvdWyP65+nlZoPrEzmVn/AZ7MJ
	vaKYgXli7/plVtuuRHERsPNXjlupUEeIEZimYnlFWLJSLeVuOHeMtQPKFujA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730094811; x=1730181211; bh=wJXBqFFjUEotInM6pA8j00ZxIPLS
	XZBy6Be328bDoU4=; b=F4QawYVME+DZp/CARSotCzALlLHQmUy84vucvUIihy8O
	pd/t/v68WRg5vkVo71EMnVWxsUqvvNOjJ2GmnEz1cM4Qf+Pj8j8b0K0FvaOD4Dvx
	q4ZsuWEXtM7JBTO/KSm49zN/JT5hnFHrKMIepE2VAScIGSLB6GOmXVnj/MCxEGBR
	2B1szlXeiDAXTkjgIWLMJjmhyU4NGRLJei3p6y5WWuDGEY1uN8svkzMxPgOIIZZD
	MeG7tPyptJy0fOjca2Bgl/0IG/dwE/vqV8Wjc7j4LqZw7NVgq5xZeTz1AP7mlGLq
	yyIFeL6js3h5/zS4mNdsPoQzWWsy5af0yiGQPyWHrQ==
X-ME-Sender: <xms:2yYfZxANWbK2OKbQVHkh00g2PrsixqT06vd3KXKF_bcrfFeMCPCz7Q>
    <xme:2yYfZ_gLXSSFp876v0LyG2SEpcD0HwB7_QnLpq-ojCZ0YkJVmsEIoSZIAo8On5lui
    egQcuV9szdZVw>
X-ME-Received: <xmr:2yYfZ8lAXySREvWtB85XJWNfqplv5MKF0J-k0vVRa-yAGYiLqceMjNvZspMEtccefZzxr7Jrk7YcX8mAoSYKqwP1Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrthhhuhhmshhhihhrnhesfigutgdrtghomhdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgdqtg
    homhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtlhhmsehf
    sgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprh
    gtphhtthhopegushhtvghrsggrsehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:2yYfZ7yX8lw5hK-msDyxCOyVeghwEutGFn5TNCOAcgizz4gjlyhDkg>
    <xmx:2yYfZ2RHMa1Zy44VkOLTQ0veBPcrq8KBlNQ9enT1-ECyFwekj9foFw>
    <xmx:2yYfZ-bZNQ1EAWWKKjo_qQfhUfGgFhdg_3NSBtCA2S61njMFq_P8CA>
    <xmx:2yYfZ3T8V8iJWEKXcKrOfghayuGeL3t5pIX8y4wc1fpHSjMY-f8Wig>
    <xmx:2yYfZ9IBjBmR_6wSuICGx55uIzubD4Vi32Wa2NYNXflm65VPK0N69dYL>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 01:53:30 -0400 (EDT)
Date: Mon, 28 Oct 2024 06:53:15 +0100
From: Greg KH <greg@kroah.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: also add stripe entries for NOCOW writes" has been
 added to the 6.11-stable tree
Message-ID: <2024102809-improving-footwear-bd85@gregkh>
References: <20241024111713.3025523-1-sashal@kernel.org>
 <3e66a465-6502-48d7-b031-1619052a1e66@wdc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e66a465-6502-48d7-b031-1619052a1e66@wdc.com>

On Thu, Oct 24, 2024 at 11:22:16AM +0000, Johannes Thumshirn wrote:
> On 24.10.24 13:17, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      btrfs: also add stripe entries for NOCOW writes
> > 
> > to the 6.11-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       btrfs-also-add-stripe-entries-for-nocow-writes.patch
> > and it can be found in the queue-6.11 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> 
> Hey Sasha,
> 
> this patch is for the RAID stripe-tree feature marked as experimental, 
> so I don't think it's needed to be backported, as noone should use it 
> (apart from testing).

Now dropped, thanks.

greg k-h

