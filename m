Return-Path: <stable+bounces-95295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795AC9D7500
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E366916819C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FB24B779;
	Sun, 24 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khcNUxyH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B924B772;
	Sun, 24 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456611; cv=none; b=nrVFH7DXz3064s0eLoPpIInFNtJ9QaqVIjnlx7LmjChOR7zJj1kDQIxZ2UU/v3K94TxPbuM7tnhlyz3Zpvf1/9fbs42ZO1V1LxV0JTZk4i1XLnQjZC835wn4YjTf911yYYqMrCfMnrzT3b5evJaKjnLzdkgM+TYCWaBlrRT2au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456611; c=relaxed/simple;
	bh=JlTdB/S010SujNxB1HhTlYLdFGB8pILgoz7V0BYlm5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZkHNnt4M5dAIX8Ob/IKczupK8novj/iskMUlcx6m4Zggby8/V+JfNj2Ln4v4Cxur+ZcjlE2w14rLCDX7MT5ax9kXyx41x1D8PQPT1UL5L/cs0IsalWUuZWibp/Qt/2+vVSexm44Jyl6zGlKJAEfEZ1LzGnQ56cj+3dhHwe8eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khcNUxyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A541C4CED1;
	Sun, 24 Nov 2024 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456610;
	bh=JlTdB/S010SujNxB1HhTlYLdFGB8pILgoz7V0BYlm5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khcNUxyH/1IosM318fWHK0fDqqwkud7OS5gqnmaLgPpqHtfPiKl5ewGkos8zBNtp1
	 f/3czvi8qO+ANKkww8Clg9VUd4BGQdz69FUPNgzC2FUdfyvvW6bC+5DUh2Nu6Io34o
	 no81CUd6Wm8Weju5lRk3bGg19qBDBISvAOJYdzy3wvNUYZQgd+FaxCN+LrST9eBU3d
	 xNsNzy2ml6eV/OdQH4RKaqQSN/g1mgtnXjjTFVDoVruH5PLTsBMeiTFF54fwYlq2oz
	 y8CdH1SXIEIKmBo9jD9KNHDH4q/YYu15109aYDCcmSdw1g8rO4PjQJ8FDszac/5tn1
	 rXeYn8yihPZ2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/28] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:55:27 -0500
Message-ID: <20241124135549.3350700-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0de6a472c3b38432b2f184bd64eb70d9ea36d107 ]

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241115003221.733593-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e571007d083cc..4dfe17f1a76aa 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2734,6 +2734,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


