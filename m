Return-Path: <stable+bounces-43013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C018BAAE4
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7053F282277
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABD1514D5;
	Fri,  3 May 2024 10:42:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71E2135B
	for <stable@vger.kernel.org>; Fri,  3 May 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732941; cv=none; b=tcBVR9CtO9CUGwQNJySKpQQJalBNMDYd3y1UeYm2ECqhB1WDlY12D47jH7p3puHHqBkg5121P/HcByr6j3rd8LjyhX60vfkX41+2sUvrSbynl03S2IgvMmmBsHxgPSZO1wnkwdZof7MHdZ0N3hQ61ex3T+cG5NYruJWFBL7io2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732941; c=relaxed/simple;
	bh=NLoL6Ucm17znsTU3edDxTaGti9e8iCzmg1SM/AhUbGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOdYihHJN7SYAbGePhUWTqfJo+mibrL1Ezkoro7JAm5VSc7n4zksSaE2uxFw+O1ndGQR1pbyo+UHLlOwl5qckcrvxdqr658O6mRkal7YRAoG30uY2Gdd+Difc1nkeiYEq+PVHYSGmvTh/OzsKTnOsOq45g3eP2Hco0NzKICSf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 647512F20236; Fri,  3 May 2024 10:35:54 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id 231BD2F2021D;
	Fri,  3 May 2024 10:35:54 +0000 (UTC)
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
	syzbot+999fac712d84878a7379@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 5.10] wifi: mac80211: check for station first in client probe
Date: Fri,  3 May 2024 13:35:42 +0300
Message-ID: <20240503103542.2347287-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 67dfa589aa8806c7959cbca2f4613b8d41c75a06 ]

When probing a client, first check if we have it, and then
check for the channel context, otherwise you can trigger
the warning there easily by probing when the AP isn't even
started yet. Since a client existing means the AP is also
operating, we can then keep the warning.

Also simplify the moved code a bit.

Reported-by: syzbot+999fac712d84878a7379@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Cc: stable@vger.kernel.org
---
 net/mac80211/cfg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45bb6f27559877..8aef97b92c5213 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3642,19 +3642,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	qos = sta->sta.wme;
+
 	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 	band = chanctx_conf->def.chan->band;
-	sta = sta_info_get_bss(sdata, peer);
-	if (sta) {
-		qos = sta->sta.wme;
-	} else {
-		ret = -ENOLINK;
-		goto unlock;
-	}
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.42.1


