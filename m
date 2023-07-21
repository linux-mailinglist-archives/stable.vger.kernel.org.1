Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0875D347
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGUTIz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGUTIy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553030E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4B661D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E7C433C8;
        Fri, 21 Jul 2023 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966532;
        bh=ZdzfQRah4eAhOX2WUVKkN3GFZwn7Wnw4GfWB6eyBjDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nja0J6SbULkLT6T/BX9vezYBa7vSS2aQhT4OD1lUDIS0wbpj7xuUpUtnvW7OUO8aY
         QUlVXtBgWUpdVw3hhbmGWeAsocZN9c/k1Eu4QBmD2fc5jiJiLCcVm/tECYaVq57439
         jdjJnD0wtcoCd/0LJQ+HgxHhyhO+nXhycQdU25U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 376/532] fs: no need to check source
Date:   Fri, 21 Jul 2023 18:04:40 +0200
Message-ID: <20230721160634.889600444@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 66d8fc0539b0d49941f313c9509a8384e4245ac1 upstream.

The @source inode must be valid. It is even checked via IS_SWAPFILE()
above making it pretty clear. So no need to check it when we unlock.

What doesn't need to exist is the @target inode. The lock_two_inodes()
helper currently swaps the @inode1 and @inode2 arguments if @inode1 is
NULL to have consistent lock class usage. However, we know that at least
for vfs_rename() that @inode1 is @source and thus is never NULL as per
above. We also know that @source is a different inode than @target as
that is checked right at the beginning of vfs_rename(). So we know that
@source is valid and locked and that @target is locked. So drop the
check whether @source is non-NULL.

Fixes: 28eceeda130f ("fs: Lock moved directories")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202307030026.9sE2pk2x-lkp@intel.com
Message-Id: <20230703-vfs-rename-source-v1-1-37eebb29b65b@kernel.org>
[brauner: use commit message from patch I sent concurrently]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namei.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4759,8 +4759,7 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	if (source)
-		inode_unlock(source);
+	inode_unlock(source);
 	if (target)
 		inode_unlock(target);
 	dput(new_dentry);


