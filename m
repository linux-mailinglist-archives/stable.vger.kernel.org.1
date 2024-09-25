Return-Path: <stable+bounces-77586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512D6985EFA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0281B2C0A6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC53217334;
	Wed, 25 Sep 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ8dSteg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C621732B;
	Wed, 25 Sep 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266381; cv=none; b=jOtXo+I+BT2orAbpOY0vk82R9rfZneA39MtzdJBvref53mkqiPkINTL42xdQD53gvb332dFh7rS82GNggfZX52vkv8XcDXzQJhwZb1NpBgpKcu9WzuYp6JqrLivRwrE9ilXzO8xaKSFZTLwgRlgor4ZiPJxOIGP5OZua3+1D52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266381; c=relaxed/simple;
	bh=xoTFhBnTc4Snj/E3xhe+4mYR/X98uCTUSeSuEr5NlEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+V4/DmeyyV7+v+0Np0z+xRPS0fSZ4CjLvC6A5aNjIBWp1Ngev9UgY82Bie2XnQTmc/XOipH5G9HghG8OLReRCBxGvAkuniGr29J4PcJwSFckjCZhHuy8HVPRJv+l2QHSAiNVGj7l0JTjmWPisK28HGiELmg29zu30v/XdLR1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ8dSteg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95CC4CEC7;
	Wed, 25 Sep 2024 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266381;
	bh=xoTFhBnTc4Snj/E3xhe+4mYR/X98uCTUSeSuEr5NlEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJ8dStegozHAJDfVk9CSsNklHhuazvseEt4HMbr59iOYuT423Vsz/UqM5/792Ecm3
	 CGur1jO2xx+bJ6+dsd2MJjqTQVmfU+LsKm1qO94OZY4OyzBL7wWoDFWunYBsGueyd4
	 9ypCxTNGBKTrmFSet57U3p4b+bMPILTvxPmHQazqq/dDqUS0KDswGykkC+MwjuzeaK
	 VXFwJ7+UAELQWJhs6Ny5BpWJ6/tCzsxsKGfDxaNk3UDblxHhBnzfeiPBfmibNtOA8Y
	 aCaEVhkV3r1d5jbDmNNFVSWOeNgldGkB/2V9TgN9tkmN6AVyZOooxJd6DDMUzGoJ8S
	 g6IrjpsZc6Y6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	irusskikh@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 040/139] net: atlantic: Avoid warning about potential string truncation
Date: Wed, 25 Sep 2024 08:07:40 -0400
Message-ID: <20240925121137.1307574-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit 5874e0c9f25661c2faefe4809907166defae3d7f ]

W=1 builds with GCC 14.2.0 warn that:

.../aq_ethtool.c:278:59: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 6 [-Wformat-truncation=]
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                                           ^~
.../aq_ethtool.c:278:56: note: directive argument in the range [-2147483641, 254]
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                                        ^~~~~~~
.../aq_ethtool.c:278:33: note: ‘snprintf’ output between 5 and 15 bytes into a destination of size 8
  278 |                                 snprintf(tc_string, 8, "TC%d ", tc);
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tc is always in the range 0 - cfg->tcs. And as cfg->tcs is a u8,
the range is 0 - 255. Further, on inspecting the code, it seems
that cfg->tcs will never be more than AQ_CFG_TCS_MAX (8), so
the range is actually 0 - 8.

So, it seems that the condition that GCC flags will not occur.
But, nonetheless, it would be nice if it didn't emit the warning.

It seems that this can be achieved by changing the format specifier
from %d to %u, in which case I believe GCC recognises an upper bound
on the range of tc of 0 - 255. After some experimentation I think
this is due to the combination of the use of %u and the type of
cfg->tcs (u8).

Empirically, updating the type of the tc variable to unsigned int
has the same effect.

As both of these changes seem to make sense in relation to what the code
is actually doing - iterating over unsigned values - do both.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240821-atlantic-str-v1-1-fa2cfe38ca00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index ac4ea93bd8dda..eaef14ea5dd2e 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -265,7 +265,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 		const int rx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_rx_stat_names);
 		const int tx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_tx_stat_names);
 		char tc_string[8];
-		int tc;
+		unsigned int tc;
 
 		memset(tc_string, 0, sizeof(tc_string));
 		memcpy(p, aq_ethtool_stat_names,
@@ -274,7 +274,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 
 		for (tc = 0; tc < cfg->tcs; tc++) {
 			if (cfg->is_qos)
-				snprintf(tc_string, 8, "TC%d ", tc);
+				snprintf(tc_string, 8, "TC%u ", tc);
 
 			for (i = 0; i < cfg->vecs; i++) {
 				for (si = 0; si < rx_stat_cnt; si++) {
-- 
2.43.0


