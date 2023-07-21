Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95275CE40
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjGUQTH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjGUQSk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE84680
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD1C61D29
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEAFC433C8;
        Fri, 21 Jul 2023 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956246;
        bh=F03z8reMNMI+cdq1lVq6R5tucQkIzOfMLxjYTZQKuIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2RniIZx2WKiqg0u+NqHjHH/UgvXURSfEDA4PjF3ub511LbTJoUTXH6Auhf672sLH
         m7bJW/Y2JhjSDgOk/XxJL9qsMgQzyA9F/SADWUR9j4iZeF73cmzvQHVyaeMkCIsvr6
         xc6iYSacSOK60oU7obSFVPcs1i/a35gs16YN5jqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        stable@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.4 151/292] ext4: fix wrong unit use in ext4_mb_clear_bb
Date:   Fri, 21 Jul 2023 18:04:20 +0200
Message-ID: <20230721160535.389241338@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 247c3d214c23dfeeeb892e91a82ac1188bdaec9f upstream.

Function ext4_issue_discard need count in cluster. Pass count_clusters
instead of count to fix the mismatch.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230603150327.3596033-11-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6243,8 +6243,8 @@ do_more:
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit,
+						 count_clusters, NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"


