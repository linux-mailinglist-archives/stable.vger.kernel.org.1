Return-Path: <stable+bounces-116701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC2A399C6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A915B188BF76
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDF23BF80;
	Tue, 18 Feb 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PjE5ugKE"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1E1A8413;
	Tue, 18 Feb 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876426; cv=none; b=pKHx5kSuow6BzXDpVnRf/8CanzyIO31CjMKZXPAixeIJruXXAkvgqVquigMxvX16orHr1kN3fLoxDassiWdKTc5RadBI0su2Itwrc6bS/t/Jy4cCd/izxvGETuBHCSmxPnBm7Yzp55rvesT0HTlcdjZjMF+uRf1AMmnM161Pz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876426; c=relaxed/simple;
	bh=mwAvFgfM059obgvyujGkz/CD8+qzGmT95qVrT+A0kJs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XMorebdMS90vvEhd/O3W99Q/dxb1+17a1dpCEGdQ0mjjhSyQd8iqUzErUJVt6sWrX4Q/0EPl/XxJWbTycJklYacXI0gMCb2mtyePb4arbcDsItyYWwn0mYxEXBl0ub+rZhAKnu8RrW5es40HvlGVfKL8QqlE873rHSxmgeyQHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PjE5ugKE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A850442BD;
	Tue, 18 Feb 2025 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739876416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tb2ydThktZ74L8NUf/2CNU7XkUMfYk3Aa0EcOihVnnc=;
	b=PjE5ugKECQRb/m56G5pfVRRWl3J3FNLU/Pps2mxZ4e7bdU7rIAvlWJIwEWhBuOSugX1kS2
	Zq2MIuKZQ92/Zbek19ZwgLnkxqafJ9oHF87HqIKhu7Un5S/7T8/V7iu6QwB/Ih8LWtngf6
	CtsaLo47bGU1qI9viieNSxsJxdoBc+zl/G0Stmruwpd44wHSz6I+Z7TuYS9kDEZ2XYdf5J
	H7PvBqpPXus8HaLq6iJtMtCkP6VfD7X0w+9YWXvz68UYADyxzXvUs/V0GrT2qEdGBhk7sA
	FhhkCinq6dZpfpyQDVjM+DKfmisWOMy1TMPsopKpED79YyV4TQkI/R53d9hrbA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH 0/2] driver core: platform: avoid use-after-free on device
 name
Date: Tue, 18 Feb 2025 12:00:11 +0100
Message-Id: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADtotGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nz3YKU1DLd0sQ0XcNEc3PLREuLFAvDJCWg8oKi1LTMCrBR0bG1tQC
 NeVcHWgAAAA==
X-Change-ID: 20250217-pdev-uaf-1a779a98d81b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Binbin Zhou <zhoubinbin@loongson.cn>, linux-sound@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefvhhorohcunfgvsghruhhnuceothhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieehhfdtvedtjeetudeluddugfetlefhgfeukeehffejlefhjeejvdfhvdelhfefnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugdphhgvlhhopegludelvddrudeikedruddtrdeliegnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsohhunhgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeiihhhouhgsihhnsghinheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhm
X-GND-Sasl: theo.lebrun@bootlin.com

The use-after-free bug appears when:
 - A platform device is created from OF, by of_device_add();
 - The same device's name is changed afterwards using dev_set_name(),
   by its probe for example.

Out of the 37 drivers that deal with platform devices and do a
dev_set_name() call, only one might be affected. That driver is
loongson-i2s-plat [0]. All other dev_set_name() calls are on children
devices created on the spot. The issue was found on downstream kernels
and we don't have what it takes to test loongson-i2s-plat.

Note: loongson-i2s-plat maintainers are CCed.

   ⟩ # Finding potential trouble-makers:
   ⟩ git grep -l 'struct platform_device' | xargs grep -l dev_set_name

The solution proposed is to add a flag to platform_device that tells if
it is responsible for freeing its name. We can then duplicate the
device name inside of_device_add() instead of copying the pointer.

What is done elsewhere?
 - Platform bus code does a copy of the argument name that is stored
   alongside the struct platform_device; see platform_device_alloc()[1].
 - Other busses duplicate the device name; either through a dynamic
   allocation [2] or through an array embedded inside devices [3].
 - Some busses don't have a separate name; when they want a name they
   take it from the device [4].

[0]: https://elixir.bootlin.com/linux/v6.13.2/source/sound/soc/loongson/loongson_i2s_plat.c#L155
[1]: https://elixir.bootlin.com/linux/v6.13.2/source/drivers/base/platform.c#L581
[2]: https://elixir.bootlin.com/linux/v6.13.2/source/drivers/gpu/drm/drm_drv.c#L679
[3]: https://elixir.bootlin.com/linux/v6.13.2/source/include/linux/i2c.h#L343
[4]: https://elixir.bootlin.com/linux/v6.13.2/source/include/linux/pci.h#L2150

This can be reproduced using Buildroot's qemu_aarch64_virt_defconfig
with CONFIG_KASAN=y and a dev_set_name() inside the probe of:
drivers/pci/controller/pci-host-common.c

The below splat appears at boot. It happens whenever something tries to
access pdev->name; one big consumer of this field is platform_match()
that fallbacks to name matching.

   ==================================================================
   BUG: KASAN: slab-use-after-free in strcmp+0x2c/0x78
   Read of size 1 at addr ffffff80c0300160 by task swapper/0/1

   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.32 #1
   Hardware name: linux,dummy-virt (DT)
   Call trace:
    dump_backtrace+0x90/0xe8
    show_stack+0x18/0x24
    dump_stack_lvl+0x48/0x60
    print_report+0xf8/0x5d8
    kasan_report+0x90/0xcc
    __asan_load1+0x60/0x6c
    strcmp+0x2c/0x78
    platform_match+0xd0/0x140
    __driver_attach+0x44/0x240
    bus_for_each_dev+0xe4/0x160
    driver_attach+0x34/0x44
    bus_add_driver+0x134/0x270
    driver_register+0xa4/0x1e4
    __platform_driver_register+0x44/0x54
    ged_driver_init+0x1c/0x28
    do_one_initcall+0xdc/0x260
    kernel_init_freeable+0x314/0x448
    kernel_init+0x2c/0x1e0
    ret_from_fork+0x10/0x20

   Allocated by task 1:
    kasan_save_stack+0x3c/0x64
    kasan_set_track+0x2c/0x40
    kasan_save_alloc_info+0x24/0x34
    __kasan_kmalloc+0xb8/0xbc
    __kmalloc_node_track_caller+0x64/0xa4
    kvasprintf+0xcc/0x16c
    kvasprintf_const+0xe8/0x180
    kobject_set_name_vargs+0x54/0xd4
    dev_set_name+0xa8/0xe4
    of_device_make_bus_id+0x298/0x2b0
    of_device_alloc+0x1ec/0x204
    of_platform_device_create_pdata+0x60/0x168
    of_platform_bus_create+0x20c/0x4a0
    of_platform_populate+0x50/0x10c
    of_platform_default_populate_init+0xe0/0x100
    do_one_initcall+0xdc/0x260
    kernel_init_freeable+0x314/0x448
    kernel_init+0x2c/0x1e0
    ret_from_fork+0x10/0x20

   Freed by task 1:
    kasan_save_stack+0x3c/0x64
    kasan_set_track+0x2c/0x40
    kasan_save_free_info+0x38/0x60
    __kasan_slab_free+0xe4/0x150
    __kmem_cache_free+0x134/0x26c
    kfree+0x54/0x6c
    kfree_const+0x34/0x40
    kobject_set_name_vargs+0xa8/0xd4
    dev_set_name+0xa8/0xe4
    pci_host_common_probe+0x9c/0x294
    platform_probe+0x90/0x100
    really_probe+0x100/0x3cc
    __driver_probe_device+0xb8/0x18c
    driver_probe_device+0x108/0x1d8
    __driver_attach+0xc8/0x240
    bus_for_each_dev+0xe4/0x160
    driver_attach+0x34/0x44
    bus_add_driver+0x134/0x270
    driver_register+0xa4/0x1e4
    __platform_driver_register+0x44/0x54
    gen_pci_driver_init+0x1c/0x28
    do_one_initcall+0xdc/0x260
    kernel_init_freeable+0x314/0x448
    kernel_init+0x2c/0x1e0
    ret_from_fork+0x10/0x20

   The buggy address belongs to the object at ffffff80c0300160
    which belongs to the cache kmalloc-16 of size 16
   The buggy address is located 0 bytes inside of
    freed 16-byte region [ffffff80c0300160, ffffff80c0300170)

   The buggy address belongs to the physical page:
   page:0000000099fe29a0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100300
   flags: 0x8000000000000800(slab|zone=2)
   page_type: 0xffffffff()
   raw: 8000000000000800 ffffff80c00013c0 dead000000000122 0000000000000000
   raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
   page dumped because: kasan: bad access detected

   Memory state around the buggy address:
    ffffff80c0300000: fa fb fc fc fa fb fc fc 00 07 fc fc 00 07 fc fc
    ffffff80c0300080: 00 07 fc fc 00 02 fc fc 00 02 fc fc 00 02 fc fc
   >ffffff80c0300100: 00 06 fc fc 00 06 fc fc 00 06 fc fc fa fb fc fc
                                                          ^
    ffffff80c0300180: 00 00 fc fc 00 00 fc fc 00 06 fc fc 00 06 fc fc
    ffffff80c0300200: 00 06 fc fc 00 06 fc fc 00 06 fc fc 00 06 fc fc
   ==================================================================

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (2):
      driver core: platform: turn pdev->id_auto into pdev->flags
      driver core: platform: avoid use-after-free on pdev->name

 drivers/base/platform.c         |  8 +++++---
 drivers/of/platform.c           | 12 +++++++++++-
 include/linux/platform_device.h |  4 +++-
 3 files changed, 19 insertions(+), 5 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-pdev-uaf-1a779a98d81b

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


