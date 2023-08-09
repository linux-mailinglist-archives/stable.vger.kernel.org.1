Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79247775ADB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjHILMQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHILMQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F81FCE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA33962347
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19DDC433C8;
        Wed,  9 Aug 2023 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579535;
        bh=hGX1m5NzUpiY7KPmtMCQuxWJ61gXsuJdiLbzPlQz+5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQhjiKJsbzLIQnED1wH6CSGjPJviYueEjVvMzhlbld95g4fhI+n9/NOozw0k5CQhA
         BkWgX0OISgsBIDI6RmnylWXmb/69f4yO4Py73mL8ldkTaqF4t6zm4WQa+JpsbLEsM1
         Tl4aJCMyElxBdlyaIEfXhpODNRqpql5neZ2d6j6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/323] nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
Date:   Wed,  9 Aug 2023 12:37:44 +0200
Message-ID: <20230809103659.315499352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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
index 6dcad7bcf20bb..737c7aa384f44 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -406,7 +406,8 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
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



