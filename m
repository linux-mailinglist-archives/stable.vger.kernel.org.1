Return-Path: <stable+bounces-159488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18338AF78DA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D55E4A3D8A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E42EFD8B;
	Thu,  3 Jul 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1PFO5qc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75F2EAD1B;
	Thu,  3 Jul 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554389; cv=none; b=X+BJyPqHAZ0nFVdpWNo9bwcz81dkQQ/tI7r42sX8Tjp49/euTb76qqh3NbBANQBm5ait9ZsprSUODrCR1pk9jHNJD1T/pkGs/kRxG/PPX0TZoMVObp0s8PrXQPMoQgeFnn9gwOFTyOk2MTr9f4pnHcsDAISKcSq7SMcqxkBpD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554389; c=relaxed/simple;
	bh=cJllJ3KsUXd9H7d77B7pWHBYuC1x85sCTLa2Hawxdkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLAGCt4+3MFalpYvXXKeDQ74djmTIwPjICuEh9pllyx3tgFVNcInfg0/+vSJmnJWQIKBzeaFwaX4tP6jmxdVRsYKz3yEtc+HMDJ1f+MlBkTXjDMnfJlWoY2kwluywWSfQN6GEgyLTYwyVP1u2COhTf/ERVlmcaRrl+9IXhfR1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1PFO5qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E88C4CEED;
	Thu,  3 Jul 2025 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554389;
	bh=cJllJ3KsUXd9H7d77B7pWHBYuC1x85sCTLa2Hawxdkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1PFO5qcXPLu+AArKhQ0cvALb4vilVCfL/RaIq1m1wNgajf0XjNoH2kLtDgkwarhB
	 lsyqwot4uB1E+0Eit/rmTD2chWa1PBuT0jQDuykfRkAWC3p2efW6XpGdD9k7jSDlyi
	 4Faq3YwqVwbT4dj2Wi3xMUccdGRPQFRsPS0Z3DIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12 172/218] drm/xe: Fix early wedge on GuC load failure
Date: Thu,  3 Jul 2025 16:42:00 +0200
Message-ID: <20250703144003.049775306@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

commit a39d082c3553d35b4fe5585e1e2fb221c130cae8 upstream.

When the GuC fails to load we declare the device wedged. However, the
very first GuC load attempt on GT0 (from xe_gt_init_hwconfig) is done
before the GT1 GuC objects are initialized, so things go bad when the
wedge code attempts to cleanup GT1. To fix this, check the initialization
status in the functions called during wedge.

Fixes: 7dbe8af13c18 ("drm/xe: Wedge the entire device")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org # v6.12+: 1e1981b16bb1: drm/xe: Fix taking invalid lock on wedge
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250611214453.1159846-2-daniele.ceraolospurio@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 0b93b7dcd9eb888a6ac7546560877705d4ad61bf)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c |    8 ++++++++
 drivers/gpu/drm/xe/xe_guc_ct.c              |    7 +++++--
 drivers/gpu/drm/xe/xe_guc_ct.h              |    5 +++++
 drivers/gpu/drm/xe/xe_guc_submit.c          |    3 +++
 4 files changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -138,6 +138,14 @@ void xe_gt_tlb_invalidation_reset(struct
 	int pending_seqno;
 
 	/*
+	 * we can get here before the CTs are even initialized if we're wedging
+	 * very early, in which case there are not going to be any pending
+	 * fences so we can bail immediately.
+	 */
+	if (!xe_guc_ct_initialized(&gt->uc.guc.ct))
+		return;
+
+	/*
 	 * CT channel is already disabled at this point. No new TLB requests can
 	 * appear.
 	 */
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -454,6 +454,9 @@ void xe_guc_ct_disable(struct xe_guc_ct
  */
 void xe_guc_ct_stop(struct xe_guc_ct *ct)
 {
+	if (!xe_guc_ct_initialized(ct))
+		return;
+
 	xe_guc_ct_set_state(ct, XE_GUC_CT_STATE_STOPPED);
 	stop_g2h_handler(ct);
 }
@@ -638,7 +641,7 @@ static int __guc_ct_send_locked(struct x
 	u16 seqno;
 	int ret;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	xe_gt_assert(gt, !g2h_len || !g2h_fence);
 	xe_gt_assert(gt, !num_g2h || !g2h_fence);
 	xe_gt_assert(gt, !g2h_len || num_g2h);
@@ -1209,7 +1212,7 @@ static int g2h_read(struct xe_guc_ct *ct
 	u32 action;
 	u32 *hxg;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	lockdep_assert_held(&ct->fast_lock);
 
 	if (ct->state == XE_GUC_CT_STATE_DISABLED)
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -23,6 +23,11 @@ void xe_guc_ct_snapshot_print(struct xe_
 void xe_guc_ct_snapshot_free(struct xe_guc_ct_snapshot *snapshot);
 void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p, bool atomic);
 
+static inline bool xe_guc_ct_initialized(struct xe_guc_ct *ct)
+{
+	return ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED;
+}
+
 static inline bool xe_guc_ct_enabled(struct xe_guc_ct *ct)
 {
 	return ct->state == XE_GUC_CT_STATE_ENABLED;
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1722,6 +1722,9 @@ int xe_guc_submit_reset_prepare(struct x
 {
 	int ret;
 
+	if (!guc->submission_state.initialized)
+		return 0;
+
 	/*
 	 * Using an atomic here rather than submission_state.lock as this
 	 * function can be called while holding the CT lock (engine reset



