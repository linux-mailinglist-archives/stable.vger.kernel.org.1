Return-Path: <stable+bounces-194036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DCC4AD84
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBBF4F5874
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C43431F8;
	Tue, 11 Nov 2025 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yD+Jbp19"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E353431E6;
	Tue, 11 Nov 2025 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824652; cv=none; b=oYKvYVtorYLBfhH8Mej33TWiDZkPb+nQR6oT9/u54KQSwuvzSfJvQrymStT+dBMGHbE9xB4FIfqGy43y0/5gmjIAGpjxW6OzQl2KLS1t9MGmCZOAKlSfdK1/AKcYF4J6vyADwsAG+F71nv7XO094cJ0jJKo8wqpXGJoZqMRAOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824652; c=relaxed/simple;
	bh=X/pBxV5DpceVL762Tafd7ON19gQ+7Eq4VTq/PAnE+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERlpaIDANozpR+aEiOuDsIkefw3FeYHhu2nD9H5HsZQQkfG7X0EmvGIiwoNgYNaQHQH7emD8QsSEkO4u1QBJ738b1FVsHI+fapORKcI9BfRNKvfftz1mqVWPfPekCWErMmPNUjf7qH+jTN0TjCh3XIGQdvPon2S3Rbh4OiMbvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yD+Jbp19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F06C19424;
	Tue, 11 Nov 2025 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824652;
	bh=X/pBxV5DpceVL762Tafd7ON19gQ+7Eq4VTq/PAnE+cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yD+Jbp19y2z4QayUPCK0wMS+oizImYzfXGoH5vLtvhy8wvM5i5hXSgNs310EmRXAM
	 t86Krxq2eK9EBtO9r9eKf2NfJkY7YQ+GO/Ib26e8WITPP+KpcvqmZ0gj11D/nMVnQ6
	 yAhO0aVSavTMWqOlAYkkphIPptfQCwIcouZnTLnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 544/849] wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error
Date: Tue, 11 Nov 2025 09:41:54 +0900
Message-ID: <20251111004549.562383947@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 7c0f63fe37a5da2c13fc35c89053b31be8ead895 ]

Free the allocated skb on error

Link: https://patch.msgid.link/20250915075910.47558-5-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index aad58f7831c7b..0d688ec5a8163 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2535,8 +2535,10 @@ int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	ret = mt7996_mcu_sta_key_tlv(wcid, skb, key, cmd);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
-- 
2.51.0




