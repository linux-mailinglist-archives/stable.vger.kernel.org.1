Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38317B8A6D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbjJDSfR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbjJDSfQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:35:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B55C6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:35:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA42C433C8;
        Wed,  4 Oct 2023 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444512;
        bh=a35JGh+llbSyrRkhaiGARIhq7S+yKNHhqt+kRAg5ySw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmNLE79mKP/bR+X3Ebv5LqvWNXwcbVDS1ROClm7Jz7P9FhgGCTG73T2hQKJFgcv5a
         ipOIgfRGeIMzjNOOPuqlZlqEy3yZsT+xK9hBQ2IF1ZSvsZcOVCoBKrWHODJelxtkTB
         esmnD/EyTYEjGr90hCwakVJSgm9o5M0RWJ43pelQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 248/321] mptcp: fix bogus receive window shrinkage with multiple subflows
Date:   Wed,  4 Oct 2023 19:56:33 +0200
Message-ID: <20231004175240.760146479@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

commit 6bec041147a2a64a490d1f813e8a004443061b38 upstream.

In case multiple subflows race to update the mptcp-level receive
window, the subflow losing the race should use the window value
provided by the "winning" subflow to update it's own tcp-level
rcv_wnd.

To such goal, the current code bogusly uses the mptcp-level rcv_wnd
value as observed before the update attempt. On unlucky circumstances
that may lead to TCP-level window shrinkage, and stall the other end.

Address the issue feeding to the rcv wnd update the correct value.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/427
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1269,12 +1269,13 @@ static void mptcp_set_rwin(struct tcp_so
 
 			if (rcv_wnd == rcv_wnd_old)
 				break;
-			if (before64(rcv_wnd_new, rcv_wnd)) {
+
+			rcv_wnd_old = rcv_wnd;
+			if (before64(rcv_wnd_new, rcv_wnd_old)) {
 				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
 				goto raise_win;
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
-			rcv_wnd_old = rcv_wnd;
 		}
 		return;
 	}


