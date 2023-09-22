Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53D7AA98F
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjIVG4U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 02:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjIVG4T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 02:56:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D87818F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 23:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYY3oinmWOH/nsO6piGtqbUUuQXSWCC3m1ck/X8KY8mq6BabQD6CpAHSLsCC3k5dgf8SQ8iaqaHchHfZFzk5NP2AA3UI6bDhojOlnqUFHI3QCAgD68i6eorH45gG5Hf7Bc+7Gcqdoc1mPmun7J8Jcq2D/sG17zvsRSRo0OA0sWQUAu2JJRuJkNMEiQoVzdEPeUpiuJmEiM8VYQTlCOzY+hzqm2AK8xa7Vw3H5ocheTKxTCD1MI6hmV6Goi80/vlRAa/cYUR4eaGmkUCIvf9SIj0lViUeNnTmuohE0RwW9rsKlcQV/I+7x/MC/cfNHMDOD7xquAupRYSsgPjOVrt5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISZlM8Z9lhWOWA/8qR4N9NlOFRWAmWW3M+dxNF5ECBI=;
 b=Cf1VHzDi95arLTJfebusyoAa67RmqraH4l89l7sA794b+KkzVlNr85PPPnyPJkpZxtDKEsDSJV/Ua5q5jDrtzOAN1Q/OtmYthLhzgOVcaZ09hhbZqCi6Va9hAAflFwEb1YMiArsu1NZxq09b7nk4oGZqd60X3tIMWFuJ4SXQRQgQGr9EU2l1J04y75Lab7TkdVOLbiZ1HmgU3qhkmXJav1v/SrxJLHCePnMvojV+L8G2RfXqD0We9J50La7Pb99WyUToXl7vcwolMNzzPle/ksh3/7WsY0dw8MERNZF8l7OE15WMIoqWgjrZii0QKrFiOlNwT16PVW092IIZEN3V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISZlM8Z9lhWOWA/8qR4N9NlOFRWAmWW3M+dxNF5ECBI=;
 b=Ah6bVzdMtsCYYmBROrX3d50EH6wciacASf2p1AQIDZKfl0veVErgWFx/nsDyd05FlRVDz6VG3JdpEMMY5gMKA08Q363iuMrmxtCFMqVAIy5wrcvocVijvztS+Kc86r7wYPIqQAi9z/QmjKmfiAdNr/CtghOhOq/IKtLdsebgnf0=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 06:56:06 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::1e) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 06:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 06:56:06 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 01:55:48 -0500
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <op-tee@lists.trustedfirmware.org>
CC:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/1] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
Date:   Fri, 22 Sep 2023 12:25:13 +0530
Message-ID: <6a829fb24c6b680275a08edf883ee458a9cab011.1695365438.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e125cbc-1205-4937-7da6-08dbbb38fe60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg+lC+p1V6dsYig2Fu6vtbZEgpm1QQaCY8FP1RFjLJqqyAckBEUXePss8GKkTYpGFVwkTZbXDeLNF/DOl7WK5CDg7hhn/HLbUXueMUlyF/q5tIVXnbqKZ3RUDAhnBuQmW4aZVWlATVvmPCy8xoxs15aCflUBQ0+SEx8I/aFg2m2mpkJ9UhTywwng0bojvHCRbDr6ClVxcUgXWiPd2QUY0IusK9ZhVWaYSK45Cs7YzTe3M7zACasY0ZIo+XVu3WKBELlIYNmCL0Gq+FYp2m+Hf/R6m+4IYosszpNSqhLYVjT8fuY7d83sBPyyz87k3dSVGuJIPgd4WmHCAzlll6yGfHUpKIvCarthAVyXCqDlSWVk/thZOvEgpARIb9kRFFQw9WkTWPaTKNjE4w2gbtelTeGp7wumOQUFel2jfLBzo+AQLaZ55k5+D7nmFlh80XyGHUB08AdjN25k7ngJzs88gF3QiZZP4KPC8jzzfRJW17/+zDMAM93TSwIyzYsCHCfNDHsIC9zTuR+7G1fbVdr/p8NdK28WK/6pfSLUeoVyPkw35devYbhc4EsJJIvPOdTfE7njkz4R5UBMIAHNSOuCiKjyHhkOHdbdYvcafAPIijeoGB9tb115lthQqfnU2k7Nhf4eDCuygUeIAVDZv5Vr3JQanXXFrIM8Y/k56Ett8d5SZ3vklrWSapikjfJt46AR9uIEdcwN3+XbJDIxt7Ci0mNMWypt6v+gV0tqcpO55wa5TciUDY3F3Q9EXUczTgBJE2z4KiDCZCz5lUKgsNtzkMHApL8TRPaIofgHRM8JS9YbuwRQeFPhfDsJgza8p5AH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(82310400011)(451199024)(230921699003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(70206006)(41300700001)(8936002)(54906003)(316002)(70586007)(110136005)(478600001)(6666004)(8676002)(7696005)(26005)(16526019)(336012)(426003)(2616005)(40460700003)(4326008)(83380400001)(82740400003)(36756003)(81166007)(356005)(86362001)(40480700001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:06.2887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e125cbc-1205-4937-7da6-08dbbb38fe60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

There is a potential race condition in amdtee_close_session that may
cause use-after-free in amdtee_open_session. For instance, if a session
has refcount == 1, and one thread tries to free this session via:

    kref_put(&sess->refcount, destroy_session);

the reference count will get decremented, and the next step would be to
call destroy_session(). However, if in another thread,
amdtee_open_session() is called before destroy_session() has completed
execution, alloc_session() may return 'sess' that will be freed up
later in destroy_session() leading to use-after-free in
amdtee_open_session.

To fix this issue, treat decrement of sess->refcount and invocation of
destroy_session() as a single critical section, so that it is executed
atomically.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..04cee03bec9d 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,14 +217,13 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 	return rc;
 }
 
+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
-	mutex_unlock(&session_list_mutex);
 	kfree(sess);
 }
 
@@ -272,7 +271,9 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
+		mutex_lock(&session_list_mutex);
 		kref_put(&sess->refcount, destroy_session);
+		mutex_unlock(&session_list_mutex);
 		goto out;
 	}
 
@@ -290,7 +291,9 @@ int amdtee_open_session(struct tee_context *ctx,
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
+		mutex_lock(&session_list_mutex);
 		kref_put(&sess->refcount, destroy_session);
+		mutex_unlock(&session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +334,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);
 
+	mutex_lock(&session_list_mutex);
 	kref_put(&sess->refcount, destroy_session);
+	mutex_unlock(&session_list_mutex);
 
 	return 0;
 }
-- 
2.25.1

