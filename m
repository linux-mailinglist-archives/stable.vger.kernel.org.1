Return-Path: <stable+bounces-164703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2FB115A4
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 03:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B158F3BE1FC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CCB676;
	Fri, 25 Jul 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31+4+doQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B057376F1
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406137; cv=none; b=WtdWeg9W57d07U2u0NvmiuGZmgS/ekS5I/iAgDLhxuaYm4h2Czvp3r68JLBr01cnhpkkxgEOnkF14ElTQmKAKNWpZ/mwhUrh1uqH1UUbK3NesKlmwG0Wu8+NFE/RN36wYKtPPzgXG4f/lX0Di51qvGnn4cwG+7P0LXd7LNP3tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406137; c=relaxed/simple;
	bh=9d2LgkAsER9qXvaUPfEoLgpaLUIRkRofct2D4FWudKI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cSebGB91QecbrPYa9jeQVU1+SwVk31TuHY/fGIcMN+ObM45odDeVTs+0gOG4sd2eVOYIkATFy9lLsXYVRPHNI6bbHe5PZaqwpJemUPDBVoASsODS8cZJOImdlo9Fw54d2LwedPOQYS3Fcfhi+lq3bfUtQfmUKMN7qHuuzCSouFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31+4+doQ; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-87c24b196cbso166983339f.2
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753406135; x=1754010935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFITuuJDgutpEFJlerPyHHpSB0sfh/jbjTlG3FOcAgo=;
        b=31+4+doQdWFBU5yROK0V0upG7crHTpa8z8IEXwsYndxUFcIhgUmvcPLpcwZ5hOgOfs
         kpPFvUscoUJPSRpQoKYv/dhRrGFPyRRC4Q1hQUrL9674MntEALWfplzkjborBaBpPdyQ
         GdIWkAPtRvfYn94VvRCdxNijWgThtLn3tE0WHeqPfKDVGgiytx+frwy7pSLSinAZzro2
         hR+7Cg/6aA0e8vgWOAR59fiiU9vFdxraprIKPF7kMI5aZVKyp+IaNKN2vfeYeBHQDTa+
         DVsiXQT6MInYRgRT40gdmoxh7nYGVhwOVwOCqvzZrcyeGtJDr13AJxfHKRPpgPI/fSIr
         rHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753406135; x=1754010935;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFITuuJDgutpEFJlerPyHHpSB0sfh/jbjTlG3FOcAgo=;
        b=KmX5fLoTASmw/BSu1RS0egPPFP9gE7B2SHgGvsXWcvKLWSsPk38DIHjzTEndKPuIZO
         T9shClXvXLsTe+xaNnnBx6RCcbF1cn1ZdmBY8N39uKuiwbSrFiQNS38GzvFiY8+bIkSc
         P/Nt8n+e93I+QwUnBlzvgKQEICgys+7QU1Wk9vpiOMLxzXyPs4mKypBWN7rRprJBLjve
         1+/GJxlU3vAhFTRw2ZPfPyS4zLdwC4mzqSDOq47cyHwOJqqboXPdQc7j/DhPEcCYOTj7
         CFSStAY7bTrhD+jWv6wG/UplnmmBxuBv0kIl40KrWTlaLvKASUJX6AXZrbmMHuHrE4Pn
         xqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCWUMg8LWOzfcgClMY5g0L35JrAcFPKAFygIL3Vcd7ZgENkN/gf0y6V+Oed5WLanXS/AOp1UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrFSpsdr5F9jqPNoS1iAYFuk1Vj5c99iRvdxquwIfkcfQWOVP
	jLfGggNZCx33GMGtUp905H33M0yWbkKDQb1axx+nfLWbWolGWL84XjoKQvY9t1rR+KOiO/meJ/x
	/h5XmFhqBJnB3KSShCCUkKFvHcw==
X-Google-Smtp-Source: AGHT+IGOtyjrWZUt4IHge1YVAFkDgbRkTc1qBa9LhfCId/pQ3L7S/vw2KQQqW8B0agIZPE8gkRvP90/rdal04fwoGg==
X-Received: from ior10.prod.google.com ([2002:a05:6602:a00a:b0:87c:359d:819])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:1689:b0:867:6680:cfd with SMTP id ca18e2360f4ac-87c64f87d98mr1663521139f.1.1753406135096;
 Thu, 24 Jul 2025 18:15:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:15:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK/agmgC/x3MTQqEMAxA4atI1gY69Q/nKjIL20YNSJS0DoJ4d
 4vLb/HeBZGUKcK3uEDpz5E3yfiUBfhllJmQQzZYYxvT2RpdjX7loHgIS0K/SUy4J8WOgutb43z lAuR8V5r4fNfD774fh1uFv2oAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753406133; l=1391;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9d2LgkAsER9qXvaUPfEoLgpaLUIRkRofct2D4FWudKI=; b=Az97+z18RNg38lLclau+LqNY25wUxs7AH7etlMkLkQAjtx4UrkJ/fucCvYO1m1JtsrhW59gi2
 O2QmudrpqmkA3awdm9rNP+my9CyxHVn9/w9CtSU5eSYTY9DSciiwM0N
X-Mailer: b4 0.12.3
Message-ID: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>
Subject: [PATCH 6.1.y] KVM: arm64: silence -Wuninitialized-const-pointer warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways.

Silence the warning by initializing the struct.

This patch won't apply to anything past v6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache configuration").

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
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


