Return-Path: <stable+bounces-198808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B08CA13BA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D59E3005C7A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66934D39F;
	Wed,  3 Dec 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/83n1cH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AE34D398;
	Wed,  3 Dec 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777748; cv=none; b=crPqy5Kn9eQ2yWNHeHakN4wJiP2CMO2tQzRYhpcmXqBgO1igzDdiPdqduYfwhMM5qXxKcLH6fud0jqLtBxVJko3hxiHg/eY05klqIb/dQ0FbRyTRNQi/ylfMHjfOSCr0yNv8D3qGcGzhU3SWsun8nJxxcrvkOZOlqnyQrtbyHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777748; c=relaxed/simple;
	bh=ub61WnPxIRJXVut/vTJGQcG9QMrFEG/DLjXIu3arw74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSuyXMGHVYwBkFQ921Q/SFH14E4RKfv07GkV/+14d0zZMHYJHQ1iBCQT1IRy39/XjYVKBBYkFNl2QM5MBhEB2Vngc6z0dJEv1p1MezQHRdldRYE7niqZdZ9Rvr/ejoT0ZydCe1ZZnbZqN32Wpyd/QbJEQP9eh77xzlc3g1zjPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/83n1cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967AAC116B1;
	Wed,  3 Dec 2025 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777748;
	bh=ub61WnPxIRJXVut/vTJGQcG9QMrFEG/DLjXIu3arw74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/83n1cHZUIHavSn2wExaQc+kFfFQYRwXxtJ+BDUkB2XodwX0RBAzwBQGrmeyCMlb
	 Sh6kR4gDJlr/nX9CcZTZkZCaOq6y0XF4tx9EPnh5SNLdMpMTATNHi6SnS1pPGMJAhd
	 qXyywhnf19GsYPne9ejVbRMLa0Nx8PvMCAO+QPV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 102/392] net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
Date: Wed,  3 Dec 2025 16:24:12 +0100
Message-ID: <20251203152417.852982573@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 6896c2449a1858acb643014894d01b3a1223d4e5 ]

stmmac_hw_setup() may return 0 on success and an appropriate negative
integer as defined in errno.h file on failure, just check it and then
return early if failed in stmmac_resume().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://patch.msgid.link/20250811073506.27513-2-yangtiezhu@loongson.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 21cc8cd9e023a..973c60e013344 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7487,7 +7487,14 @@ int stmmac_resume(struct device *dev)
 	stmmac_free_tx_skbufs(priv);
 	stmmac_clear_descriptors(priv);
 
-	stmmac_hw_setup(ndev, false);
+	ret = stmmac_hw_setup(ndev, false);
+	if (ret < 0) {
+		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
+		mutex_unlock(&priv->lock);
+		rtnl_unlock();
+		return ret;
+	}
+
 	stmmac_init_coalesce(priv);
 	stmmac_set_rx_mode(ndev);
 
-- 
2.51.0




