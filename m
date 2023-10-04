Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8947B8A7C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbjJDSgD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244441AbjJDSgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA229C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA0C433C8;
        Wed,  4 Oct 2023 18:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444557;
        bh=gk5Oz1ODp6hAFbHacPpLpkxkSBPtJ2uyS7V4Et/Uaus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpQ6XfZg9F22/Ob4Gl0CxThO6Xs/b4rXOiQqFi5KRkNYTI/jAHICWDE0TqjF6PSfF
         hpMA0xHETfMX34eYH7hJReNSMPtGlbfTxeXN+0W4TbFD6F3I3wOIvK9Zp/yqwAVsZe
         JDw79x5JAq5z+VduZjt8uIpX85nfJtYlnol1igIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.5 292/321] btrfs: set last dir index to the current last index when opening dir
Date:   Wed,  4 Oct 2023 19:57:17 +0200
Message-ID: <20231004175242.811533902@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 357950361cbc6d54fb68ed878265c647384684ae upstream.

When opening a directory for reading it, we set the last index where we
stop iteration to the value in struct btrfs_inode::index_cnt. That value
does not match the index of the most recently added directory entry but
it's instead the index number that will be assigned the next directory
entry.

This means that if after the call to opendir(3) new directory entries are
added, a readdir(3) call will return the first new directory entry. This
is fine because POSIX says the following [1]:

  "If a file is removed from or added to the directory after the most
   recent call to opendir() or rewinddir(), whether a subsequent call to
   readdir() returns an entry for that file is unspecified."

For example for the test script from commit 9b378f6ad48c ("btrfs: fix
infinite directory reads"), where we have 2000 files in a directory, ext4
doesn't return any new directory entry after opendir(3), while xfs returns
the first 13 new directory entries added after the opendir(3) call.

If we move to a shorter example with an empty directory when opendir(3) is
called, and 2 files added to the directory after the opendir(3) call, then
readdir(3) on btrfs will return the first file, ext4 and xfs return the 2
files (but in a different order). A test program for this, reported by
Ian Johnson, is the following:

   #include <dirent.h>
   #include <stdio.h>

   int main(void) {
     DIR *dir = opendir("test");

     FILE *file;
     file = fopen("test/1", "w");
     fwrite("1", 1, 1, file);
     fclose(file);

     file = fopen("test/2", "w");
     fwrite("2", 1, 1, file);
     fclose(file);

     struct dirent *entry;
     while ((entry = readdir(dir))) {
        printf("%s\n", entry->d_name);
     }
     closedir(dir);
     return 0;
   }

To make this less odd, change the behaviour to never return new entries
that were added after the opendir(3) call. This is done by setting the
last_index field of the struct btrfs_file_private attached to the
directory's file handle with a value matching btrfs_inode::index_cnt
minus 1, since that value always matches the index of the next new
directory entry and not the index of the most recently added entry.

[1] https://pubs.opengroup.org/onlinepubs/007904875/functions/readdir_r.html

Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/
CC: stable@vger.kernel.org # 6.5+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5942,7 +5942,8 @@ static int btrfs_get_dir_last_index(stru
 		}
 	}
 
-	*index = dir->index_cnt;
+	/* index_cnt is the index number of next new entry, so decrement it. */
+	*index = dir->index_cnt - 1;
 
 	return 0;
 }


