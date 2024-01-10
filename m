Return-Path: <stable+bounces-10135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC082729A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7687A284534
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6B4C3C9;
	Mon,  8 Jan 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0dsjcRbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E247791;
	Mon,  8 Jan 2024 15:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BD4C433CA;
	Mon,  8 Jan 2024 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726870;
	bh=xqzyfjjnnJmNdwXODRLhkfW/AMgnxe3v6E7qD8q95jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0dsjcRbTlZMXrAOlclWnIO6pws8nA99Motq9WWQoMdG6c3iwMBCrzRTgVjBG8WdZR
	 PMauVKx/I1qQuoSKgig/29SUO0fNAGCl3Vvy0dQNN2E9MHpSbmsP4QtMmM/6lqBtGb
	 nJFWBgeuBR59jDTXmI8fBdBVx63zEyuRwUxRbTMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haren Myneni <haren@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 104/124] powerpc/pseries/vas: Migration suspend waits for no in-progress open windows
Date: Mon,  8 Jan 2024 16:08:50 +0100
Message-ID: <20240108150607.744047075@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Haren Myneni <haren@linux.ibm.com>

[ Upstream commit 0cf72f7f14d12cb065c3d01954cf42fc5638aa69 ]

The hypervisor returns migration failure if all VAS windows are not
closed. During pre-migration stage, vas_migration_handler() sets
migration_in_progress flag and closes all windows from the list.
The allocate VAS window routine checks the migration flag, setup
the window and then add it to the list. So there is possibility of
the migration handler missing the window that is still in the
process of setup.

t1: Allocate and open VAS	t2: Migration event
    window

lock vas_pseries_mutex
If migration_in_progress set
  unlock vas_pseries_mutex
  return
open window HCALL
unlock vas_pseries_mutex
Modify window HCALL		lock vas_pseries_mutex
setup window			migration_in_progress=true
				Closes all windows from the list
				// May miss windows that are
				// not in the list
				unlock vas_pseries_mutex
lock vas_pseries_mutex		return
if nr_closed_windows == 0
  // No DLPAR CPU or migration
  add window to the list
  // Window will be added to the
  // list after the setup is completed
  unlock vas_pseries_mutex
  return
unlock vas_pseries_mutex
Close VAS window
// due to DLPAR CPU or migration
return -EBUSY

This patch resolves the issue with the following steps:
- Set the migration_in_progress flag without holding mutex.
- Introduce nr_open_wins_progress counter in VAS capabilities
  struct
- This counter tracks the number of open windows are still in
  progress
- The allocate setup window thread closes windows if the migration
  is set and decrements nr_open_window_progress counter
- The migration handler waits for no in-progress open windows.

The code flow with the fix is as follows:

t1: Allocate and open VAS       t2: Migration event
    window

lock vas_pseries_mutex
If migration_in_progress set
   unlock vas_pseries_mutex
   return
open window HCALL
nr_open_wins_progress++
// Window opened, but not
// added to the list yet
unlock vas_pseries_mutex
Modify window HCALL		migration_in_progress=true
setup window			lock vas_pseries_mutex
				Closes all windows from the list
				While nr_open_wins_progress {
				    unlock vas_pseries_mutex
lock vas_pseries_mutex		    sleep
if nr_closed_windows == 0	    // Wait if any open window in
or migration is not started	    // progress. The open window
   // No DLPAR CPU or migration	    // thread closes the window without
   add window to the list	    // adding to the list and return if
   nr_open_wins_progress--	    // the migration is in progress.
   unlock vas_pseries_mutex
   return
Close VAS window
nr_open_wins_progress--
unlock vas_pseries_mutex
return -EBUSY			    lock vas_pseries_mutex
				}
				unlock vas_pseries_mutex
				return

Fixes: 37e6764895ef ("powerpc/pseries/vas: Add VAS migration handler")
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231125235104.3405008-1-haren@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/vas.c | 51 ++++++++++++++++++++++++----
 arch/powerpc/platforms/pseries/vas.h |  2 ++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index b1f25bac280b4..71d52a670d951 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -385,11 +385,15 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 * same fault IRQ is not freed by the OS before.
 	 */
 	mutex_lock(&vas_pseries_mutex);
-	if (migration_in_progress)
+	if (migration_in_progress) {
 		rc = -EBUSY;
-	else
+	} else {
 		rc = allocate_setup_window(txwin, (u64 *)&domain[0],
 				   cop_feat_caps->win_type);
+		if (!rc)
+			caps->nr_open_wins_progress++;
+	}
+
 	mutex_unlock(&vas_pseries_mutex);
 	if (rc)
 		goto out;
@@ -404,8 +408,17 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 		goto out_free;
 
 	txwin->win_type = cop_feat_caps->win_type;
-	mutex_lock(&vas_pseries_mutex);
+
 	/*
+	 * The migration SUSPEND thread sets migration_in_progress and
+	 * closes all open windows from the list. But the window is
+	 * added to the list after open and modify HCALLs. So possible
+	 * that migration_in_progress is set before modify HCALL which
+	 * may cause some windows are still open when the hypervisor
+	 * initiates the migration.
+	 * So checks the migration_in_progress flag again and close all
+	 * open windows.
+	 *
 	 * Possible to lose the acquired credit with DLPAR core
 	 * removal after the window is opened. So if there are any
 	 * closed windows (means with lost credits), do not give new
@@ -413,9 +426,11 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 * after the existing windows are reopened when credits are
 	 * available.
 	 */
-	if (!caps->nr_close_wins) {
+	mutex_lock(&vas_pseries_mutex);
+	if (!caps->nr_close_wins && !migration_in_progress) {
 		list_add(&txwin->win_list, &caps->list);
 		caps->nr_open_windows++;
+		caps->nr_open_wins_progress--;
 		mutex_unlock(&vas_pseries_mutex);
 		vas_user_win_add_mm_context(&txwin->vas_win.task_ref);
 		return &txwin->vas_win;
@@ -433,6 +448,12 @@ static struct vas_window *vas_allocate_window(int vas_id, u64 flags,
 	 */
 	free_irq_setup(txwin);
 	h_deallocate_vas_window(txwin->vas_win.winid);
+	/*
+	 * Hold mutex and reduce nr_open_wins_progress counter.
+	 */
+	mutex_lock(&vas_pseries_mutex);
+	caps->nr_open_wins_progress--;
+	mutex_unlock(&vas_pseries_mutex);
 out:
 	atomic_dec(&cop_feat_caps->nr_used_credits);
 	kfree(txwin);
@@ -937,14 +958,14 @@ int vas_migration_handler(int action)
 	struct vas_caps *vcaps;
 	int i, rc = 0;
 
+	pr_info("VAS migration event %d\n", action);
+
 	/*
 	 * NX-GZIP is not enabled. Nothing to do for migration.
 	 */
 	if (!copypaste_feat)
 		return rc;
 
-	mutex_lock(&vas_pseries_mutex);
-
 	if (action == VAS_SUSPEND)
 		migration_in_progress = true;
 	else
@@ -990,12 +1011,27 @@ int vas_migration_handler(int action)
 
 		switch (action) {
 		case VAS_SUSPEND:
+			mutex_lock(&vas_pseries_mutex);
 			rc = reconfig_close_windows(vcaps, vcaps->nr_open_windows,
 							true);
+			/*
+			 * Windows are included in the list after successful
+			 * open. So wait for closing these in-progress open
+			 * windows in vas_allocate_window() which will be
+			 * done if the migration_in_progress is set.
+			 */
+			while (vcaps->nr_open_wins_progress) {
+				mutex_unlock(&vas_pseries_mutex);
+				msleep(10);
+				mutex_lock(&vas_pseries_mutex);
+			}
+			mutex_unlock(&vas_pseries_mutex);
 			break;
 		case VAS_RESUME:
+			mutex_lock(&vas_pseries_mutex);
 			atomic_set(&caps->nr_total_credits, new_nr_creds);
 			rc = reconfig_open_windows(vcaps, new_nr_creds, true);
+			mutex_unlock(&vas_pseries_mutex);
 			break;
 		default:
 			/* should not happen */
@@ -1011,8 +1047,9 @@ int vas_migration_handler(int action)
 			goto out;
 	}
 
+	pr_info("VAS migration event (%d) successful\n", action);
+
 out:
-	mutex_unlock(&vas_pseries_mutex);
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/pseries/vas.h b/arch/powerpc/platforms/pseries/vas.h
index 7115043ec4883..45567cd131783 100644
--- a/arch/powerpc/platforms/pseries/vas.h
+++ b/arch/powerpc/platforms/pseries/vas.h
@@ -91,6 +91,8 @@ struct vas_cop_feat_caps {
 struct vas_caps {
 	struct vas_cop_feat_caps caps;
 	struct list_head list;	/* List of open windows */
+	int nr_open_wins_progress;	/* Number of open windows in */
+					/* progress. Used in migration */
 	int nr_close_wins;	/* closed windows in the hypervisor for DLPAR */
 	int nr_open_windows;	/* Number of successful open windows */
 	u8 feat;		/* Feature type */
-- 
2.43.0




