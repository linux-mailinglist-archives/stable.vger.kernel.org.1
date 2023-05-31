Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D478B718871
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEaR1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEaR1N (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 13:27:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42569184
        for <stable@vger.kernel.org>; Wed, 31 May 2023 10:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOBWivdZbz4QoLNfrKBXrLp7XU/EmjOWd4/ynQ4OiPUJ5XiqqSNf/cuXZcvFZyUprkSASqEu7wQ7kLDpuTOqYT0HDGMxnalK4gFu/HS81ISrASPnzgPrCFLXTLuq+EsTr0WDWPzyRc0VBlgXnBOO6+te5gMevED9N6nFlTnnQS09w0lmtWrTbIZdGAhF3SgnhiYf5QwYfU752rJFtYb7kjl1dWU+4IcFAO0j61bFgt+2KGXCwmf4HNCETExVgqRzGTATw2MOLXYKMewe/WKBjoy08hd9ftS+BnrHaGh1bCH5EX1NnTeA27c8zy8P8AL3mKGQ5crQczCTioZI8KJLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDChmQZmVSeXCopVuEmLgMrVWEABsZn7xG8KPMi89xg=;
 b=d2IKulPsIqfK2l4FYrrZ2bZcOc2ZMHOFws0lNIUzgye6LvsN8kNJuKFYLY8/C7YCfHnoM2vyi+Nh/EcFDb9rfiISPOElplfpj6+Bq/xtrKfHR+2xcyxCo91Jza4PWW8E4eK+9ciHTcwDgw6KMDjVYJsC54FvF6smy+43QGfFYiFXyHMiXCL+2whExsIEiEKpjhPEeZyrEmUHCytENhwX0LSS49NN3o9Vg5PdWQmsVVYJaxieJlspN1u+yZe+1zgy5HweNuy9paSTuERaDHJgf55T7zXtjAlBg8kuan3gIu4O1dYpiR4owQylroWGZ86yQf69NAdiLP28JNgKvgLbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDChmQZmVSeXCopVuEmLgMrVWEABsZn7xG8KPMi89xg=;
 b=tzkg0EMfwJfLZamVRZjYX4xnLWv2ocbul7vQf48PJAlzJiTgkEJA0ElDaVjrFQlb8ZSMGH3bj82Z4SHayB2oikYICsucI7w1FzR0YfNwP2H/W+4nIuUQcbDzP6/Sqpuv8UOpBSZslYhnHOm60CxiPMMiuYBo7NfrWPPiQm5Esoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 17:27:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 17:27:06 +0000
Message-ID: <14df2f2b-21cf-5204-9826-698be6ccab90@amd.com>
Date:   Wed, 31 May 2023 12:27:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     stable@vger.kernel.org
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: S0ix guard rails for amdgpu in 6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cebcad-4099-46b6-8bd5-08db61fc4137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lgj5Zy7x8s2fmv2N6z7JqCn6qyDjwkUNEPyHGt09v2rYb276KCw1L9Kv/a+tWZPsmtYY00uYT5e1J7VAe3TO1vP+VDvg61zzJ5rLXRFR1UhIC+xEGMzwMgK0eckrYL2C7tqw7U4uzq/fmBB+r43Bq6S1ZE/zHUbF/lo+9Oy0fciUeTP32YlXLX7rZoG+G73fNprVHioYcycydNUDCYLK3JxICDfP3UP5WrEGGF1AqRP+K/qVXlWEF4EZuf8w0iyi4Bm9kFAWqzP/Z8baHShxXThjs+BhItm4MS4eLWWgsPBf1UaWXU5ObBKy3Q6XdTCKztIyRlN6ZfLIl5Lv31qNecQ2X3u4VNhfnuUEP9wi8rLcyFZWSmlRddW4gQAHlncLMvFx1DgZJ5M9Twi1di3rti29e67Vog3jLfYn/EClQgdGCqsKeOk1+Zj4/X/k8XbNf2/VfEVitulRS1CbcDRANruw4E324rHNPhkWVBZMVcpHv3GfWZFz8HAERn55kkApmTg6GcFi0g5cpQf3OOUxqn9FnA6VxDv1IostK5bN8sEbvDp+1r1heX3rrK4yHTOJU0FTHezzdXJmd4U05sNme7T5Cb+mW/eghZZKgcFBl8wcbaqXi9386u+vXZXOTC6u30hhQYmJ6I1ckgmbE2e/wZoT2pQQpheyL0h6rjfIYaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(6486002)(6916009)(86362001)(66556008)(5660300002)(66946007)(66476007)(478600001)(41300700001)(31686004)(8676002)(8936002)(31696002)(6666004)(316002)(6512007)(6506007)(26005)(186003)(83380400001)(4744005)(2906002)(2616005)(36756003)(38100700002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhHbVNuYjVta0ZPRThJMGs0bXYvSDJMcWluckE5UVpwMGlybXdNS0JQTW5T?=
 =?utf-8?B?WDBUcEpUSFdUcGlDN3E1TUQxZm82aHNPeDJUVVl5NG1FQkRTMHRnSFQ4NllQ?=
 =?utf-8?B?NENaQ05GNC9PaFFmZXlva0U0Y1dJR3N2UlNZNXJnM3ZndU9NYk9xUW5Kc1dV?=
 =?utf-8?B?YmZvMUFVMVdKMUgzVzA2OEtKNWc5dDl3emRFTVhLVzFscHoxc3VzZTFlR3dq?=
 =?utf-8?B?SlMzck13aE1IS3htVWpUT05BN1czV1k4MFhVNU1zMmxsdzlXYzZJWEhja3Jt?=
 =?utf-8?B?RDQ3QUgxUTMxS3diNFFYa0lseUdIaGNJdHFPUFhQK09aaVMzS0tFa1NuMkkz?=
 =?utf-8?B?RVFETU5uS2ZhV1VpWkl4U1RXMUNXZG9YUXNTWS9GelFEWWVlbE5kcjI0SkRW?=
 =?utf-8?B?T3FGdGlJWHlVaHhJQlNhSjZLYklPNVo2bTc2SzhHbnM3MDZ1RHhVdVRHOGhD?=
 =?utf-8?B?SkRkQVBKNzZZMzBUazducFF4dmEzaVJIU2U3aHBONmNCaXcwdWY4TGt3djE5?=
 =?utf-8?B?YmpVWjZpQnhXSXhQSWJpVnJuVjc3KzN0U1RXREljUEdLb0hCOFlTek94QjZJ?=
 =?utf-8?B?NDIyOFpacVJjQ24rbFlwRHBiaUhPWWVEeElQeDFBamdZdjhxRTF1cUlDaURh?=
 =?utf-8?B?NjFmNEtvWXR2eHNIVWM1WnRCNDhCR25nNHdiRmVFeUlzeXc4VnFUbXorM0I2?=
 =?utf-8?B?RjVGVEZkaHRuTGJiVjRtTEdkQWRPanVtMEl0a0NtdVhQU3ZubU9TRFZQRW1J?=
 =?utf-8?B?ZVNIVVVuUU9YbDdjbTN5b1dmaTQ3S1NmeXRzSkRtVVdzV25nOHBLbFkxc2k4?=
 =?utf-8?B?QlpQOTBPaFFlWTN1bjFpMzY4dm84Y0VYcUV6MU5mdHRWNXBDQ29VMkRjYjBO?=
 =?utf-8?B?SnZITml3b0c2MWN0eC9pZlUvVHRCSzMxL29lK01WYStIb1pweTRGeHJWNEM3?=
 =?utf-8?B?UWZWbk05VlNHZzlIS0lKSCt6ZmJvQ0V4Q21lT0g2ZzA2K2M4d3NJREFVS1dN?=
 =?utf-8?B?NGhaS0RuU2JOR0VOZW1mMzBZaVRtOXJOVGdvb0FBNnhqek12V3ROQkFmem03?=
 =?utf-8?B?bCtWQ2lyd3V1VU5oejIyQXdUNStUcFQ2QUxRY2t4N3JEVjRTL3BQUEhCOWVI?=
 =?utf-8?B?OHQzTlhzekcrd2pjQUpJaDh3cWFmTU5OZTdpdUZrb2J4RUVhdmNXdGdKVW4y?=
 =?utf-8?B?cHQvTWFOSThlTTczZDVhWGltZC9QTVlIWEMxRkoyRWdrTVRydysrejRvOU1z?=
 =?utf-8?B?WmsyN3grQythRnJOTlJWSUs4a3FMMklNdERoSGFXRlE4WDh6c05uRnlxYjNF?=
 =?utf-8?B?U0p0dzJnZVdyNlJwMFFNVm1HamhYVzVEaEVGRWdnaHVvemp2WEdsNDRHWWlJ?=
 =?utf-8?B?OUJxLzhCWWRrbFIxeVlEZjdtQWtLQ1VPZ3dMc1pMRm8rV3VxeDJCZnJSZlI2?=
 =?utf-8?B?ditzYUd2c1VaTFVuTi9rVFR5MDMxWVZZNGhGRi9wWW4wakhhdDBXQjJ3dDdo?=
 =?utf-8?B?b2Q5OTk0bCs5RGRlRTBoT3pSQnVqdnIwSE1wOStkb21KVDdleE54M0pQNk5z?=
 =?utf-8?B?MUdPNnQyMEhmMkxEdlpmTEdONmxNOGhYV3FPdmgvb25EbkhNNFp6dmFXTHc1?=
 =?utf-8?B?QmNQSDNwTERjcThkemxTeklleE03ZlRSaldOeHE5SHdZZTRBUjMxZkFIaU5G?=
 =?utf-8?B?MXMwam1WRkVDQzFObHl2d3ZuTkcrQzdrUHZaVzgya1ZOMnE2QWpXeE1TTUkz?=
 =?utf-8?B?SlFrS2JveWE4TlN5czNMZUg2WlpqQTF2b1VEcnZEK3JwUmkyZ1NvNlVrY1hy?=
 =?utf-8?B?WnFiNDhaTlBXbHRVbU5UclR0VWswc3FYc1FYdHU3TjdOWUVlUXFFcmVkZG9I?=
 =?utf-8?B?SldnS1Bwb2dIcDRtTitWWjlGV0hXV0RlK3NvZ2R4dSsvK3d4ZEJKdXJ6eVZv?=
 =?utf-8?B?bkJmVDVNNDBoVGF1N3J4RHRKc21wc0h5NmR5SmFQNHVSS0YxaEZSUXh6ZERT?=
 =?utf-8?B?UXB0MkVuaFZGcmVSY0hSYUR1bElhM0tDYW1GUTRybkV2T1JQemNaRFBDeGNh?=
 =?utf-8?B?YU5QU3pMT0xhejB6K3JidXdmQmVJcExCekVrUWxhODl5R1BDYWxNQmFvSUI5?=
 =?utf-8?Q?ngtDa+iqYYlWzQKMsgO7V6BOe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cebcad-4099-46b6-8bd5-08db61fc4137
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:27:05.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCBcQCjuj3un3eR5DsX1/Pz2nPD64MccCqd+wFIwSMA0XbgqdF6SN9vEBIl3UGBOhUnNydLgcMYlO01XtTH9Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

Hi,

There is a commit in 6.3 that adds some guard rails to ensure amdgpu 
doesn’t run s2idle flows unless the hardware really supports it.  Can 
you please take this into 6.1.y?

ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")

It is not necessary to take the commit it marks “a fix” in it’s commit 
message, as a problem was found in that commit and it will be reverted 
in the near future.

Thanks,

