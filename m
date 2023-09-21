Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1ED7A961F
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIUQ45 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjIUQ4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 12:56:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454011A7
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 09:56:32 -0700 (PDT)
Received: from CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 10:53:56 +0000
Received: from PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 10:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF1ciKC7gTiSeHLuvW7oN2T0GQC73wGaUGgvjGG+YWrPg0gB9FmHxpzLkdC/EPoeDBMaQEz3ASzcGI/bZnR9YuIqlsIOa+1WEUnRuahn30B8MLAJbRNHoAnuPEUhruG9WBWVoNKorQYswKSyNORty3R017d65USnt163n1T3ts49kgBBjsWROwQdBw7pGrvK56HhUj2H5hj4WnJLZT/k+MZ6gK9awudqAGCgWvS+B5lbRhH2Lz7sYza46C2J1WbVIyP7Xfi2gKM6dXeRCdbBF2qlA31GpJWGgGOYSC7uglSCprbx63Qrw2EA3jK3mRE0V/fGRnKxtcIq/GWZSSw+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4WvB4bcOCZwMMXECJ5s4RKgnPqXt2E5Jx5uoaPHsAQ=;
 b=WlBZ35rVXPZdGrAXnb3omuhgFbdQ4LJ7ZU5klGJ8IoBNErYXPejwbZO8wI7/1DelNxykrQ7qncpKGjHNi+oPuCnrWbAz7anZAQSKX+3cJo9zen0M/p6oxQE78gSO21oKOXp77E7IkobLfG96zk+OBl4phLiPzjVoesvMNA2VmzqtnwPUqbGM+MxYG4NbYBBqLjciNCZfMMTeBpHCrUR2tyxygAtDWcLUpH3cJzMD8NUyioYZ50V1FcrBm7kYe030+5XXWDZJAHtJ+l4lX6yVToklvwq1bRWKsCWoneHOWN5n2I1qtZ1/h/2txvpizi3gjOZMdb1NkQMStz5+FVws6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4WvB4bcOCZwMMXECJ5s4RKgnPqXt2E5Jx5uoaPHsAQ=;
 b=qFgKnyfQld353aJfFyCyJ4ZRW4UWeisJyHqN6MSUfw8GnuDcsP+e+j1j3MSEEwBtlpy0Bds4W+Jpry0YbjZdbuWzx4vJ1rZsTuxMIVZzfWPuYqWuwP5TSEUVPPLxyi9BR/5bufRrbpy4NOJAS/DylnqyGcC1IVFJskjFdCc1qPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 06:05:44 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::a67a:d5d:8219:56ce%3]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 06:05:42 +0000
Date:   Thu, 21 Sep 2023 14:05:31 +0800
From:   Lang Yu <Lang.Yu@amd.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Aaron Liu <aaron.liu@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan
 skilfish
Message-ID: <ZQvdK1e5XZB1jRII@lang-desktop>
References: <20230921055421.3927140-1-Lang.Yu@amd.com>
 <20230921055421.3927140-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921055421.3927140-2-Lang.Yu@amd.com>
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To MW6PR12MB8898.namprd12.prod.outlook.com
 (2603:10b6:303:246::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8898:EE_|PH7PR12MB5950:EE_|CYYPR12MB8653:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fe81d3-fe47-4bee-5b79-08dbba68c934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jgj89PR+iGteNNJaJyYHJgfwMlRByGQKGgM+B2N5kPGMJVmY4t8rrUQ1WR/v4PydYcxLeT4KMnZp7OJyYaOxjL99g1OtauxuX8US5ct+OhO+XM1ADIZSh1VQqO/taym72LtkHjtxrXuQfB9iQ+u1iMU4T6UhhW39D3iUNRsLhekisvj4xJUQ8+H5I4EcT3rVvuKZcBiPA1WEaEhprLy9Z9JvYAIbEVRci1oE1PJtncmhLiiv+EvDZZGv0dAtZc79pqBwF4Fb6c7d3R+BK8qknVPXalZxFdjjM4lLSDXFPrloaLSKdJWxJJbHcH+9hAC01fDuHTDQa7Wq3+D5Xbfn4tlp+pAjZsFGQiDSVlSercd2saEOA8B8ov1otI8p+IYYYIzDvcT+YYMIJ/dHhCJxTG2Sif2AYTvcuhE/uwN7jMPCEhNTrX9Fe3go1KltEHRtlRWi4dfT5OysiTyPXVKWYjUvgNcSLablWoaJp5nx7Dg6UGuVLx49OZJYIG6KJB+9E25MhH5QsIUu0fXWfPYvJbEcoHmFepH90Blm31ep538VeLik/jEEYZ0wSPc1tlSb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(451199024)(33716001)(26005)(8676002)(8936002)(4326008)(83380400001)(2906002)(5660300002)(86362001)(6506007)(6666004)(6916009)(54906003)(9686003)(6512007)(66946007)(478600001)(6486002)(41300700001)(66476007)(316002)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nK+tF25fzsavqqyPdNEgCJEDyxojwoyq0K1bZMgaxTBpZQIpfxoMWCm+Njp1?=
 =?us-ascii?Q?nBStERnEaaN88VV4ytysy3zaNCKd0Gax05KNWsjNg3+5k0/PfEs2JLkk0ADO?=
 =?us-ascii?Q?G1Nh53zdJExfq7VXbsMvd4goTmIwsClHfkbxlufhTN3xodfKngzSBWi+iBll?=
 =?us-ascii?Q?s4qvIcfamGGVm3tSer4bVeKV1MfYFbFE11/oM6yeW9wlATNx01Xf+efgL/Kx?=
 =?us-ascii?Q?+U4ajv2qm2+0LM28ZAdFG3cS6EkS7939a3DTsa3L0ohHd8MYWPhbSuSOks7b?=
 =?us-ascii?Q?il8qbfWMbaBqpYK0qbPAGjR8SwJMWWk0Rdkj1E85V3znlwNP5XddTOXGcBHe?=
 =?us-ascii?Q?PONxrasi7otBhWm6mcK4GZfr6Jn/RhqEqo1u+olyvlcufpyYOROCX5Ve1XJ/?=
 =?us-ascii?Q?Sg25l7vcXo4kfYCz3kFgsRXg4forj7o2QZ3EB7apwVpQh0SCACLM2G8X58M6?=
 =?us-ascii?Q?vzCQOLabQg5F/gmsPalKyZJgw3SaYaQxpiX0Jl5hMC+wDYBtds0ydIeMP3BG?=
 =?us-ascii?Q?ux2x84IVpejZZORDeWXgm+XPbmWxJ7CxqHiLD9GJSIXGHLCyfMONHB6h7NrY?=
 =?us-ascii?Q?eC5crazZ77SC//I1H8DCcTSRVuol8SCsdi+n8Tb29/75eDqj2d1eBtqqIlC/?=
 =?us-ascii?Q?Rr4KrpkA8/W7TkjwFA0IQgRLTsebFIUBRWDNgPp9N8Z4M8lkKktkfzyeECtT?=
 =?us-ascii?Q?XfhXZK/pDawAU1zryV84BnJd2OIjVStjZd9lPNpo+l5r+qYumZY06J+OACO1?=
 =?us-ascii?Q?eQ1OcNnes+uA1oZCX0cMt3Ed7/PBqbpYIFZWo0L06TsBx33Oz8q1WznDM1vU?=
 =?us-ascii?Q?7loqVoVU1dIIAbTr7DKHqtj+Jq2825GCZ9qY1v2F/lXtop7jpWfwj93YYP8Y?=
 =?us-ascii?Q?M7BXGSlzRAWa/LE+FOUzaflF7hl6VXEzOBNS+OiJzYjqNfrvol1NbqRd4/Lq?=
 =?us-ascii?Q?dIzdbh+nAkr4S5vjWaULcXYADW9AzjQAQD0vxiyYy9ghR2A+K3ToaYnkHzhi?=
 =?us-ascii?Q?CmW7A+I+Pl4YlNXQuOGwnh83zCjbYvUqjJRzWVxhUHwCh9ZqP6+Ebz1UyFi+?=
 =?us-ascii?Q?n/+tH85rYNugNdN1eXzUhNuOmTEjonNHH3Q4tTKL8SPc9veoknfirIOrgh6Z?=
 =?us-ascii?Q?zcyPXE9eF6I7RxhqSQ8D7cazroQsaG22WAu3Z8SrIJl/A5fxBn2E3O4bcUK6?=
 =?us-ascii?Q?YTQDvmbWfMmuIOc2OlGCargtRecdKhDWlvBj5WtIlWFkm15CKDaWPEeiA6Da?=
 =?us-ascii?Q?QM9j5tG32xPXbwBIndmqmIUfTGIWqVpTchLJa52YJ+9bQqfmNBR1QSYlzqBH?=
 =?us-ascii?Q?4+Azxu8H0U6R5b4XcqTuZWoXnNQbjn9z7WH5WEpL9UnBKq2woUDxzhW2VVq1?=
 =?us-ascii?Q?NIP+ZeCIOH+6Lb3w47CNoF4IFcX1u9WOXbn+z9lKLHGRCbp/MU+6XukYIAcF?=
 =?us-ascii?Q?c4We0kv6UuH6xmUFre/Go5Sf2OxKw1USTDoiECgFKAiszQdVRzdmi8wgOjp3?=
 =?us-ascii?Q?SaJ+/AA2TXj/OJOCO5o7nboV6HP95tBE8/mmQ8VVtV22bVRXSIhvHc1p6tX8?=
 =?us-ascii?Q?U6ZygzijPQ4j8154ijyqq9tMq6ydMqtzT5Vktpf4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe81d3-fe47-4bee-5b79-08dbba68c934
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 06:05:41.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2C7ENGFFITDCoD3IFpRbUdvS3z9PgIm5y3/BYtCkEZypr0i+91J+i6uerwLf6sgcjp78GwQ7qJsGy+KWqISpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
X-OriginatorOrg: amd.com
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

O 09/21/ , Lang Yu wrote:

Sorry for sending this patch twice. Please ignore this one.

Regards,
Lang

> Cayn skilfish uses SMUIO v11.0.8 offset.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1d671c330475..c16ca611886b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -102,6 +102,11 @@
>  #define mmGCR_GENERAL_CNTL_Sienna_Cichlid			0x1580
>  #define mmGCR_GENERAL_CNTL_Sienna_Cichlid_BASE_IDX	0
>  
> +#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish                0x0105
> +#define mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish_BASE_IDX       1
> +#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish                0x0106
> +#define mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish_BASE_IDX       1
> +
>  #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh                0x0025
>  #define mmGOLDEN_TSC_COUNT_UPPER_Vangogh_BASE_IDX       1
>  #define mmGOLDEN_TSC_COUNT_LOWER_Vangogh                0x0026
> @@ -7313,6 +7318,22 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  	uint64_t clock, clock_lo, clock_hi, hi_check;
>  
>  	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(10, 1, 3):
> +	case IP_VERSION(10, 1, 4):
> +		preempt_disable();
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Cyan_Skillfish);
> +		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
> +		 * roughly every 42 seconds.
> +		 */
> +		if (hi_check != clock_hi) {
> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Cyan_Skillfish);
> +			clock_hi = hi_check;
> +		}
> +		preempt_enable();
> +		clock = clock_lo | (clock_hi << 32ULL);
> +		break;
>  	case IP_VERSION(10, 3, 1):
>  	case IP_VERSION(10, 3, 3):
>  	case IP_VERSION(10, 3, 7):
> -- 
> 2.25.1
> 
