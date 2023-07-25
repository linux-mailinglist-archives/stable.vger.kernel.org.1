Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DC761729
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGYLpe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGYLpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D52A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56479616A3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647B0C433C8;
        Tue, 25 Jul 2023 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285531;
        bh=Ts5CTHouB7nMG/VBtow7XPerY1s7TERH2nhdJdwbnBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQozVrijDNff0nLEVw3TTDITTfoU4gGRvba1mk/tiWBoqRuaN8U7u2xvwwnVRGAvQ
         F5ivuxm+ntZyORkMorEBSIi6jZAN5a0Mug8zHZWpnoqZYybw77wZsDuP2tJoAXpMVr
         Dwc3Onb2PMplA5On5MLgT1WF2BtpsgyASUc59hZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Chao Yu <chao@kernel.org>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.4 238/313] ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
Date:   Tue, 25 Jul 2023 12:46:31 +0200
Message-ID: <20230725104531.352489233@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream.

freeze_bdev() can fail due to a lot of reasons, it needs to check its
reason before later process.

Fixes: 783d94854499 ("ext4: add EXT4_IOC_GOINGDOWN ioctl")
Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230606073203.1310389-1-chao@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ioctl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -573,6 +573,7 @@ static int ext4_shutdown(struct super_bl
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -591,7 +592,9 @@ static int ext4_shutdown(struct super_bl
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
+			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev, sb);
 		break;


