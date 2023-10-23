Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701DE7D3126
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJWLGL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjJWLGK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC3D7A
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52773C433C8;
        Mon, 23 Oct 2023 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059168;
        bh=an2cjlTFcES6t6uF7x0au4MOwAMZiZWZ3oikDF6C4e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTRfRetRDJbPU3OxnRh+UGmz+QfftdPJMpdUbQDItUYji15KP0vcAfdwjqB9DDxMQ
         MdA03YkN50Z5Qaje4uV10C9lJjM2+61a9sVgJtkPb0X2y/cV4NAWJbZfOIVhErA/l2
         +PNR6aaxVFma6iDX7ilGoJCFRyXbkZMRdhP0P/Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.5 060/241] wifi: cfg80211: use system_unbound_wq for wiphy work
Date:   Mon, 23 Oct 2023 12:54:06 +0200
Message-ID: <20231023104835.372362063@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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
@@ -1622,7 +1622,7 @@ void wiphy_work_queue(struct wiphy *wiph
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	schedule_work(&rdev->wiphy_work);
+	queue_work(system_unbound_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 


