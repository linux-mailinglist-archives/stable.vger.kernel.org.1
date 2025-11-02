Return-Path: <stable+bounces-192065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF60C290B6
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1A76345624
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E54199FBA;
	Sun,  2 Nov 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY+gLpd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681014A62B
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095816; cv=none; b=LNVyVOCxPc56cYfU5tmKDOQ1hXYwIi4lNnN85Tw7Rt9CqOWdOjpLwe4qgQxgkvcfTEhRMaHINVhKP0JqMD5aBggb/vloD4onXYdqVKFYHOm2hmyR5yjy56L6yZcCTodJeEt7dbzWTq4DpmYcv9frQzb36HfoOdroXfW8UmGRuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095816; c=relaxed/simple;
	bh=kKU8PgRGeSEHcVPNPzgz0Tah5UlbXCKxKFLV/5D53Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7DV8ln02oxIsvTnsv7TTOs8mYxQ4sQZ430x3WWgH/scHDWmimzm+PbVEQcL0Dr0psjjGtPS066ERymMsUQ7e5nktVx9F+faCFwZh7lZQJR0EKcWpC7OMGNttiNmh+5am94SAMIB8TC/kXOP8gIEhNoB482KeSn+acmQSP0zSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY+gLpd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF938C4CEF7;
	Sun,  2 Nov 2025 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762095815;
	bh=kKU8PgRGeSEHcVPNPzgz0Tah5UlbXCKxKFLV/5D53Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RY+gLpd7rzQdmBNdTGH1HOsCG+Kea5XqApoEQ5Btq0zq7sHCjnCnmJbjcHYK/aQ08
	 DyWE8Hz37nkCCzWnpi33iL8sGBslGSUR4Iwgmh1kL05z0b1wJB1dp8FLnmiHehfBOs
	 egG8ubiS8wFfbJc/u9kf/MMvZDKSdPtDMxdGmUm9sDt/L+mPPk8Zy1OXdrA/U7h69o
	 ozFpKW2KdshVelTpzLWDbohP87Hji4l7SyIpUkHzJOcZ1uhg+4RrTJin4mPUMk2xGS
	 /KcXqGwGKvpY6McRgSoZMpEhY8+VvbElnTsxrbuYkBJAYWSOgS0vWn6ZfM6dEiI0ka
	 EdnS09X14pBxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] cpuidle: governors: menu: Rearrange main loop in menu_select()
Date: Sun,  2 Nov 2025 10:03:32 -0500
Message-ID: <20251102150333.3466275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110243-dupe-pentagram-9b47@gregkh>
References: <2025110243-dupe-pentagram-9b47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 17224c1d2574d29668c4879e1fbf36d6f68cd22b ]

Reduce the indentation level in the main loop of menu_select() by
rearranging some checks and assignments in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/2389215.ElGaqSPkdT@rafael.j.wysocki
Stable-dep-of: db86f55bf81a ("cpuidle: governors: menu: Select polling state in some more cases")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 70 ++++++++++++++++----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index d54a60a024e46..7d21fb5a72f40 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -311,45 +311,47 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		if (s->exit_latency_ns > latency_req)
 			break;
 
-		if (s->target_residency_ns > predicted_ns) {
-			/*
-			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger soon enough.
-			 */
-			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->target_residency_ns <= data->next_timer_ns) {
-				predicted_ns = s->target_residency_ns;
-				idx = i;
-				break;
-			}
-			if (predicted_ns < TICK_NSEC)
-				break;
-
-			if (!tick_nohz_tick_stopped()) {
-				/*
-				 * If the state selected so far is shallow,
-				 * waking up early won't hurt, so retain the
-				 * tick in that case and let the governor run
-				 * again in the next iteration of the loop.
-				 */
-				predicted_ns = drv->states[idx].target_residency_ns;
-				break;
-			}
+		if (s->target_residency_ns <= predicted_ns) {
+			idx = i;
+			continue;
+		}
+
+		/*
+		 * Use a physical idle state, not busy polling, unless a timer
+		 * is going to trigger soon enough.
+		 */
+		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+		    s->target_residency_ns <= data->next_timer_ns) {
+			predicted_ns = s->target_residency_ns;
+			idx = i;
+			break;
+		}
 
+		if (predicted_ns < TICK_NSEC)
+			break;
+
+		if (!tick_nohz_tick_stopped()) {
 			/*
-			 * If the state selected so far is shallow and this
-			 * state's target residency matches the time till the
-			 * closest timer event, select this one to avoid getting
-			 * stuck in the shallow one for too long.
+			 * If the state selected so far is shallow, waking up
+			 * early won't hurt, so retain the tick in that case and
+			 * let the governor run again in the next iteration of
+			 * the idle loop.
 			 */
-			if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-			    s->target_residency_ns <= delta_tick)
-				idx = i;
-
-			return idx;
+			predicted_ns = drv->states[idx].target_residency_ns;
+			break;
 		}
 
-		idx = i;
+		/*
+		 * If the state selected so far is shallow and this state's
+		 * target residency matches the time till the closest timer
+		 * event, select this one to avoid getting stuck in the shallow
+		 * one for too long.
+		 */
+		if (drv->states[idx].target_residency_ns < TICK_NSEC &&
+		    s->target_residency_ns <= delta_tick)
+			idx = i;
+
+		return idx;
 	}
 
 	if (idx == -1)
-- 
2.51.0


