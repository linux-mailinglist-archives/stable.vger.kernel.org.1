Return-Path: <stable+bounces-114843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0553A30398
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3308167A7C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA51E990A;
	Tue, 11 Feb 2025 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gI919JrA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE981E571F;
	Tue, 11 Feb 2025 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255421; cv=none; b=ZU9mByPKn08rlmavmKuFwBW8ze343vi3Z09vJv7owDkpPPpGKd3ae9tq+tqiDlHODERgydjZh5s2Z7agQoJ6PbhhkWcqKw6sjy/G0UF6xlcKMWhH3eXVgIHtXtpXsDBBGIPJ8s/CNjghGU+UKV4rimmuRfh26xbb0AQmudg1DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255421; c=relaxed/simple;
	bh=SQDUVh0rl3WKxWIUb4gCysRh4Aphb9hA44Jm/KJPB0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn2Z06aXoHAYTAbK729emusw2dV+3Bv2Qpj6N4nNdLRIOkWkDr+KLzH/+TXtIAlSHEvM5TWB3Yktnf/OlkdOcJuOTJuk7XQqADfXGzGWLrqUJTv5h9i3DdkbdROYxOsdeopJtA5FhQfRsbBwjBhXCk+gWLDToy6fhlFaOAQyWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gI919JrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACF8C4CEDD;
	Tue, 11 Feb 2025 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739255419;
	bh=SQDUVh0rl3WKxWIUb4gCysRh4Aphb9hA44Jm/KJPB0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gI919JrAc4NqCB6truU0+B3zgHB/rIxKwp4qv9j4YjzXsAFjSIRNY6cvPYq+n7zcr
	 bcNFC0bCRuSiv1e86MepP1ldqSU5M5hO2fr2ZvVDHQ1jDeHuiV3vGrFYmCwkIZdzOI
	 /q1XfZyVU8UPtbCTAHrQi0xXbFapmx8AYtZT4fek=
Date: Tue, 11 Feb 2025 07:29:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without
 `marks3`
Message-ID: <2025021138-track-liberty-f5d9@gregkh>
References: <20250210223144.3481766-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210223144.3481766-1-max.kellermann@ionos.com>

On Mon, Feb 10, 2025 at 11:31:44PM +0100, Max Kellermann wrote:
> At the beginning of the function, folio queues with marks3==0 are
> skipped, but after that, the `marks3` field is ignored.  If one such
> queue is found, `slot` is set to 64 (because `__ffs(0)==64`), leading
> to a buffer overflow in the folioq_folio() call.  The resulting crash
> may look like this:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP PTI
>  CPU: 11 UID: 0 PID: 2909 Comm: kworker/u262:1 Not tainted 6.13.1-cm4all2-vm #415
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  Workqueue: events_unbound netfs_read_termination_worker
>  RIP: 0010:netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
>  Code: 48 85 c0 48 89 44 24 08 0f 84 24 01 00 00 48 8b 80 40 01 00 00 48 8b 7c 24 08 f3 48 0f bc c0 89 44 24 18 89 c0 48 8b 74 c7 08 <48> 8b 06 48 c7 04 24 00 10 00 00 a8 40 74 10 0f b6 4e 40 b8 00 10
>  RSP: 0018:ffffbbc440effe18 EFLAGS: 00010203
>  RAX: 0000000000000040 RBX: ffff96f8fc034000 RCX: 0000000000000000
>  RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffff96f8fc036400
>  RBP: 0000000000001000 R08: ffff96f9132bb400 R09: 0000000000001000
>  R10: ffff96f8c1263c80 R11: 0000000000000003 R12: 0000000000001000
>  R13: ffff96f8fb75ade8 R14: fffffaaf5ca90000 R15: ffff96f8fb75ad00
>  FS:  0000000000000000(0000) GS:ffff9703cf0c0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000010c9ca003 CR4: 00000000001706b0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __die+0x1f/0x60
>   ? page_fault_oops+0x158/0x450
>   ? search_extable+0x22/0x30
>   ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
>   ? search_module_extables+0xe/0x40
>   ? exc_page_fault+0x62/0x120
>   ? asm_exc_page_fault+0x22/0x30
>   ? netfs_pgpriv2_write_to_the_cache+0x15a/0x3f0
>   ? netfs_pgpriv2_write_to_the_cache+0xf6/0x3f0
>   netfs_read_termination_worker+0x1f/0x60
>   process_one_work+0x138/0x2d0
>   worker_thread+0x2a5/0x3b0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xba/0xe0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x30/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note this patch doesn't apply to v6.14 as it was obsoleted by commit
> e2d46f2ec332 ("netfs: Change the read result collector to only use one
> work item").

Why can't we just take what is upstream instead?

Diverging from that ALWAYS ends up being more work and problems in the
end.  Only do so if you have no other choice.

thanks,

greg k-h

