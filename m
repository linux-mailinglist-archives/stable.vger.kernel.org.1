Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768556FA97F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjEHKwI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjEHKvq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD42DD70
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0206292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26848C433D2;
        Mon,  8 May 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543069;
        bh=CL1HLDwUN1mkeYzB5XCFDH+3dVdjRatD5TFejnbijEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/4OoYzB39zma3TmZ0I461M4ZGggM8W5GnAyE0q055iiNi4a8jrb/BDJnG5PfrEk4
         9g/7bbaWZ/Kb6UXygJzF3PuzJEXEoZ0PkR0qS3bzxROdAzLEnUz1eyJadSxLGR+I3c
         sxKMWNybVepPhjezfsNjOFHK8xRbAL7VoM63sXfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.2 641/663] s390/dasd: fix hanging blockdevice after request requeue
Date:   Mon,  8 May 2023 11:47:47 +0200
Message-Id: <20230508094450.787056212@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

commit d8898ee50edecacdf0141f26fd90acf43d7e9cd7 upstream.

The DASD driver does not kick the requeue list when requeuing IO requests
to the blocklayer. This might lead to hanging blockdevice when there is
no other trigger for this.

Fix by automatically kick the requeue list when requeuing DASD requests
to the blocklayer.

Fixes: e443343e509a ("s390/dasd: blk-mq conversion")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Link: https://lore.kernel.org/r/20230405142017.2446986-8-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2941,7 +2941,7 @@ static int _dasd_requeue_request(struct
 		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
-	blk_mq_requeue_request(req, false);
+	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
 	return 0;


