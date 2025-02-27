Return-Path: <stable+bounces-119856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCDA486EC
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300DA16567D
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CEB1DF73C;
	Thu, 27 Feb 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KYbQ75Hp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C51C5489
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678445; cv=none; b=PLGWf1hVjXqN0jMOQ1kbw8e7dz54yE9BUfwGLeir1iuIjok4FfHpR91/FbvVJ5XgdnaoC0dDAszS5JO6cAGsK7TNNmhiYQstRAFZTpxw8MvW5qKugx8cK81VaM7Z5oIzf/lShLwpRqgZv7XwdJ3VGiD6ZgzLkimThrC63myeAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678445; c=relaxed/simple;
	bh=bOwn5zZRw9yp4+vrfk3BzuxmlpN+8RGzjHpCiAkL82k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=up7/pAclkjHnDaKSaROgHfwZhTUaI2LuHZxLOxttq+jKQ4mF+m6PusERCJk12yGrcvXerQMJwIHkfSjHbv2na9le13Vi1JSAe5RYXlVKvN20j1r6oVpulT3NmFyA0mz9YxFArXq2DoBmnsj74dC8ueT3HdfaFSPwoK8Scfk/J6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KYbQ75Hp; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2bc5212b2easo710185fac.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740678443; x=1741283243; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC2J6Mb9/RYSJwCU37fb1IaAz399El4qkG/TtbCDhMs=;
        b=KYbQ75HpRwZMG3Zu195FwKALVPo8oOoXFPbI0Ttgmd8b9Z0v+twqwtZG2QGE8GAW0Q
         0poOlo0aZGzklF2Bn83rZqb1kcCGQBAn7p3xyLVINliFLR2/INTtPPXBt3vOsuJcLbtG
         LPiE3jdaTUn1ftwVRquja5OgEfok7yarTiiWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678443; x=1741283243;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC2J6Mb9/RYSJwCU37fb1IaAz399El4qkG/TtbCDhMs=;
        b=OHa0RDal/tf8e+xGCdxmzeWowxP9+3rASTKmrCt2ZIrBU/M1h0Vcpp5JKgUSkvXOpe
         NYKteAJv1X9elcDYd4ep+BhpE8h7BgDtWOhTJASfn+K++vpokeQD0pCQAIYp9+Fm+cnf
         cAn50OhqnJGlKJjW5Xz6soNsVd6WSbnQdXqqbdTbTjZeFC07eZJnn2xP//4ld+DVJ+pu
         DemhhDiAlA+dheVZEwvg9FI6SlcQ4ihDVpgrZFPa7mUVkNVabO7Ua9a80B6xQ6Obv5G3
         ofRcCB+RgtA3rK65tLH0fG9QgaGbhkJGQV1v9LHlC49Kekhcb99s+6N22+YiD+RAre4p
         XSww==
X-Gm-Message-State: AOJu0YxrZSEaY5m0TQ0/cD3WH+egRSgTHhd1MY9dV2Lu1xUAJd6e0Yt+
	EfXfyRHQdbyTM13XHjdBH9HMiO34tZOlnrhwBpXS2B520MKSBYw2cuJfuGWiOA==
X-Gm-Gg: ASbGncuTA4M+jxacg0aIOufn/7c/sMMOsaKXr7xbVJONlW/aXniNIrasGHo3fWiB4FN
	8PU55cpSa193r0sEKKnn+HgGSCd1qo4Ti8n+XFH9EI/AagLaJ4FhCQGfd6RktElQLoyN4k2wCsX
	fGcunijUYiOejhGCj2rf4yIL3COBtm/WN82UtM5+hftaiB5FOZmszdlzT77mA/4j3swkVBNCJ+5
	50qWEFWzrgu/UZEp780MzWh/Xq8soORJw724m2Fa3Oi+GYbJpU/Y/+7EOLaiPG0tB2JhDrwXlTx
	026MkRPBwlV9ro3iQdnLK+K2dW7U7+CQd+ikMa+OhG1ALzvHYs9s9b0dkZKNNg==
X-Google-Smtp-Source: AGHT+IE8XZ+28PXtIF3rqQI56RoJIDoRjyLhnTul82ozQ0249c82pcF8rg78xs90VxHUTHIvPlr1HQ==
X-Received: by 2002:a05:687c:2191:b0:29e:499d:1d33 with SMTP id 586e51a60fabf-2c178433b9dmr51623fac.14.1740678442705;
        Thu, 27 Feb 2025 09:47:22 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c12639esm362545fac.14.2025.02.27.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:47:22 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: florian.fainelli@broadcom.com,
	Brian Norris <computersforpeace@gmail.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: brcmnand: fix PM resume warning
Date: Thu, 27 Feb 2025 12:46:08 -0500
Message-Id: <20250227174653.8497-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Fixed warning on PM resume as shown below caused due to uninitialized
struct nand_operation that checks chip select field :
WARN_ON(op->cs >= nanddev_ntargets(&chip->base)

[   14.588522] ------------[ cut here ]------------
[   14.588529] WARNING: CPU: 0 PID: 1392 at drivers/mtd/nand/raw/internals.h:139 nand_reset_op+0x1e0/0x1f8
[   14.588553] Modules linked in: bdc udc_core
[   14.588579] CPU: 0 UID: 0 PID: 1392 Comm: rtcwake Tainted: G        W          6.14.0-rc4-g5394eea10651 #16
[   14.588590] Tainted: [W]=WARN
[   14.588593] Hardware name: Broadcom STB (Flattened Device Tree)
[   14.588598] Call trace:
[   14.588604]  dump_backtrace from show_stack+0x18/0x1c
[   14.588622]  r7:00000009 r6:0000008b r5:60000153 r4:c0fa558c
[   14.588625]  show_stack from dump_stack_lvl+0x70/0x7c
[   14.588639]  dump_stack_lvl from dump_stack+0x18/0x1c
[   14.588653]  r5:c08d40b0 r4:c1003cb0
[   14.588656]  dump_stack from __warn+0x84/0xe4
[   14.588668]  __warn from warn_slowpath_fmt+0x18c/0x194
[   14.588678]  r7:c08d40b0 r6:c1003cb0 r5:00000000 r4:00000000
[   14.588681]  warn_slowpath_fmt from nand_reset_op+0x1e0/0x1f8
[   14.588695]  r8:70c40dff r7:89705f41 r6:36b4a597 r5:c26c9444 r4:c26b0048
[   14.588697]  nand_reset_op from brcmnand_resume+0x13c/0x150
[   14.588714]  r9:00000000 r8:00000000 r7:c24f8010 r6:c228a3f8 r5:c26c94bc r4:c26b0040
[   14.588717]  brcmnand_resume from platform_pm_resume+0x34/0x54
[   14.588735]  r5:00000010 r4:c0840a50
[   14.588738]  platform_pm_resume from dpm_run_callback+0x5c/0x14c
[   14.588757]  dpm_run_callback from device_resume+0xc0/0x324
[   14.588776]  r9:c24f8054 r8:c24f80a0 r7:00000000 r6:00000000 r5:00000010 r4:c24f8010
[   14.588779]  device_resume from dpm_resume+0x130/0x160
[   14.588799]  r9:c22539e4 r8:00000010 r7:c22bebb0 r6:c24f8010 r5:c22539dc r4:c22539b0
[   14.588802]  dpm_resume from dpm_resume_end+0x14/0x20
[   14.588822]  r10:c2204e40 r9:00000000 r8:c228a3fc r7:00000000 r6:00000003 r5:c228a414
[   14.588826]  r4:00000010
[   14.588828]  dpm_resume_end from suspend_devices_and_enter+0x274/0x6f8
[   14.588848]  r5:c228a414 r4:00000000
[   14.588851]  suspend_devices_and_enter from pm_suspend+0x228/0x2bc
[   14.588868]  r10:c3502910 r9:c3501f40 r8:00000004 r7:c228a438 r6:c0f95e18 r5:00000000
[   14.588871]  r4:00000003
[   14.588874]  pm_suspend from state_store+0x74/0xd0
[   14.588889]  r7:c228a438 r6:c0f934c8 r5:00000003 r4:00000003
[   14.588892]  state_store from kobj_attr_store+0x1c/0x28
[   14.588913]  r9:00000000 r8:00000000 r7:f09f9f08 r6:00000004 r5:c3502900 r4:c0283250
[   14.588916]  kobj_attr_store from sysfs_kf_write+0x40/0x4c
[   14.588936]  r5:c3502900 r4:c0d92a48
[   14.588939]  sysfs_kf_write from kernfs_fop_write_iter+0x104/0x1f0
[   14.588956]  r5:c3502900 r4:c3501f40
[   14.588960]  kernfs_fop_write_iter from vfs_write+0x250/0x420
[   14.588980]  r10:c0e14b48 r9:00000000 r8:c25f5780 r7:00443398 r6:f09f9f68 r5:c34f7f00
[   14.588983]  r4:c042a88c
[   14.588987]  vfs_write from ksys_write+0x74/0xe4
[   14.589005]  r10:00000004 r9:c25f5780 r8:c02002fA0 r7:00000000 r6:00000000 r5:c34f7f00
[   14.589008]  r4:c34f7f00
[   14.589011]  ksys_write from sys_write+0x10/0x14
[   14.589029]  r7:00000004 r6:004421c0 r5:00443398 r4:00000004
[   14.589032]  sys_write from ret_fast_syscall+0x0/0x5c
[   14.589044] Exception stack(0xf09f9fa8 to 0xf09f9ff0)
[   14.589050] 9fa0:                   00000004 00443398 00000004 00443398 00000004 00000001
[   14.589056] 9fc0: 00000004 00443398 004421c0 00000004 b6ecbd58 00000008 bebfbc38 0043eb78
[   14.589062] 9fe0: 00440eb0 bebfbaf8 b6de18a0 b6e579e8
[   14.589065] ---[ end trace 0000000000000000 ]---

The fix uses the higher level nand_reset(chip, chipnr); where chipnr = 0, when
doing PM resume operation in compliance with the controller support for single
die nand chip. Switching from nand_reset_op() to nand_reset() implies more
than just setting the cs field op->cs, it also reconfigures the data interface
(ie. the timings). Tested and confirmed the NAND chip is in sync timing wise
with host after the fix.

Fixes: 97d90da8a886 ("mtd: nand: provide several helpers to do common NAND operations")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index fea5b6119956..17f6d9723df9 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -3008,7 +3008,7 @@ static int brcmnand_resume(struct device *dev)
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		nand_reset_op(chip);
+		nand_reset(chip, 0);
 	}
 
 	return 0;
-- 
2.17.1


