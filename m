Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F1775A5A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjHILHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjHILHd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136E1FFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD7363118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD117C433C8;
        Wed,  9 Aug 2023 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579252;
        bh=p//87+KLbGKiTtxFDtRhZha52okbV6Mmaq31tSEbZYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rR0NIkPAP0b1HkU3+BFgdY0vDcifQQzXQgVQBsF6idtEzOiAtKKpsfiZ6Qw7aCi6u
         SCKinKcUNSV28VNKhDWZcrdanEeWOeb8CAdwSU+tMZVicJy8xdCT48SajYCbCybA3N
         3yl4U4sZTj7+WbjDtjeTj1r7DmtmrMJGy7n1ow/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhong Jinghua <zhongjinghua@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/204] nbd: Add the maximum limit of allocated index in nbd_dev_add
Date:   Wed,  9 Aug 2023 12:41:07 +0200
Message-ID: <20230809103646.917592442@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit f12bc113ce904777fd6ca003b473b427782b3dde ]

If the index allocated by idr_alloc greater than MINORMASK >> part_shift,
the device number will overflow, resulting in failure to create a block
device.

Fix it by imiting the size of the max allocation.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230605122159.2134384-1-zhongjinghua@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index eb2ca7f6ab3ab..33ad48719c124 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1630,7 +1630,8 @@ static int nbd_dev_add(int index)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&nbd_index_idr, nbd, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&nbd_index_idr, nbd, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 		if (err >= 0)
 			index = err;
 	}
-- 
2.39.2



