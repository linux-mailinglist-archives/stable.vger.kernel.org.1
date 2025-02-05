Return-Path: <stable+bounces-112929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2DA28F12
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965E6188306B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A71459F6;
	Wed,  5 Feb 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAvbkAl4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67E522A;
	Wed,  5 Feb 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765234; cv=none; b=I1I7/3t8PRmMb4BLNIiZqxjKmZF2ZGAIcB4/bElj+W28S8IzgHmeDJI1t+SXbxDeiO6tERvP2ZhOwN9+5JfCJG9p2bVNDY2yW/XVd5Ijbu67+l5yMLOPAvwGThpaOOUUSy6qCepIGl3awdSd4/iLka+VRjBtllTWcigN2qFhNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765234; c=relaxed/simple;
	bh=rB1QPDrlkaVBHuxwtWTAJSaA80tp8epqO+6XB8vCon0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrhnGvasZsqeTgX2ucGlPC9zNMJUZ0csGDSewLjLBPNCGusYMQ0oY4DXsilRZJmjYK5eJxD6IWgk+3WMmp8KMFah8n8V+8N8GO+yDYiCI9kR+1jM/kGHusyDELiPTG+nLyeW5NQDGN+tfLXTd7aKK8FTHXYOHla75lyIgGWxaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAvbkAl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B26C4CED1;
	Wed,  5 Feb 2025 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765234;
	bh=rB1QPDrlkaVBHuxwtWTAJSaA80tp8epqO+6XB8vCon0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAvbkAl44CZqI3iBjZ6KjiXW+mXzJOid3SbRB2NG26/Pd9KBtVjghySJtJWRMGrhT
	 cwSm6h9kTJaf2MqTAx9RpecvhiFEPutsJVPU4LQMDgNrRjMgECuolgDfycRMsyb/sw
	 fmMBvQBXZ5rAyiLVsM1R/5nfZclyTIOyQ4GMGDyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shengyu Qu <wiagn233@outlook.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 202/590] wifi: mt76: mt7996: fix register mapping
Date: Wed,  5 Feb 2025 14:39:17 +0100
Message-ID: <20250205134503.009659113@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit d07ecb4f7070e84de49e8fa4e5a83dd52716d805 ]

Bypass the entry when ofs is equal to dev->reg.map[i].size.
Without this patch, it would get incorrect register mapping when the CR
address is located at the boundary of an entry.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Link: https://patch.msgid.link/OSZPR01MB84344FEFF53004B5CF40BCC198132@OSZPR01MB8434.jpnprd01.prod.outlook.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 40e45fb2b6260..442f72450352b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -177,7 +177,7 @@ static u32 __mt7996_reg_addr(struct mt7996_dev *dev, u32 addr)
 			continue;
 
 		ofs = addr - dev->reg.map[i].phys;
-		if (ofs > dev->reg.map[i].size)
+		if (ofs >= dev->reg.map[i].size)
 			continue;
 
 		return dev->reg.map[i].mapped + ofs;
-- 
2.39.5




