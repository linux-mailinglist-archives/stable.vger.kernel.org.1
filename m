Return-Path: <stable+bounces-256715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCv+EQjeGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BA6076B2
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 490753093E1C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9CB439015;
	Fri, 29 May 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEk4wLHu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSWAkN7D"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD7421F0E
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079776; cv=none; b=Pgy0YNIvy3z9nTdWZLi+qGy48b3VIIpUDyGS9dQ1p8MJ5RlSdyP67CGmvD/lbt14b2+kUVVOM/clwHIyO9g4x4k4VLsGgI9x+ppYwOXmvDySAAlTsf+QetptZ5fC0u7PwKT/UKaC0xLMlZZYTb7vdwf+H9Y38wwmPjeq6Uq8XEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079776; c=relaxed/simple;
	bh=OJPzTAm4OBNQKBdHA8sxYljhi4riTjeTUbJrve7Bw2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFclUvABEe4p56WodC42I2le/LDBDdYcRCXvOBfCqp567p4KTypo0poNklxU+psAEl+Uiu8yn1mTp9MjrCTPuo5XHVOaJ7DE5AT8MjC3q/In0EQvy7m+EWPcX7ITpkbgDu8jIZBy78GkIC7N+DF0cpR98cP2WbJ11aweClSQ8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEk4wLHu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSWAkN7D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
	b=WEk4wLHuVzsPpIzStqGm31MnDr0ypAMoLwBjDIaph7NI4Q4TTJPook/+LANU53zvGqFvfU
	d1hQPtMc9fp9oaBDxjdHOcwWQeT3u8PFFjbkqKlWphncAEB34UfoE/dCK21kRPpZV1UwuG
	ANtMyFwCm3zbg0CLm1vXM9NGxoekX9c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-9M2tqW7KMyetVkF3Eeo_3w-1; Fri, 29 May 2026 14:36:09 -0400
X-MC-Unique: 9M2tqW7KMyetVkF3Eeo_3w-1
X-Mimecast-MFC-AGG-ID: 9M2tqW7KMyetVkF3Eeo_3w_1780079768
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd64c32e8so96172275e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079768; x=1780684568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
        b=jSWAkN7DfB6x1Vcxolq+TqWu77MFOxhj6pUgpOynzulOAEj7xXvfECp78ZkUrtwJi7
         euHl/POuu80ZgN04lxmNE60+l4HYRcj+Kkt1Pg2yEMGH/y09rLTFCPsx3RhSsv/rgNVh
         1ix/ACTdxLHxnJeshPAHpjcoG8CKU7H8kRq+GTy1RfxU4VCiSGpgYZn9CEUoPuGENKnD
         rPC2oLBhPo/g5dvi33ooL6iWIvZ2Pj/ghUhpXCzKGLebyrn9jrtGMAv42gUwZ6LYlzmN
         C2oCTTxe/z8SU4miXKdp0U7tdVghIXgH13t85wvFiMMF2+7enK4eI2VIjCQxZllWlmMv
         i4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079768; x=1780684568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbzkUA9BmnyEtGSi/a9eH75seLkm5VdEusAeKn8m7RA=;
        b=beS7cdAhFhadv3rKpYZuJjH4hd7sHS+FwuUjgfdZlUjPPTL1WXQj+hzL+NXfVj3tkr
         kF7hsdxUN+YdtZJ7Ijgramkrex9HrKUURvKZ2Gllr0zQRcq2Wdsbzynoxh7TPSsoheMH
         yE9EgQJUpOcPCms8d31O6QQTP1fPlffvoIE//OubpA11uJOUTRqRmqdzBuOhRxokQxQW
         yOBLj6JGppIXbJ9Z263K2CGyTn6Z/dHAtzn8DIrH1MbdhwgTIaJGRxjGEsk/BN9Yy8nI
         QQbzraDzn+AyW7cz9IVC3aP8lT+wXFMnTa+g0tntp2079PofzDKXNNxpQcmO4ZFdjPnq
         3FJA==
X-Forwarded-Encrypted: i=1; AFNElJ92yo7u1c/p/ACPDp0QOCSMJT1HVpADQC/bdtxM/C9UgiJ8tAgUbwlGndKnqnvB6qiz3A5332U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpCDD38SL28cugpXaBxT8JZ60ORtuyUtx9ea+hvkBppXhQxnn
	u7jeQCSGFqSkPVwQKkM0S2rVE1+aV0i03pBsVIkMOx4zbaIOFZFD/AYPEP72sGW2t70VolPm1BX
	kXNvzbGzf7ku5U3wEpS1MBAiEb12VQePxDpz38k7Q4JxOhHuC/9E0fCo4dQ==
X-Gm-Gg: Acq92OEp/lNcGv6hnQz1b6YRAIuhNq7X1li4n8r8yckgc3e2JUrtnNwQs7h0oUBCfK/
	y7fcX7DPkvm+DcmUcHb60KVEgC2BXMwUBdB9a+oPdildUgdUplzO411WtHmUDZiMdXuXU8ZG323
	ILatymV3nvKCLEzdgoX1SacYAiPv1UqCeipy/mh9QJ8H6nDn6u5XNdqw5Ekbxz50Z8NjLNhIQUL
	MiNkBojQJX+xty3W2bVFk8Fr6cCTmtuIsUJCC0lHQxh5kx4eJ6HaQyPw4LsSlq9C0PvFxS8RefV
	A5dBFXgHjFGSZB84NPitkFbfSpvNvAVbTLtHyoP9loICySpIH35OujTkq4ozTr69ngQ59jqJQ7S
	L8r68rYflLXy9TqgHNNpmzL5IIKvme3Sjy6Uj+b9n5GXmUl3TV1pZPXh5Uu64ZwuSXsjXVF7igN
	0ieUoxjJv2ND422O+AxFgrQrAeMWldV4RY1Jcsxg==
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490a28d390emr15119015e9.0.1780079768343;
        Fri, 29 May 2026 11:36:08 -0700 (PDT)
X-Received: by 2002:a05:600c:8b53:b0:490:5380:f2cb with SMTP id 5b1f17b1804b1-490a28d390emr15118485e9.0.1780079767918;
        Fri, 29 May 2026 11:36:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c967c6csm64118605e9.2.2026.05.29.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 07/24] KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
Date: Fri, 29 May 2026 20:35:32 +0200
Message-ID: <20260529183549.1104619-8-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256715-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 173BA6076B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Now that all paths in KVM properly validate the length needed for the
scratch area, and are guaranteed to pass in a non-zero length, WARN if KVM
attempts to configured the scratch area with min_len==0 to guard against
future bugs.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-8-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6072fecfe994..a3e85348ace9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3669,6 +3669,9 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 	u64 scratch_gpa_beg, scratch_gpa_end;
 	void *scratch_va;
 
+	if (WARN_ON_ONCE(!min_len))
+		goto e_scratch;
+
 	scratch_gpa_beg = svm->sev_es.sw_scratch;
 	if (!scratch_gpa_beg) {
 		pr_err("vmgexit: scratch gpa not provided\n");
-- 
2.54.0


