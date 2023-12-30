Return-Path: <stable+bounces-8819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE9820509
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F51C20FDD
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF08487;
	Sat, 30 Dec 2023 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ow8iN6Hl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E38813;
	Sat, 30 Dec 2023 12:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E015C433C7;
	Sat, 30 Dec 2023 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937844;
	bh=ETx7pspkq4fXw/eBtLy4rqZIV4gioxDWvrX7AMOP0aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow8iN6Hlfpw5OYo45/ozTaVuaC0KW53JsCcO0J/CltdnbFlYceNryqiOY6wh4V6On
	 L9GeqBfKn768dz9PrIL+lyAnV3DfLUgrBBvHuhZbf6Ex8CboIQoGfGBLxvapjwpNBo
	 soSllqFiWwHfdAja1aNFb3/H6oW1OEJlhzf7YZYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 060/156] net: mana: select PAGE_POOL
Date: Sat, 30 Dec 2023 11:58:34 +0000
Message-ID: <20231230115814.307199532@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yury Norov <yury.norov@gmail.com>

[ Upstream commit 340943fbff3d8faa44d2223ca04917df28786a07 ]

Mana uses PAGE_POOL API. x86_64 defconfig doesn't select it:

ld: vmlinux.o: in function `mana_create_page_pool.isra.0':
mana_en.c:(.text+0x9ae36f): undefined reference to `page_pool_create'
ld: vmlinux.o: in function `mana_get_rxfrag':
mana_en.c:(.text+0x9afed1): undefined reference to `page_pool_alloc_pages'
make[3]: *** [/home/yury/work/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[2]: *** [/home/yury/work/linux/Makefile:1154: vmlinux] Error 2
make[1]: *** [/home/yury/work/linux/Makefile:234: __sub-make] Error 2
make[1]: Leaving directory '/home/yury/work/build-linux-x86_64'
make: *** [Makefile:234: __sub-make] Error 2

So we need to select it explicitly.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Fixes: ca9c54d2 ("net: mana: Add a driver for Microsoft Azure Network Adapter")
Link: https://lore.kernel.org/r/20231215203353.635379-1-yury.norov@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 090e6b9832431..01eb7445ead95 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -20,6 +20,7 @@ config MICROSOFT_MANA
 	depends on PCI_MSI && X86_64
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
+	select PAGE_POOL
 	help
 	  This driver supports Microsoft Azure Network Adapter (MANA).
 	  So far, the driver is only supported on X86_64.
-- 
2.43.0




