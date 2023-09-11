Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8179B992
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbjIKVOo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbjIKOCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC81CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B32C433C9;
        Mon, 11 Sep 2023 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440915;
        bh=tezoR5aUeIwCNqsg5JuCloz2h19P0UQQCEGg9BcrDN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUKnPfVsJv9+7g0nsje80HMj0pUimw9qtE13+4FGDak9oFMBN6F3m8cQ8biOk0Lvt
         HsSgK39pthEa7HRXpDaKjvw1Ag69mXAnQ+mD26JIjhghH4t2e7cz1yL1Us8glNngE0
         puf57LcJIeYUBKTlhmFgsqPFuhEOtyphOpGZBmuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 194/739] pds_core: protect devlink callbacks from fw_down state
Date:   Mon, 11 Sep 2023 15:39:53 +0200
Message-ID: <20230911134656.609804397@linuxfoundation.org>
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 91202ce78fcd070982a115f0bf6f328af619aa00 ]

Don't access structs that have been cleared when in the fw_down
state and the various structs have been cleaned and are waiting
to recover.  This caused a panic on rmmod when already in fw_down
and devlink_param_unregister() tried to check the parameters.

Fixes: 40ced8944536 ("pds_core: devlink params for enabling VIF support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230824161754.34264-2-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 9c6b3653c1c7c..d9607033bbf21 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -10,6 +10,9 @@ pdsc_viftype *pdsc_dl_find_viftype_by_id(struct pdsc *pdsc,
 {
 	int vt;
 
+	if (!pdsc->viftype_status)
+		return NULL;
+
 	for (vt = 0; vt < PDS_DEV_TYPE_MAX; vt++) {
 		if (pdsc->viftype_status[vt].dl_id == dl_id)
 			return &pdsc->viftype_status[vt];
-- 
2.40.1



