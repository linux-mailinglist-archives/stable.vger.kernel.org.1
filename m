Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D94713F5B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjE1Tog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjE1Toe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74689C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB5961F30
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD65C433D2;
        Sun, 28 May 2023 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303072;
        bh=Kd66mZCQmgkJ6bs67PuBs10aQt+6fopSlwdJQyEHzg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmVLVrMg1mDfV63YQkWpb1aFp+9HNEc9ZroaiIrvGiSDoT4ujKrMvG5B9aVEJjN/9
         AVo8LlBkva0uD1DF1/9xpcgvnT1EdygVMTppSLg8qhphFsEnFWNbNKStGIAe4ZAD7e
         FQUU9Vgr9EUjYLGc0Q3oTZ1VWGaccJMiE42AkcrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 115/211] wifi: mac80211: fix min center freq offset tracing
Date:   Sun, 28 May 2023 20:10:36 +0100
Message-Id: <20230528190846.422221966@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 248e4776514bf70236e6b1a54c65aa5324c8b1eb ]

We need to set the correct trace variable, otherwise we're
overwriting something else instead and the right one that
we print later is not initialized.

Fixes: b6011960f392 ("mac80211: handle channel frequency offset")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230504134511.828474-2-gregory.greenman@intel.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 89723907a0945..5ddaa7c824773 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -67,7 +67,7 @@
 			__entry->min_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;	\
 			__entry->min_chan_width = (c)->width;				\
 			__entry->min_center_freq1 = (c)->center_freq1;			\
-			__entry->freq1_offset = (c)->freq1_offset;			\
+			__entry->min_freq1_offset = (c)->freq1_offset;			\
 			__entry->min_center_freq2 = (c)->center_freq2;
 #define MIN_CHANDEF_PR_FMT	" min_control:%d.%03d MHz min_width:%d min_center: %d.%03d/%d MHz"
 #define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_freq_offset,	\
-- 
2.39.2



