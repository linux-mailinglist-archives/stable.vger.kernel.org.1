Return-Path: <stable+bounces-95395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9429D8908
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9903284C87
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12709171CD;
	Mon, 25 Nov 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McURYnzA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C518E1946B9
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548033; cv=none; b=rdgb+IwbeQY9d5MELrKCJUsuwH24mj27/0CD7B19JjOYpXnskw4WMMTQdRpGA2JrP23stmbm6z2IpVFeebMYTfDdbNPKGvCDCVV/A8IE3MAg9NuHBKMus/tyJuT+emSwqqbjn/Q6Wm+XeABoP5GXtXdYgoe3i6RlwHYjQAngLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548033; c=relaxed/simple;
	bh=bsqxlklufJkLOjTHccrzu0tJywtkJ0I7W6vsooj2upc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbXzONFNaUQYGYeyANlNM6U054ar94DTb4lxtp8h7eKxy3HPU0KTZOqr/1ssF0+KHyMSJMVIailhefgV4ipGysaqmx97jb2Evzvkq/AwSvGL/02Ve4ah0C5LX8cREbxHgFB9Uggc8F/3Vy2gw0GeTkY+KIVB5xF5HBg05Q4csTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McURYnzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AFDC4CECE;
	Mon, 25 Nov 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548033;
	bh=bsqxlklufJkLOjTHccrzu0tJywtkJ0I7W6vsooj2upc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McURYnzAeC3B5Q30rvCad69CVDd3plsgLtrkpNlkvWxK7aWcyyKYLZONu712mjl9L
	 6ym5heMsYojO/um1PVMSB+vOVX88NmOXaY7qW/fyhkK95pRRrFskGFXmowxBl6aece
	 6bB5lPUvjS7jU5t4ANY1jZezFEOoy3JfATu/DFBgsUE6mvw7uHSejm+z7vBwsJhmlm
	 gz3YWk7wCYSKt3uJMiCrfCz28hiyO2FUWk8BZMeLNWkhuZKHno7WDlCghna5WkIRD4
	 d4ByAo/H2+aZSC26qoclagprUNIqAN7yK2OjFVw4yTyPJWn7ksEXog1hj32kCQHRSJ
	 RE8ZBktIKcgOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] wifi: rtw89: avoid to add interface to list twice when SER
Date: Mon, 25 Nov 2024 10:20:31 -0500
Message-ID: <20241125090607-7d2cda3b51b14c0d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125062549.2525431-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 7dd5d2514a8ea58f12096e888b0bd050d7eae20a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Chih-Kang Chang <gary.chang@realtek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 490eddc836b2)
6.6.y | Present (different SHA1: fdc73f2cfbe8)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:01:28.194689912 -0500
+++ /tmp/tmp.TyfXwmOFnq	2024-11-25 09:01:28.189015767 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7dd5d2514a8ea58f12096e888b0bd050d7eae20a ]
+
 If SER L2 occurs during the WoWLAN resume flow, the add interface flow
 is triggered by ieee80211_reconfig(). However, due to
 rtw89_wow_resume() return failure, it will cause the add interface flow
@@ -60,31 +62,33 @@
 Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
 Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
 Link: https://patch.msgid.link/20240731070506.46100-4-pkshih@realtek.com
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  drivers/net/wireless/realtek/rtw89/mac80211.c |  4 +++-
  drivers/net/wireless/realtek/rtw89/util.h     | 18 ++++++++++++++++++
  2 files changed, 21 insertions(+), 1 deletion(-)
 
 diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
-index ed7990a2827b8..48ad0d0f76bff 100644
+index 3a108b13aa59..f7880499aeb0 100644
 --- a/drivers/net/wireless/realtek/rtw89/mac80211.c
 +++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
-@@ -126,7 +126,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
+@@ -105,7 +105,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
+ 
+ 	mutex_lock(&rtwdev->mutex);
  	rtwvif->rtwdev = rtwdev;
- 	rtwvif->roc.state = RTW89_ROC_IDLE;
- 	rtwvif->offchan = false;
 -	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 +	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
 +		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
 +
  	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
- 	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
  	rtw89_leave_ps_mode(rtwdev);
+ 
 diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
-index e82e7df052d88..e669544cafd3f 100644
+index 1ae80b7561da..f9f52b5b63b9 100644
 --- a/drivers/net/wireless/realtek/rtw89/util.h
 +++ b/drivers/net/wireless/realtek/rtw89/util.h
-@@ -16,6 +16,24 @@
+@@ -14,6 +14,24 @@
  #define rtw89_for_each_rtwvif(rtwdev, rtwvif)				       \
  	list_for_each_entry(rtwvif, &(rtwdev)->rtwvifs_list, list)
  
@@ -109,3 +113,6 @@
  /* The result of negative dividend and positive divisor is undefined, but it
   * should be one case of round-down or round-up. So, make it round-down if the
   * result is round-up.
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

