Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2E7DB8E5
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJ3LWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJ3LWR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:22:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF144B7
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:22:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c1936fd5so6106442e87.1
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1698664933; x=1699269733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FprxzbI6BVQNgDI0NYQAcKjG+fc5xore7a8+UBbKX4c=;
        b=paVEpazkOFENpUS7tn27NMHDAAwG1Fp5RwgSC93HvcwGuCVk24mkXyv8rfW3tmveOB
         dEUhkYPtw4EGowHlabwh5YZwleeak4XDjNn+YRgj5efqQ3xoRUC+24Skwa2YwIbnHspT
         eQyQjAhuLvBlkXwVhlXXl3Aef81pzfBGqJpHcRj4z/GwTE2xfQ8C9yTgW32trB/bmUZR
         dLRltwamggqQA08n450aFWNx9JwQ/aIk0s0oDS4+ggLq8if9HmNXqMfxAIcdeTejTtyh
         pbFOxuxUo0U6wtbml/K5TmRAhXa5AmnRpfnIFi+3pJkN49m0QCiz1bM3amdkLUc6Twnh
         4Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698664933; x=1699269733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FprxzbI6BVQNgDI0NYQAcKjG+fc5xore7a8+UBbKX4c=;
        b=hxbnMkaTRCidFBXNNhZ/ONKHjLL3XSSMhpkAmnU08cw0pOaDitotPCW2h6qqL+bW8t
         thC29hLKcDknWOQYdVthUOpM5zP7tv03jTOS2c5J94S3ANUUJJgsvaKAvgybYpr1VEU2
         guEGm414MLt9MamIdtjvacEo6H/pkGCl7ZB91HJDrl2kRgoulKx03BJF3Crzue1y7eh0
         A8zw7x3fBX2rVFz7HMwFIyTc3TSkbZ+D0/RGOxxhRCXrTqG0uivjISbnSNzb8dB/FLUn
         lD4ZP2CGMYEb/OzZ+xd/o06Bp+Ja2++ogfuak0w44D4xfzEih1vuBze0JLKFbQBLqarT
         zqoA==
X-Gm-Message-State: AOJu0YxCmiULMticY65RSIeamKwe+G1N9BmR2zHoTnsoHLuTgnmttW2B
        8kFD9yHTNZzN5hzjaUca4x3QZw5kwUcUjcepSAE=
X-Google-Smtp-Source: AGHT+IEz7reEqWFOUI5rj33H7xXhv/c1K1V8OKbIfrsL1y0CcBB/oJZdOqxtm8XZWnbNaYma0J5AIQ==
X-Received: by 2002:a05:6512:2247:b0:504:33ff:156a with SMTP id i7-20020a056512224700b0050433ff156amr4292147lfu.11.1698664932369;
        Mon, 30 Oct 2023 04:22:12 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id l11-20020a19c20b000000b00507ae0a5ea8sm1420559lfc.16.2023.10.30.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:22:11 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     stable@vger.kernel.org
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Radoslaw Biernacki <rad@chromium.org>,
        Manasi Navare <navaremanasi@chromium.org>
Subject: [PATCH 4.14.y] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Mon, 30 Oct 2023 12:21:29 +0100
Message-ID: <20231030112129.137767-1-lma@semihalf.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <2023102726-arousal-ransack-d969@gregkh>
References: <2023102726-arousal-ransack-d969@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

As drm_dp_get_mst_branch_device_by_guid() is called from
drm_dp_get_mst_branch_device_by_guid(), mstb parameter has to be checked,
otherwise NULL dereference may occur in the call to
the memcpy() and cause following:

[12579.365869] BUG: kernel NULL pointer dereference, address: 0000000000000049
[12579.365878] #PF: supervisor read access in kernel mode
[12579.365880] #PF: error_code(0x0000) - not-present page
[12579.365882] PGD 0 P4D 0
[12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
...
[12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
[12579.365899] RIP: 0010:memcmp+0xb/0x29
[12579.365921] Call Trace:
[12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
[12579.365930] drm_dp_mst_up_req_work+0x137/0x416
[12579.365933] process_one_work+0x1d0/0x419
[12579.365935] worker_thread+0x11a/0x289
[12579.365938] kthread+0x13e/0x14f
[12579.365941] ? process_one_work+0x419/0x419
[12579.365943] ? kthread_blkcg+0x31/0x31
[12579.365946] ret_from_fork+0x1f/0x30

As get_mst_branch_device_by_guid_helper() is recursive, moving condition
to the first line allow to remove a similar one for step over of NULL elements
inside a loop.

Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to only mst branch")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Reviewed-by: Radoslaw Biernacki <rad@chromium.org>
Signed-off-by: Manasi Navare <navaremanasi@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230922063410.23626-1-lma@semihalf.com
(cherry picked from commit 3d887d512494d678b17c57b835c32f4e48d34f26)
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 64faa70a9dd9..879638e6bea4 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1268,14 +1268,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
 
+	if (!mstb)
+		return NULL;
+
 	if (memcmp(mstb->guid, guid, 16) == 0)
 		return mstb;
 
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (!port->mstb)
-			continue;
-
 		found_mstb = get_mst_branch_device_by_guid_helper(port->mstb, guid);
 
 		if (found_mstb)
-- 
2.42.0.820.g83a721a137-goog

