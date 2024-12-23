Return-Path: <stable+bounces-105929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C2B9FB266
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E71606DC
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607F19E98B;
	Mon, 23 Dec 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gT1yOddJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673D12C544;
	Mon, 23 Dec 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970618; cv=none; b=GMs24HDWEj+yqybSwmTvlk+Rs2Vkji3DT2Qleo0oI8bzcujh84zs/+AhmeuVfvKd+cBYie2lCbAfL1fjKI+gFrzwN965vviF9PwvdTqyQ4GejG5vE1V1j6Nyb1fFcO2D+44Tb3z7IpNq7r+AgxQpmunkAwkklziuZYvoARZdICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970618; c=relaxed/simple;
	bh=A7Sf4tPyVqY0qV9R04JqN2KA+YqCUCP1k2HhzWFtCpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMocKskjG6csRHDUN9wU8ueIDsVgw8dG80jmONdpeudthnnPh/gtxYxGEVBakvsBjE6LTbJKfxOezvm028b6ucZZCYG9XSPk3YVGJAVwN1liS1jiDIJQy85hK5ERSUDYIeslFeE/BtwULGvUsle475GXeOu36yjwzpHdgHavcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gT1yOddJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A44C4CED3;
	Mon, 23 Dec 2024 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970617;
	bh=A7Sf4tPyVqY0qV9R04JqN2KA+YqCUCP1k2HhzWFtCpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT1yOddJIyQByUwcvoY8UmX9ZFFAdVp/NhCwNlKutW5NaqcvCo3gGmnHA+eT3runz
	 1POQqAep6YeHhVZ17BUqmjy1IQQFIgii6iiOOiyoq33NtaBzUyLIMBwWBUOotG/K6b
	 2l26DYwLE5/sDwfxNiNjCrcMpTjk6+GcxhkMwyv0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 19/83] net/smc: protect link down work from execute after lgr freed
Date: Mon, 23 Dec 2024 16:58:58 +0100
Message-ID: <20241223155354.377477545@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
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

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit 2b33eb8f1b3e8c2f87cfdbc8cc117f6bdfabc6ec ]

link down work may be scheduled before lgr freed but execute
after lgr freed, which may result in crash. So it is need to
hold a reference before shedule link down work, and put the
reference after work executed or canceled.

The relevant crash call stack as follows:
 list_del corruption. prev->next should be ffffb638c9c0fe20,
    but was 0000000000000000
 ------------[ cut here ]------------
 kernel BUG at lib/list_debug.c:51!
 invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 6 PID: 978112 Comm: kworker/6:119 Kdump: loaded Tainted: G #1
 Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 2221b89 04/01/2014
 Workqueue: events smc_link_down_work [smc]
 RIP: 0010:__list_del_entry_valid.cold+0x31/0x47
 RSP: 0018:ffffb638c9c0fdd8 EFLAGS: 00010086
 RAX: 0000000000000054 RBX: ffff942fb75e5128 RCX: 0000000000000000
 RDX: ffff943520930aa0 RSI: ffff94352091fc80 RDI: ffff94352091fc80
 RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb638c9c0fc38
 R10: ffffb638c9c0fc30 R11: ffffffffa015eb28 R12: 0000000000000002
 R13: ffffb638c9c0fe20 R14: 0000000000000001 R15: ffff942f9cd051c0
 FS:  0000000000000000(0000) GS:ffff943520900000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f4f25214000 CR3: 000000025fbae004 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  rwsem_down_write_slowpath+0x17e/0x470
  smc_link_down_work+0x3c/0x60 [smc]
  process_one_work+0x1ac/0x350
  worker_thread+0x49/0x2f0
  ? rescuer_thread+0x360/0x360
  kthread+0x118/0x140
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x1f/0x30

Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 10d79cb55528..890785d4f6b6 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1726,7 +1726,9 @@ void smcr_link_down_cond_sched(struct smc_link *lnk)
 {
 	if (smc_link_downing(&lnk->state)) {
 		trace_smcr_link_down(lnk, __builtin_return_address(0));
-		schedule_work(&lnk->link_down_wrk);
+		smcr_link_hold(lnk); /* smcr_link_put in link_down_wrk */
+		if (!schedule_work(&lnk->link_down_wrk))
+			smcr_link_put(lnk);
 	}
 }
 
@@ -1758,11 +1760,14 @@ static void smc_link_down_work(struct work_struct *work)
 	struct smc_link_group *lgr = link->lgr;
 
 	if (list_empty(&lgr->list))
-		return;
+		goto out;
 	wake_up_all(&lgr->llc_msg_waiter);
 	mutex_lock(&lgr->llc_conf_mutex);
 	smcr_link_down(link);
 	mutex_unlock(&lgr->llc_conf_mutex);
+
+out:
+	smcr_link_put(link); /* smcr_link_hold by schedulers of link_down_work */
 }
 
 static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
-- 
2.39.5




