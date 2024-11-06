Return-Path: <stable+bounces-90901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16DB9BEB8C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DA1C231BC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC11F81AF;
	Wed,  6 Nov 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKdikiWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D711F81AA;
	Wed,  6 Nov 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897150; cv=none; b=RydCIheTZEBt0FOQmf6WFSdpkXat/Mp2MnBI3OS/8j8Bb594oseWk8hQXcSx6QoYCbrGc9HvT5vamtOvACwz0d3mwM7sJfnUrSmR5MjiRTWzjg5ot81vzP3a1xbV/ecwxiZhm62hEBKGZTedtEAKryLTWsO6VK6sDXcTqbqchRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897150; c=relaxed/simple;
	bh=8fuyALaXkZ5Vl/yRosUCyDO9DGUuh/3J1V+LGdyfOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC5xasChgExdHgNibaLtoQ9p+PXVbMLSXD6FHPIQsChOS9tKQBR99OzJln1l4irkhVygNh28a1yqyy8rhPcB1jScJaJ7Cf+i461EvhXr4CPXs0W+L+YL5ZgbjJIJtSUqKvBceGVU7krVHURAFLi0/2w+7CUziguiF84/w30LV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKdikiWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0133C4CECD;
	Wed,  6 Nov 2024 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897150;
	bh=8fuyALaXkZ5Vl/yRosUCyDO9DGUuh/3J1V+LGdyfOCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKdikiWcPYEa/rvR7fEYHIw8iWpPQ7tXedR/oQ3AZyCmhUGDNqNwlBboVHY/+hMA0
	 Pzl0dH+8F1Z2pCSP7Ky0efEbJyYtZVulNzV9iMcacoV7rw0coo+prQpE2jBO9KhdM4
	 XfOZYFdwtNhTSqSq2MhUdSHgyX6PP0agSLlBmdZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/126] riscv: efi: Set NX compat flag in PE/COFF header
Date: Wed,  6 Nov 2024 13:04:45 +0100
Message-ID: <20241106120308.346429953@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

[ Upstream commit d41373a4b910961df5a5e3527d7bde6ad45ca438 ]

The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
EFI binary does not rely on pages that are both executable and
writable.

The flag is used by some distro versions of GRUB to decide if the EFI
binary may be executed.

As the Linux kernel neither has RWX sections nor needs RWX pages for
relocation we should set the flag.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Fixes: cb7d2dd5612a ("RISC-V: Add PE/COFF header for EFI stub")
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240929140233.211800-1-heinrich.schuchardt@canonical.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/efi-header.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 8e733aa48ba6c..c306f3a6a800e 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -59,7 +59,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
-- 
2.43.0




