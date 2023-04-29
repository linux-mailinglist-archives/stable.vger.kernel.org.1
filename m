Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B16F225D
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 04:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbjD2CRW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjD2CRU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 22:17:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD291FDB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 19:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6RoolRLhOOLvLMfeqMG6mZ01t6dakGxnlD2gf1jrTn3Nix/odBpPDqrU2Prox0iaKHsZyOdeH7ZcgOcQn3YhdQZzk64wOJSUEgsE+07eMmnjyBuJstK0IZjuMnwwlqyNsIVLWQLppVESk37GTQ0Y1L3ac91kmnSTLi5MIWKPeV/kLrnflKuT2HBdMtExLOCwhSflhAAusopK7Se7ooQLe7ojkO4S22gG9K0vjC4eXbe4fIk9TrB7tWfy3hs1ZQzyVFAPCUeRszpZp0i00RwZBUsG6P1UvhTm6HmrjCFqL+QzGNhhx/jew5aLK4i6RzTIYAnMQQzSV7b/1Urdnz8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+Toub+rGuknl9Wrb/y4xBIV9NoqwukBeEjF2UV7+ZQ=;
 b=NkEstqaq2Fkkr/w93vGZBkDWFSC3PN21ADWa5rTLeoFS5yGWAsr3P1Ft302tjwD8DhOk2KR0xDDNf5QtWXS3StHH5PzKky2zVaEcdkZRa+XnMNE9HwNNVg4HSEA3X99VbbkprMRwkV5xRg9EY3yrLuoAxgg4hFSUbdCCzkVBSDxgPzf3OwLmjwRgq7PlbWmpSrnxTZA+301ELgXFhTZqhq0lOx7ywnxG8N6/xk8l3zKJ8qf6zgY+l0Rg4FXpUwS0mSUaqy5BYk+m1S/BwdYX733+RbA3pFsdt2xbCVI9vGFxtBGOyIWcWnaEvX9PeH2CR/pMKl4/EEa17u3eZ7we6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+Toub+rGuknl9Wrb/y4xBIV9NoqwukBeEjF2UV7+ZQ=;
 b=iKb+bAwm8EVlyw153zjQWLddp8OebgVNXVfjlvHTfavedRzkRtY/LN8qDQpdyWeVWwl/MkAqNbo/JqTW8bpoT+gV9lb4ITAXH1MbEl7J47cEx80l/SAGo95eonj7A+bxdYZo7Vvcyc73UUkRJv2ad6MI7gTdf3JjcGJSlCwSS3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Sat, 29 Apr
 2023 02:17:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 02:17:12 +0000
Message-ID: <093b3c24-2df0-5a8f-4e41-057f39fcd87f@amd.com>
Date:   Fri, 28 Apr 2023 21:17:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "Gong, Richard" <Richard.Gong@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Pink sardine ACP stability issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:806:28::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6a4c31-5223-46c3-5d5d-08db4857d7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmEzJ7xzXIhHkcxQmAHHqnF+5pVCaf6f7/dN+Kvp/qJLYxHWInUyXKlCniNbm5FMnWDdNodZswb6yWFB0CBlb7BPSxRBtlo73MnLSxo0IiLGMeFY2LuGNLdXanus/eWbIIaGKyW7eGGDCtNTd3uWjEFbqi/H2GpFjKdvoHm8UvNx9Jgt5IdqG/iD8MVk7WGx1HiLambR7gPlKb3a7EExVXHqf0zRBP8W0JqpQIVXPQeIRXMRB03TjIwYKUWzQXkdNm7Ade2QJw4/MwUvN1qndrOK3Vl5uZyotZy77S5JudBJnyQnpknKc2sRzt/XBj/DzstI/uxBWqGTDJApwrCrbR/szeo6vaZDx1VABuskRZBFdfcWHt3aiEKNEhxqzcYP2Z1WBYlCizDaZvK+wXvk+sMxSmak8zDQjgCmJYouKU7OGXdqX2rt2lBsn23bkrTOb6WNDfa9I7PlAjfvf3KYiq3dhCCNUXUU6HRa/FAT9vEEHtJvJWnGvXTeHsDBhpCyWkvO7LfJXW/F+0NRvqgRfY/4Z6JOjTGpwoLRj/jgiELkpyFt2vSREocldlyqFqpg4jVV1ihKiaflsOOiq2bsVLrQgEhNGmiKQ5nxW4MO4AMdYEtgCH1q+44+aBimOA3kMqoXx4YFV28WJcNm+TutoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6916009)(4326008)(316002)(478600001)(66946007)(66556008)(66476007)(6486002)(8676002)(5660300002)(8936002)(2906002)(44832011)(41300700001)(31696002)(36756003)(558084003)(86362001)(38100700002)(2616005)(6512007)(6506007)(186003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdSL2hSKytHYVd0c0pkdUtDZ0Z4clhUMXUxZW9QVXdPb1BONnhuY01CS2NC?=
 =?utf-8?B?TXpsNk51RGZKUzF6SlpWaXQrODlDRGxodFQ5bTZGMUtERnhiL1l6TTYrblNv?=
 =?utf-8?B?T0xsOFhrVUcrSDVPTlFFRjFDbEhhbEpGc2VUdFZ6cUpmTTNDazFWd3JudWEz?=
 =?utf-8?B?a2JJT0U2eVNWN1hjazF2S3ZFamJrcG9HR20yc2ViWUNPZyt3cEw1THYyMW11?=
 =?utf-8?B?NUtYcWtnVC93WlNNSDgwTzJiRzRPMWpBT1BWWVl3YjFaTEVNNVhuSjBoR1Qv?=
 =?utf-8?B?UzlIMzl0TGlhRUZCRW13Z1NrSWNxWVBBM2M0bURrUlRZb1Zid1Zlb2owTzZF?=
 =?utf-8?B?cW9BeEQxMGNsaWZveUV2bEJTTEpwenBTb2JwVUg1TWpaTVJtZ2Jhd1lxZHNu?=
 =?utf-8?B?SzVvbDF5bHBNdGE5QXY3R3FhTVAzdk5UZ3QrSG1TeWxFdDBKYTRSR3ZWRTN4?=
 =?utf-8?B?YmM5RklFYjU5VFVJcktCUzlZN3lnNkVBVFRBbHB2bldrbytJMlR1Y21RVTF5?=
 =?utf-8?B?VGMwUTUyN0lDZ01weUkzaE1ZREdXLzU1Q0NzZUhHS0pxeWlCMWlUQlg4R3NX?=
 =?utf-8?B?cHMxcGhKSEJoQmJxcjRpenA0bVpqNGl0dlF4ZmMxU3RpZ3FWV2JZLzErd3p6?=
 =?utf-8?B?U1RJbndUU1F0dTUwSWYxdUwrd0tYeXFzU2hnTXFVeVFPN09LVENCMFdINWlT?=
 =?utf-8?B?Nlg1RFdyZW9pQldiT2VkVW1mVngxSjBlVERKZ0NoVmFLRnJJbzVzOWdKU0ti?=
 =?utf-8?B?eTN0SjgzMjF5UHZya09iMkpPSWNVOFV1aUlKMDJzMC9ld1hPY2U4TkFOanlP?=
 =?utf-8?B?V2l5ajJTb3Njd0RGMVJRaktxWGtHdklMWDduTjBBZXN4VUtNcjgyVEIvWWla?=
 =?utf-8?B?OFNJSk5TaHpRSElZbmQ1MUVZTFBlaXdWTVFsSEFyUHp6TSs0ak5jOEVLeWkz?=
 =?utf-8?B?NTNzRXZZNVl5dzUvZEsrZjBrakhjT2RnRTBYVzVhRkpQeEpqNEMvRllCd203?=
 =?utf-8?B?LzUvNVdWN3ZmTkNobDNzei9HRDZkdytwRTRabnZZNjNvNGJPVUJwNDZwdHo0?=
 =?utf-8?B?V1hSUlE1NFhqbDNrdXh3bEJLbSs2SVNpbHI0emxRR0tmcGNIRlVUNkpDQzQ0?=
 =?utf-8?B?Z2dvOEs3RkU1MnZjZkF3bFRZeVFjanp2dDdydGJESlNWcUVhMjA3VVRoekFH?=
 =?utf-8?B?aWRCczdad21IYUR1R2dVcktpaDJwamxqN3R3K3lLVVRQOVExTmRuZW9rblkr?=
 =?utf-8?B?MGhjNU5LK3d2UHU4bFJ2a1hXL2liVVZrYXlRQjdJcHZMYjhUUGsyeVdMK3Jz?=
 =?utf-8?B?ekNZd0c1MHpMT3ZtakRvc0YwR2s5UXFzM1FuTjRCN1JnbjZ2WU5LQTJhaGgy?=
 =?utf-8?B?UERVVGI0Tm9JQ3Z3RVIzZUlUY0U5ZjJueHRJNG1FRlpQT3c1RDR3V1AydXpn?=
 =?utf-8?B?Y0VEa1FDa0xBWDlUMk9VR0JHbFRJQ3dwUE5DM0tQVC9mYkplWjdLVnhERGlv?=
 =?utf-8?B?MVRWN1oreGNFc1JnK2hqZEsyTWdrR1RORFVnTzFZQXNJNFlxT3dpRlpyWEVl?=
 =?utf-8?B?QzhvK1phRDRBS21YeU5RRW1uclcweXR5a1FhdG0zTittWDNWa0FFWHY2RmNk?=
 =?utf-8?B?UFVTNk4xM1hSQURUYytjd0dFT05odzRiSUV6RFhMaU1xYXNvUWx4bURJbTcw?=
 =?utf-8?B?OWhGNXpZUXIvNVBXZFovUHNBTkM1RzVMdGZJTzRIeUlBQU93T215TWhRczB2?=
 =?utf-8?B?Zld0SjRuci9PUUpBYUZSUTdZdzVnY1JMZHd2ZTZFbDdXUHl1N2lXbmNtbDl0?=
 =?utf-8?B?MVBIWkQycGdoaEVOcDZGUVJwWkd5TC9ieDJHdEFpenRiY1RVZjJzMGhGaFFK?=
 =?utf-8?B?UHcxamNkMW9CUlRRRzlsMkdVdFkzNy9GRkgxbS9DWHQ3Ujc4SHd6UlFZVk5T?=
 =?utf-8?B?S3YrWTIrc2lJeU9GWlhMSUE1djlZQVo3TTVFL0ZzOEtDeEplVlJVRTFZOUNQ?=
 =?utf-8?B?YjZ6VkxHakFNSFVjWW90Nk9mYURTT1VUcmpqa1Y3Qm1MNjcrSHpqWDlVaUhL?=
 =?utf-8?B?dWEwNThyR0t5bE16SEw1U0lHSGZlS1gvWURBMjBhQjJNcjV3azVSVkZubFoz?=
 =?utf-8?B?aGp0NWF5b1N2RmdyenlnbHdrSGNQazNmZ1JIaW5YZHNuQWU0MzdWVlpocmg3?=
 =?utf-8?Q?l0zQWMnDoQpfFNGiIKPs7YHR0QzCTEpJyRxTMpSKJ1TP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6a4c31-5223-46c3-5d5d-08db4857d7f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 02:17:12.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQgNgVE4tzxhgCDXCWKDWl2golp+sSbOYd1sboRN7yAqUfBOZM5TVLaMfcJVY3Dc5O91wZZb4/Givmdr+ncgsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

Some Pink Sardine platforms have some stability problems with reboot 
cycling and it has been root caused to a misconfigured mux for audio.

It's been fixed in this commit:

a4d432e9132c ("ASoC: amd: ps: update the acp clock source.")

Can you please backport this to 6.1.y +

Thanks,

