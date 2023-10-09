Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C4D7BDD9D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbjJINLZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376957AbjJINLD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693D199
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24FEC433CC;
        Mon,  9 Oct 2023 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857028;
        bh=BRZpQ5VuwgyCKninMK0XinWM21JE3RdLuzRcqsXvkhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4BR8bzZJZYOrnZ7C2Exem4sMhDWNWSH4qxrn9vqAltAbBOq7iOJdH0R/TIjYnb5S
         2nZWfBxYftsmxUUo30zH6FlEA6nJnB0JUuXKoZY7LvZixzhZONRWxtxPgvJNmUY+JQ
         Zb44sIZwltjgkVYi5rg562TQsmZWEL8ySJc10198=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jingbo Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 072/163] erofs: allow empty device tags in flatdev mode
Date:   Mon,  9 Oct 2023 15:00:36 +0200
Message-ID: <20231009130126.040033730@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit f939aeea7ab7d96cd321e7ac107f5a070836b66f ]

Device tags aren't actually required in flatdev mode, thus fix mount
failure due to empty device tags in flatdev mode.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Fixes: 8b465fecc35a ("erofs: support flattened block device for multi-blob images")
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230915082728.56588-1-jefflexu@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 566f68ddfa36e..31a103399412e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -238,7 +238,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		return PTR_ERR(ptr);
 	dis = ptr + erofs_blkoff(sb, *pos);
 
-	if (!dif->path) {
+	if (!sbi->devs->flatdev && !dif->path) {
 		if (!dis->tag[0]) {
 			erofs_err(sb, "empty device tag @ pos %llu", *pos);
 			return -EINVAL;
-- 
2.40.1



