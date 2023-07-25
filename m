Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D16761695
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjGYLkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjGYLk3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218641BC5
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B3A616AF
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C549DC433C8;
        Tue, 25 Jul 2023 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285219;
        bh=3WAgjho8LfwrUiyUYyvyeC8tXXldNAxK/siXFEKe5vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoIGQmDS58ssXKTmHImmqVDatk9lGXmB2cY3VTj3K+xp+sQrwNOnTMBJuYCYCQaja
         xBO4H2F8n2Z1aaxuCnGgtXRme4pcpMRNRCFGa+BdQlaJMerPC8h6/TjuP3M19hje01
         G8lxsoHcEWLjBwtU7eVSVtWZamHO/rQo+Ndg/Gng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuchen Yang <u202114568@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/313] scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()
Date:   Tue, 25 Jul 2023 12:44:10 +0200
Message-ID: <20230725104525.167299990@linuxfoundation.org>
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

From: Yuchen Yang <u202114568@hust.edu.cn>

[ Upstream commit 2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d ]

Smatch complains that:

tw_probe() warn: missing error code 'retval'

This patch adds error checking to tw_probe() to handle initialization
failure. If tw_reset_sequence() function returns a non-zero value, the
function will return -EINVAL to indicate initialization failure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuchen Yang <u202114568@hust.edu.cn>
Link: https://lore.kernel.org/r/20230505141259.7730-1-u202114568@hust.edu.cn
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/3w-xxxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2b1e0d5030201..75290aabd543b 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2310,8 +2310,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (tw_reset_sequence(tw_dev))
+	if (tw_reset_sequence(tw_dev)) {
+		retval = -EINVAL;
 		goto out_release_mem_region;
+	}
 
 	/* Set host specific parameters */
 	host->max_id = TW_MAX_UNITS;
-- 
2.39.2



