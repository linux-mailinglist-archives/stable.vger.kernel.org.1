Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779E776131F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGYLIU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjGYLHb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08E93C0B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7389D6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C19C433C8;
        Tue, 25 Jul 2023 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283174;
        bh=sCPzJ58rJYzroxH1xC+4Hb+DiSvqOQcB2ylZam0dqTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rnx38f2SaFzqy7THa8PnhHt46ou6paOriXOSdymJ6STMQbxeLSgqG8rXWoURKn78n
         u47aHlbOTG952LS1gxZKoKAdY/JCLHdMtnqdW5FSPJpdDkwJox82yYEjthviM4LGjr
         sUOnXvRFAXglFfyXL6b2vNG+HEdWQZa6nMVhe1IA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunxiang Li <Yunxiang.Li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.1 166/183] drm/ttm: fix bulk_move corruption when adding a entry
Date:   Tue, 25 Jul 2023 12:46:34 +0200
Message-ID: <20230725104513.760072287@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yunxiang Li <Yunxiang.Li@amd.com>

commit 4481913607e58196c48a4fef5e6f45350684ec3c upstream.

When the resource is the first in the bulk_move range, adding it again
(thus moving it to the tail) will corrupt the list since the first
pointer is not moved. This eventually lead to null pointer deref in
ttm_lru_bulk_move_del()

Fixes: fee2ede15542 ("drm/ttm: rework bulk move handling v5")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230622141902.28718-3-Yunxiang.Li@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_resource.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -85,6 +85,8 @@ static void ttm_lru_bulk_move_pos_tail(s
 				       struct ttm_resource *res)
 {
 	if (pos->last != res) {
+		if (pos->first == res)
+			pos->first = list_next_entry(res, lru);
 		list_move(&res->lru, &pos->last->lru);
 		pos->last = res;
 	}
@@ -110,7 +112,8 @@ static void ttm_lru_bulk_move_del(struct
 {
 	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
 
-	if (unlikely(pos->first == res && pos->last == res)) {
+	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
+		     (pos->first == res && pos->last == res))) {
 		pos->first = NULL;
 		pos->last = NULL;
 	} else if (pos->first == res) {


