Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80B78AA92
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjH1KXY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjH1KWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA676107
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C91D6397B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA1AC433C8;
        Mon, 28 Aug 2023 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218170;
        bh=hvHhBqhHrMobD8t5Z7UAEB4RbnHCMvC0rXTMJpdlveI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktI4OpQxyKprxysjT6tFeihVq+Pq+dGFxseytoTR8KUD/TkTrZl0VvyipZQAfaCd6
         I6iYaAt8X66E/V8XN1LLIoLGrd5x4fBPtFciBl0TSE69mcGScl81Q6rTR71VMUgh1n
         LjaYhW9IS2GRwTFmSpkztn7/iosTyrcLb4j63Trg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 6.4 103/129] of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
Date:   Mon, 28 Aug 2023 12:13:02 +0200
Message-ID: <20230828101200.782230678@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit 0aeae3788e28f64ccb95405d4dc8cd80637ffaea upstream.

Commit 12e17243d8a1 ("of: base: improve error msg in
of_phandle_iterator_next()") added printing of the phandle value on
error, but failed to update the unittest.

Fixes: 12e17243d8a1 ("of: base: improve error msg in of_phandle_iterator_next()")
Cc: stable@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230801-dt-changeset-fixes-v3-1-5f0410e007dd@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/unittest.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -664,12 +664,12 @@ static void __init of_unittest_parse_pha
 	memset(&args, 0, sizeof(args));
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 


