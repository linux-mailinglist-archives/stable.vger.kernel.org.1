Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BDB7033C8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbjEOQlY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbjEOQlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A472423E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CBC62858
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB78AC4339B;
        Mon, 15 May 2023 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168881;
        bh=XW1/T5OeDjqtg/b6YN1XMJduOneGCxaciek3jJrGBjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTot/z0c0ddNmqT6Gx955nq6cJZgT2Buih0ayihUVMPXzL5tfp7DGZqXAXiWlYre7
         +xu0jLZBLGOD+D4VMZE4NA89Qe7fhHswjyE8LiCv4kgiPPjOEpjwmxff0c3rP4+Jj6
         CvFhYgQ7ErrqmFvJMoxZY0z2xWN5zDn7ETxAl0Tw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/191] wifi: iwlwifi: mvm: check firmware response size
Date:   Mon, 15 May 2023 18:25:09 +0200
Message-Id: <20230515161709.870863156@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 13513cec93ac9902d0b896976d8bab3758a9881c ]

Check the firmware response size for responses to the
memory read/write command in debugfs before using it.

Fixes: 2b55f43f8e47 ("iwlwifi: mvm: Add mem debugfs entry")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230417113648.0d56fcaf68ee.I70e9571f3ed7263929b04f8fabad23c9b999e4ea@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 05b77419953ce..9540c874fc380 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1835,6 +1835,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (le32_to_cpu(rsp->status) != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
@@ -1912,6 +1917,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (rsp->status != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
-- 
2.39.2



