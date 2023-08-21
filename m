Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB427832E2
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjHUUCU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjHUUCT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9E11C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6320164800
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708FCC433C7;
        Mon, 21 Aug 2023 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648135;
        bh=8wIZgmQ7cNiLTKgKaCmxKSyYTpIWjAijkUt80ywWrk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjTYZtCpDepvesvPjBt4X042y3rGUfBKtGwej0Jdz6fi/KGlY/6VOQS5a0bGhJymD
         sUHncumrvDQcHvFWmNJ7Zn7T+T2G0UGOGkmXw4wVZUErBIHoB/hEmpLVuCxW+RY3MV
         905pfLO5/CM/xJcor5+1lmmZgL1IzkNMJx4NiFug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moti Haimovski <mhaimovski@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 028/234] accel/habanalabs: fix mem leak in capture user mappings
Date:   Mon, 21 Aug 2023 21:39:51 +0200
Message-ID: <20230821194129.994374865@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

[ Upstream commit 314a7ffd7c196b27eedd50cb7553029e17789b55 ]

This commit fixes a memory leak caused when clearing the user_mappings
info when a new context is opened immediately after user_mapping is
captured and a hard reset is performed.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 1ec97da3dddb8..70fb2df9a93b8 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -13,6 +13,7 @@
 
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/habanalabs.h>
@@ -218,6 +219,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
+	vfree(hdev->captured_err_info.page_fault_info.user_mappings);
 	memset(&hdev->captured_err_info, 0, sizeof(hdev->captured_err_info));
 	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
-- 
2.40.1



