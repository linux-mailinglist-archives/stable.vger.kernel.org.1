Return-Path: <stable+bounces-92213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208EE9C50AD
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AC72811A3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61C20A5FE;
	Tue, 12 Nov 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="I9I3ODVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAhzRuyw"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55B20A5E3
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400362; cv=none; b=h5Hw7ay4K1Lm/eR5QpCrgArqvEIdy81m1AoHa6Kb2UPyJncF6m+pQqVf42G4H8rUTg/Aof/hzXHwwkWYwz8wKXk9DcMjltlTXEleJsVPByNCiRdkkXvk6ln92WFT9ehF9/5Lid05N6/m3qJYJMGnb2H77xcbtJZ8zwfzMUwKmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400362; c=relaxed/simple;
	bh=vj03V+gzS8xTPUMIFRaV7/ujD0u+oMBQzVy8pA1rbcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP1xkl5t8qrWHtdA8joc5S/G+sb42V9P+4yMd2GZ6rMKpIkIwlXD+ftL5AH0dLsg5RefpQIZZkh/OcXgoVk72T6rMoQnz0xTjZEWXsFIlDiMJ9bpD4/c/r6DurgdlGAbaQppKylWHoJdhbKAeIkZOfZlv7O+0TJO9wx26N5rXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=I9I3ODVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAhzRuyw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 333C513801EC;
	Tue, 12 Nov 2024 03:32:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 Nov 2024 03:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731400358; x=1731486758; bh=X1zbOfapx7
	WhLnLaegZbhVTCDtcALqv3v7N9hHaWfMM=; b=I9I3ODVaSy5lyXMSSYuhSzEJj5
	1iVtABYV38yPUmt5og0CwsAqNmCbEsu26gEFEudq9GvITgz8uDCGweszTM0etd7q
	T4kR04/jttbaAanxquw4z1eChrRFG7nOg3gWND3MAA0rOOqRGBEbe1ozEU5R7WHB
	+qnVocXzQIndUJFy8HkkY8bevo/h+Sf+814zCLOgCToIkU9pSNRSbsi8Dsn9hzTV
	iG9CicPPFlJxS/2miDjduN2epKIqXkCarLtwmC91g5gfOy5Z342PH5iUFILU9zXu
	CSRmO/UuGRHKIAqjj4OSiei4oaYJl5h7kHDyYYSYSN2khPGUACIxPYpW4JGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731400358; x=1731486758; bh=X1zbOfapx7WhLnLaegZbhVTCDtcALqv3v7N
	9hHaWfMM=; b=gAhzRuywPLgu1O81pUStTx2Q15lJFVagx+R1wVcfnHI1CRMFEu6
	KtIu7M9Vo83uremnAXClCrowPgFXmVx8d5nyU4xbiYfYPt24EajsE4HysafSY4jM
	bjXvEPvdgq5TFDtzeKI3NzkabVJn3PlbHhl/NPWiQ93dd19KPM3Rw5w2TGCEPVKL
	BSHjGy9Phtz+f3CMy1EzJqLZqCIw9UmYp/9tGL2VK0UOVbRh6sOv/1Kst5kFdv3e
	YEqBlNT++Daz57ZEToDCFVQdFWONJDgs6ofr16X62k3OMHRDlkg2dbCrTgPpfNjI
	EaQaH1VPDMUjY0wEe9Jw+isLYtsxT4mte0Q==
X-ME-Sender: <xms:pRIzZ4TI0nNwqV4pPzlYvZp2YfP-KPVdhNjgv_mRomtn7PsP7gDpcA>
    <xme:pRIzZ1wUjEqNIRXgfQoMOjPTmTgdKQygijW5BIh90XRh_3DZ7KHhX4zC84IA1yiCN
    2gO0fGFDiqnIw>
X-ME-Received: <xmr:pRIzZ12rHxxyPg1pfPync3cum8APrTGTjQfHrlrBqcZIx5MJWo7DXUPr8HQTmQcvwmsG7hyqB2ORpyygAUcyfeTyVzl0lPSv0LtV_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepjeekfeffvdeffeduffejteekffeileehgeefudffgfdtgfeuueduuedu
    jeekfeeknecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpd
    hmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegumhgrnhhtihhpohhvseihrghnuggvgidrrhhupdhrtghpthhtohepvhhinhhitghi
    uhhsrdhgohhmvghssehinhhtvghlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pRIzZ8DwEFJ7_R9JPQmVKQU8Ze-vpCa7O1nT02SJXJKqtQhniNv0Vg>
    <xmx:pRIzZxjGxtYCXhY-eaQ84xR1MuqCpQ0QzSjTEASnFNZjxCuPNnuDLQ>
    <xmx:pRIzZ4qEovezUpdQjaTPdeGKKBMVNgrY0wGxcyLPwpcDVhOVFgnUFA>
    <xmx:pRIzZ0j8G8Fl35ewhsKEUx9uiIWZyAoPM_TQJwhG4O_LwW2SR6BNIg>
    <xmx:phIzZ6aeXzf_VXO_UTT0oKYHW7LIjC4e-POM5Z6wdN_XU8Y8ibDXCNyo>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 03:32:37 -0500 (EST)
Date: Tue, 12 Nov 2024 09:32:35 +0100
From: Greg KH <greg@kroah.com>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 1/1] net: sched: use RCU read-side critical section
 in taprio_dump()
Message-ID: <2024111228-dipped-kinetic-718f@gregkh>
References: <20241111161701.284694-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111161701.284694-1-lee@kernel.org>

On Mon, Nov 11, 2024 at 04:17:01PM +0000, Lee Jones wrote:
> From: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [ Upstream commit b22db8b8befe90b61c98626ca1a2fbb0505e9fe3 ]
> 
> Fix possible use-after-free in 'taprio_dump()' by adding RCU
> read-side critical section there. Never seen on x86 but
> found on a KASAN-enabled arm64 system when investigating
> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa:
> 
> [T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
> [T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
> [T15862]
> [T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
> [T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
> [T15862] Call trace:
> [T15862]  dump_backtrace+0x20c/0x220
> [T15862]  show_stack+0x2c/0x40
> [T15862]  dump_stack_lvl+0xf8/0x174
> [T15862]  print_report+0x170/0x4d8
> [T15862]  kasan_report+0xb8/0x1d4
> [T15862]  __asan_report_load4_noabort+0x20/0x2c
> [T15862]  taprio_dump+0xa0c/0xbb0
> [T15862]  tc_fill_qdisc+0x540/0x1020
> [T15862]  qdisc_notify.isra.0+0x330/0x3a0
> [T15862]  tc_modify_qdisc+0x7b8/0x1838
> [T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [T15862]  rtnetlink_rcv+0x28/0x40
> [T15862]  netlink_unicast+0x51c/0x790
> [T15862]  netlink_sendmsg+0x79c/0xc20
> [T15862]  __sock_sendmsg+0xe0/0x1a0
> [T15862]  ____sys_sendmsg+0x6c0/0x840
> [T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [T15862]  __sys_sendmsg+0x110/0x1d0
> [T15862]  __arm64_sys_sendmsg+0x74/0xb0
> [T15862]  invoke_syscall+0x88/0x2e0
> [T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [T15862]  do_el0_svc+0x44/0x60
> [T15862]  el0_svc+0x50/0x184
> [T15862]  el0t_64_sync_handler+0x120/0x12c
> [T15862]  el0t_64_sync+0x190/0x194
> [T15862]
> [T15862] Allocated by task 15857:
> [T15862]  kasan_save_stack+0x3c/0x70
> [T15862]  kasan_save_track+0x20/0x3c
> [T15862]  kasan_save_alloc_info+0x40/0x60
> [T15862]  __kasan_kmalloc+0xd4/0xe0
> [T15862]  __kmalloc_cache_noprof+0x194/0x334
> [T15862]  taprio_change+0x45c/0x2fe0
> [T15862]  tc_modify_qdisc+0x6a8/0x1838
> [T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
> [T15862]  netlink_rcv_skb+0x1f8/0x3d4
> [T15862]  rtnetlink_rcv+0x28/0x40
> [T15862]  netlink_unicast+0x51c/0x790
> [T15862]  netlink_sendmsg+0x79c/0xc20
> [T15862]  __sock_sendmsg+0xe0/0x1a0
> [T15862]  ____sys_sendmsg+0x6c0/0x840
> [T15862]  ___sys_sendmsg+0x1ac/0x1f0
> [T15862]  __sys_sendmsg+0x110/0x1d0
> [T15862]  __arm64_sys_sendmsg+0x74/0xb0
> [T15862]  invoke_syscall+0x88/0x2e0
> [T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
> [T15862]  do_el0_svc+0x44/0x60
> [T15862]  el0_svc+0x50/0x184
> [T15862]  el0t_64_sync_handler+0x120/0x12c
> [T15862]  el0t_64_sync+0x190/0x194
> [T15862]
> [T15862] Freed by task 6192:
> [T15862]  kasan_save_stack+0x3c/0x70
> [T15862]  kasan_save_track+0x20/0x3c
> [T15862]  kasan_save_free_info+0x4c/0x80
> [T15862]  poison_slab_object+0x110/0x160
> [T15862]  __kasan_slab_free+0x3c/0x74
> [T15862]  kfree+0x134/0x3c0
> [T15862]  taprio_free_sched_cb+0x18c/0x220
> [T15862]  rcu_core+0x920/0x1b7c
> [T15862]  rcu_core_si+0x10/0x1c
> [T15862]  handle_softirqs+0x2e8/0xd64
> [T15862]  __do_softirq+0x14/0x20
> 
> Fixes: 18cdd2f0998a ("net/sched: taprio: taprio_dump and taprio_change are protected by rtnl_mutex")
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Link: https://patch.msgid.link/20241018051339.418890-2-dmantipov@yandex.ru
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit 5d282467245f267c0b9ada3f7f309ff838521536)
> [Lee: Backported from linux-6.6.y to linux-6.1.y and fixed conflicts]
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/sched/sch_taprio.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Now queued up, thanks.

greg k-h

