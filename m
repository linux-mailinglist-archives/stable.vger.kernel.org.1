Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22F975566B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGPUuY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUuX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5DD9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D05460EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD16C433C7;
        Sun, 16 Jul 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540621;
        bh=gxRU+XbTMe25NumbdsumMQe9y4HI47rSAwJ5Yk3+wx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVi90SzzLiZ3OG+Fk3BMQTPqAajn/rR9S1LBhCeBWwFEbe3xY+66G4A8OatQbpS2A
         UeiXE0msjH580fFuwsEUakaW0YKiMLa44xOaUMdqOHLSdiQhaeksP37DzZag289vJJ
         VLYeeVa5J7obQg80wuUmTzaX3SvVfTF0JgUzWV0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 428/591] gfs2: Fix duplicate should_fault_in_pages() call
Date:   Sun, 16 Jul 2023 21:49:27 +0200
Message-ID: <20230716194934.990579025@linuxfoundation.org>
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

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit c8ed1b35931245087968fd95b2ec3dfc50f77769 ]

In gfs2_file_buffered_write(), we currently jump from the second call of
function should_fault_in_pages() to above the first call, so
should_fault_in_pages() is getting called twice in a row, causing it to
accidentally fall back to single-page writes rather than trying the more
efficient multi-page writes first.

Fix that by moving the retry label to the correct place, behind the
first call to should_fault_in_pages().

Fixes: e1fa9ea85ce8 ("gfs2: Stop using glock holder auto-demotion for now")
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index bc6cd5f4b1077..c367f1678d5dc 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1029,8 +1029,8 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	}
 
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, gh);
-retry:
 	if (should_fault_in_pages(from, iocb, &prev_count, &window_size)) {
+retry:
 		window_size -= fault_in_iov_iter_readable(from, window_size);
 		if (!window_size) {
 			ret = -EFAULT;
-- 
2.39.2



