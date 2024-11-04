Return-Path: <stable+bounces-89674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3655D9BB26E
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2D91C212AE
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F01EF0B5;
	Mon,  4 Nov 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjBNU0Ub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69C1EF0A4;
	Mon,  4 Nov 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717708; cv=none; b=kZk8ndCAlMSta0EoCB2XpyQ/eQFjzz+ukzEJlx+6PGM4ulkkNbFLdWaqd7va7Ys5k7huupypN1o/7Y/reLzfPkbn18eAQR1rEDU4hCk1LS10Amt3SGIEoqd05dtXyeZ9eGohZHuEidortJQwRn6z7XFJ3kQpIcZZcztYRDON/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717708; c=relaxed/simple;
	bh=WvCCN/4vKdKgxKkCKjj8n2cLEvdazQ6G7cQxWsxuZPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgubhJ/LWLscgNNXBO7T3NaHzr6h95gEesevVpJ/OcHLkBq5slT/1zIGFG43GqpT9nFAv5vW7T2gpGnEy8jA6tj5VkvUgJPvWI0TdwVoJCPboI+gCd4a045O1gwq8ELV+jj84z1ahzQuN6U9KxJHu8Hj6THaEswkSKjiQiYOvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjBNU0Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9922C4CECE;
	Mon,  4 Nov 2024 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717708;
	bh=WvCCN/4vKdKgxKkCKjj8n2cLEvdazQ6G7cQxWsxuZPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjBNU0UbpPNSTsCIsfHg9iSrxbgf+jy0+TKE2GM5a64RscJ79vbtB2+gdfXyrs3jH
	 jtYnhS8HghGigEAeMcuYBUEMVtNSL9Dh2vN704jThaCD6eeSabp7c2veei3Fdjn3BV
	 sFpIxPfVBEefXbxmSnQWJwuYf31P6hdbNcSGn031Vqi/5ciE53JMiaQOB4t7qnuUhE
	 pbQncfZVITDtDtm7b1aQX6QRMkXBOgJCHxD3brQaPby7yVmDk34u+WHyBEnCstt+3u
	 X/Lh5YEnxrEofGOjBu2oK/GjWYUm0/p0m05un25148SR8n5J4gpVFTivLnq7ksaCEJ
	 ajPtHPtdIeZYg==
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
	mario.limonciello@amd.com,
	yazen.ghannam@amd.com,
	bhelgaas@google.com
Subject: [PATCH AUTOSEL 5.10 5/6] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:54:46 -0500
Message-ID: <20241104105454.97918-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105454.97918-1-sashal@kernel.org>
References: <20241104105454.97918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index 455066a06f607..d561f7866fa16 100644
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


