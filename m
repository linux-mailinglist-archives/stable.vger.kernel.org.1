Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8FE75D2B5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGUTCp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGUTCo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBF30D6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789D661D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87498C433C9;
        Fri, 21 Jul 2023 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966162;
        bh=Vc9o19SWtuh+ZGGKKQl+YblqasSQVRXqqIuTRvCcRso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bhxv+hBdJsz5ec/S5VwM5ReP3A9ZYsxTKRmYo5aHjq2x3z5qeqmgzWOSGL9AuQ6uy
         cxyWgcLlDBnIQ4Z6V37ogIyj01HTDffIP98GBTGSjrW8B5R76D9E+t5gkJmNC/Dy0L
         k3+nfQYxqyAKVFwg88CZYmgbZWd35DHoEov22gxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 246/532] ksmbd: avoid field overflow warning
Date:   Fri, 21 Jul 2023 18:02:30 +0200
Message-ID: <20230721160627.699514723@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index f034b75c6d7f4..af583e4266215 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -423,7 +423,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 	out[baselen + 3] = PERIOD;
 
 	if (dot_present)
-		memcpy(&out[baselen + 4], extension, 4);
+		memcpy(out + baselen + 4, extension, 4);
 	else
 		out[baselen + 4] = '\0';
 	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
-- 
2.39.2



