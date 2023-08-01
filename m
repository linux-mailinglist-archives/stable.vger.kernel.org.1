Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FA76AEA6
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjHAJkf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjHAJkI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5CE1985
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D59561507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C2BC433C8;
        Tue,  1 Aug 2023 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882685;
        bh=XhABoXK3MZ6InE6Cx6RgE3IE/CjlFi6FEWpFYGZGxb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpZSuTi+HmApGffraDKet8fFx8ZNSpV5GINf27ShVLZHPD+9OxkSD+gwPGZloi2fq
         SCLNQiGaSJfThR6Pv2XTCeUYxbeAKbgBG5mmKRhGI41Dp0rlizvVfPZU/kn5RcQRnA
         LzOQzUcp+XMHMONmqD/MNPdZPupOG2qbiHLTwrc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 194/228] proc/vmcore: fix signedness bug in read_from_oldmem()
Date:   Tue,  1 Aug 2023 11:20:52 +0200
Message-ID: <20230801091929.874597014@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 641db40f3afe7998011bfabc726dba3e698f8196 upstream.

The bug is the error handling:

	if (tmp < nr_bytes) {

"tmp" can hold negative error codes but because "nr_bytes" is type size_t
the negative error codes are treated as very high positive values
(success).  Fix this by changing "nr_bytes" to type ssize_t.  The
"nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
they can fit in ssize_t without any issue.

Link: https://lkml.kernel.org/r/b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain
Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/vmcore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -132,7 +132,7 @@ ssize_t read_from_oldmem(struct iov_iter
 			 u64 *ppos, bool encrypted)
 {
 	unsigned long pfn, offset;
-	size_t nr_bytes;
+	ssize_t nr_bytes;
 	ssize_t read = 0, tmp;
 	int idx;
 


