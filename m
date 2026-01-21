Return-Path: <stable+bounces-210704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDm9DuR4cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:57:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97B52789
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0BA57268F3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DA366DA2;
	Wed, 21 Jan 2026 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b2krvPEL"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94138B9AF;
	Wed, 21 Jan 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978402; cv=none; b=aLvoTR2xK3PIpAraDtvmpUQ5hN2zZTlEM/h09Sbci1MvqyWc2mK0O9FIURwWW8LrXgPuycHq4VSEcw0NUnZTYevPwh28LaizzYQ9k/HlfhkJ+6c4N6qBmgP+i5TzhV7iq9XSmKHwtDECeGXOMqzjrOEtArYtvqmtDiDRqQXQBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978402; c=relaxed/simple;
	bh=oV/b8+bprG/2ppb5+JhI3BURoaWKU1/zzpmE5b9cyGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jt2eQ8MbxnlfttxaJer7xW1RWLTP4AjkcXeL6+wdT3DV0cwraCwowwYgnGkZPE93vFCfCIvIAeObKqYku0T8kFWRDWtuoeaCnBY7GtY37RzFklYqBwb3yJa4LlK/g9yXM0a/n4mcL4BXnCIEZunhz5ZEYr2G0m1ToJJDzJyMS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b2krvPEL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SC
	UD4/weMkOy3cfmmEjb4WKtHyc7re9Vr9XkzonoqiA=; b=b2krvPELIfm29cAXAh
	3utUVDCzFyoU4ywvIi1ytkS1PI5AGFqQURM99/UVRP4qBwT8Q4L0loo595snTYi4
	bCkYjxcihod+W6W4gFsVsRob70lIw1AEYthQAj7eD1XRcIcUvHbyCwyNrC2zyVQv
	WJqALQr5dYboZ5Pa5XQUQeq/A=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHA9qRd3Bptl5aHg--.5890S2;
	Wed, 21 Jan 2026 14:52:02 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Zqiang <qiang.zhang@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH v6.6] usbnet: Fix using smp_processor_id() in preemptible code warnings
Date: Wed, 21 Jan 2026 14:51:59 +0800
Message-Id: <20260121065159.2877946-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHA9qRd3Bptl5aHg--.5890S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4Dtr45Zryxur13CrykXwb_yoW5Zr45pF
	WrCF17Ar4UXF1vqayfta1SqryrZa1DtrZrGrWS9wn8ZF9xA34UXF1093WI9F1jkr48WFy0
	qF4qv3y7Xw1rZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piG2NPUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hN4Emlwd5P89gAA30
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210704-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,kernel.org,redhat.com,163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 9A97B52789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zqiang <qiang.zhang@linux.dev>

[ Upstream commit 327cd4b68b4398b6c24f10eb2b2533ffbfc10185 ]

Syzbot reported the following warning:

BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
 usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
 usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
 usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
 __dev_set_mtu net/core/dev.c:9443 [inline]
 netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
 netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
 dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
 dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x42f/0x6a0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

For historical and portability reasons, the netif_rx() is usually
run in the softirq or interrupt context, this commit therefore add
local_bh_disable/enable() protection in the usbnet_resume_rx().

Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")
Link: https://syzkaller.appspot.com/bug?id=81f55dfa587ee544baaaa5a359a060512228c1e1
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Link: https://patch.msgid.link/20251011070518.7095-1-qiang.zhang@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ The context change is due to the commit 2c04d279e857
("net: usb: Convert tasklet API to new bottom half workqueue mechanism")
in v6.17 which is irrelevant to the logic of this patch.]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/net/usb/usbnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index e6a1864f03f9..763aa239c323 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -702,6 +702,7 @@ void usbnet_resume_rx(struct usbnet *dev)
 	struct sk_buff *skb;
 	int num = 0;
 
+	local_bh_disable();
 	clear_bit(EVENT_RX_PAUSED, &dev->flags);
 
 	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
@@ -710,6 +711,7 @@ void usbnet_resume_rx(struct usbnet *dev)
 	}
 
 	tasklet_schedule(&dev->bh);
+	local_bh_enable();
 
 	netif_dbg(dev, rx_status, dev->net,
 		  "paused rx queue disabled, %d skbs requeued\n", num);
-- 
2.34.1


