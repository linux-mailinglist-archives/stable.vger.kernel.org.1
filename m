Return-Path: <stable+bounces-89011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F659B2DAF
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B6D1F21CB7
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7521DF251;
	Mon, 28 Oct 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxkUIF3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBB1DF249;
	Mon, 28 Oct 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112722; cv=none; b=kDK2jc3pfCGvVzaY/PEAAxxyvV6AcVGBq4sJUtJWVtjaE0bCX55fzx55TiAkMx5PVLANOJkFPxSiKAfFOzJXx9ppyFtOzPg3XqugHCjcZHTFBk7G6E/78XqodojX2xtYUQexxFmk309oSpr3Ev8G4RoKUtXmiVMMNExH6nV8xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112722; c=relaxed/simple;
	bh=6Qno+30D6RM+lx+mo3VjfYuDM+GRGmcC8S24sQmYI+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yroz/Uwdq7CgQaRezhdpzFB0QDQE2mfjfS/coq0jQOgE/zbw8acGE2vBT4NMSmFw6HIUG1TVDhxMrAEcQvQE4wTbW+LQRmT6K37QFXwCyAW/D/kelkvx+dYHaV6Pa4bsVFpGMyIBp697dtf2oLhxaIJ5utIX9/6PffCbevdUPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxkUIF3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FF2C4CEE3;
	Mon, 28 Oct 2024 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112722;
	bh=6Qno+30D6RM+lx+mo3VjfYuDM+GRGmcC8S24sQmYI+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxkUIF3Msw93nLh4g27+txK3Ti+BJCEyhnhljycGQH4ze8+OcAIvcdm2ZS120OXBo
	 N8QslyB+MNovnHOe54kf20MCHOFqh/0/KYETSG4RUi5BZ7nI03tqrp4mcXmLf8FHuZ
	 yyGzeRm5JIhjqkn2VhI9PFo3KaMKs9Jcupfjkz5DCOaNHmuuDblpdrE4cLEqt/eNMS
	 xDCGNYpMlhk10MQERk40fvPIi4Cjg6D9eaoN36JCm29kvauChxulkdLkyOrEUPr8nw
	 CQsItBrd8hskFvFftoaJt0f86O9vhz14smVViJ4vpVWrmNU1JmsW0biQ8Xb44zM3j2
	 a+CpltRU05s9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 29/32] drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout
Date: Mon, 28 Oct 2024 06:50:11 -0400
Message-ID: <20241028105050.3559169-29-sashal@kernel.org>
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

From: Badal Nilawar <badal.nilawar@intel.com>

[ Upstream commit 22ef43c78647dd37b0dafe2182b8650b99dbbe59 ]

In case if g2h worker doesn't get opportunity to within specified
timeout delay then flush the g2h worker explicitly.

v2:
  - Describe change in the comment and add TODO (Matt B/John H)
  - Add xe_gt_warn on fence done after G2H flush (John H)
v3:
  - Updated the comment with root cause
  - Clean up xe_gt_warn message (John H)

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/issues/1620
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/issues/2902
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241017111410.2553784-2-badal.nilawar@intel.com
(cherry picked from commit e5152723380404acb8175e0777b1cea57f319a01)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index cd9918e3896c0..ab24053f8766f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -888,6 +888,24 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
 
 	ret = wait_event_timeout(ct->g2h_fence_wq, g2h_fence.done, HZ);
 
+	/*
+	 * Occasionally it is seen that the G2H worker starts running after a delay of more than
+	 * a second even after being queued and activated by the Linux workqueue subsystem. This
+	 * leads to G2H timeout error. The root cause of issue lies with scheduling latency of
+	 * Lunarlake Hybrid CPU. Issue dissappears if we disable Lunarlake atom cores from BIOS
+	 * and this is beyond xe kmd.
+	 *
+	 * TODO: Drop this change once workqueue scheduling delay issue is fixed on LNL Hybrid CPU.
+	 */
+	if (!ret) {
+		flush_work(&ct->g2h_worker);
+		if (g2h_fence.done) {
+			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
+				   g2h_fence.seqno, action[0]);
+			ret = 1;
+		}
+	}
+
 	/*
 	 * Ensure we serialize with completion side to prevent UAF with fence going out of scope on
 	 * the stack, since we have no clue if it will fire after the timeout before we can erase
-- 
2.43.0


