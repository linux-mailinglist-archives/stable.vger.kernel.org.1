Return-Path: <stable+bounces-47272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC48D0D51
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0513280F48
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF415FD0F;
	Mon, 27 May 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRIKZWXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC3262BE;
	Mon, 27 May 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838113; cv=none; b=YJCvKUHh+PkQT3G8LAWcWWbIkBy+EZLrfAqJrRcLvuzqoyGryYZkL09kUbM8um1AT9S6KipX0KRK818SZ0JkYng6kbYdOG4Vn6/eOelvDjUJcFz6AbdGSLAqPF+knO+8GIvjp3r24CT5AUYpRDKjBfTtVp1GhCxVlWUtoWIR7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838113; c=relaxed/simple;
	bh=KepidD+b73R9ix/SUIvIwVfyCuKyMDMP/pRhuisa1iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr80Pz/ZPB+tRIL7ny2U/GTE8aibADgGMdea2gxz+L3756K5jqZ02R4+M7+UNjV2d7gDPh9bhbMeAxyXwP9+Ee1mKX5v2LpXEFCbCT8sghCB4AqME8o/8+1j+Q4Skk91QMFL8npNTMgbr0I3xvRFd3THt5rIknO22SDsurEJ+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRIKZWXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E376C2BBFC;
	Mon, 27 May 2024 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838112;
	bh=KepidD+b73R9ix/SUIvIwVfyCuKyMDMP/pRhuisa1iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRIKZWXKnDOHiQduqSUyVdZfikR5Jd/upFy+AjSMhw4EfmDTg1O/OtLWL3/IhQnpH
	 sAO+WnzDlmEXY90B324UbZPZCeGDROvmhab2nevvF1RadAy/aUEBrm+FdYm9k+z9QB
	 e3hvHsa9JpopS/c5eMRS0H2aSmwBE4J78Y58Xzpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 272/493] wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command
Date: Mon, 27 May 2024 20:54:34 +0200
Message-ID: <20240527185639.180751579@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit fa46bd62c9a8ab195d9c5108a91abf0680fec10e ]

Before sending suspend & wow command to FW, its length should be
4-bytes alignd.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ae19174b46ee5..5809555a909d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2524,6 +2524,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 			__le16 tag;
 			__le16 len;
 			u8 suspend;
+			u8 pad[7];
 		} __packed hif_suspend;
 	} req = {
 		.hif_suspend = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 2cf39276118eb..1599338e06310 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -535,7 +535,7 @@ struct mt7925_wow_pattern_tlv {
 	u8 offset;
 	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
 	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
-	u8 rsv[4];
+	u8 rsv[7];
 } __packed;
 
 static inline enum connac3_mcu_cipher_type
-- 
2.43.0




