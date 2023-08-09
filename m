Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74914775BFF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjHILWv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHILWv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C51FCE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B416321B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86115C433C9;
        Wed,  9 Aug 2023 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580169;
        bh=ZGj42isl13P3QjbjoK9zqVUaG+jSy7GXtgp31VMvfb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ywW2YZ8wNw6h5ZiQTNWkOHf89Ph1E+qE4jXcJnMbhAoEE/vu8GVqb+zM9iosko7G
         M0/ucnyuf6YnMiqZMrKWgOYPL9Kv54oMgjnsEVKFfsJz/NnGdGGySehwe3viZFwp5s
         QgOvMCIPPTeqxDGF2PMcFx1ue/VlXSgZPH2icwXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hulk Robot <hulkci@huawei.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Ye Bin <yebin10@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 235/323] scsi: qla2xxx: Fix inconsistent format argument type in qla_os.c
Date:   Wed,  9 Aug 2023 12:41:13 +0200
Message-ID: <20230809103708.836378273@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 250bd00923c72c846092271a9e51ee373db081b6 ]

Fix the following warnings:

[drivers/scsi/qla2xxx/qla_os.c:4882]: (warning) %ld in format string (no. 2)
	requires 'long' but the argument type is 'unsigned long'.
[drivers/scsi/qla2xxx/qla_os.c:5011]: (warning) %ld in format string (no. 1)
	requires 'long' but the argument type is 'unsigned long'.

Link: https://lore.kernel.org/r/20200930022515.2862532-3-yebin10@huawei.com
Reported-by: Hulk Robot <hulkci@huawei.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d721b591b95c ("scsi: qla2xxx: Array index may go out of bound")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 7863ad1390f8a..73f3e51ce9798 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4604,7 +4604,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%ld", QLA2XXX_DRIVER_NAME, vha->host_no);
+	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
@@ -4735,7 +4735,7 @@ qla2x00_uevent_emit(struct scsi_qla_host *vha, u32 code)
 
 	switch (code) {
 	case QLA_UEVENT_CODE_FW_DUMP:
-		snprintf(event_string, sizeof(event_string), "FW_DUMP=%ld",
+		snprintf(event_string, sizeof(event_string), "FW_DUMP=%lu",
 		    vha->host_no);
 		break;
 	default:
-- 
2.39.2



