Return-Path: <stable+bounces-261380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTtsEBpJJWpvGAIAu9opvQ
	(envelope-from <stable+bounces-261380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B226E64FCB1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nt09YuHl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261380-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261380-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62B1E302F7CB
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9A3112A5;
	Sun,  7 Jun 2026 10:32:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193626ED5D;
	Sun,  7 Jun 2026 10:32:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828328; cv=none; b=hCA4d9FiX2GFPoygKR1QJhk1SQBc4IB/Hzne4gTEldMYFPT1f8i3pTfYS7d3L4Jb74/5+1fXwIagozFCJD9MoUYvhbYSgMIVz+TzLLq1V4Th44g6biLl3FRYKzPZ5VITmiDiKDRnTpRmhXK8oYmKPznWOutElnNb8qT9hqxeVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828328; c=relaxed/simple;
	bh=AMoDyPYvBxKmk7q0yOPK0n2T7m3gvxgttDi80fhPCiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUbuIQeVQm+WjIG4U6xHO9+nTSnNJXSJx5K1ZfSoxXbmZXyj7VWa9VZGae0xphtNcUJ01HcMAPixbvT17XFL9rcw5uzCT1+A5cabfMmfkTeBeAoIRKfZx2dJ3b6oY6czQkGCKqGG3BqNi0+z4tcmoA0+eixlOvwLD4K72ZIzovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nt09YuHl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F651F00893;
	Sun,  7 Jun 2026 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828327;
	bh=pnaVljgu5aTtPElTMnEQ4erxXU253JvZ9TDv+7aLJ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nt09YuHl0OqZL7WIxnrVtnThi39ZtSLy0qPE4yDgYDlvJQNbAEpFJTuboPE4Hp1w1
	 Ec39R7EJbjNLLzA3k5ELdECZoJ6MZ8ymcmhxvdoPNfu3FaQH5hLPF4I5jSp7jF+vKA
	 150d7xMJWNSrdJl/sgKfi785Ovy0hf63GTCpLbq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.18 150/315] KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
Date: Sun,  7 Jun 2026 11:58:57 +0200
Message-ID: <20260607095733.115233190@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261380-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:thomas.lendacky@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B226E64FCB1

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit c8cc238093ca6c99267032f6cfe78f59389f3157 upstream.

Use READ_ONCE() when reading entries/indices from the guest-accessible
Page State Change buffer to defend against TOCTOU bugs.

Don't bother with READ_ONCE()/WRITE_ONCE() for cases where KVM is writing
(and not consuming the result!), as the guest isn't supposed to touch the
buffer while it's being processed.  I.e. using READ_ONCE() is all about
protecting against misbehaving guests.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-11-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3820,9 +3820,9 @@ static void __snp_complete_one_psc(struc
 	 */
 	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
 	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry *entry = &entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
-		entry->cur_page = entry->pagesize ? 512 : 1;
+		entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
 	hdr->cur_entry = idx;
@@ -3885,8 +3885,8 @@ next_range:
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = hdr->cur_entry;
-	idx_end = hdr->end_entry;
+	idx_start = READ_ONCE(hdr->cur_entry);
+	idx_end = READ_ONCE(hdr->end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3895,7 +3895,7 @@ next_range:
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
-		entry_start = entries[idx];
+		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3939,7 +3939,7 @@ next_range:
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||



