Return-Path: <stable+bounces-89410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A265C9B7D89
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5803A1F21DDA
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C21B5ED8;
	Thu, 31 Oct 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwsHdhjI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE11A705C
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386846; cv=none; b=rHLJAC+E5oIGmu8d02OAsN/zwYu5sJk/kxKLxGZbBI3A7n2KqCpLmoOg0KiJa0iGnHFvzvuJ2wJdKO0sT9AfYwJMKrADLG/JfubKK/ICJ4rXEllcqeVJFnuXIvM2dc7NgD/6CdRVo1cXF6WOuqAVoHZXv/wdSFQpVxHTwj53nuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386846; c=relaxed/simple;
	bh=xDtKwqvnqxZAQP4VrzospgjmeLcn8uf+9e8SZLyCgpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxbuLEkiNvtN36xfT+zK6nHjoEHKJ+EHST5XEGpZ/xJgvdKANqRnlBwvD6q2xINYmMwI+6Hm3F8DVYp7H5HfZs6nePdvQc3v8UiM3t6vh6HSA2unlE2tjcbtRcgPaOWJmSI8j9ueNwi8M3N4Jz0KL+EAIze7jMm/2mtxCbRbs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RwsHdhjI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4319399a411so9004005e9.2
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386842; x=1730991642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usrOkYEIhJMHpNEH11NB+5bvhSO9JoP7forJzaG92bc=;
        b=RwsHdhjIExPULOr8gokrXIL6m3DfiFvnZ/FHMDuA7Z3LVFvC/7zrMMeVVViBi8ieoK
         9UcN7MsodWT0pitCRrwixcwafmaVdBFeN3OAj8CMvueOI62BF/32KUoyVM312Y6A+dH4
         7jkTLib2OkQV15e894FzYUdqpfx9fF799RPdKQJ/gK3ZTl824CdGiJoM3dnCvYnj3L1D
         TKuw4CCmzsfSw/Riw55VZBRhQxN92Dr1LzJ9JxnHwsfZLpz6r4GcwE1A3a6szUoUxPDv
         dhhcMjs0HBgZUpcpRKWV6A4n99uFnfFt2ofLu7NC0Z4O+62zlUYVbjrCLb9T9bXXl5Md
         9RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386842; x=1730991642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usrOkYEIhJMHpNEH11NB+5bvhSO9JoP7forJzaG92bc=;
        b=P2JbND0O4gebaYQWlBPcNiH4NyCuU/hDNNJywbr1K+BvEO1xrmkmgL0bHTOHOhzyxI
         j1rjosq/bhGeQNVnjzDHlYosH6+Mzo8HxKLOsvMTdEbF2SBAP6uwh8GZVEcmJ+18x1Ub
         QwF8+j4i1aAaIIfrBO2BYEUTkUIOdQXEb+tHI3I3r6Qx9swlYsX89rLmyaJViv0hXQqj
         SRXRKSco6zMN5ej5DjaazTahF+HnE4D7W13btfTYc1+9f3j/KgiFJUZSuiBuYdJYvqXF
         tvSEnRrtPlJnXRBknABxU1B3eBW/zwYQgoeOv85eB+IjiX1GGJAQE4wPmasVSVqH+NnD
         hdHg==
X-Forwarded-Encrypted: i=1; AJvYcCUAFUQYnkLLERLZ+eI4l5jtPdCexMC/KkvSU0R/aiS9ZdXc748iqUzQBdAqhtvFt1El6+ygE+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0OZGN2a1crYiuN2+bwCxvTyGQNNnxY6Jz44UW7wPqKaw9529
	t5xLJyT7lv6v7tqvUP8TD2OjCRl0zI7Biy4oMrg9pdq8xUbfGoYi8ymAyCODj54=
X-Google-Smtp-Source: AGHT+IE2nRqDWcprFbqsyiRnRrZSmdUyGUKgVh+UN0C5kREuaiIMyson1wnaLb7mms/VbQSk1nr2fA==
X-Received: by 2002:a05:600c:4a88:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-431aa292eb4mr115733635e9.15.1730386842144;
        Thu, 31 Oct 2024 08:00:42 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:41 -0700 (PDT)
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
Subject: [PATCH v3 04/14] scsi: ufs: exynos: add check inside exynos_ufs_config_smu()
Date: Thu, 31 Oct 2024 15:00:23 +0000
Message-ID: <20241031150033.3440894-5-peter.griffin@linaro.org>
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

Move the EXYNOS_UFS_OPT_UFSPR_SECURE check inside exynos_ufs_config_smu().

This way all call sites will benefit from the check. This fixes a bug
currently in the exynos_ufs_resume() path on gs101 as it calls
exynos_ufs_config_smu() and we end up accessing registers that can only
be accessed from secure world which results in a serror.

Fixes: d11e0a318df8 ("scsi: ufs: exynos: Add support for Tensor gs101 SoC")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: stable@vger.kernel.org
---
v3: CC stable and be more verbose in commit message (Tudor)
---
 drivers/ufs/host/ufs-exynos.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 33de7ff747a2..f4454e89040f 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -719,6 +719,9 @@ static void exynos_ufs_config_smu(struct exynos_ufs *ufs)
 {
 	u32 reg, val;
 
+	if (ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE)
+		return;
+
 	exynos_ufs_disable_auto_ctrl_hcc_save(ufs, &val);
 
 	/* make encryption disabled by default */
@@ -1454,8 +1457,8 @@ static int exynos_ufs_init(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 	exynos_ufs_specify_phy_time_attr(ufs);
-	if (!(ufs->opts & EXYNOS_UFS_OPT_UFSPR_SECURE))
-		exynos_ufs_config_smu(ufs);
+
+	exynos_ufs_config_smu(ufs);
 
 	hba->host->dma_alignment = DATA_UNIT_SIZE - 1;
 	return 0;
-- 
2.47.0.163.g1226f6d8fa-goog


