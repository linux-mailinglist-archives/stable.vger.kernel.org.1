Return-Path: <stable+bounces-115676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA9A344F3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B05116AC9C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A626B0A5;
	Thu, 13 Feb 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tiooBo9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208F26B088;
	Thu, 13 Feb 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458866; cv=none; b=b69wHF6cOMeAEh3/bI1DyXGBdE9a4tWtM8WmMPHK5pmG8EyOU0252pqyvv0fUZ0bcITUCmr1sIYmmK4y/Qu+SgCDgxfanqtJgJ9DSYkXZWEk8bioxoL0oBCpMg0UXlfchB1A9daNXYG3CaEOIQOymYL+eQ+VAulAbBOUQ8Nr20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458866; c=relaxed/simple;
	bh=7w8fPeAclSGf1cCK78WcIy9/iim7jZukajokxKElrqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUrXgX+HVAp3GnrECP/Ve1tVm16JIS4qem1HDu0/czwqM3Kpq59BYwAtwUgGTCp2PG8fQ4hlXacYJ2HevoORQ+9XYISZC//5pmncBV6P2q85sRDmc+V2E9RKXVC/gTdn2vs9it353bMKycjCuSMYUxcyH6pRxbddrtEWN+Lwej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tiooBo9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB13C4CED1;
	Thu, 13 Feb 2025 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458866;
	bh=7w8fPeAclSGf1cCK78WcIy9/iim7jZukajokxKElrqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiooBo9sCP91YEYXIRo6J5ZCXBjAVj0VWjrgc8GkWbcny+nfgYvrOIcs1bTE4b6jj
	 QV41ct8RNcU802pjEomXAsx05P6cujxosxeawTnlWBuri8VqAYyJudtRAUgVgp4+u8
	 crsc/5zw7QQyySnvP2uqxjM+oaj7ovqCJawwfJIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 068/443] net/mlx5: use do_aux_work for PHC overflow checks
Date: Thu, 13 Feb 2025 15:23:53 +0100
Message-ID: <20250213142443.242361719@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vadim Fedorenko <vadfed@meta.com>

[ Upstream commit e61e6c415ba9ff2b32bb6780ce1b17d1d76238f1 ]

The overflow_work is using system wq to do overflow checks and updates
for PHC device timecounter, which might be overhelmed by other tasks.
But there is dedicated kthread in PTP subsystem designed for such
things. This patch changes the work queue to proper align with PTP
subsystem and to avoid overloading system work queue.
The adjfine() function acts the same way as overflow check worker,
we can postpone ptp aux worker till the next overflow period after
adjfine() was called.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250107104812.380225-1-vadfed@meta.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 24 ++++++++++---------
 include/linux/mlx5/driver.h                   |  1 -
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 4822d01123b45..d61a1a9297c90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
 	}
 }
 
-static void mlx5_timestamp_overflow(struct work_struct *work)
+static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_core_dev *mdev;
 	struct mlx5_timer *timer;
 	struct mlx5_clock *clock;
 	unsigned long flags;
 
-	timer = container_of(dwork, struct mlx5_timer, overflow_work);
-	clock = container_of(timer, struct mlx5_clock, timer);
+	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	timer = &clock->timer;
 
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
 		goto out;
@@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
 	write_sequnlock_irqrestore(&clock->lock, flags);
 
 out:
-	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
+	return timer->overflow_period;
 }
 
 static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
@@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	timer->cycles.mult = mult;
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+	ptp_schedule_worker(clock->ptp, timer->overflow_period);
 
 	return 0;
 }
@@ -852,6 +852,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
 	.settime64	= mlx5_ptp_settime,
 	.enable		= NULL,
 	.verify		= NULL,
+	.do_aux_work	= mlx5_timestamp_overflow,
 };
 
 static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
@@ -1052,12 +1053,11 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
 	do_div(ns, NSEC_PER_SEC / HZ);
 	timer->overflow_period = ns;
 
-	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
-	if (timer->overflow_period)
-		schedule_delayed_work(&timer->overflow_work, 0);
-	else
+	if (!timer->overflow_period) {
+		timer->overflow_period = HZ;
 		mlx5_core_warn(mdev,
-			       "invalid overflow period, overflow_work is not scheduled\n");
+			       "invalid overflow period, overflow_work is scheduled once per second\n");
+	}
 
 	if (clock_info)
 		clock_info->overflow_period = timer->overflow_period;
@@ -1172,6 +1172,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 
 	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
 	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+
+	if (clock->ptp)
+		ptp_schedule_worker(clock->ptp, 0);
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
@@ -1188,7 +1191,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	}
 
 	cancel_work_sync(&clock->pps_info.out_work);
-	cancel_delayed_work_sync(&clock->timer.overflow_work);
 
 	if (mdev->clock_info) {
 		free_page((unsigned long)mdev->clock_info);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index ea48eb879a0f5..fed666c5bd163 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -691,7 +691,6 @@ struct mlx5_timer {
 	struct timecounter         tc;
 	u32                        nominal_c_mult;
 	unsigned long              overflow_period;
-	struct delayed_work        overflow_work;
 };
 
 struct mlx5_clock {
-- 
2.39.5




