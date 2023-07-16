Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2154C75554B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGPUj3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjGPUj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290EAAB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B13CF60DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB0EC433C8;
        Sun, 16 Jul 2023 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539967;
        bh=xFGiy8HkXKZiklmAa5tGGltHHve2Sf6Oc+0wcePUEcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFK7D6oJInbnPFq9xpWnWB+T82yKmmxpo5eEkVAuPwEgCMyJb/4DVdf8E32Nk93Rd
         b3f833dOzxXjOe6cYJkbdC1M0DiA9yoNHYU4/yN3AHWieo8E8q2Q6VkY/+MYFiSGuj
         r9xx/Q8lgbZi7FjdNbFxPj7ZnUYnLIS6Ke9u/KS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 168/591] driver: soc: xilinx: use _safe loop iterator to avoid a use after free
Date:   Sun, 16 Jul 2023 21:45:07 +0200
Message-ID: <20230716194928.211279758@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit c58da0ba3e5c86e51e2c1557afaf6f71e00c4533 ]

The hash_for_each_possible() loop dereferences "eve_data" to get the
next item on the list.  However the loop frees eve_data so it leads to
a use after free.  Use hash_for_each_possible_safe() instead.

Fixes: c7fdb2404f66 ("drivers: soc: xilinx: add xilinx event management driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/761e0e4a-4caf-4a71-8f47-1c6ad908a848@kili.mountain
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index c76381899ef49..f9d9b82b562da 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -192,11 +192,12 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 	struct registered_event_data *eve_data;
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
+	struct hlist_node *tmp;
 
 	is_need_to_unregister = false;
 
 	/* Check for existing entry in hash table for given cb_type */
-	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
+	hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, PM_INIT_SUSPEND_CB) {
 		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
 			/* Delete the list of callback */
 			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
@@ -228,11 +229,12 @@ static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
 	u64 key = ((u64)node_id << 32U) | (u64)event;
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
+	struct hlist_node *tmp;
 
 	is_need_to_unregister = false;
 
 	/* Check for existing entry in hash table for given key id */
-	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
+	hash_for_each_possible_safe(reg_driver_map, eve_data, tmp, hentry, key) {
 		if (eve_data->key == key) {
 			/* Delete the list of callback */
 			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
-- 
2.39.2



