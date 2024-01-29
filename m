Return-Path: <stable+bounces-16459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007AA840D0C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A61C2310E
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA6157048;
	Mon, 29 Jan 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVpuTLYI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9E157E70;
	Mon, 29 Jan 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548034; cv=none; b=Wky0jU72M+o33MMU/5eEctFjzgj8Mmh/S6MMgMg4pXmzx0QLrUNUSiRm0AqQTq3vhoH51seeWoB4tgAgUzlL2xujfMi912xPj4hBdbr3mbBeQPIRK71/wvcP8PPuE6ZY7gHgoFourBisIZC3YVRrSWMhVkIk3czOtUcIt8KlnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548034; c=relaxed/simple;
	bh=XYu+S71coTePZEvgollNuDnuSyfXiQuyijGSL+PQMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1ne7gCw5y9GAxPPM/ytHirv1ruMmztCn0dSXfTE0PpxUum4FHlsPAy09Q41HixcC9oMcmD5YhDczREqUjK6dw0Bml8kebjotJ1Y98NBUmX5CLqnqqL9vA9NAkU1ugkYXjsvNcllXmt6/czlzqwnpyB61blBj8E47sJXaRJ/vRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVpuTLYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E5BC433B1;
	Mon, 29 Jan 2024 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548034;
	bh=XYu+S71coTePZEvgollNuDnuSyfXiQuyijGSL+PQMgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVpuTLYIk4Q2T1RjpVVknL9mAYSXFt9Y0h24qSPOwDsfYe4ahn+bKK09xFDZzVaC6
	 fFO8zhuvPfenKeDaCbr6xwA54o7Wlg3D3QHk6vTeloSGTEL7bEOqegfcDgWV4Pk9De
	 doKVd1MVGOtov+YsxDfFiQep3pfuvc2Jn6H1Xhzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.7 006/346] powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2
Date: Mon, 29 Jan 2024 09:00:37 -0800
Message-ID: <20240129170016.541453568@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geoff Levand <geoff@infradead.org>

commit 482b718a84f08b6fc84879c3e90cc57dba11c115 upstream.

Commit 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian
builds"), merged in Linux-6.5-rc1 changes the calling ABI in a way
that is incompatible with the current code for the PS3's LV1 hypervisor
calls.

This change just adds the line '# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set'
to the ps3_defconfig file so that the PPC64_ELF_ABI_V1 is used.

Fixes run time errors like these:

  BUG: Kernel NULL pointer dereference at 0x00000000
  Faulting instruction address: 0xc000000000047cf0
  Oops: Kernel access of bad area, sig: 11 [#1]
  Call Trace:
  [c0000000023039e0] [c00000000100ebfc] ps3_create_spu+0xc4/0x2b0 (unreliable)
  [c000000002303ab0] [c00000000100d4c4] create_spu+0xcc/0x3c4
  [c000000002303b40] [c00000000100eae4] ps3_enumerate_spus+0xa4/0xf8

Fixes: 8c5fa3b5c4df ("powerpc/64: Make ELFv2 the default for big-endian builds")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/df906ac1-5f17-44b9-b0bb-7cd292a0df65@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/configs/ps3_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -24,6 +24,7 @@ CONFIG_PS3_VRAM=m
 CONFIG_PS3_LPM=m
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_KEXEC=y
+# CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not set
 CONFIG_PPC_4K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_PM=y



