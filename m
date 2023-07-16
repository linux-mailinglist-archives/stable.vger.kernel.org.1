Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADA75560E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjGPUrF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjGPUrE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:47:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2841D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E1460EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687A0C433C7;
        Sun, 16 Jul 2023 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540422;
        bh=lqw0NhZDuc9BOWsD9HyE8KY5vzYfnpWtwbUL3D10ZM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLxIxrki18mYk5hCVeXNqQXX0Pno3rtQZPp6h2tEGxeb/QF1slLT7w8brbmEmRjmo
         Mtf4KGHBJwl0jLFGSgrKU6NG46IW8oz6sVI091ArgkzSH2jXdbH956GzzlNlF4Xcy/
         tazEBR324ueOjU7ZJs+LVhU88vxTYyN02qZK71vY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 358/591] smb: client: fix broken file attrs with nodfs mounts
Date:   Sun, 16 Jul 2023 21:48:17 +0200
Message-ID: <20230716194933.176103144@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit d439b29057e26464120fc6c18f97433aa003b5fe ]

*_get_inode_info() functions expect -EREMOTE when query path info
calls find a DFS link, regardless whether !CONFIG_CIFS_DFS_UPCALL or
'nodfs' mount option.  Otherwise, those files will miss the fake DFS
file attributes.

Before patch

  $ mount.cifs //srv/dfs /mnt/1 -o ...,nodfs
  $ ls -l /mnt/1
  ls: cannot access '/mnt/1/link': Operation not supported
  total 0
  -rwxr-xr-x 1 root root 0 Jul 26  2022 dfstest2_file1.txt
  drwxr-xr-x 2 root root 0 Aug  8  2022 dir1
  d????????? ? ?    ?    ?            ? link

After patch

  $ mount.cifs //srv/dfs /mnt/1 -o ...,nodfs
  $ ls -l /mnt/1
  total 0
  -rwxr-xr-x 1 root root 0 Jul 26  2022 dfstest2_file1.txt
  drwxr-xr-x 2 root root 0 Aug  8  2022 dir1
  drwx--x--x 2 root root 0 Jun 26 20:29 link

Fixes: c877ce47e137 ("cifs: reduce roundtrips on create/qinfo requests")
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 57526bdbab171..5ddc629e62168 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -592,9 +592,6 @@ int smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 			if (islink)
 				rc = -EREMOTE;
 		}
-		if (rc == -EREMOTE && IS_ENABLED(CONFIG_CIFS_DFS_UPCALL) && cifs_sb &&
-		    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS))
-			rc = -EOPNOTSUPP;
 	}
 
 out:
-- 
2.39.2



