Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F07038A0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbjEORdo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244367AbjEORd3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00A1524F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B4262083
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FC0C433D2;
        Mon, 15 May 2023 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171878;
        bh=c/O0qV31ZKfDuQtGjvdPfrfaJpo9rVqHAzIqawCN0mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bziMr94ZEOsOyFiuknJVYOz4dwUXFFdgDZkRnQ7zmkbF/mbc5nOnipK8Qg03kazN
         LimyJ9Rp7sgHl9/AAvnl6mO7j8TSa463hWNW7GsCQwQeBDkTwwvwidQKciPM4nMds/
         gNQLDOmq3si7a+b91yPAIc3p0Aloj5SodivrVK3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 5.15 080/134] remoteproc: st: Call of_node_put() on iteration error
Date:   Mon, 15 May 2023 18:29:17 +0200
Message-Id: <20230515161705.852089821@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

commit 8a74918948b40317a5b5bab9739d13dcb5de2784 upstream.

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: 3df52ed7f269 ("remoteproc: st: add reserved memory support")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20230320221826.2728078-3-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/st_remoteproc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rpro
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rpro
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;


