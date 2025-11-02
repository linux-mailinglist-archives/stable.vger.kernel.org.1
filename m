Return-Path: <stable+bounces-192076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D06C2957E
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC9DE346516
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E380220F2D;
	Sun,  2 Nov 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Nyccdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CF1A23A6
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762109853; cv=none; b=rNDetOTwNoPghLPg/fZC1LNHo3BdW8MyJkHosOFdz+K02IJ0SRrD2IKGA5O9ExEjQxlEzVf0jZpht79o3QNqMyutCL8Nbh8dTq0ekxYk21yAWjfL7XGsvqBo2o8qUYzKluGZc69rhI/nH1QIci3EWI9HGOFTGjtNKApmSKmr3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762109853; c=relaxed/simple;
	bh=y25DqqrRHC69HJl8A71gPNEOM/OQGJanvYCSEqV/XmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci2/Ggcv+sSQu6fXo6zP+pzGqyk8L3ylDUiH+wOLV+09krulrNV0a4droIY7nr8AfIHW79eiadaZIzkUAZWav6dy/kwpfrWpgVwjIhtOfgynT+KTr9YGcApXcw/4LiTU5nikAJRmJIjC2eLdfZjqgkChvTziTPIM9zljBZwXAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Nyccdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE906C113D0;
	Sun,  2 Nov 2025 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762109853;
	bh=y25DqqrRHC69HJl8A71gPNEOM/OQGJanvYCSEqV/XmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7NyccdinIfhrDsjY/AWyqkm8RaJ7I1SLY0as6O8/X04X8xFhjcm9bb2tpT092H/I
	 3VEoaAHGw83qvqEzq1zuHLbZFsvnuSatZzyx6Y/c68KvC20p7Tp1wqsuwrOoId95Rc
	 6KSP7BaTye1dva2p5g1LjetAuHfzKvPa2ousVz3LtyjpFGSXS/EtdgEQ9+amzvE5ya
	 hRLGtgJFFosDfKY4WkJPAgXQ47Q7Hfv+J9Y18NrYhcgEw3JNIf57eoqFIU/SKgaKQW
	 WtH9pSahKzfRJRiDRUoDN67jw719sD7J3IvEJaVkD31ebn2jcX5kQS9oIguYYwsl0o
	 u2dohq0RrWfAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] cpuidle: governors: menu: Select polling state in some more cases
Date: Sun,  2 Nov 2025 13:57:30 -0500
Message-ID: <20251102185730.3551603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102185730.3551603-1-sashal@kernel.org>
References: <2025110244-overstuff-scallop-d38a@gregkh>
 <20251102185730.3551603-1-sashal@kernel.org>
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
index e4f439467574c..9069c36a491d5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -324,10 +324,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
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


