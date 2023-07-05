Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BE7488DE
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjGEQHK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjGEQHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 12:07:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADABA
        for <stable@vger.kernel.org>; Wed,  5 Jul 2023 09:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaABPrQjbbJ4uN0wI0gYeMKVOLBUidFzmmRbh2GRx8GCZ5O8+r9bVCtdypR1MedB1nABy8srfaf7iJtVJJQYb2wTliFXeaqc9JjqlBTlCovjkmgK55xK8U2gLRMWDWCKesrOOKmSFb7+6cFTHGRZYLN1kObCO8KDRQE4BeRfT1Fm9jN4vzy/G5ifErIwuGeUBH2EYL0U4wG9ZhmPAI8K5Z/4/ExqsjDo0Rr0iaAVB6JpGrj0XUhqEHMoRmlpJCO2mzAXgcjEeESStoXBXCBbo+ND1SgQGqgsC84l/hPnDYmFi2EX8ExCJUFPxQYvwjrRiXA2rvH82TJ6IdYj0/RdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2/thypoPzZpYuPE78sEMRgYTLOvYOiLbWf0TJ1dNCk=;
 b=RPRUgvaKkeDTnJy/67y4NubKSOrvpuN07LmiRA055z/A5yQYWIp0WONkFhFG3wmhoBzZcNqtEihoMYVdm2LBbn9rPR3IywB3G4P3sGZ96SPnyX1v/2KfBEv7sERDr3mUduTI0TvKUFhFH7q3+shvJCwp2+DdRuk6IYUokh/h1bXt3zUUJJjbzj5EAT9PSa8vMjcUVuNSmhjZZK1LJfHHKcC91VDLIukYk8AEe+p+KuPha+f5xjqXtUVMhXk+v9QxcCJkcbd69UodIGccrtAjGSP+LO3mqbTQVpH+LhGjYlQgERsBLxwwQvAGMIkQbiJ3Umr6xeCsBQKfu5OAVfYjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2/thypoPzZpYuPE78sEMRgYTLOvYOiLbWf0TJ1dNCk=;
 b=QDvJtpxIKVzfrsAlIpwo49L1eZq+JlONL7/nZf4CXITwBKubuVx7n+HKCEhg9viWiyqQW7ypLdvFhcV0AWlrFuI6yuC6R3wriw4eazFNNV71wek25igSJZBcfTfjQ46QeLtFNAMKGWbqFOC0nv0Sq/EScFeptB0dtukdQ8g9d5U=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 16:07:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 16:07:05 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux regression tracking <regressions@leemhuis.info>,
        Haochen Tong <linux@hexchain.org>
Subject: RE: [PATCH] HID: amd_sfh: Check that sensors are enabled before
 set/get report
Thread-Topic: [PATCH] HID: amd_sfh: Check that sensors are enabled before
 set/get report
Thread-Index: AQHZrlnoQAmF39LsMEO1VZWFUz7Qva+rWF8w
Date:   Wed, 5 Jul 2023 16:07:05 +0000
Message-ID: <MN0PR12MB61012CD476072E6FBCCF5BE7E22FA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230620193946.22208-1-mario.limonciello@amd.com>
 <b691b60d-80c4-2bf8-4f62-c957bf8fc1ba@amd.com>
In-Reply-To: <b691b60d-80c4-2bf8-4f62-c957bf8fc1ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8db1da4e-fa84-4aee-8781-ecd04284db5d;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-05T16:06:03Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB6993:EE_
x-ms-office365-filtering-correlation-id: 11730f95-2e24-48b8-5c24-08db7d71e075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bzPIYcmjHvwhvjIBNGSmsppts/DoQSPRq2Tx6fYpg1veZrCX5Z1F86OLhXROtfifVMowDk4SgGkJmjUgzJcaGqxbej+2zOjJYIFW4AZDK2lp4971KLhuSTivNo+If+898CiCySAjd0IKFNPDreOFksJ5zLVTtSvMqDjMvZRVnu7v1sdyoxpbuyvvxXaEp8S+AUyNMUDgycMfdZyaBmCow0eY3M8wgZs9sYdgf3dcl+MNK5ljVrgYULgZxYJc5NuoYj4uTWRKTXqyvkfbjwTlTyTrViA/dHyAD+VP8F1FsLfWRSff1JrtIkaP4VjZlPQs2uIjRbPxeEmmQqg2I18S9WNvV3EAKZM0CqNaGbV2CMH2uMpIe6PTlyfXCmGOgjrqifQuxpQB0XA/dd4OGj9vLimxKAtTfRkF/baE3UVNCtVXdnAOLufG7kfnybQlXX53H5+VxxvB6TMus6OlMthqQVVFdwuNLj19LVZHUtafZF32+E74L4Hi3HRap8s2o/yBTOGCzZXUeWaQkIT9nEjYCbAN0454mrk2f6qnleft4yBwT9KveZ7vP35/OjbpowsicJPHDtdfcJIFWxZmnKHmXxAyaksxnogArLPSsY+B6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(55016003)(110136005)(54906003)(478600001)(122000001)(7696005)(76116006)(71200400001)(41300700001)(8936002)(8676002)(38100700002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(83380400001)(186003)(9686003)(966005)(6506007)(26005)(33656002)(86362001)(5660300002)(52536014)(4744005)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FQNlU0alg1VU1VZFZyU2ZCNlNkMUxTa01kZDQ1REMyTEFFQlIvck5TWWlO?=
 =?utf-8?B?alFPUjRic0I4eGR4bEZrQ0YyTmgzdXhnbEJzRW5zNk9JRHUveEF6Z2tGRit2?=
 =?utf-8?B?cnZvUzlMbzR3WGpBNit4MU5LYS9UNFpHZGZJaVVtYk1KTUNGbi81NjF4aE5W?=
 =?utf-8?B?UnVlL2VXQmVaZTlEVmJZWnBiSE16ckFWYVRsemNqOHhJOVlJWjdjUi9yQ0Ur?=
 =?utf-8?B?VkE1QktlM1dYcDdFaWNCaS91NUQ3Q04vbzJjMitKZ3lzVEordHJxZkdRMGJB?=
 =?utf-8?B?czBrOGQ2WE9IMnZPOWhmWm9jWFZJMmYzNTBTdjcvdE8zRFlTRlpNcXVYeUdQ?=
 =?utf-8?B?QjluRTJFUjJCS2F0M1U5bFBHZlBwaVllSjd4MUUyYWNUZTVOUGRPSWdFOHRu?=
 =?utf-8?B?OE9JUzBZOWc0S1d5TnhGZE9BUkZYVTVIaUUydlNYQ2ExRWQxcHByYStzNXVQ?=
 =?utf-8?B?NW5DNHNEYmRCMG0wbjArWnZhakdEbXl3QzJXZnBWOFpJKzVOZ3ZpVkVBd2ZC?=
 =?utf-8?B?OWZsTGpZRDBqRzVjZjdoRHFqck52YkMwM3p2QW9pd2dHUzFYN1JZMVIzeFNr?=
 =?utf-8?B?RG1wU3pFNjJnYXJnd2VPQ1hFblRSaW1zd2U3K293c1pqeWJHTldZMkE4SHNy?=
 =?utf-8?B?cTJHczdocFdaYkNsdVIwZ3ZoRFo3ditCNlZVRVpBQnBxYnZCMThoR3NNM2Fr?=
 =?utf-8?B?VVJTZkRlV0J3VkFMOFoxNzNTcG5zQ2JUN0J4TCtKcFlLSzMzQkIyNk5GaHFl?=
 =?utf-8?B?S25rRVRNM0NHWk5ycTQxSGxIbytrTmpraDBtVFNabmZuQWs1cXd5bnpiTUlu?=
 =?utf-8?B?aHFJWGY1ZENFamIzOUNCbzAvcUhOdnNHMnM2N29OOWM4OEVPNUdBb1FZTkQx?=
 =?utf-8?B?NFpQMEFmMUVjQ0o4RFVSWDNLZVRYZytHK0twS21oU3pPcStyOEV3S0hENEJB?=
 =?utf-8?B?bld5bW9ObGZHQUFBcmh4SmVaRk93MlZQTWhrM0NDRmNMVjI1UGFhaWRMb2ps?=
 =?utf-8?B?UmtNK29KMzFJMDlCdnZPK0NPOXpHN0Y1bnRhWVkzUnpJWXpkUzFSbjAvTGFi?=
 =?utf-8?B?TG9BWE9sOG5KTDFlR2FTa3JsMkZSRlFXTExHMjFXUUVKbklvZ0JiYmZia01p?=
 =?utf-8?B?N0ZpK0VyQXRmUHA5R2s5N1QvUUFuVndDQkdqb2lUREhoelloQm5DYkp2azRM?=
 =?utf-8?B?UlZTVUNIRHl5aVlubDE5ang0dWt4ZU9pZUsrdWMvTUM4Yk40Nm5YN056Y3pB?=
 =?utf-8?B?cWIybkdlY1NrUkRJWDdkQndWZk5UeXQ0UUcyQnBDcHZTWVhFeG9Oc1NSRVo5?=
 =?utf-8?B?TnhHYVhjVG5kQkhCR25ZRHhWSEZVTVhPeEFSZGljVWhPVC9zK0lTajk2NUhB?=
 =?utf-8?B?NGd0M2dqbitrK3NpSTY1NWdjR1Z6VFNUSzd4dGdBcmR6ZklHZDVyTzZsenJz?=
 =?utf-8?B?Slo1Tmxva2lSa01odmxKU1B5Qzl6SUN1ZUt1YzY4MFFTUStYdUwvem93VkVD?=
 =?utf-8?B?YXA3bGxxdnNOeWxGQ2x1QVZ5aUVPT3FYdng2Wng1by9iOEVaOXJQb0NqU2pL?=
 =?utf-8?B?RnJwR0Z6SG8yU3dCbXhERHU1YXF6dHNueXBpM3I2emVpdkJpYU5KVDluSGdm?=
 =?utf-8?B?ZDBjUWV0SzEzaStrZENUa1RXUno4U0RwcmFNRS92UEt6OTh6dk51MUN1VlZa?=
 =?utf-8?B?b1FLSUxNU2pWN2JXbC9VZXlOQmN1Mm9pM0EwZ3VDdVRFYmVCTGlUVDluN0dI?=
 =?utf-8?B?cDg4L0VtOEhjbno0aFlnZTJPby8zWWMyemp3SjIrSnM0aDhJeG1oNFV4cVVL?=
 =?utf-8?B?dnhVNTI3akVGbGJ1alo5bG5XS2x6YVd4VzZzTDlKemNaNXdtSzA3WFdNeU9W?=
 =?utf-8?B?dHMyditNSDljY1BwTWhTajlid1dwRGtmbjlQcTdzekRVNlhtbURsQTVSMUUw?=
 =?utf-8?B?cXJXN2ZZbW5pRS81QjhiZlN3aExOT2xZUUJ1Zm5qVFhlR0RyVHF2SEdaRkdC?=
 =?utf-8?B?ZjlOWVp2b2dua1FsQ05IWXlGdmd2MlU4NlB4YmZ0V0FGSkFXQmhGMldjaTZI?=
 =?utf-8?B?amlMY29naDRRRUs4UnMvQ1FEVmlqSkRqQUorT3JHUTcvUmlWV0NYUk5kcld1?=
 =?utf-8?Q?Pi6Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11730f95-2e24-48b8-5c24-08db7d71e075
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 16:07:05.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QitWslNHvM01Sru6SjlH4X/dMyJy6TDvPN88yzbk0i81ZG0M+0bkf7MrDqEjXoskFaY2oTV9n+omQlRRnShSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

W1B1YmxpY10NCg0KPiBjYW4gd2UgY2hlY2sgYmVsb3cgcGF0Y2ggc2VyaWVzIHdoaWNoIHNvbHZl
cyB0aGlzIGlzc3VlIGJ5IGluaXRpYWxpemluZyBISUQgb25seQ0KPiBpZiBpc19hbnlfc2Vuc29y
X2VuYWJsZWQuDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9ueWN2YXIuWUZILjcuNzYu
MjMwNTIzMTU1OTAwMC4yOTc2MEBjYm9iay4NCj4gZmhmci5wbS8NCj4NCg0KVGhlIG9yaWdpbmFs
IHJlcG9ydGVyIHdvbid0IGJlIGFibGUgdG8gdGVzdCBpdCBiZWNhdXNlIHRoZXkndmUgdXBncmFk
ZWQgdGhlaXINCmZpcm13YXJlIGFuZCBTRkggaXMgZGlzYWJsZWQgaW4gdGhlIG5ldyBmaXJtd2Fy
ZS4NCg0KQnV0IHllYWggaXQgc2VlbXMgcGxhdXNpYmxlIHRoaXMgc2VyaWVzIGNvdWxkIGhlbHAu
ICBJZiBpdCBjb21lcyBiYWNrIHVwIGFnYWluDQp3ZSBzaG91bGQgcG9pbnQgYW55b25lIGFmZmVj
dGVkIHRvIHRoaXMgc2VyaWVzLg0KDQpUaGFua3MhDQo=
