Return-Path: <stable+bounces-9003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEF8205CA
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798C41F2354F
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14838487;
	Sat, 30 Dec 2023 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b0cCv0YY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71579C2;
	Sat, 30 Dec 2023 12:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00269C433C8;
	Sat, 30 Dec 2023 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938321;
	bh=G90VcqE/vmcUvZinbNW/lkORQ3W8ZRIPCbc5NDHhAGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0cCv0YYixuClpbqhxrwvpLrM4LW3Ub+6zORgcN7EiQTa6+Q/n/r4eoZJFfuJvr0F
	 sLdvjyIG+69SQ1QT+7yttpdv+6fLCdGFJcEM8KywysGUHojE0IVVKWpBwUjeI/TTdi
	 Mz1FD7ouY0WRSdVRAgFq1/Enn4OgrFSJLk91/odo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?L=E9o=20Lam?= <leo@leolam.fr>,
	=?UTF-8?q?Philip=20M=FCller?= <philm@manjaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 112/112] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
Date: Sat, 30 Dec 2023 12:00:25 +0000
Message-ID: <20231230115810.342302151@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "L�o Lam" <leo@leolam.fr>

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
Tested-by: "L�o Lam" <leo@leolam.fr>
Tested-by: "Philip M�ller" <philm@manjaro.org>
Cc: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: "L�o Lam" <leo@leolam.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12656,17 +12656,23 @@ static int nl80211_set_cqm_rssi(struct g
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



