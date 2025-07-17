Return-Path: <stable+bounces-163229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA13B087A2
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF161AA1851
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9513279327;
	Thu, 17 Jul 2025 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JM94aVfu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE0218AB0
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739788; cv=none; b=F6DbVwqYP8N45scoa1aL4TSoDAphT8D+++GAeHmvQmJ3oCO2LEwAMiRQik/QbUKH+WccHvt94boLj+5K8poWClR1nnIbu/oX17PgoQ7JTDc846+AJWarl6h/v3EcGQrDtmQwtBehYDrhLcbTcLjwVWizNktKosN/RX753onFIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739788; c=relaxed/simple;
	bh=r7OQ4mvVus4ZaAvVKvet8YqFp8ZzBnz7mjBnNp/swt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se7wxXjGOZOEtU9GTt9Q2eIYmMgw4Go8CT2l3r3RpKwOpO4ji+uPrIfW1TOOCUISQa/plnqgV8qXuuKZi4zLFDuohgeW139zRc1iW25np5uymVEalhJHZuv2ZxEW5Ys2JHLxgBby3aJwvS63RBgHJcd+l8i4J3Oy/s6IIgUUc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JM94aVfu; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so4349855e9.3
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752739784; x=1753344584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFo/b044VvJo0eWcD+3p0cPO1w9kPPX6y28h41wkJYI=;
        b=JM94aVfug4SuImsZqk0F7Ga7XXzinIDXCUAse+vE+avW/KtiP0Wq2Y6Yqr4jYoG31Q
         7Y2Qq2zEop/iocsGCo7mirDUyL2INgsISQcRfKSawa/LEDuVcI897QIZhWd/V5ND8rcu
         V5twcFK2x5PNMuP3p/XLkh7ud584rH8vbLuTmdn0sBqamp4QRSNCgyz861+sk5LK0Qfv
         uSXgRSqzmK4v7O4dKdm7FYQJbr2atF/u0l9bdO0L7dwIOB3DL0DY3jt9lpUZPwbA/fTv
         RtnzyjrIRCtJAXOWBqpaal5Ch2T5lGZp0HplX0ik11rSAAIc2CqOSSmoB301ZGR4R4iE
         jD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739784; x=1753344584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFo/b044VvJo0eWcD+3p0cPO1w9kPPX6y28h41wkJYI=;
        b=gXnjKbD5j3xoT6/MxGefpRWtE6kMJVD8ZVAlaY3Lt94VMHt58PjNiaDyX2wGud1gex
         WMOvUBKp1h7UftiVcf20k7PNUjArB5ecE2gGYVgjV8G1wnDnczJZmIUVlnEEn7iuQml9
         MkgvZRsLEjPm0K3EIHSwlKLoieIvh23PWun1pXIoq58QrtEDfpbI/WZ5mmQ3S3fbotGM
         XERhlTA/aN7pQxl27fT5QF0a3DjFN+s/nE6W+rqybQCXVFzrj+MiRMsnijgXYhPAA/eU
         p91E7ccxVD1vUQbmPj7y0DSMb8k1FFY/FAgSwqq1oVFuwGJMGIrXtmFm3F6Cm1Jj9bPi
         GSsQ==
X-Gm-Message-State: AOJu0YynsgHfxZc2i1LEcKIVhXjM13jrk75PVIlqsf4z2CLVrqEDZkyh
	zvFDygSb/IVR1a34fcWVlY0wL+bXAVTgK0VMWJ7GPIx+6fDmz843ffGtNJmao5ztO9aLVmYrHgC
	BjL5I1RqZTA==
X-Gm-Gg: ASbGncvXpaTd0OSKqxy5fkIOYQZHLwpzszsKa/RYCUM0EylS+58CahjNCAh7lPXG6lN
	1hmog3po7oOcVHc29sQu132USrIapuAUI70Cgx8Ax+XxC9pFowLWqXFUKO0L06VzeVA8f07z8WY
	5vSX1qpPxEmFf/zcWCFHetJ6g61qqESrXl3aQzGjBeg/VYsOWTpmxI1z242n6EF97Ioj10nwKl0
	ihwOj0z6X/43T/hwjlOgKNqjQ4mDmQQqMeF9QuPRIQt8AzTkProhHpTaZN/Gd1ucI4NG44xegBy
	zmfWIHXiITYBAf4L+u5OQ6aTYWOuRxq0/RezAWPuE9XwTJ6Agm4/FSZp6yvDuhkLHopmJ01eQBm
	8HJnRInsX11Hm+P/H0JAibqB9
X-Google-Smtp-Source: AGHT+IEGdvIxnfvixeMBSS4Rc73B0DzaJD7k6l2nEjBvnRQvH3Z2w5yZUIbkwz2UJ4n4ggjtldn4ng==
X-Received: by 2002:a05:6000:21c7:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b60dd8f441mr3589212f8f.56.1752739783793;
        Thu, 17 Jul 2025 01:09:43 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:365f:22a6:ee13:ef7f:1e74])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4323e2asm136657685ad.110.2025.07.17.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 01:09:42 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 1/2] Revert "selftests/bpf: adjust dummy_st_ops_success to detect additional error"
Date: Thu, 17 Jul 2025 16:09:24 +0800
Message-ID: <20250717080928.221475-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717080928.221475-1-shung-hsi.yu@suse.com>
References: <20250717080928.221475-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 264451a364dba5ca6cb2878126a9798dfc0b1a06.

The updated dummy_st_ops test requires commit 1479eaff1f16 ("bpf: mark
bpf_dummy_struct_ops.test_1 parameter as nullable"), which in turn depends on
"Support PTR_MAYBE_NULL for struct_ops arguments" series (see link below),
neither are backported to stable 6.6.

Without them the kernel simply panics from null pointer dereference half way
through running BPF selftests.

    #68/1    deny_namespace/unpriv_userns_create_no_bpf:OK
    #68/2    deny_namespace/userns_create_bpf:OK
    #68      deny_namespace:OK
    [   26.829153] BUG: kernel NULL pointer dereference, address: 0000000000000000
    [   26.831136] #PF: supervisor read access in kernel mode
    [   26.832635] #PF: error_code(0x0000) - not-present page
    [   26.833999] PGD 0 P4D 0
    [   26.834771] Oops: 0000 [#1] PREEMPT SMP PTI
    [   26.835997] CPU: 2 PID: 119 Comm: test_progs Tainted: G           OE      6.6.66-00003-gd80551078e71 #3
    [   26.838774] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
    [   26.841152] RIP: 0010:bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.842877] Code: 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 00 <8b> 47 00 be 5a 00 00 00 89 77 00 c9 c3 cc cc cc cc cc cc cc cc c0
    [   26.847953] RSP: 0018:ffff9e6b803b7d88 EFLAGS: 00010202
    [   26.849425] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 2845e103d7dffb60
    [   26.851483] RDX: 0000000000000000 RSI: 0000000084d09025 RDI: 0000000000000000
    [   26.853508] RBP: ffff9e6b803b7d88 R08: 0000000000000001 R09: 0000000000000000
    [   26.855670] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9754c0b5f700
    [   26.857824] R13: ffff9754c09cc800 R14: ffff9754c0b5f680 R15: ffff9754c0b5f760
    [   26.859741] FS:  00007f77dee12740(0000) GS:ffff9754fbc80000(0000) knlGS:0000000000000000
    [   26.862087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   26.863705] CR2: 0000000000000000 CR3: 00000001020e6003 CR4: 0000000000170ee0
    [   26.865689] Call Trace:
    [   26.866407]  <TASK>
    [   26.866982]  ? __die+0x24/0x70
    [   26.867774]  ? page_fault_oops+0x15b/0x450
    [   26.868882]  ? search_bpf_extables+0xb0/0x160
    [   26.870076]  ? fixup_exception+0x26/0x330
    [   26.871214]  ? exc_page_fault+0x64/0x190
    [   26.872293]  ? asm_exc_page_fault+0x26/0x30
    [   26.873352]  ? bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.874705]  ? __bpf_prog_enter+0x3f/0xc0
    [   26.875718]  ? bpf_struct_ops_test_run+0x1b8/0x2c0
    [   26.876942]  ? __sys_bpf+0xc4e/0x2c30
    [   26.877898]  ? __x64_sys_bpf+0x20/0x30
    [   26.878812]  ? do_syscall_64+0x37/0x90
    [   26.879704]  ? entry_SYSCALL_64_after_hwframe+0x78/0xe2
    [   26.880918]  </TASK>
    [   26.881409] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
    [   26.883095] CR2: 0000000000000000
    [   26.883934] ---[ end trace 0000000000000000 ]---
    [   26.885099] RIP: 0010:bpf_prog_8ee9cbe7c9b5a50f_test_1+0x17/0x24
    [   26.886452] Code: 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 48 8b 7f 00 <8b> 47 00 be 5a 00 00 00 89 77 00 c9 c3 cc cc cc cc cc cc cc cc c0
    [   26.890379] RSP: 0018:ffff9e6b803b7d88 EFLAGS: 00010202
    [   26.891450] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 2845e103d7dffb60
    [   26.892779] RDX: 0000000000000000 RSI: 0000000084d09025 RDI: 0000000000000000
    [   26.894254] RBP: ffff9e6b803b7d88 R08: 0000000000000001 R09: 0000000000000000
    [   26.895630] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9754c0b5f700
    [   26.897008] R13: ffff9754c09cc800 R14: ffff9754c0b5f680 R15: ffff9754c0b5f760
    [   26.898337] FS:  00007f77dee12740(0000) GS:ffff9754fbc80000(0000) knlGS:0000000000000000
    [   26.899972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   26.901076] CR2: 0000000000000000 CR3: 00000001020e6003 CR4: 0000000000170ee0
    [   26.902336] Kernel panic - not syncing: Fatal exception
    [   26.903639] Kernel Offset: 0x36000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [   26.905693] ---[ end Kernel panic - not syncing: Fatal exception ]---

Link: https://lore.kernel.org/all/20240209023750.1153905-1-thinker.li@gmail.com/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/dummy_st_ops_success.c      | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index ec0c595d47af..151e3a3ea27f 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -11,17 +11,8 @@ int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
 {
 	int ret;
 
-	/* Check that 'state' nullable status is detected correctly.
-	 * If 'state' argument would be assumed non-null by verifier
-	 * the code below would be deleted as dead (which it shouldn't).
-	 * Hide it from the compiler behind 'asm' block to avoid
-	 * unnecessary optimizations.
-	 */
-	asm volatile (
-		"if %[state] != 0 goto +2;"
-		"r0 = 0xf2f3f4f5;"
-		"exit;"
-	::[state]"p"(state));
+	if (!state)
+		return 0xf2f3f4f5;
 
 	ret = state->val;
 	state->val = 0x5a;
-- 
2.50.1


