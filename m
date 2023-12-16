Return-Path: <stable+bounces-6868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE78157E7
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 06:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486AD1C24AE7
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAC125C5;
	Sat, 16 Dec 2023 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leolam.fr header.i=@leolam.fr header.b="VkBOjY4Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D8125B4
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leolam.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leolam.fr
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SsZrr70VwzMqHcp;
	Sat, 16 Dec 2023 05:48:44 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SsZrr2ww1zMpnPd;
	Sat, 16 Dec 2023 06:48:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leolam.fr;
	s=20210220; t=1702705724;
	bh=bhxnAj+GNlj0jTY3y9EzIZ28ReZMSffkEvx/4PBbI2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkBOjY4ZIt3N7mX2Ir1V5fHquw8DK2l3mXFG8vUkpzvTbtQuWB8lnziQJlABg/Imw
	 hKTH+s0O1d9RtEHMlgaLikWE04SzJFYxJjFDEp+awrHCojWqMHIDF4lYCBPAE+J7OG
	 mMGdlT9yA+rvPZmeELCJ34KKhpq22NGPeDjAr+60=
From: =?UTF-8?q?L=C3=A9o=20Lam?= <leo@leolam.fr>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9o=20Lam?= <leo@leolam.fr>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
Date: Sat, 16 Dec 2023 05:47:17 +0000
Message-ID: <20231216054715.7729-4-leo@leolam.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216054715.7729-2-leo@leolam.fr>
References: <20231216054715.7729-2-leo@leolam.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Commit 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use"
backported to 6.6.x) causes nl80211_set_cqm_rssi not to release the
wdev lock in some of the error paths.

Of course, the ensuing deadlock causes userland network managers to
break pretty badly, and on typical systems this also causes lockups on
on suspend, poweroff and reboot. See [1], [2], [3] for example reports.

The upstream commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-range
use"), committed in November 2023, is completely fine because there was
another commit in August 2023 that removed the wdev lock:
see commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex").

The reason things broke in 6.6.5 is that commit 4338058f6009 was applied
without also applying 076fc8775daf.

Commit 076fc8775daf ("wifi: cfg80211: remove wdev mutex") is a rather
large commit; adjusting the error handling (which is what this commit does)
yields a much simpler patch and was tested to work properly.

Fix the deadlock by releasing the lock before returning.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
[2] https://bbs.archlinux.org/viewtopic.php?id=290976
[3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/

Link: https://lore.kernel.org/stable/e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org/
Fixes: 008afb9f3d57 ("wifi: cfg80211: fix CQM for non-range use")
Tested-by: Léo Lam <leo@leolam.fr>
Tested-by: Philip Müller <philm@manjaro.org>
Cc: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Léo Lam <leo@leolam.fr>
---
 net/wireless/nl80211.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6a82dd876f27..0b0dfecedc50 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12906,17 +12906,23 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 					lockdep_is_held(&wdev->mtx));
 
 	/* if already disabled just succeed */
-	if (!n_thresholds && !old)
-		return 0;
+	if (!n_thresholds && !old) {
+		err = 0;
+		goto unlock;
+	}
 
 	if (n_thresholds > 1) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
 					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
-		    !rdev->ops->set_cqm_rssi_range_config)
-			return -EOPNOTSUPP;
+		    !rdev->ops->set_cqm_rssi_range_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
 	} else {
-		if (!rdev->ops->set_cqm_rssi_config)
-			return -EOPNOTSUPP;
+		if (!rdev->ops->set_cqm_rssi_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
 	}
 
 	if (n_thresholds) {
-- 
2.43.0


