Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D17B8A00
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbjJDSbL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244336AbjJDSbK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D6AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93BCC433CA;
        Wed,  4 Oct 2023 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444267;
        bh=Ifnhx01Ulu+l2AR3Gh9a9W5duLXd3uIOcxANodGt2+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX4b+vSgQsenjZBhIOjIF+QduvNHbmxNfoE2/YKMlTBJt/9R2fsJtCFpu1ltYZmjW
         M6S1QVwvVSpmBT0AU0S9ly/bHiPYYngpklW4o20ND+R5oXZoDCdrBtK2ZcV9HihFp6
         QL1vWarx54+HF4KW9+FbEEAiK3C188Z70cPjtBEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Timmy Tsai <timmtsai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 190/321] drm/amdgpu/soc21: dont remap HDP registers for SR-IOV
Date:   Wed,  4 Oct 2023 19:55:35 +0200
Message-ID: <20231004175238.033750131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 1832403cd41ca6b19b24e9d64f79cb08d920ca44 ]

This matches the behavior for soc15 and nv.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timmy Tsai <timmtsai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e5e5d68a4d702..1a5ffbf884891 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -786,7 +786,7 @@ static int soc21_common_hw_init(void *handle)
 	 * for the purpose of expose those registers
 	 * to process space
 	 */
-	if (adev->nbio.funcs->remap_hdp_registers)
+	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
 		adev->nbio.funcs->remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
-- 
2.40.1



