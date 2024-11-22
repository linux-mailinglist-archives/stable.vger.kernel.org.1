Return-Path: <stable+bounces-94636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A09D64D5
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C17B22156
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6B176AA1;
	Fri, 22 Nov 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGFPkTPl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CA178384
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307029; cv=none; b=N4w6YZlC7BuL+y2rAPZNnlq/KPid0Txr06XIHi/Yt7s7CS5OfLETU9hVS6RCFx0V+chbfXBEkPnl1WZHCBlfArZUIqpbei4HHWBJg2AYPfRZVMx0ifulNmsHh7JHMeZcD7M1VDD6jfXL9k9kfn3BWvqpQ4pgq0tJ9IC+PT+diKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307029; c=relaxed/simple;
	bh=wj7XC8Ez6cCJRJw6pmUFCOa1cTS03sRVxyKXqSIFc0A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IpBpeqwfMQNhyLQtlTM8EWJqehG9MJYB7VI08Al93HCf6M7g4aWY+UJc/geXDsjsuSgkgZGOzhoWPKMc1n5hKeQq3WW4kDPTLt4CV+S+AcCiC+xVNqcitXmklpflZTpW6xpuAWPQehgSqsjwHbpwHgyH9Xp0wzryKsUKgjCmc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGFPkTPl; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-83a9bd80875so258186239f.2
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732307026; x=1732911826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAvtorLGZx/ko8b438WYo5+MNdJYJiGYAvo9sCnf2Dk=;
        b=jGFPkTPl/+pHChNtWWak7QMuolS8QKXJWGaUx1xws70aQvLeZ5+Dyk1J64z8a0V0BF
         fJAp/oFQkr5tVC8WGfpcSXov+ch/Qep+0LBHbEDB6luz9EPYswTj31gaAfFnSuXKU2np
         uTeA5qSu3W9uXEMMb7Bb2YrrImuC+vr82ogKCe6dtmD0CUw6BehjPypTNkdf1BdGDVb9
         0XsugBg3djylElrmPDEb1gbaqf7P/sfE+udIiRlBgUomvi8fu5eRyUjKT+aPyUrKB6Sd
         zNF/yFC2x1FHFZlZFh22V22RWG7iTvctNqPZO4V3QP9GGsl4sHvGSUDPsxddrHwoYm0u
         YSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307026; x=1732911826;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAvtorLGZx/ko8b438WYo5+MNdJYJiGYAvo9sCnf2Dk=;
        b=Run+O82dikKdrRV2OnmyySRG6fBMPztlbC0MedWQDXdttfBQy95pWye/NA00340Q6D
         paUXMMxMp4KGpJQb/Yx4+D8EJG/CGNJjRBQRfopGmpNfmcpnYXBdESD/TWqMJc523Aig
         sl6l2rK8rZapUHUAjyO3rZD7ThfFEUVH5myCje2gp0BRcwzf7T7i0xqSfJudSj+41Uk/
         m9k70dU4mwNKBdbMNxfxDmGJqRnHy6ASgQw42CoOc1ruE7us2p8DAi7HRJmgeOkUFXag
         2fT3PpW9RQ5goFUyHIPB8CWIahzmaKUXeECbEaCcAPRhwii++u9MkLlbjQYcOQ53JEn4
         Qrlg==
X-Forwarded-Encrypted: i=1; AJvYcCVTMtjSaYpNqYdF0FgEbOW8vQxkIJ/GkvzmShj4dBRjztfCAOhmKlB1h9pIMwttei27Dm6iKpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qTATUxErJp3QBnwupDyvB8xN9qnUfoWk7URyALMV+U9nsSzB
	JXWhvvvHyBsSpszaKBItft0SR5byXFG8VOHEVjcKuGsZzyeMG80La/2PwVzbVhsFuF/0+cdLR+V
	U/g1VdDed234mWaIDkMGIKS2Oh6pPNg==
X-Google-Smtp-Source: AGHT+IFGfGyQ/kG0DjXGx2MTm0uZZBFfTrQdjVPbwPi4ifMA2Fyavhcy39JEKlfPhY46pkaQNMH4oWL2136ugsGNyLER
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:ba:c019:ac11:dac1])
 (user=kevinloughlin job=sendgmr) by 2002:a02:c656:0:b0:4e1:dc53:cfd4 with
 SMTP id 8926c6da1cb9f-4e1dc53d481mr4059173.6.1732307026503; Fri, 22 Nov 2024
 12:23:46 -0800 (PST)
Date: Fri, 22 Nov 2024 20:23:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122202322.977678-1-kevinloughlin@google.com>
Subject: [PATCH v2] x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()
From: Kevin Loughlin <kevinloughlin@google.com>
To: ardb@kernel.org
Cc: ardb+git@google.com, bp@alien8.de, kevinloughlin@google.com, 
	kirill.shutemov@linux.intel.com, sidtelang@google.com, pgonda@google.com, 
	thomas.lendacky@amd.com, x86@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

commit 1c811d403afd ("x86/sev: Fix position dependent variable
references in startup code") introduced RIP_REL_REF() to force RIP-
relative accesses to global variables, as needed to prevent crashes
during early SEV/SME startup code. For completeness, RIP_REL_REF()
should be used with additional variables during sme_enable() [0].
Access these vars with RIP_REL_REF() to prevent problem reoccurence.

[0] https://lore.kernel.org/all/CAMj1kXHnA0fJu6zh634=fbJswp59kSRAbhW+ubDGj1+NYwZJ-Q@mail.gmail.com/

Fixes: 1c811d403afd ("x86/sev: Fix position dependent variable references in startup code")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---

v1 -> v2: Fix typo in commit message, add Ard's and Tom's "Reviewed-by"

 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index e6c7686f443a..9fce5b87b8c5 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -565,7 +565,7 @@ void __head sme_enable(struct boot_params *bp)
 	}
 
 	RIP_REL_REF(sme_me_mask) = me_mask;
-	physical_mask &= ~me_mask;
-	cc_vendor = CC_VENDOR_AMD;
+	RIP_REL_REF(physical_mask) &= ~me_mask;
+	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
-- 
2.47.0.371.ga323438b13-goog


