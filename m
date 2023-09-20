Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607837A7C0D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjITL5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjITL5c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:57:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532AD3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:57:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9447AC433C7;
        Wed, 20 Sep 2023 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211046;
        bh=j+D/W2jm8c6lsu6hf8PuVVp1oqPV5Dy/1z83KuBMaio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUH1/S4fdrCSc8zAAW8dLwVu0a3qG0TTklEh/uEtYOuTBhT2r/27FeiB9qrIKe3W6
         xUBS9oz67P4OieCkbVJFO5lTvdsABinSigVw5o1NUQq5FfAmbvzfg1GRsJW+bjyJp/
         wHXF5q69cX2DRoimXCieCcrTeyg79+ylG9B0nh8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 089/139] misc: fastrpc: Prepare to dynamic dma-buf locking specification
Date:   Wed, 20 Sep 2023 13:30:23 +0200
Message-ID: <20230920112838.937591477@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit 791da5c7fedbc1d662445ec030d8f86872f6184c ]

Prepare fastrpc to the common dynamic dma-buf locking convention by
starting to use the unlocked versions of dma-buf API functions.

Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20221017172229.42269-12-dmitry.osipenko@collabora.com
Stable-dep-of: a2cb9cd6a394 ("misc: fastrpc: Fix incorrect DMA mapping unmap request")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 13518cac076c7..e9291694922bc 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -310,8 +310,8 @@ static void fastrpc_free_map(struct kref *ref)
 				return;
 			}
 		}
-		dma_buf_unmap_attachment(map->attach, map->table,
-					 DMA_BIDIRECTIONAL);
+		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
+						  DMA_BIDIRECTIONAL);
 		dma_buf_detach(map->buf, map->attach);
 		dma_buf_put(map->buf);
 	}
@@ -736,7 +736,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto attach_err;
 	}
 
-	map->table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);
+	map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(map->table)) {
 		err = PTR_ERR(map->table);
 		goto map_err;
-- 
2.40.1



