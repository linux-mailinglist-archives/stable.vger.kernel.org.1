Return-Path: <stable+bounces-45668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6148CD1AA
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4963E28329E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C813B5B3;
	Thu, 23 May 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpVK5l69"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09513A894;
	Thu, 23 May 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465820; cv=none; b=l+sbhmn5Nr4NsQ65QbQZa/3N5L3jecErrGvctUbQZdBar2aSynjLYnmh/3p2DqEVS48xfsJE/tYZzj1R6VFY+NkXUWk3Q0zVC99dMwsYOiuG4ukBV9qjtOKpl2XhYM6yDOD23BEKlyiWg+KDLYqXvqfTD+lbYwX/ZCB/ItQ+R6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465820; c=relaxed/simple;
	bh=eWkNJcfU+EmiTjPyTS8JAj/iB/RtbvQsavWH09XgE+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7bj64+7rebgYX9M+B64cUW0s6kI1/Ui4ikVUg1VCy47BcU6zXOvdadkp00dK6CKaJfORAUaqsmuSO37U97Is/gfWkK7tYABjFBGVN22O/qiSlI4XaJ8TL1JB0lIyN/ldgOqR6A05LH/Fr5x2jHlqe4GHocYEclXkOzf+/33JK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpVK5l69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4FEC2BD10;
	Thu, 23 May 2024 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465819;
	bh=eWkNJcfU+EmiTjPyTS8JAj/iB/RtbvQsavWH09XgE+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpVK5l693KbywU7Nnso1PNndTUAmaBnlwpt8k5OBu5ofSTY1BgoIwSKa6qAL7vkk4
	 QiKlajC3L6qWt3TdIkqTQrbyyoorR6wMChJd4zk6KzT6e0c6xtU+iA/tjfqVfVSRZJ
	 7BtuNvyqKM8GGQUubNTAXD4PO/ZaaDAB74cNVldo=
Date: Thu, 23 May 2024 14:03:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] mptcp: ensure snd_nxt is properly initialized on
 connect
Message-ID: <2024052326-boggle-smother-fbbe@gregkh>
References: <2024051325-dreamt-freebee-5563@gregkh>
 <20240513151717.2733290-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513151717.2733290-2-matttbe@kernel.org>

On Mon, May 13, 2024 at 05:17:17PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit fb7a0d334894206ae35f023a82cad5a290fd7386 upstream.
> 
> Christoph reported a splat hinting at a corrupted snd_una:
> 
>   WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>   Modules linked in:
>   CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>   Workqueue: events mptcp_worker
>   RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>   Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
>   	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
>   	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
>   RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
>   RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
>   RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
>   RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>   R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
>   R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
>   FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
>   Call Trace:
>    <TASK>
>    __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
>    mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
>    __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
>    mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
>    process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
>    process_scheduled_works kernel/workqueue.c:3335 [inline]
>    worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
>    kthread+0x121/0x170 kernel/kthread.c:388
>    ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>    </TASK>
> 
> When fallback to TCP happens early on a client socket, snd_nxt
> is not yet initialized and any incoming ack will copy such value
> into snd_una. If the mptcp worker (dumbly) tries mptcp-level
> re-injection after such ack, that would unconditionally trigger a send
> buffer cleanup using 'bad' snd_una values.
> 
> We could easily disable re-injection for fallback sockets, but such
> dumb behavior already helped catching a few subtle issues and a very
> low to zero impact in practice.
> 
> Instead address the issue always initializing snd_nxt (and write_seq,
> for consistency) at connect time.
> 
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Tested-by: Christoph Paasch <cpaasch@apple.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://lore.kernel.org/r/20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ snd_nxt field is not available in v5.10.y: before, only write_seq was
>   used, see commit eaa2ffabfc35 ("mptcp: introduce MPTCP snd_nxt") for
>   more details about that. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)

Now queued up, thanks.

greg k-h

