Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320266FA788
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjEHKbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjEHKbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD49D2E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91FD626D7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB317C433EF;
        Mon,  8 May 2023 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541871;
        bh=9g0eQcHGOm5RoBnhn4PF9aXqenZz5p9qE742o7UZkmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4sYFfndm3lC7rWCoEMG0kD88Zd/LY2vGs0Zm07WyvQPFAkhQi+Otb+aC13GHRJa0
         06NKjVbyx3p/LpXjfrGfp6KZkdJKl/87+Cuj/fZPuFZ9lxL+Vzfnhdix26S0ClhxHA
         4jGfQyU8t7TVwbt2Ok5rdaybefM/aqqTYZaAg8l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 254/663] media: saa7134: fix use after free bug in saa7134_finidev due to race condition
Date:   Mon,  8 May 2023 11:41:20 +0200
Message-Id: <20230508094436.498658606@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index 6a5053126237f..437dbe5e75e29 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -300,6 +300,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 3f0b0933eed69..3e773690468bd 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -185,6 +185,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 4d8974c9fcc98..29124756a62bc 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2146,6 +2146,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
-- 
2.39.2



