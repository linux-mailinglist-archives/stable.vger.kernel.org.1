Return-Path: <stable+bounces-188248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652FBF379F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C251C3A6B75
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179B02D9482;
	Mon, 20 Oct 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CN7Q/bGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704911E492A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992920; cv=none; b=YGmIlR6H6Z0V6M++XGDLBGWO3/7L1M1yrGyDMwsAOHMC2idxQLwHyPhdLTMivR5/ubiQSy2tcizHnqvwkRlBL56P0mHCbGEDx5B/rxpFkU0U/etrX0G+ylqyXAkppZKeBTo5U6Mh7K54C+51FUuUIqRqCSYLR/8e7qbXY6th2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992920; c=relaxed/simple;
	bh=Af8um5FueY9zBxJGpmp/HTFQ2PPJGgRljkNHZPziba0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfpQJgrWc1lhhetPlf+Lbx/9fo/kYGScG0PHk4g9hlNyBJufa1VnHGmucnfGnh5vH8V0zXInG4p+qMFeppjG1vje9NNXBuMrS9zULwgo1oK9CwKJJiqCsn7uuHEr11YR9o34VIt6sc/AWaojbTbTYRB0pk7VCT1Mx2Z/WAqHMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CN7Q/bGr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b593def09e3so3216116a12.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760992914; x=1761597714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFba3r9cx9OeElEIChoC4Sz5sdR56QEVju+DryrMtAA=;
        b=CN7Q/bGr62PzkBsFb/thefniEkBxHd8yMvxyEU6awDAffPWPtF3ShvH5zzc23X1pdm
         q1I5GfEmEuRx5bAG8T0kq03INvrL7EFRtG6ADe72AFO3iYHLrEaNl2QZHTmjeyaVDV4q
         oznd+sD15YEMOPbmHEPj1RB5jZGDd8S4xANi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992914; x=1761597714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFba3r9cx9OeElEIChoC4Sz5sdR56QEVju+DryrMtAA=;
        b=trIxEw5IMJee1O5FfScgtED5CfZCbmfiX/85n2Uews5cV8BHT7PS117v3QeC24CF60
         Cy0F+ZXt5EFgiTu2CD5tfNazkcH1pUS0sYTWw4EGzi/US8ONa79hAo0OqOXxVJGqPgRM
         icNLL4zy8zy9x0YX6MHwY+d2tE3wOYHz16KeJWEiCyGvOXvQYGjgBFCeTw4jO7DwOH7e
         xgTF9/if0Tvt4XuyU1AnB7LBFP1zkcZOxFnmF4DyMMb/AaFekpZktPjbLYgRPFQ6367D
         UdRC+HxTLD/rddZ9qMegpMTMamC6pTTae8IXVRNTO+lWTL+5o5ozH9mU3WfpjcdpDlNz
         SEyA==
X-Gm-Message-State: AOJu0Yzl4VlpAQ+8FsyeP0OBrDCA0e4auWjUHCciYomo2qzPV0ppMBiv
	ONwixp//LxZwzjC2J/TDsXyJx8NBJOvDMwoEat75hXGZBmiHxrZbxKIb00FnyiDdsPK72T3uHcI
	VoVg=
X-Gm-Gg: ASbGnctUf4mSgF+up7im6fjYW8mnZ66aDr4t0EOCAKj5wLhmqKsDZsyWXVUW/aBoKsG
	ECzuvfDOzNkL94JWv0TbFZX/1T4QmLIt9faOGWsCVA1OXacfSzDWSB49v6eImKd7fRej+w+ogaT
	DT/Gwhwjjwh4oAYoIzvRmnBLjwVguFSMwKOBWH/zCeXebItcfG+Zj/QEG14Co0pGNVBbKQnKdUU
	Wm0mjuUt0RwzOlu50ivhacP5Nljze6PRBd4hFGZsHVuHyziT5oTPN8c6VypdtRdnPPTr+y3dGO2
	rU4RT3pqWExJhuGnoaP5i4wbdvZ6SblrW0bb8UySeXjNeFMGuBHSlEvwAb5oavh59MBF6oaaRCA
	QwuBQFhbqU2WRsBQXyLUzAT4iUvrxRTuWoPH8dr5AIfafDrFccBcd6Ll/qolXxKexl0F+7gkbRm
	MO7wK+Sp0GnyJgCAm1uPkcbZ+i/mTEfpDQsc+L
X-Google-Smtp-Source: AGHT+IFGvti6O8y3xfewxBrEJ4pz9VZOfqss6SdE36p3yIPP++ZWTy9K9bYPOpTXEgak/30VTkGz5w==
X-Received: by 2002:a17:902:d60d:b0:270:e595:a440 with SMTP id d9443c01a7336-290c9cd4b48mr168804975ad.25.1760992914257;
        Mon, 20 Oct 2025 13:41:54 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f21:3ecc:2915:f4cb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29246fd92fasm89188605ad.42.2025.10.20.13.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:41:53 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com,
	Brian Norris <briannorris@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 6.6] PCI/sysfs: Ensure devices are powered for config reads (part 2)
Date: Mon, 20 Oct 2025 13:41:36 -0700
Message-ID: <20251020204146.3193844-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

Commit 48991e493507 ("PCI/sysfs: Ensure devices are powered for config
reads") was applied to various linux-stable trees. However, prior to
6.12.y, we do not have commit d2bd39c0456b ("PCI: Store all PCIe
Supported Link Speeds"). Therefore, we also need to apply the change to
max_link_speed_show().

This was pointed out here:

  Re: Patch "PCI/sysfs: Ensure devices are powered for config reads" has been added to the 6.6-stable tree
  https://lore.kernel.org/all/aPEMIreBYZ7yk3cm@google.com/

Original change description follows:

    The "max_link_width", "current_link_speed", "current_link_width",
    "secondary_bus_number", and "subordinate_bus_number" sysfs files all access
    config registers, but they don't check the runtime PM state. If the device
    is in D3cold or a parent bridge is suspended, we may see -EINVAL, bogus
    values, or worse, depending on implementation details.

    Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
    rest of the similar sysfs attributes.

    Notably, "max_link_speed" does not access config registers; it returns a
    cached value since d2bd39c0456b ("PCI: Store all PCIe Supported Link
    Speeds").

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Link: https://lore.kernel.org/all/aPEMIreBYZ7yk3cm@google.com/
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: stable@vger.kernel.org
---
This patch should be applicable to any linux-stable version that has
commit 48991e493507 but not d2bd39c0456b. So far, I believe that's
any linux-stable branch prior to 6.12.y.

I've tested this on 6.6.y.

 drivers/pci/pci-sysfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 449d42744d33..300caafcfa10 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -186,9 +186,15 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%s\n",
+			 pci_speed_string(pcie_get_speed_cap(pdev)));
+	pci_config_pm_runtime_put(pdev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
-- 
2.51.0.869.ge66316f041-goog


