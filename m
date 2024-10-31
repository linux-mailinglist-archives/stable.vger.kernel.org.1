Return-Path: <stable+bounces-89423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4D9B7FB3
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99AD1C21550
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B231A726D;
	Thu, 31 Oct 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwKi8rgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361B19DF49;
	Thu, 31 Oct 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391130; cv=none; b=e5CwSACYC2hCO2KkBVq/ak+ApjjSBnDBXY41tszQuq3h8UQxGJl5msLe1end7Bw1c2QZ7PjZ/plkyksW6gGMYTh+kdH8jOBeTerKb44hb23SP97Jx0r18pzgKkt51Ep0RG8xmv3L+GTiiicQJPeTHgUiFJbRoYTC6iDQU+a1hY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391130; c=relaxed/simple;
	bh=eJEmZyDPLbC02Dw1bjFmNYjwx8wPuh7E/dUJfe6XCXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KH8nH+EuRxKiCJMXxw5RE0dZGLNOJQ1tx56J+zydNB3SR5IHqLOXB5UYUB2W2hzohKFHmmqSmJee5Nhbspuq29qfeI35m/1TiMcwmCK/LicgO0azngIOK9kbivcX31S1Efr9k6JGD5wXVPPZWPw5QI8CukJ92QVQOyeIqCL7VOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwKi8rgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A0CC4FDF8;
	Thu, 31 Oct 2024 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391130;
	bh=eJEmZyDPLbC02Dw1bjFmNYjwx8wPuh7E/dUJfe6XCXs=;
	h=From:To:Cc:Subject:Date:From;
	b=lwKi8rgs00fdO2QE9BMW6hi2NXzjy6NXFt7VzFB2pNgQAHatvcKXpR3WB3yncLNUx
	 aGLF8/lLm9TUuegjSXYis0qqiaYe6g4ONQBdL+prOUET9SemlRs3jn3dGHimQxAL+b
	 6FzPwJEqBm3xdSi5brDCH4GbYcYBDHOodpPWFQH43SeBm08a5luahqa4pJ040IyYDU
	 d4CG/Ul6tP4nNy6oXvhX8odQygIvHNmCb2J0ABRRASiqaLa9BU88GE0eSasSRlsdAW
	 VOojFRiT2qVwNjAsmlI/FQniRvMppkdS+M004rbPZ3RYFDIriFNcaTThiO1ivglrlk
	 7W7AeU4utKkxg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: avoid overflow in damon_feed_loop_next_input()
Date: Thu, 31 Oct 2024 09:12:03 -0700
Message-Id: <20241031161203.47751-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_feed_loop_next_input() is inefficient and fragile to overflows.
Specifically, 'score_goal_diff_bp' calculation can overflow when 'score'
is high.  The calculation is actually unnecessary at all because 'goal'
is a constant of value 10,000.  Calculation of 'compensation' is again
fragile to overflow.  Final calculation of return value for
under-achiving case is again fragile to overflow when the current score
is under-achieving the target.

Add two corner cases handling at the beginning of the function to make
the body easier to read, and rewrite the body of the function to avoid
overflows and the unnecessary bp value calcuation.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/944f3d5b-9177-48e7-8ec9-7f1331a3fea3@roeck-us.net
Fixes: 9294a037c015 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning")
Cc: <stable@vger.kernel.org> # 6.8.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
Changes from RFC
(https://lore.kernel.org/20240905172405.46995-1-sj@kernel.org)
- Rebase on latest mm-unstable and cleanup code

 mm/damon/core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a83f3b736d51..27745dcf855f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1456,17 +1456,31 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 		unsigned long score)
 {
 	const unsigned long goal = 10000;
-	unsigned long score_goal_diff = max(goal, score) - min(goal, score);
-	unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
-	unsigned long compensation = last_input * score_goal_diff_bp / 10000;
 	/* Set minimum input as 10000 to avoid compensation be zero */
 	const unsigned long min_input = 10000;
+	unsigned long score_goal_diff, compensation;
+	bool over_achieving = score > goal;
 
-	if (goal > score)
+	if (score == goal)
+		return last_input;
+	if (score >= goal * 2)
+		return min_input;
+
+	if (over_achieving)
+		score_goal_diff = score - goal;
+	else
+		score_goal_diff = goal - score;
+
+	if (last_input < ULONG_MAX / score_goal_diff)
+		compensation = last_input * score_goal_diff / goal;
+	else
+		compensation = last_input / goal * score_goal_diff;
+
+	if (over_achieving)
+		return max(last_input - compensation, min_input);
+	if (last_input < ULONG_MAX - compensation)
 		return last_input + compensation;
-	if (last_input > compensation + min_input)
-		return last_input - compensation;
-	return min_input;
+	return ULONG_MAX;
 }
 
 #ifdef CONFIG_PSI
-- 
2.39.5


