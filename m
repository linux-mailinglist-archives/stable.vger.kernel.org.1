Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1875E5E7
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 02:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGXApi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 20:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXAph (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 20:45:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC09B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 17:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1fjwuNch2Uw1Hfh9D94XEEOwldjhOh3K2boPJwXB+iU2K3Y3UEogFKTv1XAz/Lbm11wGpqZBbvvDuprJ91B9pdrkTUqN6XJGjTAcDB/UvlVt1XVCWrmZ4mWsGmOD372f3aZA+NMCZbwwi/NHl65uz805o5Y5pJG72Fjj5+8IvkPC4EKUhY+CyPpZMf/gGFz6+Ejp0XWtzxBUqCnf4Q8FV+aNlalxVG5Jfux0GGXMPtwmuMnm2VrpafijZz5oIQBxE2M5ysViaWuVl5fbEPHMjbCF/BuR8a9vN+09aEBCvtuY4t5e9WXVRvhtUv2hN5ZVC8hIGumM64qtrQjThAM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7bGnSR/IIZBaOlbZSllXCymkkCb9aQ/a9R60TkWljQ=;
 b=JO/4sdR2uponaFp5ps8j0zQs+9HsZKM8fwbIMmhyus4HXp66riChodE8Lv4Oa+soGVyoz5n/vIH2CdFeMnxzd4aCRoNXJW5dAxYH6/hp+/ekomaPDEZ6B/zqjUc+CuGZq5zmADtsPDB5QezbdEbx1V6UUnBNfinnM9y061naDHHsx5XjEQZqmu8IU6uZUXH1Gvsy8kW5pF2nWlCgvRqeBcjHBu0gAst7eARx1IGjmg1Pcym4LBu7p8eXXFqXwElpsryRJYxxdRF4DTffhZ2PxwxmLLkeaS4K29id8eT4wVam7LsOOQ4MirZtuZdihcmjqUNHtXTO13gDTPQ5yS14yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7bGnSR/IIZBaOlbZSllXCymkkCb9aQ/a9R60TkWljQ=;
 b=C3bgYOc7gi4nrSTl7JHa6semAxgiEjqZcn+ZTw5384KPOpiUacYQsHyoR9uSaeZW7dxwbaPGq20Y4X4SC6qtmOk8ppd0M6oT6Ef0vCCDMEOQDuOZej+kPRsU+sUvlM7H2n9TPmdfnQkPySH8il/ak7qHJIkpjThM6/aCdX+Vjho=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Mon, 24 Jul 2023 00:45:28 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c1) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 00:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 00:45:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 19:45:21 -0500
From:   Yunxiang Li <Yunxiang.Li@amd.com>
To:     <stable@vger.kernel.org>
CC:     Yunxiang Li <Yunxiang.Li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.1.y] drm/ttm: fix bulk_move corruption when adding a entry
Date:   Sun, 23 Jul 2023 20:44:57 -0400
Message-ID: <20230724004508.1519-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072146-sports-deluge-22a1@gregkh>
References: <2023072146-sports-deluge-22a1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 4805ecc9-dcdf-4f3b-524c-08db8bdf4374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp9tQz/zbHgJFUXZWrYuqny5cSNND6C5tp9Jx36LQxmbYJ4kF665Lt4gfmlJRDPpraicFCIoAxPOqmFMXXcKRqLVlO0FcfRIdmWCbip3Z1p0F02ZI8Y7ioJ7VRI1bfopJe3G4dDVYksC9UINnFhJvx4jZP9TbKXhSspv7N++wP0vWG8ThgzA3CbJVyW5sNi9PrpWaJIoc44si7fqkjJxIGig9hZKhaqSZZqFqb6ynrl1P7ScIUd16OO+vAhlw+TDf6NLICuBlsG6xmiUg8LebUYXrNcrFcVE7tz4wWHGecUIQQ0FFtndp0tUcjLcoR5GVa1qHXQuq/umBc7UNaKwbdYLVrTvE7A84Z76pYaCMUhW5W9YKQOnW7r5us1ZQtuZj2LQWWXswUJPO7P/rCJfBnsXa3psE6N6icK7qUdRFrUu9uJLyO6zThllNhsPzv2nDGjDedC0BfMzDeou/ZF61ixxwwSuDg6DymqkYvwATvwv7p2rKybZ1N4fJOogMMO2nprRnlUSJmnPpFkT5XhOA5nEuFWk01NLnTn24NdR5//nYtQI9sJjFCk9FVUnM/6QzDY8GDezV4Iv//JPi2CHjxnziaf2o4/aqowa5yWjKoeGl9+7iauBQ4i/8D/8YKPWh4ou/Sy+6GVK7tYKpfblgDHZnoJhqEmQnv39uELQ5+9llDfkSooUOghrtj0ufCaF+ujwwCWsTtzi1aEwFTWm33ofgZQzPDe4Yns1Nw1IZF8naMbx/9YCUIbpOTzY7sM/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(47076005)(316002)(8936002)(8676002)(41300700001)(2906002)(70586007)(70206006)(40460700003)(4326008)(36860700001)(26005)(1076003)(40480700001)(83380400001)(966005)(54906003)(66574015)(426003)(86362001)(6916009)(478600001)(6666004)(82740400003)(2616005)(356005)(81166007)(36756003)(16526019)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 00:45:22.7940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4805ecc9-dcdf-4f3b-524c-08db8bdf4374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When the resource is the first in the bulk_move range, adding it again
(thus moving it to the tail) will corrupt the list since the first
pointer is not moved. This eventually lead to null pointer deref in
ttm_lru_bulk_move_del()

Fixes: fee2ede15542 ("drm/ttm: rework bulk move handling v5")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230622141902.28718-3-Yunxiang.Li@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
(cherry picked from commit 4481913607e58196c48a4fef5e6f45350684ec3c)
---
 drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index a729c32a1e48..3287032a2f8e 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -85,6 +85,8 @@ static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
 				       struct ttm_resource *res)
 {
 	if (pos->last != res) {
+		if (pos->first == res)
+			pos->first = list_next_entry(res, lru);
 		list_move(&res->lru, &pos->last->lru);
 		pos->last = res;
 	}
@@ -110,7 +112,8 @@ static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
 {
 	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
 
-	if (unlikely(pos->first == res && pos->last == res)) {
+	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
+		     (pos->first == res && pos->last == res))) {
 		pos->first = NULL;
 		pos->last = NULL;
 	} else if (pos->first == res) {
-- 
2.41.0

