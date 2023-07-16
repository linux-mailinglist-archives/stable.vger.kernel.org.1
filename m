Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708975514D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGPTyz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGPTyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B3E51
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD2D60EB2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C8C433C7;
        Sun, 16 Jul 2023 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537292;
        bh=Dgb7shysDvLNrp5RWso/gvtw8tYZnQZN85CE5HOQZx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEePdrWetV7h2LCmiULmPRare98n2K1h9CFiYjLGAHfjxbN8nvdgCZ8TU1+n/ByWC
         K5NGqrxLdGbskeJh2AmQiCD0fKqU8XS6Ci/sjfcV3D9MeWbyNzBePD3Olj4k6/DUQp
         QFuQkzAD9liarVCljCkTt8S75SGn5uqgqCIIJKd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 043/800] splice: dont call file_accessed in copy_splice_read
Date:   Sun, 16 Jul 2023 21:38:16 +0200
Message-ID: <20230716194950.093140399@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 0b24be4691c9e6ea13ca70050d42a9f9032fa788 ]

copy_splice_read calls into ->read_iter to read the data, which already
calls file_accessed.

Fixes: 33b3b041543e ("splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20230614140341.521331-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae5..030e162985b5d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -355,7 +355,6 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 		reclaim -= ret;
 		remain = ret;
 		*ppos = kiocb.ki_pos;
-		file_accessed(in);
 	} else if (ret < 0) {
 		/*
 		 * callers of ->splice_read() expect -EAGAIN on
-- 
2.39.2



