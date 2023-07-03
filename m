Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166BA746184
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGCRni (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGCRnh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 13:43:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FB10CE
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 10:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBd6HWsxWCYDF0R1/lOWSQ5mS3gJKCG7HFB8kMO4mY7j8fFYXGH8sTH6hqeN4hUKAj+EqN07z3z/gP9xNEW43aY/wYgRBYxOUzT8j7JQBvf2BADPyLij+hVmSEd22LMKCgDMPYXwKx8XYskqLqJjDblNM58pPczRjiOPfQQ/E7MNn/dLen1yUwVuCJQ0KJ9AzZrLe8/yG+PSSq5sVyu0kxi7Nd0Mdsq/zfWRr63HX1Ys2MZ/Xr4Mlhbe2MJWsj/j4E55JgpgTO+xR1iqs7Zdom/k4JpMmFSuzuj81zlYa+mAi6uIi4ItyabWtasqNMbfHYyLvwblq7vMBlBZs4j8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB6j61Uklm2CqMsaWnCsy5Y7sJHhvBGRZL9bckK+X0U=;
 b=TlkIwmvSOv1hI5KWL4pakLz2Uli/n4493sfq/XBrO3wf8B7RyvDHYv9bq5emaKNEuGyWQRE3p72X0XGG23U0f07/flzu2GDJWlWXppVIpVGCBErRcKdDbNDQmJ8nXNfLtZLS7XVgasjO3iP+vhPRjIlHHRvidXZCSu1/k6rFe6vieg+g7IQSzZqO8qROa2YFJNQBQEmxP777frD7CME9pcxOQiBCgFw6ST9AkZDn6pk+LnWmPVTOz5DhDnbaqhZvNQ10dQ0bN2qd3+faIJobQTl6y+xbcnhcxEjTiBOeJ8wVAHex3rN5mtBj8bFF21yVk6UvmIl+9nBHRDDOtZp/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB6j61Uklm2CqMsaWnCsy5Y7sJHhvBGRZL9bckK+X0U=;
 b=ysr15GyOwe9BBVPHYHBDdjlDWFP1UVnl+rHJi8ze4/loS8lbere4xVlNRwSMAHgC9ItI2qXHg0ad6/VO1PQ0ju2GynLQ+b0f0dz+Z4xzH9DQvap8+s34q6ASuFok7mcqeCrbERv9/jVf+pdF78b4OaqSXlZaf2KPSF1kfKDVQE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:43:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 17:43:09 +0000
Message-ID: <4e04459c-3ff7-3945-b34f-dde687fad4be@amd.com>
Date:   Mon, 3 Jul 2023 12:43:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Regression in 6.1.35 / 6.3.9
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2023062808-mangy-vineyard-4f66@gregkh> <ZKLT2NnJu3aA0pqt@eldamar.lan>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZKLT2NnJu3aA0pqt@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c53f399-c318-4745-5aea-08db7becf726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3qcURASv56NydegJEDjiJfwJ6H0mx0ihWoBeBruDxCpRn1mYRcgSxjckoy6tV/L+cqXuY6HmBiN94wDomJLiiIglaaKiAybbYYYD3IUPrOsauBr6F64gzM8VN4+DUVC4XNnuln68icskRphy+EYkKzU6MikTZo5agQv4klCy4UwrJ0sEO38JgnUNDbjJbOHmWngJT/J/G2jlvwXmOOx0xGvJJJbRW983/FzricpAetWGAnPAXaY52QCtTUqWSfdhD39ef1h0llGxvARRMG14PXsJL4ZZcDyVhhT2rxUeTcZA4qP7C2SoTkn5NRNDTUPeOj83jjoAD2k29g6w3ZuuEmK/pKnayh9HAH91YcMazCUxATgUlSllKZU6BkeynBlLPI9J90vpzcb3k+8JNhXBoVXHktmlvjoWOy/VIeNqgxM1IXWr/TDoeJUPipdaS24dKODDpHCLSmxQWu676kxMcr30TNRGxPXAFnobZH3Pv78lJl0p0DbtLrC84Z0BdMGIsU1xtBH+3tEACZYJE8S0SxxJCbMo1oi3XS1XVQBbZNnTfRNB26wxB8wqopmQabD84FjnA+3zckvqhamGLZuEXWv6B5qMEYFE634FkN+Zd47AVPivDlh6tNKvs7jVVjllKAe13GUwrq2s2zI7pFaryiFX8H7EDsnxHAnWhn159Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(316002)(53546011)(186003)(6506007)(41300700001)(38100700002)(478600001)(110136005)(66476007)(66946007)(66556008)(4326008)(6512007)(6666004)(6486002)(966005)(36756003)(2616005)(2906002)(86362001)(31696002)(31686004)(44832011)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFVODlsSzMxZFVnWXdadHlBeGVQVTM4U2R1YWh2WmNXd2JrbTdtZUIyS2hQ?=
 =?utf-8?B?WjFLNkZpSmZIeVJRcFNXVXBVZVJNYURmckwxTFJ6L2VLdFNiMEx3azFWZkRP?=
 =?utf-8?B?ZDNKMDBwdUI4S29tMEFtWHpCUmhSaFUzT2V5Vk52V1RNZWQ4Vmtyb09DczJQ?=
 =?utf-8?B?OCtleDkzeTE3cGFycVo0Ty8vMjNITWppdThkekJkaEJqZG1MSXo1bncxWGdB?=
 =?utf-8?B?bERqR2k0dkJnNk5udXlFMmI4NlMyOGdyNUgyMVVRSll4aDN0NER0V2FWSlpn?=
 =?utf-8?B?OHEyTVhNRXVlVTVrWWZoTGRTaVg1MDJrK21HVzd1YWhLbTlvWlpLL3VyejRN?=
 =?utf-8?B?c2pqUUN6ZVZYVHFoUkJuaE8vanRrVCt4amFRK0pXcXZ0VlZvMEJ0cUxoMGtN?=
 =?utf-8?B?WEIxMG5KbW8yd2pVdmtaWmJ3dllRMHZJd0hSM01PN0dFK2x4L2hnQ1B1dlJO?=
 =?utf-8?B?bFkzUlBtaFNsa1BsOWJvKzcrQ01udGRRSFlaTm5MZmFIdEU4ZUxURnR4c3ZH?=
 =?utf-8?B?djJlTlBTL29RbmpWWUxJbk1EcHdUQ3NabVRWdmp2TWVyaUxsazJSNldNRnRq?=
 =?utf-8?B?Z1ZiWlRpa0s2VDA2R2VteXlIbXBreG0yYUpiV0VrWkNXTlM1Wkx3VDV2UUVN?=
 =?utf-8?B?Qmp2TWpMWDFiT2NVaUtiaFF0T0VoZVhEVGlTWi9KNWp1VUk3ajdmZ1pmR01w?=
 =?utf-8?B?QmpNNWJ1QlEwL1k1VThqc01jb3JyMm4rNFlMRmxyMkRNbVFJL0FvRUxpdkVW?=
 =?utf-8?B?SitpVmV6NGw3RGt1MXpNQmNLZnpReUxicjNjb3V0MUJ0a0NxaXMray9KeGV4?=
 =?utf-8?B?My9GTlVqdDBtejdEV2R2TkdBSXJiUHdvYjRLSVg1SDBWTldJM1pDOE8vUm82?=
 =?utf-8?B?eVhQQXU3ektsQllNTlJJRm8yWnRaRjRYMVFzOVJKUFNNM00zQk5ScENOQUQ3?=
 =?utf-8?B?aFcyM3ZkclJwb3ZpM0RUcExlTlRNdStXbGd1VWdJUWxTWjNUK1puakI4YkQr?=
 =?utf-8?B?dUh6djZJUnh2R01tSnR0ZDRreHpmV29QVm4wYWUrU2lqblhiVXVJTjY2ODhq?=
 =?utf-8?B?YkVuV21RRjhqZnZmUHgzN0dUSUFFVW5LbXVMajhkb3dpNE9CVGkxMTluK1ZQ?=
 =?utf-8?B?eGRuUmwwaE01RW0wV1o1L0c5eXR0dkU1WDlxRUE0c1ZKZmtOR1Vab3cydHlz?=
 =?utf-8?B?VjFiTGJpMlhaOUsxMTVHMlYxbVBWSUVOUzRnTlg3L0ZXTTd0QnlSMW9iZnps?=
 =?utf-8?B?KzFRbmNJNGFnWGpzYVBiVjAxcURZeXFIS1FodklJYktZTlBHNFBxVEU1Nld2?=
 =?utf-8?B?V3ZzdEh6VGIrS3VFVUxTZ1RaYXhXT1hpZHI3OEhYa1kxV0xVd0F1SzdSZG4r?=
 =?utf-8?B?bzcxYno1bUl5VVRhNTRLOEJmSjd6eENXK0gzcWJ0R0tpSmNTTUtNazhYd0Ex?=
 =?utf-8?B?aURRa1N1Y0JSWXFIZE91RUV0TmNIaThKRjA2RFdFMFhOU2pkeG9lRm92Z3R6?=
 =?utf-8?B?RFNpaFZ4RmovYlIyUFBPMllwQ2d1VnkzRjVaOFhMSE9US3cwYTJLTGJSYzdD?=
 =?utf-8?B?K0pvUE45ZDhDdVQ0ME9Sb1diT1lWT2JWSDlHMFRCQytVbUpzT2JIUTd1MWEr?=
 =?utf-8?B?d0FkSlFGTEZzVU5aU1gwQTJrNzR3bFJUVlJtRjlYK2t3b1dBUWRjZ1dOeURD?=
 =?utf-8?B?b0V6eVpwN2ZHOHRranRHSEtIdkJGZDdNNHJuNzQrUmx6aHAzVXJWKzRmVlFW?=
 =?utf-8?B?UzVFZW9VbTJhanhic3dJME4vVU9EOHJzQjBXYTdJckFrSERKc3V1TmRrY0wz?=
 =?utf-8?B?cTJCTlVUa1FBRmZRVGhBK2xRZUFCYmV4bHpGQmNWSXF5enFjeEh5SEdhTUxs?=
 =?utf-8?B?ZHRJU3NiWmZrWEZ2Vzh5aUpMdEJYQndZSHBibnMyVmo5T01rRFhOSHppUWw1?=
 =?utf-8?B?elNmY05KdXRTcVNIbVdGZkptSDlxa1AxbGR1TUE5cEM2b1pJNThoWm9keVJp?=
 =?utf-8?B?NUxaM2dLMSt6SEdMemVQRmVFQVdYMEZPK3Q1T0lQTmJaOXgxVVZSKzNnT0xI?=
 =?utf-8?B?WGtvNkw1bXZFS0t3VFlpTi9kQXM5Y0NhQVo3cDBLdXVOOVFwL3hwRHIwMXl0?=
 =?utf-8?B?dEU5TnoyVldlc1lOUGtIeHhMK1M3U2hlN2FHSHVqSHhCbWlkMDFsU3IwVlBT?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c53f399-c318-4745-5aea-08db7becf726
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:43:09.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dogIpTuhNir9ipvm5U31rLpIoduzMfEQkfJDFLUrL72dkOezypJDruOrJilTkzlzLuEg31wl2G6lcD6RbFShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/3/23 08:57, Salvatore Bonaccorso wrote:
> Hi Mario,
> 
> On Wed, Jun 28, 2023 at 08:16:25PM +0200, Greg KH wrote:
>> On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
>>> [Public]
>>>
>>> Hi,
>>>   A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
>>> e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
>>>
>>> After discussing it with the original author, they submitted a revert commit for review:
>>> https://patchwork.freedesktop.org/patch/544273/
>>>
>>> I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
>>> trees to avoid exposing the regression to more people?
>>
>> As the submitted patch had the wrong git id, it might be good to be able
>> to take a real one?  I can take it once it shows up in linux-next if
>> it's really going to be going into 6.5, but I need a stable git id for
>> it.
> 
> Do you know, did that felt trough the cracks or is it still planned to
> do the revert?
> 
> Regards,
> Salvatore

Hi,

It's part of the PR that was sent for 6.5-rc1 [1]. Unfortunately it's 
not yet merged AFAICT to drm-next yet nor Linus' tree.

d6149086b45e [2] is the specific commit ID.

[1] https://patchwork.freedesktop.org/patch/545125/
[2] 
https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6149086b45e150c170beaa4546495fd1880724c

Thanks,

