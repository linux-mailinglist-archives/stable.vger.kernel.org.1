Return-Path: <stable+bounces-178355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC3CB47E54
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2263C184C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18151B4247;
	Sun,  7 Sep 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bdimp0Ty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE461F09BF;
	Sun,  7 Sep 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276572; cv=none; b=AqVQIWdElg9j049oSS/2Z2TDBOMgqC1gIrxxWBtYDVHsf63IoC2SmFDvZFj3AjfNBU8CdHvFGCxPUAioy2g1Kdq8waFwfJxSaXGWRv8KWUULg387DxWE5MnCYphWAI7Zqt10Ro0Sj10fJpDgXxGZJMvwzNZ72yGKxffKc1XvvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276572; c=relaxed/simple;
	bh=OpTleShsZYroUx3quEKgoW7eJ72DXP9lW0msH4oYJbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toGkSxesNs2wpotEC9L+Ox8wGV4z32GbXJVvfoFtt7yScznpSQoHpOjvmRvNGsbvVgWHChMUVgpCiQKQ79HQqQ9AMavqwRuUmB6N/uraa3S1X1azL96goedVZODu2VZ80T0JNelQmKITYHKUxmSjsqDZcMXGDWuHXAvBZN92PEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bdimp0Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185FDC4CEF0;
	Sun,  7 Sep 2025 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276572;
	bh=OpTleShsZYroUx3quEKgoW7eJ72DXP9lW0msH4oYJbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bdimp0TyX61ynC5yYjUSPT/ocHva+jewgofNmwqEaDrnUDZG19JpHQhe3s7uf5ha4
	 hZ0oVVEouvw1Mn7Md8dNb8ttX0P+YPvtt7zFjS4qJB3xNjOsEbElNTTMnU9K7WeUaQ
	 3R5WWHwSk/C7fxbl4rlTI2BON/N3tIhikCnWa/wE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/121] wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()
Date: Sun,  7 Sep 2025 21:57:56 +0200
Message-ID: <20250907195610.854592407@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 62b635dcd69c4fde7ce1de4992d71420a37e51e3 ]

If the ssid->datalen is more than IEEE80211_MAX_SSID_LEN (32) it would
lead to memory corruption so add some bounds checking.

Fixes: c38c70185101 ("wifi: cfg80211: Set SSID if it is not already set")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/0aaaae4a3ed37c6252363c34ae4904b1604e8e32.1756456951.git.dan.carpenter@linaro.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/sme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 70881782c25c6..5904c869085c8 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -915,13 +915,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!wdev->u.client.ssid_len) {
 		rcu_read_lock();
 		for_each_valid_link(cr, link) {
+			u32 ssid_len;
+
 			ssid = ieee80211_bss_get_elem(cr->links[link].bss,
 						      WLAN_EID_SSID);
 
 			if (!ssid || !ssid->datalen)
 				continue;
 
-			memcpy(wdev->u.client.ssid, ssid->data, ssid->datalen);
+			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
+			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
 			wdev->u.client.ssid_len = ssid->datalen;
 			break;
 		}
-- 
2.50.1




