Return-Path: <stable+bounces-226723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD/WOFmUuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:50:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6A2B0346
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DE4337AC13
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052B318EFF;
	Tue, 17 Mar 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TAIF7RSF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5B2EF67A;
	Tue, 17 Mar 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767956; cv=none; b=JDLMgKBoeby2jULfP6vz5XxWz9Xonf5p/w4iLgGSvOUKw0mN3+8IFOH8k/SBNJf9S+GvXFM/tRExI/JDU/J7uA/rZ6kp/pf/0JY5iKjYwPS849/vLTsm2G75ZQrIMXlykITao3ZKyQTuAm++2FO9rmZq2lyCRXrT4Y1BcHuaeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767956; c=relaxed/simple;
	bh=baCl0x+tSpav4pU+4UJwbxjO3oXLPfXcl95B88v2870=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cedeNorZZD6coxTEPATum+ecxKfeNNIiZn0Cu2l56RXgJ/CCvtP64SOEa9RzUhgwSwF7GbTRPLlfWoMoAC/0iSH/X94XbjwgyC9toGvDlGS8hEuxG2jggMT15UR5YEAJkmbOFV0U7TZphqvoFzXGjP3dcwOMS1nT8DjVBPvAosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TAIF7RSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24141C4CEF7;
	Tue, 17 Mar 2026 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767956;
	bh=baCl0x+tSpav4pU+4UJwbxjO3oXLPfXcl95B88v2870=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAIF7RSFSkPWg25w6+oVtMbv7htZoIA+6Mm4Uc5B7GVY1I6dIumF884O/kTLwOMUb
	 TWNjYHyI0kdpQBKGbJimgz9QuK3BKfKtN4yZKUCJ9B3PnJSp2TcXZ8NeifmzrQyuTZ
	 XF0oBCV17YxqQ6RbrJW3ISMsa+Hxg3neZaZlow0A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 6.18 199/333] arm64: gcs: Honour mprotect(PROT_NONE) on shadow stack mappings
Date: Tue, 17 Mar 2026 17:33:48 +0100
Message-ID: <20260317163006.737166680@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226723-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3AF6A2B0346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit 47a8aad135ac1aed04b7b0c0a8157fd208075827 upstream.

vm_get_page_prot() short-circuits the protection_map[] lookup for a
VM_SHADOW_STACK mapping since it uses a different PIE index from the
typical read/write/exec permissions. However, the side effect is that it
also ignores mprotect(PROT_NONE) by creating an accessible PTE.

Special-case the !(vm_flags & VM_ACCESS_FLAGS) flags to use the
protection_map[VM_NONE] permissions instead. No GCS attributes are
required for an inaccessible PTE.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 6497b66ba694 ("arm64/mm: Map pages for guarded control stack")
Cc: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmap.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -91,7 +91,11 @@ pgprot_t vm_get_page_prot(vm_flags_t vm_
 
 	/* Short circuit GCS to avoid bloating the table. */
 	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
-		prot = gcs_page_prot;
+		/* Honour mprotect(PROT_NONE) on shadow stack mappings */
+		if (vm_flags & VM_ACCESS_FLAGS)
+			prot = gcs_page_prot;
+		else
+			prot = pgprot_val(protection_map[VM_NONE]);
 	} else {
 		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);



