Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6B73E7B9
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFZSSJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFZSSI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33294
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 445C160F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44481C433C0;
        Mon, 26 Jun 2023 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803486;
        bh=4PWE3ykqn1k155ujOMaKHhbDukWjMc3TmCyTFuvqZAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2UkbdGbHRr1VbJYAfzMxoyYhrG/q0uHYp9n/4wNQqobzZdhf4I2MPO/vYFyXjkb5
         K6geR8sNFJHJoBUWoRHGNvNDczArZwhTNp3hg7hGaIS5TrgXO44dg//6qtzRIb6WBT
         h4XEpiQdP+u7i0QGLpHsx1YNAR4xIdH07rqdDC+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 060/199] mm/mprotect: fix do_mprotect_pkey() limit check
Date:   Mon, 26 Jun 2023 20:09:26 +0200
Message-ID: <20230626180808.206508926@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit 77795f900e2a07c1cbedc375789aefb43843b6c2 upstream.

The return of do_mprotect_pkey() can still be incorrectly returned as
success if there is a gap that spans to or beyond the end address passed
in.  Update the check to ensure that the end address has indeed been seen.

Link: https://lore.kernel.org/all/CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230606182912.586576-1-Liam.Howlett@oracle.com
Fixes: 82f951340f25 ("mm/mprotect: fix do_mprotect_pkey() return on error")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mprotect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -838,7 +838,7 @@ static int do_mprotect_pkey(unsigned lon
 	}
 	tlb_finish_mmu(&tlb);
 
-	if (!error && vma_iter_end(&vmi) < end)
+	if (!error && tmp < end)
 		error = -ENOMEM;
 
 out:


