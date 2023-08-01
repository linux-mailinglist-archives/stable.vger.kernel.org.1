Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C666976AF71
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjHAJrd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjHAJrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D6269A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67709614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EF7C433C7;
        Tue,  1 Aug 2023 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883143;
        bh=rrhgRIRVtRSDOtXfH4MAY1t2sEX3vUNAY620I4DKhok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jty8C89ntB8vW+Pjxv3bJO/XRuojN8e6sh9aPtgYrfMH9SVH0VFiHqUgHsZUqGsa2
         7UZDVQiPzmATKYrPf7uIX489KYOSh7sQeBPArBZvxbvhXJPty1cvn/+Q4IrgmNLtML
         fHkhyH9dSjuvlnoI9q2gF2aKYd46Tq3dr/vDN8Fg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roy Shterman <roy.shterman@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 123/239] smb3: do not set NTLMSSP_VERSION flag for negotiate not auth request
Date:   Tue,  1 Aug 2023 11:19:47 +0200
Message-ID: <20230801091930.153827706@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 19826558210b9102a7d4681c91784d137d60d71b ]

The NTLMSSP_NEGOTIATE_VERSION flag only needs to be sent during
the NTLMSSP NEGOTIATE (not the AUTH) request, so filter it out for
NTLMSSP AUTH requests. See MS-NLMP 2.2.1.3

This fixes a problem found by the gssntlmssp server.

Link: https://github.com/gssapi/gss-ntlmssp/issues/95
Fixes: 52d005337b2c ("smb3: send NTLMSSP version information")
Acked-by: Roy Shterman <roy.shterman@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 335c078c42fb5..c57ca2050b73f 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -1013,6 +1013,7 @@ int build_ntlmssp_smb3_negotiate_blob(unsigned char **pbuffer,
 }
 
 
+/* See MS-NLMP 2.2.1.3 */
 int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 					u16 *buflen,
 				   struct cifs_ses *ses,
@@ -1047,7 +1048,8 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 
 	flags = ses->ntlmssp->server_flags | NTLMSSP_REQUEST_TARGET |
 		NTLMSSP_NEGOTIATE_TARGET_INFO | NTLMSSP_NEGOTIATE_WORKSTATION_SUPPLIED;
-
+	/* we only send version information in ntlmssp negotiate, so do not set this flag */
+	flags = flags & ~NTLMSSP_NEGOTIATE_VERSION;
 	tmp = *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
 
-- 
2.40.1



