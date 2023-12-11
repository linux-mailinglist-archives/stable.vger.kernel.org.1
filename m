Return-Path: <stable+bounces-5343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C880CA49
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C82812FA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59D3C064;
	Mon, 11 Dec 2023 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WLNlauNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F3BB2B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511B9C433C7;
	Mon, 11 Dec 2023 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299141;
	bh=CiL2lLjTKYEod8VRdcd/uzKDUNXIKczmPi8h10DASgg=;
	h=Subject:To:Cc:From:Date:From;
	b=WLNlauNMNd6Lucyt42hxXCUp9KE2+/U79CybYHc51UfOkgeA3eZp+Bdt98hAwomgL
	 gW75qxmx6DVnWQN/IIPUZtT41qxjDE29V2sEtU8/B457ob+5CCfsVTzKuScx8/EuGs
	 RrtXMA1RU4fw2GvL4dCegngv5DSZY3GOrxtzc1p4=
Subject: FAILED: patch "[PATCH] MIPS: Loongson64: Reserve vgabios memory on boot" failed to apply to 5.4-stable tree
To: jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:52:19 +0100
Message-ID: <2023121118-elitism-slimness-966d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8f7aa77a463f47c9e00592d02747a9fcf2271543
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121118-elitism-slimness-966d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8f7aa77a463f ("MIPS: Loongson64: Reserve vgabios memory on boot")
cf8194e46c1e ("MIPS: Loongson64: Give chance to build under !CONFIG_NUMA and !CONFIG_SMP")
73826d604bbf ("MIPS: Loongson64: Clean up numa.c")
1062fc45d1e9 ("MIPS: Loongson64: Select SMP in Kconfig to avoid build error")
70b838292bef ("MIPS: Update default config file for Loongson-3")
39c1485c8baa ("MIPS: KVM: Add kvm guest support for Loongson-3")
24af105962c8 ("MIPS: Loongson64: DeviceTree for LS7A PCH")
f8523d0e8361 ("MIPS: Loongson: Rename CPU device-tree binding")
143463fd33fe ("MIPS: Loongson: Enable devicetree based probing for 8250 ports in defconfig")
a44de7497f91 ("MIPS: Loongson: Build ATI Radeon GPU driver as module")
68fbb9721ea7 ("MIPS: Loongson: Add DMA support for LS7A")
2c3cc858a687 ("MIPS: Loongson64: Switch the order of RS780E and LS7A")
8c88cc53ffa6 ("MIPS: Loongson: Get host bridge information")
fcecdcd388ea ("MIPS: Loongson64: Load built-in dtbs")
87fcfa7b7fe6 ("MIPS: Loongson64: Add generic dts")
bfe9a2999629 ("dt-bindings: mips: Add loongson boards")
1e07c876ab75 ("MIPS: Loongson: Do not initialise statics to 0")
75cac781dca4 ("MIPS: Loongson{2ef, 32, 64} convert to generic fw cmdline")
6fbde6b492df ("MIPS: Loongson64: Move files to the top-level directory")
1bdb7b76705a ("MIPS: Loongson64: Cleanup unused code")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f7aa77a463f47c9e00592d02747a9fcf2271543 Mon Sep 17 00:00:00 2001
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 7 Nov 2023 11:15:18 +0000
Subject: [PATCH] MIPS: Loongson64: Reserve vgabios memory on boot

vgabios is passed from firmware to kernel on Loongson64 systems.
Sane firmware will keep this pointer in reserved memory space
passed from the firmware but insane firmware keeps it in low
memory before kernel entry that is not reserved.

Previously kernel won't try to allocate memory from low memory
before kernel entry on boot, but after converting to memblock
it will do that.

Fix by resversing those memory on early boot.

Cc: stable@vger.kernel.org
Fixes: a94e4f24ec83 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index ee8de1735b7c..d62262f93069 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -88,6 +88,11 @@ void __init szmem(unsigned int node)
 			break;
 		}
 	}
+
+	/* Reserve vgabios if it comes from firmware */
+	if (loongson_sysconf.vgabios_addr)
+		memblock_reserve(virt_to_phys((void *)loongson_sysconf.vgabios_addr),
+				SZ_256K);
 }
 
 #ifndef CONFIG_NUMA


