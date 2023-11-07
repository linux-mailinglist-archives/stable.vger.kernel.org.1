Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E577E480F
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 19:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjKGSRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 13:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjKGSRR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 13:17:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B1B3
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 10:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik0PnPd7cy6qpmV1kdhB1FsURZXIdn+nY89cuUijfX+JxiHR1BF48E6QkZ16153k3cBBs33RZwuJwGe8k9/Kx7F1CwOmOcbpQ6jbw7wqD1RX3I1ZTvHAzJLjk+H8sIji2zoZvGPbhGfxmYHQiMplvbUxPRwOejyCxFdyV0ztGG5lqpRnQXh+qEB80YhzOaTSJpzYcqgLhYlDkzQT6O6b1W+vX5UZ4GvsSSb7aT7JbskNuiaHOBVrN6glD5omtUfNFxpneGQuPEBWDW8mxmX2SrVhZIGqmhtVrc5zNw+XHxCYZWiPMs00o/bNKIzDjJI+KfFZOOHvAwU99NGIW58vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBjUTJ1ii6Lh7QOm9yOLt7CGd3hgLw5w2vyi0A5Hics=;
 b=YtxPSRA4ixBv5+DevoBXUBKmdLS/TblxDqfa+WpVcv3A+qe7WZZRvQjhvrQATJcInv+FostTdRW2BjijBSu/oH9vN4Z40JVUXOswSIkP6Pimle6SDd7mQJAMMVo+G+Yr8xfjn0OAQAzoQxJjCqGBkSdyxAdWEdGpSkSo8iXGNQc61IiCrZWln/A3HbtIAH7ve7LlnWw62hbatsuodkmLKqLAIS8d2phaWdYDltOOHlO8ghDFmDKf9HZeaoZBkimXWro43EkW50ID+D+ziutV48tJrlN79Qf1qIjIKwNxP6kUM1QEXt64LXVfaEM0Zfj4WvFmL4Wp5/Wr9jq4PNVOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBjUTJ1ii6Lh7QOm9yOLt7CGd3hgLw5w2vyi0A5Hics=;
 b=pQbeuXqUTDXb22t1Op+9E5V+yeMQW8OjZW9QCn2/Gwk6SkDkr6M4QaBSfHNrSxCPsrl5tb0pVrIQJYHyCwYweoVlLQJR8UWFRLBnYAE6mVyQSqBjWpo691QWSPywutg7M21xGiFsHljFYGrgVvzz9QygEJCQPkv5gO5s6dD8Wxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 18:17:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 18:17:12 +0000
Message-ID: <5d6c34bc-f7ef-4681-ad3d-ab2f1a792b72@amd.com>
Date:   Tue, 7 Nov 2023 12:17:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
To:     Li Ma <li.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Alexander.Deucher@amd.com, yifan1.zhang@amd.com,
        Heiner Kallweit <hkallweit1@gmail.com>, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
References: <20231107085235.3841744-1-li.ma@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231107085235.3841744-1-li.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 866f3691-b854-4c07-4871-08dbdfbdc36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oORqD42KD4Soyhn4OvcDFp/KKB9nWGZrRu2sKl7h+xxOPjCoAvRsCoi4v5jVf9jM2df2rhgG0EPAALjSpiAoM6cl3s48mNZ4YyMwlaNFv0esg2+PoFvkxfxQv4HRp6zIwuqa2C5ATQ0GLmUk3VX0a+ocZDSx+dONNiO0IkwHvRx3aC0bQkKeM3RDj8T23krVgMyOlvA7UKkC/nF/HrHPdBlXBj88pOP17RhQeIx99H6izWbXxeKPRr/qZU9ejr6GBUujKLfzM/2nDKpsT7kznNGfd41wgrO8gvz0jBP+4ooVTmscc+P46MDxjTmT6BhBvaWz+iRchzzMxsAp0XrkDh3DTfroggfmhcRYCXt9qPUmuEheBvzNTo05cNNoKMr+heDtqL8jEEJUJ2blJRg+FUmk9xbDJJj2Tl7PQwKh8s61MGBeVc7opd1M0Gm7BVcVMXSt8qnZ9ZfiTv24aOytZ3MYHlcTRXzaZtl0ZLcINEm2RUVbagsUxkT43tK2npf7m8fNvcBJYp/WDBsBFrDpoVqQLDnGq4LgMiC3r9CR/L9+Yg7jY00hDqfJGe0iiE0mQt1Tb3usqMm/VyHzt1HQRgE1O3575crtymqUesETqeV6v+UnJ6tyUgEVmAT8XOJHd6VCn63l2QYhI8s0UqybxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(6486002)(2616005)(478600001)(966005)(6666004)(83380400001)(26005)(2906002)(41300700001)(5660300002)(54906003)(66556008)(44832011)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkEwMVRoMDZoOGgybnA4TXB1UWd5dHFtNGgwRmcxSWxMaVhobUEvTmZHMUM1?=
 =?utf-8?B?ZVZES0xmMng4WlBTdVVFTEk5S3ZqdlUrN25iZGpGUEdzMWR6S3ZQTXlqRU9z?=
 =?utf-8?B?cVErMWpYZm5BVWt6NGFpOUUrMUJzMTQrS1lLeXR5NHZXNnQ4MzJWVGlTUnZ6?=
 =?utf-8?B?NVhNcWpvZndzZ0lobGhlY0RlR1ljQmNEK2RtV1lveGkwWDhRSTNUNDlYTWpy?=
 =?utf-8?B?UzdsTXAxdlJvNTYzenptM1ZRcFcveTkxVGdRMFVGS050ajRZdzZZN2g3aXRa?=
 =?utf-8?B?OEJlZUV6Z0FvN3BUZ05nQTlBZ0lYNnNZZXoxZ29LdUJrcHVCdm55UU1mWFpj?=
 =?utf-8?B?amNoaG5ubU1MTmRXaW1MK2xIU1QzK1I3RGZGZkgyd2dPZ001TTN0a3BKTTY3?=
 =?utf-8?B?WFJoRkhDcmt1UnF3WmJ5VW03NXBycnU3bjlENjlYZVQ4U2RwdWFhOVpRUDJB?=
 =?utf-8?B?TUV6UUFvbFFFQWxwTURvc2tmRnRWWjNRaXJqbUt3cWM1czd4amZHbE9jOTZ2?=
 =?utf-8?B?MjhDcUFhcXNQbWpGaDlsaSs5ODFhcWlIVmF3b25hMVdBUms1V3ZuTCtXWCtC?=
 =?utf-8?B?ck40YUlubldDQ2Iwc01vellRV2tDQ1ZobmM4RzZvNEI2OUpRam1ENjJVUTFw?=
 =?utf-8?B?S3JzQXg3ZnNlVXhhRkZOWTlXYnVMZkVjY0xlUWpVOTFPY3JLdzVWMmFQazgv?=
 =?utf-8?B?bjdINjFZR3FETlUwWlNFREp5eUtsTmE5VlVtZmw3cWpicFlOWHFXMjdReTJO?=
 =?utf-8?B?czFySkhBQ04zMEtIeXVOUGdYTXRhRmIxY2RtR01Hb1ZJaXpQcUs3OEYvV3oz?=
 =?utf-8?B?Rk5xSC9OMTZIY1p4NDJOSWRsWDlzdVhBTGsvT0ZMbXp4bWNSRUdsSG5LdlZ0?=
 =?utf-8?B?S2tvU1pMdzVUWEI2aWMyVDJhdElqdW1wRVY4eS94N2NFbUJsZWloUTNkMmJQ?=
 =?utf-8?B?SVlqQjVleXhUcTl0aDRhYVozb1pnSHI4TG5BNVNqVnd6YlEzQVhIV1ZuSTQz?=
 =?utf-8?B?bjR6cXBYKzdBOXd0Y2xOMTNsTTJMdmduREtSZGFsVTRCV0daVUVLRWp5N3JV?=
 =?utf-8?B?K1ByUnhHSUUybXhNWlNrNXFiZHg2UmhDUkg3QXFibWpHU2dIR2s0Tk94SHZQ?=
 =?utf-8?B?b1N3Qk5WQUhuUU5ON3ltdjdIWSs5M2pwQlp3UWlNSVZCaXdCbnR6dWFkU25Z?=
 =?utf-8?B?SjROMThqT01UZUJMWmFlYmJ2Z3U3VFpmSHYwbnFXK1RuMmpXNnRGZ00xeHRT?=
 =?utf-8?B?cjdSdWZLc3E3WXlVUkk3M3haeU5MNjUzQTExcTZOQkI5SUQ2R0FDWHNXZ2Nk?=
 =?utf-8?B?dVVPQy9HR0FlbGtnd2N2TFM3WkUzOWp1RERqQnlQK1psMHFlcU9EdXA3U2xN?=
 =?utf-8?B?aG5DdlYyd1RIRHJqRk5FVklHUFlhbk9iRjhkZnBHbVBwZG5QaFJyeExFWTRR?=
 =?utf-8?B?QnVvWFdoK1FWU0oxMEF4bDJ4Q09qaDIxNUJXNExXSDlQRDl6RkE2LytOL3lM?=
 =?utf-8?B?K2hiUXNZM0EwNmVQKytvSDkxYkFUd2FPenRGS3k4VCthQ2h4UTlUeC9OS1Er?=
 =?utf-8?B?VU9tVWRxNzlxamIvd0pia0xyY3o2eUxqY0N4RnJkbmI2ZzRKZm8vUlpLUFd2?=
 =?utf-8?B?NWFnb0Z6M2xKZkR1UEw2Tm1tTHdsQUllWVFIWFlScTYvTFAvRi9GaXRtU0JM?=
 =?utf-8?B?cTJiSG9UM2Q3TVVNWnVLV2VlUUJXclhiSnphWHFsZUhHZk1Eak9rL1pXRVFs?=
 =?utf-8?B?YThHcE40bUdqMzU4R1R2Ny96SVd1Y05paDdEam9tMDNJQ3N5RGJ2bWI1RTA4?=
 =?utf-8?B?VmhmNXRxVmc3RVVsdForSDFOWXpQeFVoSFdZcjBteUhJdTR4cTFBNThxZ3hF?=
 =?utf-8?B?MVdjdDRvTWJHZmlpRXF0YjdIUmNrZkRja1Zhb3BIYWEvY1BOempZY3FGTFhE?=
 =?utf-8?B?NTRzTmpSUUh2U2wzYldCSXZQZHBnc2tSdFRNam1CdkpJWHVvQUtib1o1Tmkw?=
 =?utf-8?B?eEtDUWZsSnpJWmZ3V2lJNjkwWnJTb2xtSVN3QVd3ejlzMFdYT1VQRWlRYTVI?=
 =?utf-8?B?SDZ3TTVhSDNlbkJLK1A2eTdtYUtvREZKb200ajVjdVhZSXhvK0tjR2pXL3Z4?=
 =?utf-8?Q?vfGVUAep82DF75oZuDaFQL3C/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866f3691-b854-4c07-4871-08dbdfbdc36d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:17:12.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIC40CW6/p4AITl7LNLigqjBIzOsgwP7kOrICV5SskCpN92RW+0QkuHjh4s8n7QvYQzfbyjldgO5pex9HZ7g2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/7/2023 02:52, Li Ma wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [Backport: commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e]
> This backport to avoid the bug caused by r8169.
> 
> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
> causes tx timeouts with RTL8168h, see referenced bug report.
> 
> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 45147a1016be..27efd07f09ef 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5224,13 +5224,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	/* Disable ASPM L1 as that cause random device stop working
>   	 * problems as well as full system hangs for some PCIe devices users.
> -	 * Chips from RTL8168h partially have issues with L1.2, but seem
> -	 * to work fine with L1 and L1.1.
>   	 */
>   	if (rtl_aspm_is_safe(tp))
>   		rc = 0;
> -	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
> -		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>   	else
>   		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
>   	tp->aspm_manageable = !rc;

This is a backport from 6.6-rc1, I suppose you're sending the backport 
out because missing it is causing problems testing either 
amd-staging-drm-next or drm-next, right?

If the problems are amd-staging-drm-next I think you can:
# git cherry-pick -x 90ca51e8c654699b672ba61aeaa418dfb3252e5e
and commit there.  Alex will just skip it when he builds the next PR or 
rebases to a newer release.

If the problem is on drm-next, we'll need to wait for drm-next to move 
up rather than cherry-picking it there.
