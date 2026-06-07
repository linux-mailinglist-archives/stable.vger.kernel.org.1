Return-Path: <stable+bounces-261345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9YBLH9IJWoGGAIAu9opvQ
	(envelope-from <stable+bounces-261345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6058264FBD9
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qLd7dOIk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261345-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261345-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB38E30156D4
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512931F993;
	Sun,  7 Jun 2026 10:29:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1164071E3;
	Sun,  7 Jun 2026 10:29:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828194; cv=none; b=eBkeZp97sLvHoeLOWctneiltLXOKQ6jzj8lkhN9oNhu3xcS3eXnTMxGOtdOGj7Pc7xtns3r8dnb5KwOLPzWmeqh1M7xaNA32QImRDXkSNKh23cOVQfepqRIGhDzCP/lTAsgCiF05JjkCYzBexRBXDtvDhmuC6QGQA7FOCQx1a60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828194; c=relaxed/simple;
	bh=hVpLe2e24zQwbV8ZBPALHXgLdCmYqGdsGvYd+BoEkvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYfszSZcW1a/+mnN/TPcVvD/LfW3KAGKCPHPABS59PWREo7OJp17c7xuGEJs6WBcOzrQagpK4gF0MaITYzjcLv8e1ACxo543HEBc319oj6hHrtUdD5HSna6mn73SxXLDDEFLw69Tw/0M3fhUbaPFE9uTsEw4zeAnhrhW2NN8x/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qLd7dOIk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D16B1F00898;
	Sun,  7 Jun 2026 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828191;
	bh=7vZR745GEG8HwVawBI/pQCcfHh8Vbb1NA0/MW8F/pgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qLd7dOIkz7GYmRoHNEVgjbaKZTGKtGRsCio3tr88hcw/St9cpjB/00RS4xZC93HBi
	 KQkFBtGOq2ZQq0wQxlTZieqzB5zMWVw/Ei76RIAZIXgPtsTR7m3dSUxoyliKfOTyrl
	 CsTvMzJAQ4JWm7HRlZVppTQm29pTcIWRkpRcpA3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stan Shaw <shawstan96@gmail.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Gonda <pgonda@google.com>,
	Jacky Li <jackyli@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7.0 162/332] KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use
Date: Sun,  7 Jun 2026 11:58:51 +0200
Message-ID: <20260607095734.020245628@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-261345-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shawstan96@gmail.com,m:michael.roth@amd.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:jackyli@google.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6058264FBD9

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Roth <michael.roth@amd.com>

commit db3f2195d29344a3cf1e9dd9ab7f21ced7308cf7 upstream.

As per the GHCB spec, when using GHCB v2+ require the software scratch area
to reside in the GHCB's shared buffer.  Note, things like Page State Change
(PSC) requests _rely_ on this behavior, as the guest can't provide a length
when making the request, i.e. the size of the guest payload is bounded by
the size of the shared buffer.

Failure to force usage of the GHCB, and a slew of other flaws, lets a
malicious SNP guest corrupt host kernel heap memory, and leak host heap
layout information.

setup_vmgexit_scratch() allocates a buffer via kvzalloc(exit_info_2),
where exit_info_2 is guest-controlled. With exit_info_2=24, this yields
a 24-byte allocation in kmalloc-cg-32 (32-byte slab objects). The buffer
holds an 8-byte psc_hdr followed by 8-byte psc_entry structs, so only
entries[0] and entries[1] are in-bounds.

snp_begin_psc() validates end_entry against VMGEXIT_PSC_MAX_COUNT (253)
but NOT against the actual buffer size:

      idx_end = hdr->end_entry;

      if (idx_end >= VMGEXIT_PSC_MAX_COUNT) {   // checks 253, not buffer
          snp_complete_psc(svm, ...);
          return 1;
      }

      for (idx = idx_start; idx <= idx_end; idx++) {
          entry_start = entries[idx];           // OOB when idx >= 2

The guest sets end_entry=10+, causing the host to iterate entries[2+]
which are OOB into adjacent slab objects. For each OOB entry:

  - The host reads 8 bytes (OOB READ / info leak oracle)
  - If the data passes PSC validation, __snp_complete_one_psc() writes
    cur_page = 1 or 512 into the entry (OOB WRITE, sev.c:3806)
  - If validation fails, the error response reveals whether adjacent
    memory is zero vs non-zero (information disclosure to guest)

The guest controls allocation size (exit_info_2), entry range
(cur_entry/end_entry), and can fire unlimited VMGEXITs to repeatedly
hit different slab positions.

By exploiting the variety of bugs, a malicious SEV-SNP guest can:
    - OOB read adjacent kmalloc-cg-32 objects (heap layout disclosure)
    - OOB write cur_page bits into adjacent objects (heap corruption)
    - Trigger use-after-free conditions across VMGEXITs

E.g. with KASAN enabled, a single insmod of the PoC guest module
produces 73 KASAN reports:

    BUG: KASAN: slab-out-of-bounds in snp_begin_psc+0x126/0x890
    Read of size 8 at addr ffff888219ffb5e0 by task qemu-system-x86/2199

    BUG: KASAN: slab-out-of-bounds in snp_begin_psc+0x468/0x890
    Write of size 8 at addr ffff888351566648 by task qemu-system-x86/2199

    The buggy address belongs to the object at ffff888XXXXXXXXX
     which belongs to the cache kmalloc-cg-32 of size 32
    The buggy address is located N bytes to the right of
     allocated 32-byte region [ffff888XXXXXXXXX, ffff888XXXXXXXXX)

  Breakdown:
    62 slab-out-of-bounds (reads + writes past allocation)
     7 slab-use-after-free
     4 use-after-free

All credit to Stan for the wonderful description and reproducer!

Reported-by: Stan Shaw <shawstan96@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Jacky Li <jackyli@google.com>
Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
[sean: write changelog]
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3658,6 +3658,10 @@ static int setup_vmgexit_scratch(struct
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
 	} else {
+		/* GHCB v2 requires the scratch area to be within the GHCB. */
+		if (to_kvm_sev_info(svm->vcpu.kvm)->ghcb_version >= 2)
+			goto e_scratch;
+
 		/*
 		 * The guest memory must be read into a kernel buffer, so
 		 * limit the size



