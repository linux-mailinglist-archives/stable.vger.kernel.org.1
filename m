Return-Path: <stable+bounces-94025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D64A9D2883
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C83280E05
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37AB1CDFDB;
	Tue, 19 Nov 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsYZiQ7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFF1CCECD
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027615; cv=none; b=j/Tm3bLPCIairYv95jrSqoRcQ22yx6gqA9yvV1HHTBdo09WTABHXWElDgPrfvcpXCcyu15Qvt7oVsoJGezlbqAuZB8hbU/1Gp9AjsBcEz1n3oIU/8KFUPQZXGEjiypHH4D54ORq8hXmf4uqDejR41oj3qZWWaBDxLICMvbe+fI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027615; c=relaxed/simple;
	bh=ddaLJR57C22OFyOhR/GvhErMWsHrFG4JYGnAZ4OoHck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7oyIg63WE+4o9OUwZrCR8VFY8jlimNtyPrY6ICIliqzCe+klKRN0GFEgDXwEEkldrfX502zbadkGoXHftRYisdynPBGNkUKBI4Kor7yoPxtIPCQGU11VlWTE6BHv6GMKFk7+ut0EaKijU2QCFELMtplJ3MMw6x8DiSdRLOOpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsYZiQ7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DAFC4CECF;
	Tue, 19 Nov 2024 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027615;
	bh=ddaLJR57C22OFyOhR/GvhErMWsHrFG4JYGnAZ4OoHck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsYZiQ7UBMEiw4LoXGl2SlXN0w26y2PT8C4Zb64y+STWSssjaUXeH8STDj76S/4i7
	 89MaWA0y0eMaF4RtEHQA7R8oOPSf0yK7faUUJo0AmNX8fjnMT68p14rRgmOJIKDOuH
	 7eOdg1FhXdKAW0xLN+FlYCDSZd14NDUILNW1PqE0HT8hWaqOOYHw0sPYxg7ZXG2bzb
	 ep9n/Qf1k/Ey6JzLnJJfjbb0rFbE3hQ1Te6lAsmewUT1Uu9FgqTGUI12nBLec/HSUX
	 8edW//fjuYSl5NHlmBuRwCl1A53f2Qt9ympB885/xn0MsYYbqzXRM2OkhVBt0F/pvr
	 6eb0pxEZ8l6LQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/sched: taprio: extend minimum interval restriction to entire cycle too
Date: Tue, 19 Nov 2024 09:46:53 -0500
Message-ID: <20241119080618.4010517-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119080618.4010517-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: fb66df20a7201e60f2b13d7f95d031b31a8831d3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Vladimir Oltean <vladimir.oltean@nxp.com>


Status in newer kernel trees:
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b939d1e04a90)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 08:31:43.586625880 -0500
+++ /tmp/tmp.pzrjICiDrF	2024-11-19 08:31:43.578195482 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fb66df20a7201e60f2b13d7f95d031b31a8831d3 ]
+
 It is possible for syzbot to side-step the restriction imposed by the
 blamed commit in the Fixes: tag, because the taprio UAPI permits a
 cycle-time different from (and potentially shorter than) the sum of
@@ -18,16 +20,18 @@
 Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
 Link: https://lore.kernel.org/r/20240527153955.553333-2-vladimir.oltean@nxp.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  net/sched/sch_taprio.c                        | 10 ++++-----
  .../tc-testing/tc-tests/qdiscs/taprio.json    | 22 +++++++++++++++++++
  2 files changed, 27 insertions(+), 5 deletions(-)
 
 diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
-index 1189150553608..937a0c513c174 100644
+index 1d5cdc987abd..62219f23f76a 100644
 --- a/net/sched/sch_taprio.c
 +++ b/net/sched/sch_taprio.c
-@@ -1151,11 +1151,6 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
+@@ -915,11 +915,6 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
  		list_for_each_entry(entry, &new->entries, list)
  			cycle = ktime_add_ns(cycle, entry->interval);
  
@@ -39,7 +43,7 @@
  		if (cycle < 0 || cycle > INT_MAX) {
  			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
  			return -EINVAL;
-@@ -1164,6 +1159,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
+@@ -928,6 +923,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
  		new->cycle_time = cycle;
  	}
  
@@ -48,14 +52,14 @@
 +		return -EINVAL;
 +	}
 +
- 	taprio_calculate_gate_durations(q, new);
- 
  	return 0;
+ }
+ 
 diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
-index 8f12f00a4f572..557fb074acf0c 100644
+index 08d4861c2e78..d04fed83332c 100644
 --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
 +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
-@@ -154,6 +154,28 @@
+@@ -132,6 +132,28 @@
              "echo \"1\" > /sys/bus/netdevsim/del_device"
          ]
      },
@@ -84,3 +88,6 @@
      {
          "id": "3e1e",
          "name": "Add taprio Qdisc with an invalid cycle-time",
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

