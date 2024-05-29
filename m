Return-Path: <stable+bounces-47637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021498D35EF
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 14:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5BB22FF4
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9D180A80;
	Wed, 29 May 2024 12:03:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FE180A65
	for <stable@vger.kernel.org>; Wed, 29 May 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984190; cv=none; b=L638oQ6DPxp7ALpkqZTKVrFfdokEmpGzzSn4BGk+rU/vD9ltUZj3VwbuxdWCLVBcGqO24EY83L1RBzM2BhWq2uE0tkX+fNwDVjz9K/5cbm7KACh3TLHzRl1cjHwwm07GHBecWDiELVeDV3PapCG2kfCRm6WJFfST0cmB6a4ZUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984190; c=relaxed/simple;
	bh=FUgdQZEaXu0MCotYhA3f84CvYdTnkmhhti3ID8skutI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nodn+P07WTcweqdkFbY9euc4mwmN+HHD/o69pUNKV9N/Hi51R7KP/slE4T387udq0wy4hrXfxAK9NaMS/iTLgT/6siZ9hQas/AOdMA9kqVMSY0Lm30Qc2glpHiiXKkfjlYye9IjJCX9bvmghNVx5mxZcA0e4AkHMsh1MGFx99Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 922222F2023E; Wed, 29 May 2024 11:56:28 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id E740E2F2023C;
	Wed, 29 May 2024 11:56:27 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	gregkh@linuxfoundation.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	stable@vger.kernel.org,
	syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1] wifi: mac80211: apply mcast rate only if interface is up
Date: Wed, 29 May 2024 14:56:02 +0300
Message-ID: <20240529115602.4068459-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the interface isn't enabled, don't apply multicast
rate changes immediately.

Reported-by: syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1e57027da2913..2c60fc165801c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2838,8 +2838,9 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-					  BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
-- 
2.42.1


