Return-Path: <stable+bounces-62151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D493E61C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFF01C20FB1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AD757FD;
	Sun, 28 Jul 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3KUDdkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1D58203;
	Sun, 28 Jul 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181386; cv=none; b=l2CGAcnDq1gH4Loupw8P9rTi6ufRVhXBLM/UNt2CmAa09VIr+Ho4+5liPHJcZNPMSASYH9PnhWSKlHEbvZ13bbl35QwOyxX3XMde8YlC1tWTkyBTKjhDwhoFPNkAtbBWVBBI/j3f6bGw/CStfUlCK0QDuE/xTLrUQJ7n569z2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181386; c=relaxed/simple;
	bh=EZMMz4krHIUvdzWVI5xV0nWibKMMsJlJ0glYjhFHBCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfOiutXmzM2w+mSPjJMy74PhzaXn1uf80Nz81oaKzCe6SYB+jJ6vM6Pw8xaZWTn/XawIBzcqK+84Ta3GV9vq8OV2JYABlcUwPNC0a6aV5P6STVLhV4EYQCVDPyNNVGCzglxcCqO7oTOGIjvoPkryQwdgLnGa65lDlltFQv2rP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3KUDdkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE53C116B1;
	Sun, 28 Jul 2024 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181386;
	bh=EZMMz4krHIUvdzWVI5xV0nWibKMMsJlJ0glYjhFHBCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3KUDdkToYQWiFb0WndBYesteIu4OLcsXsgyWY4BeGRy1U6qKNrx3OSpLadeYuift
	 wybK884S0esKxVbNGh0BmuOQOmNbWK9VmyKa8pdTshrNup+nZwSDVhGa+E9SvpYg8T
	 Is6AAArNrphaPYwZP2qpQwPDDXUp2s/j5JpCbpuDSg2sWagV5trV7fadPgaFl52JZx
	 1wSux/j0HlWJ1ELSJQvB8yXZAmSUKaCbb2n8CCeQ/M7H1rANPU6pOMSQu68GG4V+l5
	 qJAIKVqrBLiGn8oMT4Fom0UPRqeTSrsN3CoD+DQx/jamJMB5XkaPSGkNlQlxejAjRT
	 Uddg6oJEyqFsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 07/34] drm/xe/xe_guc_submit: Fix exec queue stop race condition
Date: Sun, 28 Jul 2024 11:40:31 -0400
Message-ID: <20240728154230.2046786-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

[ Upstream commit 1564d411e17f51e2f64655b4e4da015be1ba7eaa ]

Reorder the xe_sched_tdr_queue_imm and set_exec_queue_banned calls in
guc_exec_queue_stop.  This prevents a possible race condition between
the two events in which it's possible for xe_sched_tdr_queue_imm to
wake the ufence waiter before the exec queue is banned, causing the
ufence waiter to miss the banned state.

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240510194540.3246991-1-jonathan.cavitt@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index e4e3658e6a138..0f42971ff0a83 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1429,8 +1429,8 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 			    !xe_sched_job_completed(job)) ||
 			    xe_sched_invalidate_job(job, 2)) {
 				trace_xe_sched_job_ban(job);
-				xe_sched_tdr_queue_imm(&q->guc->sched);
 				set_exec_queue_banned(q);
+				xe_sched_tdr_queue_imm(&q->guc->sched);
 			}
 		}
 	}
-- 
2.43.0


