Return-Path: <stable+bounces-200072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F52CA5609
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA9330E0B73
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 20:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E1A3233EA;
	Thu,  4 Dec 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYtcNpMr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B0320CC2
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881420; cv=none; b=O/ccJmwCqpog3Jg3XQOXqqZJwF4Ed4IAnrvnG5pq698KCzwLZB9AjlRLnF8TZ057ddjIol3eF2XDrEgLHl3MrhuG0IDCBVvJsTvKYeBZhBTvbKIYDXZD/0DDYhBorKVIswxCumugAgaMvFw5IFj6GUv4mnAKkU7qz3IFjYloOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881420; c=relaxed/simple;
	bh=QdxSdzVzK5xrxxMWmz/dhJgRurzJ2W+fjhM9MUROI4E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qywu0VLclAZeJp184VxHhAfAHFZV9Ju9ronSuwO1OxIs+bH4DptVtSDEVAlhvi6JvC8By+kParkDKFrVNZjzfiY73yptvFDXqgzUnmErUelqyrx3F5wkQONrpK81AyJ6I6dscIr5dmbn3cp1/KCd5rz5rlFJyr00MS4wWuGbdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYtcNpMr; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c6ce3b9fa0so1467205a34.0
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764881415; x=1765486215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfhXtjVpMYWte58x/PC24J5XI6+isvfw/8Zcbl9+DZA=;
        b=lYtcNpMrW6xfMys23S4emLlGUrEyjMNu0rdGqEqswLXe2BO23OEjxmTzoWxMUE0dUz
         TEhvLL8+xldwfLn8pZU+zsZgO8jXjOUDUQjY5S8BEPT7vkTdHg+UjopoGGBirxL73Ucz
         ZtqadlimRsavr24rDtgoZrDak2Zc/uNT802oEjN6nnz6oh0/7kjA44nvXXlJjUFSnKZr
         w+uK5G9yuDBeEAx2cChzMn74L8N2nHFg6KWBwLnN6/e2PcFnBC/CoTD6guaZskL4U74d
         dz1GtlD/IzdVf+rxVZ3/sptufP7MZGcXgrPXrJcCQvQwtODlP/MWv6I09Yh/DOb/NZSk
         tYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764881415; x=1765486215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfhXtjVpMYWte58x/PC24J5XI6+isvfw/8Zcbl9+DZA=;
        b=DpdRR6ZMPyXa8tsqDEDzF40VbcgVA6bq58HxDk2vOAmAVEL4ZO0/59suBnl9juYQYP
         Z1/bPMRcs8/HxgIQ27EeBPP5BMBqRj747ypho6AvpphrB/x3MDA+PHgzKozpU//PRkfx
         Ar4a3cn+XRuVyyoAPKbVAU05rixVuvjf/vPw1lMFAz+kQXOmLn6f7HGnjw+rFQvtFmcw
         U1L4cb2g7DYc5TfPWgXRu9ooLwkYz6KGnZGQW+nopZGxL92vAjlaX+4AfNjRc4dyyqqr
         tnEPjFg2boLj3HHVTJ9Qt99nKW/UT55bny3laDgmkRixeRINl+r91bDohux9CUGGMdG6
         mufQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuHt4bnlg4nNa+2Z8vC7urLiyTlZBa/AQfD7sVM9bcis/pnWFA+O8dDlQvTLfoB4SLGrEn3Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMDNtd0veV7Y6v+KEhSaEBrgEEwaD8MGP7CVx3sOXgb2ieoCY
	t9yu5h3kFDL6tGv9wfPYMvM7Pqd6kVEYXRltehrpabDGky6CHRUA9E8RERUJTgzuRKbUEgSQ0p7
	jrOd6vzZUSARRmiU0h+XHRawdCg==
X-Google-Smtp-Source: AGHT+IHKRkFsm1qvW8FHQgUBY9rowKQV8LQD4wg/pfFAOzqqCDtedAh9KEfVk/fSu+irJi0QEI5yC6OCMXP8ByDcyQ==
X-Received: from ilbbb7.prod.google.com ([2002:a05:6e02:7:b0:433:56ba:b9cb])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1184:b0:450:c0c4:3728 with SMTP id 5614622812f47-4536e428247mr3791671b6e.30.1764881415297;
 Thu, 04 Dec 2025 12:50:15 -0800 (PST)
Date: Thu, 04 Dec 2025 12:50:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAP0MWkC/42NQQ7CIBBFr9LM2jGAlUZXvYfpQmBsJ6nQADaah
 ruLPYHL95L//gaJIlOCa7NBpJUTB19BHhqw092PhOwqgxLqLDrVomnRzuwivjz7jDb4lHHJETt
 y5qKFsSfjoM6XSA9+7+nbUHnilEP87E+r/Nk/oqtEibqzrdNKGG10P4YwznS04QlDKeULzWUJn sEAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764881414; l=1644;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=QdxSdzVzK5xrxxMWmz/dhJgRurzJ2W+fjhM9MUROI4E=; b=xsVQAx0YLXTKT8wTYbzwnSITaZIYSGNlnwQWqZJic5nR3ojchC2UaEVQCaQ7cnY5/r5sGShFg
 e7G0a5kMKZmDg9asmBU5U2THu+tB9937IvPJlrFBxjct0SSPaHwhSq/
X-Mailer: b4 0.12.3
Message-ID: <20251204-b4-clidr-unint-const-ptr-v1-1-95161315ad92@google.com>
Subject: [PATCH 6.1.y RESEND] KVM: arm64: silence -Wuninitialized-const-pointer
 warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways.

Silence the warning by initializing the struct.

This patch won't apply to anything past v6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
configuration"). There is no upstream equivalent so this patch only
needs to be applied (stable only) to 6.1.

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Resending this with Nathan's RB tag, an updated commit log and better
recipients from checkpatch.pl.

I've also sent a similar patch resend for 5.15
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f4a7c5abcbca..d7ebd7387221 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2948,7 +2948,7 @@ int kvm_sys_reg_table_init(void)
 {
 	bool valid = true;
 	unsigned int i;
-	struct sys_reg_desc clidr;
+	struct sys_reg_desc clidr = {0};
 
 	/* Make sure tables are unique and in order. */
 	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20250724-b4-clidr-unint-const-ptr-7edb960bc3bd

Best regards,
--
Justin Stitt <justinstitt@google.com>


