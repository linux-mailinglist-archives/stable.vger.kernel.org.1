Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A17A3A46
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjIQUCM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjIQUBl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36944188
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABDEC43391;
        Sun, 17 Sep 2023 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980835;
        bh=dIdplIjUgxEjiHRyfzGLGVHV8R+19hclroVL09+JGrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zfyne+kmS+QC/ZJVbRk752Kgc71KURGL7JjMip83E/tM2gaPjkkgIbEHNSY4jqKDb
         IKmkCLH9EtKCcP4K/tYYnDaXuxfRsjJMDRx+mpRcxCE8NX+hat8gyNrUqju/poAuSu
         hom702ZPVNvetn8s2JiAsbbyhw/qTpCJCsmr6WBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 006/219] io_uring/net: dont overflow multishot accept
Date:   Sun, 17 Sep 2023 21:12:13 +0200
Message-ID: <20230917191041.195126484@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ upstream commit 1bfed23349716a7811645336a7ce42c4b8f250bc ]

Don't allow overflowing multishot accept CQEs, we want to limit
the grows of the overflow list.

Cc: stable@vger.kernel.org
Fixes: 4e86a2c980137 ("io_uring: implement multishot mode for accept")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/7d0d749649244873772623dd7747966f516fe6e2.1691757663.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1339,7 +1339,7 @@ retry:
 
 	if (ret < 0)
 		return ret;
-	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, true))
+	if (io_post_aux_cqe(ctx, req->cqe.user_data, ret, IORING_CQE_F_MORE, false))
 		goto retry;
 
 	return -ECANCELED;


