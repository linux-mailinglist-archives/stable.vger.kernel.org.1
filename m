Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F037ED4F8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbjKOU7o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344666AbjKOU6K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336C1FD8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF5AC43391;
        Wed, 15 Nov 2023 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081854;
        bh=/nWyjU9mPTXtUjAeUz1toDBz+APRKSQVK02VISZqrzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrb0VGzZEY5K/6rAsWA3BRJpTC/E3/BYXJjk0VmbEHdn4OmkhQL1zEBQ4k76Hbixe
         lNOwDffcPnHqgQ/zZFfE/bA9cVbRwirZ/D4eX8Z2SSWDnFFcdkLOkAEMj+RvoRVE62
         gJzPLli3JCrMnWk1KfMsW6VMLXxuDM3E2JOgndX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        wenxu <wenxu@ucloud.cn>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 168/191] inet: shrink struct flowi_common
Date:   Wed, 15 Nov 2023 15:47:23 -0500
Message-ID: <20231115204654.539002296@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 236d0941c69f0..7ffa1fe1107cc 100644
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



