Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BB7037A9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbjEORXa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbjEORXM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F712EA0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6994E62C54
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F22DC433EF;
        Mon, 15 May 2023 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171279;
        bh=2EaW7i5oK03C6plaqf6B4fGQ+TiCohS8YiwsNwcLvA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6b1z//jSi0N5Jj0ScZXBLTzU7rALK6tBpvuuw/+eSGxcd0N/V9Ul1V5OqDId1Evq
         P45toecYWOA9Fj33GICt83Z4Q3Cu5G1flRJ2vmFI/x25XC8etVbyi4Ugf1Jro79QnT
         Q6bq50KaT9w2oxMQ9iQ6VgweMwikTdRHlJE1oAoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 6.2 158/242] remoteproc: stm32: Call of_node_put() on iteration error
Date:   Mon, 15 May 2023 18:28:04 +0200
Message-Id: <20230515161726.627007704@linuxfoundation.org>
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

commit ccadca5baf5124a880f2bb50ed1ec265415f025b upstream.

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20230320221826.2728078-2-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/stm32_rproc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rp
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rp
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;


