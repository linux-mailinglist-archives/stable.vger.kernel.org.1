Return-Path: <stable+bounces-80048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691E98DB91
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F4C1C230D7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9091D0F4A;
	Wed,  2 Oct 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2o7oULRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC31CFEB3;
	Wed,  2 Oct 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879232; cv=none; b=B0LlEAzqvnJaO/dVUrjVkFnZ/f+cRt/hJ+bQvUfxZF5m7yHjca9qNATD/YcLnkkfkp05TFLg1IIoqqflsj7MA5zyjqzu9USCZTTUISe28UjSVhIkXXs//xJOrKus81z+JfCxuitinlwoyMTQ1fOs8hk0dM00j7PrIu65Er10+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879232; c=relaxed/simple;
	bh=qv55WnPSr4imFis7drRSUQGLngFHFtNMXLOdtCE43M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsKqEsyfrigRYmHs4GX4dSEtLhkPoQWXe5zNfsf9Y3WkGw5VAopCv5qqavNYR7b4iOO2Yx4WfjOrX/84F4Lt446C4DRoT5zL8ah84Q7TPfHgol+VoRjNxGr/QEhtFgklLkeULQkiOWZran15NhURWgT1hSeVjEEmXf9r4REdRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2o7oULRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311FBC4CEC2;
	Wed,  2 Oct 2024 14:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879232;
	bh=qv55WnPSr4imFis7drRSUQGLngFHFtNMXLOdtCE43M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2o7oULRh3UG1UDpJWrQ4O10Gy46/jwsv6uHzwWSpfZOaui15LNNpGU058JchgR3yt
	 1yhRSd2l/iJMJycBkeltuy89EZ/Iw6vThJaj0yxj+PIgj4ap/5YYDEVjXxcwozdjzi
	 UQ/pje4MvaH0JYziT+eblxAErgbmVi1NtGqGyxNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 048/538] wifi: mt76: mt7996: fix EHT beamforming capability check
Date: Wed,  2 Oct 2024 14:54:47 +0200
Message-ID: <20241002125753.925795413@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Howard Hsu <howard-yh.hsu@mediatek.com>

[ Upstream commit 9ca65757f0a5b393a7737d37f377d5daf91716af ]

If a VIF acts as a beamformer, it should check peer's beamformee
capability, and vice versa.

Fixes: ba01944adee9 ("wifi: mt76: mt7996: add EHT beamforming support")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20240816094635.2391-7-shayne.chen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 1c3eec84892c2..325bbe3415c25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1188,10 +1188,10 @@ mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 
 		if (bfee)
 			return vif->bss_conf.eht_su_beamformee &&
-			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
 		else
 			return vif->bss_conf.eht_su_beamformer &&
-			       EHT_PHY(CAP0_SU_BEAMFORMER, pe->phy_cap_info[0]);
+			       EHT_PHY(CAP0_SU_BEAMFORMEE, pe->phy_cap_info[0]);
 	}
 
 	if (sta->deflink.he_cap.has_he) {
-- 
2.43.0




