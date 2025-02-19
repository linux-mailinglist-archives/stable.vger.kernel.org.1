Return-Path: <stable+bounces-118351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EAFA3CC1D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49EE189D6E8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0C2586E9;
	Wed, 19 Feb 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8x6bK7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3362586DF
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002998; cv=none; b=qkZOBjp77ZppSNoqnOlggPqJho+wLQyDTCjgx1G+YFS63/fvKXhjtFtC3drlqBWTclbb8Y0fMx1/LbCwxCKvIIQUajY1UytQmhSUC2WCvtm8AYROpRlA7riYdW7oGJ8Yy6e4DXnLMzfUoeooR4NzQ748LyvNJHrUmqeheiP4OeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002998; c=relaxed/simple;
	bh=ExEpV3RZwgjJyUeXf7gQh9qtflzi7TRfY4mQTYp47Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIULy8iIiozFRB9g309Rs0Z3flJ8Y6Pigs4t9pJL1+P0VR9W0OvrErMkaAo1pEgp2egdRnW4ASxVsdHr2TvinhEvCzMs4EwTCpAzhFd0NvkbczRqZVobpdTDKLyCC8538gjvJRHIQXeyGyopweGGdzH3Tw4zj0+EnE0pNIIRpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8x6bK7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C614C4CED1;
	Wed, 19 Feb 2025 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740002997;
	bh=ExEpV3RZwgjJyUeXf7gQh9qtflzi7TRfY4mQTYp47Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8x6bK7BqOPe4bwoZUd/kojMW1Op2YlptM/t4B1x1nsOfNq98dLtUA7BQnxQGg6Lr
	 K9ck9rFr+oKWzbmYtpmoCqgN6IxRCqAPh4GPvQDanYsDXYy8jYniQVZ3ug2N1pdSn3
	 QZHCb63sXo3FwQG9Zd+jWlWLJ6PPDVaE66Xp9JjUN3zqNSzKeCsUjBUJg50WO1YxbG
	 6eyHokM6Ph09J29Dbp78Uw133rqux6J6plPJHHL0p1R8SBFWzyj+3z9eCMiNF9iGCK
	 j6xMnLBs2Y+5MpQoxVej3gRS7pKcgz9f8efUL23MkTDKiQEUCWwp9e6NKOQkJOqkRe
	 I/2DJX30iUadw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sven@narfation.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: Drop unmanaged ELP metric worker
Date: Wed, 19 Feb 2025 17:09:53 -0500
Message-Id: <20250219165451-d7aeabb8444db978@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250219184905.814343-1-sven@narfation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 8c8ecc98f5c65947b0070a24bac11e12e47cc65d


Status in newer kernel trees:
6.13.y | Present (different SHA1: 7350aafa40a7)
6.12.y | Present (different SHA1: c09f874f226b)
6.6.y | Present (different SHA1: c8db60b2a7fd)
6.1.y | Present (different SHA1: 831dda93b13c)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.15.y. Reject:

diff a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c	(rejected hunks)
@@ -177,31 +199,19 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 /**
  * batadv_v_elp_throughput_metric_update() - worker updating the throughput
  *  metric of a single hop neighbour
- * @work: the work queue item
+ * @neigh: the neighbour to probe
  */
-void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+static void
+batadv_v_elp_throughput_metric_update(struct batadv_hardif_neigh_node *neigh)
 {
-	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
-	struct batadv_hardif_neigh_node *neigh;
 	u32 throughput;
 	bool valid;
 
-	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
-				   metric_work);
-	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
-			     bat_v);
-
 	valid = batadv_v_elp_get_throughput(neigh, &throughput);
 	if (!valid)
-		goto put_neigh;
+		return;
 
 	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
-
-put_neigh:
-	/* decrement refcounter to balance increment performed before scheduling
-	 * this task
-	 */
-	batadv_hardif_neigh_put(neigh);
 }
 
 /**

