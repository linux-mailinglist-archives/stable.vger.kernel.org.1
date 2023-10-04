Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062CE7B89F1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbjJDSap (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbjJDSao (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FEC4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97466C433C9;
        Wed,  4 Oct 2023 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444239;
        bh=uTI89RvTb44+XuGm2pkIGJG7TBEfIWUo/gRlKcEIZOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOkz73cxBse4aHHxR0F/p3Ppn0Smy4E3km5UgnSSfBHHs38q6ZEVKoiDkKavGukdp
         VEU8+HvJCTF3qMXqavC1mOma8N+48IO1mGNuI+hWrcm/IGR4o2aW7yAh1E0VMiVXae
         RQoHuCYgLRqvHy4n2AJRqMsSrg8q6TSYH3uGWzuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joao Alves <joao.alves@arm.com>,
        Olivier Deprez <olivier.deprez@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 151/321] firmware: arm_ffa: Dont set the memory region attributes for MEM_LEND
Date:   Wed,  4 Oct 2023 19:54:56 +0200
Message-ID: <20231004175236.253605204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 9dda1178479aa0a73fe0eaabfe2d9a1c603cfeed ]

As per the FF-A specification: section "Usage of other memory region
attributes", in a transaction to donate memory or lend memory to a single
borrower, if the receiver is a PE or Proxy endpoint, the owner must not
specify the attributes and the relayer will return INVALID_PARAMETERS
if the attributes are set.

Let us not set the memory region attributes for MEM_LEND.

Fixes: 82a8daaecfd9 ("firmware: arm_ffa: Add support for MEM_LEND")
Reported-by: Joao Alves <joao.alves@arm.com>
Reported-by: Olivier Deprez <olivier.deprez@arm.com>
Link: https://lore.kernel.org/r/20230919-ffa_v1-1_notif-v2-13-6f3a3ca3923c@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2109cd178ff70..121f4fc903cd5 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -397,6 +397,19 @@ static u32 ffa_get_num_pages_sg(struct scatterlist *sg)
 	return num_pages;
 }
 
+static u8 ffa_memory_attributes_get(u32 func_id)
+{
+	/*
+	 * For the memory lend or donate operation, if the receiver is a PE or
+	 * a proxy endpoint, the owner/sender must not specify the attributes
+	 */
+	if (func_id == FFA_FN_NATIVE(MEM_LEND) ||
+	    func_id == FFA_MEM_LEND)
+		return 0;
+
+	return FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK | FFA_MEM_INNER_SHAREABLE;
+}
+
 static int
 ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		       struct ffa_mem_ops_args *args)
@@ -413,8 +426,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	mem_region->tag = args->tag;
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
-	mem_region->attributes = FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK |
-				 FFA_MEM_INNER_SHAREABLE;
+	mem_region->attributes = ffa_memory_attributes_get(func_id);
 	ep_mem_access = &mem_region->ep_mem_access[0];
 
 	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
-- 
2.40.1



