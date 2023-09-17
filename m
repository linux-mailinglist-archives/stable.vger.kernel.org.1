Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C203B7A3CFE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbjIQUhz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbjIQUhj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18780118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A74FC433C7;
        Sun, 17 Sep 2023 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983051;
        bh=muDtx0IPLQwvepeTe6y4RStc7A5tyrUojWhDuhDpv+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzCHm4DuBpp8cfy7X0pttgEk9NO5USOBds5MsiXkjCOXF7was7dLEqTAH+gbjPuZz
         IeKpoj4NDCjUVrIhBCfj4+WSay1nLAPbobl5x32zu8ZsSIFwinnykWyc58HaRIi70R
         bTqXXqSL64jpSGR3NyWCaMY+F4c3dkhnXy0LX06g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+822d1359297e2694f873@syzkaller.appspotmail.com,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 431/511] xsk: Fix xsk_diag use-after-free error during socket cleanup
Date:   Sun, 17 Sep 2023 21:14:18 +0200
Message-ID: <20230917191124.174314960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Magnus Karlsson <magnus.karlsson@intel.com>

[ Upstream commit 3e019d8a05a38abb5c85d4f1e85fda964610aa14 ]

Fix a use-after-free error that is possible if the xsk_diag interface
is used after the socket has been unbound from the device. This can
happen either due to the socket being closed or the device
disappearing. In the early days of AF_XDP, the way we tested that a
socket was not bound to a device was to simply check if the netdevice
pointer in the xsk socket structure was NULL. Later, a better system
was introduced by having an explicit state variable in the xsk socket
struct. For example, the state of a socket that is on the way to being
closed and has been unbound from the device is XSK_UNBOUND.

The commit in the Fixes tag below deleted the old way of signalling
that a socket is unbound, setting dev to NULL. This in the belief that
all code using the old way had been exterminated. That was
unfortunately not true as the xsk diagnostics code was still using the
old way and thus does not work as intended when a socket is going
down. Fix this by introducing a test against the state variable. If
the socket is in the state XSK_UNBOUND, simply abort the diagnostic's
netlink operation.

Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/bpf/20230831100119.17408-1-magnus.karlsson@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk_diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index c014217f5fa7d..22b36c8143cfd 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	sock_diag_save_cookie(sk, msg->xdiag_cookie);
 
 	mutex_lock(&xs->mutex);
+	if (READ_ONCE(xs->state) == XSK_UNBOUND)
+		goto out_nlmsg_trim;
+
 	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
 		goto out_nlmsg_trim;
 
-- 
2.40.1



