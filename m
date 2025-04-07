Return-Path: <stable+bounces-128617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CEA7E9BA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FA37A55F8
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16B25742A;
	Mon,  7 Apr 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id44oJdB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58D21ADC3;
	Mon,  7 Apr 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049503; cv=none; b=ARVO7cvTtsNWHGo3SHJMeaeo2gX/3vt8Q6WNdxKPqb5rHzIxC0NUmGL4Tvn+v6by1Tjc2JarNIL/YNuPNAIJWjbxLUUTS1fM50dpZ0mcodjPy8+JMkBEfR862O5ZYhJXNTlKcuA0PBiuHUk3Oj+a+vsM8i4vj66yRzMNPSnTEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049503; c=relaxed/simple;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffIt1kFKdeqAAr7NuHkEPUO/98l6iuWvQO4So1Pcx334WZT/f5b+ObpRGGcNj3HRzYzDfUKTtR79B2nor+saS8TtnTRnV68Kwj1H2zUqOqQ/avZxMiIPBSJ2Er963w/YAMc4pMT9wr/MltS5x8tkxJpCNBSK43BpHhSgfyJdBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id44oJdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918E1C4CEE7;
	Mon,  7 Apr 2025 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049502;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=id44oJdBgOQF86LPDEiCyCGFB1qCcMT3d1hZI68gUWH/YfNLqHv+eo6wDhHLqTfc1
	 zvHjIMoK92PZK/JNSs/SRM/b/0wPyrBQP1ovbwKNi4CBUi94fU+JhueJIQ+8uadgCr
	 sfj8l4C0IDemViYL/o2L09bMrbOPP27804tx0C1Snv8sqW2mQ3KloUQAyxl+Q0zH6R
	 VGlMQmJBW+5z/Xv3UghlnSjf6tKJuDigc+sXv4VfNaXE4YltoZXCEDq2F4qr2WWkAy
	 A5oOZocyMdW/fZkwqz8nYCP7y3WNd7XOJNaWDXZaRhC/N7F70Eqh/p8XeTW5CS9osc
	 xWkrONzo44COQ==
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
Subject: [PATCH AUTOSEL 6.14 20/31] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:10:36 -0400
Message-Id: <20250407181054.3177479-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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


