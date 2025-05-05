Return-Path: <stable+bounces-140267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A32AAA6CC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A5B16081E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1432EDEF;
	Mon,  5 May 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjNX+s4g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5F32EDCF;
	Mon,  5 May 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484535; cv=none; b=Et4/rX82Tu+xqScqxlWiwouAYStdaZI31Gm3XhiF7H36mjW5ItVBmNBUoMmQFLwZ80GnXHc8DKhy0NzZkEkJ9oPBzAvyIfwPgU9D54jv3iTzSoaKXpLEWdrRpjN1PUMckm6UMXdm5XilqgVyllUXifphOsp+Kf5jGgfjidY1uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484535; c=relaxed/simple;
	bh=3ytZPvvlRFrrlLBWurwIWAmr/1Tw6462yNR8Huny83o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmuIkXtOzHZpHb7qovPruxUyHcHLg6haUgOcKCpo26Z+R3B3cqhimMycmhRywW5jo8y0L0voERJyZLWa4zIAuh3+LM9epEwpROQv4MTcHyDS3BaPyzHxXS2hWcJsbUBpgFOau24t6SuuOqcYCLHYjklUm79kRs3xYy1Bh6/QW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjNX+s4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F77C4CEE4;
	Mon,  5 May 2025 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484534;
	bh=3ytZPvvlRFrrlLBWurwIWAmr/1Tw6462yNR8Huny83o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjNX+s4gY2GA415r78nIv9U+aZ4PyO7TtJWJXRYAcccIiXBuSnWQ4D852vfgdxrtq
	 oWb9lyGx8D1h5FMhWyZg6zM1nN9LltlE6z7CzEXz9XffTJluW+oyRQurUAznIwk/MR
	 vRIKP6atEt3IbaB++LXttZywjAUjST4fVO0I3MF2ou8XgCBTZguI27uDlgKlcow3lZ
	 Vj+lQk8VtmKnws4VwyloqSDDoPLhs5n8xJ6JRS2gfrYgACWa7QViuhHxhQQ0I7iWX7
	 9sJ2VdsvBDBKLlMivqsymY/buXnAKsZnQYP/KF+BVDVhNYUiA8FVai7cfEmoKc50Il
	 i32UE8gNtLxLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	przemyslaw.kitszel@intel.com,
	daniel.zahka@gmail.com,
	almasrymina@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 519/642] net: ethtool: prevent flow steering to RSS contexts which don't exist
Date: Mon,  5 May 2025 18:12:15 -0400
Message-Id: <20250505221419.2672473-519-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit de7f7582dff292832fbdeaeff34e6b2ee6f9f95f ]

Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
when in use") we prevent removal of RSS contexts pointed to by
existing flow rules. Core should also prevent creation of rules
which point to RSS context which don't exist in the first place.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20250206235334.1425329-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1c3ba2247776b..0d3a70a18884f 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -993,10 +993,14 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		return rc;
 
 	/* Nonzero ring with RSS only makes sense if NIC adds them together */
-	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
-	    !ops->cap_rss_rxnfc_adds &&
-	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
-		return -EINVAL;
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
+		if (!ops->cap_rss_rxnfc_adds &&
+		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
+			return -EINVAL;
+
+		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+			return -EINVAL;
+	}
 
 	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
-- 
2.39.5


