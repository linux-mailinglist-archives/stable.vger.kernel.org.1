Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA54748E27
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjGETo3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGETo1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 15:44:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E79E1980
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 12:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD9nNlH/m16A5QIVr8ruurFpCGuJVZVtvV/5++0GC4NRaK734+WwkbTUgX0emygu8cVfscwK373ZzQhztY3o47/7w3L4ZNGW0nVieZrocgXUF/sbfB9gwUr8EDo0gFHXwdx1WY4F0VdcVFNS4qNHHs1RdUa9vmqB0Kw3pJoPb+e6IdpnxDnhFhOyLXIfshWDgs2xRrIZ6M1XbitbsyFvvif6pYxbc+0krCmTNV4Y2zLe4XtjiWPqz2eoNG4iREoQJnG3v7brAvRJS8hYNbEYifhpLV0KkXgVGxgxxUOcsd3wjvmLYWZFvn84RMvUasZcQ1fXUR3ma1aAfEw1EzW+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RODT1q/59k0XdVIpdCP8ijXc0LwqZuvR7FAT1hCGZXo=;
 b=AJ4Zp7UbbjjwfMZpCKsXyu02zUsjmL7zJ5fkqDkNpapVZ1C+PvtNuej75oPVPxHFmawrmae3t/vPwyfy3SU6WzzXJkFaGqNJBAEXsb7HH4Aakw83xQY61w/m26PmZUJf3VwfKV/MyFg2CxcF352/wz8jqOZn0+hwTE25heMBsAyvMZVWP8anO0HqOIQTw0cwtbFZnuCD8pzeU5yrKUc6NXgHaZ0k/v2Ku52dLP+crhHhb/da+/JPVNOfQaZSpH1yhcpj66Gb5wKx6NzyGzYWjBbaGICWxubLaimxnbCqgx8BDElBXSsRozy/wXytRN0EaoQswfUzye8C/ZBwqDp/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RODT1q/59k0XdVIpdCP8ijXc0LwqZuvR7FAT1hCGZXo=;
 b=LURIj2QUaEM6xQyiDNpVTt5Mxa2TBvTAg3HDfPcMMhE//IzGK7Hk7aYoWrfe/KGHw59cfrL23Ag9zmLWM977AhK9ljlvlbFCYnXeETb8gzfk5yLPKXRi7AoNsBf92wSfcs2c9fdw9+otSe0XFkbSfPGTmy8YziLVkho6IRLHDwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:44:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 19:44:19 +0000
Message-ID: <1c04a328-10e2-606a-c1ab-370d785d3534@amd.com>
Date:   Wed, 5 Jul 2023 14:44:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     stable@vger.kernel.org
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: NULL pointer fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ed3dd2-92d8-4145-c60e-08db7d90391c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBwwdrZqgxsCmaMKWXV4opMYTpBr0fZBXJz0VslmMUG9X9U5YpQFx8MQbS3RESrq+GBrhQUSzc4pByiILE1Cj6eEtYIQAuthzmTZoGAbf6lZFYCRdPNRDKO3bqwpK527QiWTX2Xxef37d9bB/cGhkkRbBMrS2OSRHo3tzh+diTU4rQyJe1A6ZzlYomEQz7JUybkPyjmzmMI591yzKZ2J+yH6LnOjpsVHCci9iu/k0FnmeJQ5Sp/001s1X+G+YE0myVPitWhDyas/ypMeqUF7+7wzWuyBDpiHnTdcY8l8kteY7ZyDKEm6qLo+kdN7pHzwPSa6QZzc/iY1pILC5HDVdfzzHJ6neCyXlM/JgW9I6X1lARrLykAj0XmeyqeGW50sftORTEqN+Tw90uFNGg6eyBR3uhgx4FhtZYjeX6DjF7cN/3G1PnlqOZPQNdzPFTh1+51THv2KVwQKfbevzN7pcBOragWGuwKuDCy2WPEYpq6Wti+mOH+xcl1S8kRRnP1a1OYR5rjBLtwNXJ/0eyQt2zb8rxbvxmnHdtD1ClXHjb0av6qaxMm9yD+hqtyWtH2ZgA+OechytSoPYv064ndY1q00u8yiM0U55Bm+TfHb8xByUC0O9k9xPhCM37XutFWou7ua+5jJrflSGT81fR59Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(66476007)(66556008)(6916009)(66946007)(2616005)(186003)(38100700002)(86362001)(31696002)(6506007)(26005)(83380400001)(6666004)(478600001)(6512007)(6486002)(36756003)(4744005)(7116003)(41300700001)(3480700007)(8936002)(8676002)(31686004)(2906002)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NjSVRWQnk5d2NaTjZTZ3FtY01BSHM1NDBRNEdhU0c3WmlXMTU1OUdYOGZy?=
 =?utf-8?B?VzlQV0lURmpEeWk0Q1lCRG1BNW01S04rRDltYkFPVnBnak9MZmlhR2hUVnRQ?=
 =?utf-8?B?bVQyZEtwN2p1d2t6b01YbE9IdlFRekMvMnhydlpYdnVHTWtnNWZYYldGSHRh?=
 =?utf-8?B?eXQzTXd3eHY3b0NNeWduVDJidno4NVBhdXZqLzhEaHhFWGlCRDMrUm15SndD?=
 =?utf-8?B?Z3lZOEJHNEtuNHR0OHphVkl1RHNXMFY4NmF1bnpiRWorTzJZaEJIcUxrVEVJ?=
 =?utf-8?B?VFQrWTMwVWpWc0R6bWVHS0ora1dISFYwWkJIVk9mR2RiMk5FeFRNR094LzlJ?=
 =?utf-8?B?WlRmalJiTUJFMTdlQk4vM3JzUHYyeXlZbFA0SFNnOFJJNHpaMFUxK0lYd0lN?=
 =?utf-8?B?dUlHL3ZYTVM1RU95TEsrUHZRTDJ5cnhsbEtRZTFSNHVHNnh4YXRYMWJ2bVlI?=
 =?utf-8?B?dy9NT2tUVWxUZTVQeXJHc1gyMlg4cW5TWlRmcnNRWjB5SFhVM2pZSFEwT3dw?=
 =?utf-8?B?enIvUUNuUUlTaVlyQ0tvcVNoekNEWk9YWDc4bVRIMjBGN05WUGppTGlEKzV2?=
 =?utf-8?B?UDNjemlIUWNTOEZZdVp5NVpleEVZdFNuQWJGZU5sSm1Zdm9udWwxQTY4d24y?=
 =?utf-8?B?N0VmME9JanJXL1NGTTV4U0ppbDFlUDcyaTl2NTBvUVVROWhXVGpSZGd6REM5?=
 =?utf-8?B?TSs5NHR4b0RkT3o3N3JjTmU5bU5xRHR6U2dQL1llS3VVSVpVdXlGVWJ5VUYw?=
 =?utf-8?B?V2toMWpzZ3hQTWNoUWtrSFNvTU9GLzVvdzBvamFPVkJCZVFzVTFBTGJWU1Fr?=
 =?utf-8?B?dG8zV1AwUmRSdmM1ZldvSXZ4VVloeEptS0ttTEdDbWdHSWxBL29FaXFnZUlx?=
 =?utf-8?B?b2FNNkxGUHNrdGNlcEI0TWpEK0Y5OFJ6Y2VSTDVUL2RaZWtOam10R1E5WHUr?=
 =?utf-8?B?WGFCS0VTMzJMVDdyUjJTYWpFU0w4V2RYeXg4dmFpdGtCQUpCMVI1RnZKVmgv?=
 =?utf-8?B?d3RDNkRQOTdIakdBUEVGelA2dXBVT294djJrM2REcmhBdEtyK1VMYklpY2Zy?=
 =?utf-8?B?NzhvSkJiNG50cjFyTkprL3F4WTc1UFJEbURFZUlNMjVHZFRSc1piUXRtQWRy?=
 =?utf-8?B?eXB1RCtMa2FQOVNLTWFZN3lnUFJFV3lYVis4WUpjODFoWmtoSHRzVGdJMVNI?=
 =?utf-8?B?UjUwdjROdHhRc1k4ZFpLWHg3RkRuYndyMTErWm8ySHVnSjlTSUdsTmltOTNx?=
 =?utf-8?B?bmJad05CQ3JTZGVueWpLVXkyTXUxODJSeUJ5Zk1HSE02ekVWK3hrM1NCV2ZZ?=
 =?utf-8?B?U1VqS1Y1U2RCOWJ0ek16cG00S2RpSUl3VWNoWDA4VncrMmVkd0pEZUNlSUMr?=
 =?utf-8?B?bXpGTC92Ui82dlZ1ekVKVmZhYSsrNFJRUU1ycWZzeGNKYmNvaW9Hei9BUS92?=
 =?utf-8?B?UWc0NEFySjZnWGtvemIzRVprN1dETy8wRXpJNXlUcTgvSm1VUVZMSm5nQ2dV?=
 =?utf-8?B?cTVodWowWXRGRmJScWJpMW41OUVVYm9DV2k2QVFOZGRjamlXSGNpd3hUSjB2?=
 =?utf-8?B?eHNHaTZ4RFgzUjUrYWZXaW10K1dFVWwyL3pkYzdiTENxWW1ZYThpVmw2Mitu?=
 =?utf-8?B?cGJSZUdqN0xLcG5JSDM3S1BGSVBYRWJDUGFYV1F3RVBXVm4vbVpkU2QrY243?=
 =?utf-8?B?Nktvd0t6M3FsRlFuZW44NmtoczdLQWFCQVptdmowMGhXWUlNeUpCVzgzRk8y?=
 =?utf-8?B?R1ZjRVBtaWtGM01EMGFPY0pXdi9yMEJ3VXY0ODN5d2tIQkNsUG9pWkdrM3Jq?=
 =?utf-8?B?eHE2c0xwREp4NHFib0NrdllaUG01djVJRjFaMVY5c2pqcENvOUdobzYwbG12?=
 =?utf-8?B?QkVIanRab0Z3ZzUzRUg1NU5KRkhQdHlNbWdJRndWd2Y5MlFlTTUyMHFwMWF5?=
 =?utf-8?B?UjBjbUdwWFJ0TmxOL2puU25YajV1NXljWnFBSHpua29kaUFIV3ZzZ0REUkpM?=
 =?utf-8?B?ZXgrenBXbTg5QnRjTTZUT0xsQTJkRWlNei8yTTJ4RmN1dFlVSjg1SDJZeHJo?=
 =?utf-8?B?OGwxMUlYcVMxN3FHUUhKOUxqWUNpUURpbFUyeWxJSlpmeElONUJHV3ZvVmtV?=
 =?utf-8?Q?NIeZEqMQvWKidkTpi7SRg6nnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed3dd2-92d8-4145-c60e-08db7d90391c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:44:19.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayBKcFiemnOaplh4MOp7fhVvUsyzBHJS3JsEPzcRogEhhkc/cRkCqOq0CSYvMrSN6EhsWVrGgsQJpbSQp+m5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
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

The following commit landed in 6.4 that helps some occasional NULL 
pointer dereferences when setting up MST devices, particularly on 
suspend/resume cycles.

54d217406afe ("drm: use mgr->dev in drm_dbg_kms in 
drm_dp_add_payload_part2")

Can you please take this to 6.1.y and 6.3.y as well?  The NULL pointer 
de-reference has been reported on both.

Thanks,

