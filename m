Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA07ED6EC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjKOWEY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbjKOWEW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7712C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B2C433C8;
        Wed, 15 Nov 2023 22:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085859;
        bh=8VhrD5C2IauGub2va+kGfph2UZZ8LYKxhtUW9zP5Hl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMqhT56pKXxPycOo4oRBCZroV0uOo/x/mutxkZLbiDJemu4usvRwtd4+ktdiPUxCe
         KVF+Z5YBwJB7bLlYU7+rGt/7B6buKwpqOXBarkUzrHJxZFAixzUmaMK1j40AyGHo8x
         9pVxWKiXVONAEEsXQ0wpqLkRb3ncqfqePdbFkIFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        wenxu <wenxu@ucloud.cn>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 101/119] inet: shrink struct flowi_common
Date:   Wed, 15 Nov 2023 17:01:31 -0500
Message-ID: <20231115220135.779285373@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1726483b79a72e0150734d5367e4a0238bf8fcff ]

I am looking at syzbot reports triggering kernel stack overflows
involving a cascade of ipvlan devices.

We can save 8 bytes in struct flowi_common.

This patch alone will not fix the issue, but is a start.

Fixes: 24ba14406c5c ("route: Add multipath_hash in flowi_common to make user-define hash")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: wenxu <wenxu@ucloud.cn>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20231025141037.3448203-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/flow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow.h b/include/net/flow.h
index d058e63fb59a3..21e781c74ac51 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -39,8 +39,8 @@ struct flowi_common {
 #define FLOWI_FLAG_SKIP_NH_OIF		0x04
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
-	struct flowi_tunnel flowic_tun_key;
 	__u32		flowic_multipath_hash;
+	struct flowi_tunnel flowic_tun_key;
 };
 
 union flowi_uli {
-- 
2.42.0



