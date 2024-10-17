Return-Path: <stable+bounces-86684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FD9A2D29
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301DA1F24D94
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DB21BB06;
	Thu, 17 Oct 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XWZH4gXD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3821B42B
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191842; cv=none; b=MxgaOdXI+mN+e8yJZMwHLH8ZgHwJFBW57Klb6LsfwPfZfrpOeZU068npH7+aWqmWSs5DiH0CV0YCIiNN9JJcSFhvWbaa7PEbkq1HfsO7n+CofWdJHwh6PMkNUDXdP3BE5EPZvqw0ljueziFa7N1081wxD2qkEiEgyQgsc+3CZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191842; c=relaxed/simple;
	bh=1iJ9CO/sJUeY8BJ77Z1oy2osckCfCBDy55nkuGRtof0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlbwliZ8H43BsOnxrGNKQvRp6+ltXnRyr/Ri8n43iZZMloFztBngCvBLC1eSmjtMMmalXPN66VzRcNSwImIyDg6H2KTntfetnwqFI1ldrAhzKzBQhxWo5+h7gt5De7y/eXHqONM+woTTAThKsKzAycG2b+jlE5PYThG+Kc/T4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XWZH4gXD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1467af9dbso89689785a.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729191836; x=1729796636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qH11hcxNbwY7wx+W/7cRdf6NRA7wQzbx43qz3yjVmc4=;
        b=XWZH4gXDUM4zzm774t56vn7a1gz07NHD4f3YWaDzjwr1ktrC4Y3w4G+wRJe1qUJm9T
         CUWCyXznccb5tuzKSHs5Vp6I5iBpwPQAzsd2P3YRD3SvFOXyfJaRXKP94h3JfPpwTgye
         gfUdJNsiVMANrQeYAekspuoRGNPoQCV4FlbUFEHbTArW2LxMK+2izEPeBtY5/MZGlWRG
         xD9Axl+QA8oyvbBHO4GBaNxeleTi14IaB0+pqU+3abzZU7VxjR2KmNqAlPn2MxV2nQ7V
         F8hQ2X2TA7/TgiI9LLmrGrtiFqkumVi4+a+TxISu+0gcaVZJ/GXqvx96rKHo4o9BHBHQ
         RtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191836; x=1729796636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qH11hcxNbwY7wx+W/7cRdf6NRA7wQzbx43qz3yjVmc4=;
        b=eb/4Xvs38wBH153lKnzc6DhQO742iWgpUiY2vJF/iRKQUkDmHL2D2IonO71479SO5q
         us0B9074qaCPWC0jUKTqgwzDY0nMoSEyELWZ2WjzH6ER5JcDXI9GrU1mu/cK8nat3njy
         RiS+kk2rkhnSgHaYRdZSrbTExtIdQGu27O+W8ht77vsN136s5onj9TcccDO47mA5M8SF
         mdLkikhpbgWECrNrtaKlbGVgz3ssbWeoUSZRFjoTVkZNTyncCq9JoaT0RU3IY3ojtnCx
         QpuZ3vAL25iYuNjO15Hz+vqnS/V63BwK4MEiZ7033iP1jTuxut8Mj6KQeb4yXlVG2sX3
         hVoA==
X-Forwarded-Encrypted: i=1; AJvYcCUXt8I84Ptd184Mp7aOioHyBHGo2+qgSkXWFYtFFy6TkVbr5SEIIbc0OZ+TXPEGvOz0FRL9twg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE51QbHP/7YAHPXSNZBtUsoqFZmgLpO7HdSGDjAq4MNVrs5Rn
	VMuV+t2JlTShShdq6GrN1sD+hGnUDIgQrqr+k1MO5yqdpHLGmuM1ESVrfJXucqXdySuKqsyDLmA
	s
X-Google-Smtp-Source: AGHT+IHmvZWzsm6C2/haXl1uVw6bseyVtbDuR+pZu1yr4xkN1vYFqbrNK9ZkLR/bbOALsetjNvUchg==
X-Received: by 2002:a05:620a:2453:b0:7b1:4cc0:5e1f with SMTP id af79cd13be357-7b14cc05ec0mr590409285a.7.1729191836065;
        Thu, 17 Oct 2024 12:03:56 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e22dfsm30211241cf.35.2024.10.17.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:03:55 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com,
	ying.huang@intel.com,
	bhe@redhat.com,
	gourry@gourry.net,
	tglx@linutronix.de,
	takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH] resource,kexec: walk_system_ram_res_rev must retain resource flags
Date: Thu, 17 Oct 2024 15:03:47 -0400
Message-ID: <20241017190347.5578-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

walk_system_ram_res_rev() erroneously discards resource flags when
passing the information to the callback.

This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
have these resources selected during kexec to store kexec buffers
if that memory happens to be at placed above normal system ram.

This leads to undefined behavior after reboot. If the kexec buffer
is never touched, nothing happens. If the kexec buffer is touched,
it could lead to a crash (like below) or undefined behavior.

Tested on a system with CXL memory expanders with driver managed
memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
showed the flags were being discarded and as a result the check
for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.

find_next_iomem_res: name(System RAM (kmem))
		     start(10000000000)
		     end(1034fffffff)
		     flags(83000200)

locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)

[.] BUG: unable to handle page fault for address: ffff89834ffff000
[.] #PF: supervisor read access in kernel mode
[.] #PF: error_code(0x0000) - not-present page
[.] PGD c04c8bf067 P4D c04c8bf067 PUD c04c8be067 PMD 0
[.] Oops: 0000 [#1] SMP
[.] RIP: 0010:ima_restore_measurement_list+0x95/0x4b0
[.] RSP: 0018:ffffc900000d3a80 EFLAGS: 00010286
[.] RAX: 0000000000001000 RBX: 0000000000000000 RCX: ffff89834ffff000
[.] RDX: 0000000000000018 RSI: ffff89834ffff000 RDI: ffff89834ffff018
[.] RBP: ffffc900000d3ba0 R08: 0000000000000020 R09: ffff888132b8a900
[.] R10: 4000000000000000 R11: 000000003a616d69 R12: 0000000000000000
[.] R13: ffffffff8404ac28 R14: 0000000000000000 R15: ffff89834ffff000
[.] FS:  0000000000000000(0000) GS:ffff893d44640000(0000) knlGS:0000000000000000
[.] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[.] ata5: SATA link down (SStatus 0 SControl 300)
[.] CR2: ffff89834ffff000 CR3: 000001034d00f001 CR4: 0000000000770ef0
[.] PKRU: 55555554
[.] Call Trace:
[.]  <TASK>
[.]  ? __die+0x78/0xc0
[.]  ? page_fault_oops+0x2a8/0x3a0
[.]  ? exc_page_fault+0x84/0x130
[.]  ? asm_exc_page_fault+0x22/0x30
[.]  ? ima_restore_measurement_list+0x95/0x4b0
[.]  ? template_desc_init_fields+0x317/0x410
[.]  ? crypto_alloc_tfm_node+0x9c/0xc0
[.]  ? init_ima_lsm+0x30/0x30
[.]  ima_load_kexec_buffer+0x72/0xa0
[.]  ima_init+0x44/0xa0
[.]  __initstub__kmod_ima__373_1201_init_ima7+0x1e/0xb0
[.]  ? init_ima_lsm+0x30/0x30
[.]  do_one_initcall+0xad/0x200
[.]  ? idr_alloc_cyclic+0xaa/0x110
[.]  ? new_slab+0x12c/0x420
[.]  ? new_slab+0x12c/0x420
[.]  ? number+0x12a/0x430
[.]  ? sysvec_apic_timer_interrupt+0xa/0x80
[.]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[.]  ? parse_args+0xd4/0x380
[.]  ? parse_args+0x14b/0x380
[.]  kernel_init_freeable+0x1c1/0x2b0
[.]  ? rest_init+0xb0/0xb0
[.]  kernel_init+0x16/0x1a0
[.]  ret_from_fork+0x2f/0x40
[.]  ? rest_init+0xb0/0xb0
[.]  ret_from_fork_asm+0x11/0x20
[.]  </TASK>

Link: https://lore.kernel.org/all/20231114091658.228030-1-bhe@redhat.com/
Fixes: 7acf164b259d ("resource: add walk_system_ram_res_rev()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 kernel/resource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..4101016e8b20 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -459,9 +459,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			rams_size += 16;
 		}
 
-		rams[i].start = res.start;
-		rams[i++].end = res.end;
-
+		rams[i++] = res;
 		start = res.end + 1;
 	}
 
-- 
2.43.0


