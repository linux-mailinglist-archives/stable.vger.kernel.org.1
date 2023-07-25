Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64D2761136
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGYKso (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYKsm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09310FD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAFD61655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBEAC433C7;
        Tue, 25 Jul 2023 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282121;
        bh=NVZFQdo3THDP+NPb0zeIaH4tSuEXZVBjnIO3q8SPIY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqlnm1o9SgaLHh564gllzTCcKr656YQ8bp30bLTKZCTJKMIgaaQUCbLz7pAsajdlL
         t0VkuSPpFesp1rT5qcTl+AXGD4EhNV1W8pZWBCVL2gXXxBSzIA8+xmAxsvBSOX3zQi
         PiPX/Sfy0PXokwlIHNKvaJ/iRw7QBb7in2qA5C/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xu Rongbo <xurongbo@baidu.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.4 016/227] fuse: revalidate: dont invalidate if interrupted
Date:   Tue, 25 Jul 2023 12:43:03 +0200
Message-ID: <20230725104515.462227578@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit a9d1c4c6df0e568207907c04aed9e7beb1294c42 upstream.

If the LOOKUP request triggered from fuse_dentry_revalidate() is
interrupted, then the dentry will be invalidated, possibly resulting in
submounts being unmounted.

Reported-by: Xu Rongbo <xurongbo@baidu.com>
Closes: https://lore.kernel.org/all/CAJfpegswN_CJJ6C3RZiaK6rpFmNyWmXfaEpnQUJ42KCwNF5tWw@mail.gmail.com/
Fixes: 9e6268db496a ("[PATCH] FUSE - read-write operations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -258,7 +258,7 @@ static int fuse_dentry_revalidate(struct
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))


