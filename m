Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05F78AA35
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjH1KUJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjH1KTi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20E10C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7B4637B4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E21C433C7;
        Mon, 28 Aug 2023 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217941;
        bh=oMri1BRhwMl9d0g1ZR9AvkaCs8FXr6zEuXiNFNgCcKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoDDJSljNoxjESGMyyNez+UTNqh2y2USQSlJx8hPgxsnDlhG3q6y+D+LM4krzg2Ox
         L6HReOSSc1qXYCdeZvJJRVOQEmFR4zjoRYQuTxeYEqjwfESOA6ZOJJqJPrsYxPF3wq
         vvJ5ajeJ4Ep9EooXeMa1yynME441W18Xkq4s9rX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fiona Ebner <f.ebner@proxmox.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 036/129] tg3: Use slab_build_skb() when needed
Date:   Mon, 28 Aug 2023 12:11:55 +0200
Message-ID: <20230828101158.583818028@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 99b415fe8986803ba0eaf6b8897b16edc8fe7ec2 ]

The tg3 driver will use kmalloc() under some conditions. Check the
frag_size and use slab_build_skb() when frag_size is 0. Silences
the warning introduced by commit ce098da1497c ("skbuff: Introduce
slab_build_skb()"):

	Use slab_build_skb() instead
	...
	tg3_poll_work+0x638/0xf90 [tg3]

Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://lore.kernel.org/all/1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20230818175417.never.273-kees@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5ef073a79ce94..cb2810f175ccd 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6881,7 +6881,10 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 
 			ri->data = NULL;
 
-			skb = build_skb(data, frag_size);
+			if (frag_size)
+				skb = build_skb(data, frag_size);
+			else
+				skb = slab_build_skb(data);
 			if (!skb) {
 				tg3_frag_free(frag_size != 0, data);
 				goto drop_it_no_recycle;
-- 
2.40.1



