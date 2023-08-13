Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F177AC89
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHMVeP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHMVeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DF1710
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FE262C75
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD16C433C8;
        Sun, 13 Aug 2023 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962453;
        bh=px2ikZgJt3p1w8e9TEPRcoe7l5DCFqn1YlrIsCewxYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4DzdqBivx+BETVYbPtyPL0SMRhGo06ryKuTcdeKLgSvrd1FQyEZaG7jm4cIcKEtB
         Ro+es4hstbd0RmQ0CCFjG4fqwAs+X9SjJ5NRZxAE681FjWqzyF7kH5qJ+7w9lwsS81
         MjLMtA9ZvmwT2H0qEU+eMgs0EIPhpGLW1Gkz9HZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 035/149] radix tree test suite: fix incorrect allocation size for pthreads
Date:   Sun, 13 Aug 2023 23:18:00 +0200
Message-ID: <20230813211719.856600552@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

commit cac7ea57a06016e4914848b707477fb07ee4ae1c upstream.

Currently the pthread allocation for each array item is based on the size
of a pthread_t pointer and should be the size of the pthread_t structure,
so the allocation is under-allocating the correct size.  Fix this by using
the size of each element in the pthreads array.

Static analysis cppcheck reported:
tools/testing/radix-tree/regression1.c:180:2: warning: Size of pointer
'threads' used instead of size of its data. [pointerSize]

Link: https://lkml.kernel.org/r/20230727160930.632674-1-colin.i.king@gmail.com
Fixes: 1366c37ed84b ("radix tree test harness")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/radix-tree/regression1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -177,7 +177,7 @@ void regression1_test(void)
 	nr_threads = 2;
 	pthread_barrier_init(&worker_barrier, NULL, nr_threads);
 
-	threads = malloc(nr_threads * sizeof(pthread_t *));
+	threads = malloc(nr_threads * sizeof(*threads));
 
 	for (i = 0; i < nr_threads; i++) {
 		arg = i;


