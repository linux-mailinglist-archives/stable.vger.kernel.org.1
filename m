Return-Path: <stable+bounces-192066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B9C290B9
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61978345F54
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3C1C5D59;
	Sun,  2 Nov 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCEPELVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2814A62B
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095817; cv=none; b=DY39JVsKnCe/1h/GuktP3b/S0uiqAHI1c1lZulKPN4+yCgKZEdZfxfXBLKbETpRFAmNr2+Od2b9BDLKVdrGyR15i01VGRkcP5VMpjvCJjq0uijMxWwbCf24+UHzYms72oCZ5NFqi0en4UOiz6ws/bhul3QIW7BNxmMbl62d0nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095817; c=relaxed/simple;
	bh=n7bx+bIrTfslhQt+09dr+P7mcQ2LS7E7lAUjuuDU9Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWfA4I3EEpGfnchvobXkkKG/qG5I2bgRlQ7eCh9rnVTMErj/Z8+8IttqMI8fXpHp9h0DkrCR4bjZmOsunZvgMBjSagBOORXy7+lOCCBD6IJYZgSvI6B+ZUMV1Z9T9AgcK/bykdrtK9LaaHEBvMCThhv3c1KYqtvxn1cLQqppzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCEPELVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C423CC116B1;
	Sun,  2 Nov 2025 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762095816;
	bh=n7bx+bIrTfslhQt+09dr+P7mcQ2LS7E7lAUjuuDU9Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCEPELVQayqqXWHueYyNDtg+ZtjMjbbwFgBmq0I3BA8HYevpi4jC4MTk3q1R/JsXI
	 VJeKsc7r2/2cd9U8DqVxARv87lJ3cEkNgTdIkRxCHY4adH/Ey/wmUlbD6Hl5qplSb5
	 7J6dNEOFCl5glx3XFVzzowcOJdVisy9ngdDyYmhcaKKoc5hLniY0iRZFzWK6ovcXyA
	 GdgMTmsJnFO/o70bahfzTUuFs6vtw3d4YEoQNfXAAth8GLtww1SnYt0M97ywm+W9m8
	 9P0lsMXR6tAD+iuXO0dJ07vFFH8oEesWCRLUNLMPXcwTir3SSBaBdssGlgOn6lg0mT
	 ZJhZg7PRVw6JQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] cpuidle: governors: menu: Select polling state in some more cases
Date: Sun,  2 Nov 2025 10:03:33 -0500
Message-ID: <20251102150333.3466275-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102150333.3466275-1-sashal@kernel.org>
References: <2025110243-dupe-pentagram-9b47@gregkh>
 <20251102150333.3466275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit db86f55bf81a3a297be05ee8775ae9a8c6e3a599 ]

A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
governors: menu: Avoid selecting states with too much latency") has been
reported and it is related to the case when the menu governor checks if
selecting a proper idle state instead of a polling one makes sense.

In particular, it is questionable to do so if the exit latency of the
idle state in question exceeds the predicted idle duration, so add a
check for that, which is sufficient to make the reported regression go
away, and update the related code comment accordingly.

Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/12786727.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 7d21fb5a72f40..23239b0c04f95 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -318,10 +318,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;
-- 
2.51.0


