Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C847A80AC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjITMjO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjITMjL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:39:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768EA122
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:38:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3FC433C9;
        Wed, 20 Sep 2023 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213531;
        bh=dp/vaowTz/5FKxgNO+TH8+AW4jB85XHe3+u9OsaHxwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRhckDNnUPOBF9sI4kWibj6Xzxf5yoJODuHBvsuRoccpSD0bTnxvX5RoMs4TKLk6m
         /9AoQ42hvA47S3bYs4F+T0oJd6HP8NsYUV3i9UpQ6R1Maxvkylj+FRf/Ho+j8tdc13
         qmKv+nBtnGsA8BJ6rBrrFfsaUbNuI0aEsweJnkM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Donnellan <ajd@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 246/367] lib/test_meminit: allocate pages up to order MAX_ORDER
Date:   Wed, 20 Sep 2023 13:30:23 +0200
Message-ID: <20230920112904.921107485@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -86,7 +86,7 @@ static int __init test_pages(int *total_
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i <= MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();


