Return-Path: <stable+bounces-47195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E2D8D0D00
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01281287601
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD315FCE9;
	Mon, 27 May 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+Bor40d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A80168C4;
	Mon, 27 May 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837914; cv=none; b=FA58fI3+H7E2nPEdYFnfHNeFV5ytUM1qRKu4B0nWbMdkfX8D2VVkv/fMhrNsPuvDyKs0IuG4+KTgPuwhil6EkuyCi/b6PMiZDL1vWNqE1BppGJvWwla2U/23mws25cr4g0jzY7p9fcIQUE5ObhcMblZHpiDsGKQht9tsof2Wnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837914; c=relaxed/simple;
	bh=/LWpP8AwGcy3HZEzW+FEDyJTZ41jBeo5+1OKBTQ3EQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoQxbq4KFdSxOpxsO8Vn3Sb/OYccIubojAtMHlRaSow6oePl9jtPw8TFVzuPe1hq3hlibN62Txx7+hWbAAOkdNpS7xr+sMIJeJIJvfef750Tjn528OjHqV89oXrvc8/J0bZBlDAUovmgvl+2ddeymQln5b7RpEffym7z5bRbQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+Bor40d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4D9C2BBFC;
	Mon, 27 May 2024 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837914;
	bh=/LWpP8AwGcy3HZEzW+FEDyJTZ41jBeo5+1OKBTQ3EQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+Bor40d2rssP5dHBftRVjiIajasWmE6NAsfR6h87YZ4XpFh9BW3VPR7CrW4RW0Lf
	 hTw9Qvmitbl0oG+RuCj5/vMcDe9i9bYzslgskNLOZsOPPIInhtue17smyRBF0jAdg6
	 zGL2NuTqOANzZP4vlWukSYwouW3QzXuuM6VQWhME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 194/493] x86/microcode/AMD: Avoid -Wformat warning with clang-15
Date: Mon, 27 May 2024 20:53:16 +0200
Message-ID: <20240527185636.689346953@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9e11fc78e2df7a2649764413029441a0c897fb11 ]

Older versions of clang show a warning for amd.c after a fix for a gcc
warning:

  arch/x86/kernel/cpu/microcode/amd.c:478:47: error: format specifies type \
    'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Werror,-Wformat]
                           "amd-ucode/microcode_amd_fam%02hhxh.bin", family);
                                                       ~~~~~~        ^~~~~~
                                                       %02hx

In clang-16 and higher, this warning is disabled by default, but clang-15 is
still supported, and it's trivial to avoid by adapting the types according
to the range of the passed data and the format string.

  [ bp: Massage commit message. ]

Fixes: 2e9064faccd1 ("x86/microcode/amd: Fix snprintf() format string warning in W=1 build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240405204919.1003409-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 13b45b9c806da..620f0af713ca2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -465,7 +465,7 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
+static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct firmware fw;
-- 
2.43.0




