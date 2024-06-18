Return-Path: <stable+bounces-52678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B185190CBDA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B5282996
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC5F1459FC;
	Tue, 18 Jun 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/TtT1BL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB5144300;
	Tue, 18 Jun 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714186; cv=none; b=MFPU0FMOBlCM4gBbxTeQ273SvXhyCJt//ARbtXrSiRqPAopjwyn/rQ4uEgfaMNoMJjnIc8iCF5TaL9354LwXkyZQo6WoezTw3S59/JigqxZAjH9y+C7BaYV3JrXUBhA81aL6U/KAev/W42od+ymrfyKiI4sIEmQ/yu7EuA43uhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714186; c=relaxed/simple;
	bh=3qO/bu8qgfFKtr3pb9LarfRM3RiaqcXJaOV4kYQdtXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP5ZwoiB/wfrN3uKcHAUcTzX7Wfjyta7uTL4vss3A96/lq1/lXxj53tVm5Q4zRResL0g9xL+XUZxmKsXyxXcNPNmcnzQsWJF1dThKxqlFyREL2lI+SCSNVPgJbhQe/x7OvwlE6V6tUGZFXK3y5GMxa5LszQ0rOU4MpO6H46mcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/TtT1BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C93C4AF48;
	Tue, 18 Jun 2024 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714185;
	bh=3qO/bu8qgfFKtr3pb9LarfRM3RiaqcXJaOV4kYQdtXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/TtT1BLR33d6Cc2I/l1NEOL9tB3ILUtxIkEanMr4KVtsStTCrhpLvTxab1sQu/gh
	 8nML/QylNYoc6QAlJ1Fxx35Bpw7sp5i9CMchCMcZPOGXnC1eZKlmkjgoQxjgJUZGEP
	 EMhB7WV+CqT17aiIxefkeo67807A3YV0w1tGIfd6hDUeV9fbsNnaEzhrd0S7eXbjj+
	 A1njj1PUVSBbRaMv+bncf/9cWCnhzwdURNMGaUbR+krKC2TlTRg2iuJVE5QzhPE0Gw
	 wbOdbqlsqwC0oDnJUEa0byY5PymrWxaFumLyPpYUm8HxPUX49XLiqkgABqZrc38DdA
	 Qr3/jS6lSutmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/44] efi: pstore: Return proper errors on UEFI failures
Date: Tue, 18 Jun 2024 08:34:48 -0400
Message-ID: <20240618123611.3301370-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
Content-Transfer-Encoding: 8bit

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

[ Upstream commit 7c23b186ab892088f76a3ad9dbff1685ffe2e832 ]

Right now efi-pstore either returns 0 (success) or -EIO; but we
do have a function to convert UEFI errors in different standard
error codes, helping to narrow down potential issues more accurately.

So, let's use this helper here.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 833cbb995dd3f..194fdbd600ad1 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -136,7 +136,7 @@ static int efi_pstore_read_func(struct pstore_record *record,
 				     &size, record->buf);
 	if (status != EFI_SUCCESS) {
 		kfree(record->buf);
-		return -EIO;
+		return efi_status_to_err(status);
 	}
 
 	/*
@@ -181,7 +181,7 @@ static ssize_t efi_pstore_read(struct pstore_record *record)
 			return 0;
 
 		if (status != EFI_SUCCESS)
-			return -EIO;
+			return efi_status_to_err(status);
 
 		/* skip variables that don't concern us */
 		if (efi_guidcmp(guid, LINUX_EFI_CRASH_GUID))
@@ -219,7 +219,7 @@ static int efi_pstore_write(struct pstore_record *record)
 					    record->size, record->psi->buf,
 					    true);
 	efivar_unlock();
-	return status == EFI_SUCCESS ? 0 : -EIO;
+	return efi_status_to_err(status);
 };
 
 static int efi_pstore_erase(struct pstore_record *record)
@@ -230,7 +230,7 @@ static int efi_pstore_erase(struct pstore_record *record)
 				     PSTORE_EFI_ATTRIBUTES, 0, NULL);
 
 	if (status != EFI_SUCCESS && status != EFI_NOT_FOUND)
-		return -EIO;
+		return efi_status_to_err(status);
 	return 0;
 }
 
-- 
2.43.0


