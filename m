Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA20726D16
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjFGUjG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjFGUil (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF32713
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A075B639BC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86F3C433EF;
        Wed,  7 Jun 2023 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170302;
        bh=8+mQAWJMmmf7sBg/yUWDv4VgtWsALOQO1EhL1CaFR2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDrWreRkVxNbuksE+ocpGRCZHSZimax3LWFkes1thqSPgZp3h/NTNEqngkyBxEvtL
         Y7RIhHBy1mWS7/c2s6I/NdyFe8GuXIDD0pxavEntnMmD7j5isdKe1+yzxYWA5EPZdB
         26J8kDmfEj6rZx+c8FjypEXX3HydCxNLKFX34Axk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/225] net/smc: Scan from current RMB list when no position specified
Date:   Wed,  7 Jun 2023 22:13:46 +0200
Message-ID: <20230607200915.401328808@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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
index 524649d0ab652..85af5bfa96228 100644
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



