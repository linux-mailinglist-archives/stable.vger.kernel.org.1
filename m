Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9B7E6CAE
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjKIOyr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 09:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOyq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 09:54:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE035A0
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699541684; x=1731077684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lo07P0DLDCd1F/3cNRFO8AdRkqKRNpvljs5oz6grkpA=;
  b=LOmEDfF5HuKB/WfeGNov+WYjW/1LvXWDpEjSdlUB00mrTUmtpGMBj9FX
   sm01Wpe/Kdl54Ex/IlQ4dMyJSe7toqsI7tJU9KAHCvKHQRs5webUGhCWF
   sLzuEsI7wTDrPbadoK3t2+jfIq1ghRHxnybHP5q6G5WJ5dQKH9sig+T1n
   kGirTt0wTwJo59AWt26Ei+6i193NBKTvhZ0/aqISh1l0aMLbtQ4Pv9ZRI
   0ZCSFvXWtpDL176j4SU2S2UY92lkhXWFmCb9l97/odn1EwJrjGbMrcknG
   adhbzTvdkX4HD8HmyPjTN8WgHGo+n7WHk7QhXo29268Jw8uqtYFAC7njv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11545132"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11545132"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 06:54:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4734788"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 06:54:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 06:54:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 06:54:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 06:54:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 06:54:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxK3957JHdewqfPAax9qe5pQMO+7uM4fciKsl6xv19m8iB57mIHl7PEFON5ULZex6CM7am+N3M/wZEv0kzdPisbYMM+cLTLkHVR+R8XRJ2MPJe3sLD/LkuE/bBZPolRvSHfka2oOoHNqaHpf2Q1BTdTuTUFiS5frVkiREHw/kJTpFiepBhxyPLHbNGviI3YffVTKYuIup1r5WIqkW36A3kwj4p++FvtrQZ+RyFPelPPWBUoljvUAqMDzr7uf/Lq0qFF1aKpO27+Nq8dLIIcfe/PqGyctW8jODtaYYua8qXT85i5qjYo+Q3FToP7lCV9k8yFVWnzfnTnU+rqq31Krlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIMatRmFPNyHcrzqRuqwWqatszJGf3BJqejG/0eAbHw=;
 b=K5GfLKCJ0mJE0Ux5bteiL/j9r7MeT9CIwaBDl/kl896dJdQDusoAb8F6eSmLAPiZTk8y0YQynuSJ+byxweQa5WtoH5Xb+VPsYtbyLi8EaA2MFf671uekkjgvN+dfGiss6diK7Ps6kndLoI2nIcKd/YD+rCkUxIzSMTvPqnDkYsna1odECv8EsC2RKk9eCBfahQXG0NPbx8gLgMFyl4V8B4ZZZuhrf/tMw8BKFXGo5FuMaZkDOTWsFNefcujXL87NuxJSdxzHAVNdvGyCI6lyrKCzXd5P+pvEZO/GfDX1peegDbpWtXLO0BKogvTyNdu2j1duWE7gJ3x0mHt++lc4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:54:39 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::ada2:f954:a3a5:6179]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::ada2:f954:a3a5:6179%5]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 14:54:39 +0000
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     <intel-xe@lists.freedesktop.org>
CC:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunxiang Li <Yunxiang.Li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 12/20] dma-buf: add dma_fence_timestamp helper
Date:   Thu, 9 Nov 2023 09:53:30 -0500
Message-ID: <20231109145347.345120-13-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109145347.345120-1-rodrigo.vivi@intel.com>
References: <20231109145347.345120-1-rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|IA1PR11MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 24feffd1-423a-4838-2ec4-08dbe133cc94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnxOpf6L70O1FiD7HfcMiyPyYocAtPO3z12iMzfQslOVCi8CVcP67Pb/xwS1ILLjFpL8zRDAsfNacjYSKNKq571BBzW0cmLu62App5mynubLd/DAMn4+iuYDBqayIIpP397+HSuWzaw24kZ+CRxZzRzsGDmtWu1tq9rNuyZP61yP+iHMknan+9j0Lj0cWd/mN3NL6rLJpJxum6lGOi2ItMHF45OhAXvj4QFd9bLCnBLEwqq/aoEIyyS/aVkERDgmbayCxy6rZPm7DsbA8O0U6QOThcFeQhf+JJvv1xn//QOTIPg4yfEerACvYdguR5sFPPVrDrzAia1m6aJm8pABkTf4CLLWnG+XhAm88MabtgmUcE7tbC/5G5cWUu5hwX/zjdwGferXCmPoPhfuySZ4aPr2/Mob4oeXfv8OSEyLr83lRLFMV6PAze9LyJ35jN+tEXIqdafmhreN/+9lYd2cpc4x96f8jova6686zVk8SAbzc0KS8Rnzjt+14Bn/S7KFCmPq0J7xeXbzCLQYECpVT8ZncoyF44wBeAHn2N3QhZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(2906002)(82960400001)(41300700001)(8676002)(8936002)(38100700002)(478600001)(966005)(4326008)(6666004)(6486002)(44832011)(86362001)(6506007)(2616005)(66556008)(66946007)(66476007)(316002)(107886003)(6916009)(54906003)(5660300002)(1076003)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xBd09pTVpzUVhUZlNNN1ZOTjVKUi95WHhVR2lOQ09jVUJoVGU4dUp5UVR2?=
 =?utf-8?B?VkJsV2Z1aklGbk8vczlXTU83Z2NWOUlBMW41RnQ1UGVpQUdMZHlNNUlxM0w5?=
 =?utf-8?B?UTByam83RGVyUEh5ZUF4MTZJVTc4OXBPUEpOa0ZiZSt3aWlBZHhvYXBlSWpn?=
 =?utf-8?B?YXc5cWlRcWRiT1dGY1RYMnJYajRkZFFIV2Z4cXBsWWp5RUJSdnNVY0d1ekl1?=
 =?utf-8?B?UFlnZnpRbnVtcWltN2tqcEJDei9zVFplQXc3M1EvR1BCVURjZU1RSWluRHg5?=
 =?utf-8?B?NFlKVStFbzczeTRuOUxJcjRWRzlSUXNXSkpQRmF2QkgzN0RzOHBvcUVINDk5?=
 =?utf-8?B?SDF0Z093T0dsdFN6Ty9UTEhHSC96V3UzU0k0MlNsd2IwcGIyU1B2U2xwbGNU?=
 =?utf-8?B?OTdhN0o4TW8vNTJ1ejZiakhWcmdZVG01WlUzSGdoOGUxWGNvNDIyT250UXd5?=
 =?utf-8?B?N05WTFZ1WlpjWi9EdThBWjRnQm1yejZwaDl6c3lsQWZLbndhNCtxazVlM0VX?=
 =?utf-8?B?QjJXcnFKd1pZU29xVTBJWk9lbU5hQUxEc1V5WVNGZUk3WUh4L0YrNUxiR0I0?=
 =?utf-8?B?UVhuRzR3Z2t6UFg0ODY1cm0reGNHR2FFOWs4RjJDb0Y0dzJsMnRiVGRTTkZ2?=
 =?utf-8?B?OHJMQ3RTbkRPVXo2cVBpbDkvc1pRYTZTTEhqN0FIbmM1WUg1MHhsVWYwNU5z?=
 =?utf-8?B?WEF0VGozZysySURaS3l3RDMvTzRLVkVRQkJLWEFHRnVTdG5oUHVQZXpMVDU5?=
 =?utf-8?B?bldyajdJbVVKN1lLT0UvOGlXRklhVkJkeHowQldRc2VsYldmcThhb0JWZDdz?=
 =?utf-8?B?THBXZzRWazFPMFN5L2M4cDNKbFF0ZGI3QW00V1hhdkJRTzJVVTcxMEcvK0Yw?=
 =?utf-8?B?U09hWHBWR2dwUFZuV0Y4dzE4SGMyNGpEVHZTT2tydm5FQXNzcFp6d1FiNlli?=
 =?utf-8?B?TWxCSGxiQ0dnYXBBbytxYkxMSXFMbEVjeVVjTkt2OUdRR3ZXSzkycjFpYXF6?=
 =?utf-8?B?cDlBUmxkS1JIeDJxVE80LzB2WERMR1V0cWtKekNlRlliVWpoUVRmQ01nd0JI?=
 =?utf-8?B?Ykc2SHNEOEwrYTJyM3ROZW9GREdSYzNCMlVWd1o1bHg0UTl2NzJtSEhaZjBs?=
 =?utf-8?B?Q084MGRyVXBQQm56TUlTQkdLY2l4QVllTU50bHM1b2lHejRFeC93dmFDeWxi?=
 =?utf-8?B?UERuSjlCcG1sMEpobkRZdVJXRGNQRSttL2hTUFBFMkV3U3d4VEd1eWZFT3VG?=
 =?utf-8?B?Ry9ubVMzTU84cVlyK3pZUzJVcmVXNmdpWXlWZE1qTjZDOHVFdm1iVUpRQmg0?=
 =?utf-8?B?cDJNQ0dYdXd5YlRxeFYvWFpoREFNenZ0c1hBN0xKUnBWMElGdmFrSzgvY0Rp?=
 =?utf-8?B?ZmtXQ1FZMmpXN0IvT0xkbEIzbjVVZG15UUZyRGJvSVRHM1JsZzZCWDB2MnZG?=
 =?utf-8?B?NGxJK0o0NFVncmVZR2pFUUNVa3BqV25oeWJYUnZrc25LeWZhS2VYdFIrVGNF?=
 =?utf-8?B?RjQ4dlIwYmdhUXdrL1N3UktpVEprZDhZMnJzN3REbkR6b3hzWHVFSnNpSGJH?=
 =?utf-8?B?UmtQT1grb1NYY0p0R0VSaEFkaCtVUWJqc1lhK0hpMHdaTXVkTFgyNnJYdTli?=
 =?utf-8?B?dWNpRUc5UE8xWVVrb2hRcWgxSGFRc1hQZjR5a3I2UDlWdkNRVVRZTGdyc3ZJ?=
 =?utf-8?B?eTBrTTRWaFZ3R0ZZTUF5RTMybFA0WW1TTVJiRkFHTnlUQStZaDRNUE1ZSzE0?=
 =?utf-8?B?aTFBNTA1VDladEl2TmZPUWhpMzk4T0V3cGhtaWZnSjBuanRDMmpzek5ITTJJ?=
 =?utf-8?B?K1RQS0JHRXBmWVR0QUNKZGN4TmtqNU5qQUhCNE04Z3BvT01QWlUxUTJqYmhB?=
 =?utf-8?B?c0dyekQ5WDNRajJGSHNucENDcWpzcDYvbGdmWi94MnI0bnJHS0I4M3JqTkdl?=
 =?utf-8?B?a2I3eDZWUTNsci9nY1ZjTnVYRThsU1o4ejY1UEFTK3M0NFJMbjRwWkVSYU5I?=
 =?utf-8?B?dWFIOHJNUCtWQ1k2WDFmYjB2ei9qSzJDTEZHazZiVWZrR09wRGx0SFlIZVZW?=
 =?utf-8?B?aFRaWVNtbGYzK1NCa252cGdEbVUra1hLMXVLSCtWY0RYZ2ovVGIydjlzcms4?=
 =?utf-8?B?dU9zdmg3MVRnTEZ2MHNLMGxRTUpWUWxZMzcybWFXaUFENEQvSldteC9FYjcr?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24feffd1-423a-4838-2ec4-08dbe133cc94
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:54:39.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZisQ+zX1AkjbJC2rBMu3LeYLZ7C2eTYjnXxaWlXzQAk92m8hhoE4KkEvd0uiCijImfYEt2E5RKjUtwA4k1vquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

When a fence signals there is a very small race window where the timestamp
isn't updated yet. sync_file solves this by busy waiting for the
timestamp to appear, but on other ocassions didn't handled this
correctly.

Provide a dma_fence_timestamp() helper function for this and use it in
all appropriate cases.

Another alternative would be to grab the spinlock when that happens.

v2 by teddy: add a wait parameter to wait for the timestamp to show up, in case
   the accurate timestamp is needed and/or the timestamp is not based on
   ktime (e.g. hw timestamp)
v3 chk: drop the parameter again for unified handling

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 1774baa64f93 ("drm/scheduler: Change scheduled fence track v2")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230929104725.2358-1-christian.koenig@amd.com
(cherry picked from commit 0da611a8702101814257a7c03f6caf0574c83b98)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/dma-buf/dma-fence-unwrap.c     | 13 ++++---------
 drivers/dma-buf/sync_file.c            |  9 +++------
 drivers/gpu/drm/scheduler/sched_main.c |  2 +-
 include/linux/dma-fence.h              | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index c625bb2b5d56..628af51c81af 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -76,16 +76,11 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 		dma_fence_unwrap_for_each(tmp, &iter[i], fences[i]) {
 			if (!dma_fence_is_signaled(tmp)) {
 				++count;
-			} else if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
-					    &tmp->flags)) {
-				if (ktime_after(tmp->timestamp, timestamp))
-					timestamp = tmp->timestamp;
 			} else {
-				/*
-				 * Use the current time if the fence is
-				 * currently signaling.
-				 */
-				timestamp = ktime_get();
+				ktime_t t = dma_fence_timestamp(tmp);
+
+				if (ktime_after(t, timestamp))
+					timestamp = t;
 			}
 		}
 	}
diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..2e9a316c596a 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -268,13 +268,10 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 		sizeof(info->driver_name));
 
 	info->status = dma_fence_get_status(fence);
-	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
-	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
-		cpu_relax();
 	info->timestamp_ns =
-		test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags) ?
-		ktime_to_ns(fence->timestamp) :
-		ktime_set(0, 0);
+		dma_fence_is_signaled(fence) ?
+			ktime_to_ns(dma_fence_timestamp(fence)) :
+			ktime_set(0, 0);
 
 	return info->status;
 }
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index fd755e953487..99797a8c836a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -935,7 +935,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 
 		if (next) {
 			next->s_fence->scheduled.timestamp =
-				job->s_fence->finished.timestamp;
+				dma_fence_timestamp(&job->s_fence->finished);
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 0d678e9a7b24..ebe78bd3d121 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -568,6 +568,25 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
 	fence->error = error;
 }
 
+/**
+ * dma_fence_timestamp - helper to get the completion timestamp of a fence
+ * @fence: fence to get the timestamp from.
+ *
+ * After a fence is signaled the timestamp is updated with the signaling time,
+ * but setting the timestamp can race with tasks waiting for the signaling. This
+ * helper busy waits for the correct timestamp to appear.
+ */
+static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
+{
+	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
+		return ktime_get();
+
+	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
+		cpu_relax();
+
+	return fence->timestamp;
+}
+
 signed long dma_fence_wait_timeout(struct dma_fence *,
 				   bool intr, signed long timeout);
 signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
-- 
2.41.0

