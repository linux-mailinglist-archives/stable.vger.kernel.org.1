Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C074C3D3
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGILgq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGILgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CED95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AABB60BC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27998C433C8;
        Sun,  9 Jul 2023 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902603;
        bh=BzvCo3HWBqSaVJKjGJ9j8VwdWk1qEnpVy9z/SWChluY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDloSBtOyl82CYs2zRZVOzQCnitxPiDLjXGiYr+38hkpjg07dAr06ESDlIt2HToWm
         5ztk+tzMB0pAbS3EfjV+8s7g7H5gLP872OuF0a+QAndf5+M1uCfYDqX8SGKVR/DQHs
         LCqiuawtLoOimDLvrD+swYbd0QSL2i2OEGFN1K5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 428/431] ksmbd: avoid field overflow warning
Date:   Sun,  9 Jul 2023 13:16:16 +0200
Message-ID: <20230709111501.223948773@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9cedc58bdbe9fff9aacd0ca19ee5777659f28fd7 ]

clang warns about a possible field overflow in a memcpy:

In file included from fs/smb/server/smb_common.c:7:
include/linux/fortify-string.h:583:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __write_overflow_field(p_size_field, size);

It appears to interpret the "&out[baselen + 4]" as referring to a single
byte of the character array, while the equivalen "out + baselen + 4" is
seen as an offset into the array.

I don't see that kind of warning elsewhere, so just go with the simple
rework.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 569e5eecdf3db..3e391a7d5a3ab 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -536,7 +536,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 	out[baselen + 3] = PERIOD;
 
 	if (dot_present)
-		memcpy(&out[baselen + 4], extension, 4);
+		memcpy(out + baselen + 4, extension, 4);
 	else
 		out[baselen + 4] = '\0';
 	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
-- 
2.39.2



