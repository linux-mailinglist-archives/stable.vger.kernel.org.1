Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C87D329E
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJWLWL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjJWLWK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE6DD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9DDC433C9;
        Mon, 23 Oct 2023 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060127;
        bh=/0Msz1EWgZKVE9KByF1yCbiwHY1kdWe6aHPyawY4P7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6s/gC+CUfQ3ou3ec8u9fc/Z99ewLoibgbUuOC4V0g0zJzE3WtfdNJhsnBwuzXYbz
         rL58sk+g450kQxIJfipPl9Hlkae2AETSx0u+1vw/o53gEhpJ1AcNPixYTR9aa2QF39
         LQ+cFi4GOsnn1Uyt74Bwa24UK3467ysLo75Mu6ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.1 050/196] wifi: cfg80211: use system_unbound_wq for wiphy work
Date:   Mon, 23 Oct 2023 12:55:15 +0200
Message-ID: <20231023104829.935017764@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 91d20ab9d9ca035527af503d00e1e30d6c375f2a upstream.

Since wiphy work items can run pretty much arbitrary
code in the stack/driver, it can take longer to run
all of this, so we shouldn't be using system_wq via
schedule_work(). Also, we lock the wiphy (which is
the reason this exists), so use system_unbound_wq.

Reported-and-tested-by: Kalle Valo <kvalo@kernel.org>
Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1618,7 +1618,7 @@ void wiphy_work_queue(struct wiphy *wiph
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	schedule_work(&rdev->wiphy_work);
+	queue_work(system_unbound_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 


