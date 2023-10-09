Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D970E7BE1D3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377557AbjJINyZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377682AbjJINyO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:54:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53EF94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:54:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19944C433C8;
        Mon,  9 Oct 2023 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859652;
        bh=nmMs6HekBtxZ928l5FvkjYftI2A+sIw4yu6zNjt1oKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hl4gJdP6RMUhN0+ee7V8HEfOLsh4ZPN2OErOx0ITESs6BjY0VvrT2CX9asDVsiy59
         SntylxggaC3BktO+mLD4QwGOEfvenOBAdaEvcdnvsvOUPI4H1xHWMyxWdtbN8Xiwu2
         EaTRwIi5eKQKeppnYo6XfHy3V94ke0dqQZJL57pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 4.19 88/91] RDMA/cma: Fix truncation compilation warning in make_cma_ports
Date:   Mon,  9 Oct 2023 15:07:00 +0200
Message-ID: <20231009130114.600815232@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

commit 18126c767658ae8a831257c6cb7776c5ba5e7249 upstream.

The following compilation error is false alarm as RDMA devices don't
have such large amount of ports to actually cause to format truncation.

drivers/infiniband/core/cma_configfs.c: In function ‘make_cma_ports’:
drivers/infiniband/core/cma_configfs.c:223:57: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
      |                                                         ^
drivers/infiniband/core/cma_configfs.c:223:17: note: ‘snprintf’ output between 2 and 11 bytes into a destination of size 10
  223 |                 snprintf(port_str, sizeof(port_str), "%u", i + 1);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:243: drivers/infiniband/core/cma_configfs.o] Error 1

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Link: https://lore.kernel.org/r/a7e3b347ee134167fa6a3787c56ef231a04bc8c2.1694434639.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma_configfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -215,7 +215,7 @@ static int make_cma_ports(struct cma_dev
 	}
 
 	for (i = 0; i < ports_num; i++) {
-		char port_str[10];
+		char port_str[11];
 
 		ports[i].port_num = i + 1;
 		snprintf(port_str, sizeof(port_str), "%u", i + 1);


