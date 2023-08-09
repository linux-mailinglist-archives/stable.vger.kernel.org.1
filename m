Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA0775AB2
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjHILKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjHILKt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A511724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523FB6245A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624AAC433C7;
        Wed,  9 Aug 2023 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579447;
        bh=EQ4ZQNWXbrWOvn9E46s0iU/rYrE5RbLdcOQhsusyyiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkB/askh2YI0HEQcUtq5HP4+0BqSpkCezYqrD5Lg9U7S4deeT1vAbRJjyo0yoHiKj
         R7TTEw9nZuEgjRgVhItxQY48c8S4LyVGSof9Wv1MRnB2AUOPn98UFqwr9mCjqmW0Ew
         pfdSncqnzIP4MvSUoge+9pwNhbkSGFD6rLitngIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com,
        Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 4.14 199/204] fs/sysv: Null check to prevent null-ptr-deref bug
Date:   Wed,  9 Aug 2023 12:42:17 +0200
Message-ID: <20230809103649.158452680@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
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


