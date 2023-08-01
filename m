Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B176AF6B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjHAJrU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHAJqy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C71BF1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FBF614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36554C433C8;
        Tue,  1 Aug 2023 09:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883132;
        bh=mtw/MHBNl9ETuwSFHKTtVsS0iNwUBSK6kVq4OwBqROw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGk+NrhZo3lZOj3Wcdgtxmf8en6C8jzE6cm3RLKRJn3iO/3SvJG+8dJh1OTY1OnE/
         VOWuuMEobAJZ5xcRJwv9b9fjUzRhXoUV3FjUtkmyWErtfuaQiYBGLXG9cSuhW5I5M9
         XmXfbzOfaCpgsCUev8FtrVxIQTJKLIUjqxDxg44o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 098/239] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Date:   Tue,  1 Aug 2023 11:19:22 +0200
Message-ID: <20230801091929.261002571@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 95f41d87810083d8b3dedcce46a4e356cf4a9673 ]

The commit in Fixes has introduced some "enum p9_session_flags" values
larger than a char.
Such values are stored in "v9fs_session_info->flags" which is a char only.

Turn it into an int so that the "enum p9_session_flags" values can fit in
it.

Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/v9fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 06a2514f0d882..698c43dd5dc86 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -108,7 +108,7 @@ enum p9_cache_bits {
 
 struct v9fs_session_info {
 	/* options */
-	unsigned char flags;
+	unsigned int flags;
 	unsigned char nodev;
 	unsigned short debug;
 	unsigned int afid;
-- 
2.40.1



