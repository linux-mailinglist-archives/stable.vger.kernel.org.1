Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26276002A
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 21:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGXT7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGXT7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 15:59:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C131722
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 12:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7MaJMap1ZuYsqe3Y3y4N3yAPYmUqOg/du5VKCkDUghjSrgpja2i+2nMTfGzTbVokobvFd7SXuMaP4HQR0LCUWuhUT3qfyqgwENuh+jBDt3x7Brgf/5azJt4VbuiHy1b8Zl5dwkfYAHU7tid57b6MJOcJb/qgUZTxiFLohpiklZDMBNArGt/CZJj5yXvGbSH95ROdIQVlZHT9RoVaTgqeqV17NVZmh2mDQ+7lgycN/O4F9cNce2NP3S2qHzyq/TE5aTJyj42PMe+ZM7dewawicTKl18RsMLv28UAkpiC/1Mk6+LdXJXdBgF8ysO37BpaFV8opurlTM1x8yGRT94yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2nSvBqHjq4JeHuANlPIdDpHu5GvKIwd31h65Ts/0u4=;
 b=DLZB+kzTtbEXblEykMT/ji7el/9iMnx6CZTPab48DEoI29dbyzU5fDGMPFE72nMHyQm7vXhRdLQjcjQpL72JGlXrY5WgqsFrlbe8tSoVoCt45rHV9ekNeKZsugcl6B7dBZAH9hhesx4Hf/hMi0V/0QUaKXmZdvI9r/14KQma4PSjbolkmLKpS8uEoblpW7AsIKZmMFEi2l/rVjsUSmnqCoSstvt7aUqy/I5xhCjeRM6fHMfW3BxBQPBA/A/TReGDFCACsYBUg8z4kVGo0q+kGv10isDYmzq1Xz69RqV3vxndyQtI+DOpDjUvCnzCkoW1g9U2xEN22+8J2OqKx2pAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2nSvBqHjq4JeHuANlPIdDpHu5GvKIwd31h65Ts/0u4=;
 b=n4HVCaHft8SQYb0ePv9CBM6Bk1rZ3SM5nu8jNjhyBjH/IlrA2YjT4klPRMF1UCz0//WbgSvtOE8K9A5gOyt72Sx0D7cxH/GXnhHs+wDjldcQs881iND8eeHI2Ib0i6jY0f7TCksc68aaKgbHie0pyZN/Ely2ghfConxU/4vH0g8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 19:59:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 19:59:10 +0000
Message-ID: <4eac08e2-2a13-1e13-536d-a8a7949796ff@amd.com>
Date:   Mon, 24 Jul 2023 14:59:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stable <stable@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Kernel 6.4.y stable backports for "drm/amd/display: Add polling
 method to handle MST reply packet"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ab3611-3bb6-4492-cda3-08db8c807267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQ8GiwN3UGNaTU4vL9W2zOLsKBNgHXZd8jjtvSr6h0q6zaWUR3Mkjf8BoGFg2DB62KelAUUF/wSJ2nrbs4ppg3lRZ+HH3CXOKtH4w/YKZG65Z83yVMVhH449flzPDyDFc0kNATYd0lqYvXAA6cCaiI90yqplNfa2yUsbQYMT7LIEE2Ql/F3PgNWtrIUL86OhO5g1+AuOSOMXlF1Ovozi/c6bmat2Zy9FaqG8Tdoms+WAaIUzTdmUoiR+q6ELLa8xDXQg/UNIU+qV+ARumkD8MXMzFA29mjHZVSdb3pRhHQqHFy2NPEK0r2lekotoPmj8aFNRORsUbLQC3gCtMUm5zVbU1mXKAFGRWK+E08wB2Ptj2RGUJJpRWPX/dbdTsZ/wOeVkFjSMM8aj5FDnIdd6xSHSxi5eq6gUNUjFx70Bw3rggRYolflQrFGylP8tNWM4zHKZ8SR6zeuRQT0/eHmSyXtdPEyOhCY6MJHXDydtpFVSH3V+6j3YMV5moSEvhDTfI9JxgANdcCRY8jeg0Uef+vvh7N0dw7iLtz417cJxyRpCvYRthr3pXXOekUW5R5CvNXrMh2wiobgMEmOhTy2tgGXXURq0Z656KCtJxwQc/hG3esW/2hOHWDh6hyLsTypfnRRop00023RisSFBvE4bLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(38100700002)(6916009)(36756003)(2616005)(83380400001)(66556008)(6506007)(8676002)(6486002)(8936002)(5660300002)(478600001)(316002)(66476007)(66946007)(41300700001)(186003)(26005)(6512007)(4744005)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0tuUEpvd3RnY0NxSVYxZmY3NkkzVjM3QzdpZWgvRjRVS2Z4Vk5wV1QvSmZL?=
 =?utf-8?B?dEFvTUlFMEVVQi9qM0R4b21hQmR5c3RQMXBIai9pamFGcTQvY3dLUUR4bStY?=
 =?utf-8?B?WVNjTnBOYWlrUEF3S2FQTFYySkxOMkluZWMwMC9ibUlYMHByNnQrYTE2clJw?=
 =?utf-8?B?MXZmTy9QYzhjQ0FjajNPWFJCM1BUVVIrWTdFdEwxRlFiS3M2WmNmYmFlVmo3?=
 =?utf-8?B?K3d1QWxlWXRnS0RNWGhrNWJxR0M3dldXYWJmUkZTK0xTMkg3ZG0xbS9sVWFv?=
 =?utf-8?B?MDZiWHM1SHdTUldRNkNkZ2krWmVTL3llV2RIeW5USmFYN28vbzhod2J4Mzgx?=
 =?utf-8?B?NkljVjV1NmREczdtVkpOblIwaWZnS3FnQmRrb3FLSFRsLzNwdXRhSTduSWl4?=
 =?utf-8?B?SGJTN09iTFlFQWhDTmhWVjFDS3AzQmRXeFltSldBM29Sa0NYSkhxWUU2ODg2?=
 =?utf-8?B?M1FYVG1jM0YyNW11N1NQcTlKWnBtODVTeDdGQnpESUU2SGZmcXE1NVJuM29P?=
 =?utf-8?B?dWRIdEc3a21tMUdrRXdjUVdyd3FQc0dPS0tabU5OaVVITHpWVHdYNDAxT3c4?=
 =?utf-8?B?OUU1bzVGZ2swWjUxY1hVTXk2ellYd0V6OUs5Mk1UMzFwSWcyaUloczlBZS8y?=
 =?utf-8?B?am4wTytkMzlWMEl1Y0FqMGhJS3FQNWVEVlNhTXFhWGJUQkVrRUtJakg1cnlq?=
 =?utf-8?B?MENqL1hKYWhmMmxYaVQxendiUnQwZkVybnk3UDBnWFlyeXJEUjFEc0xnVTRO?=
 =?utf-8?B?aGJ3M3l4VTZGdm1OcHZxNE9KUlZDWXNvUUJhNGQzd2syN0g3Ry83L2JtWW9U?=
 =?utf-8?B?c2wyQXNLUFRTSndreWhCYSsrTG45aG5NZFJLeENXQVIzSlRvVDZ0SkI5UGVr?=
 =?utf-8?B?bVFoM1JYNjdmWUx5WDRQUStlRGpYcUlEa3A0WEZDSmtJSnJ5dkh1Q3hjN09v?=
 =?utf-8?B?ay9DT3VxbDl2UFhLdVllcFdnSFBtNHJONTlRRTZwQXlEVDJNY3Y0ZTBQRWRj?=
 =?utf-8?B?WFJBeDdkYVNodHVjQmxqam12aHJ0SzhCRVZmYlQyV2hsSlFQeWJyenJhMHB6?=
 =?utf-8?B?eWtEZUliVEp5T2kxZmdYeHVVS1hBVzNaQ1JaMVc3Z0gra3p0VmpGOVA5S3d6?=
 =?utf-8?B?Wmk5RUVnRk9oTTNvdkxwZVhpRGplVTZtVm0rSExjaFJ5RjRoQ0tadkordlpY?=
 =?utf-8?B?U0pMS0YzaWgzNlpsNFBobE1pcXJKbjRyZ04rbWZLTlU5NmM4Y3E0Q0pSSitm?=
 =?utf-8?B?MXoxUUJ3a2N5K0xjKzFmQ1YvT1Q0ekZqbnFJVzY2TTJpSm5TaFo5K2J2R0ps?=
 =?utf-8?B?RWgyN3hjK0dmUDFIZTRtdWNJeE9tRVpOWmltazZPVFQvYS84aHh2VTlPUWsy?=
 =?utf-8?B?RkFkN05HbHFTWFVoaFY2S01aSzJkVXIvZ05sV2s3c3B5U0VSSGpuZEowOWxZ?=
 =?utf-8?B?U1B5WEl2dHE3RGsvdFp3RnRHY2ZRZ1B4cWpUdVl3b2Nndi9YU3ZKbzFQSU1w?=
 =?utf-8?B?ZldyZjl6SDlaYVV1aXJSOHorVHZ1dG9hNDd1T2JTOHdtbEZidko0c0dBVHFX?=
 =?utf-8?B?bmdFSzAyZVE2dlh1KzZKTldKbDFSSnV3UWlTZUxCclU1YzlscFlKWUtXZTlF?=
 =?utf-8?B?WlNyQ0xrSVlBb2QzMHhDdlY5N0lhYWpUNWJJelY4KzIzM1RueFVUc0N4b1ps?=
 =?utf-8?B?WUpGTC9DcnFmYUxjbDZDa1ZvNDVEMTRlVmQwakJxbjljZVk2SmFzb2w2NkZy?=
 =?utf-8?B?NDlCd3NEbVN5VkhTZmVxWlF1QTBINWZjZ0gvTXVSaWxMc1ZaRmloNmFHOWlO?=
 =?utf-8?B?T0FIYXNxaWUvUDlXNXlWckR4dFIxS3JjcXJSdW5tU25XRS9icTF6RXhjK3Q4?=
 =?utf-8?B?a2k4TVFBUlRxTlZLN2hCZEtyMzAwYzFXSEJRTjdUekNsQVdCZ1ladHMrcENO?=
 =?utf-8?B?K2ZERlptclQ2NEJLOGZqUUVEQXZZS05mSG5XeXpsTXluTlN6Tnk3WUVVN29H?=
 =?utf-8?B?c2VURnJCZENjaFcxTUhtWkdNR2ttcmp0R3FRNnVkVEtRZjlTUnJTaVFNM0VY?=
 =?utf-8?B?NmhLK1pHWURZTFVSWUVwSDZQNi9DRENXcDFkM0l4RnorejZhYWtaa3EvaDVE?=
 =?utf-8?Q?OxTwYNNI5JYxPEALG2zNMO3Yd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ab3611-3bb6-4492-cda3-08db8c807267
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:59:10.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNJl9oHpHM7BjJd8WHDtn3oKsWDGlwS6LZUz5om0ZQ9Cgx848p7mH5uKqz4AQc41PND2UU26tqajuGrBmvRQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

The patch "4f6d9e38c4d2 ("drm/amd/display: Add polling method to handle 
MST reply packet")" was tagged for stable, but it failed to apply to 
both 6.4.y and 6.1.y.

The 6.4.y backport is missing a dependency.  So to fix this can you 
please apply:

87279fdf5ee0 ("drm/amd/display: Clean up errors & warnings in amdgpu_dm.c")
4f6d9e38c4d2 ("drm/amd/display: Add polling method to handle MST reply 
packet")

I intend to also send out a proper 6.1.y backport, but it's a lot more 
complex due to other driver changes and will come separately.

Thanks,
