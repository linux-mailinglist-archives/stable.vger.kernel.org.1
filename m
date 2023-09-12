Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CDD79B4AE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353096AbjIKWnW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbjIKOyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0735E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14600C433C7;
        Mon, 11 Sep 2023 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444047;
        bh=eRo51FvllvhJKbAaFeg83tWH55RVDbKxOOw6WpEjwNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elGKyC+gEb/zX9Dfj3Q1iJ2U+y5u50g5CHKcmJYqUm1N5zq5YmdGxD+oOOrxoQjKA
         NSkQ8Ff5yCZzjGsqBvuHGR+84s2j3yS8Zthugb02zDIiCVek6wyOqugTdRQc0SZP1F
         OpVE5vrQKLpSNT4eqRUXZG2KhhvwP+KL9sM7ATXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 592/737] RDMA/siw: Balance the reference of cep->kref in the error path
Date:   Mon, 11 Sep 2023 15:47:31 +0200
Message-ID: <20230911134707.066439016@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <guoqing.jiang@linux.dev>

[ Upstream commit b056327bee09e6b86683d3f709a438ccd6031d72 ]

The siw_connect can go to err in below after cep is allocated successfully:

1. If siw_cm_alloc_work returns failure. In this case socket is not
assoicated with cep so siw_cep_put can't be called by siw_socket_disassoc.
We need to call siw_cep_put twice since cep->kref is increased once after
it was initialized.

2. If siw_cm_queue_work can't find a work, which means siw_cep_get is not
called in siw_cm_queue_work, so cep->kref is increased twice by siw_cep_get
and when associate socket with cep after it was initialized. So we need to
call siw_cep_put three times (one in siw_socket_disassoc).

3. siw_send_mpareqrep returns error, this scenario is similar as 2.

So we need to remove one siw_cep_put in the error path.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Link: https://lore.kernel.org/r/20230821133255.31111-2-guoqing.jiang@linux.dev
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index da530c0404da4..a2605178f4eda 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1501,7 +1501,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
-- 
2.40.1



