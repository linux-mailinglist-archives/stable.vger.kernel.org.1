Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2487352A6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjFSKhG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFSKgl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABF10E2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B4160B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE969C433CA;
        Mon, 19 Jun 2023 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170997;
        bh=r1fkOfOgDbDKggSb5DQkVjXp4EzFsDgxATBOrxin2v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlZESkKj/1jUkeJMnE0iyvegxh1Y8nvLuctbyTXD2zNfiCqLr7RJeX1OgWbg+nZUz
         D1La9z2wY1kS1WUM+kqc56dT37EWFebFPgCEbATbYNFYR++5KLnYB6QlC/HfP+WoJT
         /TD0rNk7h7oT3Z0F2Xja3eId1VnUzyzhr6a39oOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 111/187] RDMA/rxe: Fix ref count error in check_rkey()
Date:   Mon, 19 Jun 2023 12:28:49 +0200
Message-ID: <20230619102202.957238140@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit b00683422fd79dd07c9b75efdce1660e5e19150e ]

There is a reference count error in error path code and a potential race
in check_rkey() in rxe_resp.c. When looking up the rkey for a memory
window the reference to the mw from rxe_lookup_mw() is dropped before a
reference is taken on the mr referenced by the mw. If the mr is destroyed
immediately after the call to rxe_put(mw) the mr pointer is unprotected
and may end up pointing at freed memory. The rxe_get(mr) call should take
place before the rxe_put(mw) call.

All errors in check_rkey() call rxe_put(mw) if mw is not NULL but it was
already called after the above. The mw pointer should be set to NULL after
the rxe_put(mw) call to prevent this from happening.

Fixes: cdd0b85675ae ("RDMA/rxe: Implement memory access through MWs")
Link: https://lore.kernel.org/r/20230517211509.1819998-1-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8c68340502769..4e8d8bec0010b 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -519,8 +519,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		if (mw->access & IB_ZERO_BASED)
 			qp->resp.offset = mw->addr;
 
-		rxe_put(mw);
 		rxe_get(mr);
+		rxe_put(mw);
+		mw = NULL;
 	} else {
 		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
-- 
2.39.2



