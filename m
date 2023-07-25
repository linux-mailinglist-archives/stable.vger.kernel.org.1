Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1978B7615DF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjGYLdy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjGYLdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C019C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCAF061683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2EFC433C8;
        Tue, 25 Jul 2023 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284830;
        bh=9q0VftGjlhhgwKZQBzEjweR5vkmbEiXhcGML+zUgMxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abW8h+RrCDAaPkW+cvdyRNrKGXWxUigsvpa8fuWUQh7VS+q0MDPUos2y1ELb9XvB6
         L5a0XRhyolQSHb4yIWZDZtDtXi04SRnxpvy3eoNagXZZR7JSnlwi01sdtyKoOKF78h
         DsKAc7St0I8sh6p+fKxWYjeMxO15Z1MNUSkNfke8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Oros <poros@redhat.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 469/509] devlink: report devlink_port_type_warn source device
Date:   Tue, 25 Jul 2023 12:46:48 +0200
Message-ID: <20230725104615.227109527@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Petr Oros <poros@redhat.com>

[ Upstream commit a52305a81d6bb74b90b400dfa56455d37872fe4b ]

devlink_port_type_warn is scheduled for port devlink and warning
when the port type is not set. But from this warning it is not easy
found out which device (driver) has no devlink port set.

[ 3709.975552] Type was not set for devlink port.
[ 3709.975579] WARNING: CPU: 1 PID: 13092 at net/devlink/leftover.c:6775 devlink_port_type_warn+0x11/0x20
[ 3709.993967] Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nfnetlink bluetooth rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs vhost_net vhost vhost_iotlb tap tun bridge stp llc qrtr intel_rapl_msr intel_rapl_common i10nm_edac nfit libnvdimm x86_pkg_temp_thermal mlx5_ib intel_powerclamp coretemp dell_wmi ledtrig_audio sparse_keymap ipmi_ssif kvm_intel ib_uverbs rfkill ib_core video kvm iTCO_wdt acpi_ipmi intel_vsec irqbypass ipmi_si iTCO_vendor_support dcdbas ipmi_devintf mei_me ipmi_msghandler rapl mei intel_cstate isst_if_mmio isst_if_mbox_pci dell_smbios intel_uncore isst_if_common i2c_i801 dell_wmi_descriptor wmi_bmof i2c_smbus intel_pch_thermal pcspkr acpi_power_meter xfs libcrc32c sd_mod sg nvme_tcp mgag200 i2c_algo_bit nvme_fabrics drm_shmem_helper drm_kms_helper nvme syscopyarea ahci sysfillrect sysimgblt nvme_core fb_sys_fops crct10dif_pclmul libahci mlx5_core sfc crc32_pclmul nvme_common drm
[ 3709.994030]  crc32c_intel mtd t10_pi mlxfw libata tg3 mdio megaraid_sas psample ghash_clmulni_intel pci_hyperv_intf wmi dm_multipath sunrpc dm_mirror dm_region_hash dm_log dm_mod be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse
[ 3710.108431] CPU: 1 PID: 13092 Comm: kworker/1:1 Kdump: loaded Not tainted 5.14.0-319.el9.x86_64 #1
[ 3710.108435] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 09/14/2022
[ 3710.108437] Workqueue: events devlink_port_type_warn
[ 3710.108440] RIP: 0010:devlink_port_type_warn+0x11/0x20
[ 3710.108443] Code: 84 76 fe ff ff 48 c7 03 20 0e 1a ad 31 c0 e9 96 fd ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 48 c7 c7 18 24 4e ad e8 ef 71 62 ff <0f> 0b c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f6 87
[ 3710.108445] RSP: 0018:ff3b6d2e8b3c7e90 EFLAGS: 00010282
[ 3710.108447] RAX: 0000000000000000 RBX: ff366d6580127080 RCX: 0000000000000027
[ 3710.108448] RDX: 0000000000000027 RSI: 00000000ffff86de RDI: ff366d753f41f8c8
[ 3710.108449] RBP: ff366d658ff5a0c0 R08: ff366d753f41f8c0 R09: ff3b6d2e8b3c7e18
[ 3710.108450] R10: 0000000000000001 R11: 0000000000000023 R12: ff366d753f430600
[ 3710.108451] R13: ff366d753f436900 R14: 0000000000000000 R15: ff366d753f436905
[ 3710.108452] FS:  0000000000000000(0000) GS:ff366d753f400000(0000) knlGS:0000000000000000
[ 3710.108453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3710.108454] CR2: 00007f1c57bc74e0 CR3: 000000111d26a001 CR4: 0000000000773ee0
[ 3710.108456] PKRU: 55555554
[ 3710.108457] Call Trace:
[ 3710.108458]  <TASK>
[ 3710.108459]  process_one_work+0x1e2/0x3b0
[ 3710.108466]  ? rescuer_thread+0x390/0x390
[ 3710.108468]  worker_thread+0x50/0x3a0
[ 3710.108471]  ? rescuer_thread+0x390/0x390
[ 3710.108473]  kthread+0xdd/0x100
[ 3710.108477]  ? kthread_complete_and_exit+0x20/0x20
[ 3710.108479]  ret_from_fork+0x1f/0x30
[ 3710.108485]  </TASK>
[ 3710.108486] ---[ end trace 1b4b23cd0c65d6a0 ]---

After patch:
[  402.473064] ice 0000:41:00.0: Type was not set for devlink port.
[  402.473064] ice 0000:41:00.1: Type was not set for devlink port.

Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20230615095447.8259-1-poros@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 72047750dcd96..00c6944ed6342 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -8092,7 +8092,10 @@ EXPORT_SYMBOL_GPL(devlink_free);
 
 static void devlink_port_type_warn(struct work_struct *work)
 {
-	WARN(true, "Type was not set for devlink port.");
+	struct devlink_port *port = container_of(to_delayed_work(work),
+						 struct devlink_port,
+						 type_warn_dw);
+	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
-- 
2.39.2



