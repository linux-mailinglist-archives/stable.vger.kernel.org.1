Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43676AEAA
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjHAJki (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjHAJkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:09 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93C719AA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:11 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3714rcF1026402;
        Tue, 1 Aug 2023 09:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=QZtC+7f7SKHx/YRkk3
        OCfvk3sOq4BC5CacPEz6kY5g8=; b=lh0NZ9OYAlXsvMHs37OGPadkGg/zpL1TFQ
        CYF53Uk0gfFIAZQ334TPCG79tyNJ+GGW531OOY3u2szv3+noHga4DhB0rJrNEQRp
        s3zfiLSJM2uxAvKjUT8tF3ZCoD0wfA9v8G9qqF1W0uYtT3UoB/HwRaZcv9SvOvAu
        I9UOZ/MpsbVLtd4b9NfmCIv/BwQwojh2cAs7G51aRl3ExPTdyTK8nghWrvEmQMUI
        sKrRQgzK6q5DKe65G9KJs3/cUKRKJfOU8fqGgvH0WCcyWuBfeI6rCnux/uIg/qnm
        a4J1Iu1rYnod8E3rirhFIObl7FkYc8e3OdUS9+4rZ4sUXdqjSFDw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s4qyx2kyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 09:38:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9brte0PoFQdJabBj2j9zTX81gZxf38LYETAbNi5B4rQQbpyKB667Tp6Bhl0paspCI7VnAu7Orrs7f4FjfS3lR8MltsIErdGsxhkZcVDeIxFHGXCOjEq2dkpL62YSy7xALE5XE4Wyy3tb1THkAXjNxgncCGLic+xoN7N6wgjb4JrSO0321Kh78AnJIG5XA7fgZ/9oLQ43f8IbqJmyWCex+hUzoADwq1KX+OS1n+bm+p+0ChCgPznowDmuR7YiLnx878PYhqcw73mtcmEWmMKiAROjPtiz7Pk480ftjfsowFBnEER9wpZtoI19uZPDJWRqy+lpQ/gvyd2b0XWOSBG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZtC+7f7SKHx/YRkk3OCfvk3sOq4BC5CacPEz6kY5g8=;
 b=Rn47YyihL1kYJCZVqswS7sI8nwi1qIaPalhMEzf3M5eIIApEaAgGZ4lyyZOSA9mcIS2fYrESahYW1+zTRRLzvr+lc4vOYPcIoM4GpNo30m8M42f5h5v61vw0TIaMsP3KcvVvWc/YCJVsSra1WPA2IxGGiYdWahYSfQUOy4zkXirtHn+oVVY7VIGpGzsDO8HIzTzfOWQ4OSNwstpHFC23Uivxfgqaw9zpHemmktGhNcSg6ReFD9oL55SibCbhJttnIvDJ43Kyy8//eufHPSVJmdgWwbetoIQ7P7r2qIiNlpr7na5JPfiMuMlJwpfiYanIIPdVQ+dd0+sVreyq+J5qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 09:38:00 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::1f8b:45ed:dd21:9c99]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::1f8b:45ed:dd21:9c99%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 09:38:00 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     D Scott Phillips <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 1/2] arm64: Add AMPERE1 to the Spectre-BHB affected list
Date:   Tue,  1 Aug 2023 12:37:35 +0300
Message-Id: <20230801093736.4110870-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SJ2PR11MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: a15c692a-9523-48b6-efd0-08db9272feb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NER42PhwCVPfMXTgIFD4DUYKUfFgTWTkujuZkkNSsMBY3xpcVzMuQyYC98dNTHp6RDwI4/X2Ey1kOzffG0/K6eHje7LphLaoygoMNOmvjEcFG94I4ciz23fmCq6u4e1R0Y8spYp23BHmycid+kzAoGAu5ptsOvYBIQPcVTTlXVScVVv6ID1Wzloo0+oLNNsxmdPcKcIVg7AiCatgDCfwIQaB44FXFjbpYbok89nhqTuplxCkh222wm/uwossywC60ONBBqRTH8V9CYKx/Ch7puf7owjTKb70w+DVQRm7PGF14DOqpS1dCvG5WjGYMlFn5vv6X2g1Hcv79Z6pPGaszZ452E73nBUNAwzcJL7fV/Ltew45bv6Ezdm0t9vhY/6E1EsOIfRnihHS4EQFS1ugNn0tJz7PIdc1N/K2FSDYVpdz1hTZig9qjdWUoRbzYiEauo1ZFvxe5C0Fn4uqITqwjORpcanfqubg172NLUS8QTzFB87Be6Zbl8rLifxPoUgvWNsGGIBZw/55m9JOQQ0n7Yp32nf7HD5eaGSb7Gu2sEZJ93iKd5Gi43zlE4t5e3+rWWCAJpggBNMdV5pB4VTnjiS6QGHcuLViqTkz+L1Mg1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(966005)(6512007)(9686003)(6486002)(52116002)(6666004)(2616005)(36756003)(86362001)(186003)(38100700002)(38350700002)(26005)(1076003)(6506007)(5660300002)(4326008)(41300700001)(8936002)(8676002)(6916009)(66946007)(66476007)(2906002)(316002)(107886003)(478600001)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5eCFyzhcuSqkY88oqWTnDgS86/waYqn2xJk7Of+Sfgf20wpTcddpnAc2qaQ?=
 =?us-ascii?Q?2atPwMOlEuZPcxQBTw4pAF+mJ5dIoWKgbyaOwk00/9PgvjMSnI3fOBw9cbJk?=
 =?us-ascii?Q?Lbqauzs9UXGeBxlLEVuMgrXqgQneWap94pEOyGLRSJ0jLhIPRcMY/VCI+Upq?=
 =?us-ascii?Q?LJB88F6UG/DCo7lA4GJ6xoNnBt4/nVJYhDfgWAPOec3ztGHgO6GubGaU2xlD?=
 =?us-ascii?Q?G4vHI4TWobpShmIuPl61hCWQLPcULxs2vha23MbU1lpctEMFtplcCyEwADpA?=
 =?us-ascii?Q?yJj3JK4UGOq74LGOJ+i+tp1nuE/O83iAMktvtrXJRsL2Une1PMfpb+6aHV+I?=
 =?us-ascii?Q?5YB0rU5My+kGZb7u1aDyRbnQ8l+7wAt8ryrR/aFuf1Kjp0VuI4vwdjhgnroH?=
 =?us-ascii?Q?PiwL3t/jybVb/wcyO9xofdyFRQ3IYtjiFZXb4MTqSNk9ipbXd6nIn0N+TlAp?=
 =?us-ascii?Q?bkpQ7qBIIuUqws5tSfmCWZXOOdavW7AY7M9rsi99aVUhpBMqTHgPwoRR4Qfh?=
 =?us-ascii?Q?Tw3zIeZ68CZ6drz/8hRqvYxCx0qt8GfT3bx5kSnrTH42UKF82V7KFZ2DGdhX?=
 =?us-ascii?Q?pNuep2K80H+qaiJJWLSVN5Nt0ph3NF/7kxzDizW/A0VO8AWSVuNk4/tb0OdY?=
 =?us-ascii?Q?6mtleP1E1IMEm1w11RxJg4aVa4FdPxWTY9wVbNQe6GT7XT/TGMKalV8guvjc?=
 =?us-ascii?Q?MgcyR0ElnQ+HnZ46EoTzOdU/unbPVe9XiPclINO5rzIMY4uSErCXry0TiDVw?=
 =?us-ascii?Q?EhKOkyaTCFGQQbj9MDUCZSmWYKtuB1UMBYwpv6DQTfmqGBVgyIqYntfSXuCe?=
 =?us-ascii?Q?oFyZxkzKgN84In7v01k5CMwoCOVjLbO88b7NVXOmzxLC8DRJTy/W9lKu3Mv+?=
 =?us-ascii?Q?AiPZyW9NxyeDt4Ao2DOVt0jknipvIAQ5OXNfrvPvvsTI3gMuH87DZhwzIG+K?=
 =?us-ascii?Q?yuokjoAZ1OmX+w3UfGDDICoJloxnu40ZP7Yg4csTIjs/mggnuccMmjcN+FdB?=
 =?us-ascii?Q?QYo9rkENHIH0h9veU27AOPlCRfKCbRqElFjSFk0zcubBNALkdEwuNWnb3rDY?=
 =?us-ascii?Q?Ty33euqrfdlHa9c/YgOW4FC1KPnGncIjfS9/Gn4SRZHf1eroT5ryKBI8VU4A?=
 =?us-ascii?Q?RDp8fO4zgLPSt0VJIJShoVdHJ7i8dESRRMHOzoJyA7xlbNWFzKystS4PcJJt?=
 =?us-ascii?Q?z6bB/QNFHwW1cdqjEjN5WL5qkiiD3h6KHTW9StxIJ9ZBcf/e1gwHbQ0CvBGs?=
 =?us-ascii?Q?KE6wCpaljsgzVC1gGyuP5xQBez7eUt7u4aZg+ptNqNfO87sZqwbi5pa1pD6v?=
 =?us-ascii?Q?l3pwpkRZETMG+k9LHqAGwhfjUtEhMS42RLB/wwbIt8u6yebQR01wtPWoYv2V?=
 =?us-ascii?Q?9D0nuEVbkZOZuwmTYYTl0g99DfCRk1MW0A0c7OQnbqlJ1nhILmiP6NT/HetS?=
 =?us-ascii?Q?sxzOieQV7GQtfSnRyVX8ByXWzjXDX1NnUA+eohzQuT97pJu1gjrMPZlNj1yh?=
 =?us-ascii?Q?weVmsWNQp3OWPhG3jKrPuD+Ei72e6bKkqO5zSjext7r6jza2HUXR/eehSMWC?=
 =?us-ascii?Q?esKhUW67JzdsOWfGFAiIivZqGMHza3LQnFRHNhixdvkyegYFhYLMBR3joa/Z?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15c692a-9523-48b6-efd0-08db9272feb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 09:38:00.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4eo+Y9tErXQQLF+ZgHn2CMKoB2l3nd58owReKQTFiMAVpIIrE6Vcr+znarsqeEhRCpkPbbFdegm42IDhursHiBc4+f/11iHHS9SsEGoRdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
X-Proofpoint-GUID: YbTMfrK8bn_itbRD8M07cC5uMpMqFe-c
X-Proofpoint-ORIG-GUID: YbTMfrK8bn_itbRD8M07cC5uMpMqFe-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=959 suspectscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308010086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: D Scott Phillips <scott@os.amperecomputing.com>

commit 0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31 upstream.

Per AmpereOne erratum AC03_CPU_12, "Branch history may allow control of
speculative execution across software contexts," the AMPERE1 core needs the
bhb clearing loop to mitigate Spectre-BHB, with a loop iteration count of
11.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20221011022140.432370-1-scott@os.amperecomputing.com
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 arch/arm64/include/asm/cputype.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c   | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index f0165df489a3..08241810cfea 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -59,6 +59,7 @@
 #define ARM_CPU_IMP_NVIDIA		0x4E
 #define ARM_CPU_IMP_FUJITSU		0x46
 #define ARM_CPU_IMP_HISI		0x48
+#define ARM_CPU_IMP_AMPERE		0xC0
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -101,6 +102,8 @@
 
 #define HISI_CPU_PART_TSV110		0xD01
 
+#define AMPERE_CPU_PART_AMPERE1		0xAC3
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -131,6 +134,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b18f307a3c59..342cba2ae982 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1145,6 +1145,10 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 			{},
 		};
+		static const struct midr_range spectre_bhb_k11_list[] = {
+			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+			{},
+		};
 		static const struct midr_range spectre_bhb_k8_list[] = {
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
@@ -1155,6 +1159,8 @@ u8 spectre_bhb_loop_affected(int scope)
 			k = 32;
 		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
 			k = 24;
+		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+			k = 11;
 		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
 			k =  8;
 
-- 
2.39.1

