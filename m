Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2B761639
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjGYLh2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjGYLh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7571B8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D222616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291A1C433C7;
        Tue, 25 Jul 2023 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285041;
        bh=Y0i3atlbK5EFYwVxusOXKUtvIlwno+3m+NO4fCogX+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXFLdWRSB4Y7GqR3NVd+HVE1jP5wDhWKXweJJXXr5hy+SVMIWxppBm1PyWeg6urLw
         Mxn4gM7QQz9WwqGUjX9vRzMUEJpiknmHs9aEAT+dp4auIfOlKgtBJ8XVIbWQ2I++Z0
         3tgagodX47sW4pUMP1Iky38nnWT6pLhwZAZ0qaR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 034/313] nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
Date:   Tue, 25 Jul 2023 12:43:07 +0200
Message-ID: <20230725104522.569126262@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0d9b41daa5907756a31772d8af8ac5ff25cf17c1 ]

If sock->service_name is NULL, the local variable
service_name_tlv_length will not be assigned by nfc_llcp_build_tlv(),
later leading to using value frmo the stack.  Smatch warning:

  net/nfc/llcp_commands.c:442 nfc_llcp_send_connect() error: uninitialized symbol 'service_name_tlv_length'.

Fixes: de9e5aeb4f40 ("NFC: llcp: Fix usage of llcp_add_tlv()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_commands.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 3c4172a5aeb5e..bb9f40563ff63 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -394,7 +394,8 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 	const u8 *service_name_tlv = NULL;
 	const u8 *miux_tlv = NULL;
 	const u8 *rw_tlv = NULL;
-	u8 service_name_tlv_length, miux_tlv_length,  rw_tlv_length, rw;
+	u8 service_name_tlv_length = 0;
+	u8 miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
-- 
2.39.2



