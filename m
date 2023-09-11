Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A779BFBF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbjIKVOz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbjIKONh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A694DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89824C433C7;
        Mon, 11 Sep 2023 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441612;
        bh=sA8IZQz3pJ9aMwFGwXkYekvwr9qpePhhu37wJJCSf5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UubU0r2pGIWS2vvtgjYU1GCzXUZsB21oIFd/rOnFaPXH1UIUOFnEBxaPTvdK8rbcq
         oaIICQvzh/K9G0tTrMVUL10Anr+Ifwy/MUQEmlW2foBoj2pk/HFbLhY3uUL0VoMdfw
         Gu4qq4tJt3hQddBWqx5e3JwCbaojp9Ez33kiQwtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ming Qian <ming.qian@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 475/739] media: amphion: ensure the bitops dont cross boundaries
Date:   Mon, 11 Sep 2023 15:44:34 +0200
Message-ID: <20230911134704.411648657@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 5bd28eae48589694ff4e5badb03bf75dae695b3f ]

the supported_instance_count determine the instance index range,
it shouldn't exceed the bits number of instance_mask,
otherwise the bitops of instance_mask may cross boundaries

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 7863b7b53494c..2bb9f187e163c 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -88,6 +88,8 @@ static int vpu_core_boot_done(struct vpu_core *core)
 
 		core->supported_instance_count = min(core->supported_instance_count, count);
 	}
+	if (core->supported_instance_count >= BITS_PER_TYPE(core->instance_mask))
+		core->supported_instance_count = BITS_PER_TYPE(core->instance_mask);
 	core->fw_version = fw_version;
 	vpu_core_set_state(core, VPU_CORE_ACTIVE);
 
-- 
2.40.1



