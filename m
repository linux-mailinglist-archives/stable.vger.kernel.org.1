Return-Path: <stable+bounces-140362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F0AAA7E8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17E316B961
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185D342C4A;
	Mon,  5 May 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3yvhDkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9881342C49;
	Mon,  5 May 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484698; cv=none; b=Bya2LGu2Ktzr2p8Irvajf14L9IS/B8WkYVjJFMhbwlUV1AAv2LwVGhZ7UzYea3oBxMgGil8xvqM8MNjgOR1bPf2b/Eyz2f5aWQqmQ+mK67CNepes1+VroJuTXFfShsXmum4a6pnmR3WBvcarIL1c3FBcXrYH7mcd2Bvfdh1KBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484698; c=relaxed/simple;
	bh=kCcwV+upM/EsDanwO1m5XKR3rnDhiox1GbU6MMiCAxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGstR+gl1/jUI0ZXhQjdJUAgZBNzDC4dPYyA1ka3w0eF9bT8Lkkpsi4qJzfLVkk6EAE9ccspOEqpc2orGA+VygXLaUFk51THZCtYBq5xWvzWjn/kQayhhc3cPnnM1xZFSWdwicc6WUYgdjT6OgeatP52Vn1WNZVhojKEbIbcx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3yvhDkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D480C4CEF3;
	Mon,  5 May 2025 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484697;
	bh=kCcwV+upM/EsDanwO1m5XKR3rnDhiox1GbU6MMiCAxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3yvhDkDXr8IjItRv3DW1ebgf75Rgcb96N2YFviLpJ2Ljc/PNOFnx5afqH7Qik50L
	 D/6wivUxWNM6NhcYTPPkpuoyOdj1HESy1ufnpCb92lHWykkIlcNA2Kef0gS5vtcnNx
	 afRCzU5cqz0IA8TcC25qtftOxs9QAiUgaPoBUHyDKOk+/BRM5D8TVlwwlqTkf2qpfD
	 e6ZBhO5LvRfYlfOkSo6eEUyPBpnxZTHqASvru6qcyLFg8eu2/MxlMTtbThEqbeCkHZ
	 LGm8T+vz9OnLUXl/kjfFX2lUEzMkqOlGD9UYuTl6WCZm1xoi9qR5jRXKKn3li3KVhY
	 Vg/NqAoySFxMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Harrison <John.C.Harrison@Intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 613/642] drm/xe/guc: Drop error messages about missing GuC logs
Date: Mon,  5 May 2025 18:13:49 -0400
Message-Id: <20250505221419.2672473-613-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: John Harrison <John.C.Harrison@Intel.com>

[ Upstream commit 174e9ce0daf6af791386e96e76e743eb59e8a401 ]

The GuC log snapshot code would complain loudly if there was no GuC
log to take a snapshot of or if the snapshot alloc failed. Originally,
this code was only called on demand when a user (or developer)
explicitly requested a dump of the log. Hence an error message was
useful.

However, it is now part of the general devcoredump file and is called
for any GPU hang. Most people don't care about GuC logs and GPU hangs
do not generally mean a kernel/GuC bug. More importantly, there are
valid situations where there is no GuC log, e.g. SRIOV VFs.

So drop the error message.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3958
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250113194405.2033085-1-John.C.Harrison@Intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_log.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index 0ca3056d8bd3f..80514a446ba28 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -149,16 +149,12 @@ struct xe_guc_log_snapshot *xe_guc_log_snapshot_capture(struct xe_guc_log *log,
 	size_t remain;
 	int i;
 
-	if (!log->bo) {
-		xe_gt_err(gt, "GuC log buffer not allocated\n");
+	if (!log->bo)
 		return NULL;
-	}
 
 	snapshot = xe_guc_log_snapshot_alloc(log, atomic);
-	if (!snapshot) {
-		xe_gt_err(gt, "GuC log snapshot not allocated\n");
+	if (!snapshot)
 		return NULL;
-	}
 
 	remain = snapshot->size;
 	for (i = 0; i < snapshot->num_chunks; i++) {
-- 
2.39.5


