Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF96FAA14
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjEHK6x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjEHK6h (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513133FC7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB63629E9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641B2C433D2;
        Mon,  8 May 2023 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543442;
        bh=gZ+bRMauUXwl5no0RP9+NqdPeV2jwAvkv3NtuIAfj0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAm8asRCDhClbi1FuOOgcIH9zgaiSIObGL6OCrZD1fyDfnB6LFHwkBWe96bx43vkB
         HMB9+YpJQcAJqpp3wTVIUlS8YmnSpRoFd54n0MJTGsSrjxkmJaJ1ysEsm+DSRLiTtc
         UfqnnadSaYo3NeXMKSK2i3AXyeGYVglf9kuNsAoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6.3 092/694] xfs: dont consider future format versions valid
Date:   Mon,  8 May 2023 11:38:47 +0200
Message-Id: <20230508094435.514035483@linuxfoundation.org>
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

From: Dave Chinner <dchinner@redhat.com>

commit aa88019851a85df80cb77f143758b13aee09e3d9 upstream.

In commit fe08cc504448 we reworked the valid superblock version
checks. If it is a V5 filesystem, it is always valid, then we
checked if the version was less than V4 (reject) and then checked
feature fields in the V4 flags to determine if it was valid.

What we missed was that if the version is not V4 at this point,
we shoudl reject the fs. i.e. the check current treats V6+
filesystems as if it was a v4 filesystem. Fix this.

cc: stable@vger.kernel.org
Fixes: fe08cc504448 ("xfs: open code sb verifier feature checks")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_sb.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -72,7 +72,8 @@ xfs_sb_validate_v5_features(
 }
 
 /*
- * We support all XFS versions newer than a v4 superblock with V2 directories.
+ * We current support XFS v5 formats with known features and v4 superblocks with
+ * at least V2 directories.
  */
 bool
 xfs_sb_good_version(
@@ -86,16 +87,16 @@ xfs_sb_good_version(
 	if (xfs_sb_is_v5(sbp))
 		return xfs_sb_validate_v5_features(sbp);
 
+	/* versions prior to v4 are not supported */
+	if (XFS_SB_VERSION_NUM(sbp) != XFS_SB_VERSION_4)
+		return false;
+
 	/* We must not have any unknown v4 feature bits set */
 	if ((sbp->sb_versionnum & ~XFS_SB_VERSION_OKBITS) ||
 	    ((sbp->sb_versionnum & XFS_SB_VERSION_MOREBITSBIT) &&
 	     (sbp->sb_features2 & ~XFS_SB_VERSION2_OKBITS)))
 		return false;
 
-	/* versions prior to v4 are not supported */
-	if (XFS_SB_VERSION_NUM(sbp) < XFS_SB_VERSION_4)
-		return false;
-
 	/* V4 filesystems need v2 directories and unwritten extents */
 	if (!(sbp->sb_versionnum & XFS_SB_VERSION_DIRV2BIT))
 		return false;


