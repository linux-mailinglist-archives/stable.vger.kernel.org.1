Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7569E7A3A20
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbjIQT7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbjIQT6r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61367EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBB6C433C8;
        Sun, 17 Sep 2023 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980722;
        bh=c5rbceCLLUE0Nn9xO+/aSifQYGls09KMNsvy2LvuZtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTBrmhK58XQ1ReNb5XzgDVjzBvPjHUtdDuGccEL+DTF/nu+0xKZZHHt0h2fVGOouF
         TFwlramrky37hEQP++R+z8OiO3uUwfodT1XNDDE9ysUW9hLSYGLxLzEdDbXriqaDY7
         8IhA1JebJ0lSfaO1NsuxS+jzOBCf/4I5PIY4fImo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Chuck Lever <chuck.lever@oracle.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 275/285] ipv6: fix ip6_sock_set_addr_preferences() typo
Date:   Sun, 17 Sep 2023 21:14:35 +0200
Message-ID: <20230917191100.676202195@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8cdd9f1aaedf823006449faa4e540026c692ac43 ]

ip6_sock_set_addr_preferences() second argument should be an integer.

SUNRPC attempts to set IPV6_PREFER_SRC_PUBLIC were
translated to IPV6_PREFER_SRC_TMP

Fixes: 18d5ad623275 ("ipv6: add ip6_sock_set_addr_preferences")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230911154213.713941-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2acc4c808d45d..b08bd694385aa 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1356,7 +1356,7 @@ static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
 	return 0;
 }
 
-static inline int ip6_sock_set_addr_preferences(struct sock *sk, bool val)
+static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
 {
 	int ret;
 
-- 
2.40.1



