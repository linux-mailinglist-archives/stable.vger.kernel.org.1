Return-Path: <stable+bounces-232377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFGpMWcGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17136F066
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0161D329A0E7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35DA30274D;
	Tue, 31 Mar 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/qQk3Rp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E822F5491;
	Tue, 31 Mar 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976590; cv=none; b=FTINJCL8H5jo4U1Zt8RQiUO5wyXJ5CzT13q1hFAlNrDnkiiNvBvQedPqp1mS5O46o974dNNk4s96t/b4Ry4CwavaukYA3fSVBUJ0jhAgVGJOyZWa1zSOCW9S1TFqzZkLLmSsuh5PobR1UhEOgeDwRxzES933jWDnODV4PIrvFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976590; c=relaxed/simple;
	bh=upa1S2W0ccU/2gDEH+nvcnYWRuU3CjGWZspxRnp7I9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOzTQ90bZH3XfQm9Gg0JnTCRxswXJ8ahj94Q574fcEO0Kujz4GmAndbo/9LnCxXVXUduXcs4xdw7kZ/iVf7KE0Kb1+xVmowEgVWYe4tca8eZHZ36eKYm0ZGRawZBK3jCOo4rg2NGYmyRsTjFYB3FCLEjx+mozH953Vvi/g4owwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/qQk3Rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0913C19423;
	Tue, 31 Mar 2026 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976590;
	bh=upa1S2W0ccU/2gDEH+nvcnYWRuU3CjGWZspxRnp7I9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/qQk3RpzBk17giePvZUltib0XmHi9x271bN6nPhAbrlxdjLvq9ZFFB9ScHpkOc1e
	 iV9fGRVa2AeYjFCiz4ep72iutm+GwAiIhj8KHIJvhKR8HarGYFYrPcJKno+1+xe5ly
	 g61RX45ho7pm/RpaFG/7oMSOt7ry5562fUdHJ21U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 151/309] x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size
Date: Tue, 31 Mar 2026 18:20:54 +0200
Message-ID: <20260331161759.028103246@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232377-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 2F17136F066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

[ Upstream commit 217c0a5c177a3d4f7c8497950cbf5c36756e8bbb ]

ranges_to_free array should have enough room to store the entire EFI
memmap plus an extra element for NULL entry.
The calculation of this array size wrongly adds 1 to the overall size
instead of adding 1 to the number of elements.

Add parentheses to properly size the array.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: a4b0bf6a40f3 ("x86/efi: defer freeing of boot services memory")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 35caa5746115d..79f0818131e83 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -424,7 +424,7 @@ void __init efi_unmap_boot_services(void)
 	if (efi_enabled(EFI_DBG))
 		return;
 
-	sz = sizeof(*ranges_to_free) * efi.memmap.nr_map + 1;
+	sz = sizeof(*ranges_to_free) * (efi.memmap.nr_map + 1);
 	ranges_to_free = kzalloc(sz, GFP_KERNEL);
 	if (!ranges_to_free) {
 		pr_err("Failed to allocate storage for freeable EFI regions\n");
-- 
2.53.0




