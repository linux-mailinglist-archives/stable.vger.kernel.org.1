Return-Path: <stable+bounces-103224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50309EF735
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA65F189EF64
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36E13CA93;
	Thu, 12 Dec 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9zVpHNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D4216E14;
	Thu, 12 Dec 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023917; cv=none; b=X+b8wpofX7HNYa4cnk7jJT9LuODbOciUNQStb2pgt119SWo4+X+zfn+bI1I7C6kZPEtV5PAdM9vAmffWHvD+zzdPkO/tjTky1gpkklRipNoviKM5CtJvwH2VssFs7pdld8UzzZpf2JJjRW+GtiBr+KZ5R9EtyyQTzIOJ8u9IgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023917; c=relaxed/simple;
	bh=+JYzJXsN9uSP46oXOkcBPkgi+j4GxfYtVmDvB4dMaWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1l8qnc4jeJqAcr1UVSav1fydWZYoTaml37AzSRqurIJ5sr6soNxHhj8rPi2cXgIr4GjmPtzTraYFMZEVtgLJzJdyi1XxlJVW5WCPbZkbBATmURDLYMdShq+nhfqZxHqyvaD08aN/IVesBUzM/DWXm1QUEuIwbL1GCa5T69SfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9zVpHNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C1C4CED0;
	Thu, 12 Dec 2024 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023917;
	bh=+JYzJXsN9uSP46oXOkcBPkgi+j4GxfYtVmDvB4dMaWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9zVpHNEZU/DpV1XNsyQtXjc1YfOqYcS09pBW42QmpTExKotm+hM/AloGo+Oyix55
	 Gg4UWXVgo/QjTjObEZVAgOkJpdoGzxQ8PjKtT+NZe/LH/xjDtfuuOzeXRSSFmhMA+y
	 xpkMzpoRt5MoQ7P+MZ4ufRBtkOeOY0UdCucdR8X0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory Price <gourry@gourry.net>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 085/459] tpm: fix signed/unsigned bug when checking event logs
Date: Thu, 12 Dec 2024 15:57:03 +0100
Message-ID: <20241212144256.876968864@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory Price <gourry@gourry.net>

[ Upstream commit e6d654e9f5a97742cfe794b1c4bb5d3fb2d25e98 ]

A prior bugfix that fixes a signed/unsigned error causes
another signed unsigned error.

A situation where log_tbl->size is invalid can cause the
size passed to memblock_reserve to become negative.

log_size from the main event log is an unsigned int, and
the code reduces to the following

u64 value = (int)unsigned_value;

This results in sign extension, and the value sent to
memblock_reserve becomes effectively negative.

Fixes: be59d57f9806 ("efi/tpm: Fix sanity check of unsigned tbl_size being less than zero")
Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/tpm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3f..9c3613e6af158 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,7 +40,8 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	int tbl_size;
+	unsigned int tbl_size;
+	int final_tbl_size;
 	int ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
@@ -80,26 +81,26 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = 0;
+	final_tbl_size = 0;
 	if (final_tbl->nr_events != 0) {
 		void *events = (void *)efi.tpm_final_log
 				+ sizeof(final_tbl->version)
 				+ sizeof(final_tbl->nr_events);
 
-		tbl_size = tpm2_calc_event_log_size(events,
-						    final_tbl->nr_events,
-						    log_tbl->log);
+		final_tbl_size = tpm2_calc_event_log_size(events,
+							  final_tbl->nr_events,
+							  log_tbl->log);
 	}
 
-	if (tbl_size < 0) {
+	if (final_tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
 		ret = -EINVAL;
 		goto out_calc;
 	}
 
 	memblock_reserve(efi.tpm_final_log,
-			 tbl_size + sizeof(*final_tbl));
-	efi_tpm_final_log_size = tbl_size;
+			 final_tbl_size + sizeof(*final_tbl));
+	efi_tpm_final_log_size = final_tbl_size;
 
 out_calc:
 	early_memunmap(final_tbl, sizeof(*final_tbl));
-- 
2.43.0




