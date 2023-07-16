Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EE87552A2
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGPUKG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGPUKE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405A9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73DB60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA2C433C7;
        Sun, 16 Jul 2023 20:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538203;
        bh=kP8acd/ehKr3faLMmqod5bdajN5MCMDWr7lHafe/nE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kThkDxrBhq/n4/Ms6n8EooXzRsf2GtEbrTeArqZtYaHiIZ1EXrFfDqTkHuYzpUAM0
         3DcJhPB1EhDeaolS2q/zavTb6Zt4gcVyfIEtf5Fa73vj/qXJO7Hnbp4PSRW/ziZ03O
         byriFgpPMOXLgzmD117Mt6EaVlcz2jfRYhpeh7O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 367/800] drm/amdkfd: Fix potential deallocation of previously deallocated memory.
Date:   Sun, 16 Jul 2023 21:43:40 +0200
Message-ID: <20230716194957.601952933@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index fdbfd725841ff..51b53110341bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -115,18 +115,19 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
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



