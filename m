Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94AB7A3908
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjIQToD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbjIQTnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:43:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC3DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:43:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AADC433C8;
        Sun, 17 Sep 2023 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979815;
        bh=cdrEBvqpyUCSjpTzNEQV5yphANDHyXE8A9QLU25yA+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVx0npt5Nkxg63y3oc0chdgEMHxx9czDviQKI2Y1ESbad/tgmoqh1MyVDyFZ1eaPB
         CnK5DdPOe3SZdGM/pllb/Y8HyyxIhDcJz3iBRAtfe0xFccMnVscbmKEsgmELM26xX2
         uEH5mTGs8UkrS9UpFE/Kqb5Y2PB0pBTMq+fyvsls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 015/285] scsi: qla2xxx: Fix smatch warn for qla_init_iocb_limit()
Date:   Sun, 17 Sep 2023 21:10:15 +0200
Message-ID: <20230917191052.148824561@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

From: Nilesh Javali <njavali@marvell.com>

commit b496953dd0444001b12f425ea07d78c1f47e3193 upstream.

Fix indentation for warning reported by smatch:

drivers/scsi/qla2xxx/qla_init.c:4199 qla_init_iocb_limit() warn: inconsistent indenting

Fixes: efa74a62aaa2 ("scsi: qla2xxx: Adjust IOCB resource on qpair create")
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230821130045.34850-8-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4203,7 +4203,7 @@ void qla_init_iocb_limit(scsi_qla_host_t
 	u8 i;
 	struct qla_hw_data *ha = vha->hw;
 
-	 __qla_adjust_iocb_limit(ha->base_qpair);
+	__qla_adjust_iocb_limit(ha->base_qpair);
 	ha->base_qpair->fwres.iocbs_used = 0;
 	ha->base_qpair->fwres.exch_used  = 0;
 


