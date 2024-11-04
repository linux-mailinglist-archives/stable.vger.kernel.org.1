Return-Path: <stable+bounces-89680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3D9BB28A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D62B262CB
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CA1C5793;
	Mon,  4 Nov 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxiBkquf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96791F669D;
	Mon,  4 Nov 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717731; cv=none; b=jiaF0SM0iz+B2QJ7AtI1jDmeEXN9wOOM8sdtcM2A+8UeQX88QdX/zR45sn5c8AWVKqnWZxzuU55jJs7FC+bxtOsL7gj5ovJAIGrhfhjhGyFcMHgBnLlYaLQn0pFqsTxoF1Pl4GyPzJrCuUsFdvUX1qt4FaTHKH+zuqXwl6PgZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717731; c=relaxed/simple;
	bh=r165WiYUyyhjLiGDqZbBf9bowPcTEodT+FryIbtM4ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQSkhRFPUcpIF8y8hfjLSVrTMR1qckjrYfNqra+2aAXsoV+zOuDCPcVQrbB/oD2hNztqs0cYKe1p65rrCmrcKz4A57v1pr5q7hquAHuUZFiwxWXO+q7XJ0fzQs0exENebqkzyxLk24RnCMjTpUvIlm8NIGiiNHMp2ycdlGeKNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxiBkquf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153CFC4CECE;
	Mon,  4 Nov 2024 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717731;
	bh=r165WiYUyyhjLiGDqZbBf9bowPcTEodT+FryIbtM4ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uxiBkquft5cgUI+64YRHmDsWKPJu3d/LguvRGI6woV60SkmuyYWaWjyGW3xqkx7Sg
	 kIQNAgwWqNCn5U/NZvFz6q3SjQkMmwhNR+EqaZIToTI3n0ZWqE229/W9CRwq5Vgm7x
	 rWHVSDBcZalc21Z8nXGXc1U1vGvVT1q812rKKAbwX6BytSSczMyUl+ETB9avaO2f0w
	 3EdPYU09xw8yYlE+HY+XryywmiN3rm0+riC9zPZencsUzjKjuF4+vSvNTBiK1LSjyT
	 n4A+ktNCCDB8DE4m8HVMrmdYmq/ZBeov8jF3kbOjPN/IaqngG9hFsRl4mb5awk+nXk
	 RmGwfQR32WpIQ==
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
	bhelgaas@google.com,
	yazen.ghannam@amd.com,
	rdunlap@infradead.org
Subject: [PATCH AUTOSEL 5.4 5/6] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:55:09 -0500
Message-ID: <20241104105517.98071-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105517.98071-1-sashal@kernel.org>
References: <20241104105517.98071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index 1ae4e5791afaf..a4f98a2fb5353 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -118,7 +118,10 @@ static inline bool amd_gart_present(void)
 
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


