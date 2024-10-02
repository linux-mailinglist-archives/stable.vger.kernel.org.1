Return-Path: <stable+bounces-80055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65298DB98
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBCE1F2226B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E71D0F6D;
	Wed,  2 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cCapYdqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B701D0414;
	Wed,  2 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879253; cv=none; b=BerBpitqltoXun2EtdMyuRPruI7tdZ4x7wxsdpSiu2f+pZgffCR8+7wvqfQx6+ZhXaZeg8nEi9qEdq/8JERDl0BuEKM6OUuLTlBqs76OVWF2mPMmKGj1kqJsDfDVoY2wPzHYV7xrkED9lxn2HC6EPChcy8pjlFAlbIzxkTznAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879253; c=relaxed/simple;
	bh=12KrEkENuBCww30+O80EA32hFE4o96/FcXhkUi6U2w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaDWyUrnvqIy8KwQsiKPZKrUkzw5tmt3EUlDbRVOzi6kKLVK9ZQCX56ENWdb5ggdRydcgfsPiGVrQ9+V1GKXpITZ0EuboChcM0I2M/iSCSEKkgcEu7POcGAcDv9rHcj8BGmJ0rOU/+F6x1of5hFNGhRD34u7BwtY1P37KpfUFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cCapYdqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCB7C4CED5;
	Wed,  2 Oct 2024 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879253;
	bh=12KrEkENuBCww30+O80EA32hFE4o96/FcXhkUi6U2w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCapYdqVn5ybvXleUiknvhJlDK4NZRn7547JO6vGqHMSAVJD7Bd+T95TLwU2RSYtb
	 PYc4R1NVZ26OtDQJkRcDw9uYffGVVO0HXywf/t1jrZT/t/NZ6q6Jo40MR0WgoS3rDU
	 nmWQ0yMmbfiEghTE2RkoJJYjO8dVujE3rorbBPbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/538] wifi: mt76: mt7603: fix mixed declarations and code
Date: Wed,  2 Oct 2024 14:54:53 +0200
Message-ID: <20241002125754.333663292@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 9b8d932053b8b45d650360b36f701cf0f9b6470e ]

Move the qid variable declaration further up

Fixes: b473c0e47f04 ("wifi: mt76: mt7603: fix tx queue of loopback packets")
Link: https://patch.msgid.link/20240827093011.18621-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index b3a61b0ddd03d..525444953df68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -29,7 +29,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
-	u8 tid = 0, hwq = 0;
+	u8 qid, tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
@@ -57,7 +57,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
 			 IEEE80211_QOS_CTL_TAG1D_MASK;
-		u8 qid = tid_to_ac[tid];
+		qid = tid_to_ac[tid];
 		hwq = wmm_queue_map[qid];
 		skb_set_queue_mapping(skb, qid);
 	} else if (ieee80211_is_data(hdr->frame_control)) {
-- 
2.43.0




