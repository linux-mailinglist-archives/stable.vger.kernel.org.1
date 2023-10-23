Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD697D30A4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWLAv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjJWLAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:00:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D0D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:00:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0969AC433C7;
        Mon, 23 Oct 2023 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698058845;
        bh=YzxQelXUieAMqEM5CtJd9yHw+da2NIbXhsBrk7DA9Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKuskptrZaE4UbX3qT8e2IJnFpgKYmxSimq0nLOGN8tW5OOtz5IwbFW8PZpfUVVVS
         6J9eGerJ81wf3TwWUOhKgtCFhSqRZ4oKsQUMuF8l7yBV7ghnhAG7gUgK+li4wsAURx
         UouKCPbzys2IIkO+BLQ6/tik9kHeMUJrsHCRvwZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 45/66] overlayfs: set ctime when setting mtime and atime
Date:   Mon, 23 Oct 2023 12:56:35 +0200
Message-ID: <20231023104812.513500600@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 03dbab3bba5f009d053635c729d1244f2c8bad38 ]

Nathan reported that he was seeing the new warning in
setattr_copy_mgtime pop when starting podman containers. Overlayfs is
trying to set the atime and mtime via notify_change without also
setting the ctime.

POSIX states that when the atime and mtime are updated via utimes() that
we must also update the ctime to the current time. The situation with
overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
notify_change will fill in the value.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f3ed80e2966c3..4a5b0f3c6af34 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -201,7 +201,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};
-- 
2.40.1



