Return-Path: <stable+bounces-89411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318F9B7DA7
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565881C217F0
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6951CB306;
	Thu, 31 Oct 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJv1F8s8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30F1C3308
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386858; cv=none; b=Ij3K0/9aDxsd0jxEJyqpcyQVMFOwfZchL5fmCpp5WOfH48dn3VcImIdrmr/LJq6531/YujWIgtW3VYMQX6GG4OiMIvt0kcTOA5n4vUx2qPfmoEWl8Q0YBcIbvm3bHWNlCHa8NmQodx/qE0j6FL8awaPY5DkTW2c33zF5XHmVr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386858; c=relaxed/simple;
	bh=fvC24w7gj89Nb012evxg+hZIB/Nm64y6FgjqzdxwzQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKQ/ssnyFXlF5gdMj4wPyo3HjV5vov6e3C6TQILEGDN1dVIHtNzTQC3WsavJj+m1Xe4otpMulUFRSeUeVx21GwZioaE4GRY5NNtTjhPwirks2q+wKSJHg6PZxmhGT95mypB4xdGpoPbunr9c3dQHFFgxWbpeRXyCXl3TarOSvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJv1F8s8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d447de11dso883173f8f.1
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386854; x=1730991654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pek064Hz7CIKn8YheYCxRzKFA8nRolzJISWb5PBD7ls=;
        b=gJv1F8s8XZALYcOj9HUWtkVqlgdfoTIWaTgert6zScmpVZ+zAIKfammFIbzC4YrspO
         anPW8tIeFe5Dj51JMrsfJwjYKJHx6zvU3WbZdXcFkSVkqgniGUoeD9xhXYz1EK37bzCE
         K8pRodK2aNAC77QSfVL+4ztG3PQFrQC59iJ5ILJIvDO0caufr0vrLfMNhrIi9APRKufl
         7xt9y8rAORyhi52hY+05gPwHMm346lnZpldCjnZy4JppjkoW9mOQGDRDvkVVuxbc2QQF
         JiUahkVOW+CyH9cVuI7wAMJ38l38Ho5KCyfVaPnvfFv1C9oSAD7jVeoYlT/Utq0wwlXB
         xsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386854; x=1730991654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pek064Hz7CIKn8YheYCxRzKFA8nRolzJISWb5PBD7ls=;
        b=avLjzKIo6QpbQzyh7zA0OFOuWt5vQ5Q7wr2xU3NPhG8atBIUTAUpDyTXjCL04L6y1k
         LkzM7UFHlNSxSMxxT6uelxi287DpzHHvhmB0SbS2SILKTVC4tpdUGEvI+ojoBbFpxBxU
         s4AqS4E0yXdpV/OAvAFSJGLt6h0PmdcfNPIgjcHxhsfPj70MCchmRx4yFGHiOOPmkbzm
         x5lL2S836IvOfPurOvr51IPfBabpAX3igqJfz8QQjsNvNYTeNyP2GyLj7hhzflSd1nRR
         kCNFuIdDfjbrQ0NN6rB8wrdh4DxHr1ys+Pz6NpZ2PB/GwFdZuE6W1oscFCvnl1YZqMlc
         +Ajw==
X-Forwarded-Encrypted: i=1; AJvYcCVsRS0kQqXeSKVYWBgoV6cCJ5Imd8cKa5R3aBeROMYDBCeBYoqBfeLAXRfPKIfFw+BdBonV/3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60ZLTmrJxNE9itz4IkytzzJOMxPc8n158jJW5oYDt4mMgUUHJ
	vAAnyVuSa/1z15MR3p9ALPP5KVXlKb/4vfU7k3zbj5LfuIAEAnrec9plx0pUuUI=
X-Google-Smtp-Source: AGHT+IFW5CC5JRXdKxYGdEgD1gfJan72KWcvXpNH/k/uV7fOOa8gSAbAZdmjlZXVCXNa52l8mJQzTA==
X-Received: by 2002:a05:6000:1a8e:b0:368:37ac:3f95 with SMTP id ffacd0b85a97d-381be7d8f8bmr2977899f8f.31.1730386853121;
        Thu, 31 Oct 2024 08:00:53 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:52 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	ebiggers@kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 12/14] scsi: ufs: exynos: fix hibern8 notify callbacks
Date: Thu, 31 Oct 2024 15:00:31 +0000
Message-ID: <20241031150033.3440894-13-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241031150033.3440894-1-peter.griffin@linaro.org>
References: <20241031150033.3440894-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 of the patch which introduced the ufshcd_vops_hibern8_notify() callback
used a bool instead of an enum. In v2 this was updated to an enum based on
the review feedback in [1].

ufs-exynos hibernate calls have always been broken upstream as it follows
the v1 bool implementation.

Link: https://patchwork.kernel.org/project/linux-scsi/patch/001f01d23994$719997c0$54ccc740$@samsung.com/ [1]
Fixes: 55f4b1f73631 ("scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: stable@vger.kernel.org
---
v3: Added Link tag, and CC stable, and Reviewed-by (Tudor)
---
 drivers/ufs/host/ufs-exynos.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 5078210b2a5c..9b6c4cfd7665 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1526,12 +1526,12 @@ static void exynos_ufs_dev_hw_reset(struct ufs_hba *hba)
 	hci_writel(ufs, 1 << 0, HCI_GPIO_OUT);
 }
 
-static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, u8 enter)
+static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, enum uic_cmd_dme cmd)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 	struct exynos_ufs_uic_attr *attr = ufs->drv_data->uic_attr;
 
-	if (!enter) {
+	if (cmd == UIC_CMD_DME_HIBER_EXIT) {
 		if (ufs->opts & EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL)
 			exynos_ufs_disable_auto_ctrl_hcc(ufs);
 		exynos_ufs_ungate_clks(ufs);
@@ -1559,11 +1559,11 @@ static void exynos_ufs_pre_hibern8(struct ufs_hba *hba, u8 enter)
 	}
 }
 
-static void exynos_ufs_post_hibern8(struct ufs_hba *hba, u8 enter)
+static void exynos_ufs_post_hibern8(struct ufs_hba *hba, enum uic_cmd_dme cmd)
 {
 	struct exynos_ufs *ufs = ufshcd_get_variant(hba);
 
-	if (!enter) {
+	if (cmd == UIC_CMD_DME_HIBER_EXIT) {
 		u32 cur_mode = 0;
 		u32 pwrmode;
 
@@ -1582,7 +1582,7 @@ static void exynos_ufs_post_hibern8(struct ufs_hba *hba, u8 enter)
 
 		if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB))
 			exynos_ufs_establish_connt(ufs);
-	} else {
+	} else if (cmd == UIC_CMD_DME_HIBER_ENTER) {
 		ufs->entry_hibern8_t = ktime_get();
 		exynos_ufs_gate_clks(ufs);
 		if (ufs->opts & EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL)
@@ -1669,15 +1669,15 @@ static int exynos_ufs_pwr_change_notify(struct ufs_hba *hba,
 }
 
 static void exynos_ufs_hibern8_notify(struct ufs_hba *hba,
-				     enum uic_cmd_dme enter,
+				     enum uic_cmd_dme cmd,
 				     enum ufs_notify_change_status notify)
 {
 	switch ((u8)notify) {
 	case PRE_CHANGE:
-		exynos_ufs_pre_hibern8(hba, enter);
+		exynos_ufs_pre_hibern8(hba, cmd);
 		break;
 	case POST_CHANGE:
-		exynos_ufs_post_hibern8(hba, enter);
+		exynos_ufs_post_hibern8(hba, cmd);
 		break;
 	}
 }
-- 
2.47.0.163.g1226f6d8fa-goog


