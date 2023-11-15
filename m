Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EF7ECFFC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjKOTwG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjKOTwG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B71A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B9C433CA;
        Wed, 15 Nov 2023 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077922;
        bh=s2sEODsKRw2rNE/9jt535gTyKPfIU8YkT60hK3rCObY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfMqeWW53521NibbXPgd/h2ut5AFAn0bqkui5j/RQvQXn5SFyEo1xxlZp3Dlsz4/0
         gPRZhT/JRpoGtvbS6jtgFhoo+opeYgwZcsG+tjysWa040ac0R7RnZzYqFvneJuqHCx
         aMThV09sN1cGsUX550SnXTtzDVDXwcIYVAA/3bdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Milian Wolff <milian.wolff@kdab.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 595/603] eventfs: Check for NULL ef in eventfs_set_attr()
Date:   Wed, 15 Nov 2023 14:19:00 -0500
Message-ID: <20231115191652.318854666@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

The top level events directory dentry does not have a d_fsdata set to a
eventfs_file pointer. This dentry is still passed to eventfs_set_attr().
It can not assume that the d_fsdata is set. Check for that.

Link: https://lore.kernel.org/all/20231112104158.6638-1-milian.wolff@kdab.com/

Fixes: 9aaee3eebc91 ("eventfs: Save ownership and mode")
Reported-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5fcfb634fec26..efbdc47c74dcf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -113,14 +113,14 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	mutex_lock(&eventfs_mutex);
 	ef = dentry->d_fsdata;
-	if (ef->is_freed) {
+	if (ef && ef->is_freed) {
 		/* Do not allow changes if the event is about to be removed. */
 		mutex_unlock(&eventfs_mutex);
 		return -ENODEV;
 	}
 
 	ret = simple_setattr(idmap, dentry, iattr);
-	if (!ret)
+	if (!ret && ef)
 		update_attr(ef, iattr);
 	mutex_unlock(&eventfs_mutex);
 	return ret;
-- 
2.42.0



