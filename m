Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398EE6FCAAD
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjEIQC5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIQCy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 12:02:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081930E4
        for <stable@vger.kernel.org>; Tue,  9 May 2023 09:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7cDUfuxFoSczzdP45s/TojL3i1I2JjGswS5XTUeMnUxopRjv/Aw6zsrgU5zzmEWq5jDYql99dIv9xph1lsDlY/aTHk6fOTH0muMTCvbY6YodXSkCEP9jiWRTp5W8DT9kZrNjIrn4mWmIfs7IJiyLP0EGhBHiqxQaD7LoO8zm/Ac+h3TMqbBrWv+ozPnjhbbVIjTtQ3hA3E+rNuYG5eaaealBvTQdnOSe/dY+MN6eMO48WIWBQUQ3bcbEF/L0kL2KaDIs3c6e+YqM7CFvs2i7ozJ8C44wh3okFaP/dAsYafED6RuACExH6Wz1PlmoU+Ol2Op3mtl1qo0iVMV19ACyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOYkQyE5jT7D3N465Ifz2izQdjRZjgevErAs6wr+Uzk=;
 b=QymBvvQqvfav58tXHN7IzBtEnTqPB05zaPZJ62GmVQNoxkMo+bq4FpGs+21HnLxwJU+oStbrAllnwfIVlBb5o+QfzhN0XMfi5UavrmqItqdC+t4ahe5CS3m0GSnu64/aLsj5hzIlpcMhi+LN+NysZC0aovp7RYBmc8CHWAt9mBk8E1+pcCIDGXoIBP5W2v2Qu99Mev3EfkG/2PCurfT7Zky+Kn6HfP9aft/GPF8V7QoLWR3BcS0ViZjjpSyUKe1wOEFtGxJNhndvEcKl0MuJwyy7fOU7hhcmqdqp2bMtRCnhfU5kJnT998OG3+bJeieLTCDLwCHtsthGKza2jL3TOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOYkQyE5jT7D3N465Ifz2izQdjRZjgevErAs6wr+Uzk=;
 b=H1MwXYb1NviIW9ryGzccRZhRWCdZ3u0yJkXlxO1bNRIv6mmXfdWu3xcaeg7jzzBeuFC++Ou/hv5OiyUk0F5T/4Kx+yYY53DBEiLMOmSaIZWhd3bDdH2zd2HULofRayLafkyjQPg/Dugr3ZOZ8Yn9DUXFrlC9m1738pU58XCn2tw=
Received: from BN9PR03CA0895.namprd03.prod.outlook.com (2603:10b6:408:13c::30)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 16:02:46 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::e9) by BN9PR03CA0895.outlook.office365.com
 (2603:10b6:408:13c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 16:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.34 via Frontend Transport; Tue, 9 May 2023 16:02:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 11:02:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <tsung-hua.lin@amd.com>, <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y / PATCH 6.2.y 0/1] Fix a resume timing issue with MST hubs
Date:   Tue, 9 May 2023 11:01:19 -0500
Message-ID: <20230509160120.1033-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: f188a143-25ff-45c1-225b-08db50a6d447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STwwstqtGBwP+uxW9tYm5OaNMoxC3AWz7Q1KrH7yZRVAmK+0u34Pw0YfMyAbuceW/9DRayhqZo0no0X5+qndWR7tjpWrol+uKztPBdA+eNOtqawGe3nf5Ccbu3qCv5nEjtKaEtMopFIXxgUIkbXoPyfnT1wBEsC0c5Xa7Y+t5VycvOXlQUY8/JTz5Hu9iLbceFATyfMe61YoSspTqseBSo1JSB8nOLrh92a3dfpOu2eU1QMHBv6dslId5RnKZBcEwVPO4/B6zVsW84dhbA7tkbi3NUJNG+JWfiCorwS8kTRBgG/F1u2oDWwZBxd42vsPk0MITkqEFLqSZjU8M6JJJromwiyTGoEBH2m74ggcH5do07pwO/XWZPGb6OEAybcuZCqWUJbVpqsaM1HZg6W8Zlq1INbR7QKmmIA4s9nEGaqxWe8xiYt4WfUKLoTb6dc+sclNXYdcEh1vaA+WY3hTQKpJ52psxrgXAJQ/Zo27okUq4JQyn5cRaR14odYNxCAq93sXjw6ieVC491GYU6qRNXIYHLCYbl2EiTU8dmeUkcWTxzqB9L7e1D6B3uIqmUGS4R9aczPx+QfqIIK3gnSZSy4tHty8TofvEtjSVtVGrGDEeYyTZA714oCVOGAcVUoadQDRDRSkyTA5v4p68rQgkVHgEqt8QqATohvPtmT1kxddbQi/+3+Ez07EC7hpbDIGj3WyyyGJlGwW1dNgzBOKo9SOYZ6iCZ/CUdBDortRwmg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(316002)(7696005)(6666004)(478600001)(54906003)(2616005)(86362001)(41300700001)(6916009)(70586007)(70206006)(4326008)(336012)(426003)(26005)(16526019)(1076003)(186003)(36860700001)(2906002)(4744005)(8676002)(44832011)(5660300002)(8936002)(40480700001)(40460700003)(47076005)(36756003)(81166007)(82740400003)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 16:02:45.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f188a143-25ff-45c1-225b-08db50a6d447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

A commit went into 6.3 that helps adjust the timing for resume of some
monitors behind MST hubs.

This commit was done on top of a restructuring that happened in 6.3, but
the existing old function names work as well for this issue.

Hand modify the code to use the old function names in 6.2.y and 6.1.y
to help this issue.

Ryan Lin (1):
  drm/amd/display: Ext displays with dock can't recognized after resume

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.34.1

