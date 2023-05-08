Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE16FAC77
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjEHLYh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjEHLYZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB513A5C8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A573A62D37
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C14C433D2;
        Mon,  8 May 2023 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545064;
        bh=1gHjVbiwzno4iGhhE6/DY9gqDFfRJvPcx5ZnRCQCNOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXUHSi+2tiP9g0OMsEGmmCIMXtT77dSD69I+f302ACwZ7CY8X/liHzT7APtQy2zcZ
         QVNvZv0zoRJET3Qpw2fB1q3Xo/JUDpxH3KgXadVbdwq6ZMH49/Xw8ZIwy3EUPLWezp
         Du8gP+6qIfWL03clww2dsuDBJ2SeLWoOhzjyP+WU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Natalia Petrova <n.petrova@fintech.ru>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 581/694] RDMA/rdmavt: Delete unnecessary NULL check
Date:   Mon,  8 May 2023 11:46:56 +0200
Message-Id: <20230508094453.817353377@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Natalia Petrova <n.petrova@fintech.ru>

[ Upstream commit b73a0b80c69de77d8d4942abb37066531c0169b2 ]

There is no need to check 'rdi->qp_dev' for NULL. The field 'qp_dev'
is created in rvt_register_device() which will fail if the 'qp_dev'
allocation fails in rvt_driver_qp_init(). Overwise this pointer
doesn't changed and passed to rvt_qp_exit() by the next step.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acb0cc7ecc1 ("IB/rdmavt: Initialize and teardown of qpn table")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Link: https://lore.kernel.org/r/20230303124408.16685-1-n.petrova@fintech.ru
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 3acab569fbb94..2bdc4486c3daa 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -464,8 +464,6 @@ void rvt_qp_exit(struct rvt_dev_info *rdi)
 	if (qps_inuse)
 		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
 			   qps_inuse);
-	if (!rdi->qp_dev)
-		return;
 
 	kfree(rdi->qp_dev->qp_table);
 	free_qpn_table(&rdi->qp_dev->qpn_table);
-- 
2.39.2



