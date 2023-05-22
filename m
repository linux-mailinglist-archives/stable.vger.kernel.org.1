Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855270C9E2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjEVTw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjEVTwj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3BF1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47B1062B25
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F932C4339B;
        Mon, 22 May 2023 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785154;
        bh=d5RU3Okkp66UolqrrrFVQ1vav9ap1F8aLgyevXP8y/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=10k8inHEKnEtzDZQrGQUMfaj0WJVqHtoKiFwaIYSCqrAzkl2wJyC3rtmOynRqawzZ
         IrdKzBffTL8WHEAGl20MNBkimxT0TPFJ6667NKjIhC5P0XkeIzYsaTTwd4ayd7B94k
         c/cdz63L9kDm7IizOk/37ao5sba2euF3cpgN2SaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Zhang <zhangpeng.00@bytedance.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 328/364] maple_tree: make maple state reusable after mas_empty_area()
Date:   Mon, 22 May 2023 20:10:33 +0100
Message-Id: <20230522190420.974593586@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit 0257d9908d38c0b1669af4bb1bc4dbca1f273fe6 upstream.

Make mas->min and mas->max point to a node range instead of a leaf entry
range.  This allows mas to still be usable after mas_empty_area() returns.
Users would get unexpected results from other operations on the maple
state after calling the affected function.

For example, x86 MAP_32BIT mmap() acts as if there is no suitable gap when
there should be one.

Link: https://lkml.kernel.org/r/20230505145829.74574-1-zhangpeng.00@bytedance.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Reported-by: Tad <support@spotco.us>
Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
  Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
  Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/maple_tree.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5340,15 +5340,9 @@ int mas_empty_area(struct ma_state *mas,
 
 	mt = mte_node_type(mas->node);
 	pivots = ma_pivots(mas_mn(mas), mt);
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-
-	if (offset < mt_pivots[mt])
-		mas->max = pivots[offset];
-
-	if (mas->index < mas->min)
-		mas->index = mas->min;
-
+	min = mas_safe_min(mas, pivots, offset);
+	if (mas->index < min)
+		mas->index = min;
 	mas->last = mas->index + size - 1;
 	return 0;
 }


