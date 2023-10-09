Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414C7BE1B6
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377520AbjJINxU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377521AbjJINxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:53:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422191
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:53:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A32C433C7;
        Mon,  9 Oct 2023 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859595;
        bh=PGN2Mi+DtK/Nniu+U/zXE55BKUcM86tAh6DI/tbOHuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkF5M3shnuh4jJCbPX5fDKXLp347IzlOHZzXXhl9wXjTiDtOuFT/0XxdnaSgZzYPi
         5TTEDQVKyKgaq+aVzDHQM+a3cIOZcOZVdjAsjckOLKfLltMP8sZpjctmWGKEHyLfVe
         +8ctL/A324OUkK5lKS1AwJH8WZi+aD7Wv/cAeTOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Riemann <felix.riemann@sma.de>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/91] net: Fix unwanted sign extension in netdev_stats_to_stats64()
Date:   Mon,  9 Oct 2023 15:06:16 +0200
Message-ID: <20231009130113.043818724@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Riemann <felix.riemann@sma.de>

[ Upstream commit 9b55d3f0a69af649c62cbc2633e6d695bb3cc583 ]

When converting net_device_stats to rtnl_link_stats64 sign extension
is triggered on ILP32 machines as 6c1c509778 changed the previous
"ulong -> u64" conversion to "long -> u64" by accessing the
net_device_stats fields through a (signed) atomic_long_t.

This causes for example the received bytes counter to jump to 16EiB after
having received 2^31 bytes. Casting the atomic value to "unsigned long"
beforehand converting it into u64 avoids this.

Fixes: 6c1c5097781f ("net: add atomic_long_t to net_device_stats fields")
Signed-off-by: Felix Riemann <felix.riemann@sma.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3bf40c288c032..0f9214fb36e01 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9041,7 +9041,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 
 	BUILD_BUG_ON(n > sizeof(*stats64) / sizeof(u64));
 	for (i = 0; i < n; i++)
-		dst[i] = atomic_long_read(&src[i]);
+		dst[i] = (unsigned long)atomic_long_read(&src[i]);
 	/* zero out counters that only exist in rtnl_link_stats64 */
 	memset((char *)stats64 + n * sizeof(u64), 0,
 	       sizeof(*stats64) - n * sizeof(u64));
-- 
2.40.1



