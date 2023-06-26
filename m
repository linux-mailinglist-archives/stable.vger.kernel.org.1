Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81A73E94C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjFZSeV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFZSeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4170102
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B27660F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B2C433C8;
        Mon, 26 Jun 2023 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804453;
        bh=dl9c9airJ9gRrweXyC7jRYfXSh1NGAcASrPhlq6/GFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsZhNDW4D5q5I+VzgoKH421QDiNwGp7EWBV4rYJAqcVIoN2GlZ1veKpS3XHctShQm
         PNyfzz2F6YlcngYMM6mCsrVX4W1G2w8WHbF59BT0ac0x5JBN7c5dd3kXnmP/6BQtFv
         JPiKitNxq3VdfMPSyw8EjTb9KNIW9sWefco8S6yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anuj Gupta <anuj20.g@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 161/170] null_blk: Fix: memory release when memory_backed=1
Date:   Mon, 26 Jun 2023 20:12:10 +0200
Message-ID: <20230626180807.689208168@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Nitesh Shetty <nj.shetty@samsung.com>

[ Upstream commit 8cfb98196cceec35416041c6b91212d2b99392e4 ]

Memory/pages are not freed, when unloading nullblk driver.

Steps to reproduce issue
  1.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       260Mi       7.1Gi       3.0Mi       395Mi       7.3Gi
Swap:      0B          0B          0B
  2.modprobe null_blk memory_backed=1
  3.dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count=1000
  4.modprobe -r null_blk
  5.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       1.2Gi       6.1Gi       3.0Mi       398Mi       6.3Gi
Swap:      0B          0B          0B

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Link: https://lore.kernel.org/r/20230605062354.24785-1-nj.shetty@samsung.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c45d09a9a9421..e8cb914223cdf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2194,6 +2194,7 @@ static void null_destroy_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 
 	null_del_dev(nullb);
+	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
 
-- 
2.39.2



