Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8800C79B092
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376627AbjIKWUG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbjIKOxX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:53:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDD118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:53:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C88C433C7;
        Mon, 11 Sep 2023 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443998;
        bh=avq1F+9iYeNxlkMp1peMBnpxkyhXukQnDuSxvAnaeiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0b9g/+SCuE1ni3EB7w8R/XkYWhAidyehy7MdKcflFTr7lpvmPsLzTeWfs1VCFSXqE
         GHnN+J/eErn9dWbyBvLlf7GPAPPFXTrs4l7mlSoJQPUlzOhLtGW8eI4uIZf7GneAb4
         Ox+O+GluANU+JSbNClqrsS9wS12quFKHF9t49IHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Yangtao Li <frank.li@vivo.com>,
        Konstantin Vyshetsky <vkon@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 574/737] f2fs: fix spelling in ABI documentation
Date:   Mon, 11 Sep 2023 15:47:13 +0200
Message-ID: <20230911134706.571140893@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c709d099a0d2befa2b16c249ef8df722b43e6c28 ]

Correct spelling problems as identified by codespell.

Fixes: 9e615dbba41e ("f2fs: add missing description for ipu_policy node")
Fixes: b2e4a2b300e5 ("f2fs: expose discard related parameters in sysfs")
Fixes: 846ae671ad36 ("f2fs: expose extension_list sysfs entry")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: Yangtao Li <frank.li@vivo.com>
Cc: Konstantin Vyshetsky <vkon@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 8140fc98f5aee..ad3d76d37c8ba 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -54,9 +54,9 @@ Description:	Controls the in-place-update policy.
 		0x00  DISABLE         disable IPU(=default option in LFS mode)
 		0x01  FORCE           all the time
 		0x02  SSR             if SSR mode is activated
-		0x04  UTIL            if FS utilization is over threashold
+		0x04  UTIL            if FS utilization is over threshold
 		0x08  SSR_UTIL        if SSR mode is activated and FS utilization is over
-		                      threashold
+		                      threshold
 		0x10  FSYNC           activated in fsync path only for high performance
 		                      flash storages. IPU will be triggered only if the
 		                      # of dirty pages over min_fsync_blocks.
@@ -117,7 +117,7 @@ Date:		December 2021
 Contact:	"Konstantin Vyshetsky" <vkon@google.com>
 Description:	Controls the number of discards a thread will issue at a time.
 		Higher number will allow the discard thread to finish its work
-		faster, at the cost of higher latency for incomming I/O.
+		faster, at the cost of higher latency for incoming I/O.
 
 What:		/sys/fs/f2fs/<disk>/min_discard_issue_time
 Date:		December 2021
@@ -334,7 +334,7 @@ Description:	This indicates how many GC can be failed for the pinned
 		state. 2048 trials is set by default.
 
 What:		/sys/fs/f2fs/<disk>/extension_list
-Date:		Feburary 2018
+Date:		February 2018
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Used to control configure extension list:
 		- Query: cat /sys/fs/f2fs/<disk>/extension_list
-- 
2.40.1



