Return-Path: <stable+bounces-127467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78769A79A53
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A41188DE48
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303C189B9C;
	Thu,  3 Apr 2025 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXhoE9Qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AE1854;
	Thu,  3 Apr 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649880; cv=none; b=pk3bb54x5Zy9sJK1J86li9wBJAlOHYciHImw7feL6Uug4h8swJ4RE/EDd4yqbBpCfOlb7o43OT0AqnMQAdEkiL/tS/dBmZpIYhsT99ipQcjD2XMTSL4mxibmHEv7sARaNvtTbEM1XsARlOEWk9vINuFIAznf6i6ZJHcoPAzp+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649880; c=relaxed/simple;
	bh=fzE1msjPvpWi+ZpNMges2+SYdgyK49I6lJrHs42pJW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wjg65uAe8Z6q3szuPVljLfzsvZHE6wfYbyCCC2WxNbClV13/G4wiuDC/eS/4fqu+avPWrSmOjW+2SZ1jAVkow//2G02ujQym1ODDeKHKWBM69ItdbvXJKYAcYMoG5ENv/Zccnb2gEdJ5Y5Vjgm7c0Hk/hVVG+sL7Q49KmCQS94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXhoE9Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF95DC4CEDD;
	Thu,  3 Apr 2025 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743649878;
	bh=fzE1msjPvpWi+ZpNMges2+SYdgyK49I6lJrHs42pJW8=;
	h=From:To:Cc:Subject:Date:From;
	b=YXhoE9QjOThQGT9QMT2f8aW6wNiqlhlW7LsD6yFYyBPfZ5f0bmMyg4qcit5c9LEn2
	 lIuMD23Xdt0kitXJB1Vp1tuQFbF82CqTGtVw9SPZWbGV9fTNZ+85KF5mv28XkLsUjS
	 rvjsYtm/Jvb7cbvVV5Oxe06wAPo4qrki/emJXcRiRtlxnsdxufhKUlnWexGGcPrdYM
	 JplQ6ZYBAwm8pY+uflbK86B9OsVOl96AgoAN5xtcQD8zeLzoBjt8HQOF7WYzp6qIPy
	 1/LAapuFvmNtQz/MQ3MpQaGpsSlom384oryGMP0Xmf09agNR2N8T6S3ZS4qhur43up
	 ZUZ3aUkN3ZfxA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: Yijun Shen <Yijun.Shen@dell.com>,
	stable@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: amd: pmf: Fix STT limits
Date: Wed,  2 Apr 2025 22:11:04 -0500
Message-ID: <20250403031106.1266090-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On some platforms it has been observed that STT limits are not being applied
properly causing poor performance as power limits are set too low.

STT limits that are sent to the platform are supposed to be in Q8.8
format.  Convert them before sending.

Reported-by: Yijun Shen <Yijun.Shen@dell.com>
Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 5d513161d7302..9a51258df0564 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -123,7 +123,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_APU:
 			if (dev->prev_data->stt_skintemp_apu != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false, val << 8, NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_APU: %u\n", val);
 				dev->prev_data->stt_skintemp_apu = val;
 			}
@@ -131,7 +131,7 @@ static void amd_pmf_apply_policies(struct amd_pmf_dev *dev, struct ta_pmf_enact_
 
 		case PMF_POLICY_STT_SKINTEMP_HS2:
 			if (dev->prev_data->stt_skintemp_hs2 != val) {
-				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val, NULL);
+				amd_pmf_send_cmd(dev, SET_STT_LIMIT_HS2, false, val << 8, NULL);
 				dev_dbg(dev->dev, "update STT_SKINTEMP_HS2: %u\n", val);
 				dev->prev_data->stt_skintemp_hs2 = val;
 			}
-- 
2.43.0


