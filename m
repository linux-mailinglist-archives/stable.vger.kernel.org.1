Return-Path: <stable+bounces-193430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D28BDC4A4D2
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7293A4F3677
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED027814A;
	Tue, 11 Nov 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMTmNItZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B2261573;
	Tue, 11 Nov 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823165; cv=none; b=T8Aa8U9YBaewGz11nVgnu3QhqWXzRPopq8VRnLEf9fbf/K5OJoyGrqMentD9kqi72pqfe7mqTzZaGDiceh+CGoCZ6YPL0Ngo6jNdT8h7qfupR9kz1LNP7sahJ3aHkmFclERIxGqVZGeK2dXSMKtdM6uEkVLFgIQJr+X9zwp+HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823165; c=relaxed/simple;
	bh=eEZyCzS7X1/A3Z6AT2BrKZmY/5iYdC/c1YMipdivT2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZgS/IFlgfO+LXHCxaaxwnVXkz5p2ijhvUDgvtgTyNYbDkxtYzCyzV+6yjsu3Wn9yGhHL6KD9xXZXj2pRQIgkmiFIy+G7Kfp1VBmOmUAN7kAd9NtyOjk5ANp2RY8BiDrwVm3683h826HA99n6kXNRDNcen+4RENZAO1VpkTzUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMTmNItZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE711C16AAE;
	Tue, 11 Nov 2025 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823165;
	bh=eEZyCzS7X1/A3Z6AT2BrKZmY/5iYdC/c1YMipdivT2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMTmNItZA/OQgul5T/3VSuxY+byfps9zX1h7JdJtc2MCf3h/6qYtOMGB4giKhlWQ5
	 01Gd3OV6jSKosXpD0rT7Te+Tdv2RjbXrg8DoyxrjTYjccsARUqQqphtUPMr7/9kZC6
	 W/5ThczjS3gsRp7sSFuGV9WW5stEVR6u/cnKW7+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 243/849] drm/xe/pf: Dont resume device from restart worker
Date: Tue, 11 Nov 2025 09:36:53 +0900
Message-ID: <20251111004542.310532549@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 9fd9f221440024b7451678898facfb34af054310 ]

The PF's restart worker shouldn't attempt to resume the device on
its own, since its goal is to finish PF and VFs reprovisioning on
the recently reset GuC. Take extra RPM reference while scheduling
a work and release it from the worker or when we cancel a work.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Link: https://lore.kernel.org/r/20250801142822.180530-4-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
index bdbd15f3afe38..c4dda87b47cc8 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf.c
@@ -55,7 +55,12 @@ static void pf_init_workers(struct xe_gt *gt)
 static void pf_fini_workers(struct xe_gt *gt)
 {
 	xe_gt_assert(gt, IS_SRIOV_PF(gt_to_xe(gt)));
-	disable_work_sync(&gt->sriov.pf.workers.restart);
+
+	if (disable_work_sync(&gt->sriov.pf.workers.restart)) {
+		xe_gt_sriov_dbg_verbose(gt, "pending restart disabled!\n");
+		/* release an rpm reference taken on the worker's behalf */
+		xe_pm_runtime_put(gt_to_xe(gt));
+	}
 }
 
 /**
@@ -207,8 +212,11 @@ static void pf_cancel_restart(struct xe_gt *gt)
 {
 	xe_gt_assert(gt, IS_SRIOV_PF(gt_to_xe(gt)));
 
-	if (cancel_work_sync(&gt->sriov.pf.workers.restart))
+	if (cancel_work_sync(&gt->sriov.pf.workers.restart)) {
 		xe_gt_sriov_dbg_verbose(gt, "pending restart canceled!\n");
+		/* release an rpm reference taken on the worker's behalf */
+		xe_pm_runtime_put(gt_to_xe(gt));
+	}
 }
 
 /**
@@ -226,9 +234,12 @@ static void pf_restart(struct xe_gt *gt)
 {
 	struct xe_device *xe = gt_to_xe(gt);
 
-	xe_pm_runtime_get(xe);
+	xe_gt_assert(gt, !xe_pm_runtime_suspended(xe));
+
 	xe_gt_sriov_pf_config_restart(gt);
 	xe_gt_sriov_pf_control_restart(gt);
+
+	/* release an rpm reference taken on our behalf */
 	xe_pm_runtime_put(xe);
 
 	xe_gt_sriov_dbg(gt, "restart completed\n");
@@ -247,8 +258,13 @@ static void pf_queue_restart(struct xe_gt *gt)
 
 	xe_gt_assert(gt, IS_SRIOV_PF(xe));
 
-	if (!queue_work(xe->sriov.wq, &gt->sriov.pf.workers.restart))
+	/* take an rpm reference on behalf of the worker */
+	xe_pm_runtime_get_noresume(xe);
+
+	if (!queue_work(xe->sriov.wq, &gt->sriov.pf.workers.restart)) {
 		xe_gt_sriov_dbg(gt, "restart already in queue!\n");
+		xe_pm_runtime_put(xe);
+	}
 }
 
 /**
-- 
2.51.0




