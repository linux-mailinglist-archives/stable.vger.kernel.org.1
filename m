Return-Path: <stable+bounces-140433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3494AAA8AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C408C188DF56
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB362980B2;
	Mon,  5 May 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov4dcVHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55C351E9F;
	Mon,  5 May 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484842; cv=none; b=o1VT1R8Hc+5ogcuUbZF7A7zT/7IWgIBXsgA22I8kA40kBjBmFkfkbI29soigcMixTEAosKbTgiz6lKfrW2FLuyp+ShGvq1pZyhv/68YdNXam9VhycWr5DgqVMj+8wWkGc5o4Ah4i8GGTRglibBM4GwjVAAVBKe5XcvTQXKn+A9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484842; c=relaxed/simple;
	bh=NDScpiGe6m4cQ6PmgWo5FbR4UNAHpnYJHvCxgasYht4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnRNaePJVM0lBfwnZKs3uIbdJDStctdWjWsd1N9RYkGMZV1qDxdkEtk5iinnm74FjB513IoQzP11x4xrdg5iZIqCsL6fbs4xFCeNiZj3oIFsaDqEQvLl9X6oDR2EmFBR33BIY8U9VksQxqqN1LxMEl4dnTv0rmzET/lfFVdgid8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov4dcVHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2A7C4CEEF;
	Mon,  5 May 2025 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484841;
	bh=NDScpiGe6m4cQ6PmgWo5FbR4UNAHpnYJHvCxgasYht4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ov4dcVHYqo40sDK8rUhcBRUI0iLL54g/MaAC74+Hwyf9i19q4ThRR0mUMNpejA0c7
	 c7C4p1xyliyVvtNRRuqiHhBYKs2RhIofPWe0vo392w00xIVEPCkX8mcpOpbxwtXbmJ
	 qz3FoL9Sa0sJNqx1400f+X1K+LZvayc0bWr8SzlrENKaGIKIizq/2oj/XD0N7vSEVs
	 j/WoEHIBZS5qjrBcaoiTLZAWq488P+XrLgZtl/U57oUjSK/nTi0tTpgoJLCty8eAw3
	 K+QuVaRNz9krLzwVMgii5qIMhvY00pKklCr9FyddUTIvDrHISFMuB2NLt9bWZMBysi
	 87THvtGNQ1eUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 042/486] dql: Fix dql->limit value when reset.
Date: Mon,  5 May 2025 18:31:58 -0400
Message-Id: <20250505223922.2682012-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jing Su <jingsusu@didiglobal.com>

[ Upstream commit 3a17f23f7c36bac3a3584aaf97d3e3e0b2790396 ]

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
Link: https://patch.msgid.link/Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index e49deddd3de9f..7d1dfbb99b397 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -190,7 +190,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.39.5


