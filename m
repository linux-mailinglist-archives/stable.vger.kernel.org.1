Return-Path: <stable+bounces-181620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B8B9AEEA
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C6E1B27F58
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5903148D5;
	Wed, 24 Sep 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ejo8DnM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535D307AEB
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733049; cv=none; b=L6s7dbVqjfplSdGqp+xHXEEAybAF2qeit1UupH83Rtjnim02ZFLOkyDGrYmgQ4bd68dqwhazIAbd3mfK9zyM+ZVWSCSwaHNqEtl7kt8Jq+tqbQMD2p+rdMVXef5sC1gY+exASZBSe/Z/11xKBYMN4D2u/QSJsqKVZTTEsbf6aA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733049; c=relaxed/simple;
	bh=tPg4Wqz8J2TompQpzQza/5UmS8Zm70sbPvTEcMI6BDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsEslXqMfhSumxs7GP4ZcRtYx33PMCbiXhgY2uVPcncaw6NBMHvTW0SbuKGKqoiBf178pKGC4BlhAZSUK4gBYaZHNol3qatoGggGq7PeoXueW5umgL2PLmLKMnA2qXwzujNjHwr73cjVv6mmUxPBZLG2+rzfcYtrson5Gj9fPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ejo8DnM3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f198bd8eeso37833b3a.3
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758733047; x=1759337847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7w7BZfusfh40TgUumBQVrwOU9Hw6Y9fKIpILWJTmpI=;
        b=Ejo8DnM3kav7ByBkn3OXAdhFpXyC3Cdwo1tBD3NLsbxCprYwu36tZ6bcmMNBDKRe8X
         17NwpQ6yXn0U8HM+UG1D/FjL27nQ9gpUCvxpQxVyt/koee3pfix4asxuG3spdJ03HPr+
         AbHfXGURHM0/SYnLsdEH+yn5DdtyPRlkCndbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733047; x=1759337847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7w7BZfusfh40TgUumBQVrwOU9Hw6Y9fKIpILWJTmpI=;
        b=X/eddYxTQS0ErGa1WYsQcjKX10amAMKyCIRKQKQJyW9SIJj+Og1+ha+kn6mKz075UQ
         VwOUlxyONiTd2NTSqJiEfBvXkk7WkEbI6ihMlvkY6GsDKag5Xj+dNhbp85RHtWpcJJf1
         shd7HzoTuc1XHrBDNE3gI5Npig9rBhvx6C1WoapsKBQCmMFkuGpepdmud1r+Z4JBZY9/
         EXaLolvI4QZMn81c/wT31xpXiti3a9Pkxz/oUCyEsTz5Gpw127z7ZgOwad1awj8nta+M
         W6/s7IEPXfW6167fhqAFBIrA2tBPIq08A89wvrtzesUGF5PhtzbYN7PcGHtz8bH3F1N9
         BSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbRPZOL7U7FwsXFIN8tpEC72hwONIi1z2scgMLufDhIWNFDgI84p3lMdQGWtvXX7bBi/7ICDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUgDdL1bTjGAsFZcZktZD/w1JsNDmBiVCM839teQSaJab7Bpe
	lehcBETbJn/uEYIDnZXUZ5QNi/l5EOYWMZX91USTEjFyMSNFgufZVt3b0xc6h/pU1A==
X-Gm-Gg: ASbGncsqSubRfZ7TNA5r+jgr9va3UvmK3cf2hWUoMg3u+bedr6blIUyLYB9+qDIGU1T
	Fp9wKJsyVc6BIA1LMOm+Wk7K7fT0HHsTAl2Xt2QlPuuAvhjiuLAxA+bAYGgRFbW5pLptKVZi9//
	z3P0VEJHdLXIFdZO5m9IeFyZilOroTq9d9Ec8ieHTsfSgTyXMI0vK8THotC8TeRi1TZpcSEXk7X
	pt8Cp1n0uFU300U84RrY+hA970OmVs70tmee3dINJbKjn8FBC09w/ijRlnr2sK4it49tWH1IEUA
	+C+5v22Cvtp6ycGzBDNwl+f8gk06fO4mveTENPqEHg//YjLQAVd4eecUCouhIncrdub9VtzOaoE
	x/8T05EG6ss4D1ihfcHzAhE+c82bYYXUxmUxCkyZ9A2KQXlP8MO1z9boMtpUm
X-Google-Smtp-Source: AGHT+IGx9dCGSc8hHfADXStah33h7Nc5K9qEOotJoi6vkmLXbBDnOjcgbEXkXllnVBgpY/TI8WgxrA==
X-Received: by 2002:a05:6a00:8703:b0:77f:3a99:77b1 with SMTP id d2e1a72fcca58-780fce13c75mr503942b3a.9.1758733046668;
        Wed, 24 Sep 2025 09:57:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77e0bb98790sm16815959b3a.9.2025.09.24.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:57:26 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ethan Zhao <etzhao1900@gmail.com>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/sysfs: Ensure devices are powered for config reads
Date: Wed, 24 Sep 2025 09:57:11 -0700
Message-ID: <20250924095711.v2.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

max_link_width, current_link_speed, current_link_width,
secondary_bus_number, and subordinate_bus_number all access config
registers, but they don't check the runtime PM state. If the device is
in D3cold or a parent bridge is suspended, we may see -EINVAL, bogus
values, or worse, depending on implementation details.

Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
rest of the similar sysfs attributes.

Notably, max_link_speed does not access config registers; it returns a
cached value [1]. So it needs no changes.

[1] Caching was added to pcie_get_speed_cap() in v6.13 via commit
    d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds").

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Don't touch max_link_speed; it's cached, so we don't actually touch
   the hardware
 * Improve commit message

 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f28fdf6dfa02..af74cf02bb90 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -209,8 +209,14 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -222,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -239,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -255,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -271,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
-- 
2.51.0.536.g15c5d4f767-goog


