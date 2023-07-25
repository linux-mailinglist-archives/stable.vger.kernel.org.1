Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156EB761461
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjGYLSm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGYLSk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DBAA6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBF461683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2F0C433C8;
        Tue, 25 Jul 2023 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283919;
        bh=QSuO8gWqIMoCCihpWLzBXRl+xKT/B3arpaj+Sk4wkSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tV5k67Ifcdi/xM8fd7HSrd/Oj4F+0KGxkCglErQx4s0REzyH56OzLmt0jgVe+Weo+
         7bQXNQFXfmyjLBDhHA39ULO0cg+xkjkIZf9vpsPNl46hGAqQXmfMve2aPOH6hT+k9E
         Pmpi56ZlPgfOXkyL+sGM2oIiwna7+8xFJpnydSwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 152/509] drm/amdkfd: Fix potential deallocation of previously deallocated memory.
Date:   Tue, 25 Jul 2023 12:41:31 +0200
Message-ID: <20230725104600.681494652@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit cabbdea1f1861098991768d7bbf5a49ed1608213 ]

Pointer mqd_mem_obj can be deallocated in kfd_gtt_sa_allocate().
The function then returns non-zero value, which causes the second deallocation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1f8f0d17d40 ("drm/amdkfd: Move non-sdma mqd allocation out of init_mqd")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 3b6f5963180d5..dadeb2013fd9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -113,18 +113,19 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
 			&(mqd_mem_obj->gtt_mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
+
+		if (retval) {
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(kfd, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
-	}
-
-	if (retval) {
-		kfree(mqd_mem_obj);
-		return NULL;
+		if (retval)
+			return NULL;
 	}
 
 	return mqd_mem_obj;
-
 }
 
 static void init_mqd(struct mqd_manager *mm, void **mqd,
-- 
2.39.2



