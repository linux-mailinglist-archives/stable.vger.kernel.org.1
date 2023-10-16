Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564227CAC85
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjJPOzt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjJPOzs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B377B9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB79C433C8;
        Mon, 16 Oct 2023 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468147;
        bh=5PkzNac10/uJkE+iEJPwjLyBm5+nmwP8gkTUh43lUEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ApmR8dLPSXAfYOFxYjVwnRXbTPEy9Hxu00hgl5ZeEVWY5fa31N7Ka/+25sUAu1B4V
         tUZP3jgIKZLjWw5kpSzv+nu1qYxdB5/k7JSPgXGf/n8XwpFc4TNhXHtCQMFy0DFdqr
         iYYsdC23WMRNYvqtQEL9W5PLBJZOG2Xa7dssV6RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Wang <peter.wang@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.5 166/191] scsi: ufs: core: Correct clear TM error log
Date:   Mon, 16 Oct 2023 10:42:31 +0200
Message-ID: <20231016084019.251681125@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Wang <peter.wang@mediatek.com>

commit a20c4350c6a12405b7f732b3ee6801ffe2cc45ce upstream.

The clear TM function error log status was inverted.

Fixes: 4693fad7d6d4 ("scsi: ufs: core: Log error handler activity")
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20231003022002.25578-1-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6955,7 +6955,7 @@ static int ufshcd_clear_tm_cmd(struct uf
 			mask, 0, 1000, 1000);
 
 	dev_err(hba->dev, "Clearing task management function with tag %d %s\n",
-		tag, err ? "succeeded" : "failed");
+		tag, err < 0 ? "failed" : "succeeded");
 
 out:
 	return err;


