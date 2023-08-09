Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667F775B17
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjHILOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjHILOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD110F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC526315C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3670EC433C8;
        Wed,  9 Aug 2023 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579652;
        bh=AmRjzmCSLB/hvjpFlI5dEQqVIe7s7TwLAi8TNeBoVrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzuqekJB20U1CRGRaDPTkvuAMHreUWPSMvOnbznSbiaWbF/fnF3/Vil1GjDIBVWIo
         eNqlNu1AuQwSJHLmUz2W0T9O8MuYPjVVjRxX/18kEpvYZbK887sVeeMxt7PXDvX3gX
         LFF1etUrROEfm4YDrDAKt1oIrjP8TuFrnupatW5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuchen Yang <u202114568@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/323] scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()
Date:   Wed,  9 Aug 2023 12:38:25 +0200
Message-ID: <20230809103701.212759091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 471366945bd4f..8a61e832607eb 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2303,8 +2303,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
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



