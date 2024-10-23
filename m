Return-Path: <stable+bounces-87863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF469ACCA6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82401C213F5
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB301E1C00;
	Wed, 23 Oct 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiE4B1JD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790B1E0E0A;
	Wed, 23 Oct 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693863; cv=none; b=s/ftB4CFGDhDEVUh43udJtVqEZJ2zOHCW6V0dRmMPs3Xg2CpWgn+8tA/DRMIAxxcEjFdmALDHd8VsnftUdCV/rGUmzaODyL/MZTvTXYFLONHk+SvujuXO2JlwdicT4I/y5l4bn7n063Cn+NxzRTy9tBQie3Lvsko7dBU3IBLblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693863; c=relaxed/simple;
	bh=jk4gZ318ElIT3NFdJQ1M7kZzjg1NdLC7IU9xiNjjbxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7l2YuAMF10ErMf9VvijKw2sYRjvg4QOLxjZkR8l7saNKh0Bn7BXMxcQcUxcEjW9GZXglBLycwwpKq8i+2TRItVuB7C3e+raa1WcV5WzYI3zHv1q2G9ZaY00aRjT0dd9/BoYXfphXYvuJbqkQOEHWVKDUrqhTrcFNsmk2fiFANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiE4B1JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE6C4CEC6;
	Wed, 23 Oct 2024 14:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693863;
	bh=jk4gZ318ElIT3NFdJQ1M7kZzjg1NdLC7IU9xiNjjbxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiE4B1JDyjn7q0jX1YKQ95GQ2wmMIC2ikObLNKInLb/smdbF3wAwK7fabCrKUnmAV
	 0lNQbzTH6J6vI3A8jWjYXwI5c1HHW2oSd5noRPauBJ0YM25bftdO4GSNrisvMvXUDw
	 6+7bBwYOChXEaTkzGSjNHp5C4ITv9iA3ABVEZwkki9dWEpwURuHmpWR/Hx+yQ1W4a0
	 dSJJjOT4Q0mkYOSFCNJYtnfJMu8I0HxWZ50+mQEypCSm4b+H2HGCoPxtlB3NqB1vN6
	 ltsBzpyYxvZ3ai3jFIcctHKRyEhHaBaSUzkszeSvlS9dq35XWvqNoI6+uU4is/ifY7
	 PAafT5JZm8zSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Szymon Morek <szymon.morek@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
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
Subject: [PATCH AUTOSEL 6.11 28/30] drm/xe/query: Increase timestamp width
Date: Wed, 23 Oct 2024 10:29:53 -0400
Message-ID: <20241023143012.2980728-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
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

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit 477d665e9b6a1369968383f50c688d56b692a155 ]

Starting with Xe2 the timestamp is a full 64 bit counter, contrary to
the 36 bit that was available before. Although 36 should be sufficient
for any reasonable delta calculation (for Xe2, of about 30min), it's
surprising to userspace to get something truncated. Also if the
timestamp being compared to is coming from the GPU and the application
is not careful enough to apply the width there, a delta calculation
would be wrong.

Extend it to full 64-bits starting with Xe2.

v2: Expand width=64 to media gt, as it's just a wrong tagging in the
spec - empirical tests show it goes beyond 36 bits and match the engines
for the main gt

Bspec: 60411
Cc: Szymon Morek <szymon.morek@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241011035618.1057602-1-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 9d559cdcb21f42188d4c3ff3b4fe42b240f4af5d)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_query.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 4e01df6b1b7a1..3a30b12e22521 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -161,7 +161,11 @@ query_engine_cycles(struct xe_device *xe,
 			  cpu_clock);
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
-	resp.width = 36;
+
+	if (GRAPHICS_VER(xe) >= 20)
+		resp.width = 64;
+	else
+		resp.width = 36;
 
 	/* Only write to the output fields of user query */
 	if (put_user(resp.cpu_timestamp, &query_ptr->cpu_timestamp))
-- 
2.43.0


