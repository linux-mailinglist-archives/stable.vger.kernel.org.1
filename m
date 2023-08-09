Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E3775976
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjHILAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjHILAl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3CED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7010362496
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C49C433C9;
        Wed,  9 Aug 2023 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578839;
        bh=EQ4ZQNWXbrWOvn9E46s0iU/rYrE5RbLdcOQhsusyyiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DH8I41O5U97Btna1xGUwIgJ4I2zy6mzzTBXVY4j2i1y6o0/dRV8b5LE5/yU58bgjW
         VUf7GojX/0e2P184VIK4L/6BKPWv3Gopx4V2ksKZRhfxjE8ISFCYjgujfXr65yBHcg
         D+gYAZxjJ8Njfb344gwDu07/KndMCOuxhfwaEypE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com,
        Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 75/92] fs/sysv: Null check to prevent null-ptr-deref bug
Date:   Wed,  9 Aug 2023 12:41:51 +0200
Message-ID: <20230809103636.152222934@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Prince Kumar Maurya <princekumarmaurya06@gmail.com>

commit ea2b62f305893992156a798f665847e0663c9f41 upstream.

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
that leads to the null-ptr-deref bug.

Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc
Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Message-Id: <20230531013141.19487-1-princekumarmaurya06@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysv/itree.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,10 @@ static int alloc_branch(struct inode *in
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			sysv_free_block(inode->i_sb, branch[n].key);
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;


