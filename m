Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F27875E5E6
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 02:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGXAn7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 20:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGXAn6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 20:43:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A19B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 17:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK8mx1ekQlDLXT++JqnAMHtMphP+RokMTzytK5HhRo/eSLCXagbSdP7vpWN0vOUz8HpU3sa2Nv0PBlh/G1ThBNWxCEBTXcmZ60UFqQ2ypweICaexOytW8qAPCPoeQh4M9eaubpoAHay70Xre+LNSGYImWo7rUn+KqAurGd2NcUQoKyDLeW3TDTfwOd0NEtmm0qCgWXmEVWqHuO/Fs22AQaLf6PvlS6Io7WXMVvhweBXWn1hcdShXW3UIVsOOqraK/lsKFT146enVFJz572IlYbjA3y+RinHyS2Zz823mveEo/UsIYO/GZpLx2hLcCvFjU7HnCePJmxAfYrvRNNPhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6zmzHA9WzjJRLgYYrbxRXjIcXs1KkVIAKL0ZDk5yFY=;
 b=TFGj2CLYDXHw4+t/4Y+bARHrjVvPQrd73b1ud/H2BC662wTSlHV0Ct52Lintnp3+6WazLpR4AxbA7azDSvnjDRkfTXEIUW8rYzYuJFWvtP/xCQhfuhxoRl7RhljKbGON2ruQrt2PyHzb4Py3UzGoHsqVdcW5BwNjGsMKAbwfihARqwuRlUK9+Kza0f8Cdz3QGOoJLyvlh92wEfRhXbPg4c8VjnBVlZJUpXkbBQKBC3Af1Cu5fAPFWpaf4c7uzdK5vWr7lSlt0AfebmCoBixPzkNTt2iiERoTQdNOaZrKAWd0biXkz2uDLA7cR15SDu9aKeouEVBHBBWPC8M1hJqTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6zmzHA9WzjJRLgYYrbxRXjIcXs1KkVIAKL0ZDk5yFY=;
 b=yZgfLod7ubIBA8UbrN0o4Mnmu5oDncdqcjkCEWvd8oJ4lsO8lL/IQBZeGPSd0FbK2SlhhZOYc8l6cHGuiL24rWNwz0xFERnpUxLgmrzmX8adhs7zozfF9hWPih8tbc0sphH2AMrg3UUZFxCXtr/JDKBSBSkQTjhIi5Kq16PjfzU=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 24 Jul
 2023 00:43:54 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:254:cafe::7e) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24 via Frontend
 Transport; Mon, 24 Jul 2023 00:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 00:43:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 19:43:52 -0500
From:   Yunxiang Li <Yunxiang.Li@amd.com>
To:     <stable@vger.kernel.org>
CC:     Yunxiang Li <Yunxiang.Li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.4.y] drm/ttm: fix bulk_move corruption when adding a entry
Date:   Sun, 23 Jul 2023 20:43:26 -0400
Message-ID: <20230724004330.1320-1-Yunxiang.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0db13d-8f04-41e0-222f-08db8bdf0e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI8nymXtNZf41PxsKlAzwdXcynesdksVTknwTwWbTNQA1U17R6kZQelhOCDHIJOn0VxnooY2LWEg/eskYvVJIqH6pb50s/FLEgFAyC5y6hCeEtOQQGDWIZxY8QnrmTaXLjs76LAMYUOsu2iysORPM/7ojycyH40iGX19ZVIi9XyBr0yratFAGsvpYkTWf8y6VLjBBSg5noKbD1SeRAY167yc3Y29dH7CZvAMGWGAjK1IC98cXTMGK4EpTBNcaMtPoW/JE+75uu5st02Cn8597ITKOnFYXi6JGe+/hA/4ZQefM8aFaWojmkB8YRc0ZofrJrEdOWkz+XOowv2Zt5WJeutMPiX/5R0f/3dbBvsZBrG7I3laRk/eAPJbvkh20xyAMJ5WiG+LSqM+DRQ963hx8IkJ0nKPKWxSKMzbbau0qdxhuDFLuPh6Fx/DM2yyaCIDbTi2Ix4dkjz/+z8Z/0E87SYmbKzTZHIJg1zD7sX3XFIf6peUrmhaANljbZGer/efvKNi6NTd9n9VcFAywyOBvQj12LaUEwDjp/5s88fvvXlRr4xWwrvtCs8rFfvRYUP67TC42oPvlMPgazGP6kV9mca5mHDcJ+NVGFOFPm7NeGMktqRaTuk+iAZjoqlJ/VsyNzNgeAw2bRfDCioZdku+taxrbAELuPzrpWVT+jQjS1dALOsvQ8zw3rUR9Jq2KJPp8Ha4vge5zEUjpDSjzNy7DzC85bqHfzC399o0aim6Pnc2pS4Nsumf+NGAe1oReQ9H
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(1076003)(966005)(70206006)(36756003)(54906003)(5660300002)(70586007)(81166007)(8676002)(316002)(41300700001)(86362001)(4326008)(6916009)(8936002)(2906002)(6666004)(82740400003)(478600001)(356005)(2616005)(83380400001)(26005)(36860700001)(336012)(47076005)(426003)(186003)(16526019)(66574015)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 00:43:53.7490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0db13d-8f04-41e0-222f-08db8bdf0e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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
index 7333f7a87a2f..46ff9c75bb12 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -86,6 +86,8 @@ static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
 				       struct ttm_resource *res)
 {
 	if (pos->last != res) {
+		if (pos->first == res)
+			pos->first = list_next_entry(res, lru);
 		list_move(&res->lru, &pos->last->lru);
 		pos->last = res;
 	}
@@ -111,7 +113,8 @@ static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
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

