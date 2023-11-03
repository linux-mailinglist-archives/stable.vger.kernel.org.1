Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281A7DFE16
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 03:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjKCCTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjKCCTa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 22:19:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B119E
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 19:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMsU5tBW4ikqjsLEtz2AnooNO/blZqtVoTkH7aNDpUf4PioO1HUmVl2spyN4jMopdEepBUyaSFJ53NchNKm17W2wjFi+rizIUZhtcO/w/zKsA5FF6kAdEmQQ0pZwQ5PVOVqh+1kNjfZzRTAif0TwVXADXg5vpPCYmdU0Kz+1/3O6MI9dtQkfwJmtv6IeGvqJaC5hFQ0aKZbTMevWx0qG51h1cs6fOuGLbJm8flt5QLArWxpU9ZsgoJ61Q3JBuRvac3ghbFIKzNKpquinBvehr630VqPBs32q3BteGTqdu8Sgj1EO9YhJtqnIaNT/ykytol9KkeD/gykmqAyPEz/yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtsOQi1HDHpHNDfuV9AYnp2lVoS4XQuQpH0zA0VSmw4=;
 b=Mz+jnESv03ybQSq2sHHs3UpSkmDeRLEiv6SWLZnEryYs9qFXx7JqTGwQiiM7ghOljuTOk7MSilHLyyPZhUHjyk4B0czr7MyiMSQqpHkrnpbNiN3dOhH/P/SnqP1/HrDND41jsWUSkiXQBGnq+0j0M3D99UXuycrttl9GIFIku2E4Eqo4OBFNMvtTzsqrNfti+elfNa0MhqCNcdcfS+5Ii7nRv7TTDKNPUvClYPaphKSJwAcOcVK1AEWZn8ni/XOzYxfV7RLXpzlelAp8kuuiyes2NAz3YHsvd1xcNQEeYduSrDne5s8f5dqAbfYmnPBEEiToWKaNEjDkGW8EGAxbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtsOQi1HDHpHNDfuV9AYnp2lVoS4XQuQpH0zA0VSmw4=;
 b=A3ve+hBsq2OaZlxYmYilRaJhyhUT1hs4Al+iF+o88GgmwkUY4Kh4ADbBC1c0k0i34t6zwQOFJ34BmHEOEIVedJm6NduQG9pKVeYyxcQxjH6pRRy/HFERWC54ARKntITvWYkQXd6A/e2l5dPiKlgr32hi0S9il7eVDIy3EiIfTb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 02:19:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Fri, 3 Nov 2023
 02:19:22 +0000
Message-ID: <6beacbc1-4c92-4ca2-9778-15d9f73ef696@amd.com>
Date:   Thu, 2 Nov 2023 21:19:19 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: PSR w/ high IRQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:a03:167::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3d7be1-6aac-4a1a-a21a-08dbdc134adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlHEIENL+VtLfuIRARZSW6eCyZwnZZl4rIJJabNt3eXPrFkO51uF/pFDWfgmJnhmO5LaUo2Rcho2czg8OlOL/9ms8QUqWvleK2gEPP3USy8tJyHWvHH5TFsGqL6vAH53m1/XCjHTJ4Vu7GCHjThcT9O+XenccOp51Hz2eqofTQUtw4SXYNXxiODLv6k3QgiElBtN8mll0zV3QYQyCYm+7Zrc3REYW6aYYL05On3gUPIHP0UsLYs4K3pGJ9CvuWbzIysHleNJ+4qJG07QFxmbNLmjMqt7R6ljyhPqa1vRZ+w/ir9IabnDxNHjnkFsSU+Pd+YW/Axcj5qCh96nRU6/Nq2PG8rBbg12JTYyQxyb9SmLYlm7y/vOZugiVzt2Lf6bH+QDTecwyUgNLU2OuofvrpLA71vCeJosNE0E7QoPVcPxXXrKOAYaLMPUvg13jMRz8XzWSQffxh0U7+zpiQjQzWWmEPW8/qEPLSkD9ADV0ehOBBlV+ZvNkba0sxe7gHDA3lQZOQ79HRfn9GN5qju4n8EmkuZDPs1qda6862NGFuWWrIWGk0e6uuNF5Sw9WeKTyOaK/Wu3J6g3SZKcow6M4LeqBSanifJ0yJUih9G0CQZBiotsS5K0A7Q14liSHo3UBgWrW6UJ1r0D6JB4gJNMPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(26005)(6512007)(6506007)(478600001)(6666004)(4744005)(83380400001)(2906002)(66946007)(5660300002)(41300700001)(44832011)(66476007)(66556008)(6486002)(8936002)(316002)(8676002)(6916009)(38100700002)(86362001)(31696002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTY1ZjhjMHF6NCtqNmFDeTZYK0s1dUZDNThQWEV4RytCUk1lK2k1bkFIRVFz?=
 =?utf-8?B?c0RFNHZKTWo3dzVWY0NmWklsc091ak1semRkRDRDNXFEcXpZZGgrOW1FZkpK?=
 =?utf-8?B?UmZTL1Q5NGtEemVPNGlNRDNDM3owV2E0WGV6L08xRXNsL2NlTjkxdkhSdW1a?=
 =?utf-8?B?UjUrUmg4elpVRkRhSnZKNCtINmJqQ1ZpMGwwMEI3bkJGbzU3aHFDbk02cW5o?=
 =?utf-8?B?RDBXZFo3bG1vOE44N3hCb2NFWWswcGNwRXIydmorbzdUQi94S0RZVk9MZ3Uv?=
 =?utf-8?B?VUVhUWEwY3ZxMzNhVGI2ZnJkMjAzRFNibkR3WTNoM3BoeTBXeVpuUGdwbDJw?=
 =?utf-8?B?MEt3S2lscGRGSWI2R3dha0I1UlFmRDdqQlE5NzJIRDcxQzNrWnJ1U1JkWEUx?=
 =?utf-8?B?eXNJN1ZpMHBCQ0Jia1BzZWNIRE4zVTdtdEZzaHBTS2dpTHpJUEFXYmsvNXp2?=
 =?utf-8?B?bEIwOWtGMWlrL3UyYUl2dUd3bHpsUkxHcnZBRWtXdVYwTTRZMVpzSWI1RElH?=
 =?utf-8?B?T1pMSVd6RzhYQ3ZFeUdtMDhWSDJVRjVBRG4zeUZveDJhT044aWUwU09BRmVp?=
 =?utf-8?B?L092U0s2NURBNnd1T0llMjBBYUFEN2drNmdqZjZYWUMxaCtjZEtJczZ3UWtm?=
 =?utf-8?B?OUFZOXRmTHpQTmUxTFUyT2RLL3dFRGU1enVKRWx2WjlPVlRWQnFzM0ZnYk5s?=
 =?utf-8?B?b3JCTE1HdGNmdmRsNkNXZTZhcWFoMlI5UXcrL29LRUxHT2x4QTJsbzdoVTdp?=
 =?utf-8?B?eHRpaFdqR3k5NmhsMkR3QUlxbE5kZENTZlVpaDY0VnpDZ21MYUxsNTV3WURz?=
 =?utf-8?B?bkFmeS9wZGE1S2J1c3BIUmNjM21wQ1ZPTnBZSWNic1Uyb1B6OGFpUmlvQi9I?=
 =?utf-8?B?ZHdFMGRsL0NXdVVMZE8rTkFHV0lsaXlhSXJ3V3FJT09vYnQvMm5jTk1hdWl4?=
 =?utf-8?B?ZGQrcGExRnNXaC9YYVZtbWV1Ui9qVUIwdnFCbnI1VW5POUJlb29oOXBaQmpu?=
 =?utf-8?B?a1Jja3BySXNyaFNyQnpQdWExSTYvRElWR3BYV1RVODNiSnRUb3F6QUlpMUg2?=
 =?utf-8?B?RkYrc0p0TTRCVVljS2E0MUtEU3hKWGwyQVFhN2dydFg0bzVLQ2g0czlDM1ZK?=
 =?utf-8?B?OTk4TDJHZ2pyNCtUeHI5cFB3bGdJZTNBSXY5MEg5eDF1bFIxcFZJN1pMT3VM?=
 =?utf-8?B?TnJEeUloclBCRWV3ZGIwZGhxOUVHVTNGQTk1b2M5SnVxZUdzb0tPenB2TWhX?=
 =?utf-8?B?aFAxMis0RW9xMnpJRnRscFJjSU9IVUNUN2JWN1BVRFJ0SmQ3VEN2TTZXTlFw?=
 =?utf-8?B?NkJPeU1OUmovUHBnOUNPOUNvRHg0TlRQSmFsd09iSndxS1ZmR0xHWnQxamoy?=
 =?utf-8?B?LzNaM0U0MzhGZ1pxck0xRjZMb0ZuaS9qRUUySFRKcktTanZlRnQzYThja2F1?=
 =?utf-8?B?SUo2WUNVb1d0eFlRNGJIMXZPYmEvaFR4TEJJVUxlUXh4dkVTUFZTYUhsdERy?=
 =?utf-8?B?Z0dOZ3hkOUthUVlJYVhlcitMTXhOdUVKeXZ3Tkp6K2F4andEZ0dmcWsyMkth?=
 =?utf-8?B?blJFY21DZGVWVnFxN2hSVFNveGNJL3FXcCtIQVpBWEVBN2lJakZnSEJGdkJC?=
 =?utf-8?B?bWp5TlZ1RGo3MUNuQUV1Nk9JdWZsczZ6YW5UbTRHWHJQaUVzTjNEU1huZU53?=
 =?utf-8?B?eGlxTjBYVFdRdHhIdDI3dC9VUUtub2trRDd4TGt4VXNJSXBDRmZSV3Qvb0JH?=
 =?utf-8?B?a085U3FZYnZlbW02djdlblV2bFMwZjNFUldvcmpMbVpoU29kdlBFa3ZGQlJy?=
 =?utf-8?B?bWN4VzAwL0ZudittdGNVVDRJaDh5aGtoMk5WK2F0YnN5NDZPRkJHdkFybThs?=
 =?utf-8?B?REtNeE4raGVCU3NZUVNFaXUyanlVUFZwZEhEemhxWWdmK2tWdnNTRWVCNm15?=
 =?utf-8?B?RGRjdlQwVUpuYkJ1WkhOYytNNEl2a2hOSUkyMWhzY0dIVXRDODBtTXVPTFhB?=
 =?utf-8?B?OS9EeGh1NlBpSGlQZFZSZEVDdllsUktVNFpVZjV6MGdtWFpubHR6dU54Z254?=
 =?utf-8?B?RzJWNm03ZFJsekZzTkJ1dlRJNjBoZ3RmdXp1RS9Ma1BWZGJKL202TUYwd2cr?=
 =?utf-8?Q?GJIzULyzLaW2pSaG19K50+JGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3d7be1-6aac-4a1a-a21a-08dbdc134adb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 02:19:22.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N42us5OXCEDoS+JIbXlT0Wm7bUou6Pl+Sek2w5iCHBdKTsO9ISwFWKwj2yh1ClMmUhZLJcYLh1NHUKI1nrZwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,


There is a problem under high IRQ that PSR can hang.  We've got a few 
bug reports like this.

Can you please bring this commit into 6.5.y and 6.6.y:

79df45dc4bfb ("drm/amd/display: Don't use fsleep for PSR exit waits")

This restores some of the behavior of the PSR interrupt handling to how 
it behaved in older kernels before it was changed in 6.4-rc1 by 
c69fc3d0de6ca.

Thanks,
