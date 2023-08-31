Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D578F2F6
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbjHaS6E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHaS6E (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 14:58:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA18DE5D
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k77w6vfswd0LC1ibVv9Vv84fT+CLIKoReEdLJc/SzjgRMLh7/vo60d7cTV5DqZb/XoMlZovZzsJ8n0egbupTAGLRFliTFUa31Qclo200+IPbgKNVV209EFqhS3c+7negZbgqwerw7HWJ7eAx5LwdIdS8ODEi6o4rZm7bR1TPlKFTy7rsfbT0eGkEoRXIyGA1WGBowV7uKmd3DVpptVRJ6+leYfDLUVqgUd5y70faNf6n9+xXnXzO05JQ6Rx+J8jiF6oud2VJrxhuFaIULxb3l7LG+Ll2/d2zMYGiH9DFqa10ulfDKe16QxVw3KnKI4lu2etiAyi8tmMUise0xCQ/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js/n7avZDLG7vOgYlqhlwtIdCfNKjqSbPPiAwXOYUK4=;
 b=P/JZPuVotWoJdgAGQyNXPvGFHPc5jdYmm5V2oQWaKJfHxkErRwMXAN791mKf5s5K4ouMDxZBT7Dartj5ekPZ2vsejSIj84qjfAaHbn/7z9f0qUpRPtBnPu9lyJWeyOmXQyG32Vphj2IMS32XA7G8iyvqZzAjZpVItvF7FCdnMHs2XOPrj3MK4bGgSudYvDsb3Iunue4ZKFgrAhoUdqiiRPfstSpxpJTYZehoIBK7n/6gTb7eCz85CGMnUFcJDysmIUSRuEhsYJRho9qe6j9bi3tszhIGPLAeLT+ORJuIrT76mgMBwMaiPmarIM0EfqLS5a3hdcUHbSksX4N50zokdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js/n7avZDLG7vOgYlqhlwtIdCfNKjqSbPPiAwXOYUK4=;
 b=P5sbi+U0KvqyU44pdJfWLJNiwSiGksmbmsUElR+SoMjVvI7GvWLxhAgBgyvx/FiiCWcqihoWlpJrSBzq3dX4KfYzOUK2MZLY/xA6X8DdjbPLFSAF/TTbrsOoLqUINj9BSVH+l8K+Y78uKbyus8Y5eZRqaI4c1yuOgehjQYx2Efg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 18:57:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 18:57:58 +0000
Message-ID: <c7953970-6faf-4bd5-88f1-13d545a0e905@amd.com>
Date:   Thu, 31 Aug 2023 13:57:56 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: amdgpu segfault on 6.5 while playing VP9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1df019-a910-4ce5-cd92-08dbaa54316b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCYkB5OrTMFufRFUBWIKMAUtHhRT+L3cfseLDXQJK19gloAzdtwFKzxctuKzp+RP8IzdsHJH5p0JgdZ/TlgzujHN6znGfhezeibFcmdW8TYgNV1sye8Dx96VLlyjrC7bHoy/s+ksxzOj4KQtlIfVlCtcTuezFHvTHFDX4jwPQC3b+fMKI6gqtn+tDSBeICZgfftjJJDhA4BvCTqBWWUqfafLf16vgmjN8kIE+qBRW2kZu6d8dWDaCL51e5XKDezqhnivxUp9eQXxbm05FJo2CDQCVYtuRJ850fJd/qaRkVW7VtDf7nvSdrLECq//FHQQHE6gIjCvDFFbrFq7Npcn/jmHbApsmctupKnFDznvM/3qlWDPaCYejBYcv02AYbSWo0GVLx5iPF31f4m1dyXUMcfu3OezlrMMkXF4fbDfb2LiwocVp0Y5XJXhlBGtF/rO/Vb75K+otv0lmgJMdxP8JGZ2vS1noQsxtJlr3oUKEPGk3GFs/GVRhn5akhemcoiUmP2ddEMckQ2JwwR8AJVf+sOUDhGXTN3QORBGwlcinRgtQo3JaBDd2DdaS0KkYiqLtAotV4XYs70YorSbNTKY1h6tJ7NdCKkk6HBxtkX/LBGU2GNp/pIbDo99tAkbrjLlxkyk1zOYYbF3Nh35UZOI2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(41300700001)(8936002)(66556008)(8676002)(966005)(66476007)(478600001)(6486002)(66946007)(6916009)(26005)(316002)(2616005)(6506007)(6512007)(2906002)(38100700002)(5660300002)(31696002)(36756003)(558084003)(86362001)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBtM3FMcHJFYStkME1EalZFVjFHd3NhMUpMamlEeHdxdFZzUkI3WnFxazJG?=
 =?utf-8?B?TGRaZU9IUlc3TUxHWDlpUUsxWXZ2QmhLRmprYXIvRjAwSEw3SjZ4V01KclYz?=
 =?utf-8?B?UXZwTWUwWmk3Zmtvb1VzYWcrUndhN3owVGlrZXQvcTNYOU9ydUhPMTM4eUdy?=
 =?utf-8?B?ZW9JTUV1WHVtOG1GQkJJZjFsbnhweXFvRnROaExKM1RlVFNOUHRRK1pFcHQr?=
 =?utf-8?B?SzB0VFd2MGVjSG1vZHp6ZUovdzJtdWl1SkRXV0FGWG95b1l6blpLWkxCY3pR?=
 =?utf-8?B?VHgyejd2VzlyNThqK1RoVXB6aW5Sc1YySEJIaHRCZnM0NTIyOGV2RU1ZMGZm?=
 =?utf-8?B?Tlh0MDkrekJzK3diL29jeVU4bnhONlpPN01Jc0hSa1ZtaFFERWt1Ti90VXEw?=
 =?utf-8?B?Mnk5UmZiVzZwRi8rSEk5alY4SVVsNlN4NXdBdFh6b0J6N3RQVTd6dnR3NW44?=
 =?utf-8?B?aWV0c2ZoN21Id291ZHIwR0prSVZUOUNPOEdBcVd3bjZ0am84TkxGNW5kRzlp?=
 =?utf-8?B?Mk0wSmhQRExQUHZZbms0RDk2alo5cHBEdjdETllONjZCdk0rR3VNcm90UnYx?=
 =?utf-8?B?S1NQRU1Ud3RNcGltbisyTDFTNFd1TXFCNGlGVnpPQ0xGVE5WeVN3SDR0YTlw?=
 =?utf-8?B?WnQ1VTFQa3Q3a1BhUDE1TWxSZzZHZ2JPMFdXWUlDMnFhZ0k0UGVnRWdBWTRM?=
 =?utf-8?B?b09leWVPZmZFT1ZvVEJDUFdESWg5dnViWlZwbkppblI4WGtOQmlFc2tKbjF5?=
 =?utf-8?B?T2w3N2Fmcmg5amJib0ZRUjI2NmNkTjZVWm4vckVpa2pVR0toNTE0elRBMjlz?=
 =?utf-8?B?ckZnTjhPSFpyNnRlMU1TeXBTQkJGZmp5enBDTUZQMHhYTjR2K25rQ2Q3dGdW?=
 =?utf-8?B?RnZiSFprUEVYUStxdnlPU3dIYkpPaXNSWlRKTlB5T2luSlFXQ0RCSE12Rzhq?=
 =?utf-8?B?bVlmQjd0Tjc5cWFCNjYxS2YwS0hiZm00Tm9uSXF0YVhzbjhtT1FxUXpDOEdZ?=
 =?utf-8?B?amozOGs3aWpnekpQM2dPbDE2cHRqaGgzaHVsZ3p6SXJOLzNZL1RmaVlmbjNV?=
 =?utf-8?B?Uk1NWWFOM1BjT2dvQWdSQVFTZkhwUVZteVN5ZEhZTDFuMEFodFI3STdjVmNj?=
 =?utf-8?B?VUVMUXNZNng0U0lNdE5wQk9FcjFaRkJRZ3NWcVpRZjFoNTdMOXovZmxqYXIz?=
 =?utf-8?B?cXk4dUhvZXZiSlhadGp0S0x4WmhOR1pPSWlWRWwwdUNvbjFLcVBWc1dKL2RW?=
 =?utf-8?B?RWJQdnVoczliYXRJSmlBc2MyR01PbGpCWHdDWENKaHk4aVR3cHJUVmg2eXEx?=
 =?utf-8?B?YUsvZE5LYXlDQ1BkN0VkMHBZSDM0d3hzYzErN3Bad1IrNXZzUHlvaUxqQnlo?=
 =?utf-8?B?bm8xb3JvM2dFdFlyVHZPSktTRTZEWXU0a09hcFdhaEdXQ21KbXdEOEJpbVY0?=
 =?utf-8?B?Unp5Y2ZrZUV3dGROZHpUWTZ5R1VmYVpKNCtFQ1FJdkdkaTdUb3U5aHNPaEFP?=
 =?utf-8?B?WThoQzhVcCtHT0hhT0RGcHIvdEtRYnh3YlZCbkRHa2wwdFhBb3dRRk02dkZN?=
 =?utf-8?B?Q1JwTTRwTFBVS3hmRkVGeXJ1UzRUOHJXZ1JtOCtTeDVVUC9YVDZWUG5GM0N6?=
 =?utf-8?B?K2tHQW1qNHdJUDNVckorZTE2NzJoOVcwa1poM3hNaG9ONWdOZ1B3ZVdoV3R0?=
 =?utf-8?B?V1hHN1FPUW9VMHBRWk1iZTM1SGtadE1yWklWeFVvZHU3WEZ2WHZ5YU5tT3hS?=
 =?utf-8?B?c21hY01adFlteWRtVFR3Qlp0TFpqdkNabFFkK3ZBVXY4c0t4RzcrR01IeS9q?=
 =?utf-8?B?TVNpTm5BZlBVOGRheU8xWlFUN3NHOXlnVlhIeW5MZjd0RTBrdUxELzRkbTNP?=
 =?utf-8?B?SlRtdnVzQVNOMUhaUEdlSjI3ZUdGUnhLcGE2aHhmUWRsbGx1anppNjBZTENw?=
 =?utf-8?B?NDZhQmEwc0tBaC85V01qM3N6bDBqWUNvUUc0S1BuZG5LVWRYeXpLd2hwb05a?=
 =?utf-8?B?OHZmckpMM1B2dUVxODZic1NNdndKR0wwTzF2L2FselhRUHdZTTJuQzJVZWQ1?=
 =?utf-8?B?eTJ2M0VBUG55ZW9ETFRmL1NuaHZ2R3A4NktaUlBCTjZSNVVRU0Eya0lEY0g0?=
 =?utf-8?Q?Ood647JVLO94wIWJls0xuZ9i+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1df019-a910-4ce5-cd92-08dbaa54316b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:57:58.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2oNLo8jTnLGpYj/c4rOuYa01kFnXNPThjP7i74A4eyQKjy7qSZGjS33eZHmz386sf7o1a8IpAA39uh0KwJKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

A segfault is reported while using hardware offload for playing VP9 
videos on kernel 6.5.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2822

This is fixed by this commit:

6f38bdb86a05 ("drm/amdgpu: correct vmhub index in GMC v10/11")

Can you please backport it to 6.5.y?

Thanks,
