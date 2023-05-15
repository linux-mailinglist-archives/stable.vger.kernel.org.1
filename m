Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03976703DCD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243979AbjEOTnr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjEOTnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 15:43:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD51D2E5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkU0tEalUDSDSaYNSN4US/vYkh6nBtMOkQ+yZsKQjK0ihfMXRh8FrgG+vIaH9Y92Nz0jPhTKofDVYZcsHAJlvIsDrhXa3R7B9l/L9DnMnaGJesmbhtnvcGmTliTfBxc+IvHXlyf0WOasTndEPw7mb8hrGIn/m+1V00pq8YO3aMnO+QaKsLAMEzjbSsZnbDBXtifbu9bOSRm76LK7JDVWWdpVWpiweoLqkWM3cIoiSVN3tE2PyrQF08hZfR0QD5ZFSucZwId7t7vxIMCcn9a6PINXv7+hdKMFz01Vd4Oj7foiY0DzMdJG0isoXhdk+5iKfEuOIDnhZFRYsSInvMG1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIp4ju97O6g4X7W22DpaaNI7wIHwBbun5PEgH3r87qQ=;
 b=jo6yuHT1M+gl9doeocqW4vpizNZbje676NSnabfH/0W5DSO1lbeOuCiPsRQOR/lLc5fh7+UUV7zTsUI/oVIta/xgnOARByzQaxgWB3Tt2N1wQKDDe3eUeX0WU3K7SVjpbFMEGAPnMrdm60il5o+MpCCXbFfxGFYXurEgDzHa0PwPb5+BMk4cEhdUGr2rnOLpifhsMLn9dcUaSB0TFyJ5nLA7jROCQZhcAvaRrdxEor7V4tiQL0WYh9s6T4UP6rFYNJ0MR05rxwFrGRQh4KQ+bV5kOp741txSNOnGxEgvGkMRC/XYVQEY+H85InhVRvP3X++Rq2AZSbDqBytW2B1qPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIp4ju97O6g4X7W22DpaaNI7wIHwBbun5PEgH3r87qQ=;
 b=Jans0QyLJ+eOlQptcKfvoF50xV2ZzcPgSJb6J4JzuVpVT0wlOFv+PK/ZO8I+KNv1bg1hh5LzT90OBZZQlLgo9+eNNFe5h6hjk4ofyDOCKHZWMPh8rewM2kptTyYMrRfApR3wM1+DyzxpEkGII5wI6OtsWiG4YjjZXOa/SKJAKco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 19:43:41 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 19:43:41 +0000
Message-ID: <42f0a7f4-f53a-7fc2-6682-05ff1350f9c7@amd.com>
Date:   Mon, 15 May 2023 14:43:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Gong, Richard" <richard.gong@amd.com>
Subject: Avoid MES hangs from new MES firmware
To:     stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3071fc-d13e-445d-aca2-08db557caf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWIiV1z8UqHP3Qnw0d9hx7Es6pxrPar+Ukl6S29IHCYbaY4qtrUtFqCC78SSMeqTpbyjNP8eXCL7yYfwDM5654tQnHj9JSPR6jzy03XhWmCogQJAS23TOcjO7bvFvIJNEzv+2MwfqJNLqxuwaGPo1Saaxq2U8amZ0TGat4+DoPauGn2YucMbNmJBggPoVnEh/YfcwvYY+99a8WBAQBug13OP9ph8QFBDkimHdk3i1c8bKLiOtyoek2jopE2AXHICA97SYuweGtrH0shflAh9aWfrUDEEPEBKajRvnJyi6XgEM6PTACKlshNpxFcr7/LaKGOR4cwcamEK4o6wgT/w+aDc5QE6Egusdoe0tb5krz/sU7yfRIfCiLetdyKOw93d24C46v2jOuYoNQby+sGzVUhO9UGmDc4Uz/CvmpUeC5nFQHVCIc7PjqHAgpDi6JQIFXHiRggHyEWa/6SbGjtC8PzEn+WVUTR2EJ2kgEj0DcKUKHIw14qAO7fUJNADUMCLR+yRkJOIO3o/vForLP99Me3eah4D7eM9ugXPBSvUkjpD8e01WD84vEszutqUQfKinAzlB/IG2Ib3o9xecKU5N3gGfJF+3Vy5hxZHnWqEQ1xm76jm8XY0Y9NOWK0NG7OjgLR5+8cKB3w+gdCsLytz9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(2616005)(186003)(38100700002)(41300700001)(6666004)(31686004)(6486002)(6506007)(6512007)(26005)(478600001)(6916009)(66476007)(4326008)(66556008)(66946007)(316002)(5660300002)(8676002)(8936002)(86362001)(31696002)(2906002)(4744005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJqQ2hSRExXeEYvY0JRL0R3RFRZeHBwVHlxMzZxSVZRTUQ1eEVLUWltUzhK?=
 =?utf-8?B?QThJbGVqanBUM2NETTZqM1pSME1hNjNJM2R0d0RmcG93ZUJQL3crQldoOG5Y?=
 =?utf-8?B?YnorNURSSHVTRkdnR3pDUytzY1RzdFdyOFk3dG0ycTU4aGs2MTRSTHovTzdj?=
 =?utf-8?B?ajZwNldKTlViNk41WGxlckdURVZPOFV6b1pRQWhoSThudDNRb0RXYzB2WHVy?=
 =?utf-8?B?YitLcEpKTnd0UHBLWld2Zk5tdk5yNUY0NWZPUEw1NjNnMGRFMExMNFNBRm1q?=
 =?utf-8?B?aXArVnQ5OW1IdFRkZTdmSEkxbnR3Wk95Y2dtTEZiSndqRHgrME5TbEJ0N0VN?=
 =?utf-8?B?YUJwNkhyUHFNN0dnUUdUQVdXcVU1aWRKdnVsWEdLUHp0eVdFOEpnQk45bWdM?=
 =?utf-8?B?Q0cxVEhGQTlTUXRvR201VlJpMU5BUGdaY1k1UlV2RzRhTjg5ZUNGVlR6T244?=
 =?utf-8?B?amY4Z0JpQTg1T3ZUNmpUbU12WVc0R2tnQjdhN2E4UXNQSk9xczRYYXBmeXZo?=
 =?utf-8?B?R3FwaDBSNzBicTZqRVFTVysrVEhxWXB1YjZ6NSt3Zk05NU15OTV1K0ZIMzlT?=
 =?utf-8?B?ajNIV3Mvdmw0RVdxb2F1dnc1ZXNNR2lESG00bUVOVGI5eUxCVVk4bDVEQXFj?=
 =?utf-8?B?Y1RNUDZXd05uRTBKUHFDTk1VbmZuNjZCQ0hBNGltUWowSm51d1ZWNjRNQXFT?=
 =?utf-8?B?eDZSRUJSQmdmUVJhZkRTVHFlRDdjeE4zcDh2bVVJWGF5dWwwaDlQZGxEK2JF?=
 =?utf-8?B?UDMyMFVIS1hBYTRXRlA4K0cvTVhiVE1PcG1iQzBPZ2REMEQwYm1vTkFYbmF0?=
 =?utf-8?B?cDlIS1JyNlhiZHpUUDZ2L09POVFYT3dibDQwQjhVVFlUa1F4MVljYjNGU3dF?=
 =?utf-8?B?R0Q2RTJxMFBiOHI1ZmhuQmZWa0tBSVl3RnFiTXRhU2s2NnVRMWJQMmc1OVlv?=
 =?utf-8?B?RGFXT3l2OTBzMnFPM0w5a2ROcGVEK2ZMUmp2R3g3L21kemQwTmNKVGhGK1E2?=
 =?utf-8?B?VjBpaktpMFArZ2VZZkNPWktoaDQwTlRuQmdGUDhWUmFMVUFHY1FTSVQyMU1I?=
 =?utf-8?B?MExuekM1bjhRNU1aczQydU9KMC9yZlo0NDBNWXBhM3FPZVBEMVY5L1U1S2NT?=
 =?utf-8?B?bkJxZEx1WHhLM1R6MEo2VGo5WC9Bc1ZVRGFPbWhDTHcreU9oSVNhN09Bby9J?=
 =?utf-8?B?K0I5S2UzVTQvRU5PU0ptSmd3TEpKdmhXRmZXMC8vWUk5QWNodU5ZYVBoME4v?=
 =?utf-8?B?cVIyU0paek5haGtvUEpoRjRvaHNPRGRVNTFiam93UHpvME54V2JHWFBLNnFJ?=
 =?utf-8?B?SzBHL1dRQk00dmYzNVluWG5zeDBYT290RnR3a0pnZndsVGJVbjZVSEU4SmRk?=
 =?utf-8?B?dHNyclZndGpUazc1eUxGTjZKb2c0dm5acVhILzlEb1lld0pTNGdnVUNaOVFY?=
 =?utf-8?B?bXRIM1dKZWd2c28vWE5zUVM3bllFQ1NYNzRJWG1NUzZYWEVLQmQzN0llbjhM?=
 =?utf-8?B?cG5KS2E2azc1YlBoQkx4UTV0R0JUMTR0Mk1PU2JZaGo5bU1xakRiTTFMeGhV?=
 =?utf-8?B?Kzl3eGNBQlYzaEh4eWJIeXRqeGFHYW5Sa3FFOTQzaDY1WC9ObnpTZzd5cTlV?=
 =?utf-8?B?UURRWThuT2NheTBmYS9DdlFxTEUwaDVLL29LTCttd0R6cXhzNW9icG9EWE1Z?=
 =?utf-8?B?MEFBTm5NMWtLeFE3cFZNRkVORHgxS3NJU2VaUHl1bjd3ZjNKZXFUdDlOcDAz?=
 =?utf-8?B?bHF1N2tCR2svdGE2VDhjZFZEQXF3NEViaWJYdC8zQTJtQ0JSVWhxUjBxTlY0?=
 =?utf-8?B?Y0tWRGZPNUZWeFNJcVY3THVSellkK2pDQlQyY25mNmpIbVl1ckZ6cW9XdnNU?=
 =?utf-8?B?MFlHbWNlb29YN05BbFRyZ2cvczh2TkxFYkRqdzNhYSswalZCWmtkTm5YRURI?=
 =?utf-8?B?b0loejQ3VEJNbFBSdU53R3E4Rm5oNXFGWDlWSk96ZG15WnRlbHZQYUpEOXZm?=
 =?utf-8?B?UEdNWnVxTDRiSTAydUpObFpHTktDZG5IMWh2dGVtc1JXOVFTbVc0djJUZjVp?=
 =?utf-8?B?RnpqY3Q1RkFnUnhHang4NE83YkkwbExHNDJZc3N4N3FwdGdyUHRmYVRnVEJL?=
 =?utf-8?Q?8+8GE4YUkBubPU428gjU6xPiR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3071fc-d13e-445d-aca2-08db557caf45
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 19:43:41.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmNu8pQ2wkBWVlCDc4HagbbV2goHPVhf9BCqu4S5TItnbthCIUhrJu+ICSSe8hDufDMYmhur762wvMju7KXqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

The following commits are required for the stable kernels to avoid MES 
(MicroEngine Scheduler) hangs from new MES firmware running with AMDGPU 
driver.

Commits needed for 6.1.y
	a462ef872fd1 "drm/amdgpu: declare firmware for new MES 11.0.4"
	97998b893c30 "drm/amd/amdgpu: introduce gc_*_mes_2.bin v2"
	8855818ce755 "drm/amdgpu: reserve the old gc_11_0_*_mes.bin"

Commits needed for 6.2.y and 6.3.y:
	97998b893c30 "drm/amd/amdgpu: introduce gc_*_mes_2.bin v2"
	8855818ce755 "drm/amdgpu: reserve the old gc_11_0_*_mes.bin"

Regards,
Richard
