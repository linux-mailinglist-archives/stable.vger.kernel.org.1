Return-Path: <stable+bounces-141267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C21AAB20E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A45E189E163
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DDE41E592;
	Tue,  6 May 2025 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSvih+rN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92027FD66;
	Mon,  5 May 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485645; cv=none; b=fpKjmy8TRi8WHleUmRf5QH+dPeLWMXqTCENuDFizEbnwYTVUEykZurSQ7LFWkksxWdvChIFkv0uXTmemfA+enCfwwu8kE+zPU8t+lIuBceop/yVFJGoniWmVe3/HJomoCJl3J/FPHctaNZO9hFUmE7IcKNb3nEAJr8UsSzAbyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485645; c=relaxed/simple;
	bh=TtXmyqw612RsfiWMAd40wXZ2D5IaG3gtXNdnkD/J204=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKMG3nTqbo2B9025QjhvhvWi9bPpOh9U5xdjlBjjI4P3T0v8Jvd3LFWgdaU6GQfFQWX/QBQVus2RVtPGy7TdqYSSPmqaP+3OzZRAb7z6hIFdAwmLIClDIh773gRta980BhuYHlGBZBZTeVhCpmi68lysc78f4I8lHqXv+dyfwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSvih+rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A476C4CEED;
	Mon,  5 May 2025 22:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485644;
	bh=TtXmyqw612RsfiWMAd40wXZ2D5IaG3gtXNdnkD/J204=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BSvih+rNeiqT1otowVHmUSr3+CPCVoTG7mUtZIymnUvxuiDXIbiMD35hL4KwfOWGJ
	 egkgzs2HJnNV6GrbIudZI45zZAPDUI+PWIPGZ3Nl8Rlg8nQFDzagX86N4N7hTBKGzq
	 fzITHxPfR+rOMHecm+P3rFP9Tu2jorcY6ZDulz72QSDgPQKyZ1BuA3ywafgDQQZDDI
	 vquiV/PVFRjyhFd/mMCbYEARyY7TCQu5KkaJGNsXtH4NcgLtWuoAibZ1nT4eRZ5LOY
	 G8Opyye9/eKVL3I24fUh2AWwDIcRRekP6aowVq8BDUd52ATrWye/JM1hmLn63h9O81
	 m3gLUIs+bw3kQ==
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
	przemyslaw.kitszel@intel.com,
	gal@nvidia.com,
	daniel.zahka@gmail.com,
	almasrymina@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 402/486] net: ethtool: prevent flow steering to RSS contexts which don't exist
Date: Mon,  5 May 2025 18:37:58 -0400
Message-Id: <20250505223922.2682012-402-sashal@kernel.org>
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
index 8b9692c35e706..6ed01cec97a8e 100644
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


