Return-Path: <stable+bounces-184391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E6BD3F81
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF8188BEED
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1030CD81;
	Mon, 13 Oct 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVMD3oe3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A030648C;
	Mon, 13 Oct 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367301; cv=none; b=KxfS8h7988/uNhOvasl5ApWXdwSciWDqnkP4Gub18QB9Hr7h/KBs4pGhkq0C1dGHRl97Qo6bszz8WNnl+3XiqkT2A88TDdFETzybt5434q0UeHsZIurI7rbrXni9qLeFQV7lJ+OKxMOr9oDNc0zXiyVFog8zaOFkFIx7jkPHbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367301; c=relaxed/simple;
	bh=LvW3JjA0xNgLdVgv/OT+Ymxgv43R9HScYAmEprQ2RSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJuiHChl50iKLIvlSCb5u7x8K07v9Aglx/8QaBQ9GSfpyhwOA7Z2Pi/P/mKtZdpRKq/o+J3szbXgHBP3ry6Vng/T2RFrgvULAdO8CM9fWPVez2eTLPUTrWbNLRoOlvv8pdrGBGdu5VQ8XTbDuxMkPAow9w9xLSScGwZLyqJuNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JVMD3oe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBBAC4CEE7;
	Mon, 13 Oct 2025 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367301;
	bh=LvW3JjA0xNgLdVgv/OT+Ymxgv43R9HScYAmEprQ2RSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVMD3oe37Dy9WhqQ2DrTK2J3kkanc9bVBpDI/uHEGMep5V/N7PS7+dvldOIKNmTV0
	 cAQNEM5bJSXqDjaWTPxGb6iIM/9uRmuoVBdP6ddhExfCiLzxAZuofhTtE0gj5ntjm/
	 eAHiNeAJbNdoZ05mb8YAn3v8kNLrNzO3ema/SASY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 128/196] wifi: mt76: fix potential memory leak in mt76_wmac_probe()
Date: Mon, 13 Oct 2025 16:45:01 +0200
Message-ID: <20251013144319.325431184@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdun Nihaal <abdun.nihaal@gmail.com>

[ Upstream commit 42754b7de2b1a2cf116c5e3f1e8e78392f4ed700 ]

In mt76_wmac_probe(), when the mt76_alloc_device() call succeeds, memory
is allocated for both struct ieee80211_hw and a workqueue. However, on
the error path, the workqueue is not freed. Fix that by calling
mt76_free_device() on the error path.

Fixes: c8846e101502 ("mt76: add driver for MT7603E and MT7628/7688")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://patch.msgid.link/20250709145532.41246-1-abdun.nihaal@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index ba927033bbe8c..1206769cdc7fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -48,7 +48,7 @@ mt76_wmac_probe(struct platform_device *pdev)
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(mdev);
 	return ret;
 }
 
-- 
2.51.0




