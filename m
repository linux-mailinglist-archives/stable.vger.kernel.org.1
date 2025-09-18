Return-Path: <stable+bounces-165422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF6B15D36
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D25A543C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E705292B48;
	Wed, 30 Jul 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzmGC5o/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB9273D95;
	Wed, 30 Jul 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869070; cv=none; b=Uys8Gow9ySNTJu56zmC3cQkoXOm68ruED0wpSP5yqcS1ZPeGj0JR4esw225UFfBnZOMShzm5K+I0hm9d9hBtNjyvfl7L1SEy5aRqnrJTlhbhKY4WCIyKtQiQgXEOrqhgXW5H2jaMpOA29vobCWwQgiaz7MXDzVGtIcmpRqBrcao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869070; c=relaxed/simple;
	bh=93C0myd6nPYgm3yUJLTvahQUEBbMjECZmTSgj4fTX5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6+2TCQCGcW3xq1YLfD1lqed+9jU2Sl/fBnlUe596M9HMO1ji3hpqyiafgdXJMcXBfLdLrq2DnBe5iFQK3USWSk7viZaDM/U129b9A6/lfcSM8xFXAxfSwWHYt07SSb7MZSUaVCA3icr8cvWnt+CIaD2erJotIopcyXV97mQKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzmGC5o/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5989FC4CEF8;
	Wed, 30 Jul 2025 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753869069;
	bh=93C0myd6nPYgm3yUJLTvahQUEBbMjECZmTSgj4fTX5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzmGC5o/A/qvya0+oyaNZM7j4HX2jSatJynp/Tz+4ZY8XIfXWwQwdMb+NTnvpPC+t
	 KMsOhtblTNyWJeFv1qaxD3FAme9E+gVNMj6V+JUlnTVAUo/OZQVkuIGbC7x87YFZZH
	 nCROEL/yKfhBTKEa0HArqC2c2z/+3NjSM//WRxqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Tereshkin <atereshkin@nvidia.com>,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 28/92] net/mlx5: Fix memory leak in cmd_exec()
Date: Wed, 30 Jul 2025 11:35:36 +0200
Message-ID: <20250730093231.846004610@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
References: <20250730093230.629234025@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chiara Meiohas <cmeiohas@nvidia.com>

[ Upstream commit 3afa3ae3db52e3c216d77bd5907a5a86833806cc ]

If cmd_exec() is called with callback and mlx5_cmd_invoke() returns an
error, resources allocated in cmd_exec() will not be freed.

Fix the code to release the resources if mlx5_cmd_invoke() returns an
error.

Fixes: f086470122d5 ("net/mlx5: cmdif, Return value improvements")
Reported-by: Alex Tereshkin <atereshkin@nvidia.com>
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/1752753970-261832-2-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e53dbdc0a7a17..34256ce5473ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1948,8 +1948,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 
 	err = mlx5_cmd_invoke(dev, inb, outb, out, out_size, callback, context,
 			      pages_queue, token, force_polling);
-	if (callback)
-		return err;
+	if (callback && !err)
+		return 0;
 
 	if (err > 0) /* Failed in FW, command didn't execute */
 		err = deliv_status_to_err(err);
-- 
2.39.5




