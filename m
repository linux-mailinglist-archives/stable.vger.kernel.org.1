Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42127D31B9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjJWLMY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjJWLMW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790DC5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98172C433C7;
        Mon, 23 Oct 2023 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059540;
        bh=l/LTKqXM5KpJOgldDjaTsAGs1y4wzZQdzHYXL47kXPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNoYS4RRkqfY1q+CE3W8McdFxsXGFe2OG/FW/E7DrIgGbsIgA+JiPnXLgo57kcXAh
         aZiPSrpr+eVjJB59EXO9YzRJdIRuR9RBwk5lS4/QPWqehxEi0ScscGsvnlTR4gNobc
         IIOElWa2vzUG9803Mff++kCicsk7YggCmV4B/gY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.5 204/241] s390/cio: fix a memleak in css_alloc_subchannel
Date:   Mon, 23 Oct 2023 12:56:30 +0200
Message-ID: <20231023104838.832260134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit 63e8b94ad1840f02462633abdb363397f56bc642 upstream.

When dma_set_coherent_mask() fails, sch->lock has not been
freed, which is allocated in css_sch_create_locks(), leading
to a memleak.

Fixes: 4520a91a976e ("s390/cio: use dma helpers for setting masks")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Message-Id: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/linux-s390/bd38baa8-7b9d-4d89-9422-7e943d626d6e@linux.ibm.com/
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/css.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -233,17 +233,19 @@ struct subchannel *css_alloc_subchannel(
 	 */
 	ret = dma_set_coherent_mask(&sch->dev, DMA_BIT_MASK(31));
 	if (ret)
-		goto err;
+		goto err_lock;
 	/*
 	 * But we don't have such restrictions imposed on the stuff that
 	 * is handled by the streaming API.
 	 */
 	ret = dma_set_mask(&sch->dev, DMA_BIT_MASK(64));
 	if (ret)
-		goto err;
+		goto err_lock;
 
 	return sch;
 
+err_lock:
+	kfree(sch->lock);
 err:
 	kfree(sch);
 	return ERR_PTR(ret);


