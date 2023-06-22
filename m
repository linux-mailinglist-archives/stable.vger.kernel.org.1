Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A48739DCD
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFVJyN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFVJxx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:53:53 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5243A8D
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:49:10 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6cmlL014888;
        Thu, 22 Jun 2023 02:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=content-type:message-id:date:subject:to:cc:references:from
        :in-reply-to:mime-version; s=PPS06212021; bh=yYw1ygEgQiXfGYOgl7y
        HA2SdfLGaIrr1XrtqNXpeDhg=; b=W8W472Aa5BNLD8Lq459QMuSFAxID8uzuNgP
        CcY4uz3vCwKFFrKZvbE04zf2GoSW5Ffnk1HUIyftR2V8FWi8trUo//VD563ITHaM
        VyTYNu1yFx2V9DMOKYRcHq10zfnRLyTvKUyn7LYGk+16Vhny6WPFki4wVgZFs6sv
        bZwQwwSj8hCrNxYFRPP1fPjmHD1Twur2woFKbmRFV+BZDctf/ltBST9cCXa9eQ1+
        YcFMuEwn48C84F9o6Js5w80qzk54+spE7MGJ9QqYOwrG5c9mIESmptWGj18lTA/w
        uLMehMsNvcTp0G0IaiBGMgYCoTyc1UvQDLo3+f4WmV3HgVlQkvA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rcdctg8qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 02:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYwtTNU6zfvw3779VgOkPQNZnCAvXnDlAUYaqXjT/e2+zJJgybxJzI6LrKbhlU7xuYDMl7BlGs/HqUiUD4y0tFapUTydla6TKXMVDvgLkevtYNAdNLvbxObF0y9NBWXMgA2kDgnJvzWz7O6CURGRqUu+PD662RcxlIXSoTvO7ynsnmZNW2b+FgnKA+lUFRpfD6eI3t3Wrt/IH1f+C46Znrkkiuo+TwR+fmzjl9svTPxC3Ey+tj982JuT7ku65MI2sQPaxYfrR4vNIaIY/TiKXDqsA9AEF4s+9jwFEZbUSUnhTx2AHRuV03LN/epq6XLabhH7QFd+Vle5Q98t5wrgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYw1ygEgQiXfGYOgl7yHA2SdfLGaIrr1XrtqNXpeDhg=;
 b=OwWMSV74qXkx21TzqFEKoGM0rZSJg0Y75amjMQjaIpD6mRFV8rdtmgICiX4CLR4D3ogpHiHml9nusfHgMGYpIGFEPXgNTaSdDd5YySfD4gsim0wpwU+VmXbRha9Zd6gLaOSuGIFzd6pultbp8hZthQE+QAIHZ1r+RZ+yCNR/r5oXc1ap2AzgoGqPVaaurlNoDaPjKwSSHo4EaXsWkmmDZDKTCCXbPL9t8kDgi0+7j9gY3R4nJWlCJcJwKnqo+Ywd9/jxRBbwoZBDfywDE9RgdkpuGaDK1t/RA+ODLjjcnS5uL9bzkExbBIXTAYZvVZlNSo+7uTe/qqB+v7GwC9KguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 09:49:02 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 09:49:02 +0000
Content-Type: multipart/mixed; boundary="------------7gb0chAZrL1MzUUE5KcN7mwh"
Message-ID: <29bb8de3-c157-e99e-5259-ec0d1f71bd08@windriver.com>
Date:   Thu, 22 Jun 2023 12:48:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 2/3] media: dvbdev: fix error logic at
 dvb_register_device()
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
 <20230622085645.1298223-2-ovidiu.panait@windriver.com>
 <2023062222-kindred-football-53e1@gregkh>
From:   Ovidiu Panait <ovidiu.panait@windriver.com>
In-Reply-To: <2023062222-kindred-football-53e1@gregkh>
X-ClientProxiedBy: VI1PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::14) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 868a7b79-a2eb-49b3-8b44-08db7305e8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +e9yxHGXtmCiud//8oRqRelzwq7WYInsgXm8mlIb99+3vmPoFUQ4/YEJmqdBYJK7nfILKm2+N77fVTL1C20XgHBI91CIvGBRo8HyCYQ//xSTAHJNwfKygZ9A1jgxELR00DJhDnL5wxzuQFINHrzJF8M+n3XRWRH5wIQhNkskz/pvqaLbWO0g0rkj/XI/pt5I2veqGWC7Ag48+92qwawleGFNg0126S9FcM4LkRRkxgVCl67JpfanWDABOPnj1ITLRfQSlRLTl+FOqob1YPW8X8HcGmo+wX6h8P734xQlaNN9xNNMDTkcbUdKNTgQaIpHP8Dt1S5ZMKbX0/Sp4OAzkFQNmFD6jNrAxG9ftuN5Sd6nmetBqt/38Mdnua2toARjIpp/HkIw6qcUpoI8Ksl7ACn9wzzz+C6+LP9kawmzRn3G4T43BdUl6ucO3VERDghqocXPt0xe3FCmUvgPUrsCWe0hVOJZTVXEQILhWXOQK4BCHf/ax+9iYhUXM/zSQFnT7gNyPtfcNs5emVlgtlDBhsvk8CJO9iX9CwnHLzl0JCluYomGkIqKSbZ7PSgbri3A3mHBzccYYK1o8CSbkzbe0UVzH+cGuhP4dQIwboX93J7rx1i0JTKWUP4nVU4242HeRV3aquI9uV3wTLc5sG9x1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(346002)(396003)(366004)(376002)(451199021)(2616005)(86362001)(31696002)(478600001)(6666004)(33964004)(186003)(6486002)(4326008)(41300700001)(316002)(53546011)(31686004)(6916009)(66476007)(83380400001)(6512007)(6506007)(66946007)(66556008)(235185007)(8936002)(8676002)(5660300002)(36756003)(44832011)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1J2blZFZjRTb21UVjFNSVFpN0RyV3UvVVVNUy9LdDRkWUhMWkZsS3JMUDVX?=
 =?utf-8?B?bExiTW0yc0RId2h4LytsRGxVdWd4YmNYV3ZjSXh6dVdkSnBwREd0b0QvNWdL?=
 =?utf-8?B?NmZIU3pzSkdBb3cxTlFrOUJwZlg0QlhrRjFuTVMxQUtXdHRHT1UyOHFFSDlB?=
 =?utf-8?B?OVQvWGRidkdGcko3bG5RcU9COU5kWmZLdEhGNU5PaThoaVp3Nk1PTlNBWEZF?=
 =?utf-8?B?U0U0TkNUZCtSMDBIcDdvSXZmZngvcjVsWHcrNmFsYVNIOUg2N2RDZkM4VVJY?=
 =?utf-8?B?REpLM2VHdmR5SXdxdzRNSXR2TzJ5NjJVVEloTUpuWDA2NWpQZnVzVGh6UC9w?=
 =?utf-8?B?eU9TdUxPVllUaG9GOGRUMjd2c0NPL0tBbVMyYk5WVXp4NmRPSWQ1MkkxOXZK?=
 =?utf-8?B?cW9hWWNvL0hHNHRaQkNFanl4YlptbUxVd2RDVkNuVHZOeUJoSU5YWmJHaldX?=
 =?utf-8?B?aW9rb2hEQ2Y5NVR5N29rK2svM3krT0ZNUEM4MDZ2TUZmOVBGYnNXV3J1Y3dr?=
 =?utf-8?B?b3JwT0ROaU96V3RCNVpmYTlyVFdCTmJHM2x0ZlAyOGYxNWVIYnM1aUdHQWpQ?=
 =?utf-8?B?RVZXQXRNZmltV1ZWVlFYTS9TblZnRkJFaHFuLzcyY2NGMDNGQTVIVUhqY2o1?=
 =?utf-8?B?eUE4NERqbXRFK1JVNG53bTZJcnl3VGl3U0cySWxVbzhsa2NSQjVlOThEb2Rq?=
 =?utf-8?B?enlJVXAvYnE1V2tad1FqSDRhQy9SRGwrWDdRM2wvZ2V1THE5Z05yZ01XMGVx?=
 =?utf-8?B?RXhZTDVBdzJLVHF4SUpqVi9QZ1VMSmx6M0ZDc3ZsN3Z2c1VHUi9hUnNvemVX?=
 =?utf-8?B?aFRwcHhta2lqaXcrRWZ6NjFpZ3J1Z3RLdmd3VjNvKzk2VTNuUXNCNjZjTzc2?=
 =?utf-8?B?ZDI3alRuZlJpdDlPTCtoSG1qRFdtYnVVb3pmTHBJaFR2U1lvNmlxUmpBcFZi?=
 =?utf-8?B?bUtpM3IwbUQvYk9wWnRGbWVFZmFBcUtzalFVdEg1Vi9LTWhZeC9sMWZtZjlI?=
 =?utf-8?B?KzhOZVQ0b1piYis2cWtZWHNtYVFzUUd5blgvSzZpNzR2R3dDOXdBOElxb1Rp?=
 =?utf-8?B?SXpGd1dPRFFURDVGMVBFeGREYVc5ak9lUlFCWE50d1A0anAzYXpUWkhsRTBV?=
 =?utf-8?B?Q0svbW5lM0VTQ1FUL2hOVjlSRkp3U3BqYXpadFFZaDJjQjZDWlZ6TVdUVHVr?=
 =?utf-8?B?QXBVQlJDRldFallFTVpLRXd1bnR5RzdlOUtFM2QwYjA3VDRJNEkxb2lkTXEz?=
 =?utf-8?B?MGpKU3AwVS9JUGlWbExneXk1ZzRDaXNBemVrQ3JhY1ZKckVwYTV1QnkrcmpF?=
 =?utf-8?B?VzR0cVRvSU5HV2drWWY1YUo3SmFqZ3dKQ05NNEFlclk5SHhzdkE3bEJXWk0x?=
 =?utf-8?B?VWduWlVudWRLZXZiazdpU1RjSTNZUkczTHdCODRacDZZc0N4MmZUSnpUdTFz?=
 =?utf-8?B?cXVzZzhvZkVPMVg0Wng3Y3lNL25BZEVhZlVsUmtlbmFPbkZiUTEyZUx2T3ZB?=
 =?utf-8?B?QlQxenUzSndhWUVSdmF6dithWU9SNjJOb0dmN3hXQVJqa0RRcitUcFY3RXdu?=
 =?utf-8?B?ZGdBSEp2cDBlUkxndmhCeVhlZ2Jrck1Jd3BuN2N3ZzdsM2xOeUxPaThTbzhF?=
 =?utf-8?B?VjBaWmtxZ1hIQW9RYXljWTVCVElKY1dWZllNSFNlUmhxRUNVZ0FDSThUeUd3?=
 =?utf-8?B?d0VoK2pOVWFsaFZIR3N4L1FnQXdiNnhPckloa2c2ZTFqSzNQajhXVEpjQS9k?=
 =?utf-8?B?UHhXRlpvUDNBQTltaFhZd2xpc3BYVEUvNDVVVExiamtXQThnamJ0cSs1ZFQ3?=
 =?utf-8?B?VzJwUVg1L2NCUERTVTJJMm1Od2RXQjArN2lueUtPanVLZE03OEFwRkUzZ3dj?=
 =?utf-8?B?OEpRaTFTRUx2TE13U0lFOUhRSHFrQXE1WkNDYUJQcmNpU0J1UEt0UDFkRDhZ?=
 =?utf-8?B?bndZK0JBYVpBK0gyZURqY3RqUWR5OU1sODJLQ1JkNzdhUVUrMzBmazdEUUdT?=
 =?utf-8?B?ZHlGMUNIUHMwbkhhdnl2Mmc0R2ZVY1JBK05BZTU1TDVjeHVJcElHcENzbVNi?=
 =?utf-8?B?dS95UU9XcmVVRyt3UHppa1lERjZHTzdFVTVvcUpha2hZNUJhWkJmeGlMa0VM?=
 =?utf-8?B?V002M2QyQkczMGh2SHE5UTdlaHFVRm80ellQcDFCZmNUSzB2V21OV2tMZk5q?=
 =?utf-8?B?ekVYNWpXT0JaZ3FKd1ZnZ3ByOGt2bGk3cjJwY05OTnhUTm9hZVJ3NkdPZHJM?=
 =?utf-8?B?ODI4aGY4ajBsVG1Pc3dFeFZqZXlBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868a7b79-a2eb-49b3-8b44-08db7305e8bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 09:49:02.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAxKOJiulSh3ro7zgvFVf4F3zj9r/dd0tv1UwoIJtnTizN7mKRmRkWUYBJEtWZ7DJb7oN7yBx1bx2QxLlKFqKt3C32AjpVaNqKNQmc9Qel0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-Proofpoint-ORIG-GUID: xlVZAc_ZHVIGMXO-Pl9pe_SaqTVmyDcF
X-Proofpoint-GUID: xlVZAc_ZHVIGMXO-Pl9pe_SaqTVmyDcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_06,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2305260000
 definitions=main-2306220081
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--------------7gb0chAZrL1MzUUE5KcN7mwh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/22/23 12:29, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Jun 22, 2023 at 11:56:44AM +0300, ovidiu.panait@windriver.com wrote:
>> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>
>> commit 1fec2ecc252301110e4149e6183fa70460d29674 upstream.
>>
>> As reported by smatch:
>>
>>        drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:510 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
>>        drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:530 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
>>        drivers/media/dvb-core/dvbdev.c: drivers/media/dvb-core/dvbdev.c:545 dvb_register_device() warn: '&dvbdev->list_head' not removed from list
>>
>> The error logic inside dvb_register_device() doesn't remove
>> devices from the dvb_adapter_list in case of errors.
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
>> ---
>>   drivers/media/dvb-core/dvbdev.c | 3 +++
>>   1 file changed, 3 insertions(+)
> Only 2 of 3 patches ever showed up, is there a 3/3?

I attached the third patch. Not sure why it didn't make it to the list.


Ovidiu

> thanks,
>
> greg k-h
--------------7gb0chAZrL1MzUUE5KcN7mwh
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-media-dvb-core-Fix-use-after-free-due-to-race-at-dvb.patch"
Content-Disposition: attachment;
 filename*0="0003-media-dvb-core-Fix-use-after-free-due-to-race-at-dvb.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmNzEzNDlkN2Q1NmEyMTljMjg4MjI3ZDA5ZjI0M2Y2YmU2OGNkYzhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIeXVud29vIEtpbSA8aW12NGJlbEBnbWFpbC5jb20+CkRhdGU6
IFRodSwgMTcgTm92IDIwMjIgMDQ6NTk6MjQgKzAwMDAKU3ViamVjdDogW1BBVENIIDUuNCAzLzNd
IG1lZGlhOiBkdmItY29yZTogRml4IHVzZS1hZnRlci1mcmVlIGR1ZSB0byByYWNlIGF0CiBkdmJf
cmVnaXN0ZXJfZGV2aWNlKCkKCmNvbW1pdCA2MjdiYjUyOGIwODZiNDEzNjMxNWMyNWQ2YTQ0N2E5
OGVhOTQ0OGQzIHVwc3RyZWFtLgoKZHZiX3JlZ2lzdGVyX2RldmljZSgpIGR5bmFtaWNhbGx5IGFs
bG9jYXRlcyBmb3BzIHdpdGgga21lbWR1cCgpCnRvIHNldCB0aGUgZm9wcy0+b3duZXIuCkFuZCB0
aGVzZSBmb3BzIGFyZSByZWdpc3RlcmVkIGluICdmaWxlLT5mX29wcycgdXNpbmcgcmVwbGFjZV9m
b3BzKCkKaW4gdGhlIGR2Yl9kZXZpY2Vfb3BlbigpIHByb2Nlc3MsIGFuZCBrZnJlZSgpZCBpbiBk
dmJfZnJlZV9kZXZpY2UoKS4KCkhvd2V2ZXIsIGl0IGlzIG5vdCBjb21tb24gdG8gdXNlIGR5bmFt
aWNhbGx5IGFsbG9jYXRlZCBmb3BzIGluc3RlYWQKb2YgJ3N0YXRpYyBjb25zdCcgZm9wcyBhcyBh
biBhcmd1bWVudCBvZiByZXBsYWNlX2ZvcHMoKSwKYW5kIFVBRiBtYXkgb2NjdXIuClRoZXNlIFVB
RnMgY2FuIG9jY3VyIG9uIGFueSBkdmIgdHlwZSB1c2luZyBkdmJfcmVnaXN0ZXJfZGV2aWNlKCks
CnN1Y2ggYXMgZHZiX2R2ciwgZHZiX2RlbXV4LCBkdmJfZnJvbnRlbmQsIGR2Yl9uZXQsIGV0Yy4K
ClNvLCBpbnN0ZWFkIG9mIGtmcmVlKCkgdGhlIGZvcHMgZHluYW1pY2FsbHkgYWxsb2NhdGVkIGlu
CmR2Yl9yZWdpc3Rlcl9kZXZpY2UoKSBpbiBkdmJfZnJlZV9kZXZpY2UoKSBjYWxsZWQgZHVyaW5n
IHRoZQouZGlzY29ubmVjdCgpIHByb2Nlc3MsIGtmcmVlKCkgaXQgY29sbGVjdGl2ZWx5IGluIGV4
aXRfZHZiZGV2KCkKY2FsbGVkIHdoZW4gdGhlIGR2YmRldi5jIG1vZHVsZSBpcyByZW1vdmVkLgoK
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWEvMjAyMjExMTcwNDU5MjUu
MTQyOTctNC1pbXY0YmVsQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBIeXVud29vIEtpbSA8aW12
NGJlbEBnbWFpbC5jb20+ClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4KUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz4KU2ln
bmVkLW9mZi1ieTogT3ZpZGl1IFBhbmFpdCA8b3ZpZGl1LnBhbmFpdEB3aW5kcml2ZXIuY29tPgot
LS0KIGRyaXZlcnMvbWVkaWEvZHZiLWNvcmUvZHZiZGV2LmMgfCA4NCArKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0KIGluY2x1ZGUvbWVkaWEvZHZiZGV2LmggICAgICAgICAgfCAxNSAr
KysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9kdmItY29yZS9kdmJkZXYuYyBiL2RyaXZlcnMv
bWVkaWEvZHZiLWNvcmUvZHZiZGV2LmMKaW5kZXggZThiMGNjNjJjMjZlLi4zMWIyOTljZWQzYzEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEvZHZiLWNvcmUvZHZiZGV2LmMKKysrIGIvZHJpdmVy
cy9tZWRpYS9kdmItY29yZS9kdmJkZXYuYwpAQCAtMzcsNiArMzcsNyBAQAogI2luY2x1ZGUgPG1l
ZGlhL3R1bmVyLmg+CiAKIHN0YXRpYyBERUZJTkVfTVVURVgoZHZiZGV2X211dGV4KTsKK3N0YXRp
YyBMSVNUX0hFQUQoZHZiZGV2Zm9wc19saXN0KTsKIHN0YXRpYyBpbnQgZHZiZGV2X2RlYnVnOwog
CiBtb2R1bGVfcGFyYW0oZHZiZGV2X2RlYnVnLCBpbnQsIDA2NDQpOwpAQCAtNDYyLDE0ICs0NjMs
MTUgQEAgaW50IGR2Yl9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IGR2Yl9hZGFwdGVyICphZGFwLCBz
dHJ1Y3QgZHZiX2RldmljZSAqKnBkdmJkZXYsCiAJCQllbnVtIGR2Yl9kZXZpY2VfdHlwZSB0eXBl
LCBpbnQgZGVtdXhfc2lua19wYWRzKQogewogCXN0cnVjdCBkdmJfZGV2aWNlICpkdmJkZXY7Ci0J
c3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqZHZiZGV2Zm9wczsKKwlzdHJ1Y3QgZmlsZV9vcGVyYXRp
b25zICpkdmJkZXZmb3BzID0gTlVMTDsKKwlzdHJ1Y3QgZHZiZGV2Zm9wc19ub2RlICpub2RlID0g
TlVMTCwgKm5ld19ub2RlID0gTlVMTDsKIAlzdHJ1Y3QgZGV2aWNlICpjbHNkZXY7CiAJaW50IG1p
bm9yOwogCWludCBpZCwgcmV0OwogCiAJbXV0ZXhfbG9jaygmZHZiZGV2X3JlZ2lzdGVyX2xvY2sp
OwogCi0JaWYgKChpZCA9IGR2YmRldl9nZXRfZnJlZV9pZCAoYWRhcCwgdHlwZSkpIDwgMCl7CisJ
aWYgKChpZCA9IGR2YmRldl9nZXRfZnJlZV9pZCAoYWRhcCwgdHlwZSkpIDwgMCkgewogCQltdXRl
eF91bmxvY2soJmR2YmRldl9yZWdpc3Rlcl9sb2NrKTsKIAkJKnBkdmJkZXYgPSBOVUxMOwogCQlw
cl9lcnIoIiVzOiBjb3VsZG4ndCBmaW5kIGZyZWUgZGV2aWNlIGlkXG4iLCBfX2Z1bmNfXyk7CkBA
IC00NzcsMTggKzQ3OSw0NSBAQCBpbnQgZHZiX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgZHZiX2Fk
YXB0ZXIgKmFkYXAsIHN0cnVjdCBkdmJfZGV2aWNlICoqcGR2YmRldiwKIAl9CiAKIAkqcGR2YmRl
diA9IGR2YmRldiA9IGt6YWxsb2Moc2l6ZW9mKCpkdmJkZXYpLCBHRlBfS0VSTkVMKTsKLQogCWlm
ICghZHZiZGV2KXsKIAkJbXV0ZXhfdW5sb2NrKCZkdmJkZXZfcmVnaXN0ZXJfbG9jayk7CiAJCXJl
dHVybiAtRU5PTUVNOwogCX0KIAotCWR2YmRldmZvcHMgPSBrbWVtZHVwKHRlbXBsYXRlLT5mb3Bz
LCBzaXplb2YoKmR2YmRldmZvcHMpLCBHRlBfS0VSTkVMKTsKKwkvKgorCSAqIFdoZW4gYSBkZXZp
Y2Ugb2YgdGhlIHNhbWUgdHlwZSBpcyBwcm9iZSgpZCBtb3JlIHRoYW4gb25jZSwKKwkgKiB0aGUg
Zmlyc3QgYWxsb2NhdGVkIGZvcHMgYXJlIHVzZWQuIFRoaXMgcHJldmVudHMgbWVtb3J5IGxlYWtz
CisJICogdGhhdCBjYW4gb2NjdXIgd2hlbiB0aGUgc2FtZSBkZXZpY2UgaXMgcHJvYmUoKWQgcmVw
ZWF0ZWRseS4KKwkgKi8KKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KG5vZGUsICZkdmJkZXZmb3BzX2xp
c3QsIGxpc3RfaGVhZCkgeworCQlpZiAobm9kZS0+Zm9wcy0+b3duZXIgPT0gYWRhcC0+bW9kdWxl
ICYmCisJCQkJbm9kZS0+dHlwZSA9PSB0eXBlICYmCisJCQkJbm9kZS0+dGVtcGxhdGUgPT0gdGVt
cGxhdGUpIHsKKwkJCWR2YmRldmZvcHMgPSBub2RlLT5mb3BzOworCQkJYnJlYWs7CisJCX0KKwl9
CiAKLQlpZiAoIWR2YmRldmZvcHMpewotCQlrZnJlZSAoZHZiZGV2KTsKLQkJbXV0ZXhfdW5sb2Nr
KCZkdmJkZXZfcmVnaXN0ZXJfbG9jayk7Ci0JCXJldHVybiAtRU5PTUVNOworCWlmIChkdmJkZXZm
b3BzID09IE5VTEwpIHsKKwkJZHZiZGV2Zm9wcyA9IGttZW1kdXAodGVtcGxhdGUtPmZvcHMsIHNp
emVvZigqZHZiZGV2Zm9wcyksIEdGUF9LRVJORUwpOworCQlpZiAoIWR2YmRldmZvcHMpIHsKKwkJ
CWtmcmVlKGR2YmRldik7CisJCQltdXRleF91bmxvY2soJmR2YmRldl9yZWdpc3Rlcl9sb2NrKTsK
KwkJCXJldHVybiAtRU5PTUVNOworCQl9CisKKwkJbmV3X25vZGUgPSBremFsbG9jKHNpemVvZihz
dHJ1Y3QgZHZiZGV2Zm9wc19ub2RlKSwgR0ZQX0tFUk5FTCk7CisJCWlmICghbmV3X25vZGUpIHsK
KwkJCWtmcmVlKGR2YmRldmZvcHMpOworCQkJa2ZyZWUoZHZiZGV2KTsKKwkJCW11dGV4X3VubG9j
aygmZHZiZGV2X3JlZ2lzdGVyX2xvY2spOworCQkJcmV0dXJuIC1FTk9NRU07CisJCX0KKworCQlu
ZXdfbm9kZS0+Zm9wcyA9IGR2YmRldmZvcHM7CisJCW5ld19ub2RlLT50eXBlID0gdHlwZTsKKwkJ
bmV3X25vZGUtPnRlbXBsYXRlID0gdGVtcGxhdGU7CisJCWxpc3RfYWRkX3RhaWwgKCZuZXdfbm9k
ZS0+bGlzdF9oZWFkLCAmZHZiZGV2Zm9wc19saXN0KTsKIAl9CiAKIAltZW1jcHkoZHZiZGV2LCB0
ZW1wbGF0ZSwgc2l6ZW9mKHN0cnVjdCBkdmJfZGV2aWNlKSk7CkBAIC00OTksMjAgKzUyOCwyMCBA
QCBpbnQgZHZiX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgZHZiX2FkYXB0ZXIgKmFkYXAsIHN0cnVj
dCBkdmJfZGV2aWNlICoqcGR2YmRldiwKIAlkdmJkZXYtPnByaXYgPSBwcml2OwogCWR2YmRldi0+
Zm9wcyA9IGR2YmRldmZvcHM7CiAJaW5pdF93YWl0cXVldWVfaGVhZCAoJmR2YmRldi0+d2FpdF9x
dWV1ZSk7Ci0KIAlkdmJkZXZmb3BzLT5vd25lciA9IGFkYXAtPm1vZHVsZTsKLQogCWxpc3RfYWRk
X3RhaWwgKCZkdmJkZXYtPmxpc3RfaGVhZCwgJmFkYXAtPmRldmljZV9saXN0KTsKLQogCWRvd25f
d3JpdGUoJm1pbm9yX3J3c2VtKTsKICNpZmRlZiBDT05GSUdfRFZCX0RZTkFNSUNfTUlOT1JTCiAJ
Zm9yIChtaW5vciA9IDA7IG1pbm9yIDwgTUFYX0RWQl9NSU5PUlM7IG1pbm9yKyspCiAJCWlmIChk
dmJfbWlub3JzW21pbm9yXSA9PSBOVUxMKQogCQkJYnJlYWs7Ci0KIAlpZiAobWlub3IgPT0gTUFY
X0RWQl9NSU5PUlMpIHsKKwkJaWYgKG5ld19ub2RlKSB7CisJCQlsaXN0X2RlbCAoJm5ld19ub2Rl
LT5saXN0X2hlYWQpOworCQkJa2ZyZWUoZHZiZGV2Zm9wcyk7CisJCQlrZnJlZShuZXdfbm9kZSk7
CisJCX0KIAkJbGlzdF9kZWwgKCZkdmJkZXYtPmxpc3RfaGVhZCk7Ci0JCWtmcmVlKGR2YmRldmZv
cHMpOwogCQlrZnJlZShkdmJkZXYpOwogCQl1cF93cml0ZSgmbWlub3JfcndzZW0pOwogCQltdXRl
eF91bmxvY2soJmR2YmRldl9yZWdpc3Rlcl9sb2NrKTsKQEAgLTUyMSw0MSArNTUwLDQ3IEBAIGlu
dCBkdmJfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBkdmJfYWRhcHRlciAqYWRhcCwgc3RydWN0IGR2
Yl9kZXZpY2UgKipwZHZiZGV2LAogI2Vsc2UKIAltaW5vciA9IG51bXMybWlub3IoYWRhcC0+bnVt
LCB0eXBlLCBpZCk7CiAjZW5kaWYKLQogCWR2YmRldi0+bWlub3IgPSBtaW5vcjsKIAlkdmJfbWlu
b3JzW21pbm9yXSA9IGR2Yl9kZXZpY2VfZ2V0KGR2YmRldik7CiAJdXBfd3JpdGUoJm1pbm9yX3J3
c2VtKTsKLQogCXJldCA9IGR2Yl9yZWdpc3Rlcl9tZWRpYV9kZXZpY2UoZHZiZGV2LCB0eXBlLCBt
aW5vciwgZGVtdXhfc2lua19wYWRzKTsKIAlpZiAocmV0KSB7CiAJCXByX2VycigiJXM6IGR2Yl9y
ZWdpc3Rlcl9tZWRpYV9kZXZpY2UgZmFpbGVkIHRvIGNyZWF0ZSB0aGUgbWVkaWFncmFwaFxuIiwK
IAkJICAgICAgX19mdW5jX18pOwotCisJCWlmIChuZXdfbm9kZSkgeworCQkJbGlzdF9kZWwgKCZu
ZXdfbm9kZS0+bGlzdF9oZWFkKTsKKwkJCWtmcmVlKGR2YmRldmZvcHMpOworCQkJa2ZyZWUobmV3
X25vZGUpOworCQl9CiAJCWR2Yl9tZWRpYV9kZXZpY2VfZnJlZShkdmJkZXYpOwogCQlsaXN0X2Rl
bCAoJmR2YmRldi0+bGlzdF9oZWFkKTsKLQkJa2ZyZWUoZHZiZGV2Zm9wcyk7CiAJCWtmcmVlKGR2
YmRldik7CiAJCW11dGV4X3VubG9jaygmZHZiZGV2X3JlZ2lzdGVyX2xvY2spOwogCQlyZXR1cm4g
cmV0OwogCX0KIAotCW11dGV4X3VubG9jaygmZHZiZGV2X3JlZ2lzdGVyX2xvY2spOwotCiAJY2xz
ZGV2ID0gZGV2aWNlX2NyZWF0ZShkdmJfY2xhc3MsIGFkYXAtPmRldmljZSwKIAkJCSAgICAgICBN
S0RFVihEVkJfTUFKT1IsIG1pbm9yKSwKIAkJCSAgICAgICBkdmJkZXYsICJkdmIlZC4lcyVkIiwg
YWRhcC0+bnVtLCBkbmFtZXNbdHlwZV0sIGlkKTsKIAlpZiAoSVNfRVJSKGNsc2RldikpIHsKIAkJ
cHJfZXJyKCIlczogZmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgZHZiJWQuJXMlZCAoJWxkKVxuIiwK
IAkJICAgICAgIF9fZnVuY19fLCBhZGFwLT5udW0sIGRuYW1lc1t0eXBlXSwgaWQsIFBUUl9FUlIo
Y2xzZGV2KSk7CisJCWlmIChuZXdfbm9kZSkgeworCQkJbGlzdF9kZWwgKCZuZXdfbm9kZS0+bGlz
dF9oZWFkKTsKKwkJCWtmcmVlKGR2YmRldmZvcHMpOworCQkJa2ZyZWUobmV3X25vZGUpOworCQl9
CiAJCWR2Yl9tZWRpYV9kZXZpY2VfZnJlZShkdmJkZXYpOwogCQlsaXN0X2RlbCAoJmR2YmRldi0+
bGlzdF9oZWFkKTsKLQkJa2ZyZWUoZHZiZGV2Zm9wcyk7CiAJCWtmcmVlKGR2YmRldik7CisJCW11
dGV4X3VubG9jaygmZHZiZGV2X3JlZ2lzdGVyX2xvY2spOwogCQlyZXR1cm4gUFRSX0VSUihjbHNk
ZXYpOwogCX0KKwogCWRwcmludGsoIkRWQjogcmVnaXN0ZXIgYWRhcHRlciVkLyVzJWQgQCBtaW5v
cjogJWkgKDB4JTAyeClcbiIsCiAJCWFkYXAtPm51bSwgZG5hbWVzW3R5cGVdLCBpZCwgbWlub3Is
IG1pbm9yKTsKIAorCW11dGV4X3VubG9jaygmZHZiZGV2X3JlZ2lzdGVyX2xvY2spOwogCXJldHVy
biAwOwogfQogRVhQT1JUX1NZTUJPTChkdmJfcmVnaXN0ZXJfZGV2aWNlKTsKQEAgLTU4NCw3ICs2
MTksNiBAQCBzdGF0aWMgdm9pZCBkdmJfZnJlZV9kZXZpY2Uoc3RydWN0IGtyZWYgKnJlZikKIHsK
IAlzdHJ1Y3QgZHZiX2RldmljZSAqZHZiZGV2ID0gY29udGFpbmVyX29mKHJlZiwgc3RydWN0IGR2
Yl9kZXZpY2UsIHJlZik7CiAKLQlrZnJlZSAoZHZiZGV2LT5mb3BzKTsKIAlrZnJlZSAoZHZiZGV2
KTsKIH0KIApAQCAtMTA5MCw5ICsxMTI0LDE3IEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfZHZi
ZGV2KHZvaWQpCiAKIHN0YXRpYyB2b2lkIF9fZXhpdCBleGl0X2R2YmRldih2b2lkKQogeworCXN0
cnVjdCBkdmJkZXZmb3BzX25vZGUgKm5vZGUsICpuZXh0OworCiAJY2xhc3NfZGVzdHJveShkdmJf
Y2xhc3MpOwogCWNkZXZfZGVsKCZkdmJfZGV2aWNlX2NkZXYpOwogCXVucmVnaXN0ZXJfY2hyZGV2
X3JlZ2lvbihNS0RFVihEVkJfTUFKT1IsIDApLCBNQVhfRFZCX01JTk9SUyk7CisKKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUobm9kZSwgbmV4dCwgJmR2YmRldmZvcHNfbGlzdCwgbGlzdF9oZWFk
KSB7CisJCWxpc3RfZGVsICgmbm9kZS0+bGlzdF9oZWFkKTsKKwkJa2ZyZWUobm9kZS0+Zm9wcyk7
CisJCWtmcmVlKG5vZGUpOworCX0KIH0KIAogc3Vic3lzX2luaXRjYWxsKGluaXRfZHZiZGV2KTsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWVkaWEvZHZiZGV2LmggYi9pbmNsdWRlL21lZGlhL2R2YmRl
di5oCmluZGV4IDczYzFkZjU4NGExNC4uMzc0NWExM2Y2ZTA4IDEwMDY0NAotLS0gYS9pbmNsdWRl
L21lZGlhL2R2YmRldi5oCisrKyBiL2luY2x1ZGUvbWVkaWEvZHZiZGV2LmgKQEAgLTE4OSw2ICsx
ODksMjEgQEAgc3RydWN0IGR2Yl9kZXZpY2UgewogCXZvaWQgKnByaXY7CiB9OwogCisvKioKKyAq
IHN0cnVjdCBkdmJkZXZmb3BzX25vZGUgLSBmb3BzIG5vZGVzIHJlZ2lzdGVyZWQgaW4gZHZiZGV2
Zm9wc19saXN0CisgKgorICogQGZvcHM6CQlEeW5hbWljYWxseSBhbGxvY2F0ZWQgZm9wcyBmb3Ig
LT5vd25lciByZWdpc3RyYXRpb24KKyAqIEB0eXBlOgkJdHlwZSBvZiBkdmJfZGV2aWNlCisgKiBA
dGVtcGxhdGU6CQlkdmJfZGV2aWNlIHVzZWQgZm9yIHJlZ2lzdHJhdGlvbgorICogQGxpc3RfaGVh
ZDoJCWxpc3RfaGVhZCBmb3IgZHZiZGV2Zm9wc19saXN0CisgKi8KK3N0cnVjdCBkdmJkZXZmb3Bz
X25vZGUgeworCXN0cnVjdCBmaWxlX29wZXJhdGlvbnMgKmZvcHM7CisJZW51bSBkdmJfZGV2aWNl
X3R5cGUgdHlwZTsKKwljb25zdCBzdHJ1Y3QgZHZiX2RldmljZSAqdGVtcGxhdGU7CisJc3RydWN0
IGxpc3RfaGVhZCBsaXN0X2hlYWQ7Cit9OworCiAvKioKICAqIGR2Yl9kZXZpY2VfZ2V0IC0gSW5j
cmVhc2UgZHZiX2RldmljZSByZWZlcmVuY2UKICAqCi0tIAoyLjM5LjEKCg==

--------------7gb0chAZrL1MzUUE5KcN7mwh--
