Return-Path: <stable+bounces-96617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBED9E28F1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D28B85AE8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402881F706B;
	Tue,  3 Dec 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkDL1PJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E91E3DF9;
	Tue,  3 Dec 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238100; cv=none; b=DLDWgOQdh7Dmj0B98SX+jXOGn9SecEgwYqajqiMtIii/JT12thWg3iGmToB0NfGrAjfZSTM8iXaajBgDe2cqIJUihN8hxM6MRRXfVEsLjC9CxOgZanIa4odaxJnGZDjjZGfV3/ckmHbtbypsJwTPL9sJNpVPaQO37/hAakddKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238100; c=relaxed/simple;
	bh=0NSrUHNecNOh5B2Ox25E4d+VGQnx4Xin0QRV2j446Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9GeEX4/RwA/8cIz/CAdEk5qaiFFhPe7mAxPQ+ViiUszWLSkkPCz/kPKwY7c+GYW07gkwxrs7Pku1J6RE959I0Rpab4vRwSHYR/sduSWLBA2XdljFvIYpGPu+gPn8aYbFPU13PV1Snd4daLcjtadE01kTXctsLaDZeZwAkwiwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkDL1PJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7387DC4CECF;
	Tue,  3 Dec 2024 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238099;
	bh=0NSrUHNecNOh5B2Ox25E4d+VGQnx4Xin0QRV2j446Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkDL1PJa42ZwzExu9dMNNgKac0/1g6aj91B88r6kQT7HYDSwHamrKGnQoi97aoekp
	 YAdD4W0kzFshN4rjuRxoc0L+gD5GvIfCR3f2HPvqDPot1unv/wCLUNd/zqa10LYf2N
	 NWV33TExe/kK10pjBMbjLLYVmMNVR9XqUxHS3d+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory Price <gourry@gourry.net>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 161/817] tpm: fix signed/unsigned bug when checking event logs
Date: Tue,  3 Dec 2024 15:35:33 +0100
Message-ID: <20241203144002.011492906@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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




