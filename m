Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8086FA408
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEHJy1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjEHJyZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C82573F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD61562219
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C182CC433D2;
        Mon,  8 May 2023 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539663;
        bh=lb0ED0QQcGOo041iin7sch07zo3hfLjBX0QC2vgAKDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k27tL4XfdJK3Ux1OPZhVM6/ZICxuq2Q6bWf3JvLZsuuURxyHGeLqm7aVQKZoCj8IN
         drnecQOyMV/rxANlqi0xy1Ej2G5IwhuJIqsHrNYNRuUPPvQZxwX/Qrb7h4iEC8MDvY
         J3xTrMG3CR8z0lEIk/CyO19NpL+PQ2PijR90tGwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Songping <yusongping@huawei.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 097/611] swsmu/amdgpu_smu: Fix the wrong if-condition
Date:   Mon,  8 May 2023 11:38:59 +0200
Message-Id: <20230508094425.361461265@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Songping <yusongping@huawei.com>

commit 484d7dcc709da46a5976c9530eeff931e9ecba82 upstream.

The logical operator '&&' will make
smu->ppt_funcs->set_gfx_power_up_by_imu segment fault when
smu->ppt_funcs is NULL.

Signed-off-by: Yu Songping <yusongping@huawei.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -161,7 +161,7 @@ int smu_get_dpm_freq_range(struct smu_co
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	if (!smu->ppt_funcs && !smu->ppt_funcs->set_gfx_power_up_by_imu)
+	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
 		return -EOPNOTSUPP;
 
 	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);


