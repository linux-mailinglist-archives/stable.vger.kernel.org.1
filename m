Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC847B87FC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbjJDSLs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbjJDSLh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:11:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3BC9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:11:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75F6C433C8;
        Wed,  4 Oct 2023 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443093;
        bh=KypSy4v5XEKCyLQ2f7m+ozVNyAR5ABvALptGwt9B2do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryxJhE08khawFjanm+1QbRjOyZ1W6oRyawwI0RNVtCmCf0lGn1VplgfX8Y8XoF11a
         9aNHn3/Nqv/vResXqivvwR6vSFMivXLacl6lHVb11uSHZmtUwq6kKuzLSp0GDIX86K
         nwoO+CKcZ5sfGgUGxCtr6K2W86Vz5X2y7482Q2sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/259] NFS/pNFS: Report EINVAL errors from connect() to the server
Date:   Wed,  4 Oct 2023 19:52:59 +0200
Message-ID: <20231004175217.723669415@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit dd7d7ee3ba2a70d12d02defb478790cf57d5b87b ]

With IPv6, connect() can occasionally return EINVAL if a route is
unavailable. If this happens during I/O to a data server, we want to
report it using LAYOUTERROR as an inability to connect.

Fixes: dd52128afdde ("NFSv4.1/pnfs Ensure flexfiles reports all connection related errors")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1ec79ccf89ad2..5c69a6e9ab3e1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1235,6 +1235,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
-- 
2.40.1



