Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0075D3A6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGUTND (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGUTNC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01FC30FF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 446EF61D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547BCC433CB;
        Fri, 21 Jul 2023 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966778;
        bh=P+vWxZRY23U1jjum0DwHhFXy3i0b/+DY8N4vpyBPdAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNwRk9KSTBMOKvfcSqS+AXoDMx6GBX5Gopv0CX8V3fhZyuLz6QbfgzbvU9TyLMMAP
         0499eTvdtCZc0Ye6UGAEKDfddo1VgYTpmRwei0M1ssghvVptFEqqJKrrrYWXDtm4+w
         NxZ/RFzUmWvsxH4EvqH6vJf8HfhACn0bN3P5RaaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kemeng Shi <shikemeng@huaweicloud.com>,
        stable@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 464/532] ext4: fix wrong unit use in ext4_mb_new_blocks
Date:   Fri, 21 Jul 2023 18:06:08 +0200
Message-ID: <20230721160639.706918582@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kemeng Shi <shikemeng@huaweicloud.com>

commit 2ec6d0a5ea72689a79e6f725fd8b443a788ae279 upstream.

Function ext4_free_blocks_simple needs count in cluster. Function
ext4_free_blocks accepts count in block. Convert count to cluster
to fix the mismatch.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: stable@kernel.org
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://lore.kernel.org/r/20230603150327.3596033-12-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mballoc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6179,7 +6179,7 @@ void ext4_free_blocks(handle_t *handle,
 	}
 
 	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
+		ext4_free_blocks_simple(inode, block, EXT4_NUM_B2C(sbi, count));
 		return;
 	}
 


