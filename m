Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD29A781E87
	for <lists+stable@lfdr.de>; Sun, 20 Aug 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHTPZD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 20 Aug 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjHTPZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 20 Aug 2023 11:25:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACB646BA
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:24:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-319e93a1594so2340488f8f.1
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692545070; x=1693149870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wbdzu9Fe21KuQwmqV5eGRjnoq5R4hfHCD+0YtyLYwM=;
        b=VCpuFZSVGNRhJh4HGieNwuPdqITUj2x6mnc3sAKY+jTmYeKMSY3kaVtPvxw8zuspYa
         Jq/jyP1LITH8rx8WtbESpb+hx7W7asgQ2mp9woLhZ8Rq6SyRXsBZzKZscvMYi3Tn3R8d
         HQPtbxx8Sw+uSthcyqUEvvfJ3e6xRgJvz94B6Yf+apIcbPeXZ7fIvjjcZR78AV2tjv0x
         eXXy5Ba/qXMjLWi+0mtDoK2I0hhMTf9xHHOsgoFB2qjNVfaPaYBu/pojSZeGhHn70/lI
         5oD546XYoIbHfv/bFLqupElmvf1zlW30V1zatd9r0KByw2oQ9/gor1ZhA+guXfB0KtJC
         9MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692545070; x=1693149870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wbdzu9Fe21KuQwmqV5eGRjnoq5R4hfHCD+0YtyLYwM=;
        b=XmDRKKESeuskp0tPKGwAphNfMpa4T+eLfU3Qn7zV0UnTPGxIEPhEW+hpcc5c/5UphV
         f+0DGfk1Wtu4qbsbMcTw3AumuwnRNUHJqBbs87fsTMDeu/qZk3gmxsOarG5L12kZesbw
         98UozK2Nv+pwKbXbz/f/Spf4DfBKtuXy5fvhMDsblqsj3+zPndrNxlvRPi9JuHl5ZjKE
         2LWoNDnG5A1aWKGyhLh3SO/NLoKvI9YqOWQaKgOwekx6KxEDfy606UrbQy9PEsA36Hue
         uS/P3xf5vU2cKr82CygjtitELEJhGOI73bgXCP4f/Oho4mN+82de3b5Q3WaW2dwQSO80
         aj6Q==
X-Gm-Message-State: AOJu0Yy2EosPk9JCmj5c0uPCxTmpSOALnXYFznvHtqoAdF/u5N2UWLu1
        fI+Pe4gE30kPAF5+xw80VkS9k2PJmNgTu0zA+s4=
X-Google-Smtp-Source: AGHT+IFXOzbxdXTSGXom8ws2bvvogt8xrePe54f5DviXz5toXbUqryAu1o3m19bDJ/C5/r0gjaAnIw==
X-Received: by 2002:a05:6000:10b:b0:317:5c18:f31d with SMTP id o11-20020a056000010b00b003175c18f31dmr3330893wrx.35.1692545070131;
        Sun, 20 Aug 2023 08:24:30 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d4fcb000000b003141e629cb6sm9419257wrw.101.2023.08.20.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:24:29 -0700 (PDT)
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
Date:   Sun, 20 Aug 2023 16:24:15 +0100
Message-Id: <20230820152417.518806-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152417.518806-1-qyousef@layalina.io>
References: <20230820152417.518806-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 5f57829bb986..eca07ff71656 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1092,6 +1092,9 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
-- 
2.34.1

