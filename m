Return-Path: <stable+bounces-120048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57312A4BCCA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 11:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D4C1895518
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548C21F0E28;
	Mon,  3 Mar 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VehcebwA"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12661F2BB5;
	Mon,  3 Mar 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998717; cv=none; b=T0/m/yGjqN0K/NQMzKua+5PPQnqDtY8sINYle8cP6OXz0iqoKkgtzGYaBcuxQpif7uauQrePNW3qvMX9sefpx7SzBbFk2UlCrH1gmPIvjAUnF0Vkc95wkiXuZyDW9xL3Zg/WBmNamnUaosA3LPkEppyO272bsgpQLZw3MqFq6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998717; c=relaxed/simple;
	bh=epqAmMwiaOESlkR2wS6UCOEtQ+c5h0eTQuRBcxubrtA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KjvTtvqc/eVYQK7Hd3rCB/FVHwL0hyk2LLvVC+C8gv2jP5YRVYVKxB+Xo7UFN10acf+/+aB7h2FCc5rhwnni5fOBVDuGRGSwLO4lrYUBwlavR1DTf7A7YSLTOudA3v1mn5ydm+xrQhrJyDinSrjWql+b407d6wqYuc30PDBP0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VehcebwA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8584043426;
	Mon,  3 Mar 2025 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740998713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UruHBjRajISo099N9o0TXvUraPldBWhzjY5wVsDG8p4=;
	b=VehcebwAWX0cYaujiDhEuwILYKiLexTP7qaBpTLxvqYznFR+lGj328K4N5ti7mQGoHdyzD
	3Fh17nXRSpHUer0aRq2ALeAg8s+zswHbUlBxEsbjAZ7jL6VwJscrMCWLLd9LAYZYJ8bwgt
	J9d4dE27yCC6nxQDLmEcH9L+LZ15Mn/mPBO277TKpg3tWGyv/QDBuvfIyH50ryAkWGe7ZN
	G/2pDKCFZ26y7uwAGddXPLF5DC4j4PYC+fOz5T3BsEZkFVD19uoJx5p4mlTACIWDRPzKp5
	JJnc6Aui0YJjFX9qSMmNo10fYXoCqUsZbOL24luzrOHKWHC8oco70zmuWtKQaA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: florian.fainelli@broadcom.com, 
 Brian Norris <computersforpeace@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Kamal Dasu <kamal.dasu@broadcom.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250227174653.8497-1-kamal.dasu@broadcom.com>
References: <20250227174653.8497-1-kamal.dasu@broadcom.com>
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: fix PM resume warning
Message-Id: <174099871242.2206965.1027368384612216898.b4-ty@bootlin.com>
Date: Mon, 03 Mar 2025 11:45:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepkhgrmhgrlhdruggrshhusegsrhhorggutghomhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopegtohhmphhuthgvrhhsfhhorhhpvggrtggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnu
 higqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 27 Feb 2025 12:46:08 -0500, Kamal Dasu wrote:
> Fixed warning on PM resume as shown below caused due to uninitialized
> struct nand_operation that checks chip select field :
> WARN_ON(op->cs >= nanddev_ntargets(&chip->base)
> 
> [   14.588522] ------------[ cut here ]------------
> [   14.588529] WARNING: CPU: 0 PID: 1392 at drivers/mtd/nand/raw/internals.h:139 nand_reset_op+0x1e0/0x1f8
> [   14.588553] Modules linked in: bdc udc_core
> [   14.588579] CPU: 0 UID: 0 PID: 1392 Comm: rtcwake Tainted: G        W          6.14.0-rc4-g5394eea10651 #16
> [   14.588590] Tainted: [W]=WARN
> [   14.588593] Hardware name: Broadcom STB (Flattened Device Tree)
> [   14.588598] Call trace:
> [   14.588604]  dump_backtrace from show_stack+0x18/0x1c
> [   14.588622]  r7:00000009 r6:0000008b r5:60000153 r4:c0fa558c
> [   14.588625]  show_stack from dump_stack_lvl+0x70/0x7c
> [   14.588639]  dump_stack_lvl from dump_stack+0x18/0x1c
> [   14.588653]  r5:c08d40b0 r4:c1003cb0
> [   14.588656]  dump_stack from __warn+0x84/0xe4
> [   14.588668]  __warn from warn_slowpath_fmt+0x18c/0x194
> [   14.588678]  r7:c08d40b0 r6:c1003cb0 r5:00000000 r4:00000000
> [   14.588681]  warn_slowpath_fmt from nand_reset_op+0x1e0/0x1f8
> [   14.588695]  r8:70c40dff r7:89705f41 r6:36b4a597 r5:c26c9444 r4:c26b0048
> [   14.588697]  nand_reset_op from brcmnand_resume+0x13c/0x150
> [   14.588714]  r9:00000000 r8:00000000 r7:c24f8010 r6:c228a3f8 r5:c26c94bc r4:c26b0040
> [   14.588717]  brcmnand_resume from platform_pm_resume+0x34/0x54
> [   14.588735]  r5:00000010 r4:c0840a50
> [   14.588738]  platform_pm_resume from dpm_run_callback+0x5c/0x14c
> [   14.588757]  dpm_run_callback from device_resume+0xc0/0x324
> [   14.588776]  r9:c24f8054 r8:c24f80a0 r7:00000000 r6:00000000 r5:00000010 r4:c24f8010
> [   14.588779]  device_resume from dpm_resume+0x130/0x160
> [   14.588799]  r9:c22539e4 r8:00000010 r7:c22bebb0 r6:c24f8010 r5:c22539dc r4:c22539b0
> [   14.588802]  dpm_resume from dpm_resume_end+0x14/0x20
> [   14.588822]  r10:c2204e40 r9:00000000 r8:c228a3fc r7:00000000 r6:00000003 r5:c228a414
> [   14.588826]  r4:00000010
> [   14.588828]  dpm_resume_end from suspend_devices_and_enter+0x274/0x6f8
> [   14.588848]  r5:c228a414 r4:00000000
> [   14.588851]  suspend_devices_and_enter from pm_suspend+0x228/0x2bc
> [   14.588868]  r10:c3502910 r9:c3501f40 r8:00000004 r7:c228a438 r6:c0f95e18 r5:00000000
> [   14.588871]  r4:00000003
> [   14.588874]  pm_suspend from state_store+0x74/0xd0
> [   14.588889]  r7:c228a438 r6:c0f934c8 r5:00000003 r4:00000003
> [   14.588892]  state_store from kobj_attr_store+0x1c/0x28
> [   14.588913]  r9:00000000 r8:00000000 r7:f09f9f08 r6:00000004 r5:c3502900 r4:c0283250
> [   14.588916]  kobj_attr_store from sysfs_kf_write+0x40/0x4c
> [   14.588936]  r5:c3502900 r4:c0d92a48
> [   14.588939]  sysfs_kf_write from kernfs_fop_write_iter+0x104/0x1f0
> [   14.588956]  r5:c3502900 r4:c3501f40
> [   14.588960]  kernfs_fop_write_iter from vfs_write+0x250/0x420
> [   14.588980]  r10:c0e14b48 r9:00000000 r8:c25f5780 r7:00443398 r6:f09f9f68 r5:c34f7f00
> [   14.588983]  r4:c042a88c
> [   14.588987]  vfs_write from ksys_write+0x74/0xe4
> [   14.589005]  r10:00000004 r9:c25f5780 r8:c02002fA0 r7:00000000 r6:00000000 r5:c34f7f00
> [   14.589008]  r4:c34f7f00
> [   14.589011]  ksys_write from sys_write+0x10/0x14
> [   14.589029]  r7:00000004 r6:004421c0 r5:00443398 r4:00000004
> [   14.589032]  sys_write from ret_fast_syscall+0x0/0x5c
> [   14.589044] Exception stack(0xf09f9fa8 to 0xf09f9ff0)
> [   14.589050] 9fa0:                   00000004 00443398 00000004 00443398 00000004 00000001
> [   14.589056] 9fc0: 00000004 00443398 004421c0 00000004 b6ecbd58 00000008 bebfbc38 0043eb78
> [   14.589062] 9fe0: 00440eb0 bebfbaf8 b6de18a0 b6e579e8
> [   14.589065] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to nand/next, thanks!

[1/1] mtd: rawnand: brcmnand: fix PM resume warning
      commit: 288573e43712b1e04562de1bb93be01d74aa5f48

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


