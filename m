Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C26FAD3C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjEHLcp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjEHLcZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259340213
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A374E63069
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61A3C433EF;
        Mon,  8 May 2023 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545493;
        bh=gZ+bRMauUXwl5no0RP9+NqdPeV2jwAvkv3NtuIAfj0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgkgPU7W5kqUfLQu8i7FblqeUnvbhersyMwAqOUJJS5iF18to22DBMAur/kv/remP
         jQCsA4ZQiBfGrrWJpzbvSbNq20GJDJ9DxY8UBqxDaNg70X6KOtvS/hF+frnjMYy8OF
         RKoMPir9M+rHrdDqzxvNxCWPf3QOpM8xghavT3n8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5.15 057/371] xfs: dont consider future format versions valid
Date:   Mon,  8 May 2023 11:44:18 +0200
Message-Id: <20230508094814.339263330@linuxfoundation.org>
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


