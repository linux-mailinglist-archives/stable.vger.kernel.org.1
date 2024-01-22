Return-Path: <stable+bounces-12621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 312AE836AC6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842EDB2DF11
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F0D137C2C;
	Mon, 22 Jan 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KemMJ8ht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED87137C26;
	Mon, 22 Jan 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936482; cv=none; b=msCFUH/9hH6GLlZ/WF0YoYUhjhqdNthrPv8X/abhrAc6bMHP6FXmzxxE6uzib9tTeX5oERn7DhobtRhcRm44JejBZrV2QQOIAFzIiKi8XTcYFJNkMI/kjlyCBgVFaEZHdS0A75X13ckKQCB3hkLj6PU0aUssBsukNWEqNk33aqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936482; c=relaxed/simple;
	bh=CUVrPHTH8Bl42ciFheRbDL09XZRQRK4djqg71B1JyFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shek9EZFrCPVNyZBEGUJchPKIJ20V+0mF/2ac9cRQMf5G1vvXlZXbAkCoL21QJCK3X5sZTZ3ZsWyKC2ZuaaGKSVa4ryF81DFR+WGJm2F1SqKJ0JLsiWrI4S7l0FmURD9rPXJ8cWjkMgul9Szl9a2MRdOANHN61rlxLP0jl79/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KemMJ8ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75B8C433F1;
	Mon, 22 Jan 2024 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936482;
	bh=CUVrPHTH8Bl42ciFheRbDL09XZRQRK4djqg71B1JyFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KemMJ8htdOjv3edhUKsXsSRw0rooIHobzLaKGKs8fnGkRHxMUQs26koMdZB8pmjYR
	 WdbbpxK//cFVGDiZL8COwqS3XVMlgAeOxVPGo2HCwS3IKGTxjzvU/VhrBU/zP0mpuo
	 73WAcgB/erAlA/WB50jCMF0MGmZB+nSxKqCIh46NyyQlwhH2SULVNWQVcfFejZOTJb
	 EulHtQDRR7Ar9r52PHaccg4Ajp6ZIde7K3H3Q4NY7Bs2wo2iZPmEBDlpKz6vwFfzOk
	 /DBaqivyvPvXUZN6yES7UOpHwRiyTuT7UpZ6b/DvOf+q0ZZgv9XYdEJLOKSOtLeRmq
	 TsGiAtNWDzqkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	linux-clk@vger.kernel.org,
	linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 31/35] clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()
Date: Mon, 22 Jan 2024 10:12:28 -0500
Message-ID: <20240122151302.995456-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 21c0efbcb45cf94724d17b040ebc03fcd4a81f22 ]

In cases where imx_clk_is_resource_owned() returns false, the code path
does not handle the failure gracefully, potentially leading to a memory
leak. This fix ensures proper cleanup by freeing the allocated memory
for 'clk_node' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/all/20231210171907.3410922-1-visitorckw@gmail.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 1cee88b073fa..89a914a15d62 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -841,8 +841,10 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
 	if (!clk_node)
 		return ERR_PTR(-ENOMEM);
 
-	if (!imx_scu_clk_is_valid(rsrc_id))
+	if (!imx_scu_clk_is_valid(rsrc_id)) {
+		kfree(clk_node);
 		return ERR_PTR(-EINVAL);
+	}
 
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
-- 
2.43.0


