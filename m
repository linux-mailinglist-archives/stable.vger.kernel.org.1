Return-Path: <stable+bounces-6776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEF813DF0
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 00:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE101F21220
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588936AB88;
	Thu, 14 Dec 2023 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xcLi5TBL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B376ABA0
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVCcBC2pfrI4FkgXHJ6D5U2bu/QGCvHn7lRmuGyokkn3AAyqxMulaJgJt/Yl7f/MgKQxayroCJ08H2aXnBO0wLOcPEzkcCAE6nMSerpGBxR0/uxCRWuP++3VnZTEhmRvGgJ1dIIpQ4cWO4Gsv1urLk0EwoMSF61OiJ9n0WsSvhpAwEGHTeRBOyOjazlwPzZ2dLz7havuwD6HfMAIzIYHPlqEVRbxaGy9CAnqacvb3U9geCtx72p5ntz5itG/K5A2+lUkkXDvOgmRsgi4bRtariiOur/83sM1zdO0qE7bsXGcJ+uD1WAW05olGa32x8Pegjqrz2LsxmFBt5fKSwTZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wMYFdfom5YWGiDIYJI5L+kM5qHg1XxIIsFM7RxWXaw=;
 b=KJNKFqUxDYbH9gGmctnAgpRxUF4PR+oj3zzZgTB8RXkiL1mpP10gYNZHZ/JKhTwpBF/gDfYLVhX1K30SiUT4sRR0rK9Jq1ntTCVxxGf9FcNVTVc266g7P2lw5XsRuEZqrZ2D+HWOIfuPmgbfiJIcaxOldk2ZSdjXelso9wbqsnCN0PukwUSSoNxYUSc7TBSUMusr5sD7DyE4srWcn+vEBldmsol8KqioFmKJNiJcnSfFZud0m8O2HNRoTG24MC9Xcx1Bzj4BEwL4BZY6Sz4Wv4A4xjHbgatma/LH/vbYNfN/bMAmgRfGvSwNG+IqEwgg82om2/YuRtTCoTxzqqc6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wMYFdfom5YWGiDIYJI5L+kM5qHg1XxIIsFM7RxWXaw=;
 b=xcLi5TBL2eNSOR/pJ1CTOw+kRnbWNCEDyyrzDyHsy0PTL7jzksvG4AgauCgKseVd2PxTq44NEiEOeDHcq8WREWVPIXLwTSXt+v4HII4OBMbV8t1r0FUf/htNSfvsd1HxQUT48xe9V3bH+iegWZTOm3xas324B3tFTzTna8CWPEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:55:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:55:34 +0000
Message-ID: <ac107b91-389b-4ab6-8a17-75fc6e435da1@amd.com>
Date: Thu, 14 Dec 2023 16:55:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail
 to flush TLB
Content-Language: en-US
To: "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20231213203118.6428-1-mario.limonciello@amd.com>
 <BY5PR12MB387371C0360A45B00A7CE838F68CA@BY5PR12MB3873.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BY5PR12MB387371C0360A45B00A7CE838F68CA@BY5PR12MB3873.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:805:de::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1555cb94-105e-4dd2-c048-08dbfcf7c791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yt/TrP1jeLUXom+a7K+duErJx2hrzWWCmRjKSvtd2ipP9dguLCD8Llp6QMlv2VKcKDUkXEpT3HWz4T6M5iDmv0rEBUcrlnukW6H2W47dWxug8x4vv+zWfmRWlImvG1jD0i9pXUg3jgvmEeK4WMyEkqaXA5RKB0RiLD35f/JVcoLbNk6C1GwVf8jryFReH2Wi6e2TG9RCFnDkUMYdwWxxu+lWSqqVKxLTA8QD7lh7pZYQaoqng+X4xfEsvGCdRv8VNFjTcrCKCXqjSmsXoqDsooGcuf//lOx6neStbRfUR70JnIcPhAHpTRa2eVcbloqtfoH1rM4CijsNKqj1EBM7mr2jfEr7G+ZRDUTHNzsD0HqCgTJNQJRtUhwSTmNRIxXgzeVS+8ps5g/Rde0D/0caOF24m1HfYZztGkI6vkiWJzJ/Xz8hSj+hyZG2icSD9Nt2vINMlwsc8paQMkh8nJISW000JhoDJGSu7Zn2+M+eGSTRyrkI7/wkTR5MQ9jK0SHzh5t9WFgUWj90jmIpJp+++GiFvG6M3+St1+SvPHMtTYyOsSk1KYYAc7x4Amss7IbhOaj3AcujJRHIhsc9lpGuuy9D32hE9ZY5cYUer2l/mOdHOSF4JTPf1Uwc/rXzVLpG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(966005)(38100700002)(31686004)(26005)(83380400001)(2616005)(6512007)(6506007)(53546011)(5660300002)(2906002)(8676002)(41300700001)(36756003)(8936002)(4326008)(86362001)(44832011)(31696002)(66556008)(316002)(66946007)(66476007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnRkTTRrdWFrUzc5Zkcvemp0b1NkVG43dm1QZ20yWWtaTW5SMHYvVWxFZTFt?=
 =?utf-8?B?am9qcUtaTVMvazdsc1J0bmtlZWI4VEp6b2RBdDRkbUp5SU1RRVV1VE51L1dN?=
 =?utf-8?B?MXNlbzR2QmxUYTF1U0NxNkdZWjJtUm5yVUluajJWb1c5TWhjYk10VFF1TDBC?=
 =?utf-8?B?Vk9scWYxZngrbll4OEZxV0Q2VUloTjB2SFMweWNuYWo5SENYYTFpRURmWnZQ?=
 =?utf-8?B?eFA4bDdRczNJeVc2d2MwL21LWTU0RGI2dlY1TCt6cFVFc2tFM09tK2ZOUGR0?=
 =?utf-8?B?Tm11Tnp6NzNzd29WQWlTQVJKMjRyYThKc1h4S3RBQ05lVG5aQTdPV1lVNE9M?=
 =?utf-8?B?NkFFMjNlNUJFVFd5RkkzdkNhdGZZSkozTW5rQm0weVl2T0RKV2c2cU8wTWdV?=
 =?utf-8?B?N295Zy9WcnFWV09ZUGdRQm1DR1Y3bXNCTjZzWkR1akgybWlQdC9iMVAzRGVx?=
 =?utf-8?B?Wlg1a1JKL1lYcTlESmY5Rkg3NFRxQnJBWm9CT0ZocUJqeDRVRXA5dHloYSts?=
 =?utf-8?B?MXNLcVdJMzlCTDNqellYelphc01ka2l0d20xVlBNVnI5RU8xWk9BOVNGSklj?=
 =?utf-8?B?aVMxWkVwbnBvaDRBR2pIdUlCNC8vUU1XQmZRU0RmUXgyUG01QlFIQTJCQi8v?=
 =?utf-8?B?cytwLzAvbGdXRVZqRThFQ2hDTzlyZE5CMjNZQ2tGVE94bWx3bE85RU9rMVNu?=
 =?utf-8?B?K0djai9aVHIrck1MSjEyZkxyYll0djlSRGprZ01KSmlNSkZuN2piSkk4WWxD?=
 =?utf-8?B?V3lOZVFUSlp0UFRPanFDZUJtMHgrbkVISi9OSVVmOGdtYWhqRU1BNk1pT3JX?=
 =?utf-8?B?RmNMejhYUnpONzVTSk5JYkp4b2h3Y3ZRRWpieGxMUy9VaFlOR0dIUzRDcVZT?=
 =?utf-8?B?YmRKWG1rcU1FbFl5aGFsS0k4ZmNheVBtL2d2eWdqakwyTktvOUh4cjBNRks5?=
 =?utf-8?B?cERLRTNYdHQxY3RZcW85UWxmcC9ZZkhuUU9XbEJEWlhUV1gzaFYwc1NwTDJa?=
 =?utf-8?B?cHpES0FZS2N2MjNrRHFXWmVGSEw0UkJKWmloK1hBSDJTWnN1VVNSSWl3Rm9r?=
 =?utf-8?B?L1B6SFV3dTVQZmdiT3hQeE5IUVhNa2VkaFU2bE9TUW9sNmFuaTVaajBNUGxu?=
 =?utf-8?B?MkhPZG5PZG0vcldvZUs0bXR0WGRKZXJ4Rm9ZaEhvV2JHOGRodkpqaU1ZOWhk?=
 =?utf-8?B?SlpvMUF1N1oyNWFlQnZRSlZPN0NXVzlQMlV4Yy94TzVHclI4Z3krL1JoRjE0?=
 =?utf-8?B?RkZ4bHhWZThzNHJ0cVNJazdVSFhwTUpxUytHb01YaWNVdHkvb2Z6aFZ5Q1Nq?=
 =?utf-8?B?Y21KUGE0RDlsZkVRaktHZjBNMGNIT1lYQWYwZzczVjNnUHF5eTlOODcxbXpk?=
 =?utf-8?B?NzFGbDY2QmdSaDV4bkJUUjVOSU5tcnd6TWIwMUtlWmNBaU9lcVpPRXkyOG1W?=
 =?utf-8?B?WjNVRmlMRDBFamI5S05qK0NwZUhoTHI5dFU1UFFVeFNyR2xmTHo2eHRWWkdt?=
 =?utf-8?B?Q2t6aE5zRmwzOEpBK2dZUEVqcDhGM1NuTUdpSHlvdm5KbjdpVXZsakRoQXl3?=
 =?utf-8?B?Y1VibEdkRTJ6OTZYUm43MnlBOHBwbTFqeFFqbGU1MXcwSk8xOVFqQ0o4U3Br?=
 =?utf-8?B?T1lQMmdiaStGWUFIUFlwRWsxYjlWWkl4R081d20yc0NvSmROck91cG52SWFO?=
 =?utf-8?B?Mm1YYUlaTXBsSnJ0dkJNSVBpZUZOUjhHUDFiMDMxa1ZHV2w1SzkzTll4YVNR?=
 =?utf-8?B?RHNZZTlRa2NDYzdxZDF2NWVhckhFYnlYK1o1RFllK3Y0d0VoWDhGUi9xcU9B?=
 =?utf-8?B?VktZcHh5NFNVZUdMMG5qZU9BNzJLY3MxeXRaZERxYUx2c3AveTBwa3JIM1hs?=
 =?utf-8?B?V3hQaWFld1Z4MEx0WGZFK1lJMjJPZFlDWkxaOHEyRXFPV0J5RHJIaGlYdXh2?=
 =?utf-8?B?eWZrc0thOTE1UjBic1d0RE5SREtDL0p0M1lNSWJERllVNlRVVEhTYmR6a2hI?=
 =?utf-8?B?UUpycE1WQkt2WTVNVWUxLzJFaDZmb2tkZlpVS3ZaYnhZeEJTY0pwcHhIalA3?=
 =?utf-8?B?WUdtMG5zVUNTRkI2cVdReTRSSjdOSWZjZ0YzVmt4dVUvZEJDOHZvS0NlTXpt?=
 =?utf-8?Q?AxZDSy8X+SMNeCh2UEZZwBWhs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1555cb94-105e-4dd2-c048-08dbfcf7c791
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:55:33.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XRaMN+A3rVkOQ6h1nVI9BRw2pqu12wnpHIE1zGlwsM+75vGL+uudC/t1CQfi7j5eNqUk187ka8jDKU3VzBxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

On 12/14/2023 03:53, Huang, Tim wrote:
> [Public]
> 
> Hi Mario,
> 
> 
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Thursday, December 14, 2023 4:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; stable@vger.kernel.org; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail to flush TLB
> 
> Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that causes the first MES packet after resume to fail. Typically this packet is used to flush the TLB when GART is enabled.
> 
> This issue is fixed in newer firmware, but as OEMs may not roll this out to the field, introduce a workaround that will add an extra dummy read on resume that the result is discarded.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Tim Huang <Tim.Huang@amd.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Add a dummy read callback instead and use that.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 11 +++++++++++  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
>   4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 9ddbf1494326..cd5e1a027bdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -868,6 +868,25 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
>          return r;
>   }
> 
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev) {
> +       struct mes_misc_op_input op_input = {
> +               .op = MES_MISC_OP_READ_REG,
> +               .read_reg.reg_offset = 0,
> +               .read_reg.buffer_addr = adev->mes.read_val_gpu_addr,
> +       };
> +
> +       if (!adev->mes.funcs->misc_op) {
> +               DRM_ERROR("mes misc op is not supported!\n");
> +               return;
> +       }
> +
> +       adev->mes.silent_errors = true;
> +       if (adev->mes.funcs->misc_op(&adev->mes, &op_input))
> +               DRM_DEBUG("failed to amdgpu_mes_reg_dummy_read\n");
> +       adev->mes.silent_errors = false;
> +}
> +
>   int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>                                  uint64_t process_context_addr,
>                                  uint32_t spi_gdbg_per_vmid_cntl,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index a27b424ffe00..d208e60c1d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -135,6 +135,8 @@ struct amdgpu_mes {
> 
>          /* ip specific functions */
>          const struct amdgpu_mes_funcs   *funcs;
> +
> +       bool                            silent_errors;
>   };
> 
>   struct amdgpu_mes_process {
> @@ -356,6 +358,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
>                                    u64 gpu_addr, u64 seq);
> 
>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
> +void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev);
>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>                      uint32_t reg, uint32_t val);
>   int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 23d7b548d13f..a2ba45f859ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -960,6 +960,17 @@ static int gmc_v11_0_resume(void *handle)
>          int r;
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 4):
> +       case IP_VERSION(13, 0, 11):
> +               /* avoid a lost packet @ first GFXOFF exit after resume */
> +               if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900 && adev->in_s0ix)
> +                       amdgpu_mes_reg_dummy_read(adev);
> +               break;
> +       default:
> +               break;
> +       }
> +
> 
> I tried this patch on my device, but it not working. The situation is this dummy reading not hit the MES timeout error but after that still hit the same error in the amdgpu_virt_kiq_reg_write_reg_wait. Maybe the failed case is not just the first GFXOFF exit.
> 

I think we might be seeing two issues that manifest this way.  I can't 
reproduce the issue anymore on an OEM system with
IMU 0x0b012c00 / SMC 0x004c4600.

But I can still reproduce the same issue on a reference system running
exact same firmware.

Let me ask whether the other reporter to Gitlab could reproduce.

>          r = gmc_v11_0_hw_init(adev);
>          if (r)
>                  return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 4dfec56e1b7f..71df5cb65485 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>          r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>                        timeout);
>          if (r < 1) {
> -               DRM_ERROR("MES failed to response msg=%d\n",
> -                         x_pkt->header.opcode);
> +               if (mes->silent_errors)
> +                       DRM_DEBUG("MES failed to response msg=%d\n",
> +                                 x_pkt->header.opcode);
> +               else
> +                       DRM_ERROR("MES failed to response msg=%d\n",
> +                                 x_pkt->header.opcode);
> 
>                  while (halt_if_hws_hang)
>                          schedule();
> --
> 2.34.1
> 


