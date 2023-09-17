Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D367A396E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbjIQTtW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbjIQTtD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:49:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C539F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:48:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF08BC433C9;
        Sun, 17 Sep 2023 19:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980138;
        bh=mfJIOIaTYeZADi+9UgeSH0ZfbxVKQiqN4GJNAd1eY5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYdB3pZxw++YmLJkceqjOtVOn3SOOEP6NBguBNLqSfVf+9u80rqUH94Ono+WEojZT
         x48q3LL+j55AnEqOvDuUFmJkBF4Ob0JTP2aBAI/wbb1SUOn7JUxyjR/Ju0za2MjAM4
         cdNnzp4a6Ray9u4cUfVIsYlw0Ffhnl0jsdp78HT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Katya Orlova <e.orlova@ispras.ru>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 106/285] smb: propagate error code of extract_sharename()
Date:   Sun, 17 Sep 2023 21:11:46 +0200
Message-ID: <20230917191055.336253103@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Katya Orlova <e.orlova@ispras.ru>

[ Upstream commit efc0b0bcffcba60d9c6301063d25a22a4744b499 ]

In addition to the EINVAL, there may be an ENOMEM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index 8f6909d633da8..34e20c4cd507f 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -48,7 +48,7 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 	sharename = extract_sharename(tcon->tree_name);
 	if (IS_ERR(sharename)) {
 		cifs_dbg(FYI, "%s: couldn't extract sharename\n", __func__);
-		return -EINVAL;
+		return PTR_ERR(sharename);
 	}
 
 	slen = strlen(sharename);
-- 
2.40.1



