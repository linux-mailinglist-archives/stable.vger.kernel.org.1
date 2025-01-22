Return-Path: <stable+bounces-110120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7073A18D72
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B4A1641AC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82A1C3C0F;
	Wed, 22 Jan 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkQI89M5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44ED28EC;
	Wed, 22 Jan 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737533566; cv=none; b=DH92uBEe8KF7dSlss3xZ+8YB9DH4FMFGtZm5R4rIzzKs8uFn41+y4+89RYnmLeCJkN2LRnj8Q4qtdm+xoOG7dZsOvOwXBFElXF37Y9YbRgl0b9CrCqSUw7Bm2FOlxjINBEIFcynqafzf1N6iElYwxwQ0SK6xuimlU5Ix7c+nleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737533566; c=relaxed/simple;
	bh=pNAUmwzL50Wy8U5Ifi6Tf8zHHxv60Gh4QYKc+oUPoMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fROGWpMhPbj8NCay7ZxHlzvzTU6PV9xOTvXergyNi/cBgFw0GDUXpkTfeHCCZuhBwCqF9wxJOI9++gBfhnxa+rMjIKD4ocP5/6KSqWeCADLfO1p+5ybug2gkILyrNgg1qeu0hhd+KknsdXAXoyWV6q6LNLhtHDG3TdCRpD0ICnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkQI89M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B022BC4CED6;
	Wed, 22 Jan 2025 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737533566;
	bh=pNAUmwzL50Wy8U5Ifi6Tf8zHHxv60Gh4QYKc+oUPoMg=;
	h=From:To:Cc:Subject:Date:From;
	b=tkQI89M5pbfBMi0oH4BByNiDkBgGmQN16tZ0TAXdAH/+cC7DJYAfxcjUyEUVivrtz
	 4JA0VOkNW/BCXZ4GA4guileuQ34JVSSH4s41g0M2bdeIubMwXPEE1D9mwklgPgLSe/
	 CMZIIiwAZQNiQBOJktffx3sjZQq/TGuXSrotfn/WqOl7XIY1z4F6aE7Wi7b5S5Fwtx
	 4dw5nwu7DLcPyevAwkUg/weIf29jv2yqq8C+OAH7/VwkI/+xQZLxPC0RZRyUyNlzk4
	 8EBw6ACnG0TNbRF/v1uOZKjCaC6TR0mNKPsqqTZaf3DsQ7oTUpEvpk8OqvCQB3RZ1Z
	 z94+uig7WVcUw==
From: guoren@kernel.org
To: palmer@dabbelt.com,
	guoren@kernel.org,
	conor@kernel.org,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH V2] usb: gadget: udc: renesas_usb3: Fix compiler warning
Date: Wed, 22 Jan 2025 03:12:31 -0500
Message-Id: <20250122081231.47594-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
directive output may be truncated writing between 1 and 11 bytes into a
region of size 6 [-Wformat-truncation=]
2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^

Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas
USB3.0 peripheral controller")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501201409.BIQPtkeB-lkp@intel.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index fce5c41d9f29..89b304cf6d03 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -310,7 +310,7 @@ struct renesas_usb3_request {
 	struct list_head	queue;
 };
 
-#define USB3_EP_NAME_SIZE	8
+#define USB3_EP_NAME_SIZE	16
 struct renesas_usb3_ep {
 	struct usb_ep ep;
 	struct renesas_usb3 *usb3;
-- 
2.40.1


