Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75796FB154
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjEHNUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjEHNUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 09:20:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B3C39B8B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 06:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSGwjO2fjiikHu/5cgUhYvfgUe/OHHQc4ynP92e/9VmKA/3HHfXfMExRxvLSOz1NJiGDH97V1xEXoM0pUi7/+8KFe+vokjF9TwC/Ab1++wqjjcYCXrrNyDYgrhnNIm96n2HOjRETCz6ePwCc5n2bOc9CrLQoWSVjE/t4mxb7ZGv13V340DHDqisvHRhmoDgUo5WO9O1HNauG6GPK1giASJaObaa9v+t6wL9zfaW4kqrukJBllCTxDIQvxOWne4GBghACZAfrqzCN4tJtpG34a3fixv5IicytP7k9wJHEB66gPT5QQuTaJ+9wDkSeDCU1FHusdJnavANkp4utCZdQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRrnKvhj/vktX5+Ipq3aBdaPGj5Wmdt9Ck841P9y4Sg=;
 b=ipyRPLH9lq0eEpREg1jb1o40QUNVNK4nr5mw8JCmDaWFmh6UnOu9aX6St2gmgh33YODUyg3+USGwddjaAqDLQKKjq093+rcaor4eQVe/19dnDUtHvdEcVowD4MBmro7T4/ZijlyIQtyNZ6xkB6ua2//OxKzOeOXT3iOOps2Cf6EEoO0saiCAGAvH68L8g7I7t9SC9A2+3Fi0GtsxHNOg2JTDNed8d9iEMZZRC+GZkotewfSAUyCgO9NgPlQD/NSFU6NFDUBR7o5p1DZDMuEMjdM6E3T5j1oHeZ5sgqeEWv3wbQQoc9P2C14jFI/M0fi9A4XnImud8dGvcOlIEk5x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRrnKvhj/vktX5+Ipq3aBdaPGj5Wmdt9Ck841P9y4Sg=;
 b=UIwKjLqXJdXVVGkxvxq4rIJjj9maBdN8+G01gKyZ9tWFxQSns/5PNALwKW6B/943PT2z4YQ2PjlbE4QkH7dQEMfbRN210ktzYnjR8uXxbcv0bGo6yMPbc8/P7ST1kzboj0U5E6vZaPzKneo//3BYua5wVHCe4jMdevTwUX3keHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 13:19:43 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 13:19:43 +0000
Message-ID: <5ca2e61d-08d6-3070-f281-e2483cb7718a@amd.com>
Date:   Mon, 8 May 2023 08:19:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     stable@vger.kernel.org
From:   "Gong, Richard" <richard.gong@amd.com>
Subject: AMD Navi3x dGPU experience improvement
Cc:     Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|BL0PR12MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d1ac99-fd3c-42ca-bc5b-08db4fc6e319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vo4BfErmCv8vFtJ/o8EToT27zTNd8BdgRswL7rSl91okiYI7BmMFFEErd26NHZURa7gmHSA/tbkz1ndSn/I0Tx2zEjkPIWWbRlzyG6p6ewXsLOY8yvFSIkK1huec3sbAX2MxzR4BWbgfT2X1jLZu0tU3/LFBKJnPkQIaqBrz+7OfhAzXHu7bhZxE+OETWoyrlD5Of6orKaYUzsvgI+CQgq1slX5fOFBoyHRxMHVX+ipbfNr6WIuAKceWZ7Oz4CMeHnd6qCrhhGEr6FzdJMC2sUeYAyrWLTIzTwxLkO0WVm2Ld3pvmjTwsGrAL/jyyJ//btRFeLxWtasOsDqSTw1dLRd5WiIdepTKRw6wuN5htMfE0+BlBlx6cV6L56jE3CiguTyCHO+ZIp6LRlLNUpOgdrGDCiVghMYK74GEnYpZEC9QLBPdfTkTANoZdnKOQSJhTiMNABbWmKMpOoBUXc+WqMtr6jBMmy5dw47Y5vn/p0PD/+kIY3YQgOH6DWwmKUlPR6UidBKKFkAlJIJulEUx9lQx7Iwt3XmpCnnO/jjIfw5n02nYtgKIWLdT1h5yMLaWymaTsb0+9sC1Iq4Fjs+J+u3jqn6jrFVlW7SsiSIYlc3M+BQO9RtyARdwSKFDPeiwh9lnXSdhqzw6cYVTkPNX5PpgvBU3x5Hf8rtI51jqh9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(31686004)(36756003)(38100700002)(2906002)(31696002)(316002)(5660300002)(8676002)(86362001)(6916009)(66946007)(66476007)(66556008)(8936002)(4326008)(41300700001)(83380400001)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(2616005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxmZlhIY29zaTJicWpvSkk0cWRtVFNRR0srVGpreGhRb2dscFVpSHR3ZG1G?=
 =?utf-8?B?RXRUdXpFTkxaRVVZUVNKTlF0by9YTS8vT1dJcVVnb0Z3TmNBL3pGRG9vR1Vn?=
 =?utf-8?B?TFpjQml0Nk1XQThqaXhxQjg4MS9sRDdXck4xQzF3RlhBcDJvSXZhQjRVWGF2?=
 =?utf-8?B?WDA5TGRJSXd3RWgrMjNqSHdqNGllRlhBTnQvREpXUnhXOGxqZUNsQ0xtVVY3?=
 =?utf-8?B?S2psK3JIN0ZmTElKSjNMNUdNdzJZNjJjUEtxYit2NWhSRzkzdzJkRVkvb3Ra?=
 =?utf-8?B?M0xiRHVlTThKcHJ2a2ZvaHVRcG16RnhieUhadTNBNmYwZGVIQWVpT215S1I2?=
 =?utf-8?B?dXVZWUZNTi9jcHpMaWxQcUVXVXEvdDIvNElNcEZQM2NsWWlXTTNpMFZMKzdP?=
 =?utf-8?B?MWRYQkhGcVZ2d1dxdGd0Um5YUi9sd05MMWwwN0lnL25hMnFxTUxhd2t5Rjlu?=
 =?utf-8?B?YjVtSnMyZi9LcTNpQmZSZGwweFc4WUR0WVNsZkI0QVR0eW1MeER4RW1LR1NT?=
 =?utf-8?B?OVlOYkU0VW1XaS9YY25xQngzUlF4d3RJbjNtTnRKd3NIaDBaUml1aExmVkdV?=
 =?utf-8?B?ekN1VkpGKzdNRG9rM3FGVTdqMnZiTDZiQzk3bkhNM2JwK21McVRsaHltMXZx?=
 =?utf-8?B?bWIyUDFGeG9LWUN3NVJRcjcrR2NhTjJ5S2pYeHZTc0czZENUbTZpUVhVTmhU?=
 =?utf-8?B?VHRQQktKdmg2NXQyTitqV1BmeE04dnNVZzZmejg0dm52bEhJWC9STkVqeHA2?=
 =?utf-8?B?OEhzTU1lYVlHdW8ra29NeDBXcHk1VURpT0c2VUphcy9IRWpkMUhUR0R2dG1L?=
 =?utf-8?B?RUNVV2dQVEZQM2JNby9jcVhabFhqNVVuWEh1dGlGeThMRXZKbE1uMkp3dmIr?=
 =?utf-8?B?Q3dPYlc5SG1KT1dYc29BTnRacUlpb05BeGJRWDdTVjFYR2c2bU5Bc29SQzRP?=
 =?utf-8?B?V3JtdVhvR01jUWxORlV2RmFBMHIxNmJpYTdQQ1VhcUJYOWpxZ1AxaXZ4R3R2?=
 =?utf-8?B?NDQvLzhWeWJScVRoMHQrK0VyQkZWanl2SzNXTUVOMGdsSEdQQlpycGpJbGNq?=
 =?utf-8?B?THZiUkZSNExCOTBYdzNqWk5UcnUzQXFPenpMalNQVWJzbUd2Y2FPYXhwZUVM?=
 =?utf-8?B?QnZYS3lsRVFwU1VWNGZvclM4WDN1YmRpN0ZGNGJjTE9mdDZSeTljczBFelk3?=
 =?utf-8?B?UHY0WnIramJHNjV1bFZPeFZwN3pON0Z2MFI3cEUxTlRES3QyNG0ybXlHU2NG?=
 =?utf-8?B?TTNFM25hZTJWMkx0bXpGdE16V2pXMGdnZitKcjJ0YVBZZUdGcjVIa29WMXdG?=
 =?utf-8?B?WDlaQWhQR0UydFYyd1hUZnIxandONi9BR2R6ZHMyaGdJeHI3VUFSajZSZ0t5?=
 =?utf-8?B?dzlPRVZaU05oekZsb3Buei83a3FxZStMNk9pRTl0bi9tVWM1UDBWdXFyWVlH?=
 =?utf-8?B?ZDk4V2EzRkFXSXNQUStSYVJ1aXRtc2pHd0NUZk5xYzBwa1VrYmZEL3Q3UXNL?=
 =?utf-8?B?Q3F0U2QxL2FVMndiZ2J4WG83elcxbG9meFNsU2hYM0V4SWtjNGpXL2RJZklU?=
 =?utf-8?B?YTM5ZmhoR1ZiTkxXZnRNUlJHUjNJa055TnlYTmwwcXFSYXp6TEQ4MFc5SmVC?=
 =?utf-8?B?aXZWVTROa2RlTldLQjJMZXlZS2pRZVJEWWtjbEJrbExnMEloUVVZU0MzRWpw?=
 =?utf-8?B?RVQ4ZTJjNmNFb2lsQnpvVUZiMXF3N2pqeUJrbXQ0ZU5NUW9YMEpZb0xLWGxC?=
 =?utf-8?B?bDlFL0FHRFNOQzExVThNdUMrdHVFYW1NNjNtdUdualpUUjQwVmJGR2l4RlFX?=
 =?utf-8?B?RWVDWU54NCtqUTBnekNPd25PUVltNFNsaFRQcEErcEdEZmNJSWxaNm9zaDdT?=
 =?utf-8?B?WVBVcmJ5cEVaQTBlUGxkaDNiTmQzSDgwRERhM2hUY29iaEJxQ3luaXQ2bC9n?=
 =?utf-8?B?R0RXTGNBYTdocE1hVWlqbUFpZzlYSldJZ1plRXJYTG9iUWJKVHVCakdpclVQ?=
 =?utf-8?B?bmUrZXU1ZTF6NHdjNEoydlluT2xoMWxna3NtMGRMSVZyL2NwWVdJdXNKbFBI?=
 =?utf-8?B?NmNyK01HanQ3UFJPKzlkR2hKU003OFNzMnZCTnJPR0x6V21sRzBvVTZSQ0c2?=
 =?utf-8?Q?FdDO7dRdIPn6mviPgvq7XPEzk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d1ac99-fd3c-42ca-bc5b-08db4fc6e319
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 13:19:43.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYr59FYbj2pwTHcbIKL90LxApRokyvwd3fhiPJy34dwztxi9zk2AFqoiWxH5XiibgOpu9Yt2GRKP8ZkqEwsl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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

Since AMD introduced Navi3x dGPUs, setting them up is more difficult 
than it need to be, as you need the GPU firmware binaries present in the 
filesystem before the kernel drivers can be loaded. If you don't, you'll 
just "hang" at a black screen. This is awkward because you must do 
modprobe.blacklist=amdgpu and then load the file.

A large commit series went into 6.3 that improve this experience, but 
not all of it is stable materiel.

As the dGPUs are supported on 6.1.y and 6.2.y, we can improve the 
experience specifically for these new produces by back-porting a small 
subset of commits that correspond to firmware files that are uniquely 
loaded by the new products. With these commits amdgpu driver will return 
an error code and you can continue to use framebuffer provided by UEFI 
GOP driver until you have GPU firmware binaries loaded onto your system.

Commits needed for 6.2.y
	cc42e76e7de5 "drm/amd: Load MES microcode during early_init"
	2210af50ae7f "drm/amd: Add a new helper for loading/validating microcode"
	11e0b0067ec0 "drm/amd: Use `amdgpu_ucode_*` helpers for MES"

Commits needed for 6.1.y
	6040517e4a29 "drm/amdgpu: remove deprecated MES version vars"
	cc42e76e7de5 "drm/amd: Load MES microcode during early_init"
	2210af50ae7f "drm/amd: Add a new helper for loading/validating microcode"
	11e0b0067ec0 "drm/amd: Use `amdgpu_ucode_*` helpers for MES"

Regards,
Richard
