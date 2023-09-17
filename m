Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF57A39FA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbjIQT4v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240298AbjIQT4q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C856F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC3C433C8;
        Sun, 17 Sep 2023 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980600;
        bh=rkGtkdCl5XhERT2Y/rhlof33Dfs9We53wkXc/S7L8TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmQvLAaPLmIyTPPtHFYXI9ZlDcz2eLrSHCJ01SzfGLjRM5B+IL1Hqu8FNg34gsjrX
         3nfYYiKBKsE3gpUFabko/KPcNc3ZYhqGBm30MxbOg0BGI/8rFm/6iKBlbSgnsAD9kz
         MAvoY/0Z6dS2vBSiGiRNAZhkmJLwOQDpoSGt8uuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jay Cornwall <jay.cornwall@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 240/285] drm/amdkfd: Add missing gfx11 MQD manager callbacks
Date:   Sun, 17 Sep 2023 21:14:00 +0200
Message-ID: <20230917191059.683637788@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jay Cornwall <jay.cornwall@amd.com>

commit e9dca969b2426702a73719ab9207e43c6d80b581 upstream.

mqd_stride function was introduced in commit 2f77b9a242a2
("drm/amdkfd: Update MQD management on multi XCC setup")
but not assigned for gfx11. Fixes a NULL dereference in debugfs.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -437,6 +437,7 @@ struct mqd_manager *mqd_manager_init_v11
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -452,6 +453,7 @@ struct mqd_manager *mqd_manager_init_v11
 		mqd->destroy_mqd = kfd_destroy_mqd_cp;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -481,6 +483,7 @@ struct mqd_manager *mqd_manager_init_v11
 		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
 		mqd->is_occupied = kfd_is_occupied_sdma;
 		mqd->mqd_size = sizeof(struct v11_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
 #endif


