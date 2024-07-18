Return-Path: <stable+bounces-60573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134393510F
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EB2282F47
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA5145355;
	Thu, 18 Jul 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7k+sYjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65C47A73
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322433; cv=none; b=oKbyb6KjxSOo6mLB7WtO0CnfC0vRDzWdI5/AvAv8uBC//AoUys4Kx9OD13KmyeHu9TYyJCJgnoNxM+q1yUa4oZGyM21nCFjfJpx5Zu3/BfzPOkaDYe/sJjUbM73nU50LFfSnKkE5blc20CYtMPODmCbwij5196IsN3jpVGhWVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322433; c=relaxed/simple;
	bh=cjeX1aFyWdBgsxfxbKfPnG9h/qsmn1yS9giF+UQOvt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUecb34Wor+kITaJMhKHW5GgaT00QB5Jcxnh7qB1t2XixppAg+704Z1csAHxuXAeMBnVim9od3yJy3Z09eWpWc0usUgayXSwyirzUbUrQJ7W56balVNr/TPFkq6XFmAZWbpXGl/jTkzbvJxeBMeREtE+U5DXUZHjJDMAvvb+zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7k+sYjb; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso430629a91.1
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721322430; x=1721927230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbWG4pqQqIat0xDS0ZVANXGmuhcJIaLuF1t7QxTUgZc=;
        b=m7k+sYjb1rMVAGo464+87Ykc1YRWqFoXtSxbQC1kX59ymqXr0mfiCrAJbMmEVs9jgn
         20SxRBL7mn/iv5AtXEIidk6upCLzOAwt4RJx3aEFT0rFVwtzsgqCz/47fkkQr0M0jFSv
         dnwKaS0XiyXEl9hTK8uDhIdnXtTFfpzhH162HCGykZl0fqoyX5qPlWKFuxXwqnDha0TR
         ECBMwWuzWVoFsq0F9shtBzuyD8F5UBdt96b6BsEmuNpMJDgNSiN+X3TA0Zey2+oeJUn6
         93b521i75fn1S7sHT9eU2C6MQ00Xd29h8vi/7YFz64ffY6lLdGmz094iYZP0SfOLl2Tq
         sSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721322430; x=1721927230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbWG4pqQqIat0xDS0ZVANXGmuhcJIaLuF1t7QxTUgZc=;
        b=Yd0nX/8Ly4ep7X+unPql9D3uXmr7h8oWXzUIogPPETGh9Q3L4vDNjqSEpV4e5Jbsh7
         IOCASu1g91jgRTry6ex9Nc/WlYOIe4kbFPjUSbKTPGVsX4WYrvjxC6whMckaDMNslbrs
         VTOdn/I5ox3Rzw/2xw4Qvz8GkIokjRX3LmyRmz6AtGJKG7tfjPSlSU35VHqnCgcF7nf6
         81+joqA1Yx4+/IfPE3cnGmu+b62Tn0pgxHfBeiUTNKltX/pfvDyr6JgWP+splWN0GGOk
         Y3cwkr+61m724Qv3gXu2Bscba7Ya5Z0HjzBX64u46J1xQW/Ni/6ZOnouF7bMFkFxa/T3
         7EeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7rsPgpSz1YdCJYNqoyjefLAwxco/Zg+Sd4Mv4Up0mdNyl3RR9YE0Usy3U7LVkciunMjnKPVbz6+2rD1VaybIUlp3ynj1i
X-Gm-Message-State: AOJu0YwOFERooWXo41DBbCJcyyN8MKAKWncjY7UuQx63wpmUJZczSP3I
	Aj+FaNyknnvgajCx13FG4GdPukW+bfOkdYTRcKbs5j3zti9b3fcwRmcKdVq80w==
X-Google-Smtp-Source: AGHT+IHzfGYavO6Fs7TNZbgx1Lr2vRkcXC3MMHfexuW7iiUp4F5HrO19UwuxKuf2xwzNcnSQfjNJvg==
X-Received: by 2002:a17:90a:b885:b0:2c9:93a3:1db6 with SMTP id 98e67ed59e1d1-2cb5269443amr4146865a91.11.1721322430332;
        Thu, 18 Jul 2024 10:07:10 -0700 (PDT)
Received: from localhost.localdomain ([120.56.207.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77342dcdsm969962a91.25.2024.07.18.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 10:07:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Anjana Hari <quic_ahari@quicinc.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: ufs: core: Do not set link to OFF state while waking up from hibernation
Date: Thu, 18 Jul 2024 22:36:59 +0530
Message-Id: <20240718170659.201647-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UFS link is just put into hibern8 state during the 'freeze' process of the
hibernation. Afterwards, the system may get powered down. But that doesn't
matter during wakeup. Because during wakeup from hibernation, UFS link is
again put into hibern8 state by the restore kernel and then the control is
handed over to the to image kernel.

So in both the places, UFS link is never turned OFF. But
ufshcd_system_restore() just assumes that the link will be in OFF state and
sets the link state accordingly. And this breaks hibernation wakeup:

[ 2445.371335] phy phy-1d87000.phy.3: phy_power_on was called before phy_init
[ 2445.427883] ufshcd-qcom 1d84000.ufshc: Controller enable failed
[ 2445.427890] ufshcd-qcom 1d84000.ufshc: ufshcd_host_reset_and_restore: Host init failed -5
[ 2445.427906] ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: -5
[ 2445.427918] ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_restore returns -5
[ 2445.427973] ufs_device_wlun 0:0:0:49488: PM: failed to restore async: error -5

So fix the issue by removing the code that sets the link to OFF state.

Cc: Anjana Hari <quic_ahari@quicinc.com>
Cc: stable@vger.kernel.org # 6.3
Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9f037a40316a..a9dfa82adac9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10261,9 +10261,6 @@ int ufshcd_system_restore(struct device *dev)
 	 */
 	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
-	/* Resuming from hibernate, assume that link was OFF */
-	ufshcd_set_link_off(hba);
-
 	return 0;
 
 }
-- 
2.25.1


