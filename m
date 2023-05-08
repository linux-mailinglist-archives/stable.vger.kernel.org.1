Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54E6FAEA7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjEHLqg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjEHLqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FA10E6B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D695636B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C334C433EF;
        Mon,  8 May 2023 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546366;
        bh=2yX76qLcn1KkNIJrDXgeIgBXiy8XGQgn4DbjAXQFVQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvzRFlR5/UgCUIx8lvk5AJ5+MyO1Hd6ivepw7Rooi+/Uk+edPK87eZofqsHtk+8Vf
         evrY6GLOto/xk6vvZaz+M3ihywlrpoWbp693v7K/+9IclOvJt5P9dZU2D8XNDvRf5F
         jz3Nb9glvVaFcxy7h0QoTzyOVSZQ/KunFiGS1nxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 344/371] afs: Fix updating of i_size with dv jump from server
Date:   Mon,  8 May 2023 11:49:05 +0200
Message-Id: <20230508094825.799944115@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit d7f74e9a917503ee78f2b603a456d7227cf38919 ]

If the data version returned from the server is larger than expected,
the local data is invalidated, but we may still want to note the remote
file size.

Since we're setting change_size, we have to also set data_changed
for the i_size to get updated.

Fixes: 3f4aa9818163 ("afs: Fix EOF corruption")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 785bacb972da5..91b1f8cabd58f 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -219,6 +219,7 @@ static void afs_apply_status(struct afs_operation *op,
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
 		}
 		change_size = true;
+		data_changed = true;
 	} else if (vnode->status.type == AFS_FTYPE_DIR) {
 		/* Expected directory change is handled elsewhere so
 		 * that we can locally edit the directory and save on a
-- 
2.39.2



