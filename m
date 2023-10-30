Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31217DB8D5
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJ3LNm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3LNl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 07:13:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1FB3
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:13:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso23580091fa.2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1698664414; x=1699269214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii+ONr4jksPzt35CYOsqscxWBu8UX3dQUl5Kcpmf7ek=;
        b=p/BCKU2V65W+AjAjOgjqA209fkfDRia44NLrL1JVCATZ4UgzQMXf26ktqcUkq2UxIs
         OYJPgNlPZVR794UIKk/UKcelaxPzyhjtK7LkElKR0ZCwz6+AZ5hXZmeaRoMJBoyxKv48
         RW0G/d08C0d0UX3BTWEiPB95XTSvJxlh6LuoBzaqUQo+ZdGoOI6YCyTQrWo2PsvUz7jA
         aGYm8l1pnETkJhmmo/xEe86eM8/ztOZ9LSRL4XoxU2ERfskg7/ED01uSmOQlKWwZqE6m
         XAGSGIDS9NODJXLmPkkYrOy289O2DCUJOVI3Yas/AJPpZHNZ5wySVfFoObFYLaoP4p7E
         aTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698664414; x=1699269214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii+ONr4jksPzt35CYOsqscxWBu8UX3dQUl5Kcpmf7ek=;
        b=ZNox+4IG09rFXuBudpRvHM9IWRaUChtEyX6xQhsb0+tTTB436w9sE8XnL/ukl2+FTp
         UtC6YjQ2QslvU7Q4NAKcq2CWuems3i6GKZkm/ABscs+RHru0EedLfqwqnN7RV2jj8VPu
         wcqYX9A5vV7Tb8b821Bd7SzkrFw3/sJuU+HcbjK2mDDlowOkMi8p+ErwIFtUOHCgJw60
         erp1TLk/K79LZdzhpl9K5fz0i0pNSfQGD73cydXV0pOErnk2A76kKGQWX8n5CVKrWXku
         uYGHkosdH8ALxY9uQCJ2EAMTdK4PwB/c9bqRA8n7e0w6ggXv/SF8Z43xql+Oe4Sdt2wS
         Elcg==
X-Gm-Message-State: AOJu0Yyna9mLEDaPDqr4wAgg1bgrGPsCoWCKBEP5boyqyeRykC/um2Df
        p2lxD1WCgBo9+PeSvuzyPSBhhK7XKl5IeY2n3l8=
X-Google-Smtp-Source: AGHT+IEt0MfKopUOD89tfmxnUR+ucICNGc1pd7QGeErberuAjwTpzY9uY/iAH/VrO9uQGVw/YtpBIg==
X-Received: by 2002:a2e:87d1:0:b0:2c5:d3c:8f4d with SMTP id v17-20020a2e87d1000000b002c50d3c8f4dmr6548000ljj.13.1698664413852;
        Mon, 30 Oct 2023 04:13:33 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id e20-20020a2e8ed4000000b002bfe8537f37sm1201544ljl.33.2023.10.30.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 04:13:33 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     stable@vger.kernel.org
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Radoslaw Biernacki <rad@chromium.org>,
        Manasi Navare <navaremanasi@chromium.org>
Subject: [PATCH 4.19.y] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Mon, 30 Oct 2023 12:12:52 +0100
Message-ID: <20231030111252.133311-1-lma@semihalf.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <2023102725-spiral-unglue-4f7c@gregkh>
References: <2023102725-spiral-unglue-4f7c@gregkh>
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
index 603ebaa6a7ed..8b994886e5b1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1308,14 +1308,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
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

