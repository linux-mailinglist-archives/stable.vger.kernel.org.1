Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725036F9857
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjEGK4S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEGK4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E035B8F
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1AF60B34
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356B5C433EF;
        Sun,  7 May 2023 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456975;
        bh=XIrvqB0C0BqBnmv+TBUsk2hTp4lK1Kw0GrOfKTFNEkQ=;
        h=Subject:To:Cc:From:Date:From;
        b=FhwZBk4F3VM9QN9s1cvYwhx6tVuW4mEewLma8zUefOvGlOpYOw2wDuGt5mdq/5Fnb
         HeKWYYyA91iKNrlf5XU3nWuucRcDceAvefAB/ysnS0KLue4+1LWeOu2c+fO1kEkVnz
         edqwvXbaxuIW5qfDz3d0/t18dsls0/fNTQopT9Tk=
Subject: FAILED: patch "[PATCH] wifi: ath9k: Don't mark channelmap stack variable read-only" failed to apply to 6.3-stable tree
To:     toke@toke.dk, quic_kvalo@quicinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:56:12 +0200
Message-ID: <2023050712-jailhouse-glazing-2d6c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x b956e3110a797a3663f91f9b8935b667cc23fe72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050712-jailhouse-glazing-2d6c@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

b956e3110a79 ("wifi: ath9k: Don't mark channelmap stack variable read-only in ath9k_mci_update_wlan_channels()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b956e3110a797a3663f91f9b8935b667cc23fe72 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Mon, 17 Apr 2023 13:35:03 +0300
Subject: [PATCH] wifi: ath9k: Don't mark channelmap stack variable read-only
 in ath9k_mci_update_wlan_channels()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This partially reverts commit e161d4b60ae3a5356e07202e0bfedb5fad82c6aa.

Turns out the channelmap variable is not actually read-only, it's modified
through the MCI_GPM_CLR_CHANNEL_BIT() macro further down in the function,
so making it read-only causes page faults when that code is hit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217183
Fixes: e161d4b60ae3 ("wifi: ath9k: Make arrays prof_prio and channelmap static const")
Cc: stable@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230413214118.153781-1-toke@toke.dk

diff --git a/drivers/net/wireless/ath/ath9k/mci.c b/drivers/net/wireless/ath/ath9k/mci.c
index 3363fc4e8966..a0845002d6fe 100644
--- a/drivers/net/wireless/ath/ath9k/mci.c
+++ b/drivers/net/wireless/ath/ath9k/mci.c
@@ -646,9 +646,7 @@ void ath9k_mci_update_wlan_channels(struct ath_softc *sc, bool allow_all)
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath9k_hw_mci *mci = &ah->btcoex_hw.mci;
 	struct ath9k_channel *chan = ah->curchan;
-	static const u32 channelmap[] = {
-		0x00000000, 0xffff0000, 0xffffffff, 0x7fffffff
-	};
+	u32 channelmap[] = {0x00000000, 0xffff0000, 0xffffffff, 0x7fffffff};
 	int i;
 	s16 chan_start, chan_end;
 	u16 wlan_chan;

