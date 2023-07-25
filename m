Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB01D761691
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjGYLk1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjGYLkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952CF1FD3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BBF96169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D666C433C7;
        Tue, 25 Jul 2023 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285213;
        bh=I0zl0RXdqBsOg6TnVwLCWc8XiNdABBhigcYd33eG3bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFqcCerI5moUsbTeRBXs0/O5AKHZWMB+14ISo28IF3eoETVunnc6akJaacBaDA9xz
         aK36tFVQf7Nsjnmpi8prbuFi99NXnQlpxKD3aA5JLqv3lkE2CMy6Xrj0SdhkIWI4Gh
         fI/KO+q00qC9901sITqEXuY2FVCdED8yTWSBNOaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinhong Zhu <jinhongzhu@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/313] scsi: qedf: Fix NULL dereference in error handling
Date:   Tue, 25 Jul 2023 12:44:08 +0200
Message-ID: <20230725104525.075415685@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index f864ef059d29e..858058f228191 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2914,9 +2914,8 @@ static int qedf_alloc_global_queues(struct qedf_ctx *qedf)
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



