Return-Path: <stable+bounces-89646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9269BB208
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8992A282B6D
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005CE1D4142;
	Mon,  4 Nov 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2y7ynXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F991D363F;
	Mon,  4 Nov 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717584; cv=none; b=mq/Q+wAgYCYaU5VACYxMnWARxrx+StIGYZcv7RejS1K68nirQ6HCCf5gJzJovXaK6mj/SpT+DsCVgDpGYdys1ZQHtGJZOVnXL+XjT8zcuM8Fqv7Lukz+Zrq+sHnHenMfQnf1A2denN3KY9pZucm3d0Iq36FS6q2FcqBR0EiZBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717584; c=relaxed/simple;
	bh=w7Oqj9fzajCQ0+MmECDbLfwKZlnZ2v2aacnJpW55AiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTnFVF71DYO9kSU7auO2hxUrthGvVZawhNgDwgyG8T7s6TVR6kCpgrrV2+6fvIVc8emBkiwiaP6hW//A54EVxk5sUJufKzNKv23C9e3Uzn21b88GFvbNVjKsDhBt71NX1Dwgt8s+3ekm16JALzjGMnbv6xD8wB40y9CiC9Ria+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2y7ynXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203FC4CECE;
	Mon,  4 Nov 2024 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717584;
	bh=w7Oqj9fzajCQ0+MmECDbLfwKZlnZ2v2aacnJpW55AiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2y7ynXBNKEzU67TOI/kwUBtaISPa4sh2jQ5iDamCp3+RpdDQVHlHJcrLP2L7JhRT
	 kwq4xnaKdDbBWkaAU4rotE4+Bgap6M3nHtgZOP2+N9Vj1Q6fsPGhbmyqiLQhSc5a+U
	 KgRtHthobnh1eZ9La1CB8g+goq4nrZ2Sv201A+a6RmDn5B7Q3wE8xVGd4rnljbFaLf
	 l2JbiV4kinJbA40b/MGW0NKtZk8VDb54+ygotaqusi7olUmLEH1hg6cVUV1mvD2yL5
	 tIjp5Ag241doMkQHGwulQEDCeDbfnlGPWVRrUrqMxdGl9fuVOzeEqicvSYgHAnBe41
	 3fVcYqXUXY4xQ==
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
	rdunlap@infradead.org,
	bhelgaas@google.com,
	yazen.ghannam@amd.com
Subject: [PATCH AUTOSEL 6.6 12/14] x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB
Date: Mon,  4 Nov 2024 05:52:04 -0500
Message-ID: <20241104105228.97053-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
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
index ed0eaf65c4372..c8cdc69aae098 100644
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


