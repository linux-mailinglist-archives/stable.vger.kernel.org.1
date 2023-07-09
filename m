Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE674C38E
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjGILdr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGILdg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB618C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50BD60BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F270CC433C8;
        Sun,  9 Jul 2023 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902414;
        bh=Be224LAlFle4iKmpYDwf/Pi+CcItcObuC7IlieF5R3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2bS8rEcPjqTnkSY8Mf1sbxVQbtwPjjQL4DGAKCdYN1F7XGc6iyezq1usBNV1xkFa
         4D08wQRmVOPoJrKj+3ejYA8ivSIX2VaXbP1f1T2d3w5NJ/s1Ue+QwxIZ2I83yaBtLU
         u9jD4G0r4qYbwoI/9v59T/CHk/2UbtEgVKiF68+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinhong Zhu <jinhongzhu@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 341/431] scsi: qedf: Fix NULL dereference in error handling
Date:   Sun,  9 Jul 2023 13:14:49 +0200
Message-ID: <20230709111459.163380714@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Jinhong Zhu <jinhongzhu@hust.edu.cn>

[ Upstream commit f025312b089474a54e4859f3453771314d9e3d4f ]

Smatch reported:

drivers/scsi/qedf/qedf_main.c:3056 qedf_alloc_global_queues()
warn: missing unwind goto?

At this point in the function, nothing has been allocated so we can return
directly. In particular the "qedf->global_queues" have not been allocated
so calling qedf_free_global_queues() will lead to a NULL dereference when
we check if (!gl[i]) and "gl" is NULL.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Jinhong Zhu <jinhongzhu@hust.edu.cn>
Link: https://lore.kernel.org/r/20230502140022.2852-1-jinhongzhu@hust.edu.cn
Reviewed-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 35e16600fc637..f2c7dd4db9c64 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3043,9 +3043,8 @@ static int qedf_alloc_global_queues(struct qedf_ctx *qedf)
 	 * addresses of our queues
 	 */
 	if (!qedf->p_cpuq) {
-		status = -EINVAL;
 		QEDF_ERR(&qedf->dbg_ctx, "p_cpuq is NULL.\n");
-		goto mem_alloc_failure;
+		return -EINVAL;
 	}
 
 	qedf->global_queues = kzalloc((sizeof(struct global_queue *)
-- 
2.39.2



