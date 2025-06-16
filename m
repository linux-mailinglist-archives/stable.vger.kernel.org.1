Return-Path: <stable+bounces-152697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B1FADAB50
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7E3ABB1C
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4578B272E6D;
	Mon, 16 Jun 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkzNPxan"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26A270578
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064313; cv=none; b=C8N7+mMGyNYwPYChYFK7Ioy9c+vmv9eH+iYm3AYvyxBu51u8O80tAv8r0EDGQ3EC7OcwZOWwdhbA9RHA9+gVH2DceHq/pccc2gF4CxNFPuEhKn4TsKep+h5OX3qD1QRhfF02g6o2q7ZkCuzCMwdI9lmPsBy6xgj1KoG6YJ8JYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064313; c=relaxed/simple;
	bh=g7tlwdRNtN0gqtJClqvwnCStjM6vCVUxxCaFkz13PfI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=okzreILlBx/RfTQpwpPR/bshr6hDKkNc+W0pV1MXRSL/4F8Se22VtimIfwJkHlBcDdTfH0Pt+R/lnXSWQGmCxxx4mN2cxtiw+XaaKuHdKJzK5vAMpPjumAdJ3qEV4dY36+KiGvY+vmfeK/jy+wrsbEVf8ng2IeXs6rZxPy1J3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--anvithdosapati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkzNPxan; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--anvithdosapati.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4034b42so1446000b3a.3
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750064311; x=1750669111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERVQz1A2O2BXzPah5knZjJSx5XV0pxIWUqYZQG345/A=;
        b=JkzNPxanarVjXL7Iu8RW6H+YSn7e2LqAE2rbonskKeaGa54b0QtsCjbK7mquaxZkLu
         bSgnGjTJ4iPfa7PXIOiPD6ZIoGR7n3WAIDimHE6yXUVgtMIaZwFr+cHJV6P1ueO8OO89
         vuVgQBw4a6SKkgMD6DXgdDgT4KAY8+WdJy/L8VADaSfB1IyB0WQwOT90teMNHhNClHs+
         eFhudXrrMI5Ga95QHpWOq/Ep0t8hhnlcTx8k3O2bxash4G3JRZAD19ZGUhuZOhUETCOD
         PFwR3VzDbpjgmNHomILvkx7pdtTaqugSB8xzZ5Sc/8y5Vw2KbcmiAzG9LOCRkST1Rxcq
         Vx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750064311; x=1750669111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERVQz1A2O2BXzPah5knZjJSx5XV0pxIWUqYZQG345/A=;
        b=mgRPAQ9LsG66ghTh/ohgRwH4RD+K+iSeqSgSHIP+jTVpcvOtWXUh763O+F9RyJLNOq
         ULbcCrTzRSEy/tageVUF61F0aPi+Y9jVRcn77RcltiWUJiI8PqMa1+blqPBP0NLfQAya
         t174PC+fuA9BZY6z7mkWF/mMuN+3B2PlJdkp8sViP1QQ2ayO5mwlnj3+pOBLq5IhRpLc
         Xjz1mwYh8/mvx+WNLCwrwZCt8SheBBKKWAPk0r77yDb6DRM/IPI2AIblNcE6sTue6gt2
         6Vp4mGhLUgqv0Z0B5Es/uUWjs+H7UTiXBjdXbWAC/+0W42zHhIrxh/iB9wLIwoGG2INd
         hyGA==
X-Forwarded-Encrypted: i=1; AJvYcCUq4/alyiW6pQmuN5ziAj1tRne8/knE6ud35a5KXsyYQH6sifkXq0Qpamr0Sz8U5WXDx8gw7Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjnvDSD3f4b99BGv8I8ULqaKyYLLKG5fFQg+wQPd1qzoQRU4w
	PwTFfo8bqoZtSWHbWpJu0wt8YY9/DMwopWpbsfnkTJwKJyUE19wMdYOxaBfHn2RM0By2X/TIdfi
	1w7d0LST9twSH1eTcsg+2Dy99pQqV/b7y2px4Hw==
X-Google-Smtp-Source: AGHT+IFhXs6n3o6icotL1+3XeLD9ZY9eTAmeu2x57RShZxqj4RSih7awjaXGE2lMq+jpHBr9PWJ3C6BLb0Iepg4J0wUDcg==
X-Received: from pgam2.prod.google.com ([2002:a05:6a02:2b42:b0:b2c:2104:8856])
 (user=anvithdosapati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9ccb:b0:215:eafc:abda with SMTP id adf61e73a8af0-21fbd4d48f6mr11377195637.18.1750064310866;
 Mon, 16 Jun 2025 01:58:30 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:57:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250616085734.2133581-1-anvithdosapati@google.com>
Subject: [PATCH v2] scsi: ufs: core: Fix clk scaling to be conditional in
 reset and restore
From: Anvith Dosapati <anvithdosapati@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Subhash Jadavani <subhashj@codeaurora.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, manugautam@google.com, vamshigajjela@google.com, 
	anvithdosapati <anvithdosapati@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: anvithdosapati <anvithdosapati@google.com>

In ufshcd_host_reset_and_restore, scale up clocks only when clock
scaling is supported. Without this change cpu latency is voted for 0
(ufshcd_pm_qos_update) during resume unconditionally.

Signed-off-by: anvithdosapati <anvithdosapati@google.com>
Fixes: a3cd5ec55f6c7 ("scsi: ufs: add load based scaling of UFS gear")
Cc: stable@vger.kernel.org
---
v2:
- Update commit message
- Add Fixes and Cc stable

 drivers/ufs/core/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4410e7d93b7d..fac381ea2b3a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7802,7 +7802,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, ULONG_MAX, true);
+	if (ufshcd_is_clkscaling_supported(hba))
+		ufshcd_scale_clks(hba, ULONG_MAX, true);
 
 	err = ufshcd_hba_enable(hba);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


