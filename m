Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACE27BDDCF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376801AbjJINNc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376892AbjJINNU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF2ED
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A15C433CD;
        Mon,  9 Oct 2023 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857148;
        bh=rmz9639pLz6J7OoDi5pRgxBouRmokiUZmWcLjzSJvbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlXE5BP7Gt4b+MC4lIKYV4r4YDPYzn22Y5WrlRsfpOpxHnoZ3jtxzwSxT+jZtDL9w
         YV5Utm0MXcN3UvW77OaeZm9oDQVxw7NVHMU8mtSZgGo6/0XzJjpU6p8sHdAtLI6uTH
         hCluxOAXBoLTsA5aZ6uYYghmcTVbGlB7ZkoBY0yM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Cline <jeremy@jcline.org>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: [PATCH 6.5 112/163] net: nfc: llcp: Add lock when modifying device list
Date:   Mon,  9 Oct 2023 15:01:16 +0200
Message-ID: <20231009130127.120244529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jeremy@jcline.org>

[ Upstream commit dfc7f7a988dad34c3bf4c053124fb26aa6c5f916 ]

The device list needs its associated lock held when modifying it, or the
list could become corrupted, as syzbot discovered.

Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
Link: https://lore.kernel.org/r/20230908235853.1319596-1-jeremy@jcline.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index f60e424e06076..6705bb895e239 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1636,7 +1636,9 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	timer_setup(&local->sdreq_timer, nfc_llcp_sdreq_timer, 0);
 	INIT_WORK(&local->sdreq_timeout_work, nfc_llcp_sdreq_timeout_work);
 
+	spin_lock(&llcp_devices_lock);
 	list_add(&local->list, &llcp_devices);
+	spin_unlock(&llcp_devices_lock);
 
 	return 0;
 }
-- 
2.40.1



