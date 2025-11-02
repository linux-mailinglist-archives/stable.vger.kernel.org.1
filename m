Return-Path: <stable+bounces-192075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA2C29581
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F293ABEC1
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B221B1BC;
	Sun,  2 Nov 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA+rMvey"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36BC2FB
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762109853; cv=none; b=I82bfx0zIgHVKf3CZMV1aPXUeRBNMqCpQCwLFIusVW2LKRx5KkxRVdTXvxjME7uoTDykO42+wfU+vwRwHrJzrShDFGczHYcJ7QajRII0e8dcXLGcZAteLrMfDz5ZxJEy27D/ySoB/7jhBsAk0zvw2mX6ajQ4SgytOPmzbxBzYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762109853; c=relaxed/simple;
	bh=3No/Ejgs17bSMMIBRCBpHSVXSGMLQup/fb87eXX256o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGyRlBGKNpZZsf80NXbyNOkbaIpvhuxWQBTSCwY7v8E03D8o9ICLj244LCHa6wAnsVEmktipCN02MNo4GeJ2X1zcPtHx+r/crF/93VwERfuM1d8XVsVstFFKkTEduAMXCSHMjD7sM7dK3xIhekXvsFDZvy/SuXmgrTlZmv6oZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA+rMvey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5677C4CEF7;
	Sun,  2 Nov 2025 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762109852;
	bh=3No/Ejgs17bSMMIBRCBpHSVXSGMLQup/fb87eXX256o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JA+rMveyDFRhj5qGmqfuOBCJHuONmx0VQ7J/yAkxhu4QmdQdexsCKHNZlFN5gPqIB
	 LQGmdK5RXuaF0RWOWsip2esiWxF/z6zoC9Gv/KLRXGZsOxyxL0NDdyK8QLTjSBkeI/
	 fkdqdnPo58IH2ZzVAuvDkDhsVhRaZOz4CN4vkOOIe+SAkJ7lHrzM/c4YsN2etbdUJ9
	 alDN9IJJsXLB+GuiqeB4SdMmmMKhX+W9jsj8+gjpnHMRxB4J1qFOXfzqPa3W6Ykpqh
	 F6nQx2DUpRon8g4em90K5pjrIzs1+84eKXzASzk2IZgx8ienvI71Emyn9vEqNHmUd5
	 oU0zIqKYOYXRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] cpuidle: governors: menu: Rearrange main loop in menu_select()
Date: Sun,  2 Nov 2025 13:57:29 -0500
Message-ID: <20251102185730.3551603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110244-overstuff-scallop-d38a@gregkh>
References: <2025110244-overstuff-scallop-d38a@gregkh>
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
index a87c08f7eb686..e4f439467574c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -317,45 +317,47 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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


