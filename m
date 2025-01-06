Return-Path: <stable+bounces-106846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B0FA0269E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A60D3A4808
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2E1DC9AA;
	Mon,  6 Jan 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kSYZriku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTYVXwSW"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF01D619D;
	Mon,  6 Jan 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170421; cv=none; b=cToBlAFSphjWkMTx/lWIGzWCxMSdRwHhoIM50r5TJDkzLZ4PlrpDKfTjVj4JhpyvvTLAShF430gDysC21Nq0xcE/Oe06Qqcd2nxnrUxQ1VwjW7bDGP2TVugIGIU9YzIOywQQtOTKKk1jJLw4O3NlAF86rzPuy0pFp+vNqIwSz0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170421; c=relaxed/simple;
	bh=2CEwRnA2vL9DxLn9DleCI8pfO3Q0W7UbBwuzJ6m/iUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzc/I83nD8WHWxztFUulwp9oc/B3VmnY8xmQusYv4EOc49YVtWpWR6HJQmsxM7G21qHYLKfvSDkQzFbfcrkqdPfETZ16ecyHb1n1q0lyuXmEJxPxCjGirSw8Msme6qUVjVyh9ZSfJBWKea0MCMRJbuz/RSyIxcIE2WQu07sNucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kSYZriku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTYVXwSW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 463BF1380A5D;
	Mon,  6 Jan 2025 08:33:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 08:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736170417; x=1736256817; bh=E+OweSDlrV
	SNhXEv9fGYNKJOXPqVZm6TtrXdJ+ouXhU=; b=kSYZrikuojGJweLNDz7azbQUUc
	uUDW9bAQjfUtT4U60OA/37yKCPmS9uyarmW4/1L1Ud4SizArrpVwpwxgtaIfhXQ9
	C2/LxT3tEP/76/Sbps/gpBZLvV+iISQafoRZV0t1E5sKGUnfihKyqCC7oTouk8/I
	IiYxCuE7qzXG7vYV48WHNQ5PXJyAMx8+jYAt3VJYwf+kEfZD07Sf88/GfWJM0IDx
	/9o2cjWbUzHTsO5SnlwIUKH1nu8nGZ6207mzuEA8vz87j75H5/cVmO57v75YX2kf
	Fh8W2BXa6PqdfEaxBZqZc/Amv4Tg/W2zbp63pl+29IYftP4FgpFHRIk6r3SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736170417; x=1736256817; bh=E+OweSDlrVSNhXEv9fGYNKJOXPqVZm6TtrX
	dJ+ouXhU=; b=UTYVXwSWV6Nh+tos7LthbqMjk2PWFpUE89z8ErFR0+9MtYGmjjO
	OFY89qHMWYyaHezcsafElidGcbaFVJyFidGUbJ1bitWLkbtlPuyszzOmnwl1J96c
	HMGwV9MW3FzKNnHWgkUPyZFVzvivDgS6fGaaH/EB1ZQxLvl2qlXeOa29SUStD/L9
	NgZBkYkcfA4xC3KvR1I5e2WcTfxr4MzQfMReFrX2CYNRVstthNzU1I1X5q0Y3Ga6
	WjVwTa0JErigD8XbcQuUlekOYBgApH/4/gazHp6UPd6HuUPdZTrIcamxMLJx07Jd
	SHQi955L8Qi7+U04mpXTY/FOnFDDT58wd7g==
X-ME-Sender: <xms:sNt7Z5oA07TMDZ507uXhNqxCbujrQ1i9tyZq5FhP1ei4dOpsgNRtDg>
    <xme:sNt7Z7q5T_I1ZtTiJy_nRkiwGD__gyrzdt_5xubJcOYP0p8X__x1D0zCWjJl_afGJ
    2G_bA6pIBUWqA>
X-ME-Received: <xmr:sNt7Z2OIp0e6rGHmk3xNNLaMwQd6dhWcGyovoQJWQxrQ3MQXpYHh6YJScKs_B-jvpeQGvNEPdCuGJp6V_La0uRJF1iIXyDnFoRRbjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefh
    gfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepth
    horhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkohhitghhihhrohdruggvnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthho
    pegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehsthgrsghlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sNt7Z05wBeFhgdgkEUrEm6PxDeK4EgTdpb7o5jBgQamdb2mcrBXeRQ>
    <xmx:sNt7Z46pYhrnsvVJh5nKSPN1HnphT0OEEcB3hzfi834EH84bwk9zmw>
    <xmx:sNt7Z8hhJtTWl-VCXqmkFhqBOhCtmGdJLQMT6KtWWhdhPiUtApRdsA>
    <xmx:sNt7Z67jLtd62HFKp_bktqZfHn5YoFbxdrjNLhbBBa0u3ZhISY3gZA>
    <xmx:sdt7ZzpLl4I6bOdcDIY0W2SxWF6aP-06-NPaKs3wklNlGQP6gbqg5rIg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 08:33:36 -0500 (EST)
Date: Mon, 6 Jan 2025 14:33:34 +0100
From: Greg KH <greg@kroah.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Koichiro Den <koichiro.den@canonical.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <2025010620-childcare-backhand-aae3@gregkh>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
 <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>

On Mon, Jan 06, 2025 at 02:18:17PM +0100, Borislav Petkov wrote:
> On Sun, Jan 05, 2025 at 02:20:54PM -0800, Linus Torvalds wrote:
> > So we had a slight pickup in commits this last week, but as expected
> > and hoped for, things were still pretty quiet. About twice as many
> > commits as the holiday week, but that's still not all that many.
> > 
> > I expect things will start becoming more normal now that people are
> > back from the holidays and are starting to recover and wake up from
> > their food comas.
> > 
> > In the meantime, below is the shortlog for the last week. Nothing
> > particularly stands out, the changes are dominated by various driver
> > updates (gpu, rdma and networking), with a random smattering of fixes
> > elsewhere.
> 
> Something not well baked managed to sneak in and it is tagged for stable:
> 
> adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()")
> 
> Reverting it fixes the warn splat below.
> 
> [    0.310373] smpboot: x86: Booting SMP configuration:
> [    0.311074] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> [    0.313798] ------------[ cut here ]------------
> [    0.317530] workqueue: work disable count underflowed
> [    0.317530] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:4317 enable_work+0xa4/0xb0
> [    0.317530] Modules linked in:
> [    0.317530] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #11
> [    0.317530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-8 02/21/2024
> [    0.317530] RIP: 0010:enable_work+0xa4/0xb0
> [    0.317530] Code: c0 48 83 c4 18 5b 5d e9 ca 25 9f 00 80 3d 0a c7 48 08 00 75 b3 c6 05 01 c7 48 08 01 90 48 c7 c7 c8 eb 1d 82 e8 5d 77 fd ff 90 <0f> 0b 90 90 eb 98 90 0f 0b 90 eb b1 90 90 90 90 90 90 90 90 90 90
> [    0.317530] RSP: 0018:ffffc90000137e18 EFLAGS: 00010082
> [    0.317530] RAX: 0000000000000029 RBX: ffff88807d66dda0 RCX: 00000000ffefffff
> [    0.317530] RDX: 0000000000000001 RSI: ffffc90000137ce0 RDI: 0000000000000001
> [    0.317530] RBP: 0000000000000000 R08: 00000000ffefffff R09: 0000000000000058
> [    0.317530] R10: 0000000000000000 R11: ffffffff8244df00 R12: 0000000000000000
> [    0.317530] R13: ffff88807d6604e0 R14: ffffffff812439f0 R15: ffff88807d660508
> [    0.317530] FS:  0000000000000000(0000) GS:ffff88807d640000(0000) knlGS:0000000000000000
> [    0.317530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.317530] CR2: 0000000000000000 CR3: 0000000002c1a000 CR4: 00000000003506f0
> [    0.317530] Call Trace:
> [    0.317530]  <TASK>
> [    0.317530]  ? __warn+0xa0/0x160
> [    0.317530]  ? enable_work+0xa4/0xb0
> [    0.317530]  ? report_bug+0x18c/0x1c0
> [    0.317530]  ? handle_bug+0x54/0x90
> [    0.317530]  ? exc_invalid_op+0x1b/0x80
> [    0.317530]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.317530]  ? __pfx_vmstat_cpu_online+0x10/0x10
> [    0.317530]  ? enable_work+0xa4/0xb0
> [    0.317530]  ? enable_work+0xa3/0xb0
> [    0.317530]  vmstat_cpu_online+0x61/0x80
> [    0.317530]  cpuhp_invoke_callback+0x10f/0x480
> [    0.317530]  ? srso_return_thunk+0x5/0x5f
> [    0.317530]  cpuhp_thread_fun+0xd4/0x160
> [    0.317530]  smpboot_thread_fn+0xdd/0x1f0
> [    0.317530]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    0.317530]  kthread+0xca/0xf0
> [    0.317530]  ? __pfx_kthread+0x10/0x10
> [    0.317530]  ret_from_fork+0x50/0x60
> [    0.317530]  ? __pfx_kthread+0x10/0x10
> [    0.317530]  ret_from_fork_asm+0x1a/0x30
> [    0.317530]  </TASK>
> [    0.317530] ---[ end trace 0000000000000000 ]---
> [    0.377680] smp: Brought up 1 node, 16 CPUs
> [    0.378345] smpboot: Total of 16 processors activated (118393.24 BogoMIPS)

I've just dropped it from the stable queues as well.

thanks,

greg k-h

