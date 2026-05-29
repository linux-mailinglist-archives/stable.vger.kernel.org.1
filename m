Return-Path: <stable+bounces-256709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMp4N1ndGWpWzggAu9opvQ
	(envelope-from <stable+bounces-256709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E060761D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D5E03024E39
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F5425CFC;
	Fri, 29 May 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka5a/O6h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbgtCbQ0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA7423A66
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079760; cv=none; b=DSXxPu5r9vEZin+t8U1MBU4JLZotW8ko4jg+dByiL0zVIuobd/zSb06Gqg0VvcUJ4x8tGj8iu90qR/579W5aurFB6b7/AvDGQcfrTpxaNlqby1nBY4c48h2kgWi+eCD6cXm0LOAlzA+2219DCgFmISWrX+x8RjA747368EcB9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079760; c=relaxed/simple;
	bh=d9xvjs+tTx/sVZNCwndNXY07gix+BakluyzBTGottoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi6YFzPg7fEsHzq23edy4axFZnkPWvJ+MoO2pMhQwnqEUISC8aWq+CTqpnwFmVFTvLHwgPXG9LcLF/RrfHsQIfXctRg8QydunJ4QQrC3H7d2lROYSDH1YA9EJOk4Yi14nda0J2tFJzjTY/jIBnzaK7mxYTZMqPK436/Nw1OSwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka5a/O6h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbgtCbQ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
	b=Ka5a/O6hURURRfck86omhX0On33avbU68gRZKtnXdod6jGtm4bJxUDAsh2vMy3NSTKDAev
	sz22WWxiDZFtEgZeTD81XjkMUtSPC3X2cBi+azFZ1X3SKU6DEStw3214tGMSULhKphJRw4
	drZd9dvrQiqrA3fCRTsfqJdBhQNvkpg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-kB8t2Q8yMh2QEqzf3HpG5Q-1; Fri, 29 May 2026 14:35:54 -0400
X-MC-Unique: kB8t2Q8yMh2QEqzf3HpG5Q-1
X-Mimecast-MFC-AGG-ID: kB8t2Q8yMh2QEqzf3HpG5Q_1780079753
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ed830a0eeso2879501f8f.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079753; x=1780684553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
        b=NbgtCbQ010XyI1gQ6VOPWKSPEcwOXucv/uB6U+6QjR1MsGeSBmCyv4fgwID7Qd9RlC
         hOeHuKyLTt19NVFFDp0dfnH7pS7IPVzs/U0gCpRLWD469fId6MWP5iA9vC3Nxt+rVpSs
         X5GtCiTY1Uhx13L5yZESp/2Y/9rvIfetDZAzGTF0f+ypJUWRWPia9WD/2jWqKsyR7T7c
         9/KYr8zMNWwhifwJSEZPl94Q5b41J5JX/RkLfJ2mtonRK0VO77suVjZhKaEL+HXRHdDE
         0nUukwyQko41cI9h5gj8W0sFvqNolZv9nu4fwoWvLWpZeh9knrCTzed6ghlT9yk99fgx
         LG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079753; x=1780684553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bItx102/eY014jSvfKnVDtrZQixF/uHwn/vTfUZ9ulM=;
        b=Wt1kSMXWkA1M6jG0DFDfXOQBYZvI67jl4LMHL4IOuFsx4h25T02OcBVtsbV3/0vWl5
         MIwTCuC7HLgex4HirUruIkMTcy4ZXJjaSG6Mua6r9kdI4FGChn1l+xaI5U/aliJqiSmI
         gzPMwMyWHXAQbRfnfaePKvsj3DHMMo4FUgkXM4jUnaoioYe799U1Odrt8vRCPLHnSAXO
         z8yhPho0eGAETgmUyXtvW0m5SfKuaq58GpIDnW6KzOscInB7bvxku4Br3jyo2OuDr5Ft
         N8LUP2WSV0iUEFu9/OMgH4vDexESjH7qQK50YsMEMRM74s2n22JNridTb8fGTSjjvbGY
         FyWg==
X-Forwarded-Encrypted: i=1; AFNElJ+PG03HFlKK1fjxPJJKhmuZAldyAk+8/XoC9xrSMz54YSnbirii/SXdLpIdJklhxLXwW/4g8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTnFvLnTVuURZq0qC2zg5+xI21Qa5hjbvq5SS2T3OuXg47o9M
	GuC75hWLpQ2Rt0kfK2n8sst4xlYl1ptY0f9TBm5N4D02e1AXZEvmjMto7lJnVR3GkIX3U5Kg2XU
	DCVbxFJCQhlPerczoZh3XndTNBIH0YFEwyD9tF9M6ter0XvRmuN3t/S5E1g==
X-Gm-Gg: Acq92OF+LyO+jJ3vkIpLfXZ2n05bDq2R6OK8hSbUxSmawHvc9B1DHonm9Q9/KEW7z+U
	uM//CcfU6ZeHTWl8lDld7HysDBYr7T8lTDQTB3OcqXr2syH7Cwab+88e52CqHgZ7g0ZS2HUQQw8
	L3TXgVfrPDTUutqTICzd0nIErO2BtYQMGTbDe4KnyP0kuhs9YQFEYCUpUolE6+JiJW20WAHAwfM
	RRwdzzAt2cyJOL/dQeQXN7LpwFOYE4Lo0JD05MK0v6Mn97fMEhCySxE/gB0tCRWQhb5cHFfCYHV
	71kgqDehEU8rWez5+jR+Xcorj7mndOjVOVBnOBy2x1W02UCZ5KXIheJidGlzTYz3w9eDDpiEoVr
	XA0+PviEZBrSm1pmvQ6AJsr/kjDKJbn4kpo+UJT4idnXGpDL4jui+rHQgZBQhOz6bbfI63/QBiv
	iXTFeVgQizytCiA9CUZzZapBJWGdPn0S9MqiTmGg==
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr12422015e9.15.1780079753312;
        Fri, 29 May 2026 11:35:53 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr12421485e9.15.1780079752861;
        Fri, 29 May 2026 11:35:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm5101632f8f.26.2026.05.29.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Stan Shaw <shawstan96@gmail.com>,
	Peter Gonda <pgonda@google.com>,
	Jacky Li <jackyli@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/24] KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use
Date: Fri, 29 May 2026 20:35:26 +0200
Message-ID: <20260529183549.1104619-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256709-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,amd.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 738E060761D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Roth <michael.roth@amd.com>

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
---
 arch/x86/kvm/svm/sev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..23170b64f4a3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3703,6 +3703,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
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
-- 
2.54.0


