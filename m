Return-Path: <stable+bounces-181278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE3B93038
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34071448043
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAE2F3613;
	Mon, 22 Sep 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bi0G7jkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF412F2910;
	Mon, 22 Sep 2025 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570133; cv=none; b=FXkbTRovWhb3CS1uPD/HX60wh8kDqHODfKscFP5txVdLIgKjvtK21I9bVSVmuyGpkETOX9MN+iT50DkDbFdox2NMPAGzpQGqQkgDcOqv64dhoAzhZHrpE8aB2+NX6tTYVnY02+BPy0lF78mRukR2X5hQ//Qf0r9fElc9L3tx1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570133; c=relaxed/simple;
	bh=VWG20wqEfc31iNC6a7BV9Hy10jUn4Lk/kZ6H/PL+05U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxOfMk4AyLv1vDYLcpMPq8kcqbOygpAgNL915PuEm4U4CVLOkUfNq3T2Clp5b/gkN1iRe/2B26DTIYrHmCguY9kN2XSLyjGf9WsHIsOtunGvn764iNZ0Qc+VgOBduUSQrZPXb+gGxx+yyVY5NVuZWyu6IydQSOU426F30l0qNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bi0G7jkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2876DC4CEF0;
	Mon, 22 Sep 2025 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570133;
	bh=VWG20wqEfc31iNC6a7BV9Hy10jUn4Lk/kZ6H/PL+05U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bi0G7jkTSEGRCwKkB/xW3zpTFcwlX2xKorFzH0fy+0v/eW0ScFYIdOAb8XZ0HHoNO
	 GpL0f6Pus5ZwzlEB09wBcTeKSploV8c9dzxY5hjZ1FE6M9Y/TmXXL45gErqPcL6DPy
	 //rnWqFCWkGtDpL1bdexN8m7hgL8H7pqI0pi9Zcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 008/149] wifi: mt76: do not add non-sta wcid entries to the poll list
Date: Mon, 22 Sep 2025 21:28:28 +0200
Message-ID: <20250922192413.102883210@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit a3c99ef88a084e1c2b99dd56bbfa7f89c9be3e92 ]

Polling and airtime reporting is valid for station entries only

Link: https://patch.msgid.link/20250827085352.51636-2-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8e6ce16ab5b88..c9e2dca308312 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1731,7 +1731,7 @@ EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
 
 void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid)
 {
-	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state) || !wcid->sta)
 		return;
 
 	spin_lock_bh(&dev->sta_poll_lock);
-- 
2.51.0




