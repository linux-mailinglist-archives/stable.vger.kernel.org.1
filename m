Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88379761669
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjGYLjT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjGYLjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EDD19A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A0F6167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1789DC433C7;
        Tue, 25 Jul 2023 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285133;
        bh=K8K1NfSnwd0QxhuwtMieT2kzJBzJ49mJHxxQ22r9K2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0GM8rLdcwwg5IwT0OrAwuZNNE/D5C6xgWZxI0M9m/0lMIbwUEv6b6kd2+NeUsjw+
         3E1q4VlHDpLv8odhjjgQcNyX8kSwE9jndRAXIuL7TW2PahgahOtJvUfyZi/rL1pTKV
         JFt3Q7F1RPqZ5s4JqYrZByLDgDiDVtUHfhjSQG+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Sowden <jeremy@azazel.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/313] lib/ts_bm: reset initial match offset for every block of text
Date:   Tue, 25 Jul 2023 12:43:39 +0200
Message-ID: <20230725104523.853650205@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 6f67fbf8192da80c4db01a1800c7fceaca9cf1f9 ]

The `shift` variable which indicates the offset in the string at which
to start matching the pattern is initialized to `bm->patlen - 1`, but it
is not reset when a new block is retrieved.  This means the implemen-
tation may start looking at later and later positions in each successive
block and miss occurrences of the pattern at the beginning.  E.g.,
consider a HTTP packet held in a non-linear skb, where the HTTP request
line occurs in the second block:

  [... 52 bytes of packet headers ...]
  GET /bmtest HTTP/1.1\r\nHost: www.example.com\r\n\r\n

and the pattern is "GET /bmtest".

Once the first block comprising the packet headers has been examined,
`shift` will be pointing to somewhere near the end of the block, and so
when the second block is examined the request line at the beginning will
be missed.

Reinitialize the variable for each new block.

Fixes: 8082e4ed0a61 ("[LIB]: Boyer-Moore extension for textsearch infrastructure strike #2")
Link: https://bugzilla.netfilter.org/show_bug.cgi?id=1390
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/ts_bm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index b352903c50e38..0a22ae48af61f 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -60,10 +60,12 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 	struct ts_bm *bm = ts_config_priv(conf);
 	unsigned int i, text_len, consumed = state->offset;
 	const u8 *text;
-	int shift = bm->patlen - 1, bs;
+	int bs;
 	const u8 icase = conf->flags & TS_IGNORECASE;
 
 	for (;;) {
+		int shift = bm->patlen - 1;
+
 		text_len = conf->get_next_block(consumed, &text, conf, state);
 
 		if (unlikely(text_len == 0))
-- 
2.39.2



