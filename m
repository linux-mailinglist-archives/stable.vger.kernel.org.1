Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90F76AFEF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjHAJvj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjHAJvW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07C2D62
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AE0614D0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A7BC433CA;
        Tue,  1 Aug 2023 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883449;
        bh=7en2ZsGzG4GBq5c5OHJtj5w8xAVrjarutFS4cVjJ3TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnE3xLaYlI5Fkz4kHcR/sCLtXjpoB/Yn1PCARtd5gRlqt7ofRhu2KTTykV3bMOdbF
         Rbyb+KjykCWvB3hV1ra/pQZlWv0uVwpLf6gVmKRmf61N8nqTVlvgf1wA1sYTylhFIK
         tS/7TL512MHDxI6mlL0lh8KfUs3k86NQ6/+rdKQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 6.4 220/239] fs/9p: remove unnecessary invalidate_inode_pages2
Date:   Tue,  1 Aug 2023 11:21:24 +0200
Message-ID: <20230801091933.859126844@linuxfoundation.org>
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

commit 350cd9b959757e7c571f45fab29d116d5f67cbff upstream.

There was an invalidate_inode_pages2 added to readonly mmap path
that is unnecessary since that path is only entered when writeback
cache is disabled on mount.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_file.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -484,7 +484,6 @@ v9fs_file_mmap(struct file *filp, struct
 
 	if (!(v9ses->cache & CACHE_WRITEBACK)) {
 		p9_debug(P9_DEBUG_CACHE, "(read-only mmap mode)");
-		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}
 


