Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4893770C628
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjEVTQF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjEVTPm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A99D103
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC656275E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7487EC433D2;
        Mon, 22 May 2023 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782928;
        bh=EfgmZvaJyLYUFwhi4Ji+9XYIRtmquCM7KCGk7HAPPJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzMhiV3DlKlkE6UxD+g6vcu5GXG1iq5cfmt1jJyxw4e1elwmv7eMqAYCrkhj4uKsg
         SLNq0DhtN4Rekj0fI2PKN8hiMac+1iLy1MlOMV7/9oOhO/tDbGnCXz6eKrriNPV7G3
         VERuQoUnXuA6pRznh7aBl23w+5FLlxFZMT0EuBZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com,
        Min Li <lm0963hack@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 077/203] Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp
Date:   Mon, 22 May 2023 20:08:21 +0100
Message-Id: <20230522190357.121225701@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 25e97f7b1866e6b8503be349eeea44bb52d661ce ]

conn->chan_lock isn't acquired before l2cap_get_chan_by_scid,
if l2cap_get_chan_by_scid returns NULL, then 'bad unlock balance'
is triggered.

Reported-by: syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000894f5f05f95e9f4d@google.com/
Signed-off-by: Min Li <lm0963hack@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 446343348329f..f01b77b037878 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4694,7 +4694,6 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-- 
2.39.2



