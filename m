Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2BC7615C8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjGYLdX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjGYLdF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC4118
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D5761655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A84C433C7;
        Tue, 25 Jul 2023 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284782;
        bh=0N68d4JnT5B8Op9uwnKe29sW88UEYLqOy2m4Iopa6sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G6tdg4L2HEjyA0OwI+zDxNVCXINMe4CLuG3zTnf+K753pjJQisQEN57rb8We87idX
         vdlM9+KTQ+Q+lHPIPZrNl84wmnXBsnjB0xZ9b130Y5YyUGvd/+pM7OqI3M1PGqandV
         m7vBcEKN4Q2QUB2wzNvwGxJUNvST+rzkKFQclgho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Paul Moore <paul@paul-moore.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 480/509] security: keys: Modify mismatched function name
Date:   Tue, 25 Jul 2023 12:46:59 +0200
Message-ID: <20230725104615.721526990@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 2a4152742025c5f21482e8cebc581702a0fa5b01 ]

No functional modification involved.

security/keys/trusted-keys/trusted_tpm2.c:203: warning: expecting prototype for tpm_buf_append_auth(). Prototype was for tpm2_buf_append_auth() instead.

Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5524
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 4c19d3abddbee..65f68856414a6 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -21,7 +21,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 };
 
 /**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
  * @buf: an allocated tpm_buf instance
  * @session_handle: session handle
-- 
2.39.2



