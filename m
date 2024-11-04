Return-Path: <stable+bounces-89632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833BC9BB1D0
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DC02852E6
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35D1B6CEA;
	Mon,  4 Nov 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCycuRIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E891B5823;
	Mon,  4 Nov 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717520; cv=none; b=s8urtekxZe8+8g+S8hW3swOfIOpGcCftR5mIV1gt9bJxtqrr7d+YgUFnegmn5wRFKTaX8+gaKVnwg4Qa3JQCrUL/pZV0oG1/FCLBgEFslCc1/VSTwTs3QjxIZNl/3v/cWCuhhgPUThGI9L9QB+BDCjMEn5yHYniBhNDC4plsqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717520; c=relaxed/simple;
	bh=/p2glFF7I3gJGSr5pWrTAoJjyZVCFpFT4a3QZfUDKSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZqQfp9b4hqEKDLd7lh/2Lh+SimBLmGZWEzKNJOQOn7Z4eOuOGkYE36zE1CwhhUaIGyO74mRDJRSIRuvX0I8wnxcB9cuNfoon7RAKTANCKFpepsiVmD+HXFcKkdgj9RWq4KEgi4tU0wW4NL3hlNhvmkYsFYv2qMo4pb2C36+INA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCycuRIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15861C4CED1;
	Mon,  4 Nov 2024 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717520;
	bh=/p2glFF7I3gJGSr5pWrTAoJjyZVCFpFT4a3QZfUDKSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCycuRIYa9nFc+87+yhEjZ7DGTibpha3M8SXzKjZOPXAHP3AFj0n9J0QefbrIDFY/
	 9SXWY6AqIDgCJjXRvd2YU9zc0IqbmQhcz+Mx6jP+tecNMJHwKO46vVMOH4qROqADYc
	 I+4GApIZm4h0+OhnRWC3MvA8214WsyotuMa6hlljjXPEyzLaKV8McZNfvNNhxDqxgS
	 6VU66yBIIx+0zjSC7YPbVIFD9AS/hgXX9TCUVy1H2U2kTYy6uAmy9udeyHLKdA3Lv0
	 671GVdQik7zJKpAzpixuZfMgPFeeVzT/RjHCUf1/z1TXTbAQKyFnLBFwlXgnXAHCvx
	 8TQOG7v2RU3jw==
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
	mario.limonciello@amd.com,
	yazen.ghannam@amd.com
Subject: [PATCH AUTOSEL 6.11 19/21] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:49:55 -0500
Message-ID: <20241104105048.96444-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
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
index 6f3b6aef47ba9..d0caac26533f2 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -116,7 +116,10 @@ static inline bool amd_gart_present(void)
 
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


