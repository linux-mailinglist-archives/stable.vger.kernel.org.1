Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B4A73E86C
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFZSZw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjFZSZ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565026A0
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B519760F4F
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EC3C433C0;
        Mon, 26 Jun 2023 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803859;
        bh=GS0pPVjWt188lZEoepBV2THYAmcEA8YdD0oC8UPiH2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIhxyZfvAKLINPYN5UvLb5xEEzjp+xtGL+Owejfkd7d5S/eW7A8cGp4ZOoRQpekW+
         wuXqy56wll0Z/8N6udXGnbiVyND+Q4zeNp5FRXvx+H3Fn9kJwX83CgVRcqOQk9CK7I
         zpomX5D9iL1qotfPqrUn6wm2tCkogFRWU/av65j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Anuj Gupta <anuj20.g@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 185/199] null_blk: Fix: memory release when memory_backed=1
Date:   Mon, 26 Jun 2023 20:11:31 +0200
Message-ID: <20230626180813.862034004@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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
index 14491952047f5..3b6b4cb400f42 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2212,6 +2212,7 @@ static void null_destroy_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 
 	null_del_dev(nullb);
+	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
 
-- 
2.39.2



