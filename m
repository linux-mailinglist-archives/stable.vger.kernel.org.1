Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE077BD1B
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjHNPcr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjHNPco (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:32:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34EA10D0
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d91jHa/q0nGSNaXoK29Cp3khRGaAosAqBsqBb//n/WP+56JG6uqz6+z7yVKDYDsQUpML1Y8jFH2qnicsJCB+a6VADFFBTCuBrS2imzUiswQxy/LmVGGL5pK1i5rPnBpKcPU51KY+ehKZxsoUSRGJvwfvntKx3xdVY7bSVRc7pp1pLn+VT6TEgikXjcmfL/7SoakOd4Qff6cNY/wpiuiMf/wajjqhsag/IDGSWpjREPDp7AdaSgSfuMv2PJhh55pZCP0a6Cx1D8kPoDs8h/DEh+MNHYM/IvSu67AYDKKqA4LSrK0JGz1znXWeLF5edqZwWS6Q5vAoGW6hflxvgXwDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcynTE3hv+qAiYJkhqDuoaZvF/X5cDnG4KxK+I0J6Bo=;
 b=CNnkO7Q9RrmHEaqRDFvCW0Zd8RRPrcO5QRRpLhQ9X8/YeYZ5m+C+4o1nr+9nlj7TO0ll0JMFlJ0g76Ouc5DyI9Ebq/3bXncv7NAcHVYgswFHPyTPQp6Txys4F31yq70cqpfLRO9h42sWZuXD8OUzpEQQHpCswArC3X56m7oEaVKJbRqi+adHtvU5Jk608WJQ5xJ/YT9/eOsF3DgtmCKjOvNG1EbS0yt0H9YE1mvFT2Kc8DBzu4hliW4OnKbkZDLkM00ECoLt8mpRP1+nGaxPfLbf9Luik4PubEZyDC6TyzX1BUO90u1+lvj2C9WXn/QSECwu/QXpFBIvF5jfJpqISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcynTE3hv+qAiYJkhqDuoaZvF/X5cDnG4KxK+I0J6Bo=;
 b=s97+kZtSiMWVEcQlCF55tto5EvXsdpES6EdYZek0JP2cLq2uV2zd30aDl4Ro6QsLnfHGGM961Xrmq9mBmzhIjh3kg3acWHgPIVE1x+IQ7MgCLz5Z1uZO0ifwpQHZAsuaRj5LgjyFwns501y2FhBTiR941slSx4LvBdDohjEQyCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:32:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 15:32:41 +0000
Message-ID: <d73a3a25-0186-4f07-b7b2-684edd179892@amd.com>
Date:   Mon, 14 Aug 2023 10:32:39 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [6.1.y] Assertion with 7xxx dGPUs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0022.namprd05.prod.outlook.com
 (2603:10b6:803:40::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b45287-a992-429c-0f8b-08db9cdbb2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giugeoL/a/j8bAGg9sStr/oAQ86byJBp8cl4fn9aMMPV1WPaXfXjwGDUovlB2fHZU+2PGft9LbndcKeyvSKdKWf5ig89bdrt3mvN/LExDmUPSN85A77F2PCpcBIcBxc38oNhMDWkSdRLcJdYbXowoLFvcLJGePBAnbXTX063JE9Uz1iNoDvypWUB5Jlpol8+F1Y9IMSW9gxlDh2sRg/tDis/qYnXdP7wtrJj8DowdYOt3SLinQ2hI0sheOvae72bzEI1B/0KQlYDjzEPOj02hoNlyMD+mIK5r6v3bzg02iNsjut+Q+2lPnyas5IkUfsP4s1ua81q98buz51S5p4yNpoZCQDwT2zuyzB3Ii7e2m+gaEUUZIBuI7fdmWTSVAmnSVdYUmAbGhmSuDKTmkxCdjggNYfHEfsasS5PJWDspfNIKQHGuOIH6I8KZ55hqIIOfyT1nXvZ4pXWoRyWxQFn5L2Jk50OmYzXVgp4fDkQ4ThD2EXK0EI3bzrSTnILWFSbw2mLevB1dXzjSsD+e9cToGKBkqG7Q/nr9YjlGvoQcmbWh3Fog7wPzUCgfrnkJm19iC3mxi+X5cP/nrca8MGIvOL6JCp9zmc0SNdanbrwoHDCmXm60qbYmnw8lDJl23bdyr+VdNTe4LG3UuOMYVsw2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(86362001)(31696002)(38100700002)(41300700001)(478600001)(66946007)(6512007)(66476007)(66556008)(316002)(6916009)(966005)(8676002)(8936002)(5660300002)(2616005)(26005)(6506007)(6486002)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZqN3RrU3p0VjExcUJSblhrVnRNS0RCQmRrRnlsRU8xMllYRFR6UUVOQTZi?=
 =?utf-8?B?dVFoa3ZwT0VrK0NkRzV6U25vWVFQdWZmQjdTLzhQZlQ0Z3pRZVlweDN6SkpJ?=
 =?utf-8?B?Yy9Bd04yU0NoODd4WWpiVkVnbzF0QmpNWDNyeFhNRVdUZzlkZE1MTjkxMER2?=
 =?utf-8?B?NXhFMTRLQkVuZ1VrSklLT1JZTGwvU24wYm5KNTNKMmdkd2JHRDNjOTRDWlpS?=
 =?utf-8?B?R0JmU0I2SDAyb2RSdDY4eFhjaDd2R09nTnR5WWNucll5OWFPWks0UHRCK2k3?=
 =?utf-8?B?ckZyT25SSktzQjNCN1ZiMVd1ZVlwM2NZOVlHSmtFMzJoU21LR3JrV201ell4?=
 =?utf-8?B?aGxOaSthYVpweitBQ1VpQlBLNXRwL0dvU1RNMmVLUFJiblNtbVdTUWtraTJK?=
 =?utf-8?B?TWo2djI0MDF0ZGdONE4yNjZ2UmRRWFFkRnBZbGlJeHVpaGNMSnlsWXpKVnlI?=
 =?utf-8?B?UmdYR1Vuck5PSXRSek4zdlpWOFY4VmZBRXJ3MkhPOGxWUkhMUW5FZERwWnhq?=
 =?utf-8?B?U0FsNG1MVExvTHhIK3lnTHA0VWI0cEEvdjlYbitad09HV0Rzd3NOODlESkZQ?=
 =?utf-8?B?cFdidmZIcVFqQkxyQXVYZ3ZndnVrRWVGbzl4dnBHam8zYjhQTlJQVWwwVmV6?=
 =?utf-8?B?bW1QcDMzN1ErYVRIQmEydjlwMXZxcktLVm8zbzJzeEJlNHdSNXN1Q1lsSWhS?=
 =?utf-8?B?Z0xuWFJjRmdXUEFxNWdQQ2t5NkxyZnlpQkxUckRkSVc4c2FWWXV6SjFOUUsw?=
 =?utf-8?B?YkRIcjh2SDJjUVYrVG1obEQya3VtTnhrNHpzdDBQcTY3c0Z5cERBZmxMM0tq?=
 =?utf-8?B?MXVDZEVJaE5RL2NHNFVvZEU4RDBnVTFuSEZJck80U3pJOGcyOWtGbjd2RVZD?=
 =?utf-8?B?UU4rZ3dCUzZ3R25ENFhjZHpkNEE0TWhVcEtiU3FLeFZFelJobGZad1oxN0F0?=
 =?utf-8?B?VGh6WGIyZVJhbWJkNzIrbktMQnNHcnRsV1lYdkpjeEpsc1ZoOXl3NithLzJl?=
 =?utf-8?B?SEN0VzhZaVlHK1pxQzhzN0RETzV3STBzV0I2b1VXSEhYci9VVWtoUFNmam80?=
 =?utf-8?B?SVE0eHlFN250eklRblpmVkZ6OUJnWWVjSEJ1cTkwcURwam8xdFZPbWhIVGtF?=
 =?utf-8?B?emNMeHI2M2tFVXFnQkNFa1M0T1pLcU9CbHRqY0tSa1RocTZCRFQzbSt1TjB1?=
 =?utf-8?B?V1lmSkZybC9QV0ZCV28yQ1ZjVUNsd1B0d2xueHJxN204T202YlNQbHJTMXpn?=
 =?utf-8?B?VWlwU2pLSHFZeEU3anEvRE02LzZUYy8wTkhmR2t4aEhlZlMzeUE0akZnMzJN?=
 =?utf-8?B?bDdUWkU0QWVBVGF0YWwwUnRWVkZxQmxlQ21RVldwWktBYXhlOEtQWU1hb1R3?=
 =?utf-8?B?Umo5Q3N1RnVWd05rMDhveHlLUmZra1FCQkJRaVJ1dzQ0Q0FLc0N5c0ZmMVlw?=
 =?utf-8?B?T2ZPRndKMEFBeE1xV0FqNEc1RHhFUTFyTWlWYi9LWXRseHZNeWMzL1NKb210?=
 =?utf-8?B?WWtLbmFzekJIb0s5Q0hoOUJGV0ltZ3FBQy9LTnJBbmVERTE3Y0tTNkt3Zkcx?=
 =?utf-8?B?MGxLV1ZtMkREWWpnVnlLL3E0UVcybjFjTEo3akxrY1FtU1htcjBhS3AyVnF3?=
 =?utf-8?B?RnVOUDhJSTMyWWNOV2xhZ3I0TE40d3FURGswblZRQjc0ZEFMbkFQMTNCRUZo?=
 =?utf-8?B?WkMvQWVqSG5zWG4rTzhRQ252d3YxbnI0dDlUMHNIcDZ1Q2VxODNkY2RDWGIw?=
 =?utf-8?B?VlJFZkprU2p5REx2ZjhVMlA0Sk5rdjN4UEdEbTlvL3p2MDROTW56eWVvNkRt?=
 =?utf-8?B?dEJ3MXhReGFQVmVMam1SckxNVUk2TUl3UUM4UWJ4RXU4TzFJQTBiSkd1NHMy?=
 =?utf-8?B?WGlSRitLQ2FGbFlXQmJMQW8yN3lxaXFGVjBoZG1PMUwrWWFqcTlhK3NKQ3JL?=
 =?utf-8?B?bU1CcmlVdkRMclJQYThLOHFSa3Y2WEVHOHBBN3hJVHgzajBoS3FnUWIwT1FE?=
 =?utf-8?B?VjhHSjFxK1llQkYxWG5YWVFIeldqNTJsdFpuOXdhUHNJU1NOMDkxUkx3QkVl?=
 =?utf-8?B?WUdpVEVHTlIzQVRoMEh2MWgrVWdKUnM4UjdXNjlXcnM2bGczdCtUcUVDMFpv?=
 =?utf-8?Q?9x6/IOlYEooOFFaeAVstH9XWo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b45287-a992-429c-0f8b-08db9cdbb2b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:32:41.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym4zorxwuOXDS2R0VU/1pdwPqregsIvBYVLUXMPFXx2Z+yZnb+yrydcJ+ZbR7ylokSe2ziSQbwefdPgc3b3lVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

In addition to the hang fix patches recently this other patch is needed 
for helping a case that ASSERT() catches.

74fa4c81aadf ("drm/amd/display: Implement workaround for writing to 
OTG_PIXEL_RATE_DIV register")

Can you please take this to stable 6.1.y too?

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2466

Thanks,
