Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A57ECFD9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjKOTvP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbjKOTvO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4BAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D2C433C8;
        Wed, 15 Nov 2023 19:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077871;
        bh=Ifim9AG9SKPva+6a0uwB3gaI6SpdjcwVEEmnoPySa8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgZeYgqnYVEq9f7MYNgms02evYjy98YfcRxt87BOV3m/GDqIK2/pQPp15fn0yd55P
         vl8nSdbHHaYS8yAt3FQvu2aKDy3HA2OrK7mQebHae0TlYqaV3huSAUZrSBnabxYX97
         7iz798xEtqh1fXcSJu5l85Qfo+ROlcuhS8dpvXzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        wenxu <wenxu@ucloud.cn>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 546/603] inet: shrink struct flowi_common
Date:   Wed, 15 Nov 2023 14:18:11 -0500
Message-ID: <20231115191649.542388975@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 7f0adda3bf2fe..335bbc52171c1 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -40,8 +40,8 @@ struct flowi_common {
 #define FLOWI_FLAG_KNOWN_NH		0x02
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
-	struct flowi_tunnel flowic_tun_key;
 	__u32		flowic_multipath_hash;
+	struct flowi_tunnel flowic_tun_key;
 };
 
 union flowi_uli {
-- 
2.42.0



