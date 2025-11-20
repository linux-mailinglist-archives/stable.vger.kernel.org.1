Return-Path: <stable+bounces-195227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B275BC724F9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 07:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 137AE4E4594
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85E28D8DF;
	Thu, 20 Nov 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="QsjOkJja"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2662C0F68
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619309; cv=none; b=rGrdRMWaZkAPbaKQOEeU1/3fmbXngKzBGmAPkqkzEEXbX6RdZLBgP9tEEcipu+ENz4Up0YD4nOCkhgmwqAfPyz4k35BaPO9xEsKZpiUT4p85Ch4Ccg3B+/leC34VRSH5Bp1bPn5KfIlAjdw7tChsw4y3sGwuFHkPxLYMKmEh4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619309; c=relaxed/simple;
	bh=sF1qIao+TYn7SW75G70+AU4lV0vjhqkP6LJXt4lvhnI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eOdB35G1o5yg5MQKE1lqWMxZZaeDBHspPALcrDpd/iJIqNUqa+9juFr2SeZddBF7t5Nj75hMl52cu6/TNyRkIh/RvYFUeIzmU0nKIEr3/78fQIVfPJD4c6jdMT2Tk6UFjEyfIf9kc8KBlN7AaIwHzWf7Jrt8nH3wIoF247JEwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=QsjOkJja; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1763619302;
	bh=B11YdCxnfX3eA2fZ53RtkZVR+/TU7c6yKHbU0cgE2fI=;
	h=From:Subject:Date:Message-Id;
	b=QsjOkJjaOhAGg+hbS2ROGH6ClWzAB5XihFIXpoTL9hMV+Fs0T12bbOsgTIGoEJ8/X
	 IFLZG8uWkcb2htY0O7DMjaKfOO56MW2Af7ag24jl6QnjXCsVD+MjUa17rDV3S/aTbv
	 h1ff0ZkB93Tb8kV2uxMqiqeDL83lQKD9VNnplT7M=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([117.129.7.61])
	by sina.cn (10.54.253.32) with ESMTP
	id 691EB151000042F5; Thu, 20 Nov 2025 14:12:36 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 6698014456643
X-SMAIL-UIID: 00068659356640B899E01033BC39A168-20251120-141236-1
From: Chen Yu <xnguchen@sina.cn>
To: vladimir.oltean@nxp.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12.y] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Thu, 20 Nov 2025 14:12:31 +0800
Message-Id: <20251120061231.3103-1-xnguchen@sina.cn>
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


