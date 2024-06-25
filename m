Return-Path: <stable+bounces-55426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14B916384
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E1A28B5E2
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328D1494DE;
	Tue, 25 Jun 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znLkRqc8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070C147C96;
	Tue, 25 Jun 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308868; cv=none; b=UtsFHfa15AJ9NqlIozLaTb9BQNHuoU/QNchh//b/1ylwB0KUt/KyvntGd9blqo0F+8+kuEZOkj96oa2d68AnhYbjz/O4PCwVq5VahzPymWtwPU5lcbZYzhEwK3+pd/kvGuxHPcOx1kemEorH41uqjVFoLWrEO+SK5muuMdsJNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308868; c=relaxed/simple;
	bh=Ad30qBr6XBsx8nl2rzO3crijffW76o1LfIbe2qCtWQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDiNu4dhc4UXyIrKHAdy+fumzfA+/R/5aDTsQQZbACUpITHwmqtuzalYZ/HrafEwLpQCzJuIipsRLQ3P/6M5OF5a19xiIMGsV2MVHYcrIBxtGQiO1fwZ1kU7mAc0Qx7ZsNZxAgidNWBGVhedG2DS+pPmEcdwaB2nHz940IfiIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znLkRqc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19953C32786;
	Tue, 25 Jun 2024 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308868;
	bh=Ad30qBr6XBsx8nl2rzO3crijffW76o1LfIbe2qCtWQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=znLkRqc8axCuobaiTQTc4V+QsyR+re9uTOae3ahqmOMbJDGcfcbzwGkfZjK0Wn2ZE
	 qggRqZGhXOrTC7evEnILwWUTB6LWN6TiLE+dURKkRyNQzxZxQy88fcfY1Hn0iJOudC
	 S/IwYBqysmuvzPUWwaEDRBtaasccUeuDQLxBM7Fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zqiang <qiang.zhang1211@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 007/192] rcutorture: Make stall-tasks directly exit when rcutorture tests end
Date: Tue, 25 Jun 2024 11:31:19 +0200
Message-ID: <20240625085537.437914408@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 431315a563015f259b28e34c5842f6166439e969 ]

When the rcutorture tests start to exit, the rcu_torture_cleanup() is
invoked to stop kthreads and release resources, if the stall-task
kthreads exist, cpu-stall has started and the rcutorture.stall_cpu
is set to a larger value, the rcu_torture_cleanup() will be blocked
for a long time and the hung-task may occur, this commit therefore
add kthread_should_stop() to the loop of cpu-stall operation, when
rcutorture tests ends, no need to wait for cpu-stall to end, exit
directly.

Use the following command to test:

insmod rcutorture.ko torture_type=srcu fwd_progress=0 stat_interval=4
stall_cpu_block=1 stall_cpu=200 stall_cpu_holdoff=10 read_exit_burst=0
object_debug=1
rmmod rcutorture

[15361.918610] INFO: task rmmod:878 blocked for more than 122 seconds.
[15361.918613]       Tainted: G        W
6.8.0-rc2-yoctodev-standard+ #25
[15361.918615] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[15361.918616] task:rmmod           state:D stack:0     pid:878
tgid:878   ppid:773    flags:0x00004002
[15361.918621] Call Trace:
[15361.918623]  <TASK>
[15361.918626]  __schedule+0xc0d/0x28f0
[15361.918631]  ? __pfx___schedule+0x10/0x10
[15361.918635]  ? rcu_is_watching+0x19/0xb0
[15361.918638]  ? schedule+0x1f6/0x290
[15361.918642]  ? __pfx_lock_release+0x10/0x10
[15361.918645]  ? schedule+0xc9/0x290
[15361.918648]  ? schedule+0xc9/0x290
[15361.918653]  ? trace_preempt_off+0x54/0x100
[15361.918657]  ? schedule+0xc9/0x290
[15361.918661]  schedule+0xd0/0x290
[15361.918665]  schedule_timeout+0x56d/0x7d0
[15361.918669]  ? debug_smp_processor_id+0x1b/0x30
[15361.918672]  ? rcu_is_watching+0x19/0xb0
[15361.918676]  ? __pfx_schedule_timeout+0x10/0x10
[15361.918679]  ? debug_smp_processor_id+0x1b/0x30
[15361.918683]  ? rcu_is_watching+0x19/0xb0
[15361.918686]  ? wait_for_completion+0x179/0x4c0
[15361.918690]  ? __pfx_lock_release+0x10/0x10
[15361.918693]  ? __kasan_check_write+0x18/0x20
[15361.918696]  ? wait_for_completion+0x9d/0x4c0
[15361.918700]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918703]  ? wait_for_completion+0x179/0x4c0
[15361.918707]  ? _raw_spin_unlock_irq+0x36/0x50
[15361.918710]  ? wait_for_completion+0x179/0x4c0
[15361.918714]  ? trace_preempt_on+0x54/0x100
[15361.918718]  ? wait_for_completion+0x179/0x4c0
[15361.918723]  wait_for_completion+0x181/0x4c0
[15361.918728]  ? __pfx_wait_for_completion+0x10/0x10
[15361.918738]  kthread_stop+0x152/0x470
[15361.918742]  _torture_stop_kthread+0x44/0xc0 [torture
7af7f9cbba28271a10503b653f9e05d518fbc8c3]
[15361.918752]  rcu_torture_cleanup+0x2ac/0xe90 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918766]  ? __pfx_rcu_torture_cleanup+0x10/0x10 [rcutorture
f2cb1f556ee7956270927183c4c2c7749a336529]
[15361.918777]  ? __kasan_check_write+0x18/0x20
[15361.918781]  ? __mutex_unlock_slowpath+0x17c/0x670
[15361.918789]  ? __might_fault+0xcd/0x180
[15361.918793]  ? find_module_all+0x104/0x1d0
[15361.918799]  __x64_sys_delete_module+0x2a4/0x3f0
[15361.918803]  ? __pfx___x64_sys_delete_module+0x10/0x10
[15361.918807]  ? syscall_exit_to_user_mode+0x149/0x280

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index eb40c1f63a8b1..263457305d36a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2464,8 +2464,8 @@ static int rcu_torture_stall(void *args)
 			preempt_disable();
 		pr_alert("%s start on CPU %d.\n",
 			  __func__, raw_smp_processor_id());
-		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
-				    stop_at))
+		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(), stop_at) &&
+		       !kthread_should_stop())
 			if (stall_cpu_block) {
 #ifdef CONFIG_PREEMPTION
 				preempt_schedule();
-- 
2.43.0




