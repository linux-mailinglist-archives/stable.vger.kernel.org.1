Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8D73530C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjFSKlN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjFSKkn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B5B3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E71660B33
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4933C433C8;
        Mon, 19 Jun 2023 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171242;
        bh=qe51Uh+xie1MnPHX/zdQ1DrgBZaG52fL+rEGpEKdbQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1fDJX1aYYREzydierPU1+QkyW1tV0DySNSND5j90HIHtPtv9HrRUHJX8N5flS23I
         xY+EkB3jjwuG5UwN0cQTl2XUfDKNjDR/AMebm5s69WjJMPH54prkq3dFEkVzjLiHCp
         otXKJ72q1KAQgPS47fT6fwfwVMidZO0FB27HOrRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/49] xen/blkfront: Only check REQ_FUA for writes
Date:   Mon, 19 Jun 2023 12:29:49 +0200
Message-ID: <20230619102130.444341275@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit b6ebaa8100090092aa602530d7e8316816d0c98d ]

The existing code silently converts read operations with the
REQ_FUA bit set into write-barrier operations. This results in data
loss as the backend scribbles zeroes over the data instead of returning
it.

While the REQ_FUA bit doesn't make sense on a read operation, at least
one well-known out-of-tree kernel module does set it and since it
results in data loss, let's be safe here and only look at REQ_FUA for
writes.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230426164005.2213139-1-ross.lagerwall@citrix.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7ee618ab1567b..b4807d12ef29c 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -779,7 +779,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		ring_req->u.rw.handle = info->handle;
 		ring_req->operation = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
-		if (req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA) {
+		if (req_op(req) == REQ_OP_FLUSH ||
+		    (req_op(req) == REQ_OP_WRITE && (req->cmd_flags & REQ_FUA))) {
 			/*
 			 * Ideally we can do an unordered flush-to-disk.
 			 * In case the backend onlysupports barriers, use that.
-- 
2.39.2



