Return-Path: <stable+bounces-118352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A872BA3CC1E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6F1898CB7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C782586EB;
	Wed, 19 Feb 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB/kFG7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E02586E1
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003003; cv=none; b=jvEGtlGlgmx2tH5zhXf9k026n3RpbzESwTK9SX7wQMEtBiGMB/e/lGVJOYoqiupydHuDbtXC4AcMPS909oS74dzk3tmQKo/horUD0nXo4TOLSj6DphvAaELvckDmPeLvaGAalZmyrKWirSLwC7A19DXaz5JHiyOKKt3LsrSGnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003003; c=relaxed/simple;
	bh=xXv19ZMGqKy5BKVGlWA6V7FVe3zIDVRXl/oXg7y/Jmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdhKAZFd0WZQDub4R88UVkWIYp55zLJ1w98DKCTlIFZ8qu1Rej6FlgUmcqdIGYJMrqfwjxECOldFF/+/+1Hn7E2rCchuIkIcvwyAWKxOYvt+/yZuJgsiq7gLKVw3vcfBBV+Pz4L8REYhHSApbCFVhP9LknzGKzTHleLNPYD2kCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB/kFG7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A007DC4CED1;
	Wed, 19 Feb 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003003;
	bh=xXv19ZMGqKy5BKVGlWA6V7FVe3zIDVRXl/oXg7y/Jmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZB/kFG7K6hcGWH1Uk71WCcIDmCee/Soz6DYblV+TDH9oTaM/3dBStjrG2s0+Co3sO
	 dCpQrAbuxJl+SB4/P4MPaB+SCPFg2EDwwXWWtKiW7jeQK/jLCs8FUvcU7MpdhSso1q
	 6kNuLpg7XK9osdYENohds/fyFUwHjZj1PGrrY1dx7RjvRO0odx2ghC4RCh88TxQ4gc
	 0TOPJybQLtjagaWDxt9GgMMVwhSM5tXh+IRn2TzTtvbmRNuWjDaJHkALMg6Lg0U3Z1
	 M/G+gaps1UiiBAqNGACwYgEFdDsSEQjO4cfAWyjhJckMt258d3QCHheRm8XUv0i/r9
	 6+GBJgoNmpJxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sven@narfation.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Date: Wed, 19 Feb 2025 17:09:58 -0500
Message-Id: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250219185519.840435-1-sven@narfation.org>
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
5.15.y | Present (different SHA1: 72203462f255)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.10.y. Reject:

diff a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c	(rejected hunks)
@@ -176,31 +198,19 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
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

