Return-Path: <stable+bounces-128672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A3A7EA58
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C04188EA2F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C90263F3B;
	Mon,  7 Apr 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxU8YSAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAF263F29;
	Mon,  7 Apr 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049639; cv=none; b=eE1dDr0ohW2tXjpNZW2P5Crnl2pSs5mttiggLUZ94Q7HlcW9zoD4xgA74Oo7w9KjUUXris/zmQ96QZFOFNhZtaCbCQiWVunLPkIfv88K/gKWo4BB4ilKig2uT6qtTTKyii16IZtgYaht2MelHHPeDlrUzU4pnmPLLYqbQU3GpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049639; c=relaxed/simple;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwD51zxcir6GEPKG89HZhzFhyUDZ58RfA1vnUO4zshXEUJvkyTbrt+cumoM5/HRMUI7xEVA0syRpFzz0yuw/g4PGdOPQiNSnzgyDyPi/x/5LKO14hM7L9FX5a9EqeZNTrnONpfuB7qDHkd4fHU/3x1W+oMSJR+2tgNZNGV9HtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxU8YSAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A01DC4CEE7;
	Mon,  7 Apr 2025 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049638;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxU8YSADFs8rBmLZk7+yLUEcRKBgcdQ58Fpvb1R52gAJu7qqdUpU4Phx6BwxNKtQN
	 f1+QoyU4fuJLTs3m+qh0ZcqVJlXbSRBc9d7aMRtX52qXXAuHa3JZ7QzBs/BYmdD5Ld
	 DtpUF9Mq+bLr/Hm5c0kBJp/ErNzuR3tHLv6FQO27+1LOSYqa093W6QXC/P63wcS77u
	 kzI/t7jX4K1TMmpEowz7q3nRr1z2OOUTPMVxfGjMqyy0azdz53A5IKVtFU/LrVyrSa
	 afxpi3K+MsTR+reM4EDq7y5G/uIBsG5RZ5doWGdwV+JWQB/Sw1cyR+FoKcP51Og7kR
	 OdTZy/UF3yPSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	richardcochran@gmail.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/22] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:13:24 -0400
Message-Id: <20250407181333.3182622-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 8c75f3e6a433d92084ad4e78b029ae680865420f ]

The variable d->name, returned by devm_kasprintf(), could be NULL.
A pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://lore.kernel.org/r/20250311012705.1233829-1-chenyuan0y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b799..a09f72772e6e9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
+
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.39.5


