Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE873752E
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjFTTkL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFTTkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 15:40:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4CE7D
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 12:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrOCD6siTLiWs5qSWzsm9IpQUxBULCO5W+SZWuMhJE4qKB2JhdkKzz9zbfXHJDq3uJLTDsmYmue1cYiMOB65DtB1qJrlvzI+HBURjGiPIj5Bv/TfCRXXBxTEowSLO4NR7yghog8+KC5IzdeR2VnVVllu1KFqaeS5ZEQWHDlmn7QedVwYG41dtAyXJOIDES2kVx4WU31ZM8jU6B5vFCCKgHpyuIv47JkedEcjDBDYNoecr3/Hz2Bi2TO6XvW9wK7T2fB2Xvs57uFab5O2QE72Vx7Ba5mfufP6XmE4/n8wQbDJDW+MX3faiiR+Opf9pPSCXjopHNF+6zNiMZlif+RiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF4Wawj1HTYVsxNIGL5RywAPAHo5TOghcaMEK5WK1xo=;
 b=dAfbm2SXO5okQ4oTlrNmZI7FBW4b22TuMYyEYYvlwCbCizefSJfWY4x2wSydRdZQtYnOy8q2hPJpfzW+rp54SoidfeXr+ckzN22M+XGXef8VX/MppiZHv008FTyQ+Xx2iF7wE61LE7w7/bGFiE3GjvfKifi30RTGIyjlcCCiCbc2TsjosUZj7tgdnRaaCoKTGB+sN7FTcfiMP40Lddq8goIeCFtKO6wWBs1QqHu6ltaJ22WjFwEFimh6nd+g3gDiV+rPETh0qfeZjK4LReocRww3a8hxhXYyxxfvnDZi+Ip7rCg3vVIRF4knWHL4bskI1aHfWPZIBpv5zNVh6xRU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF4Wawj1HTYVsxNIGL5RywAPAHo5TOghcaMEK5WK1xo=;
 b=nyf3kbd1pTQK63WRztQ3Juxbg2iOoCagoa7Ydqv9rvpviffXKrE6ceZDwfEoIrxQe4iOaLqqtLn1Sl6VQHPgySm8qNXuDSu/8DQaMiEMtUZTCANOG7pt8PVzASO0PCNX7t7RB+O7W2v21k1wcFlCeh2rlib4eelJvi4d7gc9x8U=
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:40:05 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::9c) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 19:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 19:40:04 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 14:40:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>,
        Linux regression tracking <regressions@leemhuis.info>,
        Haochen Tong <linux@hexchain.org>
Subject: [PATCH] HID: amd_sfh: Check that sensors are enabled before set/get report
Date:   Tue, 20 Jun 2023 14:39:46 -0500
Message-ID: <20230620193946.22208-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fd68fe-0d71-4ce5-4111-08db71c62570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8H330ZOrhKGgWslUMsBrY4YBQNi8clz1fv09eQBzRL96rk2HGjlswRaH+bxbMIWBAwXi2lt6OZ69bffc7gFcQPtlMBjS4NlB5m4J4mRpbP7AFeYCZRlmTVugWX0JBf+nVInvfYryqkueGORvEUuHfLEAIeywPH9FbBvz42oO/bcvBuZI/o8ohDCvM/RifbRAfFvdYiKrTdtYGyQ5hzOiRaKbKGLXlRY/xx7Me3A19EMMQ+bUFriJZL+c23QvGxw+WF3OtU3H66FdFn2QI7GDEUQGxgXg+JkkMt0QjRnQ6B6FPOInjbuxALMtq8LEWmlSIsrih/ClBXHAeKXFOM39e/lc2ACW51poUmsPH5mpB+p8YJTlCicX5UrF9Brht8V8HjSZ4dTX3/q25qL519YhFgdd1YFghTxAjXv+ENsZH50UbYH6h7lPwQxmOKKSSuHJn+bNp3+YHEuVb013LuRykvJN6pl11r4/P7LXR6//O2UibBLJAhR1el7SaVMundhfuHzDnQT3aPwOspI+qd5UL4xB5/xdUkxdMJziOk5l2To6dIJtFROyLDq4ObVtYKtjKeq794oAJAqLuuLyDYc7tMujqsy8OuQKjtylgpVXk0jDgMTK2al8Bg/e+S+6zegAvuHL4LLc9MYK1uaYnTj5BeJNIWzsOWsyQL7KpwhsA53UNyHVdnLvJY7Xiv50oMQLApMRecxjwDQMqWgnOIeuDpkh6Ceaevvo3G/xOYmwq3rfRW7M/sUh9a2o0A368r5K25W6bADIM2ylSYaY64kjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(36756003)(6666004)(7696005)(1076003)(336012)(478600001)(8936002)(81166007)(356005)(82740400003)(2906002)(966005)(36860700001)(26005)(44832011)(40460700003)(41300700001)(186003)(8676002)(86362001)(54906003)(40480700001)(110136005)(16526019)(316002)(82310400005)(5660300002)(83380400001)(426003)(2616005)(70206006)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:40:04.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd68fe-0d71-4ce5-4111-08db71c62570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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

A crash was reported in amd-sfh related to hid core initialization
before SFH initialization has run.

```
   amdtp_hid_request+0x36/0x50 [amd_sfh
2e3095779aada9fdb1764f08ca578ccb14e41fe4]
   sensor_hub_get_feature+0xad/0x170 [hid_sensor_hub
d6157999c9d260a1bfa6f27d4a0dc2c3e2c5654e]
   hid_sensor_parse_common_attributes+0x217/0x310 [hid_sensor_iio_common
07a7935272aa9c7a28193b574580b3e953a64ec4]
   hid_gyro_3d_probe+0x7f/0x2e0 [hid_sensor_gyro_3d
9f2eb51294a1f0c0315b365f335617cbaef01eab]
   platform_probe+0x44/0xa0
   really_probe+0x19e/0x3e0
```

Ensure that sensors have been set up before calling into
amd_sfh_get_report() or amd_sfh_set_report().

Cc: stable@vger.kernel.org
Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
Fixes: 7bcfdab3f0c6 ("HID: amd_sfh: if no sensors are enabled, clean up")
Reported-by: Haochen Tong <linux@hexchain.org>
Link: https://lore.kernel.org/all/3250319.ancTxkQ2z5@zen/T/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index d9b7b01900b5..88f3d913eaa1 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -25,6 +25,9 @@ void amd_sfh_set_report(struct hid_device *hid, int report_id,
 	struct amdtp_cl_data *cli_data = hid_data->cli_data;
 	int i;
 
+	if (!cli_data->is_any_sensor_enabled)
+		return;
+
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			cli_data->cur_hid_dev = i;
@@ -41,6 +44,9 @@ int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
 	struct request_list *req_list = &cli_data->req_list;
 	int i;
 
+	if (!cli_data->is_any_sensor_enabled)
+		return -ENODEV;
+
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
-- 
2.34.1

