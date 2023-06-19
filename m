Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA08273525A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjFSKeG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjFSKdv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5430127
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80DAA60B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942C1C433C8;
        Mon, 19 Jun 2023 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170829;
        bh=kybRpC5mWdsrViV4HvFm/3Zn4Fh2e7TlqqPq8L2nJVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFfHK2gQ4on/olulBTCJGfpNqi43C0DVWIRORYqUCelwGF+apCpv2NB6myNERf2Ku
         aQSOGeb6JNJu+DV5ZZTduTnMJuwgzSQld+C7iSwfm3UMmAPZ0hhyo/4RSRsgpnUb1K
         i9HgG+Cbaz8dkYrFGVuSjG5x9pjVQGsXvGowTzlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com,
        SeongJae Park <sj@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 051/187] mm/damon/core: fix divide error in damon_nr_accesses_to_accesses_bp()
Date:   Mon, 19 Jun 2023 12:27:49 +0200
Message-ID: <20230619102200.129368749@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit 5ff6e2fff88ef9bf110c5e85a48e7b557bfc64c1 upstream.

If 'aggr_interval' is smaller than 'sample_interval', max_nr_accesses in
damon_nr_accesses_to_accesses_bp() becomes zero which leads to divide
error, let's validate the values of them in damon_set_attrs() to fix it,
which similar to others attrs check.

Link: https://lkml.kernel.org/r/20230527032101.167788-1-wangkefeng.wang@huawei.com
Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=841a46899768ec7bec67
Link: https://lore.kernel.org/damon/00000000000055fc4e05fc975bc2@google.com/
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d9ef62047bf5..91cff7f2997e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -551,6 +551,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
 		return -EINVAL;
+	if (attrs->sample_interval > attrs->aggr_interval)
+		return -EINVAL;
 
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
-- 
2.41.0



