Return-Path: <stable+bounces-120603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1AFA50780
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB190174FAF
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC27250BE9;
	Wed,  5 Mar 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aeqEjSfL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873971C6FFE;
	Wed,  5 Mar 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197439; cv=none; b=QsRAH/rh+jetr0sYaHH0KjatU9uj04nzZXNc9yaHCFBbTmXza7UBAPDT6x1fnviUWfrKY6jH8S3An2yVOMZTBXKh3nzedJd0OCeU54+BGrIqNsQ0Ft8bYo0XFtTQXeUtWKqVKTQsjrdnp/sWgN/wfhs+Qr+a0wtiP50MXvg58YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197439; c=relaxed/simple;
	bh=lS8klghCrYjnDE84UafB7Ek+Me+xPcUvYHcQEALoU0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1V+88GDUXZpvc0Yww/JkVL3HQrS5m6X274DkfHKKFe8etycU8joD26yeoLsJxhjjdfZILnDvXNuu8weHmzzWDV1BvzXiOLiTBXssJL8WRRLZQOrLy+pESP1wYfVriF9ZydSf6q6wWspQ3Gygnt2zAO3piV+ZF1R7lh6muKn0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aeqEjSfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1C5C4CEE2;
	Wed,  5 Mar 2025 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197439;
	bh=lS8klghCrYjnDE84UafB7Ek+Me+xPcUvYHcQEALoU0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeqEjSfL8B5AHv8JaW617MHYG+54htzukOfDNcGLO/8+Pq9J3a4jc/n6vGLloyfAz
	 QhuWYqKpj1W4N5FMH2Skz+x7FEW720XUuRhZR86f6+SALq29AnLT9b6G7vdHv+DA1o
	 zpR2MOzyCeish3ousYSwFSlLeVMvXrDiboE1s7XU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1 156/176] usbnet: gl620a: fix endpoint checking in genelink_bind()
Date: Wed,  5 Mar 2025 18:48:45 +0100
Message-ID: <20250305174511.705246160@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit 1cf9631d836b289bd5490776551961c883ae8a4f upstream.

Syzbot reports [1] a warning in usb_submit_urb() triggered by
inconsistencies between expected and actually present endpoints
in gl620a driver. Since genelink_bind() does not properly
verify whether specified eps are in fact provided by the device,
in this case, an artificially manufactured one, one may get a
mismatch.

Fix the issue by resorting to a usbnet utility function
usbnet_get_endpoints(), usually reserved for this very problem.
Check for endpoints and return early before proceeding further if
any are missing.

[1] Syzbot report:
usb 5-1: Manufacturer: syz
usb 5-1: SerialNumber: syz
usb 5-1: config 0 descriptor??
gl620a 5-1:0.23 usb0: register 'gl620a' at usb-dummy_hcd.0-1, ...
------------[ cut here ]------------
usb 5-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 2 PID: 1841 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 2 UID: 0 PID: 1841 Comm: kworker/2:2 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
...
Call Trace:
 <TASK>
 usbnet_start_xmit+0x6be/0x2780 drivers/net/usb/usbnet.c:1467
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3606
 sch_direct_xmit+0x1ae/0xc30 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3827 [inline]
 __dev_queue_xmit+0x13d4/0x43e0 net/core/dev.c:4400
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 neigh_resolve_output net/core/neighbour.c:1514 [inline]
 neigh_resolve_output+0x5bc/0x950 net/core/neighbour.c:1494
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0xb1b/0x2070 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
 ip6_finish_output+0x3f9/0x1360 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x1f8/0x540 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 mld_sendpack+0x9f0/0x11d0 net/ipv6/mcast.c:1819
 mld_send_cr net/ipv6/mcast.c:2120 [inline]
 mld_ifc_work+0x740/0xca0 net/ipv6/mcast.c:2651
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Reported-by: syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d693c07c6f647e0388d3
Fixes: 47ee3051c856 ("[PATCH] USB: usbnet (5/9) module for genesys gl620a cables")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://patch.msgid.link/20250224172919.1220522-1-n.zhandarovich@fintech.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/gl620a.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -179,9 +179,7 @@ static int genelink_bind(struct usbnet *
 {
 	dev->hard_mtu = GL_RCV_BUF_SIZE;
 	dev->net->hard_header_len += 4;
-	dev->in = usb_rcvbulkpipe(dev->udev, dev->driver_info->in);
-	dev->out = usb_sndbulkpipe(dev->udev, dev->driver_info->out);
-	return 0;
+	return usbnet_get_endpoints(dev, intf);
 }
 
 static const struct driver_info	genelink_info = {



