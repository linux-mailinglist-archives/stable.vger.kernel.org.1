Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3078782E74
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHUQag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjHUQag (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 12:30:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91449E8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 09:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoJUfNohG/y1Lki1eseIReXr7Pr5ubAy/cJOxGmejn9dsiIr/pyKVd0BA3jYfUAqc0+rp3tL5hVnYVgd2a421KIGYbCP0JGe8htNlolDl00rFt6mgBgqBmvlXbt6gLblCP7yiJwCU9M42xdJ5NU8uYSSlh+eTZSgJ4HWYj3pL+kSGVCz7pO4t8gY/d5RXhTSsMZqNz3fnAud4MoyOsZwzHCiT3ZeYD0vCdmdHK0W4arMhFCRkSZaVaGsYk5kSQVq4/SwG2KDzpjhb46b7Spu12f36STIabWo4MqMoEqf8/lwHLY9Z/Odgxcr0HGyjJHFJsz4OgdlcBbzVm+wIi6kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2LgEuq1CTJsuGk2E3ecYa2W1DQA1pNG/SjXLl8foww=;
 b=myk9+hOb2aS9ejmrxyzd3wqMKIqlzxhWZ17SH96g8dOqX/FpxvQ4LqdFF7sMny4COBz2l8K+WGtOWfTxeJKcxPYmf3hyjdys+h0LlDhUW8eCxdMGbGmzmN5CH7HImrHafz8VSiR8CjPcbbm5zlXPE+Mjfigo6JBbVm2iI0QtFIvIm2MNa1ZjVB7P7xq4JVGG4DaOIlmTyh/lWVpKRGv1jGyu0+1NA198QjBrzmDwDqnKEjWZYh5sgHPOWP54nNk6PnYNtFT68S3DM65xxcPPKZ85oKgUMH7kVSJDXGLwxUJjP8B1D3xp+tkv3PqZD9+W8dq7YDuKoKslJlJ4dNHdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2LgEuq1CTJsuGk2E3ecYa2W1DQA1pNG/SjXLl8foww=;
 b=zd1yqibTGUQptij3BwjnxckATPlyAlNs9lfmYmAeeFumCvkMIgy764h04U5upNi3Erovy8NCKbwhCdpqGD9bnIf2Hv4QrdGgB94/zYNWbrYOK+QHQHKIXQt5dAb/ZuG9r5o7sAHs4z3Wpx7n3LRdPPAmx7mb5WI5J0YA0B23ryc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:30:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:30:32 +0000
Message-ID: <0b151c40-3edd-4511-a647-4e11e2308841@amd.com>
Date:   Mon, 21 Aug 2023 11:30:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: skip the RLC stop when S0i3 suspend for
 SMU v13.0.4/11
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tim Huang <Tim.Huang@amd.com>, sashal@kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20230817134037.1535484-1-alexander.deucher@amd.com>
 <1337fb94-3a31-4aca-897d-8a59e7500dac@amd.com>
 <2023082112-matchbook-favoring-48cc@gregkh>
 <2023082101-diocese-likely-63c5@gregkh>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2023082101-diocese-likely-63c5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:5:330::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 159a2135-241f-4bfc-c72c-08dba263f056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5B5XRNxx6/2NSc498aOpxuBrdl5moM650q4PMr/X7U6q7g6QeXI7qoXG+0qZHpZYPbvydMyruk2ZSdd0IA6J1yj+qG3K9zp0JRYvbLau9DoMurlwlpEWJz8A+2qHbzaoqCPsl95WZaoC8ro06OQyVJ1aNxWKijVQQhiEcJNwSqdxtiBQylcathOP7ZBN8aA62HUG7UcJFuYugM6TJBgD16YiPEGSHTHPttsxD+oBqTZxA2J5AcXVhj71bUWjHLN/h90M0oXfr8AZYlAfiE8gYe0VYLTygWqu3VWxbOpnZdZU4hhJyoi/PRghXmHOyRS10XUQGn0QNwwgbMbZ2AOs5xpVgKpTuAnx9WX3iFyJiCQdxRoaBR36QjBm81cZDXKs4n2yoikeLmHiZGzflSkqym80gLdD+atxF11YhCsd0jKLU+JQ759t6xeae+kz2cZweNHYivvPsZTvH/CaPS8TC8oWyu3ZtMm0i7BmX9GhaGYZUIYyrpKnCtoVdGeYeorHLZNV5WZvsNCP4sr0gPwarrniyY+rGTtZezREbTM/H5Rm9PfTGAYcgce/ADafx85MuE7ZZx4WipLb1SGfHLOmTVFCgczmdgcVdI1TS7ptSeF8RF7OZS1DHOA8wtnhZnaNnQHgPidOiGegtkzeFqmdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(186009)(1800799009)(451199024)(54906003)(6916009)(66946007)(66556008)(6512007)(316002)(66476007)(8936002)(8676002)(2616005)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(2906002)(83380400001)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFXVEZOREEwNkJleFN4NEdoVENjMjdWdU9nZTFWVGdCVmRObVBycy9mZTIz?=
 =?utf-8?B?dnZ5SFo4d1dLLzJvOFgrZTJsRkdRWXRKQk40WHFZSTVqa2FmMXVaSldQMDJR?=
 =?utf-8?B?aHgwOWt2WHc1VFJZNE9zeC9tNUhkRFdNNG9Sazg3cG41NG11cjVBdEtHQVNT?=
 =?utf-8?B?aVU4WGhGSnlHN1JBMTlIWjdwbGtxZlFWcVFNQkpFM1kwVVZGTUJVQ216TWht?=
 =?utf-8?B?RVZodFlSMDNCMGp1NTRQd3h0ayt1Y1kvWUgvOEVqaEVxNlpiMWJkK2x2Ni85?=
 =?utf-8?B?NERoTHBGVi84Q3BJRDJRMkZDemx5Y0tvUldXOXF3RnlxMjkxdWVVUFJDT0Nz?=
 =?utf-8?B?T2wveWdibjQxaXlDaVhXcDJEUjRMV3pEYzFOM3pzbHRvYjFlSS9UaWVjYTVR?=
 =?utf-8?B?VFRzZnBucE1STDN6ekJyMlQrK0R4TDFZU0lpTEg4K2M4d2wyaHkxRnBLSGFt?=
 =?utf-8?B?azV0MkZIUTNZZzhiMk5hUHYrTm1lNW1SaWpUWC91Y3IxUHYwYkpiMXY2cXVI?=
 =?utf-8?B?ai9haElhTmdJRHo1SEQ2MWdVQ0RUVHBZSDlRSDBGdkFEWWdxcWRRblpxdDll?=
 =?utf-8?B?VFBESVlRMTVSNFhNOW1jRkd5Y2tiWmlhbGFQWVdSaDU5MVhVWjZra0l5d2Vq?=
 =?utf-8?B?bDZjSU8xRHFWL2owZkROcGx3OVBpRllCbDhHdk91NDgyZHd0SjFqN21rUjRJ?=
 =?utf-8?B?M0xoOWJpRDh0ZTZtTS93Vmd2WTQ5dHI0U1d3SFJCdzF0a1dWZmdhMHpGN3dv?=
 =?utf-8?B?SUJ0Yi9jL0hyY0dOKzdqRFB2WEZkOWJLczN5MFlnMGgwSHlBOFpLMEVPY000?=
 =?utf-8?B?Lzk4YVlsZzNrQ2hhWWQ2aHBGanVJYkZoVjY1dTZqQ3AybUlXaHdKZlJrSHlz?=
 =?utf-8?B?NmE2WDdqKzR4ZlAxM2NsUXdobHVOZ1BzRThXWHViWEp2VFRvYlRsK1JheXVT?=
 =?utf-8?B?WkFualp2UWVNSUxyK1dnS2tKWnByNzZtc2NIU0dEYVpRdGpmNk9ncW9tUnhh?=
 =?utf-8?B?NXEvUExEeVJWNHdCc3JNVDVpZ2FsdlRxd3JJWnhYNmdTQXFlUmQ2L25ESThl?=
 =?utf-8?B?QndpemdJYlk1MlFhUTZxSStQQ1JXbm5ySVVrMVZzNHdxNkpoaU1qQXVXb3VU?=
 =?utf-8?B?VFdTN0FzZmxHZi9JUzFHOS9LNDBpY1pVMlUvQXR0bjM5b0ZaNTZlb1gvTHVU?=
 =?utf-8?B?RUpPTUdOZjV2dHR5R2RzYTU2MFM1WG14c1VDaW5yQmFoVW41VGlDc09IWVlw?=
 =?utf-8?B?b2twWW0rS2VVVnVHYUxycG56dUxEMFl5b0hDM2RXV3JnTUZJdkMyOHo4SWFt?=
 =?utf-8?B?R0NqTExUMk0wZWs1VWRrdnBKTHZ3eFRsMWRRZE1jMWZ1dVY5T0RGMlJhN0NN?=
 =?utf-8?B?RTFURVlFQWtNeGJQdDZzQ21xSEp4ejhXYkFVK2NJbmZSUjQycWRtdnkyY0d2?=
 =?utf-8?B?M1EwL3F1T21jVmJxSXErMDNZM1drUzdialBQQjNaY21iQzlIOXU5ZUxGYUox?=
 =?utf-8?B?WURzN1VpdXpkbGtPTC9aN3lIWUlBVERnaTZ1by9CODE3R0w5dWlJZGJBWmRl?=
 =?utf-8?B?eGJxb3VUSnZCdmsrM1VIWUEzZDBoSmdlc0FVeHd6akFzQ3BNRzZzTURLTGll?=
 =?utf-8?B?OVpTeG5mKzgrU2NDWFRPVUhZUVMwdjVjdThxVTFMeTVwaGhpUnJUWWtaS0U2?=
 =?utf-8?B?cTZweko5Rld1eXpKNFdZaFRFWVgxMXFpRjVEV29QSGpqaHFaS2Iwb0pzRkhs?=
 =?utf-8?B?b2x1OW1BVG9Sd0tYR2cxT3VFbE1saEppeDBsWE4rZGhmZ2NOT3o5U3lZWjVl?=
 =?utf-8?B?ck0wemJUZlllTjMzaWpDbERPalZmNWxBdnhFemQvQ0cwYjAycDFvanl2T0dE?=
 =?utf-8?B?VEVKOStNUkgrWUtnM1ZlUFJvVGZwRWQyallPeVRqUWppSy9abkZnOUQ3K3Y3?=
 =?utf-8?B?NXgweDFlYkFCV09DbUVtd09qc3o0cldkV0o5MmMvU0dlekdRVWRDc0Zjc3hp?=
 =?utf-8?B?THM2NC9tUjJCTEdMRmV6Qi9aNklKVkNsTDc0THRHM3VLQnVKaVIzVmVtdlY4?=
 =?utf-8?B?eUJnaHF0WkliSEJNOFRNb0M0Qm1YaXJuL0tlb0l1Mnd6cXo1a0pJTGpWMGlH?=
 =?utf-8?Q?YrHl9c+kpxuykn1phQKnUxX3L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159a2135-241f-4bfc-c72c-08dba263f056
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:30:32.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfVa/NiaLsUPtsZCdn3zcbbWULTkdak8OVl2ttAFbiLoSc5iAwFAiNWrVT6gXjwdUCq8NlCfnGg/XmEloVkFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 8/21/2023 10:37 AM, Greg KH wrote:
> On Mon, Aug 21, 2023 at 02:56:41PM +0200, Greg KH wrote:
>> On Mon, Aug 21, 2023 at 07:15:53AM -0500, Limonciello, Mario wrote:
>>>
>>>
>>> On 8/17/2023 8:40 AM, Alex Deucher wrote:
>>>> From: Tim Huang <Tim.Huang@amd.com>
>>>>
>>>> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
>>>> the firmwares will handle that properly.
>>>>
>>>> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
>>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> (cherry picked from commit 730d44e1fa306a20746ad4a85da550662aed9daa)
>>>> Cc: stable@vger.kernel.org # 6.1.x
>>>
>>> Greg,
>>>
>>> Just want to make sure this one didn't get accidentally skipped since you
>>> populated the stable queues and didn't see it landed.
>>
>> I'm still working on catching up on the stable backlog as I was gone
>> last week, this is in my "to get to soon" queue, it's not lost :)
> 
> Wait, I'm confused.  You have 2 patches in this series, yet one says
> "6.1.x" and one "6.4.x"?  But both actually to both trees.  So where are
> these supposed to be applied to?
> 
> Please always give me a hint, and never mix/match kernel versions in a
> patch series, what would you do if you recieved that?
> 
> thanks,
> 
> greg k-h

Yeah I see the confusion here.  Sorry about that.
I looked over both and they should both apply to 6.1.y and 6.4.y.

Thanks!
