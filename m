Return-Path: <stable+bounces-13682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F21837D65
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78331C28AEE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174059B4D;
	Tue, 23 Jan 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaZ+4/V9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC452F7C;
	Tue, 23 Jan 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969924; cv=none; b=F+GF9hNUteiaYaexjdNfJUgqK3QJV6lu/lJVCA7CrpwHnCYnnxh19VgXdmFVmsj8kh9TMyKO7XyeyD4yxLXEYfQaHlZJekA+HADjDzu60Dud0PFApJ2r8WvJaahNetq1lRDkdDJW4J5qid72ezyHMs5UA3SSa8lEFUsSqEpCCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969924; c=relaxed/simple;
	bh=+pUQod179hXjWtwFanM//hEjMFZMFja1M9ItkEoM7FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPDNiWAeLNACvwRGxOamS10BLDKAP5jIqbzOKFU/GGk4ondDnBKcE9d713wMwMXDTdqQjJrp/RU32ztSNTXuAaubuwIoMlDPepbY0/7QuBGOPnDI+cBOa3nIXqaikUxlMNcOHhZVfjesl3CQWmneGl7nNL3b+qQcECfy0x0S7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaZ+4/V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9272DC43390;
	Tue, 23 Jan 2024 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969923;
	bh=+pUQod179hXjWtwFanM//hEjMFZMFja1M9ItkEoM7FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaZ+4/V9CFS24YQUUdmmsThVoEwdy55BN2W6gqze/SHKKdckhznJHOMMKpGk4a/1t
	 o8o0FikygeOhVtjxrN3aEDtscoc4nt++kcOy6FtHbn0LVN1mW1Uly6uWYMujAoT7u2
	 n5OjE3hR08XFIblOcHgOkpXmc1n/qPIkNKoGoG/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 525/641] selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry
Date: Mon, 22 Jan 2024 15:57:09 -0800
Message-ID: <20240122235834.523175449@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

From: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>

[ Upstream commit b84fc2e0139ba4b23b8039bd7cfd242894fe8f8b ]

Ensure sym_tab and sym_names are zero-initialized and add an early-out
condition in the unlikely (erroneous) case that the enclave ELF file would
not contain a symbol table.

This addresses -Werror=maybe-uninitialized compiler warnings for gcc -O2.

Fixes: 33c5aac3bf32 ("selftests/sgx: Test complete changing of page type flow")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-3-jo.vanbulck%40cs.kuleuven.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sgx/load.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac1cf04..c9f658e44de6 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -136,11 +136,11 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
  */
 uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 {
+	Elf64_Sym *symtab = NULL;
+	char *sym_names = NULL;
 	Elf64_Shdr *sections;
-	Elf64_Sym *symtab;
 	Elf64_Ehdr *ehdr;
-	char *sym_names;
-	int num_sym;
+	int num_sym = 0;
 	int i;
 
 	ehdr = encl->bin;
@@ -161,6 +161,9 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 		}
 	}
 
+	if (!symtab || !sym_names)
+		return 0;
+
 	for (i = 0; i < num_sym; i++) {
 		Elf64_Sym *sym = &symtab[i];
 
-- 
2.43.0




