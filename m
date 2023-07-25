Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C07612CA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjGYLFi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjGYLFW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545D2720
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E774761654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0291FC433C8;
        Tue, 25 Jul 2023 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282991;
        bh=b5DAxg33cj2tHPTxN31GKwPM82ZUFVAQXamkAOWTxKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Veom/LloJvYld6b+7cYCNMnR9eWkxDJPRjt37RM5OHSHvrxZjjZuFFERv+C8he0p6
         o/Aa1wewa/Xb9MW8PeZKkE0UakvtsCgNmqVwXljgXGur59PuWXmXFlGQrihUQivif3
         GxLsxLvJhsCV4yN9Is3cEzR1zMdDmtfsC6sMNu6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Immad Mir <mirimmad17@gmail.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/183] [PATCH AUTOSEL 4.19 11/11] FS: JFS: Check for read-only mounted filesystem in txBegin
Date:   Tue, 25 Jul 2023 12:44:49 +0200
Message-ID: <20230725104510.160546344@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

[ Upstream commit 95e2b352c03b0a86c5717ba1d24ea20969abcacc ]

 This patch adds a check for read-only mounted filesystem
 in txBegin before starting a transaction potentially saving
 from NULL pointer deref.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_txnmgr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, in
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);


