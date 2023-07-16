Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90D755398
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjGPUUr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGPUUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05741126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA2660E9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B77FC433C8;
        Sun, 16 Jul 2023 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538845;
        bh=aO9NX716XojEKuJq6qIPfQI3jPGRjCYOz086QnLF+PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjPxW/r62IiDtZGkKpPmq0gtoHFMlohl4YP9rhWgY96AZMBpqsh6l3gQJTdYy47Ye
         fexCOfi+FC0PJO7eq8YaE/dMEQmLSJ0ApOqF89f3dUzK81+RRZ68L3byyiRQo899i2
         RwpNQ+YbHDrMoy/LlWsgJjXh/7trUkSJ2mEs3hd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 568/800] media: common: saa7146: Avoid a leak in vmalloc_to_sg()
Date:   Sun, 16 Jul 2023 21:47:01 +0200
Message-ID: <20230716195002.281012321@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit b2aa8ac6f97e26d788948fb60dcc5625c9633f4e ]

Commit in Fixes turned a BUG() into a "normal" memory allocation failure.
While at it, it introduced a memory leak.
So fix it.

Also update the comment on top of the function to reflect what has been
change by the commit in Fixes.

Fixes: 40e986c99624 ("media: common: saa7146: replace BUG_ON by WARN_ON")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/common/saa7146/saa7146_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_core.c b/drivers/media/common/saa7146/saa7146_core.c
index bcb957883044c..27c53eed8fe39 100644
--- a/drivers/media/common/saa7146/saa7146_core.c
+++ b/drivers/media/common/saa7146/saa7146_core.c
@@ -133,8 +133,8 @@ int saa7146_wait_for_debi_done(struct saa7146_dev *dev, int nobusyloop)
  ****************************************************************************/
 
 /* this is videobuf_vmalloc_to_sg() from videobuf-dma-sg.c
-   make sure virt has been allocated with vmalloc_32(), otherwise the BUG()
-   may be triggered on highmem machines */
+   make sure virt has been allocated with vmalloc_32(), otherwise return NULL
+   on highmem machines */
 static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 {
 	struct scatterlist *sglist;
@@ -150,7 +150,7 @@ static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 		if (NULL == pg)
 			goto err;
 		if (WARN_ON(PageHighMem(pg)))
-			return NULL;
+			goto err;
 		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
 	}
 	return sglist;
-- 
2.39.2



