Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075FF7A3A27
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjIQT7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIQT7F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CBEF3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B65C433C7;
        Sun, 17 Sep 2023 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980739;
        bh=YrO9HJhduO8DQw+7lL19OCPG7qVa7OrwcE1G2jThcfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAfTN5MJnW5M/Srm0EuIrMNjbzDfhtkkxJxFakrSHBG3PHkwc8azS+1VUeR4Wh2z/
         Ce1E9MLbfQK75aA0wz7zajBoiLb/HFyHItQDEH+KtU+k4RUBSaIH7p6FFl0W6dKpSD
         gfwP2Q8ibyti73ftBkD9qXfwwEgMzdOh6LS4D6q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 279/285] selftest: tcp: Fix address length in bind_wildcard.c.
Date:   Sun, 17 Sep 2023 21:14:39 +0200
Message-ID: <20230917191100.795634198@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 0071d15517b4a3d265abc00395beb1138e7236c7 ]

The selftest passes the IPv6 address length for an IPv4 address.
We should pass the correct length.

Note inet_bind_sk() does not check if the size is larger than
sizeof(struct sockaddr_in), so there is no real bug in this
selftest.

Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/bind_wildcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index 58edfc15d28bd..e7ebe72e879d7 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -100,7 +100,7 @@ void bind_sockets(struct __test_metadata *_metadata,
 TEST_F(bind_wildcard, v4_v6)
 {
 	bind_sockets(_metadata, self,
-		     (struct sockaddr *)&self->addr4, sizeof(self->addr6),
+		     (struct sockaddr *)&self->addr4, sizeof(self->addr4),
 		     (struct sockaddr *)&self->addr6, sizeof(self->addr6));
 }
 
-- 
2.40.1



