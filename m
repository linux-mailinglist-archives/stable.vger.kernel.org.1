Return-Path: <stable+bounces-200101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B4CA5F89
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7EBD315ACA2
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5E246BD2;
	Fri,  5 Dec 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="Sy0CTuo2"
X-Original-To: stable@vger.kernel.org
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDC27EFFA
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904430; cv=none; b=jjQSgiou+DwsTtJypCFx9xjLWoAErz5SVM3YFi1ElKrNjAEIre+ao5Bp0Ii1FxLBfc/zMVWOnHu+4rXsxQi4rIxmSFFLZJpIqWcQah8I7oXJcdNS1JOICbI8IP4po1HpuwcyCU2a1Rs5tOTCs/ToG9cM6CqrF7DePv4jRyvnPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904430; c=relaxed/simple;
	bh=sF1qIao+TYn7SW75G70+AU4lV0vjhqkP6LJXt4lvhnI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DjPsjBvZGGdi+KX2HjJd+VxTHI2303bl7wThqiF5kQOPUGCLFhjmoLh4qceqf5otf4YIm6kCGcuXhLjk0FkdB4NpFXqbd0cIlJZREHZLtExhMnxa6GoOpS7NAyyJwVYwI+qHfl3jlUaKipFbZrqwFlgRP75IzA5mucGAMGQGYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=Sy0CTuo2; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1764904426;
	bh=B11YdCxnfX3eA2fZ53RtkZVR+/TU7c6yKHbU0cgE2fI=;
	h=From:Subject:Date:Message-Id;
	b=Sy0CTuo2P1ZCpp4KFVO6X3uNDaT9v+5s1jq5RASYr2x18MOwm1PF+EWFqHycrx/hg
	 ntRBhgJW5J8Usu9gv8Jec6P0C2lpLFxi3cZSq1YVbFl/qLAeWI2jGJkSzjrJD+xSM1
	 SYCv8IdEsHwftntzgFtov6MIx1xDbg7K66cPq1g4=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([183.241.245.185])
	by sina.cn (10.54.253.32) with ESMTP
	id 69324D9C00003924; Fri, 5 Dec 2025 11:13:01 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 4535734456880
X-SMAIL-UIID: 4A48157AEE4B48349AB0D9F1F7B4BF0A-20251205-111301-1
From: Chen Yu <xnguchen@sina.cn>
To: vladimir.oltean@nxp.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Fri,  5 Dec 2025 11:12:23 +0800
Message-Id: <20251205031223.2563-1-xnguchen@sina.cn>
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


