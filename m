Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9980719DB3
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjFANZt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjFANZk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520BE6A
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F486448E
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B659C433EF;
        Thu,  1 Jun 2023 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625911;
        bh=dq2VkogEOvOc9nBziMaAEroK8xNOlKJvrqsUcRZwHi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tuJEoGiUc5282502xqRCh6b9osrkdyDbq/k+MwUNEO2gR5DLu+6hQxUQIq4jgbrRn
         ulFSODXMq+1/QSyp9G+pvVKKrAizKZ0vbU+BDR9ke+33TwmcZkp3WFZGIE1FAnG7XG
         zy7Q4ImXPQgbWLsPkXB4jVB49iQWQeFGaLOgh6aA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 35/42] xdp: xdp_mem_allocator can be NULL in trace_mem_connect().
Date:   Thu,  1 Jun 2023 14:21:22 +0100
Message-Id: <20230601131938.284914018@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit e0ae713023a9d09d6e1b454bdc8e8c1dd32c586e ]

Since the commit mentioned below __xdp_reg_mem_model() can return a NULL
pointer. This pointer is dereferenced in trace_mem_connect() which leads
to segfault.

The trace points (mem_connect + mem_disconnect) were put in place to
pair connect/disconnect using the IDs. The ID is only assigned if
__xdp_reg_mem_model() does not return NULL. That connect trace point is
of no use if there is no ID.

Skip that connect trace point if xdp_alloc is NULL.

[ Toke Høiland-Jørgensen delivered the reasoning for skipping the trace
  point ]

Fixes: 4a48ef70b93b8 ("xdp: Allow registering memory model without rxq reference")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/YikmmXsffE+QajTB@linutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/xdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 5ed2e9d5a3191..a3e3d2538a3a8 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -359,7 +359,8 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	if (IS_ERR(xdp_alloc))
 		return PTR_ERR(xdp_alloc);
 
-	trace_mem_connect(xdp_alloc, xdp_rxq);
+	if (trace_mem_connect_enabled() && xdp_alloc)
+		trace_mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
-- 
2.39.2



