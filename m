Return-Path: <stable+bounces-89685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE19BB299
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D185B2783B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A21F76CB;
	Mon,  4 Nov 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXV6m0t3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3B1F76DB;
	Mon,  4 Nov 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717749; cv=none; b=FE98HXNhMSpFby+/vUWRKp2Tt3VAr/oCYyzicWAV82O7UxplNZ104A4xhlIJd5BUGWScep9kSKFme2zopQMLv3ijg6EzzVtwYg3vUxwa3ce79UZTxxs1lSyDqYU2gyq4Vdv0w43FgkRq7L+fwAq7dkCdZDniCOLupa3gz+RozvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717749; c=relaxed/simple;
	bh=THidAdKtmYirQtE3VR5MA8+4VCQJIGVgy8vGyNjZ3Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS8TW4T/BJTFUUE8JJKVqjxSnetua4sQGK6qchAepR8uHvk30xNmFSSCJ4PEJv7jHZDnyoyec2G270WeC5LsLNZj6b+XhqGJp87egQiUIyqfCukgMaepF9K9g8ddHkkp7wYJ/WDM/xfim+HPmd196TXuxrDLGc4d1UimvzruAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXV6m0t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760EFC4CECE;
	Mon,  4 Nov 2024 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717748;
	bh=THidAdKtmYirQtE3VR5MA8+4VCQJIGVgy8vGyNjZ3Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXV6m0t35T4k4X3kJMoUVwCxKjmNYXjk0BR1DDYeg23/YImgPgjLNmj1d5UdeyMAb
	 Lkp2k0UQmEvUdp5YcIuUkhwm3i40lkSOMFoB+fVxusaFgcO+gcLdEbaWhdD3m1xghi
	 0qJnuBCnb44CNt4x033Kjw7FY6MzI0vZrhxPHQXb6Z1oWtzjy5VXu7uUa/TWF5Inli
	 N9XzH4oUt/H5IpYgSyFjFPSlpyakmiW3zlNtkMjZlP9gcJPvJo01zVpABrdOTHWgo2
	 flVl5j4nkW0wlWglRd+vuINYbLNX2Uw9W2QWutNMHKpsk0tGgqCo3W0IE7SZIv+mAl
	 A6f6URrG39WHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	yazen.ghannam@amd.com,
	rdunlap@infradead.org,
	bhelgaas@google.com
Subject: [PATCH AUTOSEL 4.19 4/5] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:55:33 -0500
Message-ID: <20241104105539.98219-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105539.98219-1-sashal@kernel.org>
References: <20241104105539.98219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fce9642c765a18abd1db0339a7d832c29b68456a ]

node_to_amd_nb() is defined to NULL in non-AMD configs:

  drivers/platform/x86/amd/hsmp/plat.c: In function 'init_platform_device':
  drivers/platform/x86/amd/hsmp/plat.c:165:68: error: dereferencing 'void *' pointer [-Werror]
    165 |                 sock->root                      = node_to_amd_nb(i)->root;
        |                                                                    ^~
  drivers/platform/x86/amd/hsmp/plat.c:165:68: error: request for member 'root' in something not a structure or union

Users of the interface who also allow COMPILE_TEST will cause the above build
error so provide an inline stub to fix that.

  [ bp: Massage commit message. ]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20241029092329.3857004-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/amd_nb.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index fddb6d26239f5..7957ac2a643fd 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -115,7 +115,10 @@ static inline bool amd_gart_present(void)
 
 #define amd_nb_num(x)		0
 #define amd_nb_has_feature(x)	false
-#define node_to_amd_nb(x)	NULL
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
 #define amd_gart_present(x)	false
 
 #endif
-- 
2.43.0


