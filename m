Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D4726B27
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjFGUXR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFGUXF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4931BD6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D090618C2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA18AC433EF;
        Wed,  7 Jun 2023 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169356;
        bh=skiiqiBrch32MYNPPGXiAhUAfZ8nmDkt3MWyA6yvheA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2gV8y/iIGtdd6a0B3E7g8Rk1PENngKUke6JyDglfQ8sHt9mY/j/LCxnWm60x+NcC
         27XIzdNKtpDY7OjIqzKfkNuDnOZ0bZ8T2vyfA6rthgEqw5fG3X4YKeON0ReoDF9aeZ
         AhHks80IZKgv/xeHioTmtFDbRn/cOxKs/AAABsBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 050/286] net/smc: Scan from current RMB list when no position specified
Date:   Wed,  7 Jun 2023 22:12:29 +0200
Message-ID: <20230607200924.680737134@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit b24aa141c2ff26c919237aee61ea1818fc6780d9 ]

When finding the first RMB of link group, it should start from the
current RMB list whose index is 0. So fix it.

Fixes: b4ba4652b3f8 ("net/smc: extend LLC layer for SMC-Rv2")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_llc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index a0840b8c935b8..8423e8e0063f4 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -578,7 +578,10 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
 {
 	struct smc_buf_desc *buf_next;
 
-	if (!buf_pos || list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
+	if (!buf_pos)
+		return _smc_llc_get_next_rmb(lgr, buf_lst);
+
+	if (list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
 		(*buf_lst)++;
 		return _smc_llc_get_next_rmb(lgr, buf_lst);
 	}
-- 
2.39.2



