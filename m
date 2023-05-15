Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EC703994
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbjEORnv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbjEORne (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7111577
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACD762E50
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99FDC433EF;
        Mon, 15 May 2023 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172464;
        bh=WBQHgrZivu1/vaqI2bSpJ1ggUsNp54OLvpEqeScgugQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rW1POXhOIqM9ewZ0ij9zm8prG873zFzGjziCGVoNgzcaAIL4kgHwQjQY79qeoirtI
         NpstaeEDzLQqSTBAUqLr5DVb6LHYsDVquOKomC1ACXuaGAYbZPwNIr/sdkohkfj1h0
         dtFWJIH2VK8WHhvlkhazdNEaX8RLVWaSVeQahQws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Neukum <oneukum@suse.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com
Subject: [PATCH 5.10 133/381] wifi: ath6kl: reduce WARN to dev_dbg() in callback
Date:   Mon, 15 May 2023 18:26:24 +0200
Message-Id: <20230515161742.846726854@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 75c4a8154cb6c7239fb55d5550f481f6765fb83c ]

The warn is triggered on a known race condition, documented in the code above
the test, that is correctly handled.  Using WARN() hinders automated testing.
Reducing severity.

Fixes: de2070fc4aa7 ("ath6kl: Fix kernel panic on continuous driver load/unload")
Reported-and-tested-by: syzbot+555908813b2ea35dae9a@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230126182431.867984-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/htc_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index c68848819a52d..9b88d96bfe96c 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -960,8 +960,8 @@ static int ath6kl_htc_pipe_rx_complete(struct ath6kl *ar, struct sk_buff *skb,
 	 * Thus the possibility of ar->htc_target being NULL
 	 * via ath6kl_recv_complete -> ath6kl_usb_io_comp_work.
 	 */
-	if (WARN_ON_ONCE(!target)) {
-		ath6kl_err("Target not yet initialized\n");
+	if (!target) {
+		ath6kl_dbg(ATH6KL_DBG_HTC, "Target not yet initialized\n");
 		status = -EINVAL;
 		goto free_skb;
 	}
-- 
2.39.2



