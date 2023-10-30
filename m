Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429BF7DB8F2
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjJ3L3p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjJ3L3o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:29:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881FB3
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:29:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f6efd64so6045023e87.2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1698665380; x=1699270180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaQVDnTFq4Ql5c0acHpHy/AmWkkpS8a8E13/426/yFA=;
        b=l/GCWbVWgGBpLzl1WcnYtBjhnAHu3TJU4dOyfMKj6cVPZ6JS1NNEcOK4Mozma+6TvJ
         b9UQwPyflemEsg4RXLdicBu8zdFG04XPFaHsmxW80jh2NPfv+u02Zi7CkMFEmop41HG7
         6K7d71X08geNKmt8uZO7yJYK2BF9TIgOI2UdffGhWZciriI6axrUFOn9RP4TBmtoeOQy
         5pZidz2YhoOgp9IWq4hob2jZhd2kGCJfFb9mZaUdOmfWs+mEMyybZAE0Tn77bU3NZKc5
         Q86bwILxra0JA1Zu9Aus+8idZz9p1c8dntIZv/L1JMoQy4YSCxczFRciPPjn9f2LaQJ9
         PnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665380; x=1699270180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaQVDnTFq4Ql5c0acHpHy/AmWkkpS8a8E13/426/yFA=;
        b=qIViHPFEz1syzCeVNr7EBwsXGzbNxL24eQz2q2Fed9gWxRkBzhgHP9ZHuff2ycs7LU
         tNnJqLq/SdM8PMncHNhBm0pbfie/Taa3U4qGGI+7j39VedtVyJ8IzzCSPpNojw5HjLNZ
         cZGz5eCAgy+g50jT9AAz6lG3aBuUz4mOOsNhJL9cCIDJ6Y0kyYHU2k4jqv0Mwl8BBn6k
         CMX3Jh9IuFbGn5BLa9LdFeE9VCNutuhsFfi99X/1BvI0f8J/XJleVDST6+3ELTnEGVAG
         BnfU4cNp222QzsXcBfkugwmGhfY/mC9T2lFwmhq0MOjLXhiakVo/N5LLePvYXzusJLa6
         m+YQ==
X-Gm-Message-State: AOJu0Yzt4lEopTU3ODJUh+bJ509h9CJU+L9g7evJHMDAIWE3KuatBQYY
        LLxAg6d+WySOuJj/VQxmPCM4F0KB2Ag8Antxg3c=
X-Google-Smtp-Source: AGHT+IEzVDHjdArWSLPCsLpgfRc9erUDnLEsBGAB9YgyjWuMrj2yQDWL2udEooca0ucR253TtNF2dg==
X-Received: by 2002:ac2:4ecb:0:b0:507:a6b2:c63e with SMTP id p11-20020ac24ecb000000b00507a6b2c63emr6147826lfr.53.1698665379885;
        Mon, 30 Oct 2023 04:29:39 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id l5-20020ac24305000000b005041b7735dbsm1379433lfh.53.2023.10.30.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:29:39 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     stable@vger.kernel.org
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Radoslaw Biernacki <rad@chromium.org>,
        Manasi Navare <navaremanasi@chromium.org>
Subject: [PATCH 5.4.y] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Mon, 30 Oct 2023 12:29:04 +0100
Message-ID: <20231030112904.142092-1-lma@semihalf.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <2023102723-steerable-trench-2f00@gregkh>
References: <2023102723-steerable-trench-2f00@gregkh>
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
index 1ff13af13324..7b396b7277ee 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1806,14 +1806,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
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

