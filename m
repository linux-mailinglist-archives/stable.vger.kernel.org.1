Return-Path: <stable+bounces-89668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E09BB259
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C1B1C21B96
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E021C3026;
	Mon,  4 Nov 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j75M6XJZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE651E5728;
	Mon,  4 Nov 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717685; cv=none; b=nofZdI37F8xF23XiVdMIXoyfz85GetBhcFSA8ZRgHOJnY7YagoeTEJpTw2syIAgYD/vVG/OFDv9C+Lm85sORWONn44g1u9GLva2MAUdhC1VaGWZgJRoBmuM2T9phr0G8wDzD1/nP8Y4seYejZaFNni2Fe+M/4wPbTse5exN9y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717685; c=relaxed/simple;
	bh=WvCCN/4vKdKgxKkCKjj8n2cLEvdazQ6G7cQxWsxuZPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViYm9Ai0QnCHupXYzZLzUpVXIgupMciOdnpI1jvZDbP49l3/ALM09WpP79q2SnGATEreQAUcMt590BWd8jnNg5W3txoK2p1pjA48/7ykpWNmDZrLuoxdm2CWUpD/CsBLyUiWsUCQSUT9KzE/9cxXZyd3qOrxUls+dVUAkHuYRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j75M6XJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE8BC4CECE;
	Mon,  4 Nov 2024 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717685;
	bh=WvCCN/4vKdKgxKkCKjj8n2cLEvdazQ6G7cQxWsxuZPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j75M6XJZB6obxBHZfg3Oj1MpODgHukKbpxzYgtoAqPC8ry2MXLKDM/pfHvJcNWKSQ
	 m2GuuEMxDp2k/CcM3tKrdjVcfA0FW8lqsDn7pUOW95RKPmp2AQmb4G48372U/30Neb
	 md6I5wx8/tcrQnYFPgDOyhyXz0l1xBzcXGnxwkNyAGWhWRUttEfW1m2DHhrpAdcymb
	 VV10ogQXtE5EviEBFd3qFNFFTOh8ZpxCwf8It0PetDTb4R3IQ+12mlk/8U8tNR8dOv
	 Ev3gnqdJdoeyYprdSNncG4BKeBJi+xtW1TPDRDWUKboxp1CNzBj0Voko4Lcg9fSgNw
	 O3pUZwy1RpUwQ==
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
	bhelgaas@google.com,
	rdunlap@infradead.org
Subject: [PATCH AUTOSEL 5.15 09/10] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:53:58 -0500
Message-ID: <20241104105414.97666-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105414.97666-1-sashal@kernel.org>
References: <20241104105414.97666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
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


