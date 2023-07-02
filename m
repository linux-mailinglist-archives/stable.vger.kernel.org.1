Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A57744DAF
	for <lists+stable@lfdr.de>; Sun,  2 Jul 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGBNNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 2 Jul 2023 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNNF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 09:13:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9B135
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 06:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzcW+S1gGTRVL25soCBolBayfhgq6DS1s6JkKJMl9A8t7gCBINE0AfQFHDtdc/4SBRDcxWO2kVtM4333lOhBcZgTiRdbySevk+R2it/blhUN9DWZxxrm4Mrzs2I1BwNv42SfTfUmrwDi1vJQaRBBN2Unaz692fkAV9VhulSvzni69xIJXMSnhB2APA7vt997YU6M/hTsEpATWGKZFrNYXiMo+JkN2q0V95dqJzvcjv+GOqhGOKRYu76mKd0/SUVfaZ5yfSZfekJ6u6NFA1rFKpJGIhvo0pSlthJZ4VN2UeqAjexWX8lCbWaVJWMVqVKfEyzayPPUKbwdmA8WwYEZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BO5w6tCZuemlMMyhqHLL5RMUamNTJEFvU5DMjEBlw8=;
 b=CdWOhUYvNMJmeZZZhUhQxUXesWsbY0gEapnMCbqrhr//c3IIE8VOlrcWcF5qRaID5gwLWfaVOVSl8w4cWcbAOvBBoLYbfAKmGR9RjamTVI+HIBJ9VfImO0cfaW5ARiod7tFMzF3zhAHXdNSXYW4Apdl8rT3yLccImzPpDZgXDkNGSkh7aEwRZsBCuzWpG3FqYbUz8e9YBR/ff7Il9/oLn+b17QHGKMWxm8NmldXC0nfAlGk/pD/JnlzwPftJHUoBtDoQxZWW692Q1KnVbvgifHHJnk/jkwleFqXPb1CFskeYCPM/xBo63Xqx40I1zVREOxvWSd+v5AAObcgjSnx/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BO5w6tCZuemlMMyhqHLL5RMUamNTJEFvU5DMjEBlw8=;
 b=CJXJ0VXs4bHBj15U2m1CwazU8IuK2jKMNN7cm0bzm6ElDfjgqjeeAWrtG8P8L5py5PKfM9ywHxZhiHlHRHhVOhhp6exvr8oWz+45GQIh9AgoTuli//Ou8ez2JO3gsAJbUvAUBPaYZ3iyWjA0rmYxQaiqhNX9IlmxuJ5sU2YZKps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sun, 2 Jul
 2023 13:12:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Sun, 2 Jul 2023
 13:12:56 +0000
Message-ID: <9ef5921a-2382-b006-75fe-1613ac727dc7@amd.com>
Date:   Sun, 2 Jul 2023 08:12:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Fix regression on Stoney
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9238f069-e38f-4f90-c363-08db7afe0d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XcYGUyUbMPoYbnGyhejO3N9kJ/IIRx2pjgG4a7ERKzmvBbZzfJ0xne0j21LCRWlRFVjS3slPjRDGR72HhdBr0RjKqs9haBOTtveDErKjAgnecjYj2ESaaOxNhkQdJB93TL+4apKKmvOv6Qq5EETQJFNkfvWHurkZYo0DSGMFXr1xxGW8H+gjs/1sbNXoGykqruh5SGWy78aeQp3iUqB98TYJbb21yCNOxKfzzpI5O5kZS1KJm+4ruYpB39vUFCL3Oh8GliyVbbRKtC0vdMJJwQWCI5DD6IX1d9ZpNWVXGIQvEfm0eHovdbJWdUOFPL6PDfb6aHtufrYDIbhJUQVJFyD+O1GAV2tdo44joW4H6Sp8Zj+fy/Kh8unBEPyH2IoNnoVvABPskCrTUOaIt0SDrYsotJ3nxmvJqU+ctufZ+nedf0pDXFKNv+4IE3rOdsQ3sxvCGYBrtVZItmb65uCMk/3AID+OLrBrIt2bNMbnUQkg04xCz05obc5eJ8w7z9hzH2qfIH/ow5azkmiPiPZotQlhKKH2tOC2aNy7gA8CAYKIBeMnfzEzra6SZaKcFVMnMGfGEC3nSJ6+8iaauT0akJxlwEQXYxZX2PPygX5I2JtqwYbbdCv2H8YLJ28EaCx8ZRXKzZymsKqSdPGkKO65S0zEEe3pQyp92ouRyNsXSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(2616005)(83380400001)(186003)(478600001)(3480700007)(2906002)(31686004)(8676002)(8936002)(36756003)(44832011)(5660300002)(31696002)(86362001)(966005)(6486002)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZ2aGNWVjg2cFhLYjJkL1Uzd1lUblZtZ0IyVWhvQlY2dVVaRm1aUS8xa3lR?=
 =?utf-8?B?dFdSeXdESzVEdzkzbzVOQkRab21QL3dNWUlqRHpEMFlXQkdaa0Zhb3Vqekkz?=
 =?utf-8?B?T1Y0MVQrVFJsU0NUbG5FSVZKVTEwdGdRcEUrS3FnZGVvSFhMYmRhZHlxRTFS?=
 =?utf-8?B?blhXWFRzWkVtUG9GczdGaTFHZkkzQ3Z3Lzk3Y3UzU1dCeEExTFBPV0FNK3pP?=
 =?utf-8?B?RGNFakJZeFdieVY4bWVtS0t3NzcxaDJGT2Q2a1Y1TU1yalZnVk96ZjBBVzdW?=
 =?utf-8?B?QkZyMGVsTEZOOXhXNEMzVmg2OTlMejVFTlN5SmgrWjdyTHpYYlJTUm9Qb3JM?=
 =?utf-8?B?ZW1ha1A3MDVXakFybmpuemIyRFEyc2x5cGJZc2dTaTBqaDJWSFl0dkVodlNE?=
 =?utf-8?B?UjZ0eC84VEZhbEs4dnlpdnJlTkV0bW9FakVHYXBDdUk5K1F6SWRIV2h0R0Vp?=
 =?utf-8?B?RFR4YWpnVG4yM2NXMnFLeG9IbzJ3NDRTVCtmYXoweXo1ZFJ2cHQrLytGMjN3?=
 =?utf-8?B?T01tamd4aWcwMmRiNVlHVzhveGk3alByTDQvV1hpdVh5UWlMOGRrSGtVQVAw?=
 =?utf-8?B?NnI5NWN4b3ZnRE9JZW0wODFEN3luTHpKRE9RWmkxYS92a25jTE02dGx5cy9k?=
 =?utf-8?B?NlMyRjVNSHNic20vM0JvOU5oU1c2SlduS2l6eS8rQlBIZGtaOHd4VUFxdnVJ?=
 =?utf-8?B?bkNZSGZ2RDlHL2NNY1NOVGEwam9TMDVvUWdSL3VSSDJVOGd0anVkbXQraFVp?=
 =?utf-8?B?a3pnbGs5QjByQ2ZSazNZT1krcUN5c2czRjhoVFRPVUJqNENzcFpoZ29WUHli?=
 =?utf-8?B?d2lSbExCZFRxV0Q4bTNxbVhvRUNSdEgwRjZMYUQybXVTQ3VaSGNYY3JTUGhR?=
 =?utf-8?B?Rkdvc013M1BRdHZmcmc0cHFHSFBQT0tiY3NrYWNLcW5uU1pDSGRTV1Q4UHpu?=
 =?utf-8?B?VTg0UFNpK1diMmZWY3ZmNGQ0cEord3ovVktxWVNWcWdDaHR4bktNWWNNQXFB?=
 =?utf-8?B?dllEQVAxVnBqRDMvUDRMSUVGU2x2QlZpYmlaZWFVUHU4dk16dUhubnJGYkZP?=
 =?utf-8?B?NDlJa0ZERFVYanh2SW45c2t2QjZ3QjZWOVRMbktlVkhzVmt3UDFWNlF2b1FF?=
 =?utf-8?B?dkE2RDFSUUd5bHBGT0MwQTBLdnRialpLN2ZSYmFrZjZXMWJJQUN2RStYZXpO?=
 =?utf-8?B?MnBQajhpKzJ3MkFSSW9xRmRITWhJQmt1UUxLNW4xTHlSc1hHazdIKzlwOFpQ?=
 =?utf-8?B?S2NQc3JXYkcxcmFIT0VLaGRlRENmajRPKzdqSFl2b1B0MmxVYi9pdmZ1Q1lJ?=
 =?utf-8?B?bVlHRnB3QnJNWCt6M2xIOC9VN2NUVEpqNTNRY1lpSFV0U1MxMTkzYkVSTkx6?=
 =?utf-8?B?Q0FTM2lqalZHelJpTFFtWUV6d04zRHlhQ3NjL09XYW9lWUNwbER3T0Z6bm94?=
 =?utf-8?B?WmlWQVVPY0kzZGp2TmIrd0U2NGRvOU9KQ0k3WTdNSEJFUU1YdlIxcGNrcGtK?=
 =?utf-8?B?eGZvSnlKMDBybTNlV2pmTlN2NUIrK0VDc0ZodEdzZUJzdzREK1VQUlRmanY3?=
 =?utf-8?B?QVVSR0JoQ1NZd2lJbHpiNnZIUE4wL2NZMkwzanc5ZktXRXYrdDczZnE5NTQr?=
 =?utf-8?B?b1RTQW50SkQwMFFFcVZ0Z1MzS1lBcjhmZlM3WC9rRXQvUFJGWHhvWUp1ODdW?=
 =?utf-8?B?NDVaa1BtSDFETmRRSjhLdkZrek5USHZvRUNZTjlOajkvc0lwenRNQllpL1FF?=
 =?utf-8?B?dzUvdkp5Zml4ZnFkRERpWnJrUDQxY1BlWmpZM1BOMGkrK0RGVlBGOHVkY3o3?=
 =?utf-8?B?alY0d3U2Vzlwenpxc0ZUTUpackVTRnVWMHZyRUMrYmJDaFlRM0Z2cy90MEI3?=
 =?utf-8?B?Z1A0NGU3RS9vRmVrNitEWE1uRDd2NFEwdVNFc2NvZGpqVUFDVCtIa2FVcEV3?=
 =?utf-8?B?ZUxuc2J2ODh6a1dwNTAzZktncWpacnBsNGQ2eFl3M2RpNHhCK1pKUEdnOU9Q?=
 =?utf-8?B?U21ySjgxTGR6YWJNeGZpZXFJT0kvdFN6anZZZHE2UG1FcmowSnZmWm1lTG0w?=
 =?utf-8?B?bG5UaHp1SmZDUmpkZEpIMEx0K0t6SnhORnV6WlpTSDBPdWJodUdoRkkwMk5L?=
 =?utf-8?B?NElkRWIvSCtnSTNwNkZyVjFvTi9jK3pPWFkvS29YODYxQzNJRlM5TzI5RGxv?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9238f069-e38f-4f90-c363-08db7afe0d1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2023 13:12:56.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1rb9mqtvW5MOSS2/+f8px2gOw+Sh4XiqHKygBl4BLL4WyBXxQCZh1rzlp7F+Zy1aL2oAdF6CCXYIEOOfUyqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

A regression [1] was reported on suspend for AMD Stoney on 6.3.10.
It bisected down to:

1ca399f127e0 ("drm/amd/display: Add wrapper to call planes and stream 
update")

This was requested by me to fix a PSR problem [2], which isn't used on 
Stoney.

This was also backported into 6.1.36 (as e538342002cb) and 5.15.119 (as 
3c1aa91b37f9).

It's fixed on 6.3.y by cherry-picking:

32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations 
pending")

It's fixed in 6.1.y by cherry-picking:

3442f4e0e555 ("drm/amd/display: Remove optimization for VRR updates")
32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations 
pending")

On 5.15.y it's not a reasonable backport to take the fix to stable 
because there is a lot of missing Freesync code.  Instead it's better to 
revert the patch series that introduced it to 5.15.y because PSR-SU 
isn't even introduced until later kernels anyway.

5a24be76af79 ("drm/amd/display: fix the system hang while disable PSR")
3c1aa91b37f9 ("drm/amd/display: Add wrapper to call planes and stream 
update")
eea850c025b5 ("drm/amd/display: Use dc_update_planes_and_stream")
97ca308925a5 ("drm/amd/display: Add minimal pipe split transition state")

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/2670
[2] 
https://lore.kernel.org/stable/e2ae2999-2e39-31ad-198a-26ab3ae53ae7@amd.com/

Thanks,

