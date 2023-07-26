Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C27763F1C
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGZS4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGZS4p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 14:56:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025F270B
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 11:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hot/bUK+olypj04Y9xiPaZzFqTwq6AcCcP0h0V0Xa9kKriSHXoyP76wNxQs8apfTVNNG/22OMxFrNPsGOA2o20qHP2IvI9isjCUB/Xzf60WCLBBvjmKdowm9IpGzGI2EmL9bSO/+NfEv9j9zM3xqOVOO9hMrb5//Y1KUKbGu6/6YqpZ8YlXwGkS4zzmsH5Md0HXI2XbDid56EA8ZU2mbT2Emz9usUcKK/9s6J1Pc7kqblVFQM8Zdx9n1AUeuyUmcz+xR/OSO0tiSUEXIB75i/AuyWiw06JIWW2jn0+ApciB5ZrXhR3JpltI80LAo5xsRYAHunlIHCy3XvcsQXtNAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaGxW+xl+3JRzSMDDbqNOxvs0Ja86K6XcU8OV4fsYG4=;
 b=kX9EuePufuugi9hXwKXoYcd9aaox6fDWrJMd2rHdqLSwEvjGCZmv7T+V8u4SRjlk/QQt7HjsI5Hs3h9OI732p/vwuQMFukVI7eKsPieA5dyYf0DD1Xljy8p1iWWqTqLlijvTr4vyGqoa0OsGkBLevpGyKTO5E4tsinFntVnmRdAp4yWXH5W8e4VbIOiKPm8kqHhP3TBHCV/NDinSC3tu4ZmQn0B1IqNHjFc6cULGX1d/tRt4RjQRWfbobxY3I/P7O3nS22Z9oEx0mJueyYEtnEDjjo+Rc2Pbxd1FmjejIztq8tMeyseANI5bn7k0HBLjBLBeF9tIpFGXsa9DNvMigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaGxW+xl+3JRzSMDDbqNOxvs0Ja86K6XcU8OV4fsYG4=;
 b=UY+4dmZT67byHSwfCurU3UXiCkhkRXvakcwsQ3m+qNSPwN8hzcP9ba97TgNlJRsDujcCj3xzXqpFtUVtyOWcfp9NhbaxaBe9m6XgaCqLuLlDgM352/QDmOYb/yQwRg5+jiKSkvhQhKmwiiJ1bb8V2UROxUKlOm1EIB9fkgQPQ2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:56:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 18:56:35 +0000
Message-ID: <4801073d-3884-28df-4196-7a8daabba6d4@amd.com>
Date:   Wed, 26 Jul 2023 13:56:33 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: PMF EC notifications
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:5:337::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9c8051-9ad0-48b6-ae9e-08db8e0a092c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhhf7Tnj/1D50xezK11ePpCJqpnPUzwQTUMlTYKO2Z88EgL+7ljUymVisJGibtd6QXnRX8gQ89uSMyeonfrawb3+26UH1zVJ1l1qeRRyLSkfQEYljVquCBOSGsEmN2AwS9L+7w2LVE4/+8MfBRFJONkXQkhH3VRSl4d8etUP500HPVH0Y2kFcUwJtWvgnkNX7D3TodGsejyiDe3gz6tgljlz8KpucBidreEGNRBqKWCiWcSiqEGY68DoHp2PwcvBXq5Q/rTv4LBnc3SoMZ9m8gnDVxA2IXctK10LoDkD7IjIdUHGKxfjmCU4B4RJn1yzkWPhhkc6c41qq2+/maP4Hqi7pmxalaAhA9aeyg8lf1n6+VEuujUdB3ve9rHClUNtDijGtl2D6zVIkWy5aGD39VyKVc9KUQpnHUt5/NYoCaoemjwUBQI/2hcLoNdzlEIQBczhSYfdbPoy439v3FYB3FKgKjMZ/sS5uX/Rgqx/uf75aaaLgZhPQE+Ljb8c0uboOJftdOLB3B+9nnWymAEFDm5hSdQYON9NOHthV6x0lwCkdlKR9PbpY9VhGgpn5UQUjIwjPOzZ96rRbJYbSolzV9uIfYGfwLRD2RabFlc/OWrFUgZlsKvY/R5v1yXLYvIYWinJtONZ5Fq1LFWrXiIDTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(4744005)(478600001)(38100700002)(3480700007)(186003)(2616005)(26005)(6506007)(41300700001)(5660300002)(6512007)(6486002)(7116003)(66946007)(8676002)(316002)(83380400001)(6916009)(66556008)(66476007)(15650500001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHdzRkJkVVVPZUZMZEt1dEpVL3BsMUJuU3VDQTBXVU9QamFydWRYZmdBS0Iv?=
 =?utf-8?B?VU91eXY2MTdCa203ZGRqUDU3SkNySWhmTm1HM2MrYkJ2Z3RZYjYwa1JnUTdI?=
 =?utf-8?B?TGZjQXNQT2xkdTVIQnFWNVE4czRyQUJIYmVZU1U4cXg5eERSdHJnVUhPZnNL?=
 =?utf-8?B?Zm1LekJtRFBiSzhOWjFKSmVDelpMOFhGTk5uejJpV1FiVkk1NlBIS2lVMFlj?=
 =?utf-8?B?NnhVTmFoWWpyVmplQjlKSTI1dklzOUZYTGk2WnhKYTlHRXJoTEtibnZSZzh4?=
 =?utf-8?B?dmFmcVlCamRydnd3UDdXdUJRYkw3UUE3Z1VzTjhTK3RIaThrZWJHSGRNZk51?=
 =?utf-8?B?Sm43OE9BZ1d2U0YrU3B0Q003SWpDMHhXSGlaUStUWkorQkNvcTN5RjNibm53?=
 =?utf-8?B?UEREVGhVdGcyTG42MmdlaXR1L0NtbTNJMEthWkp0KytGU3dIYjRDZDdNK1VM?=
 =?utf-8?B?S0p1cGU0cUNjM2xBSGNyVXRKTmdlMkl2SUQvQ2w2Ui9nR3NoR1hlMmRpR2FB?=
 =?utf-8?B?U3k0MGE2cDQzVjlLemF4eWNFbU9CRDRyWVo5cUxCMTB2Q3lsa3BscUN1YW8z?=
 =?utf-8?B?RHZyK0JyUFRNOVpGTE00NTJqSmlKcWsvKzhyWWZpVDNwbm5iUTVMc1NVUThK?=
 =?utf-8?B?S3lTTysrcXhPU2JEWXh0ZCs2cjgzUUFjRzZOcldkcDFGTU5IRmZGWG9CUEY5?=
 =?utf-8?B?UEVLMFFDOWNEVXh0OWFhc2haL2lhaEExWWhTbmhPTGM2ckxVK3RtNThsZjJJ?=
 =?utf-8?B?cExBaTJyNW02Q052eWFIMS9rb3l1cVR3clhROUlqU2VTaGViblpJQjBKLzNv?=
 =?utf-8?B?cHVCdFdoZnRLQzZ3ZHU1VWtqWS9STGE4VGJ1WnhNbnQrMWxrRHJBZkF1VWlo?=
 =?utf-8?B?THhyUEEyYkJXanVaK3lYeWUyN0JwUGZFSFE4NUw4QmV2RURhdStuQXdrb3Z5?=
 =?utf-8?B?Q2krTklQTXdXeENYRDRudE9MOVdnT05TREEvQjJPV2NuSTR6RjhTTUJ0Z0Zq?=
 =?utf-8?B?WExuaHpBTkZYSmREUFkvdzlsaER5NHhXdDZyV0IrckNWR1BVOWRJVWxsR0kr?=
 =?utf-8?B?c3Awd0w3R1JVUjB5eUkxUFgvVFplUXRyaURFazhGRzRBcy9MRkcvYy9IcU05?=
 =?utf-8?B?ZzNURmtzdUw0T05PUDVucnRBMW1ldmZSQTJQSlVFUmJ1bVFXbW9vUUNaQkVN?=
 =?utf-8?B?REFsVVFTZCt1bng1RFhKdWx6QTFpYzNWMHhGSG9vazA1dVBxOWQ2ak8yUzM4?=
 =?utf-8?B?YlBHck9jNjlaN0VMeno2WkVReGNVS3k2WEtZQ0VHaUF4SllsOWVPVEkxVm41?=
 =?utf-8?B?Z080SU5hWGlaNEpsOVlSMVMyUitkRDZuSTFId1pvMm5CYlRSbXJlT2Z1SWoy?=
 =?utf-8?B?MWtnTjM0L2lmbEg4V2psQzNPbTVzT1ZNMmhuWWEzdnQ0OUUrOW9TZGxwUWxS?=
 =?utf-8?B?TnFJSkRkWlUvUThockhNaFBTQWRhYzE2ODFKMG0rOUh2OFgyS3NyTE5MVno3?=
 =?utf-8?B?SXZ3RElMa0hpZTUyVXlsNGRTVm1wb1h6VG9aLy9xQ2pCK1RFbW1pR0U0d1hR?=
 =?utf-8?B?WXJpb2ExSlRJbDBhNkE4amw2L0lMVnlJbW94S1paNkF5V1RmemFDOUdHOTZs?=
 =?utf-8?B?MnRiT0V5aXdaZXdhaEVVVDg2TGp4bzFac01JWmpNRC8wTkJsOEtUOTdPSWhq?=
 =?utf-8?B?bzVWczdhNTBpYVFia1BvcUJ0cStIMEhtMUQrN3ZRaVJqQXFLZmFXaHNwbm5m?=
 =?utf-8?B?TCtEb1FUc1VMZDhTMDN2SkJaT1c5NHVEQXhvSVNZUkdkeEhKQ3pkNEtxYS9C?=
 =?utf-8?B?Nm9HYkRMMXRNaVVRTGlIc1dhNVZTVFB1ekNXRnJaeW9OVy95Q1J3cll4b2lL?=
 =?utf-8?B?ZXlnSFFSNWxMTUI2dzN4Vk52VkdBTVNmZFlBZFNEWG5OeXBKYmw4TmJTeWZU?=
 =?utf-8?B?V21nWURCUE81MlM2RzczL1I0UjdpLzRLNjQ3UWZhMExZK0R3bEVOdDQ5Ulpp?=
 =?utf-8?B?aHNOZGs4Z2JGRHBJMnJvRW5mUkdZTFJ4Q2E2WHRUSlc5ckxKallSbnpwcXVj?=
 =?utf-8?B?cXNGWGliMG1YN09RaHRCWjlJUnVCZHJWUTVFTVVDN01VNktsWEZ1bENiU1k3?=
 =?utf-8?Q?1C5bjbOF+sr4ET+WSjP05uqNd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9c8051-9ad0-48b6-ae9e-08db8e0a092c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:56:35.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDKMM1RcYTzfL8Zojfkm+/n8G1cj50B1mP/DeoOh9Qmv2u4Wmky51+mZ76GXptdAJm63xwTi6p+o7V2ROs6Jvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
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

The following two patches fix the notification path to the EC (by way of 
SBIOS) for the PMF driver.

33c9ab5b493a0 platform/x86/amd/pmf: Notify OS power slider update
839e90e75e695 platform/x86/amd/pmf: reduce verbosity of 
apmf_get_system_params

This change allows Phoenix based laptops to use software like 
power-profiles-daemon to configure the APU for power saving or for 
performance and on affected systems can significantly impact battery life.

As Phoenix systems are enabled from 6.1 onwards, can these both be 
brought to 6.1.y and 6.4.y?

Thanks!
