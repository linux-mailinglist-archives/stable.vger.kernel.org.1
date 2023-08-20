Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE0781EAF
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHTP0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHTPZ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 11:25:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88104686
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:23:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c3df710bdso304267f8f.1
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544987; x=1693149787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLSxlsy87hcasRJmuGTJaVLeiItQlaN8QE5VZMp0yL4=;
        b=Pa5yqh/IcChza6SIKJKAfM5dfE9CHgJuxcBVqz9Qrpw5SBR45EPi87dz0126SE2V/u
         f2/ST09WioBkG1a8Hc5bakXx7TAPkjXnLqUpISluuL+zJQlX/gx6dtmUohh1kvR/FkGt
         Y6g1Gk4ef05WaT1Tv8qD7qCCVjpU8JOoMsNg8p2VTPTKPGXkFOKeutMaL9gDrCHe+GOA
         HKzNNjS3X3HeMaQXODuyJ5VcuR90AQvLHmNBCfBFz9hYtxbvrC7iGAKSD0eoTILxZv3A
         zCsftidzJ2QorQD9GLG4Ztq5UnPLjCurwMBTnbM1noMp5txz1ywEjGpCLEwqHwvES9Fk
         2Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544987; x=1693149787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLSxlsy87hcasRJmuGTJaVLeiItQlaN8QE5VZMp0yL4=;
        b=RP9hPV58xvG/maIrNIVAaoX/JdIS0GC7ihGQb3syID5gmdB/U4+Qf61gUlWFesDcxN
         Po6C2bPK8iFScHvoLNpg2L5wDDo2AJcNd5R9l+m1WviBZ2hbWGr7456zf5wBB5DTmUQk
         nmwqwFqQIRSKaiVFrRTDKrLZnqqbB7Vu1yETjLbf76sqlM6XN7fANMfPPeSM0YHnkNe+
         rB34cCYpehy2m/JbXlMMdBLkf+q3jCTE+pFgO5iIVKlkVZKV4vIemet6Fs2udtPbszWs
         CCUrZo8RBh1xrxklDSOjagXPELLOt2TvH8BkCFD8v+MBGyxeSIFZRH80se174Biod/ex
         rgew==
X-Gm-Message-State: AOJu0YwAM+woTKtLZ2CyuY1hVoVhB1UH9Tqjy4AZQeTVWSdy5tEX5jdm
        wxQaj2SaydWEz524wTFyUmVbL70NAzAyxnyhqLk=
X-Google-Smtp-Source: AGHT+IE32G8w72ksUDK+nWjkkSgh68TATPAsonJHAJ5xVbrQvBdZcIsen56O99uNCh453PwPPOBZGw==
X-Received: by 2002:adf:f50b:0:b0:319:6afc:7a3c with SMTP id q11-20020adff50b000000b003196afc7a3cmr2829992wro.10.1692544987515;
        Sun, 20 Aug 2023 08:23:07 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:07 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 4/6] cgroup/cpuset: Iterate only if DEADLINE tasks are present
Date:   Sun, 20 Aug 2023 16:22:56 +0100
Message-Id: <20230820152258.518128-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152258.518128-1-qyousef@layalina.io>
References: <20230820152258.518128-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit c0f78fd5edcf29b2822ac165f9248a6c165e8554 upstream.

update_tasks_root_domain currently iterates over all tasks even if no
DEADLINE task is present on the cpuset/root domain for which bandwidth
accounting is being rebuilt. This has been reported to introduce 10+ ms
delays on suspend-resume operations.

Skip the costly iteration for cpusets that don't contain DEADLINE tasks.

Reported-by: Qais Yousef (Google) <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit c0f78fd5edcf29b2822ac165f9248a6c165e8554)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 00821ed3d300..63c8939503cb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -966,6 +966,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.34.1

