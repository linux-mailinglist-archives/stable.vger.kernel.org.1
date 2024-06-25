Return-Path: <stable+bounces-55710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14B9164D7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF968B20FFF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27825148319;
	Tue, 25 Jun 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7UXdRzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B13C90B;
	Tue, 25 Jun 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309709; cv=none; b=qIicrFS/LWw6InQdVQljnUp+crFV9LMNYL2H7aDwChm17F4nm3Cl6SZ3tRmURyy/KPLtteCFJouzwPvCbeJUAyebCHO+dLvKJoTWBR/3qKtCUwZXGTqD9ufs7j18p2MBdTh8zHZgWNpwgZj8vRvrIqUtbv8AWvyRTrCwrBzbc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309709; c=relaxed/simple;
	bh=IKukQdcYThoBjGTemwGtEU/HmEUi62gvC3dscKD5I30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdYa3/CtYcVFA9+z/fLa+YXWC1RgJp8Ue3qAH8efpRCaApIZMzoB2XdL9oq2OQqyHNONyacvEI+0NyBSh9ijJeiGi34aHkXIREqKWyON2r8sEF393irCyFnBuD/riek5uO+ch4hnXv5r3h3f9owXtRjuEfIfBXqGrsCjxUpxRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q7UXdRzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6063CC32781;
	Tue, 25 Jun 2024 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309709;
	bh=IKukQdcYThoBjGTemwGtEU/HmEUi62gvC3dscKD5I30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7UXdRzblbegTiPbmKqZEkZ5hPr/rYpw2UYw1/WBwCEb/NXP5FMkKBG60HeWVqw/4
	 DHVqd074w5mRp5tBFlKJ4UmRHvSDo9Iz70ht3ZazuuLv4d+ow/GBUnbrTA5C5r0TFs
	 3UTFQL2Gio5u2u3Wi0FyTxYax3V2QjUfDMbuEfgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com,
	David Ruth <druth@chromium.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/131] net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()
Date: Tue, 25 Jun 2024 11:33:41 +0200
Message-ID: <20240625085528.454005547@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
References: <20240625085525.931079317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ruth <druth@chromium.org>

[ Upstream commit d864319871b05fadd153e0aede4811ca7008f5d6 ]

syzbot found hanging tasks waiting on rtnl_lock [1]

A reproducer is available in the syzbot bug.

When a request to add multiple actions with the same index is sent, the
second request will block forever on the first request. This holds
rtnl_lock, and causes tasks to hang.

Return -EAGAIN to prevent infinite looping, while keeping documented
behavior.

[1]

INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0 state:D stack:23744 pid:5088 tgid:5088 ppid:2 flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5409 [inline]
__schedule+0xf15/0x5d00 kernel/sched/core.c:6746
__schedule_loop kernel/sched/core.c:6823 [inline]
schedule+0xe7/0x350 kernel/sched/core.c:6838
schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
__mutex_lock_common kernel/locking/mutex.c:684 [inline]
__mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
wiphy_lock include/net/cfg80211.h:5953 [inline]
reg_leave_invalid_chans net/wireless/reg.c:2466 [inline]
reg_check_chans_work+0x10a/0x10e0 net/wireless/reg.c:2481

Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
Signed-off-by: David Ruth <druth@chromium.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20240614190326.1349786-1-druth@chromium.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ecede5158a295..5a361deb804a3 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -834,7 +834,6 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	u32 max;
 
 	if (*index) {
-again:
 		rcu_read_lock();
 		p = idr_find(&idrinfo->action_idr, *index);
 
@@ -843,7 +842,7 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			 * index but did not assign the pointer yet.
 			 */
 			rcu_read_unlock();
-			goto again;
+			return -EAGAIN;
 		}
 
 		if (!p) {
-- 
2.43.0




