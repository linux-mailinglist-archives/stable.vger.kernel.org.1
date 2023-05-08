Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99896FAAE2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjEHLHq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjEHLHD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CC29C91
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA2E62AB4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF23FC433EF;
        Mon,  8 May 2023 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543980;
        bh=x1pjOODMCUuiKQWmap/VWXnW8YJAWpinnYjZV3yR8vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDFaW84yupnMN9YkMjE3vly2DF5d+c42bPakS73YOB0Y117lJs49hmHL7g8TMCvqj
         lKKSJUhX3TOtLbqEVc3XqsEgrnmB+P65+XbCx0Jdzwv71DdeqaRcRVYCCMTbsqQmNU
         4YBgQARlxaOmfHkQfUPqqpErnOGbsCIUNlEQ2+Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 246/694] gpu: host1x: Fix potential double free if IOMMU is disabled
Date:   Mon,  8 May 2023 11:41:21 +0200
Message-Id: <20230508094440.294859110@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 8466ff24a37a9a18fb935e90dda64f049131ae28 ]

If context device has no IOMMU, the 'cdl->devs' is freed in
error path, but host1x_memory_context_list_init() doesn't
return an error code, so the module can be loaded successfully,
when it's unloading, the host1x_memory_context_list_free() is
called in host1x_remove(), it will cause double free. Set the
'cdl->devs' to NULL after freeing it to avoid double free.

Fixes: 8aa5bcb61612 ("gpu: host1x: Add context device management code")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 8beedcf080abd..5ec18315ff9fe 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -83,6 +83,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 		device_del(&cdl->devs[i].dev);
 
 	kfree(cdl->devs);
+	cdl->devs = NULL;
 	cdl->len = 0;
 
 	return err;
-- 
2.39.2



