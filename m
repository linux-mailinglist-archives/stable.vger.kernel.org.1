Return-Path: <stable+bounces-220529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK5RNzE8o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9E1C690E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2EA73074BCD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA73CEAE4;
	Sat, 28 Feb 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8xjT1xd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A203CEB14;
	Sat, 28 Feb 2026 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300412; cv=none; b=X1cxV+foDwJAoiAiKOiVOSPJiNNqOf1QYHAD5eeTgCmEpsIssxje9uZ8pxNp1Tndx6cRukGXgcfUkumK9tnNT8/dWpDGX7lvzWH6ZwgoFbtzUcg0n+NSSsPB71G1eIPdVZ86lL16gZxX74MgUO1yEvGuCF0ZZIPdQsJbTj0J0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300412; c=relaxed/simple;
	bh=SrC1HFLWc/goT+GjWOISSRyEcH/2eDN1Im7wikqoMHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2FJ5s2OVlrvxYJR1yubJkMswk4zDJ39VWjUlpt45xKHJrZopbn8cV+fokGm4UfXh1w1vHb7eixAr7v3zaU+O89GhRveHrAd5JJKgFCajSrySuetC53VURQzS7MHWuB86x67NX6QWA7jePm9EFT+MZOFIRo8M55Cx7+Asw/SpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8xjT1xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C1C116D0;
	Sat, 28 Feb 2026 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300412;
	bh=SrC1HFLWc/goT+GjWOISSRyEcH/2eDN1Im7wikqoMHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8xjT1xdkoF+R02YuJD1nOPrCVjeGxlvWcGBiiwuwR0SAh3dWXjdd2P7nOTA0uSKO
	 aTu3lfGognugZqWEE/bU85WowR7KhJp2jrQfx3H9rYEszDXo+0foRQX4SQwn58eBHE
	 Y2iUwQr5EahU9fSnk9aLqm6DLsCR8mrX4s0g4Aczt51oV/FzE69N7yqRbVUnSnyIGE
	 Hrb6Xig83Dyk/xmakFHbXAYS19Xq36crhZ+B15ZpiIIeyR9y1kPl6nmTx2OsoIWElH
	 rkDxi2TzR0KIagb+pg+1RRSbl3MI90jSHNAsu9S/6JTcLLt6CkmhlVsPmGw3yeZc+v
	 deNfMzVBnu4Hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 450/844] xfrm: always flush state and policy upon NETDEV_UNREGISTER event
Date: Sat, 28 Feb 2026 12:26:03 -0500
Message-ID: <20260228173244.1509663-451-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220529-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable,881d65229ca4f9ae8c84];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3DD9E1C690E
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 4efa91a28576054aae0e6dad9cba8fed8293aef8 ]

syzbot is reporting that "struct xfrm_state" refcount is leaking.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is because commit d77e38e612a0 ("xfrm: Add an IPsec hardware
offloading API") implemented xfrm_dev_unregister() as no-op despite
xfrm_dev_state_add() from xfrm_state_construct() acquires a reference
to "struct net_device".
I guess that that commit expected that NETDEV_DOWN event is fired before
NETDEV_UNREGISTER event fires, and also assumed that xfrm_dev_state_add()
is called only if (dev->features & NETIF_F_HW_ESP) != 0.

Sabrina Dubroca identified steps to reproduce the same symptoms as below.

  echo 0 > /sys/bus/netdevsim/new_device
  dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
  ip xfrm state add src 192.168.13.1 dst 192.168.13.2 proto esp \
     spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128   \
     offload crypto dev $dev dir out
  ethtool -K $dev esp-hw-offload off
  echo 0 > /sys/bus/netdevsim/del_device

Like these steps indicate, the NETIF_F_HW_ESP bit can be cleared after
xfrm_dev_state_add() acquired a reference to "struct net_device".
Also, xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit
when acquiring a reference to "struct net_device".

Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
re-introduced the NETDEV_UNREGISTER event to xfrm_dev_event(), but that
commit for unknown reason chose to share xfrm_dev_down() between the
NETDEV_DOWN event and the NETDEV_UNREGISTER event.
I guess that that commit missed the behavior in the previous paragraph.

Therefore, we need to re-introduce xfrm_dev_unregister() in order to
release the reference to "struct net_device" by unconditionally flushing
state and policy.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29e..550457e4c4f01 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -544,6 +544,14 @@ static int xfrm_dev_down(struct net_device *dev)
 	return NOTIFY_DONE;
 }
 
+static int xfrm_dev_unregister(struct net_device *dev)
+{
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
+
+	return NOTIFY_DONE;
+}
+
 static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
@@ -556,8 +564,10 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
 		return xfrm_api_check(dev);
 
 	case NETDEV_DOWN:
-	case NETDEV_UNREGISTER:
 		return xfrm_dev_down(dev);
+
+	case NETDEV_UNREGISTER:
+		return xfrm_dev_unregister(dev);
 	}
 	return NOTIFY_DONE;
 }
-- 
2.51.0


