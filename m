Return-Path: <stable+bounces-256718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOSyIQDeGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D3A6076A4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8877A30E9438
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77743E4A1;
	Fri, 29 May 2026 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex0p/+tv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIeMoaCF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3641423A87
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079786; cv=none; b=gr4lIsinJzUuViVx9ZTIVTv0mHbfxKVwXD9J730empBMRc+lXDqFtRg9GRtjpFYSzx2dSykmTMdcthN5F43f85oTlrdUzIYT9yzg0QyeTuhIEGSxi4ZgAXKrMIuf67Fle8aeynKL49FsVTzxbhjbUxx7LOmPUYtUBzyVwCL2ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079786; c=relaxed/simple;
	bh=Rdf4N65bOt7x8Nwrw5ueMoXtOuEXS+ZMINlCI3t8Sys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEJYz9unatmKGp85MksIO944jXT1zexqpjoFfqzTrul+gKZd0Pe6+AjxbVvZ9OtblWcIpllI0ecEHG/j2dJZJefSftQAUa5S0KohcKSJq1f1/F2YmOU52jn1xIV34eNWlkcQ1b7fTXKSTCJHNY/rPN9iUrA1qtNaf89ulNHaIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex0p/+tv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIeMoaCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
	b=ex0p/+tvLSJQH3k13Yqr/9jvyUUhSd4ON95Rhr7udVCusUl8rHCFj3wmNzjzi+L5wt1BkO
	TMxLyk1H5cWkAZr2WQ8HRcYh/BPFjJQhU88ufp2MpxkpTHMZmYpke608wLyVc2tI+HUBZD
	g3+piUtU/or5cCVY2l0bwYOkxjArXvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-R6K63Xu2PCWWk3aP2CBnbA-1; Fri, 29 May 2026 14:36:16 -0400
X-MC-Unique: R6K63Xu2PCWWk3aP2CBnbA-1
X-Mimecast-MFC-AGG-ID: R6K63Xu2PCWWk3aP2CBnbA_1780079775
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4905428aad6so56259295e9.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079775; x=1780684575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
        b=hIeMoaCFudUrTMHCPGwG+QndgOsetPGNO8qbXkR91riPOic+wxJnAOu5qOa0GG/dBO
         LZgRoXg7GIfXhFAmMzwgAsojlnrGvImh2/VZTGmGU48rB+tE4vKA/+ekFd5VRKSz0wNL
         4rZxex9GMu9Uz/y1TEaratSKS/faooYyuku46BRZCOS2Ly527X0PL9t7iAeOI1GIlx8l
         xER4arrSzTHuk18kJiUZb1Js2tvykIfRSA63ezctGCCRYJ0k/HUUzPfD4l444/elyTa/
         MesRxhpJKCP47xwrvTP3QEdX0iLB+jp1U02LepTltRgga2Dmot59YeFmoDxyaW7wplp5
         +h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079775; x=1780684575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6iAVB9mfQ/7q9K71+HvMK+Lw89cTkPEsSBKbCzolaQ=;
        b=CsoHe5fSemBYfiAwCRf4sy5NXjyobki83BMcWhQ9b9ewFRRkWCUUvfA1/kwYJBXjCA
         zqiOx/H0ke+aPqVaC3WuBkg3DuSrpXKElm99wn6fqjaHKJ+kvH4jTHCPV9SvpFm89H5a
         z6T/sd+c+elQxrr7g2crsrqDNXvElj4Fja5o4CWEyarM5Ml6UtGM8ZE3Rac1UMeM+e2I
         EFc5+LPXmtiPQuUAup3EyW9lkNYNI0wdnymwfeKiHE1ZdmnbtdTfPi1sg6vB45sV+v/v
         asmUUFrFs22t7vcTP2bSdvHJIBWcvWBRo4E6JTnz3EWAI++jmvFX9kDQwDjX4FkjQgDV
         0Xdg==
X-Forwarded-Encrypted: i=1; AFNElJ8sMYKeVkVc4RNYtEpDkBNe+syGMTsTWpzwG+sy0U2vsttlYKXVIkoJw+KksRPKJ75JdtyovOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrZeUUAjotJXYGyST/rx24ku/79TojWBkRF5XqydyTabz+vxc
	QcRw+o7axWnnJE0KSzulC8eni6FNZfPIjnjXQ3O0H2rS/fLELPd8YKcC2ZAvDoEztKp8wuQG3uB
	GkbPdxJAaY1m7GO+U/Wt76Chdee/kfHZkRzWMmb9FADySpCdEvJzQA6O4Sg==
X-Gm-Gg: Acq92OESoSOrMZp4JQ8oJI7o66bYrZOco9ZjO2tdyNTXCJzzRP9joFC88sgxrLhzFVG
	5DZ750xt1L3E6L4zGg8YBwZNqHT4PiFNUsXMa/GQ6fXv4h1F+YBWsAg4zw6xbkI3crPW7bA6f22
	09b/695DL4iJkoZclydcZXFiGqJRR+Uiygx49DVI7iTRvPjzfD66zWsYMTlbCmtsRugQ0mkAyiX
	2spohqLLf50s+GX//urEIzs6Y0Q4AzplBKBOPGyhyxyPkvXw4wCX1ECFj/2abzZishClKjz2zjK
	/Rd82iq/Y3inn7xxf6Rb9axDo1SFGm4J+76Q7hvuJN+kWBX2+KtYh5VEsgtSdglriwQ8HoomMJs
	FPMejJgps7jm1tbYOwigyfOwcP3MjlUe0YtdM2v950rw8A+c2gV22hp8bx12l8QXKkdjC7o7jYC
	Z040Ysi7Ekv5TNlnupa6KuGKdqnCP0EkXzr69N3A==
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr14591355e9.7.1780079775214;
        Fri, 29 May 2026 11:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr14590955e9.7.1780079774772;
        Fri, 29 May 2026 11:36:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c110243sm29636005e9.6.2026.05.29.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 10/24] KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
Date: Fri, 29 May 2026 20:35:35 +0200
Message-ID: <20260529183549.1104619-11-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256718-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 04D3A6076A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

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
---
 arch/x86/kvm/svm/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6e8cbae2135a..62b5befe0eed 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3872,9 +3872,9 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 	 */
 	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
 	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry *entry = &entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
-		entry->cur_page = entry->pagesize ? 512 : 1;
+		entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
 	hdr->cur_entry = idx;
@@ -3938,8 +3938,8 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = hdr->cur_entry;
-	idx_end = hdr->end_entry;
+	idx_start = READ_ONCE(hdr->cur_entry);
+	idx_end = READ_ONCE(hdr->end_entry);
 
 	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
@@ -3948,7 +3948,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
-		entry_start = entries[idx];
+		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3992,7 +3992,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||
-- 
2.54.0


