Return-Path: <stable+bounces-183237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44073BB74F5
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE614E9C5C
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF62848BB;
	Fri,  3 Oct 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUNBv/uq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB355284670
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504810; cv=none; b=dCKD5ZhJCo4pxEG0ZnSDxeSWVQCwrJE7TRyVY0jfUgPOtQEv4elQ6NG7VcdlpZcSVEfdS8r7NgN5C9r29+sKGwzqThgNA9joXXWs0RjlgXEFY0skbxek554oNI/FnFshQZz7JPcuoIZDcVsU1zfp31JnohbSwovLu3T+YeIe9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504810; c=relaxed/simple;
	bh=IpAFTubAVXYPQLJ+5YyMrifJUtVWBC4sXuvqGgFQJn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlLOfMRZvGxLSZeGQFGIKxVlGYyKgc0RtedxBe55cRdM5woF/e+bAmFvGP1yMO5QnQhEQSzVSHoAVzv2z23pybtLfjQ3LwPmJbrJNDwyu+eZ4pmdqhNNwjdhxdIaGiUui0I2dAbUMXuJZ2/zuqZC3TN9U2jIVRG5BVu1WrOaw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUNBv/uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9415C4CEF5;
	Fri,  3 Oct 2025 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759504808;
	bh=IpAFTubAVXYPQLJ+5YyMrifJUtVWBC4sXuvqGgFQJn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUNBv/uqGV2z9q5mTZq+ly7a7UU7zl7J4lXSlaK61Bk3Xgi2UVFKeZSK1mkbYLXBv
	 D0N/XCDn0EP7djVlmENm3+lH9iUQCstlRaoBCXawWsE/vP1aehbBqWQF03h38sHR5L
	 Uph4rs0HpOUCIQKA7XUD3AMpxbGveRdrNtGHSrC6/21g7+FG4+9IuvQC0NLEzm1lQt
	 f8TOqrBLgVx1BDJ1t3rWp2HLmU0pIQbBQnZD4sjcaioFTVzPsLXNhUO7jmRCaYV8ui
	 WlJho269UtxrDiBrNb2LR4R5g4es2vbOwQ81FN2HHKynn8Z/5BG8WgIVmLdXDao0FU
	 KOaQynR3xEszA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chih-Kang Chang <gary.chang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] wifi: rtw89: mcc: stop TX during MCC prepare
Date: Fri,  3 Oct 2025 11:20:04 -0400
Message-ID: <20251003152005.3176758-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100340-dwelling-engross-0738@gregkh>
References: <2025100340-dwelling-engross-0738@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chih-Kang Chang <gary.chang@realtek.com>

[ Upstream commit 182c7ff8b87e4edbb2227ede39ae0952da7a0f4a ]

Stop TX during the MCC configuration period to prevent packet leakage.
The stop time is defined as 'start_tsf - tsf', which means the duration
from when MCC configuration begins until MCC starts.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250610130034.14692-6-pkshih@realtek.com
Stable-dep-of: 3e31a6bc0731 ("wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 35 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |  2 ++
 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index b18019b53181c..17daf93fec0a4 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1595,6 +1595,35 @@ static bool rtw89_mcc_duration_decision_on_bt(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						mcc_prepare_done_work.work);
+
+	lockdep_assert_wiphy(wiphy);
+
+	ieee80211_wake_queues(rtwdev->hw);
+}
+
+static void rtw89_mcc_prepare(struct rtw89_dev *rtwdev, bool start)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_config *config = &mcc->config;
+
+	if (start) {
+		ieee80211_stop_queues(rtwdev->hw);
+
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work,
+					 usecs_to_jiffies(config->prepare_delay));
+	} else {
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work, 0);
+		wiphy_delayed_work_flush(rtwdev->hw->wiphy,
+					 &rtwdev->mcc_prepare_done_work);
+	}
+}
+
 static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1630,6 +1659,8 @@ static int rtw89_mcc_fill_start_tsf(struct rtw89_dev *rtwdev)
 
 	config->start_tsf = start_tsf;
 	config->start_tsf_in_aux_domain = tsf_aux + start_tsf - tsf;
+	config->prepare_delay = start_tsf - tsf;
+
 	return 0;
 }
 
@@ -2219,6 +2250,8 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_START);
 
 	rtw89_mcc_start_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, true);
 	return 0;
 }
 
@@ -2307,6 +2340,8 @@ static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
 	rtw89_chanctx_notify(rtwdev, RTW89_CHANCTX_STATE_MCC_STOP);
 
 	rtw89_mcc_stop_beacon_noa(rtwdev);
+
+	rtw89_mcc_prepare(rtwdev, false);
 }
 
 static int rtw89_mcc_update(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 2a25563593af9..be998fdd8724b 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -129,6 +129,8 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 #define rtw89_mgnt_chan_get(rtwdev, link_index) \
 	__rtw89_mgnt_chan_get(rtwdev, __func__, link_index)
 
+void rtw89_mcc_prepare_done_work(struct wiphy *wiphy, struct wiphy_work *work);
+
 int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 			  struct ieee80211_chanctx_conf *ctx);
 void rtw89_chanctx_ops_remove(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 894ab7ab94ccb..0e4d5679e426c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4816,6 +4816,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_bt_devinfo_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_rfk_chk_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->cfo_track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->mcc_prepare_done_work);
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->antdiv_work);
 
@@ -5042,6 +5043,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	wiphy_delayed_work_init(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
 	wiphy_delayed_work_init(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
 	wiphy_delayed_work_init(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	wiphy_delayed_work_init(&rtwdev->mcc_prepare_done_work, rtw89_mcc_prepare_done_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
 	wiphy_delayed_work_init(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1c8f3b9b7c4c6..f505fe6da4a24 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5728,6 +5728,7 @@ struct rtw89_mcc_config {
 	struct rtw89_mcc_sync sync;
 	u64 start_tsf;
 	u64 start_tsf_in_aux_domain;
+	u64 prepare_delay;
 	u16 mcc_interval; /* TU */
 	u16 beacon_offset; /* TU */
 };
@@ -5858,6 +5859,7 @@ struct rtw89_dev {
 	struct wiphy_delayed_work coex_bt_devinfo_work;
 	struct wiphy_delayed_work coex_rfk_chk_work;
 	struct wiphy_delayed_work cfo_track_work;
+	struct wiphy_delayed_work mcc_prepare_done_work;
 	struct delayed_work forbid_ba_work;
 	struct wiphy_delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
-- 
2.51.0


