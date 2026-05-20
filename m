Return-Path: <stable+bounces-250495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PqLHawQDmrw5wUAu9opvQ
	(envelope-from <stable+bounces-250495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:51:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1817598CAB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE6A379A6F2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9C3246FE;
	Wed, 20 May 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="alcuJRa8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BD1BD9D0;
	Wed, 20 May 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295559; cv=none; b=odR1gSyVg4oMUEfLb/YgaLxClLPdxuT4MGFW1ehOrxT0f7uVG6H9cq9/UeG7t6DRPp2e1PJUsakzI9jvZ7FSRAzDEczaoattOt6Zp7CWuul8AIZU5ov+m56IDtQmw8fppRKBGzX+IiCv1+1Yw583+iHJk0aEOSR976oxY9FZhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295559; c=relaxed/simple;
	bh=qMTeoYkH2eaQ1i5p37SkKIAMhWiaDWM8KxgbPsj3xMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDPmG3RFjtbDFMLyfqoWMnPMrXMRfqgLXQQF+1oQtT6ePZr//SeCOEfwSh7LbvZK9Oxma7yUA4s4MWIbQwF7iANSgutWc5vFzs8ff26YK2ZuLXP/906fJv207zI9rZTvwhmGWNyt7KxiUWRnMqudlzAnPCYBLoW1MAOIMl5QEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=alcuJRa8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72B51F000E9;
	Wed, 20 May 2026 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295558;
	bh=M+TuZM9oGCosDQdyH/lmgxPEZ4JsapqtEkSqAvbiZW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alcuJRa8cmqxjezXss6xorWOeYvOTqxNy2kcKkyuJ4SZ/1Mxn1nc59+vzN61AxDyR
	 BPHZ/HqLk9lNX9KNdh5KlIqQWnuP5DkkbPh40TzdDSNSQ8SndXCVNJIxvXcE7RNgRL
	 oRqdFD+cLKIKrkOZ93lXDOY3MmHSztQQgcKvetOE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Huth <thuth@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0464/1146] efi/capsule-loader: fix incorrect sizeof in phys array reallocation
Date: Wed, 20 May 2026 18:11:54 +0200
Message-ID: <20260520162158.696392209@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250495-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C1817598CAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 2c628a1270919..8e8f81f0a5a0a 100644
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




