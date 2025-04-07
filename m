Return-Path: <stable+bounces-128646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D56A7EA0F
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7111E7A71B5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9C25D902;
	Mon,  7 Apr 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX7xthFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37325D8F6;
	Mon,  7 Apr 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049578; cv=none; b=LQWEiAcip8/eApEHx8PuGCtwSNeyZ9Ki9dwKey7kDzpF9sz+qfALEgtnnyFPRbVp8E6dpn+thnqEd0EfZYvOVVlCyGG5tFWiabINX6nucd52SRQ0DgCN2NEWxAEtrrDurqgFYftu+X42BEWRwAbzbLLhFmfF8crqbk0IxxrdC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049578; c=relaxed/simple;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQnKHUOGjkvMaFsfYL6evEvEKlviUAAhlgyCTIL7qSFlW1q7zMhEK94jXg4RmZ9tMzXHOx/OSRCsN/E9vClOBKfX33sAwRBxTFYl40NpsSdnQJvdU8gbqNHrzoeDf7cmIBUBi1pq80rfAu+r9n4tk4Md7EkzrWhkVzJfi2d835Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX7xthFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F16C4CEDD;
	Mon,  7 Apr 2025 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049577;
	bh=QBJ+dUeJc1CSohXQzdN/Y/YCiwyNb/H1CHJQS7EhYcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JX7xthFK7yQFN3HXFZHFZFmUFAdcZWRaGPaRbR0JNQe4NRXcYZ0Zp5LffamXeiky0
	 YdKE1P8r9qfOZ4UYmV9kGouGqSs0g0RSluDqqChFSqOzfy1P4vBYifru3iNGnlzhhV
	 6nyurJRdf4mAgjk3ldiaLlNKL9fVCRigYqwj67fdohZ/kv+Ws4IjNjKxC3fbKJQJw0
	 PkcKdf5viakPWY3FbL4UjsfWgDvRLaUFfdcm72ioLVbzInXokosSeEHGFNLzDNa2eT
	 Ndcj06nVv2L7J/vK/nWxVHLenQAKXb9USZawsPilpEgU91x04XN45kAIFAYshR9SjX
	 MK9SUJAPaXn0Q==
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
Subject: [PATCH AUTOSEL 6.13 17/28] usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()
Date: Mon,  7 Apr 2025 14:12:07 -0400
Message-Id: <20250407181224.3180941-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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


