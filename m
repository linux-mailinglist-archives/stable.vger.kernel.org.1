Return-Path: <stable+bounces-206297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4717D03470
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5665301D5F8
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00F3D6488;
	Thu,  8 Jan 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1f9RFGao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB93D605C;
	Thu,  8 Jan 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866937; cv=none; b=hH7JYwoECs03GYXr3g+kreRqE1SAA3Hz9IztPE1qgEuegxDZDJUcUjtofuHqUeVUzVykX16snYxnFfptfK6hiypibqxhucDAbft/Dvr2BDjo2Jw0it/wRzPRqF3ANITDbtKRpOj85z81aP0QzESiyss9v7wJgVaEHCGqIgBPnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866937; c=relaxed/simple;
	bh=kWBrEl9Yf0lKqjUjkxR3fjkBSItC7QpKJFB09llNT8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKLa9lfVGXZePIC6gQ3jjOs8719JNeVGX4lFdptj4Joje+KgRMZbl4n+S4WXygSgCFDwUAgcp7uQdehU+22b7jBtcX5sTugeFp46n0Vdz6ANm2dh7ng2arTUG8hkYUDq+JNorJXknOCa9gfOZ2P/CFfs4G13DLgFaQ0AWEhzn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1f9RFGao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284D8C116C6;
	Thu,  8 Jan 2026 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767866936;
	bh=kWBrEl9Yf0lKqjUjkxR3fjkBSItC7QpKJFB09llNT8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1f9RFGaoEe8i0zFCsDza2R7t5/gIkIoPSSIs4zW3RRPN9QEpnYjcD8OzH8QieE3Ie
	 S54AfUUDc6skvLMJAgy8aNXAsbdj3x5+H9qLC/ol36x38qAPrVdeWjt+dIHql7oDZl
	 Sp6fk+r8VuZGLJo3ieLppusgdp3Dn0YljqqpsJAo=
Date: Thu, 8 Jan 2026 11:08:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Sharma <black.hawk@163.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zqiang <qiang.zhang@linux.dev>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v6.12] usbnet: Fix using smp_processor_id() in
 preemptible code warnings
Message-ID: <2026010838-epidural-reflex-d9e7@gregkh>
References: <20260107081855.743357-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107081855.743357-1-black.hawk@163.com>

On Wed, Jan 07, 2026 at 04:18:55PM +0800, Rahul Sharma wrote:
> From: Zqiang <qiang.zhang@linux.dev>
> 
> Syzbot reported the following warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
> caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
> CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary)
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
>  usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
>  usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
>  usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
>  __dev_set_mtu net/core/dev.c:9443 [inline]
>  netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
>  netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
>  dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
>  dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
>  dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
>  sock_do_ioctl+0x19d/0x280 net/socket.c:1204
>  sock_ioctl+0x42f/0x6a0 net/socket.c:1311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl fs/ioctl.c:892 [inline]
>  __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> For historical and portability reasons, the netif_rx() is usually
> run in the softirq or interrupt context, this commit therefore add
> local_bh_disable/enable() protection in the usbnet_resume_rx().
> 
> Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
> Link: https://syzkaller.appspot.com/bug?id=81f55dfa587ee544baaaa5a359a060512228c1e1
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Link: https://patch.msgid.link/20251011070518.7095-1-qiang.zhang@linux.dev
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [ The context change is due to the commit 2c04d279e857
> ("net: usb: Convert tasklet API to new bottom half workqueue mechanism")
> in v6.17 which is irrelevant to the logic of this patch.]
> Signed-off-by: Rahul Sharma <black.hawk@163.com>
> ---
>  drivers/net/usb/usbnet.c | 2 ++
>  1 file changed, 2 insertions(+)

What is the git id of this commit in Linus's tree?

thanks,

greg k-h

