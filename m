Return-Path: <stable+bounces-256712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGrlBSfdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:38:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F456075E7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 917EF307CDBD
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0519442B72C;
	Fri, 29 May 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJjXHS7e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pprur9qd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D154279FD
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079768; cv=none; b=SQt6yq/QUMLBWYWfOd0hjJBIbxI/TRk6ron+vauEvp7AOif5VVAeS4cq17YUPRKIP90FvR5P6CGwtLNs28n9o9zWi6nahfPaevgZ/2Xbxww0OoNnGhwSRR4XI/bheK/AqEQNVEx/4zPgoFrdqvqcupR/dUp1+KnfcgZ3lyCh7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079768; c=relaxed/simple;
	bh=f+nkgUwG6A0jJd/pAJCpY6wq36Ry3jzJBqYji69OyE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF6l64ptA0b6z6h+WRRtHW27Uli/mcn6GDOm9qM3Caxgya2H4VTuukCMHcWF8XSWL6BIAXOA/BKvxg4c4iTmfeTpOUAGUYi19cFL8Wq6jPoDWPm1udutbJ1PSZVRR1goPwJqOm/W1G4TnljE2EdOSKgvJKPjuuZjBsNx5w3ggHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJjXHS7e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pprur9qd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
	b=ZJjXHS7eeUAEi+rJVgMrE3PaLyzPnHax7jtt2HCX6TGGTSq/l5JMxs0PD0mm5eCVl2ZHPl
	aJFW7ZTotBAsDUxHreXILnQM4787HSJ8CBVf1yVlLk2GQX06/w1nZf+RZt7N1LPjDJlkgh
	7CllZtIBqismyalprbuhmGjQRe3C6uw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-IEdc4vAnNvKRklPIPUvBjA-1; Fri, 29 May 2026 14:36:02 -0400
X-MC-Unique: IEdc4vAnNvKRklPIPUvBjA-1
X-Mimecast-MFC-AGG-ID: IEdc4vAnNvKRklPIPUvBjA_1780079761
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49058295985so43196185e9.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079761; x=1780684561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
        b=Pprur9qdqaQrq/F6LOS953AZYsH5rwPrVxedBf1zhCULsPHZSZ3c2tGW61raWAgGN8
         9x3dl+2PnnS5aU17xAjnfChodtJHWO12TyHcqQ20L/L6JmNRl3Z8EFaa6MB0RmOhrRKL
         2u/E/7Mt10lTHij/Ktgm+1ioOCDDYG04p/JOMjKjFkVAtEmEjEi50rNn4sUBAq+c4c1B
         /vcRT0vpd2oP8d3h0O+lALsKsPT1MM13kOOVHT0Hc1vcx3hJ8IXDbfO0pbKwwvLQgtfu
         w74QgmLfMkv+1wiNeumjohLJ7Mx3boh5iLH2yamTNkCbXcF0RUn5Rg9MDVRqO5s87cmf
         DQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079761; x=1780684561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XndtQXgYoKhYp0VgWVa9fVm5ME+RcvJYRIMg+5FuNQc=;
        b=prC5tZLEMHXTtPtWYMnHrhJCRrW1MJW8N+zfJOpub+fvIHot38O3zz0Z9rhOPu9Eca
         xnOIfCLmPW6fmr7KR4pa7xi7XS2miSWu5PoScQWmncWdsqsshhifLruxKt98Pp0R3PkA
         j0wKQdTfTHjYts+AzjT6pfnzv2CLu/N3YRPdvZwAAc3jZCa8DJ7ETN667fisX8WqGUbi
         PJje4dWMtfAgq1RrRCZaPnuYHTvkXoqR4cXXPeUl5jbJOvv3UrrHX4cSNaL8JLK2bRQ4
         mZtzba65SiRQZ2ViXFf9Pk75z4Nwxh0EpBvLnF2aM04uoe+FL+wuFSb9PMeNRIP3++iO
         IS4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lq9TYzexoklhOiAmM6Arrlz+AyjXiWzDgxD/vVCicQikUxsqEMc35FlwkvPZWpuUc3GIcWbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/+a7Bgs3iWecB4kwAjCswTJxZhvH9ZVpRliHz7psFsTU7IU8
	wdDoteKb2/lHilc7Op/3Relrni7zqOnY5S4RI5BpIMa4x6s57Q6CywM9RGgkRSc1oaSIH9jlsWr
	v2OvmlGTni92Blvin3U8HsYv+XKpetImmSakx+l4VTnb063kbH3ua3te3tg==
X-Gm-Gg: Acq92OEd89p3DTNGlParRbmLKc2wXN6NOY9S6oV7mkUHC66S0V3vLcAMhOztjlhKCDJ
	2bSNqLsKgc0+swnVJ2gtskl55m9HKHRH9NkPgSKbwjkt68Krjx3apzLmfYcpnPogHmXwc9kc4aN
	I1uxN/z972Q/1ajnwzJWIIlTVLWUWF7bBbwrlTTSqMNl8eXDAsvVOWN4cC6tr20jDUkv+7F5yRB
	kKOoP7yudoTI8z6t0YyTy/GyIm7DeaDB/fyTxVmXk1M3kpzzITP3dN+eyu6KULrJbCMn2oDRQD6
	ADJeS9OxLjcJVBVDZB5FU+6cI6Eq/IaKZvVz9hdkVD7OOoAfeKvvdRqfClLibtftuYyvgebQqQr
	ALIQJuVf2rCOPwHicaEL0lCfXABd/8134l6cf6qF+XoMALxOPJJedQGtkClp+qTqZGQMg43zXUp
	AQjD9j4KXxmv6CSi956lAM6n/BxxXTuuRojcBW5A==
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490a2933b22mr9949035e9.18.1780079761512;
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id 5b1f17b1804b1-490a2933b22mr9948755e9.18.1780079761169;
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0a89sm73788825e9.7.2026.05.29.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/24] KVM: SEV: Ignore Port I/O requests of length '0'
Date: Fri, 29 May 2026 20:35:29 +0200
Message-ID: <20260529183549.1104619-5-pbonzini@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-256712-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C0F456075E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
setting up the software scratch area (and other code) doesn't have to
worry about underflowing the length, and to allow for WARNing on trying
to configure the scratch area with len==0.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e6579ca9f364..52703c954856 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4585,6 +4585,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
 	}
@@ -4605,6 +4610,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;
-- 
2.54.0


