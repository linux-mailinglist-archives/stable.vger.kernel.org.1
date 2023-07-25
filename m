Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607F761141
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjGYKtO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYKtO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4A199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 594DD6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB99C433C7;
        Tue, 25 Jul 2023 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282151;
        bh=rr+AIe3BWfMFqUL0HbmluR22ksFyRK6wqOtlacIzNgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMUqrjQE1r8dSEAwIwTGwAiBR0Bpes/2VgAXDBB8q6itDOnH82J/3RfWPPL/cuqfp
         CXcGmlRJ+KW9q2HRfmcAs1U/gHuPVZpKaak/EaayBh9WchrkHRsi2XOvu6N8VGA5R5
         F7x+ILdTs24aZp7nYnu2NJhfjFQFM0SBL/CcFukI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 6.4 026/227] accel/qaic: Fix a leak in map_user_pages()
Date:   Tue, 25 Jul 2023 12:43:13 +0200
Message-ID: <20230725104515.891736546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 73274c33d961f4aa0f968f763e2c9f4210b4f4a3 upstream.

If get_user_pages_fast() allocates some pages but not as many as we
wanted, then the current code leaks those pages.  Call put_page() on
the pages before returning.

Fixes: 129776ac2e38 ("accel/qaic: Add control path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Cc: stable@vger.kernel.org # 6.4.x
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/ZK0Q+ZuONTsBG+1T@moroto
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/qaic/qaic_control.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -418,9 +418,12 @@ static int find_and_map_user_pages(struc
 	}
 
 	ret = get_user_pages_fast(xfer_start_addr, nr_pages, 0, page_list);
-	if (ret < 0 || ret != nr_pages) {
-		ret = -EFAULT;
+	if (ret < 0)
 		goto free_page_list;
+	if (ret != nr_pages) {
+		nr_pages = ret;
+		ret = -EFAULT;
+		goto put_pages;
 	}
 
 	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);


