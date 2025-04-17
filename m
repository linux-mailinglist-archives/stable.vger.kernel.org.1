Return-Path: <stable+bounces-133503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BE5A925F4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6E1789B7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54877257443;
	Thu, 17 Apr 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2FOhH0Pu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AC257436;
	Thu, 17 Apr 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913274; cv=none; b=ZlWxai5S/YQ+SuhMQrTbscH+3wCEohJPS8i7FfY8wgD4BsQa2cxQrv/ZbHHTjc4hQY2FzJJpA79NqqixBTALDn2OedlJGE+qg5O3nEBPWRsG3C/xu3/yFA+N1KoPrD0aP48RmtAiBAa4nPvcYKASXxxRO3dM3oWuyQ8AWQt6f8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913274; c=relaxed/simple;
	bh=0p/LzmlXRTtIznQJt/XC255h7vFSdIGRvT/2oEhmTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnsGc1Pt3EHRJ37/RyL8iQVT62YimqGt53oDtXS8+HP68g9EKo97gdcFWyAlrdzxCNULhf3MXbcPsYYUkUYaikvXpZlAVds1vFfWxPV7VsICza0CprC/rDrtrLAc+ThJTAka5PFqWzk6/ak1hf4ESXFt1kuuOBxP1a6Qv4bXz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2FOhH0Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913CDC4CEE4;
	Thu, 17 Apr 2025 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913274;
	bh=0p/LzmlXRTtIznQJt/XC255h7vFSdIGRvT/2oEhmTaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2FOhH0Pu9KD/T6W1FfQ0rZngILdmP452Px2492Uk+Slx6WZ5f24aEHlMZsqwPmEYR
	 YR7EsIM6k/mRwacQj24yGI7UymG70jt6xxfUDme4it9spcSZqOjteWE2C5Y5RcJo2t
	 w9Jt2Lua9O/9vmzwhOs/VJzkF2X0kUWTK9JMgtmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Wang <sean.wang@mediatek.com>,
	Caleb Jorden <cjorden@gmail.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.14 284/449] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Thu, 17 Apr 2025 19:49:32 +0200
Message-ID: <20250417175129.506244235@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

commit 7dcea6fe33ee3d7cbb65baee0dd7adc76d1c9ddc upstream.

The mt7925 chip is only support a single radio, so the maximum
number of simultaneous should be 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250305000851.493671-3-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_p
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;



