Return-Path: <stable+bounces-256714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMMQJ1fdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C6607614
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB16030316FA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811042EED3;
	Fri, 29 May 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbUhqruY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1JckBS2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D04279FD
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079774; cv=none; b=mPYNKB82Yr3649JWgF2kzgBgbrdN006guwMVq06hBvS2iUdsRefupD4dXIMh4OAKLM3qdCH5m9PLbwe4dK93f2NWn8ECJKaInv/6iqHyDHmyeQcKf0++0/X+hpE71e70yxgpPSNOcq06hzC+do0snOeZOzJ2+RIxtJ6PcNcMAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079774; c=relaxed/simple;
	bh=JLl8YjbHuCGzOk/HWi0SHb1/V1UT/hbE1I30zoZy6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/L46OS1uBhlDupi2Nz2jKg9KOSXkI8OTLGFORk/z6NYTRYKbkZPJTTtGRB8nq1CA+RWohBz9vEDqaZlBfLqlHeiUZVZJVj82kPrjVwq8WHZ9IPWAJBsuNY5EAxbjbJtf39GHEHNyuKbFR4unCJa19ywoqJgk1ftbn9xD4/hR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbUhqruY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1JckBS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
	b=NbUhqruYtpGvrNetuNQXdHfkL/pn4db9SPWe2Nix+Amgg4P56494TfaYkZyoXNR+Q0ZQw3
	REBbXSpAD7lZQh+7rb3GfnSwNWttxfuNojyHNGMBAY2AEXz7EFBhwp+wF2b8ofwOxpeyhC
	HhX21cDLLlJps6e2DuShzLKj2SFm3wE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-QT8X-g3bPyG1c5xQzM48tQ-1; Fri, 29 May 2026 14:36:04 -0400
X-MC-Unique: QT8X-g3bPyG1c5xQzM48tQ-1
X-Mimecast-MFC-AGG-ID: QT8X-g3bPyG1c5xQzM48tQ_1780079764
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4909deb82d0so6963765e9.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079763; x=1780684563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
        b=D1JckBS2XzRV+n15PHnq310NJ2gag4jWWhD9JkmsOOjMLSSt63lHDytzyBCH93LBCY
         ol8oeq5CsraepLtFoKUV8fFGSSzkaleJUDCQJ+7jiLDE7+7KTyOmLSn9yrEC8n1dzK6+
         G8yYC1YeemsL4RqkQdSfzsNarpFJUC8cTNM8tO6rKj8Qxkd1jXy+8wtadnIbCqq8K/SU
         MqdBDg5oYdMAhFKgzPsEYSEVY30O4SDyB26vNQba4N+MAUDBZKLHslkA2L1mMVGINgbK
         sjyPYVfWaUefePg30OeKADeJEut15bpu1to7dk0YHcZ40UNNvYLb0498/VCWtTUEz1tu
         FLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079763; x=1780684563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyh3yBei2dvCuDBWuVl4/7h8CqM5bAYkcfDKwxMNYFY=;
        b=O6HVtareWv5FAUgvIs4/IQpCExAMa33z4PgubY/kfba5bCQKsTvyeetXg8j6Beu8ic
         fuyjduavWS2Z5z17y4gSRV5pUuaxNfVKVkm54USnpN558hNpW7bZynSCHQcBgHnB/hHN
         abSxR14q/f3sHgQZXV6/MADhrZ4KHpyz3pMjUJ97gbqU1l9wpqpA06UK9cBmhMtq00dF
         SRBs6RnSe6RjsShylZmxS4YzcnAJo4MQic1Ld/lblpOP5lygq6x8YIuOMih1AAbTa8Ae
         DhO7SAdkFF4RZJqLnFNBnY2kXnfAS8IbAGJvT35j2y5+0UUSRmuzb1cE8a4gJOzCqrp0
         bbEg==
X-Forwarded-Encrypted: i=1; AFNElJ/myl3ghd6jokZTfuK4PAHdbWXVT5O1ol1R8R5F92IHvdIUaSQVo8H91lwBoRUmEF1Veen4taQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HtzUqAE9A31OqtB8bhsGDlniyaGw52qywFW3GBLMN/5FyCoK
	eGmq82yVubRhsJXhEam7D+4knGK7vTmOjnFS0a/VleaiC3hvEoP6Ohlda+JZ9POoRXEeul1siZO
	xAFvcsYyR9QIGXrrVH2NSd/LOCbLqeq7FYpee2gcyYibqQtvm+Qd67cqfVMLiKVPwrg==
X-Gm-Gg: Acq92OFzpNI6cp9f6j7f+S5E8ve2lc1UJj8Hf4J9QEGcVJWdsYcW15wCl5GE3mp9Cyi
	JieGb+VyPwLfltN3QpQBbjo0GvbBdA9Of8b400bmIcYQ+LmNGf2wBUBznWsypEk02EcVfFzcuTi
	82lcamEF9GaalZmLiu/0CXtuamTu2nbBdPrgs2zXk+29+nMs2uRtd3FJ7TeF4r9/9VUQMI23M/Z
	yHqgxJkRhIXJJiYaml/OeZiiVhg6DIAaYw34wWEHzs6ubumFk5YfIGoLNQRY6m66cVPWA1i+eF/
	39qlLTQo2FA39f5Ie3Zx0c93aSVozzlbnZnSSGabL0z6m4i3L8nvZoRcrj8VCKI53ecRE2/FmIR
	LwXC42AHQ9Q0eBRZD2hDzorNH7FuflCTPHW/TaQyGuaQjRj0o/+NJnLqarK9N4EwsVCKnvrmz8I
	QP9eQtzjmCz3UgtgkxmjJf/OBAYkGHvkLbE+fDLQ==
X-Received: by 2002:a05:600c:314e:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490a2968857mr11860005e9.32.1780079763476;
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490a2968857mr11859665e9.32.1780079763049;
        Fri, 29 May 2026 11:36:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm49675745e9.13.2026.05.29.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/24] KVM: SEV: Use the size of the PSC header as the minimum size for PSC requests
Date: Fri, 29 May 2026 20:35:30 +0200
Message-ID: <20260529183549.1104619-6-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256714-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 2D3C6607614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When handling a Page State Change (PSC) #VMGEXIT use the size of the PSC
header as the minimum size for the scratch area.  Per the GHCB spec, PSC
requests do NOT provide the length, i.e. using control->exit_info_2 for the
length is completely made up behavior.  The existing code "works", e.g.
even though Linux-as-a-guest always passes '0', because KVM doesn't do
anything with the length when the request is in the GHCB's shared buffer.

Use the header as the min length.  Once the header is retrieved, KVM can
use the specified indices to compute the full size of the request.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 52703c954856..cbb3040e0778 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4559,7 +4559,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.data[0] = control->ghcb_gpa;
 		break;
 	case SVM_VMGEXIT_PSC:
-		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
+		ret = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
 		if (ret)
 			break;
 
-- 
2.54.0


