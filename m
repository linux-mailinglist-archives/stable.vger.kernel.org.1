Return-Path: <stable+bounces-200123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A863ACA62FA
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 06:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DFB3030902
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F9727D77D;
	Fri,  5 Dec 2025 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="Hw98zGM6"
X-Original-To: stable@vger.kernel.org
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA413D539
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764914114; cv=none; b=aNGtV7mQlBkWv1QHDZC1HE9+K5c3kNcF6a3o8oOeSA9GnLJ3RyDqcevW1wCLVjEMgoc7hLU4v7I6d0/A1yGgjdy4RqHyxhdEDYPWeVhGDrLj7V6iHaRCCwWveDDY2nHOHdBxEnlqOF4D+EeoiRlT8Y36dF8P1KDkNWf5IOD5tSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764914114; c=relaxed/simple;
	bh=sF1qIao+TYn7SW75G70+AU4lV0vjhqkP6LJXt4lvhnI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=be06Cv0VZ+ERjZR8IdKCHP5BdZ9utc3C75ZYsrzWYwDK/Ml+3T8NRtnt5US0Sz+LtLjEAY0WKFNENUiv35nXBCtRGZl6djs4DEb8XAEiu9e/vBSNLwA5smfLScpRKmLzPB/i89EUGRaKO8lLvyepLzhd/wNZOJ5r4kYED8yGKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=Hw98zGM6; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1764914110;
	bh=B11YdCxnfX3eA2fZ53RtkZVR+/TU7c6yKHbU0cgE2fI=;
	h=From:Subject:Date:Message-Id;
	b=Hw98zGM6d5jS+AQtofsrkEW18MehYZwL0BewK1D1YWV2tDLXtv4GTkOGWmW8YoGRi
	 xvI/XI0I0OwDvAmJMAbIh3YzNIXDNeU7lp9nFw4CY4thk2jp1UOsHRs8tGKkG7tO2W
	 dBc1tLscCddOtdSORenV+JfuwZIdZ4jiJU/C/vOA=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([183.241.245.185])
	by sina.cn (10.54.253.33) with ESMTP
	id 693273AD00002139; Fri, 5 Dec 2025 13:55:02 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 349376685192
X-SMAIL-UIID: 370DE357ADC84545A867B620BDFDF5B2-20251205-135502-1
From: Chen Yu <xnguchen@sina.cn>
To: vladimir.oltean@nxp.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Fri,  5 Dec 2025 13:54:48 +0800
Message-Id: <20251205055448.3030-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 5f2b28b79d2d1946ee36ad8b3dc0066f73c90481 ]

There are actually 2 problems:
- deleting the last element doesn't require the memmove of elements
  [i + 1, end) over it. Actually, element i+1 is out of bounds.
- The memmove itself should move size - i - 1 elements, because the last
  element is out of bounds.

The out-of-bounds element still remains out of bounds after being
accessed, so the problem is only that we touch it, not that it becomes
in active use. But I suppose it can lead to issues if the out-of-bounds
element is part of an unmapped page.

Fixes: 6666cebc5e30 ("net: dsa: sja1105: Add support for VLAN operations")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250318115716.2124395-4-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 drivers/net/dsa/sja1105/sja1105_static_config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index baba204ad62f..2ac91fe2a79b 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -1921,8 +1921,10 @@ int sja1105_table_delete_entry(struct sja1105_table *table, int i)
 	if (i > table->entry_count)
 		return -ERANGE;
 
-	memmove(entries + i * entry_size, entries + (i + 1) * entry_size,
-		(table->entry_count - i) * entry_size);
+	if (i + 1 < table->entry_count) {
+		memmove(entries + i * entry_size, entries + (i + 1) * entry_size,
+			(table->entry_count - i - 1) * entry_size);
+	}
 
 	table->entry_count--;
 
-- 
2.17.1


