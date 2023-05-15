Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1771370350C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjEOQzR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbjEOQy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8426EA6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA0B629BF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D210C433EF;
        Mon, 15 May 2023 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169685;
        bh=a52zrwDBx/yFl//l8hqYrIDIjGhWl1TWQchmfB2dWnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8XQFWwBd1g7CCsJk8PenX7Te7rf+6HWmdoBGYrzkPdQw5XyQ1DBwxgejyGj4hq1i
         2LVtvXPo5Upn07sAWzn16ou923XDmR4hDvj6TRcGboTP8cQzq9omBgpM3wjEm7Q93L
         o6j/LntmGEjoebZ1nGq0em9uT4vD+TsTJBsSNGx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 137/246] btrfs: zoned: zone finish data relocation BG with last IO
Date:   Mon, 15 May 2023 18:25:49 +0200
Message-Id: <20230515161726.675809164@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Naohiro Aota <Naohiro.Aota@wdc.com>

commit f84353c7c20536ea7e01eca79430eccdf3cc7348 upstream.

For data block groups, we zone finish a zone (or, just deactivate it) when
seeing the last IO in btrfs_finish_ordered_io(). That is only called for
IOs using ZONE_APPEND, but we use a regular WRITE command for data
relocation IOs. Detect it and call btrfs_zone_finish_endio() properly.

Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3167,6 +3167,9 @@ int btrfs_finish_ordered_io(struct btrfs
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
+	} else if (btrfs_is_data_reloc_root(inode->root)) {
+		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+					ordered_extent->disk_num_bytes);
 	}
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {


