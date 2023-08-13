Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA177AC76
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjHMVdY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjHMVdX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAE91
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3362D62C10
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFD5C433C8;
        Sun, 13 Aug 2023 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962404;
        bh=aZnw1OV+jMUJXvVCpoKEj3qiMuPrW3K1yT5hcYm4sqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWGfTPsw2SzYB7frKuqjzwXgzAUPunonru1NDk7F2Eqh8tK5XdVtjOt5OlnA/hpRH
         0n6cLmG0ffcr5haz/JclXtzENH4TD8e7mtRkPXORmvRql4xA8PLdWTJpWDVCr7rrWR
         qmNumINJOwXNwzGIBXKYrJLX2J0qX5kTgbSFVyA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 017/149] mptcp: avoid bogus reset on fallback close
Date:   Sun, 13 Aug 2023 23:17:42 +0200
Message-ID: <20230813211719.313571449@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit ff18f9ef30ee87740f741b964375d0cfb84e1ec2 upstream.

Since the blamed commit, the MPTCP protocol unconditionally sends
TCP resets on all the subflows on disconnect().

That fits full-blown MPTCP sockets - to implement the fastclose
mechanism - but causes unexpected corruption of the data stream,
caught as sporadic self-tests failures.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/419
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Link: https://lore.kernel.org/r/20230803-upstream-net-20230803-misc-fixes-6-5-v1-3-6671b1ab11cc@tessares.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2367,7 +2367,7 @@ static void __mptcp_close_ssk(struct soc
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if (flags & MPTCP_CF_FASTCLOSE) {
+	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
 		/* be sure to force the tcp_disconnect() path,
 		 * to generate the egress reset
 		 */


