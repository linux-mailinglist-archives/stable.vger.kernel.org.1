Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DC7ECE9F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjKOToS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjKOToR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1712C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPNL/qYDFjatWnl2sFrmnMobPMfbK9/cxB6qKgmcstX7nLb4dwYhJ8OFD5iuMW9grT43F4Z0RRRudhNbmR/08cGWs+0jM2xir7zOUtMWq4YZ+zC4nOpRXsCCQ0wMrwkyk4qOKMrcUlyV/AUEfQ+12/OkR+NQ1un0AgRnkNxy9EMb3GehtPCszkLjeKEEO4ZDZSPBn1Esw4wH5jrspEUeHRiriBcbtcv+milrsTc+7IH+LspH6kf6jkvCmBMlgZDB6CdfLcgcq8r9Rb3K0dScbDeXb3pCbtLwG0jDdxhT3bthCpkGReInqd5Q46Q65jBqkL8DmsJ45QABJMV35UdTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9yhAeB0nbTsbzFlTDfqZeJ2tP+5SvxVk9/Oqi6B1ik=;
 b=P+8r8cUg7b/UR/UKI6sy3vl/FKl3UYPassVZPSVHuWAAN62tlQIoKllV4bSjpA62orQgmBxfm/W1AbOkKIOsUaB1qdhz1vmx2MyWcZ7Z7BMYVDbsh/FG4Tosl9Wqj9TPGuMmCjzmPpdINOEg9nHeQT6Hp4YSGQUJLFKP1tpvkYcwuuH7Wz1FqDAqQP30qHB4s9VZ3KuP5ysIPXlX3ywsqxihIYSLRr7ITxqdd5A6JMaNuyLEAIpBhX9ZE9Lbc6i2GFA3S3FlDRrzcjA3l63NiRepmKBgFXZv3/vFZeq29DrGBn0ZfDXccPncZkHdESzH/PXrnLczfNGfDWBUGzYzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9yhAeB0nbTsbzFlTDfqZeJ2tP+5SvxVk9/Oqi6B1ik=;
 b=oEB+7GwkAtdjpJebGXU5uv35Y4LqoThsVUcETdE/FXuqWhAU9CsXUqpM6bHVhN+pllz6boB+iof5rm9d6+ybrd5eB22na18371GgCsICOP7ssAs7mXyX/sZ+k7aMIBZFckRjGK7ZJSZEq0U03RouTJXqhq1U0xTkQCoRhnLRye8=
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:10 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::84) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:10 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:09 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Alvin Lee" <alvin.lee2@amd.com>, <stable@vger.kernel.org>,
        Samson Tam <samson.tam@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 02/35] drm/amd/display: Include udelay when waiting for INBOX0 ACK
Date:   Wed, 15 Nov 2023 14:40:15 -0500
Message-ID: <20231115194332.39469-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 584d67ab-db2d-43e4-9893-08dbe6133d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpHYiXUTl1Kn507pPPF4LoAX/izB3KSlOn6fE/93JIA8xw4R+/CtLGmeoMWpfBQTfFlwe/PjcsL+3T3ZRxXHZ1nsc560MhkU6VPBGDIW2UMOYoY+mNtLboLFEKQ6HCp0nPqOkF7ifEj3q0Px4JT+OZR/YOQy6qR+Sx6T4pLJa8j9KOi7dVRTT+s0sSfXEo9RIB15eNA9d+bz35zoKgEoZ6ceHyfopkLyl5JWIQ3N0CmAPmE3qgAbZvH0FLGsQHlX6VJfWDkCDdddiuerncanV5Lk1hJs4JFGb3F4Vbx1dl53wykR3ExeZMu6GLchXHtwDqP4I4Kj761/wuhiaf/AqnSJ2Tc3PU6F6T0NxwPtO4YCH3eAKRQ9JmgcUQWDnir/mhgfLEjfTkOCbfkOF8JHc/vshXcgW7n0HF6UCHZ3LjZw5LqrDikkhEFXPWWoko1lfidtIVz0vtj0sB5h5EHBZVGo1oyTqZtY1qKziWw3zOXfPhatAEwQ6Ba21paAA+GXtglPJKMd/3c7ngfxrcsQawFBnwj4cmHCX52QmHzjVazwYYL+Vu114bA0rFE78GWGQjj7k/48UNhEwij2nW0Jho7uolz96ljzzj2ogvdxBYzdZ2qVuDBydXlC9ew4f2j96DF9ly5pEqENmqbaLQDQOsUHyJluikfntW8lnB1McAtwVGS4TFcFdwHU49ylOKAb4tFGTrnRcyiDUqYpKITz/wOkQsvp6kagXHiJKsbud+SJW4sXHdHZN5jtAsivWqWMhiSat97JvGeA3C7kNtLWhbkX+1gHHOQbXkR9tyyfWILs9lZdfFoZmIGxmUZV8BFi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(316002)(54906003)(6916009)(36756003)(70206006)(70586007)(4326008)(8936002)(8676002)(4744005)(83380400001)(16526019)(426003)(6666004)(2906002)(336012)(47076005)(26005)(36860700001)(41300700001)(44832011)(1076003)(2616005)(5660300002)(82740400003)(356005)(40480700001)(478600001)(81166007)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:10.5525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584d67ab-db2d-43e4-9893-08dbe6133d0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

When waiting for the ACK for INBOX0 message,
we have to ensure to include the udelay
for proper wait time

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 22fc4ba96def..38360adc53d9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1077,6 +1077,7 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
 		ack = dmub->hw_funcs.read_inbox0_ack_register(dmub);
 		if (ack)
 			return DMUB_STATUS_OK;
+		udelay(1);
 	}
 	return DMUB_STATUS_TIMEOUT;
 }
-- 
2.42.0

