Return-Path: <stable+bounces-220196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAAJIYguo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA311C5683
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87354320DFF1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7C4C957F;
	Sat, 28 Feb 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH96b393"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF24C9577;
	Sat, 28 Feb 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300102; cv=none; b=LSt/Qc1W2sTZ7Fyt1SdrIJvJBvNfwh0Q7NIni9ywX1v6Fjmp/rycsxWY8yPcZUFJSbQ25KwqVIi6VzCT0HzuGWWyy5+Qo6jjPXxliDYCjbXKF0bb743BUoCxKRe4C5/rhinhUJN/iesAcovgJ7JIkFvITM/kQq8CG7Aa8RbblDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300102; c=relaxed/simple;
	bh=uZiaFSzPj05fK+Caj/goHYRSBC6v9HZFf3WZoHgNqrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVeTqCV/HS7/x7YX5i4Xbu2PAV4BxIi8oMtBfvw0B6PS4XIDbx9oNXrjxYkAU4B5+909efulgp4fkCvzi97wWO4ZjwrGuNWcfiRlqba+qk0CTJD15rFhFOgGW8k5I495f3jNydFUL/GSCxM3C6oBcyN7F5LOA1YizrJ3zCzlHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH96b393; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80168C2BC87;
	Sat, 28 Feb 2026 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300102;
	bh=uZiaFSzPj05fK+Caj/goHYRSBC6v9HZFf3WZoHgNqrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NH96b393xCqy+49/IWoO0ROc41LF9oUtnAGxBkMIylxqHbwForToPWleiG+A444tZ
	 qliyPXZVnsQVP6AmpZPr0/K5EXCSeSmgsfnnywAIbOISr1OHVuPeyKq/J+8ppfBXo6
	 cW3OODVb3CxkFC+hiIZgUgDwgEnEPdOrCIsUrjqdYIq3TauHWi4frfs+9DbV8gg0ac
	 w2/eDeHygKesYakAnNYYyOOnsLvLyLchbbF5ZfKxLfSOIfX2BAjZpRlUZWBnMg+69Q
	 5piDlTgSp5bjBqpkyBk+Lff5kwxq2+tfXW+GCHQVemZ4rzOgx7iJii0RSDdCBQkY6D
	 kaeMDo3FqxiNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 118/844] soc: imx8m: Fix error handling for clk_prepare_enable()
Date: Sat, 28 Feb 2026 12:20:31 -0500
Message-ID: <20260228173244.1509663-119-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,gmail.com,pengutronix.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220196-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 9CA311C5683
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit f6ef3d9ff81240e9bcc030f2da132eb0f8a761d7 ]

imx8m_soc_prepare() directly returns the result of clk_prepare_enable(),
which skips proper cleanup if the clock enable fails. Check the return
value of clk_prepare_enable() and release resources if failure.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601111406.ZVV3YaiU-lkp@intel.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/soc-imx8m.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 04a1b60f2f2b5..8e2322999f099 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -148,7 +148,11 @@ static int imx8m_soc_prepare(struct platform_device *pdev, const char *ocotp_com
 		goto err_clk;
 	}
 
-	return clk_prepare_enable(drvdata->clk);
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		goto err_clk;
+
+	return 0;
 
 err_clk:
 	iounmap(drvdata->ocotp_base);
-- 
2.51.0


