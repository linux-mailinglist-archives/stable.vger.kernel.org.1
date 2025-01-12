Return-Path: <stable+bounces-108321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3385A0A82B
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 11:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6272165FB5
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34D185935;
	Sun, 12 Jan 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OUJWYTY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LolOvXnG"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80538B
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736676590; cv=none; b=uj/3pX5/UpwIG2BAQ17pEkoXIIw3Kw7nDgCw1RciryAgvrY9rnmsa5Ql/4Owf6Mq3hl5rldlzeMVbdB0rc61g1djQegUimyg5wxayAeqKlX0d5nx24RvZgQJ7Yx2kigsQ1bLQEjYpA8CXVdJcDYR1TKyxUgRRTF1dOdu799tApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736676590; c=relaxed/simple;
	bh=6aK5j/B7K4wPN/GKb9PsvWksiKji3G1mtz+FeZ9vjYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgrToS6uJ+6mcUwDclAsLMsBl/38LBE6wQe4F78bB962McJ6px0+nWOAXl5Elw1D+8SMsuzkWHxCh24YAawgfVfE+6mNGobpBOBREvhkluIMaC8zTVjtgyVCvg4FWpLmN2FYmejuyyfAVQMnonSuhZmcGn1t4MkVoESLY6QhxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OUJWYTY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LolOvXnG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FB40114015D;
	Sun, 12 Jan 2025 05:09:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 12 Jan 2025 05:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736676586; x=1736762986; bh=gdFWKnu0IV
	Ix31y5bwz1FgWgtWzDaOqwiWL22GbKXJk=; b=OUJWYTY4xSmn+3kVhHLIjamRr1
	l4nknp8jZnC1nUiEnq4/24h9XvwEw4J2kNcDP4oFY4EzqSVXuwWcV+KZzs9N/+k8
	1ZOQVzcs4jYaI5CzLc+nT6Z/rLbgNV45XjsO1aZbCmEiLVw/w81791/xex0/5jGM
	NAicGKlpID3frnp7nZjYYcm4aOPVTOpdJ+Ha2WK0vFVXuRCJO8u+1lEuoPCgQ9zD
	DdiaPvGXIX4MYb2SJSDSYxR5oGTiBVKO+lohBNeFW2Hu/cNij9uPAIQuclKFy9PE
	Ih6R2mblyRZVLshfDOHjsl/4LIE04ssKF6G0fCeMgSC1wOdxoF+d8/LWhQqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736676586; x=1736762986; bh=gdFWKnu0IVIx31y5bwz1FgWgtWzDaOqwiWL
	22GbKXJk=; b=LolOvXnGx7tJUcRt6xSyvwvROn5TLeFTjps16wA6ZhZAewlPc6X
	fnf2LVj/2K5wlLhSQeUNuuHN7Ykh4LPMuQPuPZoaeLOQ/Ynwyj52/pqTfUsi1lGO
	gl7CoGj5Ea6DgdhErnNvWcg8qsfowxVGfap3m2o6KhCk1jBTjItNC76JpOHYcxzX
	8y2RBuNScsJOHIuVZ0e/V7iDy2spWI97kng/gP+4ufqFdV3XjJpDPCMumtBG9gzq
	B+Nnedm5FNiiZSBdxDs9/OTyHAdhJ1Ubau0yfMu8L8DXGNS8UeoIZXE3vTUm3l94
	0bHHDmZ3mclGO069TwT1z++0yIA31lgs4fA==
X-ME-Sender: <xms:6ZSDZz2luoELQhzmvTndNWXTCnLi2k3vrk_JYSjp8KPqKhHAQ7iCsg>
    <xme:6ZSDZyFFH2-OzbRuJU4Oe8HNXbFPuxggGJSTx0dQ1KhnVa5kLaTnOzH1_1v4SyG15
    GwkTg2fldGOQw>
X-ME-Received: <xmr:6ZSDZz5tOLifhb0eh7BaiOTDBa56j7K8QI9Q1l_9psfyjuXLK6WfrQJLdkHYmkpQsW4HdO6cGgEQOY7F3_Qym_1NpcNhNvJ5eiSXKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghg
    sehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtdeluddtleekfe
    egjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghlvhgrlhgrnhelsehfohigmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhirghmrdhhohiflh
    gvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegtlheslhhinhhugidrtghomhdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:6ZSDZ42jN-DgtzXD9pGkQxEY7SwO7ZKVPI_nEpUbHgPs8Bb2tloJxQ>
    <xmx:6ZSDZ2EV4byHbnIJcAWes5TZjXwfUg_qxI_ZoNzg84veCw_TVgBLuw>
    <xmx:6ZSDZ5_cXfkUBCeuXmOhs7Mslos9qr28fsaybKO1jxFFTMrAvDRA3Q>
    <xmx:6ZSDZzlbXziJ8Aq39teWjQEiCYlcAc8wHhDV4uSsp4RD4B7JkBFsbQ>
    <xmx:6pSDZ9ebbGvKOivENJ8oCpQU2L9Lrq0xCTC19BI3SiQAoIYgfNbxFHfW>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jan 2025 05:09:45 -0500 (EST)
Date: Sun, 12 Jan 2025 11:09:43 +0100
From: Greg KH <greg@kroah.com>
To: alvalan9@foxmail.com
Cc: stable@vger.kernel.org, david@redhat.com, Liam.Howlett@oracle.com,
	cl@linux.com, akpm@linux-foundation.org
Subject: Re: [PATCH 6.1.y] mm/mempolicy: fix migrate_to_node() assuming there
 is at least one VMA in a MM
Message-ID: <2025011245-playset-transform-d82f@gregkh>
References: <tencent_A6390C6B4311AD460DE2C7BDE489B515CE06@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A6390C6B4311AD460DE2C7BDE489B515CE06@qq.com>

On Sat, Jan 11, 2025 at 10:15:20PM +0800, alvalan9@foxmail.com wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> [ Upstream commit 091c1dd2d4df6edd1beebe0e5863d4034ade9572 ]
> 
> We currently assume that there is at least one VMA in a MM, which isn't
> true.
> 
> So we might end up having find_vma() return NULL, to then de-reference
> NULL.  So properly handle find_vma() returning NULL.
> 
> This fixes the report:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
> RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
> Code: ...
> RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
> RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
> RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
> R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
> R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
> FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
>  __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
>  __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
>  __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [akpm@linux-foundation.org: add unlikely()]
> Link: https://lkml.kernel.org/r/20241120201151.9518-1-david@redhat.com
> Fixes: 39743889aaf7 ("[PATCH] Swap Migration V5: sys_migrate_pages interface")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/673d2696.050a0220.3c9d61.012f.GAE@google.com/T/
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Christoph Lameter <cl@linux.com>
> Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ Remove mmap_read_unlock() because mmap_read_lock() is not called before find_vma() ]
> Signed-off-by: Alva Lan <alvalan9@foxmail.com>
> ---
>  mm/mempolicy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 399d8cb48813..d67dd0f503fa 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1068,6 +1068,9 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
>  	 */
>  	vma = find_vma(mm, 0);
> +	if (unlikely(!vma)) {
> +		return 0;
> +	}	

Please follow the proper kernel coding style when doing backports, you
have {} here where not needed, AND you have trailing whitespace :(

Also, I'd like for someone on the reviewed-by chain to review that this
backport actually is ok before applying it (after you fix it up...)

thanks,

greg k-h

