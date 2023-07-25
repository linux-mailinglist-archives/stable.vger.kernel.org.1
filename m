Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE37615AE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjGYLcA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjGYLb7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA6318F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E4E06168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03A3C433C7;
        Tue, 25 Jul 2023 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284710;
        bh=iFyQ9zPw9eALoLN9Y0D0phQq7AIeEoAGSzwYsaC0vZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBy7cBxWLRiD3Xui/uwCHBSs2nmDM8ntKK9cfsAMrHWrWZSpO8XnnOO9e/WgIOyY3
         /MlUFmSB0tii16jq/AObIHHi9X3ilrS5wVkSiieuDQqfXSmHtK9zsXZ94GPOVquxDI
         qfpbbYDcKzs08ArBKpJLnuNPp4JffYIi0DjSC+KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Eric Whitney <enwlinux@gmail.com>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.10 454/509] ext4: correct inline offset when handling xattrs in inode body
Date:   Tue, 25 Jul 2023 12:46:33 +0200
Message-ID: <20230725104614.516589198@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Eric Whitney <enwlinux@gmail.com>

commit 6909cf5c4101214f4305a62d582a5b93c7e1eb9a upstream.

When run on a file system where the inline_data feature has been
enabled, xfstests generic/269, generic/270, and generic/476 cause ext4
to emit error messages indicating that inline directory entries are
corrupted.  This occurs because the inline offset used to locate
inline directory entries in the inode body is not updated when an
xattr in that shared region is deleted and the region is shifted in
memory to recover the space it occupied.  If the deleted xattr precedes
the system.data attribute, which points to the inline directory entries,
that attribute will be moved further up in the region.  The inline
offset continues to point to whatever is located in system.data's former
location, with unfortunate effects when used to access directory entries
or (presumably) inline data in the inode body.

Cc: stable@kernel.org
Signed-off-by: Eric Whitney <enwlinux@gmail.com>
Link: https://lore.kernel.org/r/20230522181520.1570360-1-enwlinux@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1725,6 +1725,20 @@ static int ext4_xattr_set_entry(struct e
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);


