Return-Path: <stable+bounces-257546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBs1LNcbG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5212E60F578
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFC0F3047CB0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59851395AEA;
	Sat, 30 May 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiV57p9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8B263F44;
	Sat, 30 May 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161358; cv=none; b=ne+vhoGu4U2x0Sw0PxnGjLxsHo/lPDoyxXJt7IshcmX/24ZImdT6S5GAJBJnsJQlCT0A3A2+xVsbJqRtoeqEAy3Sbjprt2KlSD71jiEwvOTQ5tatmvO+vR9YnKplihFgEzxrJaHmDSkHsQvMj6Nt/h+lqfk8jqrbXjqteD2g1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161358; c=relaxed/simple;
	bh=5MzSLSlJoDxcjzj5f3U8hzAzhVAPcmlHIl59JYskWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8leIJ8elU+gk4PBTBI6xZSA+gYBk7/7f1/OKxccybE5YjenQyx4W+wHHGzEaXHMuiikfHGAkHtZlTQcKcew4DbbaDxIhI3rysNR58jPebQixJbdUioFaVEKDassFf6ffCH9opbxb0UDs/fZ4cCc03RVyNoNVRz3G8cgygWdDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiV57p9a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847701F00893;
	Sat, 30 May 2026 17:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161357;
	bh=HJL0oRDNkrVKy9+P4I7/7V2FTt4kjuKihtyTPemRcGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xiV57p9ahj9oMZJWBZZOa8MH03IczbEe6bzfSpYcLBEzkW8ABYe/6ckQ56JI5LQ88
	 x9xru02IZ6XIZPQWawAjBkKK9wtbHvhgSeeXlqhN4Q31KdqLOaUHWljb6Gu51B6fJg
	 kmyhapk0l+hK3jC+dUVXdLYthKgSYq8oBv5riUBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Huth <thuth@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 570/969] efi/capsule-loader: fix incorrect sizeof in phys array reallocation
Date: Sat, 30 May 2026 18:01:34 +0200
Message-ID: <20260530160316.140098180@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257546-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5212E60F578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Huth <thuth@redhat.com>

[ Upstream commit 48a428215782321b56956974f23593e40ce84b7a ]

The krealloc() call for cap_info->phys in __efi_capsule_setup_info() uses
sizeof(phys_addr_t *) instead of sizeof(phys_addr_t), which might be
causing an undersized allocation.

The allocation is also inconsistent with the initial array allocation in
efi_capsule_open() that allocates one entry with sizeof(phys_addr_t),
and the efi_capsule_write() function that stores phys_addr_t values (not
pointers) via page_to_phys().

On 64-bit systems where sizeof(phys_addr_t) == sizeof(phys_addr_t *), this
goes unnoticed. On 32-bit systems with PAE where phys_addr_t is 64-bit but
pointers are 32-bit, this allocates half the required space, which might
lead to a heap buffer overflow when storing physical addresses.

This is similar to the bug fixed in commit fccfa646ef36 ("efi/capsule-loader:
fix incorrect allocation size") which fixed the same issue at the initial
allocation site.

Fixes: f24c4d478013 ("efi/capsule-loader: Reinstate virtual capsule mapping")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/capsule-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 97bafb5f70389..c6a8bdbcae71b 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -67,7 +67,7 @@ int __efi_capsule_setup_info(struct capsule_info *cap_info)
 	cap_info->pages = temp_page;
 
 	temp_page = krealloc(cap_info->phys,
-			     pages_needed * sizeof(phys_addr_t *),
+			     pages_needed * sizeof(phys_addr_t),
 			     GFP_KERNEL | __GFP_ZERO);
 	if (!temp_page)
 		return -ENOMEM;
-- 
2.53.0




