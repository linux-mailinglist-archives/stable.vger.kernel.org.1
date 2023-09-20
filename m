Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8447A7A92
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjITLnp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITLnp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:43:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D45A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:43:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCF6C433C7;
        Wed, 20 Sep 2023 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210218;
        bh=NN9qIWFUN0+6XgC7i0dSs4/8cWP1AIRxCYispwf3vAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxDsS216CYSJDnMbD/B6p63ZXULWHB4GY0HOrl/1CC4HJ614WjCFYe0wpEqVh0ova
         wqc8YVKM5X9MXrFDMm58PC+lPBkVYenBoEibYSYvPlOO2MB0yKqoJWzNGQ0/pcKIqE
         zaGW8U+4fK3Gf0br5uoVeK7CnhQrS0snhDqquT9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 001/211] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
Date:   Wed, 20 Sep 2023 13:27:25 +0200
Message-ID: <20230920112845.904129842@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

[ Upstream commit eee2d2e6ea5550118170dbd5bb1316ceb38455fb ]

folio_next_index() returns an unsigned long value which left shifted
by PAGE_SHIFT could possibly cause an overflow on 32-bit system. Instead
use folio_pos(folio) + folio_size(folio), which does this correctly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7d2f70708f37d..794fda5bd9bc6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -927,7 +927,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			 * the end of this data range, not the end of the folio.
 			 */
 			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+					folio_pos(folio) + folio_size(folio));
 		}
 
 		/* move offset to start of next folio in range */
-- 
2.40.1



