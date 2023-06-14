Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E92713F96
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjE1TrC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjE1TrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A90BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E89B361F78
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13705C433EF;
        Sun, 28 May 2023 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303216;
        bh=XwbO+uP9z+euriGaEYmaJKRYaDunT7FebxX5uWb1vxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDSljLb+rUh3tBaxppFtyI0D5f6rtRFIqg7aAEMK/jSh27fTBW2BThNPeA9Ro/PI9
         5Hpl5M5PhU8sB0uG87wH6eWKWP1ER9Eqtz8YoEqc/UHZ4mmzhVpxkh7rZCgg3GvqAy
         yepCG7Fjd3LqzZ0mkBsxOiNKYGMDsFkKxoGhalTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.10 201/211] xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()
Date:   Sun, 28 May 2023 20:12:02 +0100
Message-Id: <20230528190848.491895336@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 8fafac202d18230bb9926bda48e563fd2cce2a4f upstream.

In the pvcalls_new_active_socket() function, most error paths call
pvcalls_back_release_active(fedata->dev, fedata, map) which calls
sock_release() on "sock".  The bug is that the caller also frees sock.

Fix this by making every error path in pvcalls_new_active_socket()
release the sock, and don't free it in the caller.

Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/e5f98dc2-0305-491f-a860-71bbd1398a2f@kili.mountain
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/pvcalls-back.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -321,8 +321,10 @@ static struct sock_mapping *pvcalls_new_
 	void *page;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (map == NULL)
+	if (map == NULL) {
+		sock_release(sock);
 		return NULL;
+	}
 
 	map->fedata = fedata;
 	map->sock = sock;
@@ -414,10 +416,8 @@ static int pvcalls_back_connect(struct x
 					req->u.connect.ref,
 					req->u.connect.evtchn,
 					sock);
-	if (!map) {
+	if (!map)
 		ret = -EFAULT;
-		sock_release(sock);
-	}
 
 out:
 	rsp = RING_GET_RESPONSE(&fedata->ring, fedata->ring.rsp_prod_pvt++);
@@ -558,7 +558,6 @@ static void __pvcalls_back_accept(struct
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(sock);
 		goto out_error;
 	}
 


