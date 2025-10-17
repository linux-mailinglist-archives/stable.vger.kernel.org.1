Return-Path: <stable+bounces-186368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6812BE9602
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8541887D01
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E05695;
	Fri, 17 Oct 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLYQVWJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCF3370F6;
	Fri, 17 Oct 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713043; cv=none; b=taUjQbW2m8odkhN+/YUiI3jDbMZ3cOcLzB9fPcmS3Q8ST0YnV2Je0OoVcDj14sUCbk1Nx6XjZPMB6qtr6pxepeQD+GessMwmOl6cuc2ml5wl5GSQnE/apCsfMrkCOvtwXvW8zQY1GDxqCI4z3D+XEo0gh/f0ATlGc9mzaEg3mD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713043; c=relaxed/simple;
	bh=sFS22HaoMVKkPGkOEdJy6n9N/szY2RZmKHP5++O75cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE6LD5nwSqgtunFvLprJGJjXt+1et/VaD7x76zgUKtqW/1GsLgfq2HqtBi5t9VO91Y2Ag0vf7DiBcVCjXFQOlKGVxkpynwJMZx8vmaUfDGpfa7MwCfjhxmsV+T/K45vMT1BM6gMs2VivCr5ycNm5hV1kS/lyVA2tygoLOVfUR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLYQVWJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E1DC4CEE7;
	Fri, 17 Oct 2025 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713043;
	bh=sFS22HaoMVKkPGkOEdJy6n9N/szY2RZmKHP5++O75cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLYQVWJI4O2CsVitXY47y70NQz9JI5hD6rrxLt7kjPCA9gtJVWbcjwbyJDaU/LQfs
	 FxukvVyfwSHXHca/C8hFEguKu/xUAWsqbiUssfHvoo+HzG48mNgjP6KYUDB8OBtYjn
	 yM3+zv3Fm4SxJW+nztMRNIn5n2j2PJWLP+YRL0LE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/168] LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()
Date: Fri, 17 Oct 2025 16:51:47 +0200
Message-ID: <20251017145130.056309599@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 6c3ca6654a74dd396bc477839ba8d9792eced441 ]

Both acpi_table_upgrade() and acpi_boot_table_init() are defined as
empty functions under !CONFIG_ACPI_TABLE_UPGRADE and !CONFIG_ACPI in
include/linux/acpi.h, there are no implicit declaration errors with
various configs.

  #ifdef CONFIG_ACPI_TABLE_UPGRADE
  void acpi_table_upgrade(void);
  #else
  static inline void acpi_table_upgrade(void) { }
  #endif

  #ifdef	CONFIG_ACPI
  ...
  void acpi_boot_table_init (void);
  ...
  #else	/* !CONFIG_ACPI */
  ...
  static inline void acpi_boot_table_init(void)
  {
  }
  ...
  #endif	/* !CONFIG_ACPI */

As Huacai suggested, CONFIG_ACPI_TABLE_UPGRADE is ugly and not necessary
here, just remove it. At the same time, just keep CONFIG_ACPI to prevent
potential build errors in future, and give a signal to indicate the code
is ACPI-specific. For the same reason, we also put acpi_table_upgrade()
under CONFIG_ACPI.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Stable-dep-of: 98662be7ef20 ("LoongArch: Init acpi_gbl_use_global_lock to false")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index b00e885d98458..55efe2f5fa1c3 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -252,10 +252,8 @@ void __init platform_init(void)
 	arch_reserve_vmcore();
 	arch_parse_crashkernel();
 
-#ifdef CONFIG_ACPI_TABLE_UPGRADE
-	acpi_table_upgrade();
-#endif
 #ifdef CONFIG_ACPI
+	acpi_table_upgrade();
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
-- 
2.51.0




