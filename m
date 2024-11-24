Return-Path: <stable+bounces-95089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436269D75C7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF6B42E69
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE56D194C67;
	Sun, 24 Nov 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yomgni01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75429217F45;
	Sun, 24 Nov 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455932; cv=none; b=kqZC3y0nfy23APgllGpJ6iSmSltbfZDfUkpf76hw2NpU8PIBd+QphJR6tViB4UWpVFpY127iiK6E5LZKhPyyZDRwjPsjcaa9Sac1dLTlKGS8YHsDqizwEarOQTgf8bgPFlESwOh8W8HdER43ah44X4JKi0IVdCDgaZXEOTOqzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455932; c=relaxed/simple;
	bh=tdq7CB7sYCM2OCnVIj3XDtDuwKU6P+fqhq+Tzo50ocA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7KBCYB7kMDTY4yg7QGomx2uo8ksYhYLZyRGgi0j4nKw+D5KHed9ifrPV9SB1Zus1dtUFm34HxmGSuoU4nYdhGP7c7+vgJYphFpphAE66xIDSQ9F3/t9ihYgTlephitI5rJaNqppfptVclu9Q6LvFzNIHCFvzBNS36km+76XMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yomgni01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79079C4CED1;
	Sun, 24 Nov 2024 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455932;
	bh=tdq7CB7sYCM2OCnVIj3XDtDuwKU6P+fqhq+Tzo50ocA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yomgni01y9FSAFa5eRqsUa7tcwhkYaczXmzhzYJypQ80dBbGZk9b4W9I2GLurnDxm
	 3CpGZlGCI3UIMOPIIVaov3lkn0ZBYIowMl0ObBvyQxjk8LfhnM6D1WQn9trhb9S32H
	 CDnJmN/OMC5gHMfyZnGO7ikDTl1UkXQzj2ZSdUuqAJn5ucXpMS+/SHzxRj2jYJ/H/E
	 vkfQYP5iR1sonD/QxjHD+GeA6YrXl4vctqGtWgH4Jv/E+Ycg6WF0Sfb1ewUClTxrMS
	 UwGG3LbVc3A+QaaCiUl79mJRnCTqlES9EnXKWqC+8yNDIdmrqbdKAbb7WjXM/RRB7B
	 vUgUrGGV6hb9w==
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
Subject: [PATCH AUTOSEL 6.11 86/87] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:39:04 -0500
Message-ID: <20241124134102.3344326-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index a6fe88eca939f..82174b02e2677 100644
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


