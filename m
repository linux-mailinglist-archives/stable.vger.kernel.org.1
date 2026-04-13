Return-Path: <stable+bounces-237478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGq/EAMi3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58A3F0A04
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AC2B302CE06
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915A832863D;
	Mon, 13 Apr 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2DUXcNd9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1D318ED2;
	Mon, 13 Apr 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099558; cv=none; b=PYtqxuYX/vFg2XIokIhqOuucMAETCNhH/wNHWX9nxecMIc9BMRrzLIaDfWekELsNjDo1LDP95x6DfICleqCTqfVt38EPDnr7PzfzvxeamlcG4osgYwyByUrezh5JeXBdwR1nttKVAFQke9sYxUx59ZgJsGnDyI7yOei6B8gp9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099558; c=relaxed/simple;
	bh=esrMXbVF6Q544EQ2slZNdTAJofKCX6sF5RvAtIIvZBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRQDI4WAn/gzKNWTP7WUhw0IhhjOgG/f4Tv4W+1lmoHWOfEqPkIB9ywKBW8AvInxpQKzgB36b3UddYrO3L1J4JzbO+wvZ5OVqZfIQRojYabSXEaPX60//xBSp1yy7taJrLHFaEvsAhAnrFKR3vRKlpZSOZIehk3Jve+CJMpIcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2DUXcNd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCBDC2BCAF;
	Mon, 13 Apr 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099558;
	bh=esrMXbVF6Q544EQ2slZNdTAJofKCX6sF5RvAtIIvZBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2DUXcNd9S7XTgCiX6NScD8i2RWH8nXHOM+ZbCnVWskQtOqaJs6YXmAUgwyoO/toJm
	 i44SitXLsb4VoFkKlnk20q26fOv2CO58U7LsYTN9qOW1X2tBQ7CZp81tYV4jtpiCCa
	 2FVTDVTc6MCiYyKBTR21z3uzDlov2rqfzVznvIMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Jones <pjones@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 354/491] efi/mokvar-table: Avoid repeated map/unmap of the same page
Date: Mon, 13 Apr 2026 17:59:59 +0200
Message-ID: <20260413155832.292236682@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237478-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CE58A3F0A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e3cf2d91d0583cae70aeb512da87e3ade25ea912 ]

Tweak the logic that traverses the MOKVAR UEFI configuration table to
only unmap the entry header and map the next one if they don't live in
the same physical page.

Link: https://lore.kernel.org/all/8f085931-3e9d-4386-9209-1d6c95616327@uncooperative.org/
Tested-By: Peter Jones <pjones@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/mokvar-table.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 39a49adf007a5..69ac876ca809d 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -99,13 +99,13 @@ static struct kobject *mokvar_kobj;
  */
 void __init efi_mokvar_table_init(void)
 {
+	struct efi_mokvar_table_entry __aligned(1) *mokvar_entry, *next_entry;
 	efi_memory_desc_t md;
 	void *va = NULL;
 	unsigned long cur_offset = 0;
 	unsigned long offset_limit;
 	unsigned long map_size_needed = 0;
 	unsigned long size;
-	struct efi_mokvar_table_entry *mokvar_entry;
 	int err;
 
 	if (!efi_enabled(EFI_MEMMAP))
@@ -142,7 +142,7 @@ void __init efi_mokvar_table_init(void)
 			return;
 		}
 		mokvar_entry = va;
-
+next:
 		/* Check for last sentinel entry */
 		if (mokvar_entry->name[0] == '\0') {
 			if (mokvar_entry->data_size != 0)
@@ -156,7 +156,19 @@ void __init efi_mokvar_table_init(void)
 		mokvar_entry->name[sizeof(mokvar_entry->name) - 1] = '\0';
 
 		/* Advance to the next entry */
-		cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
+		size = sizeof(*mokvar_entry) + mokvar_entry->data_size;
+		cur_offset += size;
+
+		/*
+		 * Don't bother remapping if the current entry header and the
+		 * next one end on the same page.
+		 */
+		next_entry = (void *)((unsigned long)mokvar_entry + size);
+		if (((((unsigned long)(mokvar_entry + 1) - 1) ^
+		      ((unsigned long)(next_entry + 1) - 1)) & PAGE_MASK) == 0) {
+			mokvar_entry = next_entry;
+			goto next;
+		}
 	}
 
 	if (va)
-- 
2.53.0




