Return-Path: <stable+bounces-26495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193F870EDC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D412D1C21217
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781D3200D4;
	Mon,  4 Mar 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJtX+HY0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502B200CD;
	Mon,  4 Mar 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588880; cv=none; b=T3euzhSJQb9j//FtSA8/hkBAcRj471kv6OHAYNkNjE76YH9NCOdra/m3LXyJwae2xfMMfs0ySrU+uRcWe2PDh6ZZFYImIzKIxaRdw0y+eCKrzMM0jVSE1dKYpO9HuiRrBufUqznLgoWnZU6G21pPG6cDdyY+JImZYxMDVexL2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588880; c=relaxed/simple;
	bh=UqCSp8vMcwGf0vJh35aV37fJ9zGfxFhEoFNXJzbMugs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbn64Flv4TS7fPWPJ8ffXtYeOPT6Pe/ckcOsV5OBxf6FvSOPs2uvfvLOh3p3cBbe9PvcQ/cQx6n9pC3E2DVP4Fp5ARKyCdhAAYRVNI+gdEl0E768P/qPLTiitXUHKf0D63l4Bk0LZvApNg9LbMbzPA/c8KXJBhRVUkReq91qSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJtX+HY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87C6C433F1;
	Mon,  4 Mar 2024 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588880;
	bh=UqCSp8vMcwGf0vJh35aV37fJ9zGfxFhEoFNXJzbMugs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJtX+HY0dKV9R9G2ba18QTluZF7rvWnT0wtcL9LBuMhw8060ID+bbdLAagZmpvXv2
	 y7zU66NXRj+iiVdTo+jqNGjiapYpgPNFKBXGXCXp6EkG//hOsgvlXXoc777XpEOhEp
	 moAcBABSusRQ4hpcSwRnsslpLYo5M0bRlWkp0SzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Schumacher <timschumi@gmx.de>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.1 093/215] efivarfs: Request at most 512 bytes for variable names
Date: Mon,  4 Mar 2024 21:22:36 +0000
Message-ID: <20240304211559.959483188@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

From: Tim Schumacher <timschumi@gmx.de>

commit f45812cc23fb74bef62d4eb8a69fe7218f4b9f2a upstream.

Work around a quirk in a few old (2011-ish) UEFI implementations, where
a call to `GetNextVariableName` with a buffer size larger than 512 bytes
will always return EFI_INVALID_PARAMETER.

There is some lore around EFI variable names being up to 1024 bytes in
size, but this has no basis in the UEFI specification, and the upper
bounds are typically platform specific, and apply to the entire variable
(name plus payload).

Given that Linux does not permit creating files with names longer than
NAME_MAX (255) bytes, 512 bytes (== 256 UTF-16 characters) is a
reasonable limit.

Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Tim Schumacher <timschumi@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/efivarfs/vars.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -372,7 +372,7 @@ static void dup_variable_bug(efi_char16_
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head)
 {
-	unsigned long variable_name_size = 1024;
+	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
 	efi_status_t status;
 	efi_guid_t vendor_guid;
@@ -389,12 +389,13 @@ int efivar_init(int (*func)(efi_char16_t
 		goto free;
 
 	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
+	 * A small set of old UEFI implementations reject sizes
+	 * above a certain threshold, the lowest seen in the wild
+	 * is 512.
 	 */
 
 	do {
-		variable_name_size = 1024;
+		variable_name_size = 512;
 
 		status = efivar_get_next_variable(&variable_name_size,
 						  variable_name,
@@ -431,9 +432,13 @@ int efivar_init(int (*func)(efi_char16_t
 			break;
 		case EFI_NOT_FOUND:
 			break;
+		case EFI_BUFFER_TOO_SMALL:
+			pr_warn("efivars: Variable name size exceeds maximum (%lu > 512)\n",
+				variable_name_size);
+			status = EFI_NOT_FOUND;
+			break;
 		default:
-			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
-				status);
+			pr_warn("efivars: get_next_variable: status=%lx\n", status);
 			status = EFI_NOT_FOUND;
 			break;
 		}



