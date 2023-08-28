Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3478A9E1
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjH1KQ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjH1KQi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1D12F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B9E617E4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BD8C433C7;
        Mon, 28 Aug 2023 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217789;
        bh=AOKE6DNagsbjlFmqmP3BwOliQWtvedveFzcHi6+LeHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5eHl80SPaggbYouISpChAtOR5KNPjToXwkkbXVR1pSP1keEPg7NxeMw/LLC4fCyn
         pkz/xF4Ux4QIeQzcjvSH27fHCkUk3Gb5j1hOc6LE0pjIOTE8L0ATcR5CUCHlEDDIEX
         wIWjsXEcBFYdGJD3QKZMIYACVRWR+kdFSdaSrSo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 39/57] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
Date:   Mon, 28 Aug 2023 12:12:59 +0200
Message-ID: <20230828101145.699158960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
References: <20230828101144.231099710@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

commit d1e0e61d617ba17aa516db707aa871387566bbf7 upstream.

According to all consumers code of attrs[XFRMA_SEC_CTX], like

* verify_sec_ctx_len(), convert to xfrm_user_sec_ctx*
* xfrm_state_construct(), call security_xfrm_state_alloc whose prototype
is int security_xfrm_state_alloc(.., struct xfrm_user_sec_ctx *sec_ctx);
* copy_from_user_sec_ctx(), convert to xfrm_user_sec_ctx *
...

It seems that the expected parsing result for XFRMA_SEC_CTX should be
structure xfrm_user_sec_ctx, and the current xfrm_sec_ctx is confusing
and misleading (Luckily, they happen to have same size 8 bytes).

This commit amend the policy structure to xfrm_user_sec_ctx to avoid
ambiguity.

Fixes: cf5cb79f6946 ("[XFRM] netlink: Establish an attribute policy")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2514,7 +2514,7 @@ static const struct nla_policy xfrma_pol
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },


