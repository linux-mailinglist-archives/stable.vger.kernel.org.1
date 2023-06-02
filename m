Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E637206C8
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjFBQFZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjFBQFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:05:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC81AB
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=av/0t46OGH+NdTV3TrODmwTTEmu+fUEvWWkukBB1K098Io1Q0Klk2cGZhG8iXjd2ixbs4XGCH0hRpTFwy1lHeTdm/b2CG1ngpPxKwY/C+sQvS6mm2DMf8GAYdqqRRWAWKb+BUMyhjv4Ka+F+KHZFaQxQtlF3CWw2gEr/2ND+Dp6nSB+OEQAkgsHOV8SgO6qufhEhmAvnSmpdOZ5ZdWn6QmRfp2Rg3QFAx6GqqATdr0aqZqUkmEisyZJoxQoBgWb4JGnSG7NSoY7HuMp7HIFHZqSGMgNjPC1c6vFNGDbnxn8CaoqsUTgpsdjZ5t1j4M6tA4n787NfBICes5YYx3tA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duHPBSHG6smb/XXl+fIOu/Kql/M5Z50yBPfr86Lyj4A=;
 b=ckiIT0/2ufWh+n2G8TVXpu5xu2KkjRRVTbxubGCkyhMDzUBkfLJzeAkC9PX23zpjjp3cpq/Xrb7bQk6i5FPnttWm/2bmI2HKoStNvzNq9DoqImzhLxVTAIxYOQJJvFicDb7KmhC5eOmdVdUjTOxkdDjLJqlkPqSJRC/mZVnx2LL6HVxDo777iP+QtEPNL+o/it/w0t5nP1nWwqc1Zo4D1vwbotB5JVjstG0CdiJOBXorD/hzKrlQPL8UI1LPlvdQQcPRthy4dVA5mSK9CrJNIW4iPV6zWjKdgXhw7MPpeqvbE/tOzIEEiUWzPqMh5pT4G5m5uc84407BZ/QZel/fPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duHPBSHG6smb/XXl+fIOu/Kql/M5Z50yBPfr86Lyj4A=;
 b=qvxhcpPhP/eZVw+t/0g0O+QeiWdYXvQST7f5O+5yz6shTjAlPTIQmNL1ip6A1PgHFH3BRUrvdusN88ndluyrzZUaRKOvD0uy93k6iCb56kUWKNZ22mRVvEzZKBS5qO4PJtNdIe5urHRL9NMl1aKuLrXaTcZUbebFw3dlGK+mGRz8+oZKo6NUbAXZ+QGG0gyIv003EG1RVEYJ6hBouro4u2LMRuAg60xkrb4ztUmTidPkjyaFus286XJlDgEX3zz73x78eisbS5iuLfCVtU2Igdg5USTqtjCTGqNXscCzqiTYOnVvVboexODO6Hyq0T3nzRWh9pz18zxv5u8I5T5V5A==
Received: from DB6PR0202CA0027.eurprd02.prod.outlook.com (2603:10a6:4:a5::13)
 by DB9PR10MB6316.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 16:05:18 +0000
Received: from DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::7d) by DB6PR0202CA0027.outlook.office365.com
 (2603:10a6:4:a5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Fri, 2 Jun 2023 16:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT082.mail.protection.outlook.com (10.152.5.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 16:05:18 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 2 Jun 2023 18:05:18 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.177) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 2 Jun 2023 18:05:17 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <holger.philipps@siemens.com>, <wagner.dominik@siemens.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        "Henning Schild" <henning.schild@siemens.com>
Subject: [PATCH 5.10 0/2] backport i915 fixes to 5.10
Date:   Fri, 2 Jun 2023 18:05:05 +0200
Message-ID: <20230602160507.2057-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.69.177]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT082:EE_|DB9PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f1e391-038f-4861-09a3-08db6383293f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Geu04BFZlInfaAcS7MecaOXAMKk4vyVkhFf/7LQPgK08up7BlJzf4aTJd8tMMFui0bU6buldJAWPx13wBNFj87rSfncBFp6vD1NmqgfLc/YErcmBq6DG5PA+jasRGbqXPng0Yh5sK/VLmNtu8CyjgdVBZzq5bmtI8VP2OMMc/hbp+8FQXzjUyEWo/H8NiEXLBW0A1Zwd2YZF+S8spBcVZi5XuJvcyTxwGcL7liEiXahF15+kHk6tAngYBy5T28pv5ingm0CLf0RP3nvqAoAlJ5M3nYcLoVBsB9G1+XEJms8hMkSRzXXQUdX0r/5cXWe+RvlRewZCrpBeF1F5gzYxSZUXKxcckTdQGpZtpJCgxY57lVaV4vNQBCkcty+5vN01RRgA4agGw4e/ve7ZavhH9bu4kUM071SLGBEaf5lMAWNpss3iE/HUhIBiDX0a+u9gU4ntqXjpHkTNretwin/QQPmL9dhtq+JEIQqqAVgCFwZhcCAQS7tGKndoUPXxGCwekFGrzSt98eYZd6Mqx491P7vvRQArJuc2wukyiTGkbl9+l/frFOetQGha2WWgds0ebOLUc8mEnVCnawi1JFWfPeE1UCmzP+rdLb3IvTfz9nPvfAHWUdJvLY+4cVBshtkAUNaB1WLoIb6d7Pd326di9zmDEXlhGIs/D/ujvikhB5aCLOq/1qvw1H0oGQUmA+HucCCNVF0Tmtc53SfLdVJvoNTOYIKTzDseboPj9yhDyrsirwhfbK0cB6AJyvlNZTT31I1eslnd7s4jhA4lqA+HZQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(6666004)(47076005)(45080400002)(107886003)(956004)(2616005)(1076003)(40480700001)(26005)(36860700001)(36756003)(16526019)(336012)(83380400001)(40460700003)(41300700001)(4326008)(81166007)(70206006)(316002)(82960400001)(70586007)(82740400003)(356005)(82310400005)(44832011)(186003)(86362001)(2906002)(5660300002)(8676002)(8936002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:05:18.6191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f1e391-038f-4861-09a3-08db6383293f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6316
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This fixes the following problem which was seen on a Tigerlake running
Debian 10 with a 5.10 kernel.

[  111.408631] Missing case (val == 65535)
[  111.408698] WARNING: CPU: 2 PID: 446 at drivers/gpu/drm/i915/intel_dram.c:95 skl_dram_get_dimm_info+0x72/0x1a0 [i915]
[  111.408699] Modules linked in: intel_powerclamp coretemp i915(+) joydev kvm_intel kvm hid_generic irqbypass crc32_pclmul snd_hda_intel ghash_clmulni_intel snd_intel_dspcfg snd_hda_codec aesni_intel glue_helper crypto_simd cryptd snd_hwdep snd_hda_core drm_kms_helper uas snd_pcm usb_storage intel_cstate mei_wdt mei_hdcp snd_timer scsi_mod usbhid hid cec wdat_wdt snd mei_me evdev mei intel_uncore rc_core watchdog pcspkr soundcore video acpi_pad acpi_tad button drm fuse configfs loop(+) efi_pstore efivarfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 dm_mod xhci_pci xhci_hcd marvell dwmac_intel stmmac igb e1000e usbcore nvme nvme_core pcs_xpcs phylink libphy i2c_algo_bit t10_pi dca crc_t10dif crct10dif_generic intel_lpss_pci ptp vmd intel_lpss i2c_i801 crct10dif_pclmul pps_core crct10dif_common idma64 usb_common crc32c_intel i2c_smbus
[  111.408755] CPU: 2 PID: 446 Comm: (udev-worker) Not tainted 5.10.180 #2
[  111.408756] Hardware name: SIEMENS AG SIMATIC IPC427G/no information, BIOS T29.01.02.D3.0 10/11/2022
[  111.408797] RIP: 0010:skl_dram_get_dimm_info+0x72/0x1a0 [i915]
[  111.408799] Code: 01 00 00 0f 84 31 01 00 00 66 3d 00 01 0f 84 27 01 00 00 41 0f b7 d0 48 c7 c6 ba 81 7c c1 48 c7 c7 be 81 7c c1 e8 d2 75 89 fa <0f> 0b c6 45 01 00 44 0f b6 4d 00 31 f6 b9 01 00 00 00 c1 fb 09 83
[  111.408801] RSP: 0018:ffffa23a40b53b10 EFLAGS: 00010286
[  111.408802] RAX: 0000000000000000 RBX: 000000000000ffff RCX: 0000000000000027
[  111.408803] RDX: ffff947b278a0908 RSI: 0000000000000001 RDI: ffff947b278a0900
[  111.408804] RBP: ffffa23a40b53b78 R08: 0000000000000000 R09: ffffa23a40b53920
[  111.408805] R10: ffffa23a40b53918 R11: 0000000000000003 R12: 0000000000000000
[  111.408806] R13: 000000000000004c R14: ffff9479b1a00000 R15: ffff9479b1a00000
[  111.408808] FS:  00007ff9626478c0(0000) GS:ffff947b27880000(0000) knlGS:0000000000000000
[  111.408809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.408810] CR2: 0000555753cbf15c CR3: 0000000108432002 CR4: 0000000000770ee0
[  111.408810] PKRU: 55555554
[  111.408811] Call Trace:
[  111.408854]  skl_dram_get_channel_info+0x24/0x160 [i915]
[  111.408892]  intel_dram_detect+0xef/0x630 [i915]
[  111.408931]  i915_driver_probe+0xb18/0xc40 [i915]
[  111.408969]  ? i915_pci_probe+0x3f/0x160 [i915]
[  111.408973]  local_pci_probe+0x3b/0x80
[  111.408975]  pci_device_probe+0xfc/0x1b0
[  111.408979]  really_probe+0x26e/0x460
[  111.408981]  driver_probe_device+0xb4/0x100
[  111.408983]  device_driver_attach+0xa9/0xb0
[  111.408984]  ? device_driver_attach+0xb0/0xb0
[  111.408985]  __driver_attach+0xa1/0x140
[  111.408987]  ? device_driver_attach+0xb0/0xb0
[  111.408989]  bus_for_each_dev+0x84/0xd0
[  111.408991]  bus_add_driver+0x13e/0x200
[  111.408993]  driver_register+0x89/0xe0
[  111.409036]  i915_init+0x60/0x75 [i915]
[  111.409038]  ? 0xffffffffc18b8000
[  111.409041]  do_one_initcall+0x56/0x1f0
[  111.409044]  do_init_module+0x4a/0x240
[  111.409047]  __do_sys_finit_module+0xaa/0x110
[  111.409050]  do_syscall_64+0x30/0x40
[  111.409053]  entry_SYSCALL_64_after_hwframe+0x61/0xc6
[  111.409054] RIP: 0033:0x7ff962d534f9
[  111.409056] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 08 0d 00 f7 d8 64 89 01 48
[  111.409057] RSP: 002b:00007fff57caf5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  111.409058] RAX: ffffffffffffffda RBX: 0000555753cad120 RCX: 00007ff962d534f9
[  111.409059] RDX: 0000000000000000 RSI: 00007ff962ee6efd RDI: 0000000000000010
[  111.409060] RBP: 00007ff962ee6efd R08: 0000000000000000 R09: 0000555753c7a320
[  111.409061] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000020000
[  111.409062] R13: 0000000000000000 R14: 0000555753ca4f30 R15: 0000555752d40e4f
[  111.409064] ---[ end trace 2da6ec0bd6f7c3a1 ]---


José Roberto de Souza (1):
  drm/i915/gen11+: Only load DRAM information from pcode

Matt Roper (1):
  drm/i915/dg1: Wait for pcode/uncore handshake at startup

 drivers/gpu/drm/i915/display/intel_bw.c | 80 +++---------------------
 drivers/gpu/drm/i915/i915_drv.c         |  4 ++
 drivers/gpu/drm/i915/i915_drv.h         |  1 +
 drivers/gpu/drm/i915/i915_reg.h         |  3 +
 drivers/gpu/drm/i915/intel_dram.c       | 82 ++++++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_sideband.c   | 15 +++++
 drivers/gpu/drm/i915/intel_sideband.h   |  2 +
 7 files changed, 114 insertions(+), 73 deletions(-)

-- 
2.39.3

