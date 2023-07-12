Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C5750F6F
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGLRO1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLRO0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 13:14:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CA1980
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 10:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvg+sbZRE4kEVKfPgnMY768VDuRxth43oPoOtDsuh7vubHF5MSgQjfAifz+q9w4gVUw02x7kBueBXntqVxxHJJXprVu4evkJN1JrGyOEJjMKL/+8nLal9OyHwQUQFrzD8NFqQacwoQ1/3A9Bl+CKlljCqqOG2M+ixGuo+h17sV/YNBOpr6NLvur80C1H7X9DfXEuuk1hi2Mma6SVq/jCgVU92xLo7JUleeGflA8TDUjMZlGMCSgilTjQDvZMVg1S08a+qR/w+sgkWBIws4n01tDUn0IXlTJdIskSbM2ndIUutnwYVbVkvr9+lZ6R96kxIGmT2D5G3Ig196f2UoPdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6OSNH56fTgBhP2PHB7npb7IGOW25UquDK5/8FUOVoc=;
 b=hgAgdyoy6qJnDKsaDB+ofkL4N7aoxILEZ1qKlVAJqKdFUl8/d5TE/p1BPoOJ6XkpAGlQy4qxJLN0r1DniKrN9hrGb015zmsQzVl49xfQZzuoA2cN+37jirfDkPoDu7Kp8uvFiPLwwATsgUyLmvKXU9dueR+/vkL6rDHjTSVNH+zJgA2RxvxwGxa6qoaLrU6FfJpvYcia0UCbiLxG/KxPDrMFz6yerkNfKvbRxaUFAPU0iYdMeAOIv4ZlWUVnHZtwekfTerF1cTiCQ5ycUZ6KANGWKi+SRoB2zI88mhRxwRM6U1zyrdVzNyjVUYuiUs1kTDgv64OOozuaJMahhpdLHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6OSNH56fTgBhP2PHB7npb7IGOW25UquDK5/8FUOVoc=;
 b=WYcLRicFNFzVBLb5HKWbg8bJe5gdWLlyyzGpByK2X4lFcpDnBrBJr9ldfUMKMQ9eoV9b8npfHjkIHabJWSidpfnblOxQjKi6bPddc17aIzju+BqMEgyOlGBPFSZYqJ7drxgeiNtttjTGfclfZ7jrxgAu05Uk4tx/2t12QYQxHC4=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Wed, 12 Jul
 2023 17:14:22 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::5a) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:22 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:14:22 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:17 -0500
From:   Alan Liu <HaoPing.Liu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, Zhikai Zhai <zhikai.zhai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Alvin Lee <alvin.lee2@amd.com>,
        Alan Liu <haoping.liu@amd.com>
Subject: [PATCH 26/33] drm/amd/display: Disable MPC split by default on special asic
Date:   Thu, 13 Jul 2023 01:11:30 +0800
Message-ID: <20230712171137.3398344-27-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af7d201-3a3c-4731-97d7-08db82fb6fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWsNp2/uPYIji0je3juJ41skca5X6k7+ExuZRzq6TisJwg2tB5kU1q+qlEVqaG7Fp0cSTEILzUg6JwdDSbJvqVkA46oPchRqSoMQF9MYxjKgoVOJ0fPGGE0Mt59GAFxqDIjaHkgcvm2JK6Y3rpvYxYyJU7ZhgDSjtrqlpIVvki40yAfPNl5JTl+qePIMY5i1NuhIEQbC/D7l4OV1vWv6TqDgSv4vdMADyqC4Ll5ipnObEku3lqhN96jOFHUP/iTx6YX00UzJ8kAgEegjKtm2x03ut//0zhdE/9azAIvVxisERcvzE7yK3bGs+MOCgdNpQWPtPNL0mPl4GW7hzcq00r2fhL3cbakTuLDlCugRfZevto2TNbOvZXjRukgagS/8jIfHRTA2N5LT3c3GYHyKOzPJ9do7nhmLOGnHeog6K2CWDwt4qbozxJ3E/rEoVwhyjttE1BBHua2eWGIxNBr94nmW5qwxL+om5NLfXHrRdauylrTDh/RqQgOrP+vY4sd7/6iLNjjyIHYAUXZbJEAn5U6sxkwKM31rWSyvkBwntbZQvsQTUxtFGtabsyO4P1MQOPfOYpo/DHwx51fqRnmF3NbYnya42O4hNJgBNdLSreOGSfotP2fbL5QUrDlpdrxKFtj2oYn8M8nPVh2SvUfHgd5uXgQ3TI+5QvaPXQDbcy/nkNEDEL95G5kPQXrAOn23DRENu4qxmKg34MpePfwIMRnU6bRiz+mva5dT4RCbIKOOtxUmhVQzdUGEnfoz5LHU3GWBZnzc7/cDF0QjL7ePAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(81166007)(54906003)(356005)(6666004)(40460700003)(7696005)(82740400003)(478600001)(6916009)(8676002)(5660300002)(2906002)(36756003)(8936002)(86362001)(82310400005)(4326008)(316002)(40480700001)(70586007)(70206006)(26005)(1076003)(186003)(336012)(41300700001)(36860700001)(426003)(2616005)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:22.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af7d201-3a3c-4731-97d7-08db82fb6fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
All of pipes will be used when the MPC split enable on the dcn
which just has 2 pipes. Then MPO enter will trigger the minimal
transition which need programe dcn from 2 pipes MPC split to 2
pipes MPO. This action will cause lag if happen frequently.

[HOW]
Disable the MPC split for the platform which dcn resource is limited

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 45956ef6f3f9..131b8b82afc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -65,7 +65,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.34.1

