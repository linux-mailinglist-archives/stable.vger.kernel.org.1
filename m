Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFA755493
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGPUb6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjGPUbw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88677E48
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE4F60EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D32CC433C8;
        Sun, 16 Jul 2023 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539506;
        bh=OQwUDxUZut63Iz4v5xigsxKLefG9Mjr1/mSDKCTPGxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VubmYBeQQDmgOT/qtJ7Xpck3Uvf9+R8wSXt1Y9JKWT+QANxPkmqHLUtrXyDlvLuwb
         8+h2jhoPG8qDXqZ7BrskqWFJ8oM/bzE9LVfom98A51Ze+IrR5+1yk9EogwVj6Xf0pT
         BJlM+dP52ljsBm06QW1YZa64+8DK/h/alIXCGD5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ido Schimmel <idosch@idosch.org>,
        NeilBrown <neilb@suse.de>, Ido Schimmel <idosch@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 014/591] lockd: drop inappropriate svc_get() from locked_get()
Date:   Sun, 16 Jul 2023 21:42:33 +0200
Message-ID: <20230716194924.234374869@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: NeilBrown <neilb@suse.de>

[ Upstream commit 665e89ab7c5af1f2d260834c861a74b01a30f95f ]

The below-mentioned patch was intended to simplify refcounting on the
svc_serv used by locked.  The goal was to only ever have a single
reference from the single thread.  To that end we dropped a call to
lockd_start_svc() (except when creating thread) which would take a
reference, and dropped the svc_put(serv) that would drop that reference.

Unfortunately we didn't also remove the svc_get() from
lockd_create_svc() in the case where the svc_serv already existed.
So after the patch:
 - on the first call the svc_serv was allocated and the one reference
   was given to the thread, so there are no extra references
 - on subsequent calls svc_get() was called so there is now an extra
   reference.
This is clearly not consistent.

The inconsistency is also clear in the current code in lockd_get()
takes *two* references, one on nlmsvc_serv and one by incrementing
nlmsvc_users.   This clearly does not match lockd_put().

So: drop that svc_get() from lockd_get() (which used to be in
lockd_create_svc().

Reported-by: Ido Schimmel <idosch@idosch.org>
Closes: https://lore.kernel.org/linux-nfs/ZHsI%2FH16VX9kJQX1@shredder/T/#u
Fixes: b73a2972041b ("lockd: move lockd_start_svc() call into lockd_create_svc()")
Signed-off-by: NeilBrown <neilb@suse.de>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 59ef8a1f843f3..5579e67da17db 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -355,7 +355,6 @@ static int lockd_get(void)
 	int error;
 
 	if (nlmsvc_serv) {
-		svc_get(nlmsvc_serv);
 		nlmsvc_users++;
 		return 0;
 	}
-- 
2.39.2



