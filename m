Return-Path: <stable+bounces-58232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34892A352
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ED82820BC
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2C81AD2;
	Mon,  8 Jul 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIIugIHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202E3FB94
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443320; cv=none; b=VRQERtCf1iQR6lwte7/Rrg8rWXIPNhDGJlOTxnsL3PNCh7axRiq00CD6ycxBQYraL7zA1VsuB2GqEIWwsMW68X+09mDigdPcWll3FJisUZd8nWlOA/zF01FV4NcJ0AZjvktxwXnYrG1qRzUYba9J3j4KiQ0AVLAj2jA9cEsjgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443320; c=relaxed/simple;
	bh=e7YDZm4PpxmOt7sdnywit5Wh19+UN0CcQy7cSk79Wko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He77Pq2Pf1BzW5ItFkj8ZKjjNZ0L8AJY/SJJvP1NzO4QfyPmitjn7s6Dbh1I4H7HOYaFnN//dL/N+/0ctBAWI8P/SBmAYy4N/+RdX9qMEmiwcwIPqcu7OeigBOxnJdIucI/jfP97HsutHsWFtJew/FtMVURFCbK7DJyWl5/ExVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIIugIHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC520C116B1;
	Mon,  8 Jul 2024 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443320;
	bh=e7YDZm4PpxmOt7sdnywit5Wh19+UN0CcQy7cSk79Wko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIIugIHYD7aydRzcj5ocJxVkGj26QQlJW+alB+rmlMUqDK0PaTF5gXsgiWdmjHZDN
	 H53Ay5IxMh7et7f//dFy0S9tB0qLZN2NUx3D/KOVlbLBXmKWxs0Y19oIkfoKkMd38k
	 O1A/q87Iz2wryKxjk0lbHQgqGfd3gMr4FwbcMnXI=
Date: Mon, 8 Jul 2024 14:55:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: stable@vger.kernel.org, wangyufen@huawei.com, mqaio@linux.alibaba.com,
	dtcccc@linux.alibaba.com, tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com, dust.li@linux.alibaba.com
Subject: Re: [PATCH backport 5.10.y] bpf, sockmap: Fix sk->sk_forward_alloc
 warn_on in sk_stream_kill_queues
Message-ID: <2024070809-cloak-quiet-9b2e@gregkh>
References: <20240703034746.57537-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703034746.57537-1-guwen@linux.alibaba.com>

On Wed, Jul 03, 2024 at 11:47:46AM +0800, Wen Gu wrote:
> From: Wang Yufen <wangyufen@huawei.com>
> 
> [ Upstream commit d8616ee2affcff37c5d315310da557a694a3303d ]
> 
> During TCP sockmap redirect pressure test, the following warning is triggered:
> 
> WARNING: CPU: 3 PID: 2145 at net/core/stream.c:205 sk_stream_kill_queues+0xbc/0xd0
> CPU: 3 PID: 2145 Comm: iperf Kdump: loaded Tainted: G        W         5.10.0+ #9
> Call Trace:
>  inet_csk_destroy_sock+0x55/0x110
>  inet_csk_listen_stop+0xbb/0x380
>  tcp_close+0x41b/0x480
>  inet_release+0x42/0x80
>  __sock_release+0x3d/0xa0
>  sock_close+0x11/0x20
>  __fput+0x9d/0x240
>  task_work_run+0x62/0x90
>  exit_to_user_mode_prepare+0x110/0x120
>  syscall_exit_to_user_mode+0x27/0x190
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The reason we observed is that:
> 
> When the listener is closing, a connection may have completed the three-way
> handshake but not accepted, and the client has sent some packets. The child
> sks in accept queue release by inet_child_forget()->inet_csk_destroy_sock(),
> but psocks of child sks have not released.
> 
> To fix, add sock_map_destroy to release psocks.
> 
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Link: https://lore.kernel.org/bpf/20220524075311.649153-1-wangyufen@huawei.com
> Stable-dep-of: 8bbabb3fddcd ("bpf, sock_map: Move cancel_work_sync() out of sock lock")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Conflict in include/linux/bpf.h due to function declaration position
> and remove non-existed sk_psock_stop helper from sock_map_destroy.]
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> background:
> Link: https://lore.kernel.org/stable/d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com/
> 
> @stable team:
> This backport has 2 changes compared to the original patch:
> - fix conflict due to sock_map_destroy declaration position in include/linux/bpf.h;
> - remove the non-existed sk_psock_stop helper from sock_map_destroy. This helper is
>   introduced by 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()") after
>   v5.10, it is not a fix and hard to backport. Considering that what did in
>   sk_psock_stop is done in sk_psock_drop and neither sock_map_close nor sock_map_unhash
>   in v5.10 introduces sk_psock_stop, I removed it from sock_map_destroy too.
> I tested it in my environment, the regression was gone.

Now queued up, thanks.

greg k-h

