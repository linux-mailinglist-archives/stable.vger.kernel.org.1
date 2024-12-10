Return-Path: <stable+bounces-100356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C39EABF9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC60F1649C9
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BE238722;
	Tue, 10 Dec 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3t9p8fj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AD234985
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822923; cv=none; b=PlvJiOuPl6P1zMIJvmFtjDRgLWg72+cBKRk/s6tCRSWzPYTnFelENvvthrwKSeKUjdN4lBMsDEfZMWpNdvf06ic4g684zUOIrft0ikP9WPuwl1wppC6bK2wQ98Ocpe4Wgu9dZrQUyrKlwgB3Tyvozuu50K7NWiOc2k0v8+i92xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822923; c=relaxed/simple;
	bh=Oilyyc9ixuKivUuDfRPhVc9rWFfhGYPy3aRbqZfLnH8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EqGI4Se2PyIg0UaasjKLWqOhnLOpOa4Q8HntXaqQed4taROvexurO4eBPQNOH2RW8XtOvsJD/q064oMjN2Wzlb71sd6THvRQ8mlaXmbFc2B9iYuEgP4J30qKvaPTrAmlSaw6mS99UqrsMTfHJqR4opPeGt1mHGJOTN715Bsn4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3t9p8fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B440AC4CEE0;
	Tue, 10 Dec 2024 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733822923;
	bh=Oilyyc9ixuKivUuDfRPhVc9rWFfhGYPy3aRbqZfLnH8=;
	h=Subject:To:Cc:From:Date:From;
	b=K3t9p8fjBGHTWAFUlMKo+sKXvjjFiG/s2CQ4E4M1gHB1gYXrOI3g0d64e04q8un31
	 zAfJB2r7rh2f1d4gP1QhL7gdgzw87JohRimQjkpACP3MmBAclLNreSApnmTqvhFx6r
	 BF+D9UpPc5ZHU+cpOT0Sh51/g0jXEuqUl467NDSI=
Subject: FAILED: patch "[PATCH] drm/dp_mst: Fix resetting msg rx state after topology removal" failed to apply to 5.15-stable tree
To: imre.deak@intel.com,lyude@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:28:07 +0100
Message-ID: <2024121006-ivy-curvy-63a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a6fa67d26de385c3c7a23c1e109a0e23bfda4ec7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121006-ivy-curvy-63a6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6fa67d26de385c3c7a23c1e109a0e23bfda4ec7 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Tue, 3 Dec 2024 18:02:17 +0200
Subject: [PATCH] drm/dp_mst: Fix resetting msg rx state after topology removal

If the MST topology is removed during the reception of an MST down reply
or MST up request sideband message, the
drm_dp_mst_topology_mgr::up_req_recv/down_rep_recv states could be reset
from one thread via drm_dp_mst_topology_mgr_set_mst(false), racing with
the reading/parsing of the message from another thread via
drm_dp_mst_handle_down_rep() or drm_dp_mst_handle_up_req(). The race is
possible since the reader/parser doesn't hold any lock while accessing
the reception state. This in turn can lead to a memory corruption in the
reader/parser as described by commit bd2fccac61b4 ("drm/dp_mst: Fix MST
sideband message body length check").

Fix the above by resetting the message reception state if needed before
reading/parsing a message. Another solution would be to hold the
drm_dp_mst_topology_mgr::lock for the whole duration of the message
reception/parsing in drm_dp_mst_handle_down_rep() and
drm_dp_mst_handle_up_req(), however this would require a bigger change.
Since the fix is also needed for stable, opting for the simpler solution
in this patch.

Cc: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org>
Fixes: 1d082618bbf3 ("drm/display/dp_mst: Fix down/up message handling after sink disconnect")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13056
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241203160223.2926014-2-imre.deak@intel.com

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index e6ee180815b2..1475aa95ab6b 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3700,8 +3700,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		ret = 0;
 		mgr->payload_id_table_cleared = false;
 
-		memset(&mgr->down_rep_recv, 0, sizeof(mgr->down_rep_recv));
-		memset(&mgr->up_req_recv, 0, sizeof(mgr->up_req_recv));
+		mgr->reset_rx_state = true;
 	}
 
 out_unlock:
@@ -3859,6 +3858,11 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_resume);
 
+static void reset_msg_rx_state(struct drm_dp_sideband_msg_rx *msg)
+{
+	memset(msg, 0, sizeof(*msg));
+}
+
 static bool
 drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
 		      struct drm_dp_mst_branch **mstb)
@@ -4141,6 +4145,17 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	return 0;
 }
 
+static void update_msg_rx_state(struct drm_dp_mst_topology_mgr *mgr)
+{
+	mutex_lock(&mgr->lock);
+	if (mgr->reset_rx_state) {
+		mgr->reset_rx_state = false;
+		reset_msg_rx_state(&mgr->down_rep_recv);
+		reset_msg_rx_state(&mgr->up_req_recv);
+	}
+	mutex_unlock(&mgr->lock);
+}
+
 /**
  * drm_dp_mst_hpd_irq_handle_event() - MST hotplug IRQ handle MST event
  * @mgr: manager to notify irq for.
@@ -4175,6 +4190,8 @@ int drm_dp_mst_hpd_irq_handle_event(struct drm_dp_mst_topology_mgr *mgr, const u
 		*handled = true;
 	}
 
+	update_msg_rx_state(mgr);
+
 	if (esi[1] & DP_DOWN_REP_MSG_RDY) {
 		ret = drm_dp_mst_handle_down_rep(mgr);
 		*handled = true;
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index f6a1cbb0f600..a80ba457a858 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -699,6 +699,13 @@ struct drm_dp_mst_topology_mgr {
 	 */
 	bool payload_id_table_cleared : 1;
 
+	/**
+	 * @reset_rx_state: The down request's reply and up request message
+	 * receiver state must be reset, after the topology manager got
+	 * removed. Protected by @lock.
+	 */
+	bool reset_rx_state : 1;
+
 	/**
 	 * @payload_count: The number of currently active payloads in hardware. This value is only
 	 * intended to be used internally by MST helpers for payload tracking, and is only safe to


