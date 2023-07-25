Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01C7761645
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjGYLhm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjGYLhi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C1199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A966166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB0C433C7;
        Tue, 25 Jul 2023 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285055;
        bh=JWFMFDUM3Ckr6zmYOqwt1PqWm0hPrktiv9T+27tD0z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Skumz2tmpGji/Bo4Ljqw8C1i7w1mhUwnXfe0Srv/WVdv2yLOnOO4y7U8xpGYqF1g0
         9uTIYcWhT5C1hzuoWj/X2czNtdkS0wOO/lkn/k4xVjRNAgBlsX9WECWZQrdh/P3Lfi
         rQ0grhz0v9CE9ExrqaaSPBeCBUfbjnRESYNfJdM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Ilia.Gavrilov" <Ilia.Gavrilov@infotecs.ru>,
        Simon Horman <simon.horman@corigine.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 068/313] netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.
Date:   Tue, 25 Jul 2023 12:43:41 +0200
Message-ID: <20230725104523.934068277@linuxfoundation.org>
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

From: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit f188d30087480eab421cd8ca552fb15f55d57f4d ]

ct_sip_parse_numerical_param() returns only 0 or 1 now.
But process_register_request() and process_register_response() imply
checking for a negative value if parsing of a numerical header parameter
failed.
The invocation in nf_nat_sip() looks correct:
 	if (ct_sip_parse_numerical_param(...) > 0 &&
 	    ...) { ... }

Make the return value of the function ct_sip_parse_numerical_param()
a tristate to fix all the cases
a) return 1 if value is found; *val is set
b) return 0 if value is not found; *val is unchanged
c) return -1 on error; *val is undefined

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 0f32a40fc91a ("[NETFILTER]: nf_conntrack_sip: create signalling expectations")
Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_sip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 78fd9122b70c7..751df19fe0f8a 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -611,7 +611,7 @@ int ct_sip_parse_numerical_param(const struct nf_conn *ct, const char *dptr,
 	start += strlen(name);
 	*val = simple_strtoul(start, &end, 0);
 	if (start == end)
-		return 0;
+		return -1;
 	if (matchoff && matchlen) {
 		*matchoff = start - dptr;
 		*matchlen = end - start;
-- 
2.39.2



