Return-Path: <stable+bounces-117490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E7A3B6D8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D0A178DFC
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294C1D90D9;
	Wed, 19 Feb 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fWy1aEwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54081CD213;
	Wed, 19 Feb 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955449; cv=none; b=g3cbTCiX/EyV0U953sDMvy2QxpfFnnz1pbfIoz0OyqHqkeollcivGw0Cyl0Q6bAk72JiGIXs/5qJOrXXvZIBJXvbEVfpflTJtY/fdhH0P2/vdWR3ZMdthBopCYWLz8GqfHrPfQL11FE85jw05skDGTWr2Ja53bZvcpn6hkq0tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955449; c=relaxed/simple;
	bh=keiXZe/JblW9/8pZjkV1xPDkcR6mOv5AEJPC2TsnDzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N74R0fCuKYuLz4MVlRm33JXhjw7Jp5J7xVqwc0h/OMWbLNIIzPt5jF1WBaUb1c+W4RHkxqFvS9BpNalbzaKidsUbXLRsoRfyF7QmxpycihFw3lew/6LpDnukPJGGa+0OeZSCqdEiF7iOMIQD4KuW6D7TjfXvZsU8wBMcikPxK60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWy1aEwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277ADC4CED1;
	Wed, 19 Feb 2025 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955449;
	bh=keiXZe/JblW9/8pZjkV1xPDkcR6mOv5AEJPC2TsnDzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWy1aEwaNaTapnwbS6q6jucT0EwcYPoHfXLGD0lKT4s6WXbde6YOg3xCT+fyJPhlY
	 U4/VSNF69zz6hcYy53TUVh4zt0T2fn7yx7XYjn/lK6/a1gU3vaPdzJfIGwBVjq5GoY
	 zpcEgvdgNBMgAH5DR8/BmL4WbtuV3SfBgoo1Aghc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/152] vxlan: check vxlan_vnigroup_init() return value
Date: Wed, 19 Feb 2025 09:27:03 +0100
Message-ID: <20250219082550.435475211@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5805402dcc56241987bca674a1b4da79a249bab7 ]

vxlan_init() must check vxlan_vnigroup_init() success
otherwise a crash happens later, spotted by syzbot.

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000160-0x0000000000000167]
CPU: 0 UID: 0 PID: 7313 Comm: syz-executor147 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:vxlan_vnigroup_uninit+0x89/0x500 drivers/net/vxlan/vxlan_vnifilter.c:912
Code: 00 48 8b 44 24 08 4c 8b b0 98 41 00 00 49 8d 86 60 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 04 00 00 49 8b 86 60 01 00 00 48 ba 00 00 00
RSP: 0018:ffffc9000cc1eea8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8672effb
RDX: 000000000000002c RSI: ffffffff8672ecb9 RDI: ffff8880461b4f18
RBP: ffff8880461b4ef4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000020000
R13: ffff8880461b0d80 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fecfa95d6c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecfa95cfb8 CR3: 000000004472c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  vxlan_uninit+0x1ab/0x200 drivers/net/vxlan/vxlan_core.c:2942
  unregister_netdevice_many_notify+0x12d6/0x1f30 net/core/dev.c:11824
  unregister_netdevice_many net/core/dev.c:11866 [inline]
  unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11736
  register_netdevice+0x1829/0x1eb0 net/core/dev.c:10901
  __vxlan_dev_create+0x7c6/0xa30 drivers/net/vxlan/vxlan_core.c:3981
  vxlan_newlink+0xd1/0x130 drivers/net/vxlan/vxlan_core.c:4407
  rtnl_newlink_create net/core/rtnetlink.c:3795 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3906 [inline]

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67a9d9b4.050a0220.110943.002d.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20250210105242.883482-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ee02a92338da1..64db3e98a1b66 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2966,8 +2966,11 @@ static int vxlan_init(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
-		vxlan_vnigroup_init(vxlan);
+	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		err = vxlan_vnigroup_init(vxlan);
+		if (err)
+			return err;
+	}
 
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 	if (!dev->tstats) {
-- 
2.39.5




