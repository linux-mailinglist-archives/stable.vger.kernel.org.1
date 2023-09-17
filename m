Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A807A3769
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjIQTSy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbjIQTSY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:18:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2AD118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:18:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97908C433C7;
        Sun, 17 Sep 2023 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978298;
        bh=T7bAwj006nPfzkAo9W1AiCM3kJGQ65b5L3m8143bKJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5joIjODUCj6XfzDrW5uomPQ7DApisfG/2pYvrDwH9wSKXF0sn5IZYthvwkfQf1/E
         UKtIKJdvzwphG9VSzT876/DL8jVk6z23WdSxfwbbT3vrsJxw3SKxpxJqqizQ31Hae4
         IAVmmAPzFtZ5v8qDxza/tMSozUa7HKHZagWXhgT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Winston Wen <wentao@uniontech.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/406] fs/nls: make load_nls() take a const parameter
Date:   Sun, 17 Sep 2023 21:08:13 +0200
Message-ID: <20230917191102.180779901@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Winston Wen <wentao@uniontech.com>

[ Upstream commit c1ed39ec116272935528ca9b348b8ee79b0791da ]

load_nls() take a char * parameter, use it to find nls module in list or
construct the module name to load it.

This change make load_nls() take a const parameter, so we don't need do
some cast like this:

        ses->local_nls = load_nls((char *)ctx->local_nls->charset);

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nls/nls_base.c   | 4 ++--
 include/linux/nls.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e792..a026dbd3593f6 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -272,7 +272,7 @@ int unregister_nls(struct nls_table * nls)
 	return -EINVAL;
 }
 
-static struct nls_table *find_nls(char *charset)
+static struct nls_table *find_nls(const char *charset)
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
@@ -288,7 +288,7 @@ static struct nls_table *find_nls(char *charset)
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls(const char *charset)
 {
 	return try_then_request_module(find_nls(charset), "nls_%s", charset);
 }
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 499e486b3722d..e0bf8367b274a 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -47,7 +47,7 @@ enum utf16_endian {
 /* nls_base.c */
 extern int __register_nls(struct nls_table *, struct module *);
 extern int unregister_nls(struct nls_table *);
-extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls(const char *charset);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
-- 
2.40.1



