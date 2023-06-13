Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F572E703
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbjFMPWl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbjFMPWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFB19B9
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+s3qwKjciyL85S8ECngfFYMHVRUZaSXd+j1KrAYNrum3+cBQCIEDaYH6roERBhUzXrXR0P1wDDez2n9TxOCFIWJBDkxBEQsu1yvJeII9zrxuCM+19Tr+IObkD1UmfSyrH5dVQZl4axIeuJnna7zLBEwdIeu08IM3Eda5Q0FcAPtAzwBbiKL/qtA3HViNNpTzYWg8QJ6FUTcGyRycV/zyqBk/UFb8ZkToMLe33sjzKriZyDdVaTtl94G/UqRziB3mgT7oWNIK+N0DG93hnTSZSzzyaCLu9yKBG3LsnPd03/I0Cc21rAfDj56QMEisnudxG/YRt89R7yK0RTZB2LTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBFjVCUDdFLZFX4xjpuugMBgpRU25tjamZTV1VmwtjQ=;
 b=MslP8iEm0W7DiKnkFMx7wd0uSKf485x9Sx4nwFY2oBRY6PDDqngYtJHI3fwpNl+x8QplZG6N+U66cELZRhTmvb21BjtVdVNsw1VnOSghjG572cAQf+suQXnsayRok9/C5XgV2Du+WrAb78m56jX0xRFPk4UlyVkIsI2gRVGTSemeQlSdmnkjZfu4X/QOCbsmo6mlFN53HDXJndRej+hvwxMElbVmbMZ1YGvYfPVXikmaAVIJW6rSt0qBSIyki/ePcbozrrxXIpzpfIrsXjuwv3jBJbXhnvYlOhsg4IUvYYUcIX5WC/t6T1m/BdEn7DDoayDEkOMwM6LfHMx5wk43Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBFjVCUDdFLZFX4xjpuugMBgpRU25tjamZTV1VmwtjQ=;
 b=Qf0/0RrMJg8NRtvhozSKOpOoCfiQOSDk7BIh1OCUIZrqKP5/4VQIhq2hLyfkEWTNkAmu8ww9ZH/mZaR4BHjHevVyLFTE5cXjSO9TnJprJHTOVfuFu+cMepa9JiNnB0rOR2qhL3rb/srGYnBCqrmW1VJF9YMxZdDY9dvc/rJSyXI=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 15:22:29 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::23) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:22:23 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: add RAS POISON interrupt funcs for vcn_v4_0
Date:   Tue, 13 Jun 2023 11:21:56 -0400
Message-ID: <20230613152200.2020919-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613152200.2020919-1-alexander.deucher@amd.com>
References: <20230613152200.2020919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb36fee-336e-45ea-a75f-08db6c21ffe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWt2HgYukUWYhtf2WlkPPqQg1jVfGvX0TTkOE0cirWdFN5z4e9+CWxUYj85VqPbVJK9o28jNWmzrtRC98A7vZ8TksW0QjCfnF8NrqEt4noi92DBraMqyHiCglhDlBB9/JeEHL2IcTJVsZgQwSQ7KrIsu0X8qsMksrlCadKlNZqQT0OhpcEBcy5R9DFvvzWMNqMDWGLf0vvq0MSrtsutrBKgzy30oPuw/LqoYsLaBxXhQ/z28S2/6IbU9OPDoh+vuyoJVM6DY9JYU5lrPgKFb27Wocspw2bPH6sWJq3e//Ti9BEddQ4+jIrizs9uKWy+4/3g11HrwrsME5Lgufp3KEeKT4/eqH8NTZ9EzGhbCbC6mp/Qx44sSOazKm7bPjHBG1cwyKVLIrsyNxh6/IqNEORKjQS4KuAZwVeFK5aqcYFFO33a4VHahyWjOW9yFeRm4PTqqzxDTJJEeOtOaZT/c4jHTcr6IqeNldQ7NIsaCh10YKpxSmN6u/Far7Lyub+EAyVr2ucwVz2MoEzZq2kfw5YudqaIj6+aRMoXO/WU1ryWRiFqXLXo+h/nUkJPaZ8Pxrla4XEi3zR0ESEbSXJQDcYNd6C1lKNP8Gxt9l18S/73WaLAYxpJaVPKJ6cl6BY7t+UcWGk20difEUG9KmZbw43oIwqX4wrRw5x19rPXdEpOpZR341UiifqsmF2dCgaSpiFlYSkMVPDj0jzVLVNLZD3uUT+dOmAw8Mz67et/sYDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8936002)(8676002)(5660300002)(6916009)(4326008)(70586007)(70206006)(316002)(54906003)(2906002)(41300700001)(36860700001)(40460700003)(966005)(6666004)(478600001)(7696005)(81166007)(40480700001)(356005)(1076003)(426003)(16526019)(36756003)(336012)(83380400001)(186003)(47076005)(2616005)(26005)(82740400003)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:28.5287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb36fee-336e-45ea-a75f-08db6c21ffe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Horatio Zhang <Hongkun.Zhang@amd.com>

Add ras_poison_irq and functions. And fix the amdgpu_irq_put
call trace in vcn_v4_0_hw_fini.

[   44.563572] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   44.563629] RSP: 0018:ffffb36740edfc90 EFLAGS: 00010246
[   44.563630] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   44.563630] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   44.563631] RBP: ffffb36740edfcb0 R08: 0000000000000000 R09: 0000000000000000
[   44.563631] R10: 0000000000000000 R11: 0000000000000000 R12: ffff954c568e2ea8
[   44.563631] R13: 0000000000000000 R14: ffff954c568c0000 R15: ffff954c568e2ea8
[   44.563632] FS:  0000000000000000(0000) GS:ffff954f584c0000(0000) knlGS:0000000000000000
[   44.563632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.563633] CR2: 00007f028741ba70 CR3: 000000026ca10000 CR4: 0000000000750ee0
[   44.563633] PKRU: 55555554
[   44.563633] Call Trace:
[   44.563634]  <TASK>
[   44.563634]  vcn_v4_0_hw_fini+0x62/0x160 [amdgpu]
[   44.563700]  vcn_v4_0_suspend+0x13/0x30 [amdgpu]
[   44.563755]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   44.563806]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   44.563858]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   44.563909]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   44.564006]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   44.564061]  process_one_work+0x21f/0x400
[   44.564062]  worker_thread+0x200/0x3f0
[   44.564063]  ? process_one_work+0x400/0x400
[   44.564064]  kthread+0xee/0x120
[   44.564065]  ? kthread_complete_and_exit+0x20/0x20
[   44.564066]  ret_from_fork+0x22/0x30

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 020c76d983151f6f6c9493a3bbe83c1ec927617a)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 36 ++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 720ab36f9c92..6c62e47a95ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -139,7 +139,7 @@ static int vcn_v4_0_sw_init(void *handle)
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
+				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 
@@ -305,8 +305,8 @@ static int vcn_v4_0_hw_fini(void *handle)
                         vcn_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
-
-		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1976,6 +1976,24 @@ static int vcn_v4_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgp
 	return 0;
 }
 
+/**
+ * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @type: interrupt types
+ * @state: interrupt states
+ *
+ * Set VCN block RAS interrupt state
+ */
+static int vcn_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
+	struct amdgpu_irq_src *source,
+	unsigned int type,
+	enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 /**
  * vcn_v4_0_process_interrupt - process VCN block interrupt
  *
@@ -2008,9 +2026,6 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
-	case VCN_4_0__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -2025,6 +2040,11 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_irq_funcs = {
 	.process = vcn_v4_0_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
+	.set = vcn_v4_0_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 /**
  * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
  *
@@ -2042,6 +2062,9 @@ static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 
 		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v4_0_irq_funcs;
+
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v4_0_ras_irq_funcs;
 	}
 }
 
@@ -2115,6 +2138,7 @@ const struct amdgpu_ras_block_hw_ops vcn_v4_0_ras_hw_ops = {
 static struct amdgpu_vcn_ras vcn_v4_0_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v4_0_ras_hw_ops,
+		.ras_late_init = amdgpu_vcn_ras_late_init,
 	},
 };
 
-- 
2.40.1

