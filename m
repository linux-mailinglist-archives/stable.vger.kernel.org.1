Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE727037AC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbjEORXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjEORXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1737110A05
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A899C62C53
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B817C433D2;
        Mon, 15 May 2023 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171286;
        bh=mblPHaVTzJFd9zvtR/j6mmAdK23F7mYATGqoMeeeZ2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2Dt7y+pPPatrToeOnKS3h0DTAkn3n3XPTL5hjj8yUgMVu3EowberjgJ07gEN4FAG
         MEc94cI4raAbktufawEYCBn8C0qHXLJ+c0lkZC+zUNZFgdW8tPmQVlK0SAis5P3ytX
         9Z6/fJIpoKaXvydli67hezBS2bSTw0DonWboeFCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: [PATCH 6.2 160/242] remoteproc: imx_dsp_rproc: Call of_node_put() on iteration error
Date:   Mon, 15 May 2023 18:28:06 +0200
Message-Id: <20230515161726.685862677@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Mathieu Poirier <mathieu.poirier@linaro.org>

commit e0e01de8ee146986872e54e8365f4b4654819412 upstream.

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver for DSP on i.MX")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://lore.kernel.org/r/20230320221826.2728078-6-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/imx_dsp_rproc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -627,15 +627,19 @@ static int imx_dsp_rproc_add_carveout(st
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
-		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da))
+		if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size, &da)) {
+			of_node_put(it.node);
 			return -EINVAL;
+		}
 
 		cpu_addr = devm_ioremap_wc(dev, rmem->base, rmem->size);
 		if (!cpu_addr) {
+			of_node_put(it.node);
 			dev_err(dev, "failed to map memory %p\n", &rmem->base);
 			return -ENOMEM;
 		}
@@ -644,10 +648,12 @@ static int imx_dsp_rproc_add_carveout(st
 		mem = rproc_mem_entry_init(dev, (void __force *)cpu_addr, (dma_addr_t)rmem->base,
 					   rmem->size, da, NULL, NULL, it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}


