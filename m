Return-Path: <stable+bounces-88123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6F9AF876
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD7FB210F5
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D64918BC1D;
	Fri, 25 Oct 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nad+USn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mtmn86KY"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7C18BBA1;
	Fri, 25 Oct 2024 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828181; cv=none; b=fzSy4g7nBcD/WWA5ApG8QuoY2KArat/gt5SQA4ZkiNOHYnoUjZ6Utl+S/BAHmyZ3v7/XtqEHtMcZxbb/FRDcP+x1/mDCyjG1JnQZipA7n2hLGYre8VWPXvh6GD0h3Zuq4LJzJ724Aa6iOSXSCK+B15SFbJkHSbrNu99bo8JdmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828181; c=relaxed/simple;
	bh=biyN6BFINDLG9M70e01SzJIMheNqG2jq1GnZO+ddetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phyxc+xCTSrsxkU8fIxN5nSFqfHH2NwTxDnM0MW+okM+YhRzgfttxYZ3OCexIoQTUz2FClzp0xzmYMcTc7PFThV7hPKGVvS8rqXJT194qgNkXuQ92Fl8yTZG/77yUWSSJ6cty1M27JuyIP79wf6Al4PCKIZ+BCy7uMLjWheFqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nad+USn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mtmn86KY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37C1E114017A;
	Thu, 24 Oct 2024 23:49:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 23:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1729828178; x=
	1729914578; bh=WgS6yhK7Z1D4ST/hhcqeRn9rI9T894JvSD6lnkO9Iy4=; b=n
	ad+USn6oL36B3vvBbXK3HNJ3K1+oFehHGDpVnpnN9Bup8hAnBvflA2x92/MMkhnZ
	DhVu+dZUlvr/Scuol7rLXmHqaqHphQ3ZdOfmE3l0OjUW5oLEW/OGj23IkXcrebn9
	UlrwluUhpGRilpEIOkOgWXzqNOCIK+adbZ8u8IN584B6LB9UmyhgpFb9CXwI74xZ
	rXh9/nuYAibemxgHlAz5hfIvuj1j4TP7JXPVxcRRWBwfxcoaBRpe2VUeodKx6ucM
	BGA5SzgxepDMscFVDIE7oAcQFKejHd+6RnF8yKVq0cbKae2FQuobSdenHHBBUk72
	J1R2ZZxnRJof1n1Zwys1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729828178; x=1729914578; bh=WgS6yhK7Z1D4ST/hhcqeRn9rI9T8
	94JvSD6lnkO9Iy4=; b=mtmn86KYzMkBgKjm/XzfBAMvaaIfK62AG2JqMOcFlBjc
	avCcLDIzgvpfscevO1wQYkxmpdqQ/cJ3nd3aCAiTqD80tKoHyC878AJWCrwAOu2U
	1AeBpB6wV+1vSWLNFJNvLc6qwmJ/LPliwQ+lo/Bj+ac1WBFZDzVTaDsEUd/+U1nu
	H67vF9cHEkFMfwrbjfD4PgQ/TreuMWNompbXIBQzN+A0UJRvD7JLwxyCh6MFHYI2
	+1bR3LUki1qgkBxyGZBqMHLAjH61Ghf0/FJHBLxok7rJ8A0OE2BbUwPMQz3B4uu5
	Ib0iAyJTtEy5FE2lu0qPKGmoWJ5Jvrq6qTFzXoKydQ==
X-ME-Sender: <xms:URUbZ3XU3sljmavQL1E0brgNdxFN4ViJevjVqZt7palS7FqrUOM0Hg>
    <xme:URUbZ_mvk8CUT6ppK0gAS3ULEhMPJ8-RFvpigA-qfIfyTpeyFzS64xiSJTwcSIUaO
    8u8fkYUG6EgbIKOaCM>
X-ME-Received: <xmr:URUbZzb7580JRctQCXlPNiwyT-ALm82TojAMT0bOloW0ubo8_xg54MSbrymF2rDpnHDRsGSMO-QNhHaeWbRRxkOkHNnEU6Jbm50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeff
    udduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughmuhhnugdrrhgrihhl
    vgesphhrohhtohhnrdhmvgdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgvghhrvg
    hsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsthgrsghl
    vgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:URUbZyXmI8YdVWkCnmjP5hcuhlH0mmavj5vkZD-TO-GhVtXig6zGIw>
    <xmx:URUbZxkAbhpeTGaVOVbEvFZSgWS6ABe-d6Og9VDvbqF9tTJD5Uxw-w>
    <xmx:URUbZ_cc31pZbPBLRgXHeuw24B_6_FJiWp2My0UlelTqDPxMUwwwfQ>
    <xmx:URUbZ7HQVn2PfJEMlvpAaamk20HRRb_sLVVjjgaRrUO5hnkHVOBYsA>
    <xmx:UhUbZ0uOjIHDpDSCv9ffevWSR9tOIfChPe4W8n4Z_NN-UBFAeEUZL7QP>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 23:49:36 -0400 (EDT)
Date: Fri, 25 Oct 2024 12:49:34 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@proton.me>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: firewire-ohci: device rediscovery hardlock regression
Message-ID: <20241025034934.GA95457@workstation.local>
Mail-Followup-To: Edmund Raile <edmund.raile@proton.me>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
References: <8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.camel@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9902a4ece9329af1e1e42f5fea76861f0bf0e8.camel@proton.me>

Hi,

Thanks for the bug report.

Coincidentally, I face the same problem with my TC Electronic Desktop
Konnekt 6, which reports one available port and two invalidated ports, and
investigate its cause. I think the problem occurs just for the devices
which have three or more ports.

I sent a fix[1] just now by referring to your suggestions. Would you please
evaluate the fix with your device?

I'm sorry for your inconvenience.


[1] [PATCH] firewire: core: fix invalid port index for parent device
https://lore.kernel.org/lkml/20241025034137.99317-1-o-takashi@sakamocchi.jp/


Thanks

Takashi Sakamoto

On Thu, Oct 24, 2024 at 01:56:31PM +0000, Edmund Raile wrote:
> Hello,
> 
> I'd like to report a regression in firewire-ohci that results
> in the kernel hardlocking when re-discovering a FireWire device.
> 
> TI XIO2213B
> RME FireFace 800
> 
> It will occur under three conditions:
>  * power-cycling the FireWire device
>  * un- and re-plugging the FireWire device
>  * suspending and then waking the PC
> 
> Often it would also occur directly on boot in QEMU but I have not
> yet observed this specific behavior on bare metal.
> 
> Here is an excerpt from the stack trace (don't know whether it is
> acceptable to send in full):
> 
> kernel: ------------[ cut here ]------------
> kernel: refcount_t: addition on 0; use-after-free.
> kernel: WARNING: CPU: 3 PID: 116 at lib/refcount.c:25
> refcount_warn_saturate (/build/linux/lib/refcount.c:25 (discriminator
> 1)) 
> kernel: Workqueue: firewire_ohci bus_reset_work
> kernel: RIP: 0010:refcount_warn_saturate
> (/build/linux/lib/refcount.c:25 (discriminator 1)) 
> kernel: Call Trace:
> kernel:  <TASK>
> kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
> (discriminator 1)) 
> kernel: ? __warn.cold (/build/linux/kernel/panic.c:693) 
> kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
> (discriminator 1)) 
> kernel: ? report_bug (/build/linux/lib/bug.c:180
> /build/linux/lib/bug.c:219) 
> kernel: ? handle_bug (/build/linux/arch/x86/kernel/traps.c:218) 
> kernel: ? exc_invalid_op (/build/linux/arch/x86/kernel/traps.c:260
> (discriminator 1)) 
> kernel: ? asm_exc_invalid_op
> (/build/linux/./arch/x86/include/asm/idtentry.h:621) 
> kernel: ? refcount_warn_saturate (/build/linux/lib/refcount.c:25
> (discriminator 1)) 
> kernel: for_each_fw_node (/build/linux/./include/linux/refcount.h:190
> /build/linux/./include/linux/refcount.h:241
> /build/linux/./include/linux/refcount.h:258
> /build/linux/drivers/firewire/core.h:199
> /build/linux/drivers/firewire/core-topology.c:275) 
> kernel: ? __pfx_report_found_node (/build/linux/drivers/firewire/core-
> topology.c:312) 
> kernel: fw_core_handle_bus_reset (/build/linux/drivers/firewire/core-
> topology.c:399 (discriminator 1) /build/linux/drivers/firewire/core-
> topology.c:504 (discriminator 1)) 
> kernel: bus_reset_work (/build/linux/drivers/firewire/ohci.c:2121) 
> kernel: process_one_work
> (/build/linux/./arch/x86/include/asm/jump_label.h:27
> /build/linux/./include/linux/jump_label.h:207
> /build/linux/./include/trace/events/workqueue.h:110
> /build/linux/kernel/workqueue.c:3236) 
> kernel: worker_thread (/build/linux/kernel/workqueue.c:3306
> (discriminator 2) /build/linux/kernel/workqueue.c:3393 (discriminator
> 2)) 
> kernel: ? __pfx_worker_thread (/build/linux/kernel/workqueue.c:3339) 
> kernel: kthread (/build/linux/kernel/kthread.c:389) 
> kernel: ? __pfx_kthread (/build/linux/kernel/kthread.c:342) 
> kernel: ret_from_fork (/build/linux/arch/x86/kernel/process.c:153) 
> kernel: ? __pfx_kthread (/build/linux/kernel/kthread.c:342) 
> kernel: ret_from_fork_asm (/build/linux/arch/x86/entry/entry_64.S:254) 
> kernel:  </TASK>
> 
> I have identified the commit via bisection:
> 24b7f8e5cd656196a13077e160aec45ad89b58d9
> firewire: core: use helper functions for self ID sequence
> 
> It was part of the following patch series:
> firewire: add tracepoints events for self ID sequence
> https://lore.kernel.org/all/20240605235155.116468-6-o-takashi@sakamocchi.jp/
> 
> #regzbot introduced: 24b7f8e5cd65
> 
> Since this was before v6.10-rc5 and stable 6.10.14 is EOL,
> stable v6.11.5 and mainline are affected.
> 
> Reversion appears to be non-trivial as it is part of a patch
> series, other files have been altered as well and other commits
> build on top of it.
> 
> Call chain:
> core-topology.c fw_core_handle_bus_reset()
> -> core-topology.c   for_each_fw_node(card, local_node,
> report_found_node)
> -> core.h            fw_node_get(root)
> -> refcount.h        __refcount_inc(&node)
> -> refcount.h        __refcount_add(1, r, oldp);
> -> refcount.h        refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
> -> refcount.h        REFCOUNT_WARN("addition on 0; use-after-free")
> 
> Since local_node of fw_core_handle_bus_reset() is retrieved by
> 	local_node = build_tree(card, self_ids, self_id_count);
> build_tree() needs to be looked at, it was indeed altered by
> 24b7f8e5cd65.
> 
> After a hard 3 hour look traversing all used functions and comparing
> against the original function (as of e404cacfc5ed), this caught my eye:
>        for (port_index = 0; port_index < total_port_count;
> ++port_index) {
>                switch (port_status) {
>                case PHY_PACKET_SELF_ID_PORT_STATUS_PARENT:
>                        node->color = i;
> 
> In both for loops, "port_index" was replaced by "i"
> "i" remains in use above:
>        for (i = 0, h = &stack; i < child_port_count; i++)
>                h = h->prev;
> 
> While the original also used the less descriptive i in the loop
>        for (i = 0; i < port_count; i++) {
>                switch (get_port_type(sid, i)) {
>                case SELFID_PORT_PARENT:
>                         node->color = i;
> but reset it to 0 at the beginning of the loop.
> 
> So the stray "i" in the for loop should be replaced with the loop
> iterator "port_index" as it is meant to be synchronous with the
> loop iterator (i.e. the port_index), no?
> 
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-
> topology.c
> index 8c10f47cc8fc..7fd91ba9c9c4 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -207,7 +207,7 @@ static struct fw_node *build_tree(struct fw_card
> *card, const u32 *sid, int self
>                                 // the node->ports array where the
> parent node should be.  Later,
>                                 // when we handle the parent node, we
> fix up the reference.
>                                 ++parent_count;
> -                               node->color = i;
> +                               node->color = port_index;
>                                 break;
> 
> What threw me off was discaridng node->color as it would be replaced
> later anyways (can't be important!), or so I thought.
> 
> Please tell me, is this line of reasoning correct or am I missing
> something?
> 
> Compiling 24b7f8e5cd65 and later mainline with the patch above
> resulted in a kernel that didn't crash!
> 
> In case my solution should turn out to be correct, I will gladly
> submit the patch.
> 
> Kind regards,
> Edmund Raile.

