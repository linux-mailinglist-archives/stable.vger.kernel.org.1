Return-Path: <stable+bounces-128724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4162EA7EB32
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAEF165B5B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60226B962;
	Mon,  7 Apr 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhHBcldp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEC255E38;
	Mon,  7 Apr 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049760; cv=none; b=ase8k9UCAwGeOPw+GD15bLKz3NocJWDAfD/ofHUDAqsuDcmxJzZMjpVEUQl56YQhXC1XxnFYG6Kod8yyUuwDpXJuBADhxdv1Y+4y1A9RwcxNZkdmM6ufmhFI0tgfrQgO3W9pxLcWgXmUJjq/PIATT71CycjBikU8Jut3FRswqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049760; c=relaxed/simple;
	bh=k13xiQCaT/GS6dWcuXlaBInjqnzPmqms2Dv69by3/rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPjWI8ABFE98cOk2y/9n28yLvfk1w0Q5fNxHLyscjvgAWSLz+6fzvD3zGTuMm9WEx1xC5uh353j83D9D4zVkij64u+ddw6YOzTIEtneIw7pe6PlMP5CPQovJJPyhFmjGTj4eW9a3MylTc1sRKpiQtnQHuWql5NuLoLWpfbkGyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhHBcldp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B4FC4CEDD;
	Mon,  7 Apr 2025 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049759;
	bh=k13xiQCaT/GS6dWcuXlaBInjqnzPmqms2Dv69by3/rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhHBcldpetwj+Px1tlBUuWitjT07SZP+IoP3R9vvpPEOWbLi8eKgSyPqXXjDd99d5
	 SD1kdDcqxtHEt8+TKorNtwYKWKztXuIBgxmfJqtKWgTtNO6n6a+r+uFOgtZr4k8hHP
	 V5vGz/SdpNfX2wGjsQAdADsYL/nk+5uACGIOqYngshyIEhWoJXKRrCjiMYHyqmic2X
	 AcbNGhrZNhRjnp4ErPrGyD2eZSEJzynZRWYb3hYkrapgqx0foxf7BffNp5cETvDIzZ
	 Lo6AEiw378Xfb7aX22M1HJocqeS37bitc6+d6P22TXh33hd+BPQFuq2oWqwqYJLFDn
	 EM3urwhIEDsOA==
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
Subject: [PATCH AUTOSEL 5.4 3/3] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:48 -0400
Message-Id: <20250407181550.3184047-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181550.3184047-1-sashal@kernel.org>
References: <20250407181550.3184047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 4008e7a511889..89d7d3b24718d 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -542,6 +542,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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


