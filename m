Return-Path: <stable+bounces-79433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE098D83B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FC31C22CE3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF31D0491;
	Wed,  2 Oct 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yYHCj6j+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F3198837;
	Wed,  2 Oct 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877444; cv=none; b=Z0K8BuQok10BR7yFG5d9IASiTyat+ybUSCB2eGrbMIeWtgJrXYQ6IFgZrqlkeSuuzyzbRUf4I8H3W75c8QjIehy1ifyFs+A5tmGFIk2EjkduTCR4KJhmJ6oSXjByWnqLDB0qgMW89qRm1OMQs8rcMo7sys1PTiFbgf9PYl4w+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877444; c=relaxed/simple;
	bh=bNxKkdsRD4ZRgZ4aTizsiw9PMAk0eCi/Nuqd+0gdBRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjiwf+iPP6irChRcXWxceMP9+vARMcurUNQxKpJfoxfUqT0DilSNlhiaIYFPsgLMLlwvem4OIc5k9K5HwO7BSMiIU0/PRGFufgB9DuE9oucIEWdC0hdBYArc6mtqFdvRNXB2dKMT0qfBDZotDgavqgGu2GchFEj99Slf5IyvbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yYHCj6j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D6FC4CEEE;
	Wed,  2 Oct 2024 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877444;
	bh=bNxKkdsRD4ZRgZ4aTizsiw9PMAk0eCi/Nuqd+0gdBRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yYHCj6j+LT7Ubu9upCFd4rjwWkIdii6sbWePqJHKg5OkOI3BDc8M2FstSULoawtji
	 ya0FR/x1I2xcxKHkXwACCMjO+2fPhg17vdz3VafB3M0SIDxeZ5eTQWzKutQqoX0/Yx
	 ycv7P55SpEx3vTlO07iWIjwq+AHIITUcTnZqXdTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 081/634] wifi: mt76: mt7996: fix uninitialized TLV data
Date: Wed,  2 Oct 2024 14:53:01 +0200
Message-ID: <20241002125814.309160140@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 9e461f4a2329109571f4b10f9bcad28d07e6ebb3 ]

Use skb_put_zero instead of skb_put

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Link: https://patch.msgid.link/20240827093011.18621-23-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 161ebf54a46e3..9176905451b50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -735,7 +735,7 @@ void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb)
 static struct tlv *
 mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
 {
-	struct tlv *ptlv = skb_put(skb, len);
+	struct tlv *ptlv = skb_put_zero(skb, len);
 
 	ptlv->tag = cpu_to_le16(tag);
 	ptlv->len = cpu_to_le16(len);
-- 
2.43.0




