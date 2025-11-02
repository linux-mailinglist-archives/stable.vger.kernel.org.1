Return-Path: <stable+bounces-192081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C5C295AC
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 20:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9999F3ADBAC
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 19:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDA1A23A4;
	Sun,  2 Nov 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skOIzWJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF979F2
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110176; cv=none; b=WMgxf731SN+IuGbVmHKAKPKNi5GpZuqonae4+pEMQAbgqSFUXGRrhLn5Qvu5AGbovyX+mCnZ4oFCrqDl2qWePIOZYNRjTd1Zoss97BvdlwDVMa/alWL3xilYxhDDsT3ctlWUDrSzzMp52/5zSnAGAEQboWfJ2jjkbSw3FwrPJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110176; c=relaxed/simple;
	bh=kfIAgolKlEz8ULg1ePqizCfV9Y6YyAe7Az2pqRFD97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELgxQLh3RedIkyuX+JodlPyrug4MxGAGnCDpey5R9DP8DlDexEb6mxY9/Xs0z1dnT7cdPDT3p7EEEQG2/GUApvg2E7DTiqKGuUdUB0/b5AG00/tvfDd6O/3y7qHKsCUEM8cC7k66v24LQgvxO9wcFECw0XJOep8jz+AOakjCmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skOIzWJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B65C116B1;
	Sun,  2 Nov 2025 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762110176;
	bh=kfIAgolKlEz8ULg1ePqizCfV9Y6YyAe7Az2pqRFD97w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skOIzWJnBwE0S/R2RRhpddnXHyFy4Q7w8y78Bf4GVVhq54v6RcGc0ExNhS1T7bX0s
	 yinw4x+IwGa5hL4621vAzlVw0L7zOE+p7rgIo80J2zkoPsUrus30/guwrthpE71HyL
	 sGIQtCCRlRnzu8Dy7UB1BAADtbblCGTvwz6WNrI6iZybx1uEG/3G316h3lf2BY0jvk
	 gSuYFcIrrO3QJSsmGX5wiKjKXAYNKww+o7M0WX80LchRtrStZci6lTG7J2rmX4cL64
	 CNwRK59PMYUMcLKXIipkSpt5C8H3DQ/rcPm1S3ymht8ftLcfD8Chly5bGN2afkao9m
	 qVD01zUZg5UNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Doug Smythies <dsmythies@telus.net>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] cpuidle: governors: menu: Select polling state in some more cases
Date: Sun,  2 Nov 2025 14:02:52 -0500
Message-ID: <20251102190252.3557318-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102190252.3557318-1-sashal@kernel.org>
References: <2025110245-mongoose-ravioli-e19d@gregkh>
 <20251102190252.3557318-1-sashal@kernel.org>
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
index 8e9d9c448f0f8..8c591dde61023 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -355,10 +355,13 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
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


