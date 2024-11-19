Return-Path: <stable+bounces-93913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CC9D1F61
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776BF1F2292F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8514D6ED;
	Tue, 19 Nov 2024 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv/KtGZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FA149C57
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991007; cv=none; b=b8bgcj/3+mvLFpCxMMvp8eqCZe/OKj792AY4mqKxgCmqYP8R+Ifj+LjLBDs7AZi2UpwLleVl0I7r2tRyRHM+E5rYW08T7iYBVBsTYgK1qWgR0vReDJNO0BmEfWEh4h8ZoYEV1ynSQ46z25XVuayZgvxsfnY6wwGgVcEQt/T2vAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991007; c=relaxed/simple;
	bh=Xtd27Am7E+7ycIc10cdKTAFak4/ehuye4vGhLJAA6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oT8+QWJ2OyMxYHobNGU8bbQYbVnfpBtqOI5CTMsmzakbgSJDLXkCRc6/7zlewZL7tvByKa8JuQN1L39n5to8UTKyebyLMCWGbk6BZVTXkZGjG3OPdj2jCbM+O4mBw4mUq0hyFz3lZmBhngpRCFIzclNxo9fWdyvOTAcj3X15MlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv/KtGZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0592DC4CED2;
	Tue, 19 Nov 2024 04:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991007;
	bh=Xtd27Am7E+7ycIc10cdKTAFak4/ehuye4vGhLJAA6PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lv/KtGZbvaEdKTBIZBKzVvK+IoKpA+RMunXtIh39u4noV2BFeT//MAB8gi/RZcBo8
	 ivlKQLa5B9AFKNmCnLu5/EyzgfQx8DHh/pkoWBXFuyLAiPDwRj98ZlIEcCKiymC8R+
	 4lPUQRRaRQ25eijlEHrqkSPz8P1MjIU0PkSsm9Cd/NiudHwCrHkRaV+dJCoWBYY6lo
	 dzpwTRVn/qn7QnMbCPskROIzL1kZ+uchO+C7i/tgrnJmj1beATCb39BQFspOYIqQpX
	 NSofuPVo0Fd3JLeNTH/1JWIcztp7QVPn1I9+e/bSLUSxoJi6hsl0WGznIR2Vk1NI22
	 WsUjukDo7D0BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] wifi: rtw89: fix null pointer access when abort scan
Date: Mon, 18 Nov 2024 23:36:45 -0500
Message-ID: <20241118032551.298969-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118032551.298969-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 7e11a2966f51695c0af0b1f976a32d64dee243b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Po-Hao Huang <phhuang@realtek.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: b34d64e9aa55)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 17:23:03.622084195 -0500
+++ /tmp/tmp.60YCJ78a5r	2024-11-18 17:23:03.614228530 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7e11a2966f51695c0af0b1f976a32d64dee243b2 ]
+
 During cancel scan we might use vif that weren't scanning.
 Fix this by using the actual scanning vif.
 
@@ -5,15 +7,18 @@
 Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
 Signed-off-by: Kalle Valo <kvalo@kernel.org>
 Link: https://msgid.link/20240119081501.25223-6-pkshih@realtek.com
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu:  Bp to fix CVE: CVE-2024-35946 resolved minor conflicts]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
+ drivers/net/wireless/realtek/rtw89/mac80211.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
-index 21b42984fd8a4..b61c5be8cae3c 100644
+index 3a108b13aa59..4909de5cd0ea 100644
 --- a/drivers/net/wireless/realtek/rtw89/mac80211.c
 +++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
-@@ -441,7 +441,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
+@@ -381,7 +381,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
  			 * when disconnected by peer
  			 */
  			if (rtwdev->scanning)
@@ -22,12 +27,6 @@
  		}
  	}
  
-@@ -994,7 +994,7 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
- 	}
- 
- 	if (rtwdev->scanning)
--		rtw89_hw_scan_abort(rtwdev, vif);
-+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
- 
- 	if (type == IEEE80211_ROC_TYPE_MGMT_TX)
- 		roc->state = RTW89_ROC_MGMT;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

