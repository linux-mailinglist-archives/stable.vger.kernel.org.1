Return-Path: <stable+bounces-37769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87C89C6EC
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC5528274C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76A126F08;
	Mon,  8 Apr 2024 14:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E38127B66
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586189; cv=none; b=ntXfka0p6Kap8uu0uuSqHliW4j9DI2vbp+r7Y+ZI7mluVe/emwXGzuclYG45IxIEI4qMT8ofG8Ni5z6Wbgzuo9SwZ0hubeWEl9Wsrjrtr4ZYGwrXDLzPhVHYlM5Ti6MiSHpuGfPtKtusCBFX22xfSgSsO52Bsbgg+4Vyuy+7dP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586189; c=relaxed/simple;
	bh=LtxY8Logg+741iXply/AAe9hD9s2xXch7nOHroPgjJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ro4lWYu+8W1gbdufbmHFWRbwqmaLxFD3jqAVa10oheZoBKN89xNzHoIFcEa13jyLFX43YT2jmbjJBi9aBz/NBxBppP7hnakv2RN7EpHfs4gDM5m4w28hh+q1xl1k9ykOAOGiKbJ8YZKS548CfbNB9zfU/zlpF2XRFh+AlhfqofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 391972F2024E; Mon,  8 Apr 2024 14:23:05 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 5D9C12F20254;
	Mon,  8 Apr 2024 14:23:01 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 6.1] wifi: mac80211: avoid lockdep checking when removing deflink
Date: Mon,  8 Apr 2024 17:22:51 +0300
Message-ID: <20240408142251.1850102-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit b8b80770b26c4591f20f1cde3328e5f1489c4488 ]

struct sta_info may be removed without holding sta_mtx if it has not
yet been inserted. To support this, only assert that the lock is held
for links other than the deflink.

This fixes lockdep issues that may be triggered in error cases.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230619161906.cdd81377dea0.If5a6734b4b85608a2275a09b4f99b5564d82997f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/mac80211/sta_info.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd56015b29258..edec857edbd25 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -357,8 +357,9 @@ static void sta_remove_link(struct sta_info *sta, unsigned int link_id,
 	struct sta_link_alloc *alloc = NULL;
 	struct link_sta_info *link_sta;
 
-	link_sta = rcu_dereference_protected(sta->link[link_id],
-					     lockdep_is_held(&sta->local->sta_mtx));
+	link_sta = rcu_access_pointer(sta->link[link_id]);
+	if (link_sta != &sta->deflink)
+		lockdep_assert_held(&sta->local->sta_mtx);
 
 	if (WARN_ON(!link_sta))
 		return;
-- 
2.42.1


