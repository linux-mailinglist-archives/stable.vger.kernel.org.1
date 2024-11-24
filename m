Return-Path: <stable+bounces-95002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35B9D722E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0464B164772
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CE1F6668;
	Sun, 24 Nov 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOt0Hc1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D561B983F;
	Sun, 24 Nov 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455540; cv=none; b=Y6eyqaXD/E/RCB1bI9lj4gz6pWEgjiL/xPWtQ838Gzru0leRiUeFh1cuJr+vHzuUcEj9tn3fTUrCwn6rPWkwMG8ekWeOG3CBRJXjQQFdi8I8NkM14QshPXQ+Lrw97VKPYpVtrZiaZT5E+j1rsGQMg58zzE9OCe11XwFECYRW/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455540; c=relaxed/simple;
	bh=+Ie0C/59+iKF5VCxKNk6LEwABQxfj6qEtGK8IVG+vKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvPlj25H++qoR8COZJX8ZPHYzGSVoPnEuomi3cMrPHaRd+aR9CZNckQn3q/tIGevrcb2N1XSCgZGO0Trvo9L9TNHnFs9XoyHT5ySGsUw0u0yNR+q82z74evR7CCFcXqMY0fBHToudhfRPY1IpOeiBYErksIrSpDYVkYUB2Q8+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOt0Hc1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE482C4CED1;
	Sun, 24 Nov 2024 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455540;
	bh=+Ie0C/59+iKF5VCxKNk6LEwABQxfj6qEtGK8IVG+vKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOt0Hc1gWLA0RgT7ZiJfTogo7XmP2Ms7q5n7YTUhMM5Ja7wUws7dORhWydAFGKhC5
	 kzL96mEFuFt054o/tH6VN0cU6tJ49BZ+ILisVFxrhHmoRBYqErlNME7UyOMT576v+w
	 zr1/xZS58tpfyjLHcu6n55kwgsOp1dL901UIeR55VALuyN2qdN2gvw0wheD4Vzq7P/
	 GNZDwsJ4DhGshDmIw436ENVA8fl+e4jq4SXamQp3z0KjtRvOIPIQduSbI3AmNyPP7e
	 E77K5n/AfFDQ5ngfCWuNfbjmBRyeqMvHRdcAKcPuwgzhaS5WzY67xjQeL5mH0djEAg
	 eU4SVMEx1HELw==
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
	James.Z.Li@Dell.com,
	lizetao1@huawei.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 106/107] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:30:06 -0500
Message-ID: <20241124133301.3341829-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 77b819cd995b2..cc58315a40a79 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2876,6 +2876,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


