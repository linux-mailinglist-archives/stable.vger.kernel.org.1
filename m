Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69EC7828C8
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjHUMQD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjHUMQC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 08:16:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21544CD
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 05:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrlOXW/DN+NFl1f25bSnK7PpKSCrpYXU6UGhlKFR/QzxggUx7fS9nGnxXnwIK6VV9ftTv2oCwR8tc9Zodn3OaPDqCho3O5eYIY/osp1SfAW7aaq8F4iflDWaX6CBIOpOd2pCamE98z8eMfqPYhY4rHthnod3feNx7VBPjNVU8JoRg0T8pvUyx3C2pAw25VAo7k6xLwMrpoyu6EJfNj3CFUjU7apdF++62wWotIPpEvv5Z+BQaymahOlH3kepq/WrZakfx7rd8E/0tVrJPZLrVOGQML7HWZVRTjYANZ31P5naNu5TqAef4vdZ1JbVpRjgzV5bJMHP+H/ZhO1HhCZRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t71JwrxbT0rjVky+X2nusQtHyVy4hARfzxutCsPbyo=;
 b=ioEIssICypiXbOHxe77nZC339SHX6JYdWkkGMPWH0hqHn3suCWaZGmp1Ywvvq8huIzkIO401EoO4hFnfwpSFrPfu7stwunUNeoh9wS3kC/xp9DQecEoLTAH500ftsX/8n9HUIWmPzXqSw8y7DBujOmy3pD0dtm5HcT8k36zbejc3tQxSw5CirUuJ6OXxMEEbG6gDsscfuzDhr1Oxwc5j22jepP7egJ8rl/82IV2jtcDBP6qSLhpZT5BcdQXVuOjAyCvt1Soj9VVf7pwFKodcO/fkR8n0J6ygOmab7lnar9LG6KO0x4RZp4OFZWSuBxxm0CDl606Ql995lJT4AIAG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t71JwrxbT0rjVky+X2nusQtHyVy4hARfzxutCsPbyo=;
 b=dFecYVEdM3HAZkKz+ZhKzitDhDkjMpFZAdQZqfYnD3B7lm677dc3+NEx7vvlRbcc9DAR8dFP3Fvs/AQU5k+joRY7E0eNStFW6zpvPljQ2fsFId9CaR6IiFlyyUg0SPU7ynn5r+dWKBafY+eqZea/HBAodKXrwmzqhye7s1oC7Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:15:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:15:56 +0000
Message-ID: <1337fb94-3a31-4aca-897d-8a59e7500dac@amd.com>
Date:   Mon, 21 Aug 2023 07:15:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: skip the RLC stop when S0i3 suspend for
 SMU v13.0.4/11
To:     gregkh@linuxfoundation.org
Cc:     Tim Huang <Tim.Huang@amd.com>, sashal@kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20230817134037.1535484-1-alexander.deucher@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230817134037.1535484-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0141.namprd11.prod.outlook.com
 (2603:10b6:806:131::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8417cdd9-1d14-4807-9362-08dba2405f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEeGKapdAHukdda9YIA0cAdsLr8F/RXio1mLjbSfFwdsjw10VtVAGdhso96YhXmwihRIdGP4gpSZYCw9Nxn/KxyOn8VnyW0f95n1LQtcuXd7ATjCUuax0SpKLPQ2wrGhmvdlKFIro5aH7kPjspadB0Q/0A/vWEVg8f1R2Rm4uc7AgF2Y+/jPWEGVg9InjVa/Ap7QYnK1aM1Q/GnUzZHrkSXDCuCEHoQgsf8Xh/8J1EnyX2MQIWkQ3H1gJdpq/zjsbp86WqGSNm6Tc+zxpHkttCQ9ZM0Qe3YievWxQ0ecS3KYJ79AOW4hpuscdv48nTfeo0QxmKFaHSYFilAGjAW1dE8dELdtjSrZYI9fDTQ06nuffVZZMKlRE+oc5ovNuSC16UR6OZ/UbXJhR8GYlTdcyvpRhZVZj60JpA0l1WCytm2M/xg2o7IM8FeqPLrFLgwq0OMuF1bBQoDUSbPPmMBQ9EqwSLxPq70hFdoyhDbkj3UZ+aWjMrAAqNjnz4NyJQt9yjcRrI5SBhtEoMs+4Q/H3k2DT0sqod04KvVZyCXPnj/re5cgCSiORhFsl4FiEXI5q+VNOwj721qVwswV/UfhlB4MY5YyBGp7aht3M5nHceJUK2mZU3hKVJoCHeA0U87mOKp0GfklmEmpGQx2ij3+2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRVanlHeWR5cWRlNmRsaEY5clV4Q3ZQVGFROUx6VU41eHNndk8xdEJzUHM5?=
 =?utf-8?B?YjlVK1d2K1NZcFpiQVpQUVVrRHhiOEdxdnhSb1gvWCtFcWZJVGkvNEtYSHFv?=
 =?utf-8?B?Smc5YUZCSFRnTVVVdmFvMGFoejl1NC9BWnNXa2diYVpIVk91aTArQ1BCaXZP?=
 =?utf-8?B?dEoycE4vRmFHK0JZdDZKZ1Y3SERTVC9xVHJLSjZWc09BZzdRUkJNMkxCOUlU?=
 =?utf-8?B?TUtwKzRNYm43a2d5N0FPRi9XMC9YSVdBYkF2YncrL3hNOUlpZWlETGlkS1k2?=
 =?utf-8?B?QXd4cFhQZEVqWXM2ZXBicWNhcC9nN0M4M3JjVDBBVHYzcXN3MVBQWDVJZW5v?=
 =?utf-8?B?Smc2Mmhra2ptbURYU3phc04vYnZTSzhHQVJjb2lQeVBZSDZKeHV0OFIvUllE?=
 =?utf-8?B?WFVIYlBpK2NIM3E1WGxKOVVzelVzWk5zc0ZtNHhscGpPQUN4MTZ4RjJlZWhq?=
 =?utf-8?B?cXM3Zk43VXRHWnFBRGRURVd0c1hjQy84djZSR1NyRWFNeEhzK2U0ek16MXhZ?=
 =?utf-8?B?N0gzV0xGRU04V3IyZ0M4QURGRDZzYll5SnJSdGlMYzU5U0xRMnJ1Z1FiNFhS?=
 =?utf-8?B?amQ1czJmcXNhdlpXMnVtK1ZlQ2M0cE1zdlh1Y2w0MkQwdTVaQkoyNDlkUUlU?=
 =?utf-8?B?bmtRQndqaWhpWUhubjBXSk54RmFlOGptWVZ1V1F1RmkvSzNLclE3cDYyZE9F?=
 =?utf-8?B?TmZFaWNCODdZMDRYZUJvdmRrR0M1M2xBeHF2SkVFc1crUVdsU3ZqSnFWRWYx?=
 =?utf-8?B?S0UvVXlvenhQaVljTEYzSHJ6UjdqTXFEN1BqQ3hLZTAzTEo4MDZLcXNLVDBZ?=
 =?utf-8?B?OVhKRGQyZ0FMNGhtdTFGSThLekRqUFMvYjhzN0lmb1BNYVAyczVHdDk1aVRq?=
 =?utf-8?B?K0Yxc1Y5MXdoK1dENGdneGRQNVJZRmdDV01tV0ZsZWgyeDVoVGhpaEVYWGhL?=
 =?utf-8?B?SGQ5enpFYUVEVUpZU1QvMFBlS05nd2xXamhhQU92cTRuVEdxTzBkYjNsdGd5?=
 =?utf-8?B?djhoNjlVdEtWMUdPYkxEK0RtZkwzSyt1UTVJemZtN2RzaFZaTXc0R1pmRVFU?=
 =?utf-8?B?Wnk2VEpqOEY1anYrZkJJUXVkelplMFBvaC92bERGZTBwTFZUU2FYRHNvUGpX?=
 =?utf-8?B?eUV6bmxxVlBhMExmZWJFNkdmTW9mR1Z4OTZDSUdkMnBCNTlYMWFabE4rRjBE?=
 =?utf-8?B?NG9zUW1nc2lvTHhMTVF4M0lJY2plb0dJL0JsbkZSMi9nOGRSVDNLUVdGTWFV?=
 =?utf-8?B?ZDNxdE01aGRqT1RJeDkrc1RmeE5RbWVoNFlLcVhRdnVpNlBiVldUQmh0bGVP?=
 =?utf-8?B?MUJ2MmZTRDNKMjFleU50YUNhVkJES2pKdGR6aFJHdmRvT0FwUTlTbFJkTlFn?=
 =?utf-8?B?OXFHUndNWEJVMHVpTjBhUGJqVFdtdHRsbHBKKzhRY1RucXEzWXgxUHZubkgy?=
 =?utf-8?B?WGJxK3p2NjRPMGhnS21tVU9uaitVTXN2NnFpbmZlRGkxY2ZpY1JQOE5LMXdi?=
 =?utf-8?B?MDUwZVVlQWRwTXI1WkZiTHlaODJFeThlSU1jSExSdlpBL3NIVU9hcTdWYmc1?=
 =?utf-8?B?OTZXTFZBZEsxTUszcnN1ZnNWN1Z2d1pjNlQwLzJBNWd0UmgzcUsydTRtbE9S?=
 =?utf-8?B?YVQ1aGtRZlRhK0pSRndrNVZzbCtZMEdsbjczQ1M2cFV4WUpuR3ZqWjVhQmtJ?=
 =?utf-8?B?d0RhYnVkZXZ2K1NpcTgvRFE0bEk4ODlyV0ZNWFB2cmpQc0pTV21WOVM1bEJ1?=
 =?utf-8?B?ZkgwVy8vcHNpZXhKc2RERW1nYjZQaEMwQWh4N244UmVLbFJHMW80S0pvU2s5?=
 =?utf-8?B?ZFBvVDFhM2JVWHNkUGVXYWJTbVZORWNpL1A5UjJuMWw2Q1BoRTE4WHVnd3VI?=
 =?utf-8?B?L0R1aTl2L0pzeFJWejJNeWtrTFQrZGpESDM3S0V0WXdOWktqUHluWTFlcEpJ?=
 =?utf-8?B?Qi9QYUNMYWcvNkF2ZCtaZ2RYc0J2UFlmdnppR2FsMlNhRDROd3dXUDY3b2NW?=
 =?utf-8?B?L0N1L3lUK1hickEzQnNUa0VqbVY5b3ZPMHY3Z0w0ZVhvYU9YZ2kwY1lXaEdw?=
 =?utf-8?B?ay9jWUFpY08vVzVQVnQ5VkJJajNGN25vaHo0a21wNGhOQ3h5dUNZZFBLa0Y0?=
 =?utf-8?Q?S+iJwf+sImh7ooZO6jgOOyVZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8417cdd9-1d14-4807-9362-08dba2405f22
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:15:56.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ugke7ZzoJL2YQvcPYEV4T2b7mucz1hMPDrYGJ1D3EKCLStK+vwFmtmJq8g5YnjBrHj3K00mXEuOsWcRNgpBc2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 8/17/2023 8:40 AM, Alex Deucher wrote:
> From: Tim Huang <Tim.Huang@amd.com>
> 
> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
> the firmwares will handle that properly.
> 
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 730d44e1fa306a20746ad4a85da550662aed9daa)
> Cc: stable@vger.kernel.org # 6.1.x

Greg,

Just want to make sure this one didn't get accidentally skipped since 
you populated the stable queues and didn't see it landed.

Thanks!

> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ea03e8d9a3f6..818379276a58 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1573,9 +1573,9 @@ static int smu_disable_dpms(struct smu_context *smu)
>   
>   	/*
>   	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
> -	 * for gpu reset case. Driver involvement is unnecessary.
> +	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
>   	 */
> -	if (amdgpu_in_reset(adev)) {
> +	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
>   		switch (adev->ip_versions[MP1_HWIP][0]) {
>   		case IP_VERSION(13, 0, 4):
>   		case IP_VERSION(13, 0, 11):
