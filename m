Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FC7037AD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbjEORXm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjEORXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41619BE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB73D62C52
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD27C4339B;
        Mon, 15 May 2023 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171289;
        bh=QmnDGkAw0UDgIUvCaXOQ+xUZF9d48JvpofGptycY9vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eou/SdUraUCwhlD/kFm5Xru6yFUfpIkHYDgLCuMB86n6opZmAFO8v2Sli3p3reBjr
         Q0/0hZmOSvNbkkvEocTNERO8i1rs5CV55HY/xRnFhHIVgRvaQ9qb963ArbceEJNwy+
         wWgSOG7WjxgXdLuB2jf797RR/5w2OeTGbKSF2f+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6.2 161/242] remoteproc: imx_rproc: Call of_node_put() on iteration error
Date:   Mon, 15 May 2023 18:28:07 +0200
Message-Id: <20230515161726.714526104@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Mathieu Poirier <mathieu.poirier@linaro.org>

commit 5ef074e805ecfd9a16dbb7b6b88bbfa8abad7054 upstream.

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20230320221826.2728078-5-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/imx_rproc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -541,6 +541,7 @@ static int imx_rproc_prepare(struct rpro
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(priv->dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -553,10 +554,12 @@ static int imx_rproc_prepare(struct rpro
 					   imx_rproc_mem_alloc, imx_rproc_mem_release,
 					   it.node->name);
 
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


