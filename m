Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA227A393F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbjIQTqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbjIQTqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:46:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF80E7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:46:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A84C433C8;
        Sun, 17 Sep 2023 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979990;
        bh=fMiNUMYgO4U5NqdsQNRoagXm4s1UH4+7QwnbDUM5wQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1S4avnEEC7F8dlq+RWmGSS2cssQxAANmAAB12965YXcuZnS1QH/FVNlBBlJDd587C
         XwecZU7i1rNyscMn5YWJpSTWfRw7ARmSrj1L9vRdpqrdhcThOqnII4mWUEzRnlbr5N
         R4qQTHZWgwJ6BuK0MlcJtWWAvSXCOJFTDKfo+8oA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Donnellan <ajd@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 037/285] lib/test_meminit: allocate pages up to order MAX_ORDER
Date:   Sun, 17 Sep 2023 21:10:37 +0200
Message-ID: <20230917191052.955528450@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Donnellan <ajd@linux.ibm.com>

commit efb78fa86e95832b78ca0ba60f3706788a818938 upstream.

test_pages() tests the page allocator by calling alloc_pages() with
different orders up to order 10.

However, different architectures and platforms support different maximum
contiguous allocation sizes.  The default maximum allocation order
(MAX_ORDER) is 10, but architectures can use CONFIG_ARCH_FORCE_MAX_ORDER
to override this.  On platforms where this is less than 10, test_meminit()
will blow up with a WARN().  This is expected, so let's not do that.

Replace the hardcoded "10" with the MAX_ORDER macro so that we test
allocations up to the expected platform limit.

Link: https://lkml.kernel.org/r/20230714015238.47931-1-ajd@linux.ibm.com
Fixes: 5015a300a522 ("lib: introduce test_meminit module")
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Xiaoke Wang <xkernel.wang@foxmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_meminit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i <= MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();


