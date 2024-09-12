Return-Path: <stable+bounces-75970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2219764D0
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 10:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B59E1F2473C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 08:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8118FDBA;
	Thu, 12 Sep 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="w98Z+nwF"
X-Original-To: stable@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686218F2D3
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130928; cv=none; b=FWnmLX62NuBO0R1fYuR//1pp8hg+d9ATV6DDTJ1cahJdZnMV/TFbTFWvF/1r7AuJYzL4MB26+2aXh/kBiOWofdzjelkD3B6g2EuLuXP3zKLekcowttL26LnnRU47QhNzooKKMGWwYlxg+42XJsP9HdehnumEGv9OLnTxR6jQQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130928; c=relaxed/simple;
	bh=Tv550bqlYYEJ32QbYeZtBsvhoIAVvpCVt4GXkH8VLYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDIwg1CDA9wPMyzzPfVHvq7yfFcoQ51uaDTJZcHuuE/BxbrZpKGMvpHJtI2frlEXjwaqQgHeZZOfQ6ezp3yFWL3VBa8MAyFQ8z98m8+2LwQAC8nFDX54OqJA/XLWSXOphq995Je6897wSZtJ+cOAPQPkWq5R5pge/jAa5sRdXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=w98Z+nwF; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kVwunK5Vt/i6pCyKJjuHs6L8xfgvF0uvIaxBmJz7VVs=; b=w98Z+nwFkTuXTjoLtGS5nBeBd8
	7yOKXOL7t+RU6PL6vh4yjr9kvmFBWxjozHb4Cbe6/RG2zNAibRoJQFrL1W78fJYM1adzMkMlfRTPR
	/EyqgRi3yiPrR4PDnmb6EM4lzXa8BtD8kOgvUtS5Qc2D2OXbwPkXq54WOIuhVscXiQ88=;
Received: from localhost.syndicat.com ([127.0.0.1]:51099 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1sofUt-0000yL-1E;
	Thu, 12 Sep 2024 10:48:15 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZlMCL-BDRvV0; Thu, 12 Sep 2024 10:48:15 +0200 (CEST)
Received: from p579493d3.dip0.t-ipconnect.de ([87.148.147.211]:56124 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1sofUs-00030j-2w;
	Thu, 12 Sep 2024 10:48:14 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] x86: SMP broken on Xen PV DomU since 6.9
Date: Thu, 12 Sep 2024 10:48:14 +0200
Message-ID: <5998315.MhkbZ0Pkbq@gongov>
Organization: Syndicat IT&Internet
Disposition-Notification-To: Niels Dettenbach <nd@syndicat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Sender Address Domain - syndicat.com

Virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a 
special, nonstandard synthetized CPU topology which "just works" under 
kernels 6.9.x while newer kernels wrongly assuming a "crash kernel" and 
disable SMP (reducing to one CPU core) because the newer topology 
implementation produces a wrong error "[Firmware Bug]: APIC enumeration 
order not specification compliant" after new topology checks which are 
improper for Xen PV platform. As a result, the kernel disables SMT and 
activates just one CPU core within the VM (DomU).

The patch disables the regarding checks if it is running in Xen PV 
mode (only) and bring back SMP / all CPUs as in the past to such DomU 
VMs.

Signed-off-by: Niels Dettenbach <nd@syndicat.com>

---


The current behaviour leads all of our production Xen Host platforms 
(amd64 - HPE proliant) unusable after updating to newer linux kernels 
(with just one CPU available/activated per VM) while older kernels and
other OS (current NetBSD PV DomU) still work fully (and stable since many 
years on the platform). 

Xen PV mode is still provided by current Xen and widely used - even 
if less wide as the newer Xen PVH mode today. So a solution probably 
will be required.

So we assume that bug affects stable@vger.kernel.org as well.


dmesg from affected kernel:

-- snip --
[    0.640364] CPU topo: Enumerated BSP APIC 0 is not marked in APICBASE MSR
[    0.640367] CPU topo: Assuming crash kernel. Limiting to one CPU to prevent machine INIT
[    0.640368] CPU topo: [Firmware Bug]: APIC enumeration order not specification compliant
[    0.640376] CPU topo: Max. logical packages:   1
[    0.640378] CPU topo: Max. logical dies:       1
[    0.640379] CPU topo: Max. dies per package:   1
[    0.640386] CPU topo: Max. threads per core:   1
[    0.640388] CPU topo: Num. cores per package:     1
[    0.640389] CPU topo: Num. threads per package:   1
[    0.640390] CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
[    0.640402] Cannot find an available gap in the 32-bit address range
-- snap --


after patch applied:
-- snip --
[    0.369439] CPU topo: Max. logical packages:   1
[    0.369441] CPU topo: Max. logical dies:       1
[    0.369442] CPU topo: Max. dies per package:   1
[    0.369450] CPU topo: Max. threads per core:   2
[    0.369452] CPU topo: Num. cores per package:     3
[    0.369453] CPU topo: Num. threads per package:   6
[    0.369453] CPU topo: Allowing 6 present CPUs plus 0 hotplug CPUs
-- snap --


We tested the patch intensely under productive / high load since 2 days now with no issues.


references:
arch/x86/kernel/cpu/topology.c
[line 448]
-- snip --
        /*
         * XEN PV is special as it does not advertise the local APIC
         * properly, but provides a fake topology for it so that the
         * infrastructure works. So don't apply the restrictions vs. APIC
         * here.
         */
--snap --




--- linux/arch/x86/kernel/cpu/topology.c        2024-09-11 17:42:42.699278317 +0200
+++ linux/arch/x86/kernel/cpu/topology.c.orig   2024-09-11 09:53:16.194095250 +0200
@@ -132,14 +132,6 @@
        u64 msr;

        /*
-        * assume Xen PV has a working (special) topology
-        */
-       if (xen_pv_domain()) {
-               topo_info.real_bsp_apic_id = topo_info.boot_cpu_apic_id;
-               return false;
-       }
-
-       /*
         * There is no real good way to detect whether this a kdump()
         * kernel, but except on the Voyager SMP monstrosity which is not
         * longer supported, the real BSP APIC ID is the first one which is

 








