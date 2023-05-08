Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93B6FAC4C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjEHLXG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjEHLXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F49B391AE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E2162CD2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E07C433EF;
        Mon,  8 May 2023 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544974;
        bh=FW0MD4duk7G0ZQQxdSx03KTE3SPBbXr9x06v/eNL08M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbo4DPiAZHahs2g/Q5H82XC8RI1t3KUajmBbmuV2tcOgDUrhuv9v3Zn7G/2AlNrQZ
         eX5oMqtZJPk1F8iSOhN4ldhVphA0KqID/MyvyhVSRUhgD20SN/9ddFkGzcELLGHWj4
         56acO3/J+8h07K7iUjVXAFeMjzhh1tHuWtxJWMWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 576/694] RDMA/siw: Fix potential page_array out of range access
Date:   Mon,  8 May 2023 11:46:51 +0200
Message-Id: <20230508094453.591927553@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 271bfcfb83a9f77cbae3d6e1a16e3c14132922f0 ]

When seg is equal to MAX_ARRAY, the loop should break, otherwise
it will result in out of range access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Link: https://lore.kernel.org/r/20230227091751.589612-1-d.dulov@aladdin.ru
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 05052b49107f2..6bb9e9e81ff4c 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -558,7 +558,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			data_len -= plen;
 			fp_off = 0;
 
-			if (++seg > (int)MAX_ARRAY) {
+			if (++seg >= (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
 				siw_unmap_pages(iov, kmap_mask, seg-1);
 				wqe->processed -= c_tx->bytes_unsent;
-- 
2.39.2



