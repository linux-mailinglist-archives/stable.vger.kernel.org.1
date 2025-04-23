Return-Path: <stable+bounces-136272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2760A99344
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F29A334E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0627280CDC;
	Wed, 23 Apr 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1B5YcYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56B1A23B0;
	Wed, 23 Apr 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422110; cv=none; b=scvCq4Xw+tTRn1Gqof/Z8HDRjGm+63jZkFAX0ubr/lkcTB01kcwxRvApv8AyugckBj9NizJFcN8r/rGmKkASR+XySOG3BYuUjQtSO7hv2IT26OuKxm+KrsETvwgrLqzhnEjb5PP8rfInLWJAr62E11RMUgT9SQyBE+HPptP5FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422110; c=relaxed/simple;
	bh=U4G10Gm/giEhL3U0frOOMxR95yriXI/VRIxlp1bC/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx1WTfs9X7BpFxZb4d76x1iQeW/vrpI4OARMHax5u3jmOyX0ODbQvY6RT1Eh1a3jYi2LWz9tZATw3XLPdkFRTXNovO5zxjzRZBHfCG1AUbb0ZH6F7gkYgUYxAw731UaZ/2Gl6ggnC31Jyk3G90zE3C+EfAHFLruuXSHeizCJXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1B5YcYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A587CC4CEE2;
	Wed, 23 Apr 2025 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422110;
	bh=U4G10Gm/giEhL3U0frOOMxR95yriXI/VRIxlp1bC/Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1B5YcYyUHImPLHQs2QFvZdkkoD8uVvZ2UIszMnuOqRocPkCX09pKwhQEix29l9qd
	 GGivwI5z28mymtlDb0aOu8bW33IwLh1D8X+YzCVO38DhrKnD/kz9cWVbQclm7UCuQf
	 xTaIpENZCFca4UVbhelY+d1j4X83ttWi0GKnEXyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bert Karwatzki <spasswolf@web.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 258/393] Revert "wifi: mac80211: Update skbs control block key in ieee80211_tx_dequeue()"
Date: Wed, 23 Apr 2025 16:42:34 +0200
Message-ID: <20250423142654.030286803@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 0937cb5f345c79d702b4d0d744e2a2529b551cb2 ]

This reverts commit a104042e2bf6528199adb6ca901efe7b60c2c27f.

Since the original bug seems to have been around for years,
but a new issue was report with the fix, revert the fix for
now. We have a couple of weeks to figure it out for this
release, if needed.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/linux-wireless/20250410215527.3001-1-spasswolf@web.de
Fixes: a104042e2bf6 ("wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8c46498152d76..45a093d3f1fa7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3877,7 +3877,6 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
-	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.39.5




