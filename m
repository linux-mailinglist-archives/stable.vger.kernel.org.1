Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459547616DD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjGYLoY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjGYLnu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC8113
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F76D6167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40606C433C8;
        Tue, 25 Jul 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285423;
        bh=jCyfVEhU6vEmeCWsgLq+jwpt/9NF9ZDiTroh/Zk4hLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKgbm9QGaqN4BRfqiz8Zg49wjDRwwmet8FvV4qkRJAMG6DObfB89FIHuiKM0DHFSb
         aPLkD0VuyMO4cAL9pk4XZXV/W8pfNhcLTzFEwGwrbGiBpdnGuFAkUfjk6bBNxLYH7h
         HXF3qzgiQk239IWKQVjG0GM3w+VCOcXjgMpksc5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 200/313] scsi: qla2xxx: Fix error code in qla2x00_start_sp()
Date:   Tue, 25 Jul 2023 12:45:53 +0200
Message-ID: <20230725104529.664477600@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e579b007eff3ff8d29d59d16214cd85fb9e573f7 ]

This should be negative -EAGAIN instead of positive.  The callers treat
non-zero error codes the same so it doesn't really impact runtime beyond
some trivial differences to debug output.

Fixes: 80676d054e5a ("scsi: qla2xxx: Fix session cleanup hang")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 103288b0377e0..cbdc84fdc52c1 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3665,7 +3665,7 @@ qla2x00_start_sp(srb_t *sp)
 	spin_lock_irqsave(qp->qp_lock_ptr, flags);
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
-		rval = EAGAIN;
+		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
 		    "qla2x00_alloc_iocbs failed.\n");
 		goto done;
-- 
2.39.2



