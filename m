Return-Path: <stable+bounces-69086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62A953561
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C248B21031
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC619FA7A;
	Thu, 15 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="se+O8Mwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0F1DFFB;
	Thu, 15 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732622; cv=none; b=QcZiS9gNzlhHDwdg4C5oTV45LfInmOnJg1DevWToD6xzFz/KidMlKvbR5Sl3vHIuEecMPEpV1sa8Zq88t3SwxcXohrGSKFyFONw29KwF1hytzxGyK2ZXajaZjaOFaBqLN13bSx03SlXCFqAM/US5YsFWPUrMRM0WqiGY5+7un6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732622; c=relaxed/simple;
	bh=UNsHnYTv+M3IL9u8wJWlzGX9k4pkKASK+dEhBFQR+lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf5TUlqzdMyvx4bqrNLcxrrKBnVy8g64/u57XKgLAg0kwvz2TaLaIixSAs6yJb0LwaSZrSqP5MaXCja5Qz9YQl21NWU2felkMH0W1XMkyN9Jhekhttv2gintE1aUgZKlt0FFbQKxQXzvZ38aHa/kOUtJlyS9pJPzWGXqNQMY7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=se+O8Mwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67651C32786;
	Thu, 15 Aug 2024 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732621;
	bh=UNsHnYTv+M3IL9u8wJWlzGX9k4pkKASK+dEhBFQR+lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se+O8Mwm/5xMwBwTNi/qGP4xdy/Sel/+k/5Co3RiK0vV9egSWItOB648VCS44juOE
	 LWMmx0POrmYGsogYyTJLmldthDjzimQFFrKKFUXbH1qd/bfEGEuNOesF1A47FCYNw4
	 OgWa3CxJvtgAc56R1X7pV8d/Qq5hGskITJGtMlAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Xin Long <lucien.xin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 235/352] sched: act_ct: take care of padding in struct zones_ht_key
Date: Thu, 15 Aug 2024 15:25:01 +0200
Message-ID: <20240815131928.519329714@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2191a54f63225b548fd8346be3611c3219a24738 ]

Blamed commit increased lookup key size from 2 bytes to 16 bytes,
because zones_ht_key got a struct net pointer.

Make sure rhashtable_lookup() is not using the padding bytes
which are not initialized.

 BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
  rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
  __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
  rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
  tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
  tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
  tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
  tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
  tcf_action_add net/sched/act_api.c:2061 [inline]
  tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
  rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
  __sys_sendmsg net/socket.c:2680 [inline]
  __do_sys_sendmsg net/socket.c:2689 [inline]
  __se_sys_sendmsg net/socket.c:2687 [inline]
  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
  x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:47
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable key created at:
  tcf_ct_flow_table_get+0x4a/0x2260 net/sched/act_ct.c:324
  tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408

Fixes: 88c67aeb1407 ("sched: act_ct: add netns into the key of tcf_ct_flow_table")
Reported-by: syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index a59a8ad387211..4ea7a81707f3f 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -41,6 +41,8 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
 	struct net *net;
 	u16 zone;
+	/* Note : pad[] must be the last field. */
+	u8  pad[];
 };
 
 struct tcf_ct_flow_table {
@@ -57,7 +59,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
 	.key_offset = offsetof(struct tcf_ct_flow_table, key),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
+	.key_len = offsetof(struct zones_ht_key, pad),
 	.automatic_shrinking = true,
 };
 
-- 
2.43.0




