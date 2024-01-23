Return-Path: <stable+bounces-14955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C4D838357
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996551C29AA5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FF61688;
	Tue, 23 Jan 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QqodiOSR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D661673;
	Tue, 23 Jan 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974940; cv=none; b=oqOCY5sOd0K+/WSNaJKmIU/7iQkaZk+ZE68b69V55exrykY0gz5WdT1f2QydBTTRO2IL7YPFqJhPsgmlRJlEqr5f4+RGwT32svKxkS+NYxw+XeSZ8w/Ouic9R/mwT9NRpp2jGnIs1n2IPau+o97ZjIDI7UoDfMkYFKZdZa+2gN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974940; c=relaxed/simple;
	bh=2+Bc5hx+4AiDlFIjHgSzuSg4mzpMVW64HTZNxwc+CZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+PfoRrp+Oz5wTawGwvZXb1+mPal33SFARbhN9yoKY7qd8g3TGcn/Pi30/KsiwZiKAtMcVnLAB3AbbHEKugQVqvqc4OEPe2X2EKnRMTbV0xz5jAoj3XaABjCKnRa3ysC9djaCWL+5Qeiss/dXgqEfozZsa3HXVjkdkFcY685JHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QqodiOSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE155C43399;
	Tue, 23 Jan 2024 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974940;
	bh=2+Bc5hx+4AiDlFIjHgSzuSg4mzpMVW64HTZNxwc+CZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqodiOSRFrRQtcZg6si5FqPYMrixYxryAZ9ACELy9rBl/zLK9zVnuI1qpjzX8H3oP
	 RRoE0GPnmY5886rSzwGfBH5DLX86aGjVVW1HWW7R7Ulp1HFY71qDJg4WPsk/4+J1tq
	 jD1PzGyUeJ1YkdaGocY1Q9hJ9OoOYpe225RGLR1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 135/583] wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
Date: Mon, 22 Jan 2024 15:53:06 -0800
Message-ID: <20240122235816.245249008@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit c33e5f4cbb9f961e66473a9ace077c4d1f29a5bb ]

Fix typo in mt76_get_of_eeprom_from_nvmem where eeprom was misspelled as
epprom.

Fixes: 5bef3a406c6e ("wifi: mt76: add support for providing eeprom in nvmem cells")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 36564930aef1..9220baec2394 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -106,7 +106,7 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 #endif
 }
 
-static int mt76_get_of_epprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	struct nvmem_cell *cell;
@@ -153,7 +153,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_epprom_from_nvmem(dev, eep, len);
+	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
-- 
2.43.0




