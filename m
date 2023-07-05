Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CAD747B61
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 04:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGECA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 22:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGECAz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 22:00:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1DE10C3
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 19:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Unjn9vDnsUkbmX/fyYq9yoJhA47OZeywi2oO9lPdL2x7khEjiHjMxY06BuEGMeitjg9we3Y6cRoS5BElLkFhQ0rqJH/nU5sifmKmX2LMSLOe65GGByDDyINGpGvZLki0CJyYURqgZUa2SOx6EaIVH1/M3X1fSkI4ylsBlIKqRzqESO9FPY3FkRh0ahPjL6TgG4LnvEXfJK0alhoA/8OchH/3W/eikHgb1EJTRCxxn6AeV2ckLHCSAQtuVlqCdrGK7/DEyk0eWHDJqwhxvmX1YtuM+fF8t35+pTg8ZxgjPkv0hjyUx3zoz3qztpabVuFzg5hDOtcuuv6/JZfxaPx/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf0ifmjCQsN+rdlyur0+JYyn1MxCaZiHcdPVX4tHKTA=;
 b=NzqrB9zDc5iVu7tINwVtgc8LhU4Z7nx9xvI0Jtae2vGzIplUKbjnHS5vRMM7GnKkfNeW0qQmt7HwmDQM4q2a0md/MJE4u18r+TbeU135GjjOODREuKOj34TzHyS1hebTq7y1ouv6bvX+wk4GoobILghwCDOt6FF4RGDFHgH+Dqm5YxvCNtxKV3KDlA0ShDe4xjdc+giknnXmSRlN6e5/IQKyT7GNjUu8HT1h69GukX90xg7cmGz+LnGPqCCOi+cHGk4CIHDYpAyzJV7WY3f2xZ+pXGTDURa2rqiwCeNtkDrar7RpkKTkzfY3bEwxPOz0nnGIj9Waa4mgUveqUylxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf0ifmjCQsN+rdlyur0+JYyn1MxCaZiHcdPVX4tHKTA=;
 b=pgMtSaJZOmqXxkInM+g9r7LYyRXOD3/Ugik/43RysN6U2owvJEg1MNJEePNqRcYPY9Uhm82EHWv7IwsFBd9+V5VJlcuK1NU6P/sJpbP+0UrBlI2p9TO1dybr58TdXqlY+pZmqPT7EVT+qqQ/keBmjuzOmXnF3JObA6dw3UBLNBU=
Received: from BY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:a03:1a0::35)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 02:00:52 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1a0:cafe::7a) by BY5PR16CA0022.outlook.office365.com
 (2603:10b6:a03:1a0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.31 via Frontend
 Transport; Wed, 5 Jul 2023 02:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 02:00:51 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 21:00:49 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <Basavaraj.Natikar@amd.com>, <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <andriy.shevchenko@linux.intel.com>, <npliashechnikov@gmail.com>,
        <nmschulte@gmail.com>, <friedrich.vock@gmx.de>,
        <dridri85@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] pinctrl: amd: Only use special debounce behavior for GPIO 0
Date:   Tue, 4 Jul 2023 20:59:58 -0500
Message-ID: <20230705020001.187145-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705020001.187145-1-mario.limonciello@amd.com>
References: <20230705020001.187145-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d034e0b-2c8a-4c6c-06ae-08db7cfba90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOAuJNVfmBJPso2OEWb5VcI3LtVXZy3ITnORhZfcjgk86f5FHQh3mUf5qdylqRHNvnx/QXK5Na+yxbwqNlhx+Tdzg6RYNS3XiUmI9vhCyLXNBRuN0y4YfYWt5kvEVq0R6wLMtGgWSzgzNK0IhLnTNFNXxiRP9KtCNz9dqPVYMMt5Jn/1BHPHfTm3hhOA9o9/naOH5VC7nWLPNJ5yPrgcS9xcXwzVQ+wXd/r7w+jpLdMP6Q2Yzet4lIYOIRXnU7RSIkP7WIGeUqCioNZHLoXKhtBZ563yWx4v+HM7w9Ba1vbh0+M89zuCmFzySVDCXS0tmk16/7hYSSxj7w2fJE9VGeYmJLCv2KB25Nqv3RxdhZMivxmBLUdzlxGMYPozer3uk2UQl69WqcZ4PEMzF1vzzvvQPoCeaHtcFnI6wImTidEBIga65ysoKjaGPlVMjaB//uT9AgWmYXeHG1q2WGOw977D41+89TXRSdPSRjnZquoEKu03cz1C60ThFuE+XGbnstYDV3EL9gVH1kVBhrKVYSjZYqzvW5Z0GmfW8iY3ZKZiMj2mO43kLd6A+FyplNt51P6bruCZ9bVC+4CN5opFiRZ3R4RR7o9n+9wsL5Uw/gRn7HMPakPapuStF2Q5z1XfgMqAlIJYBRvb19PD41dfT84hCHqOu/Rh9fqK217o0IpTLDuC9mZW/JgsM9/3rwaymHvo0RSzx8g1l+bCMAM6mmJ2rZ+HqzhbDs1rhWr8RZzozDJo4ekBq1Jga5EUUKpi6OfpYyxClLllcBLbCla+sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(26005)(478600001)(82740400003)(1076003)(6666004)(86362001)(2616005)(16526019)(186003)(54906003)(4326008)(81166007)(70586007)(36860700001)(426003)(336012)(356005)(83380400001)(110136005)(70206006)(7696005)(316002)(47076005)(8676002)(8936002)(44832011)(40460700003)(41300700001)(2906002)(40480700001)(5660300002)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 02:00:51.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d034e0b-2c8a-4c6c-06ae-08db7cfba90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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

It's uncommon to use debounce on any other pin, but technically
we should only set debounce to 0 when working off GPIO0.

Cc: stable@vger.kernel.org
Fixes: 968ab9261627 ("pinctrl: amd: Detect internal GPIO0 debounce handling")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/pinctrl-amd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 7a4dd0c861abc..02d9f9f245707 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -127,9 +127,11 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
-	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
-	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
-		debounce = 0;
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
 
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
-- 
2.34.1

