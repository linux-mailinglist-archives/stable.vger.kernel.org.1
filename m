Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5A761267
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjGYLCG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjGYLBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703235588
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B71616A3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5472AC433C8;
        Tue, 25 Jul 2023 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282742;
        bh=rOPkcVZo97jOqtpgu7S2ZEpvotSZL9u3SxSmgcePGqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gtq1DsIfdrTcE+LUbn1nhOH9z9ZmX+k4H0RnVTGzxOMsApD5ATmRoSgVAu1bAXrPA
         Bl4ZcELx5/OlHKiUVIa7Fzg/e8eraeMt7BQlc+6nMYwCc5ktYcZL8drVMsg+p3Tq59
         SvXA8nsLSUD8nLCktiLF2oEcYdCwF5TSNJveAwzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 6.1 011/183] fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT
Date:   Tue, 25 Jul 2023 12:43:59 +0200
Message-ID: <20230725104508.222712449@linuxfoundation.org>
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

From: Bernd Schubert <bschubert@ddn.com>

commit 3066ff93476c35679cb07a97cce37d9bb07632ff upstream.

This is just a safety precaution to avoid checking flags on memory that was
initialized on the user space side.  libfuse zeroes struct fuse_init_out
outarg, but this is not guranteed to be done in all implementations.
Better is to act on flags and to only apply flags2 when FUSE_INIT_EXT is
set.

There is a risk with this change, though - it might break existing user
space libraries, which are already using flags2 without setting
FUSE_INIT_EXT.

The corresponding libfuse patch is here
https://github.com/libfuse/libfuse/pull/662

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Fixes: 53db28933e95 ("fuse: extend init flags")
Cc: <stable@vger.kernel.org> # v5.17
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/fuse/inode.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1127,7 +1127,10 @@ static void process_init_reply(struct fu
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags | (u64) arg->flags2 << 32;
+			u64 flags = arg->flags;
+
+			if (flags & FUSE_INIT_EXT)
+				flags |= (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)


