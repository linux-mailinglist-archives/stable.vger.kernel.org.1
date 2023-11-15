Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD87ECF20
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjKOTqe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjKOTqc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3AAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35A4C433C7;
        Wed, 15 Nov 2023 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077588;
        bh=Qol+q42kiNHjv0kMjCPV5Gei92cIXJy36xlrnjyJ+J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBkKw1LUgcp0RgEZ0UUjhpXEkUql01TfJqjGrlf8Y20CoB4RfmwL/NYld+8kQcXAc
         Fh/9Dey8dBXqyAxAHp59yI/c+kDcxB2sN2oYENFWNe+QOCjGmsMWMyPaarRitcbNo1
         vZSrn1KFZy/s2jX/g50G+WPG3REkz6VncC0XHUeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 374/603] dlm: be sure we reset all nodes at forced shutdown
Date:   Wed, 15 Nov 2023 14:15:19 -0500
Message-ID: <20231115191639.358158904@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit e759eb3e27e5b624930548f1c0eda90da6e26ee9 ]

In case we running in a force shutdown in either midcomms or lowcomms
implementation we will make sure we reset all per midcomms node
information.

Fixes: 63e711b08160 ("fs: dlm: create midcomms nodes when configure")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/midcomms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 4ad71e97cec2a..6bc8d7f89b2cc 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1405,10 +1405,16 @@ void dlm_midcomms_shutdown(void)
 			midcomms_shutdown(node);
 		}
 	}
-	srcu_read_unlock(&nodes_srcu, idx);
-	mutex_unlock(&close_lock);
 
 	dlm_lowcomms_shutdown();
+
+	for (i = 0; i < CONN_HASH_SIZE; i++) {
+		hlist_for_each_entry_rcu(node, &node_hash[i], hlist) {
+			midcomms_node_reset(node);
+		}
+	}
+	srcu_read_unlock(&nodes_srcu, idx);
+	mutex_unlock(&close_lock);
 }
 
 int dlm_midcomms_close(int nodeid)
-- 
2.42.0



