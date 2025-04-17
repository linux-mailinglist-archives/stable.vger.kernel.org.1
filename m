Return-Path: <stable+bounces-134329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DAAA92A8A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7081D4A6690
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA8257AC3;
	Thu, 17 Apr 2025 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PolqTj/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DA25178E;
	Thu, 17 Apr 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915799; cv=none; b=lvyLsN8pq0ZumuoCHSXRLDbIOWwosq98QfJRZGFikMKGq7eeo8pd73ntlmDdTTCedeW/rFLtoUy+M2hgE/SmmQxmKX9fIASd50k2rLpQx+dec1mNCTfKB5j8DNhY7WRD+nOAq6G/CEmEaUShxiJPyK6n1wetLTmYVZhyqb2w3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915799; c=relaxed/simple;
	bh=jSGbmUZ1BxqgCsNx4LP9qbJNRWpZPqh+DtSeXeeeNoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBVkI/ARJ2CI7XHaoLwz0fvhFjmuMfC1/B5+9KsVq8TJmTUgYCRr+JXLOk41lFwqe9YYLLOD2CCjXbwRt3LwFXmo/PHJSoYLBl7SJIOjjVZHNBNWlsNxATqeBE6c5jJYItWyp/iBoLfUvn8DZM9DeE6RqKcGWqJkMORW60G0+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PolqTj/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1B9C4CEE4;
	Thu, 17 Apr 2025 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915798;
	bh=jSGbmUZ1BxqgCsNx4LP9qbJNRWpZPqh+DtSeXeeeNoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PolqTj/XbyikUGybsMBYxzmJpT521L/aw41XDTCyEFc3FPdydtS1an8WIc49bwC0H
	 yVKxkvzsLivufKTEdRwCffM6Z5Wm/BwCcJ/jTycxpT9XNsiILYsxyOvt8g/95oWYgV
	 YX+kK93mqpCoYG9xKyeSDnHwhXEhScS2VMN1y0fE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12 243/393] wifi: mt76: mt7925: fix country count limitation for CLC
Date: Thu, 17 Apr 2025 19:50:52 +0200
Message-ID: <20250417175117.369304183@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

commit 6458d760a0c0afd2fda11e83ed3e1125a252432f upstream.

Due to the increase in the number of power tables for 6Ghz on CLC,
the variable nr_country is no longer sufficient to represent the
total quantity. Therefore, we have switched to calculating the
length of clc buf to obtain the correct power table.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250116062131.3860198-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3119,13 +3119,14 @@ __mt7925_mcu_set_clc(struct mt792x_dev *
 		.env = env_cap,
 	};
 	int ret, valid_cnt = 0;
-	u8 i, *pos;
+	u8 *pos, *last_pos;
 
 	if (!clc)
 		return 0;
 
 	pos = clc->data + sizeof(*seg) * clc->nr_seg;
-	for (i = 0; i < clc->nr_country; i++) {
+	last_pos = clc->data + le32_to_cpu(*(__le32 *)(clc->data + 4));
+	while (pos < last_pos) {
 		struct mt7925_clc_rule *rule = (struct mt7925_clc_rule *)pos;
 
 		pos += sizeof(*rule);



