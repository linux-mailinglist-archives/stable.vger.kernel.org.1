Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443376AF34
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjHAJpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjHAJpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6202D44
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD056150E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDFDC433C7;
        Tue,  1 Aug 2023 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883038;
        bh=ayWGq/45E8IlQD7a+uCQlhVOhAK3GKm4ap5vuUBnl1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OoDq1VXwc09Sz/5cdLw1YM7BQy5RmLayYvdkV/rIGvhcGdu7dlzhmey3xhfK8+dnh
         qxlyUYZTYsmBaqK0ht7VEDYvEKI0B1LYcJwpjEaB9oNtYGxJMRI0EqihZBM9E72+5+
         Kk0Ls7EznjRNiPE7+yo+y3PNYYubgQUS0TvWBucc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 064/239] iavf: fix potential deadlock on allocation failure
Date:   Tue,  1 Aug 2023 11:18:48 +0200
Message-ID: <20230801091927.975379940@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit a2f054c10bef0b54600ec9cb776508443e941343 ]

In iavf_adminq_task(), if kzalloc() fails to allocate the event.msg_buf,
the function will exit without releasing the adapter->crit_lock.

This is unlikely, but if it happens, the next access to that mutex will
deadlock.

Fix this by moving the unlock to the end of the function, and adding a new
label to allow jumping to the unlock portion of the function exit flow.

Fixes: fc2e6b3b132a ("iavf: Rework mutexes for better synchronisation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ba96312feb505..6c25d240e70bc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3300,7 +3300,7 @@ static void iavf_adminq_task(struct work_struct *work)
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
 	if (!event.msg_buf)
-		goto out;
+		goto unlock;
 
 	do {
 		ret = iavf_clean_arq_element(hw, &event, &pending);
@@ -3315,7 +3315,6 @@ static void iavf_adminq_task(struct work_struct *work)
 		if (pending != 0)
 			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
-	mutex_unlock(&adapter->crit_lock);
 
 	if (iavf_is_reset_in_progress(adapter))
 		goto freedom;
@@ -3359,6 +3358,8 @@ static void iavf_adminq_task(struct work_struct *work)
 
 freedom:
 	kfree(event.msg_buf);
+unlock:
+	mutex_unlock(&adapter->crit_lock);
 out:
 	/* re-enable Admin queue interrupt cause */
 	iavf_misc_irq_enable(adapter);
-- 
2.39.2



