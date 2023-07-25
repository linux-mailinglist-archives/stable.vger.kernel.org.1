Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5013761661
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjGYLis (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjGYLiq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5501FD6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB2761655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723C3C433C8;
        Tue, 25 Jul 2023 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285116;
        bh=IR/ToLxYtni0XsFPgKGPY7T94qk9nUedCnHauGvdes4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1t1Op4jUvlnLjZ368tvEqLkIxA1biUe/Qk8pq9P6fm97AVe+YcW1BOymuR0kVIk/H
         uBxtazN8HxO0D25ZzjuTKZiEEhi8BImChK+6Tm0KsCjI26d5zU+ErH3pI/oJtaMBkT
         ug4l104CpE5h4foVi5q5SzxpTGfTe+p4CyYzXLdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 088/313] drm/amdkfd: Fix potential deallocation of previously deallocated memory.
Date:   Tue, 25 Jul 2023 12:44:01 +0200
Message-ID: <20230725104524.763753412@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
index d3380c5bdbdea..d978fcac26651 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -101,18 +101,19 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
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



