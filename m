Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD057615F3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjGYLey (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjGYLex (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F2F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16F961655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11D6C433C8;
        Tue, 25 Jul 2023 11:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284891;
        bh=QUZG9pvKYxPF15Wjs+bE7eiD5ySu8FbVB00bWZJZkz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDF2mQ4xC8DkZoDejwINJF2CuIE1EQiL7lW5p+WJ/eZMBgqdsE4kSky8e0DHEzJro
         W2iE6jAmhwj2egNDeKxYcMu9sNB1j1tbyHvvL+PRlvW/n7lPb8UBxFPaoYPcR2uKw4
         jg7NvNBJKzSEvMNsl1rjU9yG6+w7CNFpH9ZgydC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Lan <lanyang0908@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dragos-Marian Panait <dragos.panait@windriver.com>
Subject: [PATCH 5.4 001/313] gfs2: Dont deref jdesc in evict
Date:   Tue, 25 Jul 2023 12:42:34 +0200
Message-ID: <20230725104521.239037265@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636 upstream.

On corrupt gfs2 file systems the evict code can try to reference the
journal descriptor structure, jdesc, after it has been freed and set to
NULL. The sequence of events is:

init_journal()
...
fail_jindex:
   gfs2_jindex_free(sdp); <------frees journals, sets jdesc = NULL
      if (gfs2_holder_initialized(&ji_gh))
         gfs2_glock_dq_uninit(&ji_gh);
fail:
   iput(sdp->sd_jindex); <--references jdesc in evict_linked_inode
      evict()
         gfs2_evict_inode()
            evict_linked_inode()
               ret = gfs2_trans_begin(sdp, 0, sdp->sd_jdesc->jd_blocks);
<------references the now freed/zeroed sd_jdesc pointer.

The call to gfs2_trans_begin is done because the truncate_inode_pages
call can cause gfs2 events that require a transaction, such as removing
journaled data (jdata) blocks from the journal.

This patch fixes the problem by adding a check for sdp->sd_jdesc to
function gfs2_evict_inode. In theory, this should only happen to corrupt
gfs2 file systems, when gfs2 detects the problem, reports it, then tries
to evict all the system inodes it has read in up to that point.

Reported-by: Yang Lan <lanyang0908@gmail.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[DP: adjusted context]
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/super.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1258,6 +1258,14 @@ static void gfs2_evict_inode(struct inod
 	if (inode->i_nlink || sb_rdonly(sb))
 		goto out;
 
+	/*
+	 * In case of an incomplete mount, gfs2_evict_inode() may be called for
+	 * system files without having an active journal to write to.  In that
+	 * case, skip the filesystem evict.
+	 */
+	if (!sdp->sd_jdesc)
+		goto out;
+
 	if (test_bit(GIF_ALLOC_FAILED, &ip->i_flags)) {
 		BUG_ON(!gfs2_glock_is_locked_by_me(ip->i_gl));
 		gfs2_holder_mark_uninitialized(&gh);


