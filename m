Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC8720CD1
	for <lists+stable@lfdr.de>; Sat,  3 Jun 2023 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjFCBKF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 21:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjFCBKE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 21:10:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B601E43
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 18:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VulPcTJOCcPTl+d09OKgzHXsVvhqtcY2eLUTkMy9WrQ900qy6g9qpBip0tkPJ2LI4Kf1LvopjUSX0p/kP94/9gussH6IV3IL3K1mEta6/xLlTy3JazkXoe6BiV3fpvFWVggGPup8ImAb2/sPxeg7b+QJoWd6guJlhhKbODjvJ51zCb4oIwZwvJj4Zu/91hN8btCLOnkWEjleA7LthfJyFmNVx83Ga2srA0yKGRhCKl4Zf5/melu656+8tEChKvyuyb0RgPmkU3sotantoa5BN+iN9bcyuhNtk30/lLxfZ/bKoLzCNoE3O7U4HTE4wxl70AuzNKEp4xWdJ4/3HDqjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l5XRpw0oFNXKag3UVzqDnkU1IK5B8jGIn0N0piTtUc=;
 b=kMAKaRAsbnInBDGvk9vUoZ/gOpBf80vbCbeNN8QfXF1KOIgi7+nlDldVsypijJLW3ax33qrr6qgMbU+XRRg1EHgGCAgxqTGJW+VqY0amVI2WK6j+DuaI1RlgOs/RDSXCexDgMbpwupctNxrFWv7RTk19pMZr913K5CxQsIEC072aL3RiR9j3GLMk3TsuXBBtN1ePa3WBlgalgeXc96t0+AJj4X+ZcKKOvHxTKGqsRCQCPDEc3BLmhyOb8+xapP4MU36U+n1pLWwC5MO0NZCotfJ+czRH8VNuAHbE6wKhhFLFYR9QBMemZKLUcPOQ/5GdiUbmKQC5MmDRCaQqcLW3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l5XRpw0oFNXKag3UVzqDnkU1IK5B8jGIn0N0piTtUc=;
 b=aJd+It+rhHIL4hRBW1YnV0MoxexOxI2Yo5T2WsNdxnx2E2uDtOcGE+IBoHHUfbtc2Jkcyz3fq2qVI9D4ID08tAx/o02wEXgf9a7FVEthNmdrs7yTKgE+Jjt/ZVBcUkm24k8wKa6wa8VK8Pp3K9qiH07xGrxUh6htSGlBicZEQlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.26; Sat, 3 Jun 2023 01:09:58 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::9843:8963:3ffe:88fb]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::9843:8963:3ffe:88fb%4]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 01:09:58 +0000
Message-ID: <4936a11f-f4f0-7559-a43e-90098aa68c90@amd.com>
Date:   Fri, 2 Jun 2023 20:09:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: amdgpu regression in 6.3.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0052.namprd12.prod.outlook.com
 (2603:10b6:802:20::23) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: c16aa826-fe42-4871-323d-08db63cf3fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iT4XnAa06RZzfTupEuDDYmQ83pbki8etRCPyS9nd0wIL8MroMTiaIF+CQF9yeVRQgofawVbm3NWw5eRkUnAFdKQEMD2PdgoTl2Vt5wYl9AS8Ltp/zCOY9qQGaOIqGPKQzpkMdoeIlrfY6oeU4sVoJMJ/Ss9KN3LBFq5U+Kw9tWMRqcFvZdP31+HeA8DnTMK/PKewNCjT6FyVQdnrbcDTKxLp3lfxY0hLF6uwdi9wns2gldW8HtBVe56yy2/UFDiJFDJKzSFjIk8yFPGS8GhuKKOhvdqH9qlzOlrAd+kNqkBaiolpbC8xNoN3SvUaj+b11jkBzF7XUQ1LSH/sYJD6xE0niMcx6GMWi6LObLmN66r4AENKjr9k9f1NBeqSkbn58k/jS3Xb0mp5XCAJSb20E6sJnev8pGapnt22f3vBnzek9V9r7Fsa2HwkKOaEMs2aQbFL7Gxn+GtRLq/WOfblqtDOm4kGVGqTCn1u7xcgPbXQDEAET0rGcqmB+S4xvfTY9e1qiq6jeD7M65DDK/EkOcHKzP6j4s+/VzLWbo+gK6GLnT/ZuoyPF8Z4PR9f08vPBma9qUmWCjCAhPlVurI8PRQasL9TBehDzS4KPnHxgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(38100700002)(31686004)(86362001)(66476007)(478600001)(6916009)(66946007)(66556008)(31696002)(36756003)(6486002)(966005)(7116003)(6506007)(6512007)(186003)(4744005)(5660300002)(2906002)(8676002)(8936002)(316002)(41300700001)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2c4dk1jQjBNWGY0cXhUV0FtSWlVVHc2alNTWFVHdnU4VlAxSmNINUNCOXVa?=
 =?utf-8?B?SGdnR2tBOXZ6UHZNeis3bFBFOWtHL3hnMkVwc1VVUTR2WEVUc3o4cExCOXZK?=
 =?utf-8?B?eVQ1cUtHcUJTRmkrWnliRE14MnNscldWZDMyYTRRUkt6S3RSc0VsSldwQ1Vm?=
 =?utf-8?B?eHA0RGJ5aXF6YnpRdWV6TzFJdno4ME1BaXE5NjB2M2F4UE9wTXZTcUdkdzY0?=
 =?utf-8?B?T1hOWkk5aHBQcDFGSHBIOGlTU2JZejc3RWZzbmNpN1U3TWFISCtMR0cwbERG?=
 =?utf-8?B?VGFOaG5uWS9MdHlXZVlYZGJQdnpBSTd0TG83aGFQMURLUGphUUpWNHFiWTNO?=
 =?utf-8?B?K1JHa1JFKzVLQmZLUzhhMUVvc2JQMm91amVWN08vOTZBSVJwVXdxRzR3RE9J?=
 =?utf-8?B?MGJreVRFWU5rc1Uwc2FrM0ZHOHFreU8wQzZqNFNtT3NydWNsY2lsMzl4Nk5X?=
 =?utf-8?B?UllKbi9qS2c1RGlic0JTUFBsTVB2VVpXU0ovOTNSRjk1UTQvYU0ydzRxK25Y?=
 =?utf-8?B?TXBIbUlYS01EcXdWTmpwZGpDYUloNklFb0J1TGR4RzhBMUNxUExNenZNOU9D?=
 =?utf-8?B?VmI4NmRGcFRwRjAzRWQ1NzdlK1M1N1E4dTVHaDRNTmF5eXhlMTlCTzVhMEhF?=
 =?utf-8?B?TSsyRStoSytUU0Jvb1RKa0lvaW1PUkt1ZU1EMlJ1RWJwQnpkZTNFdktLaUp1?=
 =?utf-8?B?ZlNYb3lYU1NmQkdHQytZUlVobEtzY3RtZTNqVWFrY0lNUWx2ZlVEVDdmQ3hq?=
 =?utf-8?B?TGtiL2t5d3d6SG1VQnAzK1V3cjE4dzUxcGJ5QmFSK0wrRysybVdicXFjcE54?=
 =?utf-8?B?alJUa3lKMmYyOElmU0tqcUs4OGxkYzg5cG95MDk5ZkNDMVJQVC9mQVFnTVVF?=
 =?utf-8?B?cWdjS1JTKysydGliNFF1cStQNFNaWDkzY0s3eDMzc1dmY1NwNjRXdko1bG80?=
 =?utf-8?B?QWRhb1VsbXR5eElDdFBiclptM0NwdTFRajBZVEpscnpnMWplUWZkYms3QzBQ?=
 =?utf-8?B?aVFaWkkvdFBJUzRjMlpJc0R1dUhLU2RFQWRMbXE5R2g2QWIwY1lMZ3BKY2Zt?=
 =?utf-8?B?L05ZR1hjeTRYdkJhbVRUbysvRmswTnVRYU9mSVpKT1VWSXg0ZFdkM0RoVjJP?=
 =?utf-8?B?TXU1bVovcEd0TkprZmc2dkVTMzBIVjNXU1pNd1ZWbFc4cllwWXRGeUoxbGtq?=
 =?utf-8?B?NEtTUmoxRjY3RVZjUUdiUjFnNE5IZDh1bHplZ0NKM3VUbG1pc0MyaFBzZVZ3?=
 =?utf-8?B?QlYvTjkrV01uQm5ITDkzeU5xRzYyNWVsYWJZeWhLR0pjbGkxb2xSV29HWnh1?=
 =?utf-8?B?WDJ5UGdBN25PS0I5dGhyaVhTOUlkTWY2OFA5Y2JSZFJVb3ptNnhsWkFzdEQ2?=
 =?utf-8?B?ejdWVktoazdCa3F0RzlZUXBTUHJEWXRBV3ZBK2htcmYzL0dBNlp2cnRJNU1l?=
 =?utf-8?B?dkNBd1lScld5azVVWG5DNGpLMnphejN3Z0VkZHVkREFuV284dXhRVndUaE5w?=
 =?utf-8?B?VzBKcFpXWXdNR29ac1RON1FVOVYveExFVVdSYmJnbEVvZWg0REttZThwSGZO?=
 =?utf-8?B?cVhpRDVxTkhWSmhZc2RTT1cyVFZCaWJZM201V1VIYysyNFZIRFp6SE81MmZD?=
 =?utf-8?B?V2s0RVYzWFhwZEl4dUZhU0NqemNiSWJuSUNDQ1ptRDNwUC9TY29ncm1vUTlk?=
 =?utf-8?B?T0YwZkZzeTZESmhDcC95d2xXcmMxNVRaR3Q2eG9SdnNRZW5XbXQyTW9oZWt1?=
 =?utf-8?B?Q1BvN2N1Rk5PNG4vaHpmMTRTcW9NR3U2SFBpT1cvMmYyT0QraFpqbytYL0Ro?=
 =?utf-8?B?WEhvZWlEa2JSUHFFWDZKM2NtN3FGT1B3RUlGVWRJUzhPTS9FSzFpdEZxWkQw?=
 =?utf-8?B?T1ZiQzMxN0s0RlYvc3E2SFRzLzZxSmlBS1pTR3M3VW9Ram56eXJuVE5WdHp0?=
 =?utf-8?B?RUdpd2ZQcXZHSUdWYWJIRGhCZFVFaitnNG5yR3I5b1FxYzRwUmxiekQ2dThP?=
 =?utf-8?B?K2NON1Jla3dJbExCTy92bmU3b3RGUnVoS05OSmY4TzhFU2Jhd2djOHVLcWJi?=
 =?utf-8?B?MElIWkN1OXdjYXNvaE9kRi8rMXhPZWdkL1JzRy92MjYrQkRsRzBCVDRCclpo?=
 =?utf-8?B?cGtvOUhMam5DZFArVms3ejA2YjhuQXhzcnRsU3drRk5aYzM3cG9OYlExQmVk?=
 =?utf-8?Q?ZmF7Mou5MkcEFxUBJTNK43OT29PGWx0h7AORoUnj+Nki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16aa826-fe42-4871-323d-08db63cf3fbc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 01:09:58.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2C3HCq9s1eM19VRDBkRSQH6of6xIfavRepy4kYaQpDA9G6K2HSuiaNDs19/6MfXj/SbaPIeWWd1kQtRf3npPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

Sasha's auto-selection backported:

commit f3f8f16b10f8 ("drm/amd/display: enable DPG when disabling plane 
for phantom pipe") from 6.4 into 6.3.y as
commit ef6c86d067b4 ("drm/amd/display: enable DPG when disabling plane 
for phantom pipe")

This was bisected down to have caused a regression in both 6.3.4 and 6.3.5:

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2581

The problematic behavior doesn't occur in 6.4-rc4.

This is confirmed to fixed on 6.3.y by backporting an additional commit:

82a10aff9428 ("drm/amd/display: Only wait for blank completion if OTG 
active")||

Can you please backport this to 6.3.y to fix this regression?

Thanks!

