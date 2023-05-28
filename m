Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F9713D0F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjE1TV2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjE1TV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E48A0
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A628961B11
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A8C433D2;
        Sun, 28 May 2023 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301685;
        bh=Kj4R2YI2m89JegjuUvVtt1Dg208D9FEudH84eVJGXJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBnaaXirC9aIIqrGVOUzFTLrLtUGdKBP2NCjCZ6Nfjp45aKULg/8YQOKKEKqM8ttY
         Uz1VI7gtbWoZMgzhPzaefUDOUBQeh5/S6fpMIrxPJ3i1NX/eRLAuyPOmZzX7UfwDCD
         QbASA3wsp1c/f8b2K822/L68/IwTGLiabqiAJzs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.19 128/132] xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()
Date:   Sun, 28 May 2023 20:11:07 +0100
Message-Id: <20230528190837.792453580@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -330,8 +330,10 @@ static struct sock_mapping *pvcalls_new_
 	void *page;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
-	if (map == NULL)
+	if (map == NULL) {
+		sock_release(sock);
 		return NULL;
+	}
 
 	map->fedata = fedata;
 	map->sock = sock;
@@ -423,10 +425,8 @@ static int pvcalls_back_connect(struct x
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
@@ -567,7 +567,6 @@ static void __pvcalls_back_accept(struct
 					sock);
 	if (!map) {
 		ret = -EFAULT;
-		sock_release(sock);
 		goto out_error;
 	}
 


