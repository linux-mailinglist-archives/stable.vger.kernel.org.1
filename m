Return-Path: <stable+bounces-92861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF99C6514
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5728394A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7B21CFB2;
	Tue, 12 Nov 2024 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhSGDvqb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33521CF91
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453786; cv=none; b=TERPqaybQCi/C+2bxqYU4iKqyuAmQbiRZ9USnsEeRqfQ52vUTl6192P6TViy2xsT/a91xAdTbKfIFStJbV+F1c0D08P3d4y6qP52ucQWQZN9GfhHySb5WE5Ioxa7Q1FNkXMwjPaQTV1NicrWgEjfdN6nTQOmZ+8DkTePTzIaaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453786; c=relaxed/simple;
	bh=ayby78yQOyjOz6ls+yE5cxTfghhQvc3yyzZlL7gs+bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BDtXmX326h82vlHRFk+en9FU9HqYq2Hwv/U7x99zaxTKRDVXOXwjrxDeXPsN+2Lnb849sIH2Tk2rJTyRaIH/AJq1gNRpGAlJvX3YkKNipkPjCuUoqyFc268HskQ0KC0yJPX3Xd8gI8bsVkiF7aj6sxSq03cnfXgYmIn6h5ydO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhSGDvqb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e2bb354e91so6498025a91.2
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453784; x=1732058584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=vhSGDvqb1dkZp23maJjOm0aVpI8AuAJy8zaOHGi1Ce2dLhI1Eboz1WTOohRMcP0xMS
         FpYWPLcJk8aZIKnmsjL3Y+Idv3Jwg4msGh++kQhDx1XRFcdbVsVDZA5oN+/zflE1UCiX
         wWJ74ulIO5b6b/NL/1E4UbVqHWAxkCRBllUGzNRfAjZQusRUKUCVAhsThbQJaG8Yo2C8
         ebrQvVtea9tkmGTmNmFldRS+4bEjf3n8AHZZ5dVaM4W5zFfD1K52Q8CHa/uezxcLaUUR
         0Q9S9jn3KpYAtPnc3H9qzU6X1eU2KMdSV1fsJXObLopapE/XjucGHhLY61A1yWwFFKiV
         g2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453784; x=1732058584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmL++hD8fgHMSusvyHDFwqq57StgWysj/njcEHmccMk=;
        b=JbDB7yJ3tSnZzeudywASon8qlYepPhj/C5BHlrr9AWq3ol5FhQKbVDu/mUvYig+onO
         Zsqp1xA5BaloTV5mBOrH6hm24fhMc7hNAzBOgi0moaT5OwFBSEpzarFsR9wdW8KA6NTj
         kbdmrEbobZPIT8oHSCw0HpjjmmyJ088TpaCaYHqPOpjg/a0dx1QEIOWz8Fpcgbv0IM5n
         7x4sLPEiQrnn6GjoGYTyRzx2fUVJyI1PjTSAsXymcrE2WVvx3DxhWwww2YvM3rLbIJ1g
         yZOscLeT8C8mUSzqAJFiXfD/sx/hGZqoOMvEY68s3yqn13cyalmx/M3ulxCSw4gIPLIT
         8wnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEeY7CTmUmhkgscXaPtRlau5KFRL6eGIJrkJQwtkUqJU0EZHPQfGhgg1YkzeSvnXF/QB4wi3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiwvAnSXt3MR3EqHa1W2dT/2gYUOaZBCHDV2t8M2QxTj2PUL0
	05E6pgKAdTeGX8d1ppRpMPJdpPw7uIZrsAWDfYGU+XP6E/GVBiAbjhqk+XVcE+H+C1HNJgqjwYy
	BBPSAwzuz6invLg0fwjehzQ==
X-Google-Smtp-Source: AGHT+IEKIx/zzlZD9qfrCEEtWDHbsmZlYa32pBSY0nOxUmKrJ4QniZXwOwxKWzCDaGQhHEeyreWYnDeyUdJT3VYCwQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:2ec3:b0:2e2:bb49:1052 with
 SMTP id 98e67ed59e1d1-2e9e4c7f1aamr70975a91.4.1731453784634; Tue, 12 Nov 2024
 15:23:04 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:41 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-3-dionnaglaze@google.com>
Subject: [PATCH v6 2/8] KVM: SVM: Fix snp_context_create error reporting
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, stable@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Failure to allocate should not return -ENOTTY.
Command failure has multiple possible error modes.

Fixes: 136d8bc931c8 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_START command")

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>
CC: stable@vger.kernel.org

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 357906375ec59..d0e0152aefb32 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2171,7 +2171,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	/* Allocate memory for context page */
 	context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
 	if (!context)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	data.address = __psp_pa(context);
 	rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
@@ -2179,7 +2179,7 @@ static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		pr_warn("Failed to create SEV-SNP context, rc %d fw_error %d",
 			rc, argp->error);
 		snp_free_firmware_page(context);
-		return NULL;
+		return ERR_PTR(rc);
 	}
 
 	return context;
@@ -2227,8 +2227,8 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		return -EINVAL;
 
 	sev->snp_context = snp_context_create(kvm, argp);
-	if (!sev->snp_context)
-		return -ENOTTY;
+	if (IS_ERR(sev->snp_context))
+		return PTR_ERR(sev->snp_context);
 
 	start.gctx_paddr = __psp_pa(sev->snp_context);
 	start.policy = params.policy;
-- 
2.47.0.277.g8800431eea-goog


