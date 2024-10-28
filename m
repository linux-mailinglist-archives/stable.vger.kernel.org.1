Return-Path: <stable+bounces-89012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79939B2DB2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5608DB23884
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA721DF275;
	Mon, 28 Oct 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX7WjG2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C01DF24B;
	Mon, 28 Oct 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112725; cv=none; b=uo067HRIgJgLTuQT2nQOS6bGnr25zr2DTw/THYQCxj25ByKTp7l8PWWf0v0wh40VTHKzkFPiLYqsExb+pBQRPb7eF4Vz3h8mrOOA2OiD9V1e+bI4ODhWoWhKT7IO1rUDicTsGI2EJmwXhAPRpQcWkh/FjYlIfATVStm3o2KdTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112725; c=relaxed/simple;
	bh=awgu0iGo3uoDSu5mVHC0L1PH/1s2sI1wy6Q5lwygyvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWk76Rog3n5hxKRqc1/EFj8Dy1TirX/PH4w2kYC9rNxMgNGWF1ZxWQpBqw5n7pu51hHTj3a1fC6pPY1fL18T4Z7Hl9S2PmvzBXdeDzK1g3wI7rmpSy5evR3F0/6D4jUn4/AbXjDOxYIiFoAYZWOQrmOqAZbd+DpQySCF3sK+vOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX7WjG2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF7FC4CEE7;
	Mon, 28 Oct 2024 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112725;
	bh=awgu0iGo3uoDSu5mVHC0L1PH/1s2sI1wy6Q5lwygyvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PX7WjG2EQb65tx4JZ+/EjISmEOSLCaG59iP666KjYqqi2w4oSMKjIfrf6H2mkwE78
	 TkzhtN+Rtoh7YTvlr5cP7FXTbsuhR4a4exHnHkRcA3dCCDe5NYo6LcXg/TZuMFDEMg
	 F030fyJflF1wSHw0r/77X9JX6NpEXmYqaqLXhrZUpyardsUnhEpjH7mFwd/yHBUEEw
	 AoN/k9oMyNQm7qfS3eDJyYYIMeWtreRq/aRVar8XrMK5yFIjqYIkKuWtyMpZAX7Qyn
	 pkq2KcZ5rf2pEg+EkbSoUioDN55vFyF27mhC3jj4xhhLFUQTGvQLns1EoAZswsS/6e
	 RChDO457PvDFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Alex Zuo <alex.zuo@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 30/32] drm/xe: Handle unreliable MMIO reads during forcewake
Date: Mon, 28 Oct 2024 06:50:12 -0400
Message-ID: <20241028105050.3559169-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 69418db678567bdf9a4992c83d448da462ffa78c ]

In some cases, when the driver attempts to read an MMIO register,
the hardware may return 0xFFFFFFFF. The current force wake path
code treats this as a valid response, as it only checks the BIT.
However, 0xFFFFFFFF should be considered an invalid value, indicating
a potential issue. To address this, we should add a log entry to
highlight this condition and return failure.
The force wake failure log level is changed from notice to err
to match the failure return value.

v2 (Matt Brost):
  - set ret value (-EIO) to kick the error to upper layers
v3 (Rodrigo):
  - add commit message for the log level promotion from notice to err
v4:
  - update reviewed info

Suggested-by: Alex Zuo <alex.zuo@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Acked-by: Badal Nilawar <badal.nilawar@intel.com>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241017221547.1564029-1-shuicheng.lin@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit a9fbeabe7226a3bf90f82d0e28a02c18e3c67447)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_force_wake.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_force_wake.c b/drivers/gpu/drm/xe/xe_force_wake.c
index b263fff152737..7d9fc489dcb81 100644
--- a/drivers/gpu/drm/xe/xe_force_wake.c
+++ b/drivers/gpu/drm/xe/xe_force_wake.c
@@ -115,9 +115,15 @@ static int __domain_wait(struct xe_gt *gt, struct xe_force_wake_domain *domain,
 			     XE_FORCE_WAKE_ACK_TIMEOUT_MS * USEC_PER_MSEC,
 			     &value, true);
 	if (ret)
-		xe_gt_notice(gt, "Force wake domain %d failed to ack %s (%pe) reg[%#x] = %#x\n",
-			     domain->id, str_wake_sleep(wake), ERR_PTR(ret),
-			     domain->reg_ack.addr, value);
+		xe_gt_err(gt, "Force wake domain %d failed to ack %s (%pe) reg[%#x] = %#x\n",
+			  domain->id, str_wake_sleep(wake), ERR_PTR(ret),
+			  domain->reg_ack.addr, value);
+	if (value == ~0) {
+		xe_gt_err(gt,
+			  "Force wake domain %d: %s. MMIO unreliable (forcewake register returns 0xFFFFFFFF)!\n",
+			  domain->id, str_wake_sleep(wake));
+		ret = -EIO;
+	}
 
 	return ret;
 }
-- 
2.43.0


