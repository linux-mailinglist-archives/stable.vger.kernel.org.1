Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAAC75D1A8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGUSvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUSvY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B430CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6803561D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78171C433C8;
        Fri, 21 Jul 2023 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965482;
        bh=jR9aMMNgsl3xWtwYY47AqPgStgMVxHerlfx8HNGOOMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCgRClwBk2dv0EUln3Z4seAsLCklVljq0owRB0aCCoTdvIsFqo7X0mu0UlBPu7Lqz
         4PQH762GIz3HKRxf0HxFMef9ZTcDu2+RJHS2KpiPEzldJCuOx969vd+t2REHsB40nQ
         WMbP2Bw0qfU5ddbnjHRODTwcq9C7y079ZhiQMceE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 289/292] scsi: qla2xxx: Fix end of loop test
Date:   Fri, 21 Jul 2023 18:06:38 +0200
Message-ID: <20230721160541.375489163@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 339020091e246e708c1381acf74c5f8e3fe4d2b5 upstream.

This loop will exit successfully when "found" is false or in the failure
case it times out with "wait_iter" set to -1.  The test for timeouts is
impossible as is.

Fixes: b843adde8d49 ("scsi: qla2xxx: Fix mem access after free")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/cea5a62f-b873-4347-8f8e-c67527ced8d2@kili.mountain
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_os.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1409,7 +1409,7 @@ __qla2x00_eh_wait_for_pending_commands(s
 			break;
 	}
 
-	if (!wait_iter && found)
+	if (wait_iter == -1)
 		status = QLA_FUNCTION_FAILED;
 
 	return status;


