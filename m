Return-Path: <stable+bounces-211907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBNNLQ1feWkXwwEAu9opvQ
	(envelope-from <stable+bounces-211907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 01:57:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB99BCB5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DCC30138B9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588C1B3B19;
	Wed, 28 Jan 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXeLqpEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4E1A2545
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561865; cv=none; b=SWH91KeNTAvIFnynl9hVlCCAAR7fxWlJ78EsTXiPMbNPMvGx56uj/mGh6hfW4KNiLJRd+W0UjmD2I5UT1LFzoYNPmDq/dFM1E2E+iG0BdVfdBhU5eC+X5ro5/EfiH2NkajX05z1ckcnJlRvSrY0IQRkP2n5CcB/zQkuY9L6waAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561865; c=relaxed/simple;
	bh=cvtMEJHL6/B/3US+ewLrpaN3g6Q5b4Rw916q2DlwIRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3k+uVyoFPfQL8y5YEIqIg69GyXYS+WId7cRDNjkEyRO56NcLH+INsOIK2LFk1TTSrKUhOAKvGYl8ksG7xXfmwN/8YCwXIHgYhPl9Iyf7PSxaJ+z+rERXuG2kttmZcC/9ol/7yMpBAdlttjX5syAzDEOiTg8MtQO3tWd+oKpajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXeLqpEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1608FC116C6;
	Wed, 28 Jan 2026 00:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561864;
	bh=cvtMEJHL6/B/3US+ewLrpaN3g6Q5b4Rw916q2DlwIRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXeLqpEa0ZvTYvGgGTVN6c8kFOmDcbqzK3Zmt7h2q4RD95BeeeqHrQeYkguaTcIsq
	 h8WTr1506nStRwPMrViRUd5t70wly+8zct6OcRrAXU+yfaiq8fb433eZhW7odLhkuS
	 IBoozX6gzd+qn9YfWTjRySRpDrsp0/0z1zBbnUYLraxvHVN1iBB7SZkob8d0fk8Gnw
	 XWtxOXDkHbUnLoraPVKZE/McQ8PkOmMyt8TmvpghRm1mwl+2GZsRjZVk3EW2vgrOeb
	 OWkNnah6A1pSrZV2McZzivyHNhEVCL5IxBFnwZXlHBn7dJ4Gj95T0HGAKMhmkC8/q7
	 535TUGuPXDZCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] of: platform: Use default match table for /firmware
Date: Tue, 27 Jan 2026 19:57:42 -0500
Message-ID: <20260128005742.2301675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012750-reshoot-angler-7553@gregkh>
References: <2026012750-reshoot-angler-7553@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211907-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 11EB99BCB5
X-Rspamd-Action: no action

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit 48e6a9c4a20870e09f85ff1a3628275d6bce31c0 ]

Calling of_platform_populate() without a match table will only populate
the immediate child nodes under /firmware. This is usually fine, but in
the case of something like a "simple-mfd" node such as
"raspberrypi,bcm2835-firmware", those child nodes will not be populated.
And subsequent calls won't work either because the /firmware node is
marked as processed already.

Switch the call to of_platform_default_populate() to solve this problem.
It should be a nop for existing cases.

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Cc: stable@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://patch.msgid.link/20260114015158.692170-2-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5ec..3e1be88847e77 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -533,7 +533,7 @@ static int __init of_platform_default_populate_init(void)
 
 	node = of_find_node_by_path("/firmware");
 	if (node) {
-		of_platform_populate(node, NULL, NULL, NULL);
+		of_platform_default_populate(node, NULL, NULL);
 		of_node_put(node);
 	}
 
-- 
2.51.0


