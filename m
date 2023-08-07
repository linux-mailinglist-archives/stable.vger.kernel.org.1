Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C14771848
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHGCVz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjHGCVy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:21:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B31986
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpRcFWCdLp7IlJX+C8NonyEk+a62BKNXCso8hf398bAOIjotFF+RFSJa9o7nUmkU6NPO6zKGRvPBFvJhiEd4f9FgncKr2VGY99ctau+8mCm6usYrBRQizNdMlwU3ZRwVZN+Fj64jAi8u5b0Qs0t1wN0FLTYZX7UViem+Jv4MzT2ul2NTWl69bJ8sHDKSYMMga4GNHgr2F//wNSf40X1juU9r0ekLTjCOGGnIu1p+nzGwM2KyKkzAHlVa2u8QHQI3OvaflUc2dtCn0k8q67QFM+rq9Gt1TXmjLeEEyCtK815/CvsJV92QqxdzCMj3jjB3uXKuzonoOIjBQG7x77ohVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET4iwjxOKtl8PZ/DYLTyRAkRX1DOF6+k31wjGKEMuKU=;
 b=Vo5PwRp5rPBA24hKbb3DLI1DY++V8cStY/jPVXwXQc9uNIwQ67T8F1j8sLEKjpZYDpPcTI6AmisoqnNzHZ2Blm8JzzZrFwqMz6RGgbezGeOJMqfdQxuJAJvQuWs+Wks5rDf5VJ8AJZ5KZnvJ5WMqFFLC36U9eRsYDgTRdinVIrAGLsJtTt3wC7hjM1PHjlV/EtEnON7o45yfCDfe9ObHhBmRds+dEGLmxQ7f5I8n/9dQpQqQ9tgSQ4AGCEGKKhXJVVdqWC6owLvTYaxNwVcDq1eTyK9Hg3egfoBFhzfl7yQQIz9AEy3OHfltEV/0brS8lOFiI0Z1kc1VJ/HRuUKgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET4iwjxOKtl8PZ/DYLTyRAkRX1DOF6+k31wjGKEMuKU=;
 b=Pwvehl1MpSvPpAPk+VmHMO/0gMcAuV06n9uraBWRoTMeXlK4Ulvk8i1u5ImH7jJZlkdwJjH7zgEq0DFTu0kZmacqRT29WzC3dwiVERTAb5aQ/iRlTWLkqyGzELf5i3Ln1bfrAE0Lwp/7p4UXXv1+vJHTUbRABowLL1A+scOHhlU=
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:21:43 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::fa) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 7 Aug 2023 02:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 02:21:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 6 Aug
 2023 21:21:44 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 6 Aug 2023 21:21:43 -0500
From:   tiancyin <tianci.yin@amd.com>
To:     <stable@vger.kernel.org>
CC:     Tianci Yin <tianci.yin@amd.com>
Subject: [PATCH 6.1.y 10/10] Revert "drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2"
Date:   Mon, 7 Aug 2023 10:20:55 +0800
Message-ID: <20230807022055.2798020-10-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807022055.2798020-1-tianci.yin@amd.com>
References: <20230807022055.2798020-1-tianci.yin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 129e23a6-2dfa-45ee-8dff-08db96ed0beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKMwfOeUrK108P+ZWgu9hHu0H8tchWCkUVJenCNMRNV4e6T1zFbZytCg5undLNmnjewiwJWm8Z97dO7imVnSsNvEAQyCPPH/eUo8zy+VQDpVntOPEOOJ87Av5186GqlJ8daUCOFXsVfjmagThL8ZYf/CudpOCvTwcsvxOsRqEnhXgnho1I7OagLFNuwGdhLuLnWANpzq10MxhY7BAiqcQSIjkopKlOyNY0TJpqFJ290AA3GGFszZ3N5mmmN0mZWWK/oQJuFWinashZ9XPCSrWjqw2YSKeqgtakR/WXaqUcwqSZo8EhugLcJYXCXmEorMRr9wx13x+DW7tnJSjdv1TvyVe1TtkBOUxtyUC7Y2ZrcZj042DUi7jsYBafKuejL8yHs3YtDN+2rhGaycF7UkzbXX8ur87WDVUKIUyqTgExeL3OlUzxaLX/A2z7AT4hJS3Dv9mARqHECuQJyP3X0QB5fISB7orhee3tdhwEjoLwQ7tRaKnJyoQ3wfKv93+ZHuf4xaLHKfxD0fmekH9NUOtNVjUtosZOaZU6u3e+nW7RD0Ddzplg9VIC/pLq/thlJNttiRvAQtz+YSG+3/Ypj/0aJK9/g8wj1ZVZ0uwY/KYk9XXWJxw2jxIcpDYEx1d6zzw0W5uVIxKzALfQfTlU8ceLC6UyjF2oXVn4b7xJ8rA4ImGaeb+UJaONcH5/AJgdCFeSnajU+N7VnSX0jVu8p1A640UhM5+it5C5PwcSjWwgnVqmbJAJA4/z/UvYOtIl3qQHnyDuACrpswd3Za/rS/+NM3CQ03Ilv2rj+sY7XGxKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39850400004)(346002)(451199021)(82310400008)(186006)(1800799003)(40470700004)(46966006)(36840700001)(40480700001)(336012)(40460700003)(2616005)(36756003)(4326008)(316002)(6916009)(86362001)(478600001)(81166007)(356005)(70206006)(6666004)(70586007)(7696005)(82740400003)(41300700001)(1076003)(26005)(426003)(8936002)(8676002)(47076005)(4744005)(36860700001)(2906002)(5660300002)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 02:21:45.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129e23a6-2dfa-45ee-8dff-08db96ed0beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This reverts commit a2ef3163c3604788abdc060cab74c95ed44fec1a.
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f5fa7abd97fc..2f4afe40f3e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1165,6 +1165,10 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
+	// For phantom pipes, use the same programming as the main pipes
+	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
+	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
-- 
2.34.1

