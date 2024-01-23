Return-Path: <stable+bounces-13259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62245837B25
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE37C1F2811F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757714A4C4;
	Tue, 23 Jan 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCrTldJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829414A4C2;
	Tue, 23 Jan 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969211; cv=none; b=Vn5hRF7xLMpLUabeI7XwZZIn8Wncp2YvviSWCzggic0hPu7ZoTYK9NiiEk8+tk37Of/AcvaQ/DTwO5n6dlA1wVYNhU3vJfVgQ/o6fqrqkZO2XuLhwaOi5rOSwXJWZGsCk/cXpOV8LHyDzPBf6ksVG54XQbVwgFiRpitYRr5NZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969211; c=relaxed/simple;
	bh=Ahr8RBC+LBkUHx7fdSUqHCprBRkpU2rW559kkTuMWdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yoa2xta3pB7WPOIVzUzKzsIvZVIEB3nhhyqdMALSAifLuGNHlgwSwfKkuR8RmeQRZvCWHmB2azLFDzu6QnQhDKiD1bHL1JUItDq+RmSLl7MHwFJEm8W2ZO6P9P9AyyAsjDUZLyoj4GUUM7S3cSKvlUiXfn50rvX6htfJ1p16biA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCrTldJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A16C433C7;
	Tue, 23 Jan 2024 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969211;
	bh=Ahr8RBC+LBkUHx7fdSUqHCprBRkpU2rW559kkTuMWdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCrTldJkrWuLVlkxy9ryJLieaEB7N5V47yys9dTG82wYGANk5n2s3BDsTyj1sSpiS
	 jwUvw3wQpoC/Qka2hZWsPbx6fYqXNXmQfngpClupcy3esyUxhhieibX0IarraRkKqm
	 kU4YkbOgADx8mgJURp2aDfx4aE3m9TrlHMk4fDLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 101/641] wifi: ath11k: Defer on rproc_get failure
Date: Mon, 22 Jan 2024 15:50:05 -0800
Message-ID: <20240122235821.198041759@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit 2a3ec40b98b46c339adb57313d3b933ee5e7a8e8 ]

If we already have gotten the rproc_handle (meaning the "qcom,rproc"
property is defined in the devicetree), it's a valid state that the
remoteproc module hasn't probed yet so we should defer probing instead
of just failing to probe.

This resolves a race condition when the ath11k driver probes and fails
before the wpss remoteproc driver has probed, like the following:

  [    6.232360] ath11k 17a10040.wifi: failed to get rproc
  [    6.232366] ath11k 17a10040.wifi: failed to get rproc: -22
  [    6.232478] ath11k: probe of 17a10040.wifi failed with error -22
       ...
  [    6.252415] remoteproc remoteproc2: 8a00000.remoteproc is available
  [    6.252776] remoteproc remoteproc2: powering up 8a00000.remoteproc
  [    6.252781] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mdt, size 7188

So, defer the probe if we hit that so we can retry later once the wpss
remoteproc is available.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01264-QCAMSLSWPLZ-1.37886.3

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 235336ef2a7a..f8f5e653cd03 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -803,8 +803,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 
 	prproc = rproc_get_by_phandle(rproc_phandle);
 	if (!prproc) {
-		ath11k_err(ab, "failed to get rproc\n");
-		return -EINVAL;
+		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
+		return -EPROBE_DEFER;
 	}
 	ab_ahb->tgt_rproc = prproc;
 
-- 
2.43.0




