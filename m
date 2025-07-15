Return-Path: <stable+bounces-162086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F1B05B8E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBAF565FA5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BCD2D5426;
	Tue, 15 Jul 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3zyyDLx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589C1991D2;
	Tue, 15 Jul 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585635; cv=none; b=huwpQ/ASELJoo8PdkT3OwBYZGvm4yiG0bxGWuPpuA2Ax3sxA2NMoPiggVK6lj97fGkQdeO1/aXpbG5Xo4Q+xo/YD/SVt7bVslViQlMrgh5CU019uDE9yOmms/a05JnqDiqzTMPs0Sqkt04EJEVWWfe/OqYOruSh2Uk0hClSm8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585635; c=relaxed/simple;
	bh=+oEWqwAe6PbZOfPklL2YDtBDD40OWX3+FquU54xyzVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyOrxEig5Bb+1dwVgiW/vDtURp4IzEG22KbgIw8RtiuYKWSH7rrK7c3elNNDyB8/rRV3Sqr62jFMm2RnHNRbnG6ZaaaW5gfGeSRwfxM/oA4Hxmwv5gfXG4XGSy6qtDsn1D52FpP+r/0bi3aaDksja/I+gCN1zys19EwFJyvVpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3zyyDLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AF7C4CEE3;
	Tue, 15 Jul 2025 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585635;
	bh=+oEWqwAe6PbZOfPklL2YDtBDD40OWX3+FquU54xyzVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3zyyDLxy+/8nxSf/K8iNbCbkULa0pUqii5zdGobcgNjxQdgdzIuKSiShAjAnO5bV
	 hUUYO9h5HqC5c9ba2QzaE3UHxQNKisWrh2X11oy0HGqBHlP+7Y8x0k0Xbxk8qUZYv1
	 Nb8ZUij4hPMkCtRVJDjStSJzA1RtmhWsUFO0DQdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael-CY Lee <michael-cy.lee@mediatek.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 113/163] wifi: mac80211: fix non-transmitted BSSID profile search
Date: Tue, 15 Jul 2025 15:13:01 +0200
Message-ID: <20250715130813.386188487@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit e1e6ebf490e55fee1ae573aa443c1d4aea5e4a40 ]

When the non-transmitted BSSID profile is found, immediately return
from the search to not return the wrong profile_len when the profile
is found in a multiple BSSID element that isn't the last one in the
frame.

Fixes: 5023b14cf4df ("mac80211: support profile split between elements")
Reported-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Link: https://patch.msgid.link/20250630154501.f26cd45a0ecd.I28e0525d06e8a99e555707301bca29265cf20dc8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/parse.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 6da39c864f45b..922ea9a6e2412 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -758,7 +758,6 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 {
 	const struct element *elem, *sub;
 	size_t profile_len = 0;
-	bool found = false;
 
 	if (!bss || !bss->transmitted_bss)
 		return profile_len;
@@ -809,15 +808,14 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 					       index[2],
 					       new_bssid);
 			if (ether_addr_equal(new_bssid, bss->bssid)) {
-				found = true;
 				elems->bssid_index_len = index[1];
 				elems->bssid_index = (void *)&index[2];
-				break;
+				return profile_len;
 			}
 		}
 	}
 
-	return found ? profile_len : 0;
+	return 0;
 }
 
 static void
-- 
2.39.5




