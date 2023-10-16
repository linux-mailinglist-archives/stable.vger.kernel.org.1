Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932D87CA2E3
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjJPI4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPI4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:56:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE4E5
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:56:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89C5C433C8;
        Mon, 16 Oct 2023 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446597;
        bh=ahue3Cg2KDW4TU61ELAGNIHYcUJaxc+fJq8fogKzNkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhqpIcxxD4rCin/H+5yzAoFaXYd+t/TQSWxc0ncEy4RkzlDUaTcsTEvu0kJRtFsi/
         O+GGxP0lhTly8qnwIbysTQ38evOsKm+9uATGp/ACb6epiS7oaHOqysJcYsfMQdxVIA
         rd4HfLq71MXrgqfi5BqIeAnBjyFODnQT81joEq54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/131] net: refine debug info in skb_checksum_help()
Date:   Mon, 16 Oct 2023 10:40:38 +0200
Message-ID: <20231016084001.440100088@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 26c29961b142444cd99361644c30fa1e9b3da6be ]

syzbot uses panic_on_warn.

This means that the skb_dump() I added in the blamed commit are
not even called.

Rewrite this so that we get the needed skb dump before syzbot crashes.

Fixes: eeee4b77dc52 ("net: add more debug info in skb_checksum_help()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20231006173355.2254983-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a2e3c6470ab3f..5374761f5af2c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3274,15 +3274,19 @@ int skb_checksum_help(struct sk_buff *skb)
 
 	offset = skb_checksum_start_offset(skb);
 	ret = -EINVAL;
-	if (WARN_ON_ONCE(offset >= skb_headlen(skb))) {
+	if (unlikely(offset >= skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
+			  offset, skb_headlen(skb));
 		goto out;
 	}
 	csum = skb_checksum(skb, offset, skb->len - offset, 0);
 
 	offset += skb->csum_offset;
-	if (WARN_ON_ONCE(offset + sizeof(__sum16) > skb_headlen(skb))) {
+	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
 		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
+		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
+			  offset + sizeof(__sum16), skb_headlen(skb));
 		goto out;
 	}
 	ret = skb_ensure_writable(skb, offset + sizeof(__sum16));
-- 
2.40.1



