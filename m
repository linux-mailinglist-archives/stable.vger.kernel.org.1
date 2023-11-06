Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546047E23F1
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjKFNQb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjKFNQ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA194
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CCEC433C9;
        Mon,  6 Nov 2023 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276583;
        bh=HuVZM4kqqtRb3g7w+n5fLVtZl3RGPA3MaO0oz3FgH54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm8oQzSj10Hx5ZhVV2CRdtfF7kktC7ut3FsjwDCfaxSWLpzGzFR2kLU4G/epvJeR3
         ZALCfYHgQpm3XSZDWcCB85HWU5AWT29SkfN3ztam2IEjyHZQpZ0+9iAkPBBuy0ZQDt
         bi/RM4ig8+UnpIaqNVEFM9lYY0Cjb1Db4hqEI4aM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Su Hui <suhui@nfschina.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 29/88] fs/ntfs3: Avoid possible memory leak
Date:   Mon,  6 Nov 2023 14:03:23 +0100
Message-ID: <20231106130306.858524574@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit e4494770a5cad3c9d1d2a65ed15d07656c0d9b82 ]

smatch warn:
fs/ntfs3/fslog.c:2172 last_log_lsn() warn: possible memory leak of 'page_bufs'
Jump to label 'out' to free 'page_bufs' and is more consistent with
other code.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 12f28cdf5c838..98ccb66508583 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2168,8 +2168,10 @@ static int last_log_lsn(struct ntfs_log *log)
 
 			if (!page) {
 				page = kmalloc(log->page_size, GFP_NOFS);
-				if (!page)
-					return -ENOMEM;
+				if (!page) {
+					err = -ENOMEM;
+					goto out;
+				}
 			}
 
 			/*
-- 
2.42.0



