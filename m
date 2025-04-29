Return-Path: <stable+bounces-137718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D3AA14AE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0211BA54BE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F825178B;
	Tue, 29 Apr 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lA7A2qKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BD2517AF;
	Tue, 29 Apr 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946918; cv=none; b=r+WhoIS8jQwBqeFwgQ7zjAe7MCNl6aQdsQS1JI9O76Y+c3cJMsuG96bpMOSrLnPmE/IpykarcZEiJfToHT4+fGuuw4iCuSk8BFLfEiBxxp/Ndb1fh28Rn5JJ1isqXgBH0AJWL5kGkvpCh6/sdgjuydJzbsCs0mGNqpLHoeElviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946918; c=relaxed/simple;
	bh=sIkPlYtV5I/n6zj5OJrXDKljUFOADv0I2H4c1ELmbjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDjf6mqQkyFYlQKEHkYXfjDKhCnQr5wLR48IkqSv9Va7sBkZitmFFLxd9zFZgwKxtcQtenEP3Tc84aJ65TwU3POq+rqsiPsbBQr3ET7b9D5VzyQKCl6iHuF8BCqBsG8bGyJ/AttSRH24kSJWiD+pNUDBpnGnE8Dgk+P/16qw198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lA7A2qKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0E3C4CEE3;
	Tue, 29 Apr 2025 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946918;
	bh=sIkPlYtV5I/n6zj5OJrXDKljUFOADv0I2H4c1ELmbjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA7A2qKouH3hD2m7+BJGVvArOSi+fvT7Fh3u2ecudkUSeX2u4kEiF/Us5ZjCz7WJi
	 vSSFlSsp5mKxu+d/Z/C1ifdcUZWjBlFfC2jECW2J5uR0L6h1DxTUhQnZWc0xVJhnQ+
	 DTwvQQYSr2SxVEDFrBUHBUWDfnX+ZFWvQcMaFVII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bert Karwatzki <spasswolf@web.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 112/286] Revert "wifi: mac80211: Update skbs control block key in ieee80211_tx_dequeue()"
Date: Tue, 29 Apr 2025 18:40:16 +0200
Message-ID: <20250429161112.467286378@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 5615575595efb..0d6d12fc3c07e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3691,7 +3691,6 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
-	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
-- 
2.39.5




