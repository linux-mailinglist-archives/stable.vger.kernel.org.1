Return-Path: <stable+bounces-128720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A85A7EAF3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103747A1592
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A526B098;
	Mon,  7 Apr 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftQIQVyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DB26AA9B;
	Mon,  7 Apr 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049745; cv=none; b=nNq7y48C+lyUA6E+PemtzgeTxjeyx0x8RKg7MahtXqT5/wcTePc39X1E0bWJY/at705+R+uqSnzWClT+wYsqjxfk8GfPalrXVFpRehjHOsB+7L88m750e7XTi6jZIWQ8hE7B3sWpxv/BLw8v0eVKnMhcxDxE3uLb6SkW1d/guxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049745; c=relaxed/simple;
	bh=ojmiIKC5JoIOY5ncsM343Ilta0QjoLb8LQTtRAMq5Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUWCz2A3+u0C3g8zOgn3bHNqTStqRuoZC9vKW4JuftGlkFFbFQFlgUHgNcq+cdOZbFIcN1M0sNtY2ZEf5y8BLv8QsYnE5hwBKEzBPYkblS/JCq3ncT4u5L0eWOT42h08yzY35xuVDlJpvpFVNqWeEzRK+xiT/ALD4ssLSBipREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftQIQVyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C98DC4CEE7;
	Mon,  7 Apr 2025 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049745;
	bh=ojmiIKC5JoIOY5ncsM343Ilta0QjoLb8LQTtRAMq5Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftQIQVyzGt536oXaO7gh8Odq9U85GV04hk2FXfqtDG6dy12mM5wjDKlUN+nLTdRWa
	 enNvRrOnDbmFaG8ZuOvGBFkjTlJOP9u4pVJEgQWT55T00nE+b9tal5LTvT1V6gVZ6w
	 d2TMzVmtZWBPOIxOiG7LqtqU5n8GYBEAF1/yvo9B1haC33k729ZRRog3qDXhZr5m09
	 Mg81iFCxWXG6K1pIbIyClp6ZTq0A//2Ve/nbPyQBmb4zVrVQblNbATjyJbYU/FXALG
	 1wy9BwUwB7cSfv4GDZ9AAd6j219w2EDEgJ7Hlnt6OlLBqUv8UM7lvwDBkZKSIBZQx7
	 Df6tDh2epdNAw==
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
Subject: [PATCH AUTOSEL 5.10 3/4] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:15:33 -0400
Message-Id: <20250407181536.3183979-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181536.3183979-1-sashal@kernel.org>
References: <20250407181536.3183979-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index d268306a7bfee..92755a2fe4ff7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -543,6 +543,9 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
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


