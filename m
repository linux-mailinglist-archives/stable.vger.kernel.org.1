Return-Path: <stable+bounces-256710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NSmApDdGWpazggAu9opvQ
	(envelope-from <stable+bounces-256710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4273607651
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3EBB303E0BA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E0425CD0;
	Fri, 29 May 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5aGWrLk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISL1fgGN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA7421F1A
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079765; cv=none; b=KO4XJ3g9Fkxr75gvCZdWrESNNG7sTZj64WEbLmTnWUxJoHKmRyiKbb+MkzmenEXT6+H1nY3mRiuSF2u7BMabOcCahSBPjV2O+X+Y4nuE8eO16vYskohRv2TO+yN9Ehmk1lTnPgHfAhR5p1xmeRqLw4CAQFplT2nO+IgSbrMPPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079765; c=relaxed/simple;
	bh=Ic42NJxjVTuyyhMYhy6XU5l/gYDKkJGnaGzHHnNqay0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUrPN/diic5sKd+PdO+C9314gScASbEPNQtaArZscGIhLsah32RayoyLQCa138QfJZXsdZw3NRhuEyu5pL39Gl7k/P9ygheLUu0H/oByAFMyYxf22jgwbuZmw3bWyqc5Jcp6pp1KR24w72aOYFkhMKqMTbj65bt1X4eNN+UZINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5aGWrLk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISL1fgGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
	b=W5aGWrLkNyBCswg4maOjNyaCb7IuQ4oYivDIqZs/NErKpmgJ+8gZoZhI4WmHcG6Naq+byY
	tO2iSeNpkE2r5Zt1rRTiV4OWKuyR28xz/6VPYsJXEYroKWsMNlmkTLhYC1EmoPGcN3F07Z
	IwXrb7E0d5D1L432VD80O7JmysEr0aY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-rLQNasZCObSY8-7OB6PmgA-1; Fri, 29 May 2026 14:36:00 -0400
X-MC-Unique: rLQNasZCObSY8-7OB6PmgA-1
X-Mimecast-MFC-AGG-ID: rLQNasZCObSY8-7OB6PmgA_1780079759
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490402ae2c1so79740425e9.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079759; x=1780684559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
        b=ISL1fgGNShxnQjGfQF2kQ7B/utyID71pnDqI5ctnmKMnLPWhl0v5/AZ26TygE50CIQ
         o3VGT/Iof0LL9/c+H8RDCRDW9HXa8RSLV/CmUjMqwMYCKfvDRAF2zPz9OE+zEAEDhqQD
         rImawR8DEYDvjnFw9Bb7DcB6tJUahKaO8rax+kT4eL5V4rIrHbsTo/PW4Fc8mDfmT/uS
         W3Spib4Mh9kMeKSlwXp4h7TwORZITWSu6OaTGLYw+bQzj6K3uFMf19lXznTxJtKCtNww
         C299CHBLK8uHLRlFZdOgKG5Jspv8R/nTAQpz7EOjJy+YBo5id9ybssMOFGKhfT/g2pUA
         9hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079759; x=1780684559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaDspuaK+51kNrKIJDmVaTpEzuF1DrT0Ap9tU5k1194=;
        b=neagN7iV5JVV7ZVQrpugJL0znDLVQlBEwKbH3y7EH/4+vbCFyJKQ+cqSdA4Q0nnsg2
         ZWROXvHBz+VsLJCTHxcUGbM1EwRfnA61xMlGEgjFBUXyTd7ha/TlKoV3/C8s1uhjmOxP
         z9dxwkygr0bX1Q4hASpcNCJq34Et+6BTXg7F9NKPCuCjy+QnqMNaNuB1LZPzq0JzKTWy
         1Itbfu+OyY53mslKEBKHbfTmVnEgcSLXcOWb8houwOPkeInaYfjvrThkd0gqLZKf3NkJ
         +C44AwHf5Ir+RvBLT0ZxakrNoHZzTdIwpTDu+QPRkeW0U6vOwCa2WtEKQkid7GkLEdYF
         9EbA==
X-Forwarded-Encrypted: i=1; AFNElJ9uNI0FU630nZcEV7mgB9CnxsDtdHj7Z1PjYjNCCyrsWSypM2W4QLcu2nDbd2zWHqfnz5TroGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSpfnrko9MhctDZTTf3UvWXy3xwj+8xGL1aqjabhrPjjJ2QiX
	gg09DWs6xV7ZN39OhM/qGsHTuquqRlUhEwahDzPSLm12P8CNtHMiQWVCJZ6H4ritFASU8OpWYAT
	ZfyPzEcE2lBXdH4+Ackzqm7upVXkMuwwpyyL9ELyPUaIGP8WkfenZvC++RA==
X-Gm-Gg: Acq92OEaHxl0ELKzLQbXIsEurMSA2xfBz7OthCl4PKn63VJPG3JVdzSxEy39FiNDIPW
	oHyJBKfS0kS5INIEy0Emas/2WGgFXAkH9kjZ001XOBiOtKKHfUyURhlRwztwlcGDmSd5OmZa+nj
	ZvhllRnY7f804semnUSxQq1GblsTYCYuZjwhLm2KGO6g/en9C41Zu+juqUGxyDoOLgoHI61dZAv
	YEPNJRajEJxybuYgI2YS/3yfVDki0+WviCHxgrf66hG9uTYMNg62+YNviRUyQ3AuC8FI+95hnFn
	LGUWtAvsRMF9I6ahOQT/2yLAT7EOJJDTB6MqAKv14FJg6HPpXZnUMpNNpezgpwBEuElpfzDIFmK
	8fNjBeNHBUzyUtWL5iVBbVVZjF4cV5uGVJX5dVasPRXfDmY4J50soMl62wfxCDHmbpvqpExgBWf
	TzSqQNdtfzueTiM7BdZErYAldTGrGIUxBKFdtAKg==
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490a2a4bac0mr7346645e9.12.1780079759016;
        Fri, 29 May 2026 11:35:59 -0700 (PDT)
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490a2a4bac0mr7346335e9.12.1780079758656;
        Fri, 29 May 2026 11:35:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c114e99sm19737625e9.25.2026.05.29.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/24] KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
Date: Fri, 29 May 2026 20:35:28 +0200
Message-ID: <20260529183549.1104619-4-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-256710-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D4273607651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When using GHCB v2+, reject MMIO requests that are larger than 8 bytes.
Per the GHCB spec:

  SW_EXITINFO2 must be less than or equal to 0x7fffffff for version 1 and
  less than or equal to 0x8 for all other versions.

Fixes: 4af663c2f64a ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fb2174b6d1ba..e6579ca9f364 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4502,6 +4502,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (!len)
 			return 1;
 
+		if (to_kvm_sev_info(vcpu->kvm)->ghcb_version >= 2 && len > 8) {
+			svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+			return 1;
+		}
+
 		ret = setup_vmgexit_scratch(svm, !is_write, len);
 		if (ret)
 			break;
-- 
2.54.0


