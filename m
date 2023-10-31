Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A167DCD64
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbjJaM7P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbjJaM7P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 08:59:15 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F80BD
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 05:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnqV9QAtTx7Bn9F79Kz1cPDfU6tuuQNYb3CO2gJvXoMMjMZBs0im8CN3uVEwhg3YL5d/lULUGkyK7MEb84dlyDte0gP3tbr85VPVeHT3LtQLdoLHa4Eb5iEfO84Fd8IbZp2OOZXYLthj644Rsi+zq7FJN3CEUdgqgnR8U7utHfj9yS87/jVCCW/RMTtPVoixTRFYYwCtEjsctKPByW//+aZVqUYWg6k9nKL68nMz8gKYXaCqE87eH9zlND4lVC9cDk1nZ7gtnZkl9kXx1Ou69dK83R0J/RL09I3rC7/i7Ru8YH2tJ/WH7uzLecNB4lsnAejkwwA9fxe1Psbh+Ii9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqDViyNujnqEjO95H7E0Vs1e6K4V+lYLUXwqU/linY4=;
 b=hh+KyhVxuikZbBX63yxRhrV5/QL79n+uctOrb0XDfahSbaFFETnKh/DZMp/VBip1b2IW8DPsWCb+HpDQWcsJi4mLVeeFY3IIKWHJe/N4SmFr1Rg/fsSjD/evFAVOzQ8ze5XNrj6ReuhdfhFyEqKO6B2eWwnwgCRet/x2y0JzEwFPHAbFTK+Oh6u2zWt/BQ93L2xcuqnLNKPPuVRd85QphB5cqtCGFk1RJXTfx6TzXpo2oydZPMVcBlHE+9rs+LMpXARrUUg7BmaAGyth+QP3dyVddcaJy+l0nr6mH7ytpPhTWT0T7KKBmHN/wvFzxCG7w2bxa45EEI8xoE/3bZTuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqDViyNujnqEjO95H7E0Vs1e6K4V+lYLUXwqU/linY4=;
 b=34m7jemc7wGZdct9ER4J7e+UV8JCW6l7WY2plFBU6/Icw32PS73YP8kq1MxPZ75YSHAabM+75pAwHbHLiNocwkgruh1WLoAnEjuGFzATLdEuXgPCTdFA9JgiA2nCl7xRRKDL3vWd1EPd4wrYhbaS9wAQP+G9vUvrzOHhTPe6a7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 12:59:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 12:59:10 +0000
Message-ID: <4c4e59f9-df97-4858-ad44-cf0a48804430@amd.com>
Date:   Tue, 31 Oct 2023 07:59:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5.y] platform/x86: Add s2idle quirk for more Lenovo
 laptops
Content-Language: en-US
To:     David Lazar <dlazar@gmail.com>
Cc:     stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <ZUAcTIClmzL2admd@localhost>
 <f10297db-3a65-4e61-8f59-3f029e69dbb0@amd.com> <ZUDgv5ZyhvyLh5JD@localhost>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZUDgv5ZyhvyLh5JD@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:8:56::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b8a014-5615-456f-aa74-08dbda112cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ifa+xb0B5uG8E/7SuYulr7KTSF/gTPNy9h9asKOVohr/k9bWcaGW35wn3vFy9cQ4hMK4IbbLPPmF+l+q1pfNFe9uwGE+GgbokZvAXoGZK8rpLAa3Dh1e1LPhU+CXIwrP6ffXAv74csckhJrsLhFUpQ4A7bcM6hYxDXsXJYANIj7CRTRb2lL2O5hFpblJuo9dCNjU5WkOWxI3gT7iwsa+XXciHyLCpPQkw5IWR2e6rHGwzp6RFhJ1VOIOCedaLNJpYUE/GAiPSkjvb+DKHXaWiWFH9tUDgg4UZL3VI/ctQuIBfL0kXe0tkDSj8biziZ3HQwgPcLDcWT/dCozIuGOb5qF6DMwzzME+hy+V73FuO1DLsatmA9+cikZMbjCSBZwR0aUVB5O/oC9oT46t+P2UodAJvPkN2xva6mutKVPqbS0hdZSUWqQCu64BRcpHUgG3spZxnJOB5kfpEP6gXPtc7p/SxGXXqs9vfESQPCku/9NjQgfB0S/jOY+ZebnM9MRTlGctRpsQ3qQiZR47nsaZHQC3jjqS/rbPr9vHJXOA07sPozrC2vKdtsgBvalKaJT1j9lTmViO7wXCVCL3ettvdAHX92qr99K1S4D0gNzUHSz4oAx/awx2pye8SX0upl/JtNoMybe3ofzdaAxS8kzCgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(31696002)(31686004)(6512007)(6486002)(478600001)(41300700001)(8676002)(8936002)(4326008)(53546011)(44832011)(2906002)(6506007)(83380400001)(54906003)(5660300002)(66556008)(26005)(2616005)(316002)(66476007)(66946007)(6916009)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZQMlVmdlNQS2IzL2lNdnd4SGs1M0FCd2wwZkVwZjZuTDFxWWFHTGhXZzlN?=
 =?utf-8?B?OUtIRWFyRkhoY0xVMFpwZWp6alV6Q200ejZmdUREQmtGeU5rSG9zdTNBbG4r?=
 =?utf-8?B?VWN4Yy95ZkVmdHdHOXNSSFFQMUNncys5cnhsUzRzMUMyMFdkOUVHanNMUDB0?=
 =?utf-8?B?MGpDekdvNDZxQnYwemNsaXNUMDAyNTM3UldLQnVCZVBpemFER1pUTk1UTkJT?=
 =?utf-8?B?aU4rTUhCN2h2TDdkNnhZdGFieTlyaW11QVRmeW9NZmN1S3lLcm1QUkE1R1lq?=
 =?utf-8?B?NTYyRGRickhTZ0ZJdC9QdjJNc0NHTHFKTEc0b1hERS80c3JaK2NLWUtVdDZq?=
 =?utf-8?B?czNlbzErL1NqT0J1UVBDendWWkx2Q1dzVy9OMHE5ak8xWEpLQitZTUtmbmFu?=
 =?utf-8?B?QkM2OUZZNEppSzQzeGF3R1pZVDMvbFI3eHV1TFNlM0RYVTlxbnJrV0Erdk9P?=
 =?utf-8?B?cTFBVkRqbmFSYTlXTjhxZGdFYmEzY1h4c1MyTTBnRTFFMkc4TEtJSlB1eEZQ?=
 =?utf-8?B?MkFzM0xZTGhqZHk5UHhnS2RFOXQ0anBieG84QWw4akxuZzFqZVZqVXJRN1N6?=
 =?utf-8?B?Y2sya1IzdnFXZkNwWC94alN1WC9CR0wxbll3SVF2YlU1WXRvWklIY2x4ejh4?=
 =?utf-8?B?akVoYXAzd1JsTzFpcTRjOXdSNHNqVlJZd2ZEZHg0c0Rtb09sRnhuaElLWDFq?=
 =?utf-8?B?SFh5UmZBSTV5ZEtWVzE5MGdQbDBSSE5BbUgyL0tLWkFvVVBOV0xDZW9UWk1y?=
 =?utf-8?B?SkdmSWQxRFZXWVBNaElKbjdPQXJRLzVmNVUwdFlNMDBqeTYrOE0xREsxTXYw?=
 =?utf-8?B?RTZOR29lcDQxUmNsdzlzRzlmLzN1REdLa3BUTGx1YTF4NE5jeW9XY2RPWnR1?=
 =?utf-8?B?b2xTQ1Rtc0xSaE9oS1JCZjloaFBKQU1OSnY4c0w4d3JhZ0ZES3JKQ2QvUFJZ?=
 =?utf-8?B?aEtYYXQ0Tm4yUzZwSW5icTRtc1AyckhzQ2NhRE5ENjc2UVdQdUxCUVBWWnd6?=
 =?utf-8?B?Tk83dFZFS1NlWDRFRU4yN2FobE1HTSs1cGYzZTJhdjdiRlM4RmQvZ3NYemZ2?=
 =?utf-8?B?ZE9LU2pTZEswdFIvbG9JTlBBRUpvTElwOWgxcjlUMTlCK21HYW16OEpoQWtE?=
 =?utf-8?B?bzZTL1FBZ1RpOTBmOXAvUGtrdzVhM3VDUGViUG16ZzhyL2w5UUV1NmFoV1lJ?=
 =?utf-8?B?YVZKbjhkb3lkTVRnWUlUYWZNMXlTRnliVkFFQ3BSOXgxblJTdWNSQzJoU1FL?=
 =?utf-8?B?M3dORXdoblNtQmlXZTdmaHlZakg1ckNEM1RNRFVNRmdGMmp5SmJPbjVuZjRO?=
 =?utf-8?B?WXI5RkNFaGNXKy8xRXBmQVQyb01tRlNUcjllQUVDdGhjN3ByeVhsQzNLMEJ5?=
 =?utf-8?B?bEkxVUhDL2NSdmRCNkYxaG04YklCVll6YTVkdWp2SU16ODBSd1FhQjlYWDVP?=
 =?utf-8?B?YVZhSyt3U2p5V3RPWUJvOUZ4cmZmcVpBN3pkL0JMcVJlc0hFYlcvQWxzcmpW?=
 =?utf-8?B?bnMvOUliL25ML25ObFRVek5jTkJlUWZmQXg5Z0FYMU8yMmN5cmRLc0tWSlZU?=
 =?utf-8?B?TVF3WXhEVnhJbGNrS1NtSmVHd0taTlRwcG5yV0RRNGdkMTBDelZkMktrdE5v?=
 =?utf-8?B?TWFKOFF0UXVFVTBVVG4zOXFGMllHdDFyQk9EblI2MnhmSVZMcjJkUEVxekF3?=
 =?utf-8?B?SHlWZXppSFNmK2I3T2FhUGhnZmtrUCtVSnBSc09vUU00MW1ObFIyMEZxKzJS?=
 =?utf-8?B?ekhpbFZVU1o0SXAwUUs0SWV6KzVtL1c3VjdqNFQwbmtpQ3R4dC83NjZpbFNS?=
 =?utf-8?B?N2xyanpUeno0L2hkSGVKbE9ITS9sYk9SVFZ6a3pUSWFULzZVc2pMT0FLWVJn?=
 =?utf-8?B?RWlnZll3UFJGTjEzclY2c0oyVW8wWnFBajJUdHl4K0hVM1RWaUl6R2lXZFE3?=
 =?utf-8?B?UHJjcnZDNnIvZkVCWXBZRTBiR245Q0VIY2Y3VDR4K3BLZGhiejdJYUJUdHlD?=
 =?utf-8?B?aW5CUU1oY2NKYjM3djQ2eVp2V0hCZGdBWXlWWFp1R3pEMXlza2lRTkIwWTg1?=
 =?utf-8?B?dVpjTDNtRGxjUXYxNzNoT3c5cUcxSTJIZUNiVm9ndFhwRVZuTCtPemNobE95?=
 =?utf-8?Q?Bf6YQWszCcj7LNRzFFACwxtUj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b8a014-5615-456f-aa74-08dbda112cc7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 12:59:10.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: typJUdxDn1noELPqbgr1uH4zAHB5yItTOK1hADu2bnWO5W1jrg1CwNNOkzRGivwEPZyTFsaypw8rRS6FZGVjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/2023 06:10, David Lazar wrote:
> On Mon, 30 Oct 2023 16:30, Mario Limonciello wrote:
>> In this case are there modifications or is a clean cherry-pick?  If it's not
>> a clean cherry pick, why?
> 
> This wasn't a clean cherry pick because the code has been moved
> from  drivers/platform/x86/amd/pmc-quirks.c      in 6.5.y
> to    drivers/platform/x86/amd/pmc/pmc-quirks.c  in 6.6.y.
> 
> 
>> If it's just missing another system in the quirk list it's cleaner to
>> backport that missing system and then have a clean pick.
> 
> In this case (the 6.5 patch) there was no missing system in the quirks
> list.  However, in the 6.1 version, the HP system *is* missing from
> the list (it looks like the patch that added that system wasn't
> backported to 6.1).  But even adding that system wouldn't result in a
> clean cherry pick, given that the code had been moved once before
> from  drivers/platform/x86/thinkpad_acpi.c   in 6.1.y
> to    drivers/platform/x86/amd/pmc-quirks.c  in 6.5.y.
> 
> I had refrained from adding the missing system also in order to stay
> close to the upstream patch.
> 
> In any case, I see Sasha and Greg are already working on these patches,
> so I'll leave them alone for now, to not generate more work for them.
> 
> Thanks for your help, everyone, and please let me know if there's
> anything else I should do.
> 
> -=[david]=-

Got it, thanks I think you made the right decisions in both 6.1 and 6.5 
versions.
