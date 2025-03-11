Return-Path: <stable+bounces-123160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5CA5BA81
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D76188A6A6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9C1DE894;
	Tue, 11 Mar 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+/yG6hT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7D22173C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680609; cv=none; b=At7+ZsCvDNmcDgyChc9RxZtZVuS1vPPICLBV15QSjEEEHLFbnUfRxBoHxpRhrKHmvVmBNuzm2ofT8yw+vaPtUotYLZ4jzPkkFKm/lmLzKQoFT7e5DObSrc0Xwrws0mgM4l6ji7UoEfv/bgUBP3eZy0OEEToNcKWrkAhAJImxNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680609; c=relaxed/simple;
	bh=A2bmrO8EuDqymvMm66rInn1nh/z46Lv2Wqd+7m1TZtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/FTW5pe/U3MIcpJndLzD6jJAy0Mak3Zh7Ppzm3t91QQiK+PgM62tlr1bLaRIgPnxIcDwVsNRRMfm/rQ1kbb8c7kyXUghdBRwVoVyC2oILqEbdKPPCPlcWoUHefAcF5yX7XD3m9RLpg0vweKFHOR0PNKToQvUeugavWmtmxEZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+/yG6hT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224019ad9edso116114325ad.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680607; x=1742285407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4vq5Tgd1Pw9arABzt0f/jMLyV7wEPcBk8BuG05+h7w=;
        b=j+/yG6hTUc4ci2nKlq+tQDdHEiztocEDqWiOnf65zFPFqZ9cy1gSz8UwVsQJ1cMVNX
         +qfmdlGZf5/LQrNa8CPPFhAKWxW+y7/FPQszq6KqWn9qbIkk502qhfKVa3Y0LhqHouZg
         j9Y+LD4OhIUxuRuRFdU8LfsuI8wbjlyIfJHRytYZ/R+HCKQwNmViY1DkNR2UW2b7iNZl
         6+0QBIWn4nxJyw4LCGVPOi4tpmviTgKMCrpB5A0/VeEfMoRnNOF47ICTQ8dAFeyM7UVZ
         vO0Mb1hiUvAJ3rmMwbMC140+0iFKZZqlxjibHX+q0sznWOI96bQM5Kut5T27jDE+ZD0A
         +hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680607; x=1742285407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4vq5Tgd1Pw9arABzt0f/jMLyV7wEPcBk8BuG05+h7w=;
        b=vMsis1MLaFEK8MyA8tUfSi++BUZ5k7NuKtzJ+tBQ9h1h2KvxdkIYitYEcZYz6oZ4Tj
         vRkiVv8ae0khjRrEQGDxnNe85M0wLduN3SeqDVTRLzbA4qLgtpRNXEhRRCLJgvaeFita
         qBfddlipRMMPmc50pEdsMRNuLxEDKGpy8MekKcttZEWH1wdHbgNR5ZXB8XpK203WFDYz
         F4a6P8m11g+xf54as8LLftEVihtVlAQr/HONrm3jKox+q1pC/cjleYn9RGaaNjveS7zV
         SPqz51u0o3uvtFu1clRLayPzalt59VUGx285pgKHjdXjsOo68of8ddRiJE3Po7Jwv5HP
         Ke+g==
X-Gm-Message-State: AOJu0YzExTNgj6gRLJtLgm6zpjKIoc/rUKN0gbsb0CgYOwzyexHLk99l
	Sv8N7mPYGj6NIdDJNugIakRdjX1c3BvJKhQ3+EaVpXgS9WW9mGkdMRKdyhTz
X-Gm-Gg: ASbGncv95zFCUBNU5f4F2CFjKX/2nB4zhTHnhnKUloS49irxmsiAaAqLX1hc9klW0GF
	nfss3vO0rtmNEy681EwdxtceAQkJAcH+rh/t10gYVcwCyht5N4dJ7/Hvn5DhNQ/iKlZJYDSYVg5
	P8uHJpzuEjMKsMdFJNQC4CdnPnkHzWUIFTTUixrz/fQoK1GykurM6htm9Bwvad6k8mD8l1D3sR0
	2hZkZkl5j3l9RJKmcDM7b2QFEk0r4Rz/jDGljaHdiYluJFUB2PwNNPf/PWlmC9ABzWZA1dTEgSh
	/3F1O22yBv+HO1yBfO/flZZK5go8lj8rbzDb4YbAM17JdvWrtiYFh9YabCSaQ114xoGsAu+ku8R
	dtLQ6Xgex4LrLyj783P8=
X-Google-Smtp-Source: AGHT+IHmOCdl/IUsEco8gV0nfSgoCCIaQBH65o+sxr56pq4vRh0zJUJ1dyddRQaXu8DiqISt8Zddxw==
X-Received: by 2002:a17:903:8c6:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-22428ad49f1mr251766075ad.50.1741680606593;
        Tue, 11 Mar 2025 01:10:06 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-736aa133828sm8191037b3a.1.2025.03.11.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:10:06 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called after probe complete
Date: Tue, 11 Mar 2025 16:10:00 +0800
Message-ID: <20250311081001.1394-2-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311081001.1394-1-zenmchen@gmail.com>
References: <20250311081001.1394-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1 ]

At probe stage, we only do partial initialization to enable ability to
download firmware and read capabilities. After that, we use this pre_deinit
to disable HCI to save power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231110012319.12727-4-pkshih@realtek.com
[ Zenm: minor fix to make it apply on 6.6.y ]
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 ++
 drivers/net/wireless/realtek/rtw89/core.h | 6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 535393eca..d1d8fd812 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3807,6 +3807,8 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 	rtw89_core_setup_phycap(rtwdev);
 	rtw89_core_setup_rfe_parms(rtwdev);
 
+	rtw89_hci_mac_pre_deinit(rtwdev);
+
 	rtw89_mac_pwr_off(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ee6ae2a0c..16aad0f83 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2989,6 +2989,7 @@ struct rtw89_hci_ops {
 	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
 	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_pre_deinit)(struct rtw89_dev *rtwdev);
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
 	int (*deinit)(struct rtw89_dev *rtwdev);
 
@@ -4515,6 +4516,11 @@ static inline void rtw89_hci_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 	return rtwdev->hci.ops->tx_kick_off(rtwdev, txch);
 }
 
+static inline int rtw89_hci_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.ops->mac_pre_deinit(rtwdev);
+}
+
 static inline void rtw89_hci_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
 					  bool drop)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 98af64444..658ab61e3 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2568,6 +2568,13 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -3812,6 +3819,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.write32	= rtw89_pci_ops_write32,
 
 	.mac_pre_init	= rtw89_pci_ops_mac_pre_init,
+	.mac_pre_deinit	= rtw89_pci_ops_mac_pre_deinit,
 	.mac_post_init	= rtw89_pci_ops_mac_post_init,
 	.deinit		= rtw89_pci_ops_deinit,
 
-- 
2.48.1


