Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DC7033A6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbjEOQkF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbjEOQj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54C4214
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB2B62866
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8A4C4339E;
        Mon, 15 May 2023 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168778;
        bh=B3DNZ4uP3qz5Muc0Eq10wvdq5oUeHd+9JbGPh8ZKKFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hxbpHL3IKw1uNvx8AI6/iIg3IbdaZ+Mph2ei+w9MZrApoFwSoa7j0F9B1Uvt+dNH
         tcO05nrzUz7zTliKE8YEpcJv0dJ5gRcANIrYbK4Pa9ZQdpOWqBj5/vyHYlPB7I6LaV
         yUTLIQxMemw+9QRL62wpExOiydvFemPykSlk4io8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/191] media: saa7134: fix use after free bug in saa7134_finidev due to race condition
Date:   Mon, 15 May 2023 18:24:36 +0200
Message-Id: <20230515161708.602887921@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 30cf57da176cca80f11df0d9b7f71581fe601389 ]

In saa7134_initdev, it will call saa7134_hwinit1. There are three
function invoking here: saa7134_video_init1, saa7134_ts_init1
and saa7134_vbi_init1.

All of them will init a timer with same function. Take
saa7134_video_init1 as an example. It'll bound &dev->video_q.timeout
with saa7134_buffer_timeout.

In buffer_activate, the timer funtcion is started.

If we remove the module or device which will call saa7134_finidev
to make cleanup, there may be a unfinished work. The
possible sequence is as follows, which will cause a
typical UAF bug.

Fix it by canceling the timer works accordingly before cleanup in
saa7134_finidev.

CPU0                  CPU1

                    |saa7134_buffer_timeout
saa7134_finidev     |
  kfree(dev);       |
                    |
                    | saa7134_buffer_next
                    | //use dev

Fixes: 1e7126b4a86a ("media: saa7134: Convert timers to use timer_setup()")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-ts.c    | 1 +
 drivers/media/pci/saa7134/saa7134-vbi.c   | 1 +
 drivers/media/pci/saa7134/saa7134-video.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 2be703617e294..e7adcd4f99623 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -309,6 +309,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 57bea543c39ba..559db500b19ce 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -194,6 +194,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 079219288af7b..90255ecb08ca4 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2213,6 +2213,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	vb2_queue_release(&dev->video_vbq);
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
-- 
2.39.2



