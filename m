Return-Path: <stable+bounces-145054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54906ABD597
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E06E1895406
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD0272E4D;
	Tue, 20 May 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="b5UopSQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rmzgf5ic"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803D26FA5F
	for <stable@vger.kernel.org>; Tue, 20 May 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738414; cv=none; b=Es6tEqZNsKKiHdKamh6XfJ4Uq2NJLIzcVM/j2Jw48pxy3jIyG1qQCFqgK8lycr1O11xTRNG0iLsjOrBoHrXMEujRxWit7zhLDI3L8oYfsSWjcrgx3av1xE0srrxyCDXKrm64P4jR3Teo2+wFiUGgUxDRWlU/RBthi4nu3ejo+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738414; c=relaxed/simple;
	bh=LXd3IcT6krnK2RpQyshHXOWaQZ6BWgskD1SDGsDVL28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKMcbMsoxUmEURk6VN1k4UnhyavU4lRahYi6DsjxMUL2bkDLoo9KaRqEB8GV4+qI72FNg4Ki4RWNeb6lB6efDuTT/JIYWYFcDiLoUgsgclFgtbGraRNes8nFOhQBcinuLrp0+K3V7xTsrsfZbbrWqn66YKyEBo1AT6+kcYuSakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=b5UopSQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rmzgf5ic; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BFAFD138041F;
	Tue, 20 May 2025 06:53:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 06:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747738409; x=1747824809; bh=5KP/goyqOg
	4NwHMLi5FGnM9jkt8dNnjCvxSfQffmGOg=; b=b5UopSQzPQyF/eE1oHM+asiy1D
	EUBm5NjjGpiQQ/BG9mC1Fb7Z4+19bEQtkvN733sCnunVvgwLgUug1hSS3f6+UK11
	taPzcCXhK03/eJRjrMmG/z95298wlYfCZG9gLDi7gMfo1wT5erPPml+j3agN9AgA
	PmppkqkCpcVCaTYfGn5rym2knULLzuS3pA9Ac98dcf287m4il/hmWHocjIL2P2Jg
	KGZ+rkuu5xHDtv8QpzB5XumJN7XKrWlzyXHJiwCJIJiUNM82wBuySnFf7ASRZZjN
	m/gOacd11ovueJN5YuSYePxQWq/JuqFXcqRVd9zGODfdX9GSa8cHMYzX9vIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747738409; x=1747824809; bh=5KP/goyqOg4NwHMLi5FGnM9jkt8dNnjCvxS
	fQffmGOg=; b=rmzgf5icUdwEL8Pg7aJsaJhkTf21AEQWFQWp5G2/RPqamx49pkp
	U2BCJJqPoZ1QQsQGXvcAai3/GcxuIbNa3gzOJ/RBNyZ6zFRKjdIpzrBwVy8fGZCU
	cdNNJJgrn5lLTkV8MZAaHrDH3eJqtqKRJRsqu4lZZJ//wy/6oZeFj3X/Y7B52q7E
	KdFpDp/fO6swuF7YIRAIuk4H8VLVxrF23R1QGwu/BaDNz4FJHwBDa2l8Fzyf0p/T
	Imu5dMmcMNa4JTlzHtHNO4xSH1eBTjeWdJK7YW3OsbDUVW5a0LctdW/RmrNFG1OG
	FYqjAZvaPC8S0JB52E0nNKypUBoXzzX8Z8Q==
X-ME-Sender: <xms:KF8saOJh46jCXjcKyYDgDV2fct5EhBoA4_8KhXnvjBnYgpGPs-h34A>
    <xme:KF8saGLVD7MS0qUemzYwkmREaL0JK3XQjz7v-bcE0jc298nWL6ZecocbcPHs1DSTt
    FPSWLB9wnWQ_w>
X-ME-Received: <xmr:KF8saOs-LCGmwsJXXq69qY-xhqMYzeP7o5Fgn8Xf_hjbBLmFhaO4oQL7naSD9WrbeleaArQxJD3-NvBMgtVSpaDJJsU-En4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffg
    heekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlihiihidtgeeshhhushhtrdgvughurdgtnhdprhgtph
    htthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    iihmledusehhuhhsthdrvgguuhdrtghnpdhrtghpthhtohepsghorhhishessghurhdrih
    hopdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohepughsthgvrhgs
    rgesshhushgvrdgtohhm
X-ME-Proxy: <xmx:KF8saDZY5e9N2x7FIl1YHD2c98bgvBLT_7eVzLTuungp4AToyxxkeQ>
    <xmx:KF8saFbX8pOg98amWTA7jz2rX84Wi0-xlXDdKqjaHj4RjWj80XbF6Q>
    <xmx:KF8saPCPC8RUitEQWBVVQ7BvaY0jGwZ3YYZN_ndzv63TAU6LRaFRBg>
    <xmx:KF8saLZ6GyAkHUaHKnGkYoaKdUAMKlVy1oET0SBtn5sVZ2xqPbkkbw>
    <xmx:KV8saPrLY2iUH88KKUPRj6kKP_jCrIXl2sXHlXOiQuIR5wb3qnwVmIao>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 06:53:28 -0400 (EDT)
Date: Tue, 20 May 2025 12:53:26 +0200
From: Greg KH <greg@kroah.com>
To: Zhaoyang Li <lizy04@hust.edu.cn>
Cc: stable@vger.kernel.org, dzm91@hust.edu.cn, Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.1.y] btrfs: check folio mapping after unlock in
 relocate_one_folio()
Message-ID: <2025052013-june-visiting-ab7d@gregkh>
References: <2024123045-parka-sublet-a95d@gregkh>
 <20250513032523.377137-1-lizy04@hust.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513032523.377137-1-lizy04@hust.edu.cn>

On Tue, May 13, 2025 at 11:25:23AM +0800, Zhaoyang Li wrote:
> From: Boris Burkov <boris@bur.io>
> 
> [ Upstream commit 3e74859ee35edc33a022c3f3971df066ea0ca6b9 ]
> 
> When we call btrfs_read_folio() to bring a folio uptodate, we unlock the
> folio. The result of that is that a different thread can modify the
> mapping (like remove it with invalidate) before we call folio_lock().
> This results in an invalid page and we need to try again.
> 
> In particular, if we are relocating concurrently with aborting a
> transaction, this can result in a crash like the following:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 76 PID: 1411631 Comm: kworker/u322:5
>   Workqueue: events_unbound btrfs_reclaim_bgs_work
>   RIP: 0010:set_page_extent_mapped+0x20/0xb0
>   RSP: 0018:ffffc900516a7be8 EFLAGS: 00010246
>   RAX: ffffea009e851d08 RBX: ffffea009e0b1880 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: ffffc900516a7b90 RDI: ffffea009e0b1880
>   RBP: 0000000003573000 R08: 0000000000000001 R09: ffff88c07fd2f3f0
>   R10: 0000000000000000 R11: 0000194754b575be R12: 0000000003572000
>   R13: 0000000003572fff R14: 0000000000100cca R15: 0000000005582fff
>   FS:  0000000000000000(0000) GS:ffff88c07fd00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 000000407d00f002 CR4: 00000000007706f0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>   <TASK>
>   ? __die+0x78/0xc0
>   ? page_fault_oops+0x2a8/0x3a0
>   ? __switch_to+0x133/0x530
>   ? wq_worker_running+0xa/0x40
>   ? exc_page_fault+0x63/0x130
>   ? asm_exc_page_fault+0x22/0x30
>   ? set_page_extent_mapped+0x20/0xb0
>   relocate_file_extent_cluster+0x1a7/0x940
>   relocate_data_extent+0xaf/0x120
>   relocate_block_group+0x20f/0x480
>   btrfs_relocate_block_group+0x152/0x320
>   btrfs_relocate_chunk+0x3d/0x120
>   btrfs_reclaim_bgs_work+0x2ae/0x4e0
>   process_scheduled_works+0x184/0x370
>   worker_thread+0xc6/0x3e0
>   ? blk_add_timer+0xb0/0xb0
>   kthread+0xae/0xe0
>   ? flush_tlb_kernel_range+0x90/0x90
>   ret_from_fork+0x2f/0x40
>   ? flush_tlb_kernel_range+0x90/0x90
>   ret_from_fork_asm+0x11/0x20
>   </TASK>
> 
> This occurs because cleanup_one_transaction() calls
> destroy_delalloc_inodes() which calls invalidate_inode_pages2() which
> takes the folio_lock before setting mapping to NULL. We fail to check
> this, and subsequently call set_extent_mapping(), which assumes that
> mapping != NULL (in fact it asserts that in debug mode)
> 
> Note that the "fixes" patch here is not the one that introduced the
> race (the very first iteration of this code from 2009) but a more recent
> change that made this particular crash happen in practice.
> 
> Fixes: e7f1326cc24e ("btrfs: set page extent mapped after read_folio in relocate_one_page")
> CC: stable@vger.kernel.org # 6.1+
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>

You forgot to backport to 6.6.y first :(

