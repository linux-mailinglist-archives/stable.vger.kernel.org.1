Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBA6FACC2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjEHL2E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjEHL1j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042E30AEB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA16562D14
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBFBC433EF;
        Mon,  8 May 2023 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545243;
        bh=mG7MorSJYrplD1lXuqZTVjBU4ZbXsIYrvjD+JABBHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoOdO5vJ+tMq0ddZiL1zpCp1+o1dgFcUxba6i8urgCQDXca7t/aWeS2j72CNOvAYK
         raG94jhr0nElxDaCVNZI/oJw83dZIbhhBc19Z6n7sFnSYlFXfCcXSEFu4sOaUYaJR2
         IFLs7JS4Y7aYQbnQ5zqsg8lAGUaTBAt72OOuUqU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 671/694] afs: Avoid endless loop if file is larger than expected
Date:   Mon,  8 May 2023 11:48:26 +0200
Message-Id: <20230508094457.927978645@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit 9ea4eff4b6f4f36546d537a74da44fd3f30903ab ]

afs_read_dir fetches an amount of data that's based on what the inode
size is thought to be.  If the file on the server is larger than what
was fetched, the code rechecks i_size and retries.  If the local i_size
was not properly updated, this can lead to an endless loop of fetching
i_size from the server and noticing each time that the size is larger on
the server.

If it is known that the remote size is larger than i_size, bump up the
fetch size to that size.

Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 82690d1dd49a0..a97499fd747b6 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -275,6 +275,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	loff_t i_size;
 	int nr_pages, i;
 	int ret;
+	loff_t remote_size = 0;
 
 	_enter("");
 
@@ -289,6 +290,8 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 expand:
 	i_size = i_size_read(&dvnode->netfs.inode);
+	if (i_size < remote_size)
+	    i_size = remote_size;
 	if (i_size < 2048) {
 		ret = afs_bad(dvnode, afs_file_error_dir_small);
 		goto error;
@@ -364,6 +367,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 			 * buffer.
 			 */
 			up_write(&dvnode->validate_lock);
+			remote_size = req->file_size;
 			goto expand;
 		}
 
-- 
2.39.2



