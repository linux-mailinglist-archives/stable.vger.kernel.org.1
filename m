Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C876ADE9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjHAJe2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjHAJeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA313AB4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58986614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67774C433C9;
        Tue,  1 Aug 2023 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882321;
        bh=2VzeC+8Z8lQSffTQdhl/+Ayiwv4cntheT+WHaTZjW1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stmYlqPBG3UYYF1h7jpZNBLWjNbFSJBt/fACD/XCugrfwlbHxD06ixh3L0+t5+C52
         NY+/Hw4nY8iwrM/+oDWRZHagaaRzGnprz2A4YBNbyYi07+wTvgOF2eSV+3lBuw59+2
         rgRhYLIfQfINBEStdjjRB1pfBSzOf8W1OD00mP1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/228] maple_tree: fix 32 bit mas_next testing
Date:   Tue,  1 Aug 2023 11:18:42 +0200
Message-ID: <20230801091925.162033031@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Liam R. Howlett <Liam.Howlett@oracle.com>

[ Upstream commit 7a93c71a6714ca1a9c03d70432dac104b0cfb815 ]

The test setup of mas_next is dependent on node entry size to create a 2
level tree, but the tests did not account for this in the expected value
when shifting beyond the scope of the tree.

Fix this by setting up the test to succeed depending on the node entries
which is dependent on the 32/64 bit setup.

Link: https://lkml.kernel.org/r/20230712173916.168805-1-Liam.Howlett@oracle.com
Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module testing")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
  Closes: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_maple_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 261bad680f81d..fad668042f3e7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1863,13 +1863,16 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 						   725};
 	static const unsigned long level2_32[] = { 1747, 2000, 1750, 1755,
 						   1760, 1765};
+	unsigned long last_index;
 
 	if (MAPLE_32BIT) {
 		nr_entries = 500;
 		level2 = level2_32;
+		last_index = 0x138e;
 	} else {
 		nr_entries = 200;
 		level2 = level2_64;
+		last_index = 0x7d6;
 	}
 
 	for (i = 0; i <= nr_entries; i++)
@@ -1976,7 +1979,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != last_index);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
-- 
2.39.2



