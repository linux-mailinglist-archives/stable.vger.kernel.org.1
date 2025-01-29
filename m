Return-Path: <stable+bounces-111139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103CA21E4E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B208168CB0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CB1D5AAD;
	Wed, 29 Jan 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq0x4nwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17031BEF78;
	Wed, 29 Jan 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159278; cv=none; b=f2pGNy6ICg2t8Z7nUMAJuSGztfZMYR9LBEbDRKedse9qb/FDG9qam9IrFUeqkZit3RIqNa+zMxZg0w46sPV+fgWshfu0MFrHdHwUaxfL+HMmJQj+qA9q/6/F4ph3rBQcr6Vn8Oj1wrbC3xcF7pLu8hl0AKx3BLd/CFSsDJLP5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159278; c=relaxed/simple;
	bh=+H3jVJd1lzeG60nfMsZcKWTgtOwYHsE7fkM3OZfrl4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHlbmAfc8TQ5m84/fPxcU4pAWyS6KaHoMwq4AoBCM8lECoZ3kKFvn10F1g2F8c0c68KaW4/rYn3Ow6uLh3WjLBVonYGAuzvoGKfKMFAeC3MlrbTSZ2DsvpvK6NLPsVkw7PCDg7y+Rlsv6+NOhvFTZLWjDa0TfjyqRJestY3dVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq0x4nwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8C8C4CEE1;
	Wed, 29 Jan 2025 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159278;
	bh=+H3jVJd1lzeG60nfMsZcKWTgtOwYHsE7fkM3OZfrl4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kq0x4nwpQsdH2LVCGgYO8vORpLRe0Cqoe3H0sEvpWKRJlWZ5k6gW3cHKvd5UblGAU
	 o2dG/H5WhEBXXc4fO/2IjqHfLaZEU3TceIbYF/vtshjtgsde/2mi/iNri/Ut7SpnUT
	 zw7+yqAfsUa1/cWv8BwoFCPzWM3fr2ExqXRaJZUp8QtIXAXPkMlRhG8Reywp+iHBy8
	 a3zt9FEzyDqKVfcWshZBwkyr1uckBvGqwbNf6GSJ9P7IZzRC9bHOix93B7jica0j5G
	 GOopbGYsddt7o0LyizALfpF6SlUI5mXbSHZvzqFcXjP8L0P13RRCYaXQuIUWm54Kaz
	 R3t0bfWpdWeOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	ezulian@redhat.com,
	costa.shul@redhat.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 4/4] rtla/timerlat_top: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:23 -0500
Message-Id: <20250129125724.1272534-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125724.1272534-1-sashal@kernel.org>
References: <20250129125724.1272534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 80967b354a76b360943af384c10d807d98bea5c4 ]

If either SIGINT is received twice, or after a SIGALRM (that is, after
timerlat was supposed to stop), abort processing events currently left
in the tracefs buffer and exit immediately.

This allows the user to exit rtla without waiting for processing all
events, should that take longer than wanted, at the cost of not
processing all samples.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250116144931.649593-6-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 059b468981e4d..10254176e8df8 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -902,6 +902,14 @@ static struct osnoise_tool
 static int stop_tracing;
 static void stop_top(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(top_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 }
 
-- 
2.39.5


