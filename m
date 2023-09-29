Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0427B2CBD
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 09:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjI2HAw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2HAv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 03:00:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DBA1A8
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 00:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLpwiNP4joLSqMfgpSG/v/BUUFsARLttvWLZr1EDNdniHEYempKCYZOcQ55HjhdqQbozmNIdD3qj4iomqaa6NEv45ZGY838/KIJrzE+Vs2OcbP9i2RanS1zB8r80camyNMJWhQDFsjrpDQmUVyG0rfFKvjOv8pLlhQ3wAeil/6a0nJNH5BvRkBsRBLv2DB1IA/vtUdiGp+aTKD1Q1ZcNCW+Ip5ane2jPmsoak4Xuvgohc0vURRJvmUB9ENx7li6be13dGwye6paaJ4/PNIO8ulPC1yHXF0dgGA8ZeilKCHYlxf992wFf6BEIJNSqgbk4m990soYSoNeiwVVXM0E9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+hFvd97sMu3/BHJc7aBwF1iCMV4G4HLqQdemUL1aVM=;
 b=mllYsBLoIKLG0wKsJJy476ADvPPB0SFen7gCUV+U71DFJQzs7Rv/JuXIGxcN/ybX8hEgKVSNmxXV5vyqXmxKQ21tA1dhEhQAqMaEzcE9BIGjJa3P6JMeAGIGP0lsgGfM8QlEa9/0V0ViUC8yrESS/gBwtQJQ4SMT5fkcX5Bxu9G3PYuzsTqMp/YBVSeFZJTSbqkfsVmtEwvsRM2vUdi8kPIb9Q1BSXUkOhwqNz1wsqYJuB9XiAsXfUctQC/YyHIH/zT3VwNqZH/X16MPipjBHd8uOCQxBa2mIfy/x6osQcT49Iuon7dejsC2ZEmlt4lnRl+CoFzPIdneC6AOP7aCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+hFvd97sMu3/BHJc7aBwF1iCMV4G4HLqQdemUL1aVM=;
 b=b8qPfuA0x8+btDrlmeK9FQwX6kLnV7Ch3AOt+lB7oqzHR/0yKvFX7gF9l8lmp9H3jsGCyErNQGi6IwP1nv3NnrF2oVcEeveic7uTbbHV0cEYPR0GfYU2sthrbVaW7MdTjvXveKztR6ONj2tmRqc/2J9o3yh4yQMxZmZzY8+lb9E=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 07:00:44 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::cf) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Fri, 29 Sep 2023 07:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 07:00:44 +0000
Received: from andbang9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 02:00:39 -0500
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
Subject: [PATCH v2 1/1] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
Date:   Fri, 29 Sep 2023 12:30:24 +0530
Message-ID: <0a535fc59c3ec89b52ef76574232fab8457ebd7e.1695970674.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM4PR12MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c9fd69-70d9-4c3f-37f0-08dbc0b9cd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQPhUpCshWMhRicKfLEP7U4Qu2uFJl/8efCr/uIrA0tRolX6S233dOGqykRcNShbyE10Xm0itpC4dSN8xnhx50W7Z1JO2mDJQuMFzF6z6l24Jy6yCdcnXPLxS9J82gDe+OEHuuXpunaHoHX0xQ8UGYkVKptd7olkn7pyKNszjJkbrg/HpqdlLfJ7E2zDWNTSvSnMsn/ODX/axTb9l6m/ob3INBvt/5N8Cp3s3L8DIpDRvW+SWTRZKwH7p5/AmdEgXCpdCc96LjTjBJuszfddC6RfbnJghshMp2jY1d1ipSya4P8TdZn/9ac3tdLAH52Cgf+QSQoKjJLQkSt5a///ElG+b8bJzOnPmxJiRp8mtP9m6NtzpaO1wPuSQm7NzBD5JFZa2mPtHfE8XgliHjt8G88BGcnGRb/RfVIKAKflFDJKGujvTo4/CZq3ZfEvl13a90x/hvXCHb7d/PeZJjSlolhOlIIqeVu4KAC/EnSOhagwJfmk7OL6+S3kLDjZBCe7nVv5JOHADomaM38fndvqsRMZkWhIYuETLPOnRjgbwScnwmRs1vJ0mBfYsfMvjPpFEwF7Wc+csLdL9N4rY5LIqGmjCjDVBtnyP9OuXFBpllokGfclpAGsBQm82lT2KV82nZ+hTKthXyABz74kTUBEwggkW5k7NE234DuDzPtxSMb/UCvsG13m4hejNQrrohChhDjvnLpJ+BbiL6yHi6kAuYCWMQ9WS/wvTZFjOctbe0dElOvKNwoMLmZzRUk82qsVIqwwMzqss8LlVMLysWGb6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(316002)(54906003)(8676002)(4326008)(8936002)(41300700001)(26005)(40480700001)(36756003)(2616005)(16526019)(83380400001)(426003)(336012)(70586007)(478600001)(7696005)(6666004)(356005)(82740400003)(81166007)(86362001)(47076005)(36860700001)(70206006)(40460700003)(110136005)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 07:00:44.2295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c9fd69-70d9-4c3f-37f0-08dbc0b9cd02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

To fix this issue, treat decrement of sess->refcount and removal of
'sess' from session list in destroy_session() as a critical section, so
that it is executed atomically.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
v2:
* Introduced kref_put_mutex() as suggested by Sumit Garg.

 drivers/tee/amdtee/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 372d64756ed6..3c15f6a9e91c 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 	return rc;
 }

+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);

-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
 	kfree(sess);
@@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		goto out;
 	}

@@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);

-	kref_put(&sess->refcount, destroy_session);
+	kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);

 	return 0;
 }
--
2.25.1

