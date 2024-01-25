Return-Path: <stable+bounces-15819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4017883C845
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1BB28F9E5
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55912FF9E;
	Thu, 25 Jan 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqarEH/M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86580130E32
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200759; cv=none; b=MMwfKlOquXfWPwfK+d9fyrJpTprhMQB4/GKYdjpeUS1YAog3Zc+ytsONr+Bc/UASCO1vN0gj8f6Yp6jEjOaxDRV3ShkHH9c/v2AdnGzz7WxJzB8OG5DBAdSZdDnAejL69TgM6QK0R6HMumKb/JeQ2R/uvqk+3xYFVEY63uvR/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200759; c=relaxed/simple;
	bh=5iJTd7yzgDfh2+k57BWpredB5hTRe6THo7ajyW+K5Hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKDqbMZHffawWidY1ZHhbkFEuc7FkL2PxOJuOUkB2u5v2yqvkeIMF+h9193Aw9pN7a/uKtgs4H8wwupmNVLoyYkkagUvXZaDTZCPVKrKpG1Fl3AQMZ03840EedJX8xiHTqOveKRRc3elnikzmdyA0F1SVLRhbG1THd7lqcLnOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqarEH/M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d741ef71e6so25932905ad.3
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706200757; x=1706805557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iIEiMLUr8+jAmf70ri1NbSPgh5YY+Kqzdr9UKUTLtWQ=;
        b=NqarEH/MlRAOGkeNqDvjaPXnz2qTAAIkA2DbgTYNw0QwAxMEiXxd8DX54eThSCk5gZ
         GisBzYdnTT+dBtiw4Dj5iCMVpZMCiXRcR5hYn0WKZzA6ECKUECUYva4non/vCL5gT8pa
         j10dEAHIEO9yww/vQ3+XgyeGZlCueovaUS2S2KbcrmBCgr+CIl8Lch27T9EeDTU2PR7H
         80rXhnRRT9jSSINV9wee+xb5MhPBSbDdiIaGS+CmFsNgHzGrWHzpkDG6qpz6J09mzOKY
         ujCw/hm4BuFjoMtuFDokyBwuPF58pT6yQeOmiC84XLKJvUfSc76Xfx4nV5q8ijYGt0l4
         xNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200757; x=1706805557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIEiMLUr8+jAmf70ri1NbSPgh5YY+Kqzdr9UKUTLtWQ=;
        b=Sv3mmYa+U1tXZH08LZQI3gTXpxD1gEvoMdUdLK5iZxVV5WYeUYT7OC/cSma/2TXHVr
         0gUcR+sPzR4FA+MV0dNdl0mQMwvxG+OK2Ll1h5Ee+gOZwDFpkHn+lu1M4tTQkbq1+oTb
         GLs97GAHCIUnkFQR4gPIzoM6Bg0RG3nbKGd51l2s8UWY/Bqe8B4A1sJqwMQ6CgwbBewQ
         2eDuyC3Ybl45pCGbfkNvfi5sHqy5GIJLoXpRZoy+s1a/Tey3ukYkbaG6uTGxP9mePgdh
         WbZNMFk10jbe+wRD9StLwsxbb0m1m0CHF+2B/Vxg9H3fcl2hwSWHCgpY3r5wpMxNEXX3
         t+kg==
X-Gm-Message-State: AOJu0Yz3LBa50sjuaTiJ/GKNmogf8UtwAl6MBRlNuPWMVCRXbz31HQqz
	QdcmZbQyu7OlADr38NF8VqjfzF+/54XuRceBzcYPDKcn1DlBE9OSMH0bs19r/yAOlmeblkvIOmq
	v7q3QeAhaFVqgRgjJ7VMhc02KF/i/7TExOj7F4i4Gi/IodMKUyxrde0SsWGIvsWYzgwF54x03zD
	2EXTuF4bWlvVOnmTWKPX898LnfN0rPuzo8
X-Google-Smtp-Source: AGHT+IEDD5G0mwDyVahAfW4zJg0VVApMCFLgWEKz/0165zPORK2/5nEUoC9NGXf6LZpT0bcyNxuc/gjrIWM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7886:b0:1d7:5a02:df4f with SMTP id
 q6-20020a170902788600b001d75a02df4fmr5817pll.4.1706200755053; Thu, 25 Jan
 2024 08:39:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jan 2024 08:39:11 -0800
In-Reply-To: <2024012236-pebbly-coroner-581f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024012236-pebbly-coroner-581f@gregkh>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125163911.2762171-1-seanjc@google.com>
Subject: [PATCH 6.1.y] Revert "nSVM: Check for reserved encodings of
 TLB_CONTROL in nested VMCB"
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Stefan Sterz <s.sterz@proxmox.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Upstream commit a484755ab2526ebdbe042397cdd6e427eb4b1a68.

Revert KVM's made-up consistency check on SVM's TLB control.  The APM says
that unsupported encodings are reserved, but the APM doesn't state that
VMRUN checks for a supported encoding.  Unless something is called out
in "Canonicalization and Consistency Checks" or listed as MBZ (Must Be
Zero), AMD behavior is typically to let software shoot itself in the foot.

This reverts commit 174a921b6975ef959dd82ee9e8844067a62e3ec1.

Fixes: 174a921b6975 ("nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB")
Reported-by: Stefan Sterz <s.sterz@proxmox.com>
Closes: https://lkml.kernel.org/r/b9915c9c-4cf6-051a-2d91-44cc6380f455%40proxmox.com
Cc: stable@vger.kernel.org
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20231018194104.1896415-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index bc288e6bde64..d871c65fbdd2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -239,18 +239,6 @@ static bool nested_svm_check_bitmap_pa(struct kvm_vcpu *vcpu, u64 pa, u32 size)
 	    kvm_vcpu_is_legal_gpa(vcpu, addr + size - 1);
 }
 
-static bool nested_svm_check_tlb_ctl(struct kvm_vcpu *vcpu, u8 tlb_ctl)
-{
-	/* Nested FLUSHBYASID is not supported yet.  */
-	switch(tlb_ctl) {
-		case TLB_CONTROL_DO_NOTHING:
-		case TLB_CONTROL_FLUSH_ALL_ASID:
-			return true;
-		default:
-			return false;
-	}
-}
-
 static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 					 struct vmcb_ctrl_area_cached *control)
 {
@@ -270,9 +258,6 @@ static bool __nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 					   IOPM_SIZE)))
 		return false;
 
-	if (CC(!nested_svm_check_tlb_ctl(vcpu, control->tlb_ctl)))
-		return false;
-
 	return true;
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


