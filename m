Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E450B76AFF7
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjHAJvu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjHAJvb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888A1985
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A7E614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E89C433C7;
        Tue,  1 Aug 2023 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883468;
        bh=b2vX+9Aej4/+tHWd3qLzJGnYcZmg0ccTNaIOibTA2sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfUmeon8iXsnocRGV1H0edYONVA0hYB8B6w8s5ao9poPYZRlwuIzhNqfrDspiVhX0
         WwY0Vw5cqscvqjddwei0ho8aSiTYbYDl0wz8lQeaCPmsd5CXDvTThnPlkCEgXAz/xT
         iof0TJSdnmN1oFAE8V2exVVkBkwmeg/tpHFPTdA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 6.4 217/239] fs/9p: remove unnecessary and overrestrictive check
Date:   Tue,  1 Aug 2023 11:21:21 +0200
Message-ID: <20230801091933.739976804@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Eric Van Hensbergen <ericvh@kernel.org>

commit 75b396821cb71164dac3a1ad51dda4781ea8dbad upstream.

This eliminates a check for shared that was overrestrictive and
prevented read-only mmaps when writeback caches weren't enabled.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reported-by: Robert Schwebel <r.schwebel@pengutronix.de>
Closes: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_file.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -483,9 +483,7 @@ v9fs_file_mmap(struct file *filp, struct
 	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
-		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
+		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}


