Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D247BDE7D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346592AbjJINT5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376925AbjJINN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CDB9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14145C433C7;
        Mon,  9 Oct 2023 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857234;
        bh=lo/fZj8GVtJdVdkbnelnTyYY0TJhZ77y7dVazwlrwiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMCuhyhSIfZFc//8n6C4t8BVwoOQEaRvGrudmY0s/mR1VH/9q1UPNI3ab0KcP3ezx
         +sRl2g0s2s2eGralHYmcWfQeuDGlwjDcfXqG97b4edSdfHaAjdf7LF++GcOBnmMolp
         fXeiTSDby2mEseuOEVdr+8sQe2843s7ukCDa7N2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Parav Pandit <parav@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 6.5 141/163] RDMA/core: Require admin capabilities to set system parameters
Date:   Mon,  9 Oct 2023 15:01:45 +0200
Message-ID: <20231009130127.937890172@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

commit c38d23a54445f9a8aa6831fafc9af0496ba02f9e upstream.

Like any other set command, require admin permissions to do it.

Cc: stable@vger.kernel.org
Fixes: 2b34c5580226 ("RDMA/core: Add command to set ib_core device net namspace sharing mode")
Link: https://lore.kernel.org/r/75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/nldev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2529,6 +2529,7 @@ static const struct rdma_nl_cbs nldev_cb
 	},
 	[RDMA_NLDEV_CMD_SYS_SET] = {
 		.doit = nldev_set_sys_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
 	},
 	[RDMA_NLDEV_CMD_STAT_SET] = {
 		.doit = nldev_stat_set_doit,


