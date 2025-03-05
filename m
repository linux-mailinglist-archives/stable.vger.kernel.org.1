Return-Path: <stable+bounces-120582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED96A50765
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9CE174D2F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A02512C7;
	Wed,  5 Mar 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQm0DBCF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B6481DD;
	Wed,  5 Mar 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197379; cv=none; b=QhQbx6IhctevpFqTDopNcEaDxn//qKWWpyhkdI/g9UfguVUNC5OukxedKvzD5Bju3zZgcE8yV/NSVcg39VVZ5H4eKl+V/jWR12ehps1upgW+ssXygFPT+zNHHzTk+V7v9riAihGStqeLdW1OUdDK9OWRqtvBNvVXuaaSgDIyqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197379; c=relaxed/simple;
	bh=QAlQlWNjrbq68gxnP8uM9qU2/WV8Tl5B2am1f96d0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha8yGYpQwt4qYMMVa+ql+N8n0twf2pvgJaEMKg6OhqYruPsZO7drT6IlbJ5s1Ss8cHYUTqBYDvK/P7uag580rPikPFvU9sVhiaHkkNu3b1yiYUO8kqTrW4aLwUKcQoGnk2rJe0qSZTGCzVL6bFsI06koxc/T3Zy3Yb0YIEZHCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQm0DBCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D91C4CED1;
	Wed,  5 Mar 2025 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197378;
	bh=QAlQlWNjrbq68gxnP8uM9qU2/WV8Tl5B2am1f96d0Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQm0DBCFF8ldaU84GTCVNF7YXi27cb1XM6SaiECyr1GZSZYF6V14ktKozcUtwOslV
	 OaEUmaONWa43nA7Vp1AxZXvp6hT4u5V6CF88gRTLMiNd6OB4CMq45FABE9PaOzNnew
	 iS466C8UO3++UG8Iw2SpYy6wg4io1cBoL66rV0fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yishai Hadas <yishaih@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/176] RDMA/mlx5: Fix the recovery flow of the UMR QP
Date: Wed,  5 Mar 2025 18:47:53 +0100
Message-ID: <20250305174509.641746997@linuxfoundation.org>
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

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit d97505baea64d93538b16baf14ce7b8c1fbad746 ]

This patch addresses an issue in the recovery flow of the UMR QP,
ensuring tasks do not get stuck, as highlighted by the call trace [1].

During recovery, before transitioning the QP to the RESET state, the
software must wait for all outstanding WRs to complete.

Failing to do so can cause the firmware to skip sending some flushed
CQEs with errors and simply discard them upon the RESET, as per the IB
specification.

This race condition can result in lost CQEs and tasks becoming stuck.

To resolve this, the patch sends a final WR which serves only as a
barrier before moving the QP state to RESET.

Once a CQE is received for that final WR, it guarantees that no
outstanding WRs remain, making it safe to transition the QP to RESET and
subsequently back to RTS, restoring proper functionality.

Note:
For the barrier WR, we simply reuse the failed and ready WR.
Since the QP is in an error state, it will only receive
IB_WC_WR_FLUSH_ERR. However, as it serves only as a barrier we don't
care about its status.

[1]
INFO: task rdma_resource_l:1922 blocked for more than 120 seconds.
Tainted: G        W          6.12.0-rc7+ #1626
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rdma_resource_l state:D stack:0  pid:1922 tgid:1922  ppid:1369
     flags:0x00004004
Call Trace:
<TASK>
__schedule+0x420/0xd30
schedule+0x47/0x130
schedule_timeout+0x280/0x300
? mark_held_locks+0x48/0x80
? lockdep_hardirqs_on_prepare+0xe5/0x1a0
wait_for_completion+0x75/0x130
mlx5r_umr_post_send_wait+0x3c2/0x5b0 [mlx5_ib]
? __pfx_mlx5r_umr_done+0x10/0x10 [mlx5_ib]
mlx5r_umr_revoke_mr+0x93/0xc0 [mlx5_ib]
__mlx5_ib_dereg_mr+0x299/0x520 [mlx5_ib]
? _raw_spin_unlock_irq+0x24/0x40
? wait_for_completion+0xfe/0x130
? rdma_restrack_put+0x63/0xe0 [ib_core]
ib_dereg_mr_user+0x5f/0x120 [ib_core]
? lock_release+0xc6/0x280
destroy_hw_idr_uobject+0x1d/0x60 [ib_uverbs]
uverbs_destroy_uobject+0x58/0x1d0 [ib_uverbs]
uobj_destroy+0x3f/0x70 [ib_uverbs]
ib_uverbs_cmd_verbs+0x3e4/0xbb0 [ib_uverbs]
? __pfx_uverbs_destroy_def_handler+0x10/0x10 [ib_uverbs]
? __lock_acquire+0x64e/0x2080
? mark_held_locks+0x48/0x80
? find_held_lock+0x2d/0xa0
? lock_acquire+0xc1/0x2f0
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
? __fget_files+0xc3/0x1b0
ib_uverbs_ioctl+0xe7/0x170 [ib_uverbs]
? ib_uverbs_ioctl+0xcb/0x170 [ib_uverbs]
__x64_sys_ioctl+0x1b0/0xa70
do_syscall_64+0x6b/0x140
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f99c918b17b
RSP: 002b:00007ffc766d0468 EFLAGS: 00000246 ORIG_RAX:
     0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc766d0578 RCX:
     00007f99c918b17b
RDX: 00007ffc766d0560 RSI: 00000000c0181b01 RDI:
     0000000000000003
RBP: 00007ffc766d0540 R08: 00007f99c8f99010 R09:
     000000000000bd7e
R10: 00007f99c94c1c70 R11: 0000000000000246 R12:
     00007ffc766d0530
R13: 000000000000001c R14: 0000000040246a80 R15:
     0000000000000000
</TASK>

Fixes: 158e71bb69e3 ("RDMA/mlx5: Add a umr recovery flow")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://patch.msgid.link/27b51b92ec42dfb09d8096fcbd51878f397ce6ec.1737290141.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/umr.c | 83 +++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index fa000182d0b41..1a39e86178ece 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -199,30 +199,6 @@ void mlx5r_umr_resource_cleanup(struct mlx5_ib_dev *dev)
 	ib_dealloc_pd(dev->umrc.pd);
 }
 
-static int mlx5r_umr_recover(struct mlx5_ib_dev *dev)
-{
-	struct umr_common *umrc = &dev->umrc;
-	struct ib_qp_attr attr;
-	int err;
-
-	attr.qp_state = IB_QPS_RESET;
-	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
-	if (err) {
-		mlx5_ib_dbg(dev, "Couldn't modify UMR QP\n");
-		goto err;
-	}
-
-	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
-	if (err)
-		goto err;
-
-	umrc->state = MLX5_UMR_STATE_ACTIVE;
-	return 0;
-
-err:
-	umrc->state = MLX5_UMR_STATE_ERR;
-	return err;
-}
 
 static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 			       struct mlx5r_umr_wqe *wqe, bool with_data)
@@ -270,6 +246,61 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 	return err;
 }
 
+static int mlx5r_umr_recover(struct mlx5_ib_dev *dev, u32 mkey,
+			     struct mlx5r_umr_context *umr_context,
+			     struct mlx5r_umr_wqe *wqe, bool with_data)
+{
+	struct umr_common *umrc = &dev->umrc;
+	struct ib_qp_attr attr;
+	int err;
+
+	mutex_lock(&umrc->lock);
+	/* Preventing any further WRs to be sent now */
+	if (umrc->state != MLX5_UMR_STATE_RECOVER) {
+		mlx5_ib_warn(dev, "UMR recovery encountered an unexpected state=%d\n",
+			     umrc->state);
+		umrc->state = MLX5_UMR_STATE_RECOVER;
+	}
+	mutex_unlock(&umrc->lock);
+
+	/* Sending a final/barrier WR (the failed one) and wait for its completion.
+	 * This will ensure that all the previous WRs got a completion before
+	 * we set the QP state to RESET.
+	 */
+	err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context->cqe, wqe,
+				  with_data);
+	if (err) {
+		mlx5_ib_warn(dev, "UMR recovery post send failed, err %d\n", err);
+		goto err;
+	}
+
+	/* Since the QP is in an error state, it will only receive
+	 * IB_WC_WR_FLUSH_ERR. However, as it serves only as a barrier
+	 * we don't care about its status.
+	 */
+	wait_for_completion(&umr_context->done);
+
+	attr.qp_state = IB_QPS_RESET;
+	err = ib_modify_qp(umrc->qp, &attr, IB_QP_STATE);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RESET, err=%d\n", err);
+		goto err;
+	}
+
+	err = mlx5r_umr_qp_rst2rts(dev, umrc->qp);
+	if (err) {
+		mlx5_ib_warn(dev, "Couldn't modify UMR QP to RTS, err=%d\n", err);
+		goto err;
+	}
+
+	umrc->state = MLX5_UMR_STATE_ACTIVE;
+	return 0;
+
+err:
+	umrc->state = MLX5_UMR_STATE_ERR;
+	return err;
+}
+
 static void mlx5r_umr_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct mlx5_ib_umr_context *context =
@@ -334,9 +365,7 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
 		mlx5_ib_warn(dev,
 			"reg umr failed (%u). Trying to recover and resubmit the flushed WQEs, mkey = %u\n",
 			umr_context.status, mkey);
-		mutex_lock(&umrc->lock);
-		err = mlx5r_umr_recover(dev);
-		mutex_unlock(&umrc->lock);
+		err = mlx5r_umr_recover(dev, mkey, &umr_context, wqe, with_data);
 		if (err)
 			mlx5_ib_warn(dev, "couldn't recover UMR, err %d\n",
 				     err);
-- 
2.39.5




