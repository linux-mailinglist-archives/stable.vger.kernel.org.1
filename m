Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84D72C062
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjFLKwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjFLKvt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6793D4
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9FA60F87
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232BBC433D2;
        Mon, 12 Jun 2023 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566176;
        bh=4E3Ra0lC6sYe0Zfy5Ewgo1M+oxhBfPl2HN85bjawNYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTdkjV5N5QwmEysQbhV07nKea85iam4NXMnT4+jvn4UUH0/RMfyaVz0cDjaw27oSb
         2Y20cmqg5lq/3yOI3v9wKkQt4dkRlL3addivKNJgcSQV0R9vJDjxIYXRZGRDyPbZ2h
         h4/QYcDeVKvf756b1rGQ10Wg/8D524LU3yKRyVWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ying Hsu <yinghsu@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 24/91] Bluetooth: Fix l2cap_disconnect_req deadlock
Date:   Mon, 12 Jun 2023 12:26:13 +0200
Message-ID: <20230612101703.101219410@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ying Hsu <yinghsu@chromium.org>

[ Upstream commit 02c5ea5246a44d6ffde0fddebfc1d56188052976 ]

L2CAP assumes that the locks conn->chan_lock and chan->lock are
acquired in the order conn->chan_lock, chan->lock to avoid
potential deadlock.
For example, l2sock_shutdown acquires these locks in the order:
  mutex_lock(&conn->chan_lock)
  l2cap_chan_lock(chan)

However, l2cap_disconnect_req acquires chan->lock in
l2cap_get_chan_by_scid first and then acquires conn->chan_lock
before calling l2cap_chan_del. This means that these locks are
acquired in unexpected order, which leads to potential deadlock:
  l2cap_chan_lock(c)
  mutex_lock(&conn->chan_lock)

This patch releases chan->lock before acquiring the conn_chan_lock
to avoid the potential deadlock.

Fixes: a2a9339e1c9d ("Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}")
Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f01b77b037878..101a15256efe5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4664,7 +4664,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4703,7 +4705,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
-- 
2.39.2



