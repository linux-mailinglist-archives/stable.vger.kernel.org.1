Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6E47A7DAF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjITMLW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjITMLV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:11:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA3AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:11:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59751C433C7;
        Wed, 20 Sep 2023 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211871;
        bh=2y8Vyu2wq+JZoyk6s5yYM0lhiQFXK609jAk7EYILBso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTqjg2iB7zpEF00WRdCF3ivYENy/DVqww8gvBpyHVQiEZIzGgKOKw7BOdrRv4ypiB
         bCut7Qb5NF3xjDM018sYLa+O8vu+yASktXBaQvCfwnbnCWpz0sX9tuf7MPvOHdd98U
         tHI7UzdVgcPEN1TH5iHvT0lhjg2/f0+1PnIhuGig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Mastykin <dmastykin@astralinux.ru>,
        Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/273] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date:   Wed, 20 Sep 2023 13:27:51 +0200
Message-ID: <20230920112847.385779759@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Mastykin <dmastykin@astralinux.ru>

[ Upstream commit b403643d154d15176b060b82f7fc605210033edd ]

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 15fe2120b3109..14c3d640f94b9 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -871,7 +871,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
-- 
2.40.1



