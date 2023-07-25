Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610F761289
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjGYLDn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjGYLDR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61C5B95
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9246D61696
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F0BC433C8;
        Tue, 25 Jul 2023 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282807;
        bh=qH2x+5xkOk9fUoEZOMUelcNe2MnZ3IYqpNWq6C1wAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lizk8n6XO7VOofIPMvzkY1o9NtXEe++1pV8oe/HoTsBVVfwJtLGstsJrA7Yd16oVi
         pqn4fcl7rhuiUoEpH7LlZxNBY7feivS3gFEHtHy4mAP3zs3sU0wIMU4lUVh03TQKnZ
         JgYq+N699B40/oyqagdkUIH38lUNSRu2PUGUpU3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 006/183] maple_tree: fix node allocation testing on 32 bit
Date:   Tue, 25 Jul 2023 12:43:54 +0200
Message-ID: <20230725104508.033329163@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit ef5c3de5211b5a3a8102b25aa83eb4cde65ac2fd upstream.

Internal node counting was altered and the 64 bit test was updated,
however the 32bit test was missed.

Restore the 32bit test to a functional state.

Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230712173916.168805-2-Liam.Howlett@oracle.com
Fixes: 541e06b772c1 ("maple_tree: remove GFP_ZERO from kmem_cache_alloc() and kmem_cache_alloc_bulk()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/radix-tree/maple.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -181,9 +181,9 @@ static noinline void check_new_node(stru
 				e = i - 1;
 		} else {
 			if (i >= 4)
-				e = i - 4;
-			else if (i == 3)
-				e = i - 2;
+				e = i - 3;
+			else if (i >= 1)
+				e = i - 1;
 			else
 				e = 0;
 		}


