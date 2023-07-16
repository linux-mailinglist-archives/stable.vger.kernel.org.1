Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703197552F7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjGPUOF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGPUOE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2401B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553D160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B5EC433C8;
        Sun, 16 Jul 2023 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538442;
        bh=yZTXW+VLrG2GWZ39erW2Je/RGyPZY9kNoxWnk5BFaFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVA0LOFvsyejLOnM2npgFzqgziRtQaRvQ34L8uYqUyu+wnJp3txEK4iQnI6YteqG8
         4OxUd+9E59EoFDVd30nOqDVB/BksMUif30iPAIYPUeX5N3swvlu3TE6FuitfhjK4GI
         tT46kckHh+F3HO2g5LiVUx9kJ26sTmRPl/IIacxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 452/800] scsi: ufs: core: Increase the START STOP UNIT timeout from one to ten seconds
Date:   Sun, 16 Jul 2023 21:45:05 +0200
Message-ID: <20230716194959.582182356@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit fe8637f7708c16765ecf4035813efbfdd2c9be10 ]

One UFS vendor asked to increase the UFS timeout from 1 s to 3 s.  Another
UFS vendor asked to increase the UFS timeout from 1 s to 10 s.  Hence this
patch that increases the UFS timeout to 10 s. This patch can cause the
total timeout to exceed 20 s, the Android shutdown timeout.  This is fine
since the loop around ufshcd_execute_start_stop() exists to deal with unit
attentions and because unit attentions are reported quickly.

Fixes: dcd5b7637c6d ("scsi: ufs: Reduce the START STOP UNIT timeout")
Fixes: 8f2c96420c6e ("scsi: ufs: core: Reduce the power mode change timeout")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230524203659.1394307-2-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e7e79f515e141..c36812401ef05 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9184,7 +9184,8 @@ static int ufshcd_execute_start_stop(struct scsi_device *sdev,
 	};
 
 	return scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, /*buffer=*/NULL,
-			/*bufflen=*/0, /*timeout=*/HZ, /*retries=*/0, &args);
+			/*bufflen=*/0, /*timeout=*/10 * HZ, /*retries=*/0,
+			&args);
 }
 
 /**
-- 
2.39.2



