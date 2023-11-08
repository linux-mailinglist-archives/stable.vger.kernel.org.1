Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8097E4EE6
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 03:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjKHCba (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 21:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHCba (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 21:31:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F656181
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 18:31:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdj3Gx2mIKFVEHNduKHZOj3cWRvn/iUYme9l2ulFvuK95+ssZKJd7LBzAeA6V0VEvAqAzYp/Xt7TrIh/UnfXQlyTGf3LMrwRmIAm4Vk41bep8sEJTasTWVKY2Y+lR8B7gm7Eziktgm8fI8ZR0dVT+rS7/I5D+kX2UIMqrBERhnoeOZiPamrtBJi/y2DKeAPu1nOGnyoGeT7mlydeFsvy30BrBI7U0Kj2ioxVfKg9fjxV78c7U9v7Lok2fx51G/WlNQldBIO2LaWS0bgI5S7zBLuz76EYpArepoAMThSV+e4BM+Jz3WCwmHzu1rq5ey0N3M7cCLvaDKYQGZYldeZR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpsszuK1cg0NLEBNyrM2RqdTRbTUN5tNLFAhD4H2/0c=;
 b=PwhNyZoSUbB39RDzyyh5Ax7RUDvvQvj8Tlyq+rnyCwAIiWdE9xYvPtGJeHLEIxEeWVmUVetNDJxlH/wL7nPS1kwxEjgqd/0+sdVEoIrff/2vvD0MUiybPggLhh04IZxep2/9HjBFn9ysF/eHvgdUrPslq0PSwWiWjCAwlSdW+Ia+JThgRWLHJpp/f8i4E4aIpQNeZQM/LhApJ4tSxFv60/hcAZdzl4WtV4WIjnsriITsLWMJB9JCvvLFR2RNw4VQxRdPv7dp/1btqyxcjgMfQcydKfGu4zgwIApCG2XmVVO9Acth1ehiHKDBYdAZVBgeSQOnZ1fQUgeePfttzH/rgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpsszuK1cg0NLEBNyrM2RqdTRbTUN5tNLFAhD4H2/0c=;
 b=dkq94jnRIosZsisfgpMEWP2oSVIAegh8uLv6/3AEppBWutmStONIcj/xRXIDDTpH4atKi96yk6M6LkP9Rvywehr0fMjDHPhTb8VMAgQ34rLhrd7UFkyeEz9MDOho+xke/vbfxh4fdQMe9ybaJuh6ubPnSLVew19PDUwcLBu2wOQ=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 02:31:23 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 02:31:22 +0000
From:   "Ma, Li" <Li.Ma@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Thread-Topic: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Thread-Index: AQHaEViXiNqZX483ske4GlnedrhSEbBvKoyAgACFvEA=
Date:   Wed, 8 Nov 2023 02:31:22 +0000
Message-ID: <SJ1PR12MB607584E9EC092481410E4877FAA8A@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231107085235.3841744-1-li.ma@amd.com>
 <5d6c34bc-f7ef-4681-ad3d-ab2f1a792b72@amd.com>
In-Reply-To: <5d6c34bc-f7ef-4681-ad3d-ab2f1a792b72@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=864ea2b7-e820-44de-b234-ebbdd67b3df8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T02:15:48Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7377:EE_
x-ms-office365-filtering-correlation-id: 05792c1e-4f80-4438-0ac9-08dbe002cc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52MNFasdclAQrhHHs04LnG8IXNXnFssU7DiRobg/2weV/egnBuP6dHqfINBD5yYnlH9rHDl6HCJeeLcP5O0pAMWxonl2Fhc7RbjHdkfR9drw6P2e7bZC4adLh8RzGzzFDW0zKIAachVH3SbyEoREcdzqMiYXXFecxuAddaGyGTGgmfHBgVGNKOhcg+w243EsaMTnZLTsSpkkasL+z4LW81Q4zVt6QzE3tXBk1kf/1eO/S7guhctDq8fxF4IuSEHtH7oswYO+Gf82y10+b29U3IQsvtNsVeYdVNAKkkMrFA3nvtQmp3ba8N3j6jpoS9nRynimfFHKGsw2sQEQTvOUtKDRg8MRrKlDb8oyOeq83DSeOxYsBmHQ7D6EKjVdo1jp5bjWo7Q8r177gJsONJVd6+oIl3QaqVRMzV7BqMyyXcaU5RG0oUtl3nY8DhUk1+ZJjUSjuaazeibab1dH2VVS0MHk+2Sn/xA5h6vP5eI73oJjUtKy0okmAcHOgZ8AlvyBpMdodOjSg9+R6/95lxOlb+sCaF0bElBwW/N2TWepPFMHazMb0Tq5qZwQXp3i2Xfl3vnqLLDSHN5SuRbtGGsp4qCSbCCugxE6ANihRYDM0Eg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8936002)(122000001)(9686003)(52536014)(76116006)(966005)(26005)(478600001)(64756008)(66446008)(66476007)(66556008)(316002)(110136005)(66946007)(38070700009)(54906003)(53546011)(6506007)(7696005)(71200400001)(5660300002)(4326008)(8676002)(2906002)(55016003)(83380400001)(41300700001)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhESUpocERvVUxYaXIrSVhKbVBVanRjU2g5K0NsZWZsZkdETDdhTitCMTVO?=
 =?utf-8?B?NFFmejlhejNOQTAzMnhpYllJNjdFL2I2N3FrK3VsNGE5dUYyWU5mMG5VcnVy?=
 =?utf-8?B?WUpFdHBsSE5BRzgzYWFvd3FyVlRscGlqVjF4TW1tWFlVL2pPZmdJRjJ0TXlZ?=
 =?utf-8?B?Zmh3cUVRRjVTMGlFanV6SGp3VGZUVjJkZzFFa3dDZTdQNG05Q0dvenJobHJa?=
 =?utf-8?B?OTJuYnhEQ3NUYVJtUzRFTzVVQ29IcjVnUnkxVGI5aktoeTRLZ1lVbkN0Ujl3?=
 =?utf-8?B?V0t6NUVML0VrL1ZvNG1ZdG9sdnF5TWFYNFFodWkwMnhpSlFEYTJ1MkwrUTdn?=
 =?utf-8?B?bEsxMkxOVTEvNGc5cnhWb3hXYzNFTFM3WXZiTEFpc2lLcXBQM3NlbU5JR3ky?=
 =?utf-8?B?ZnRQM08zUlVGWUZjQ0d3eEd0bFkxTU85ZTRnR3kzUGhncTNtNGhzWTRFZExo?=
 =?utf-8?B?aXpHN3hXL0Q4cVhjYzliUStkY0FpRC81ankyM2t5L2dLT1pnTmVNTmpGdzdz?=
 =?utf-8?B?Y1ZKMXlXWVBCNGZia3p3OUlJR1VuckVSN3dGZitqWWNIZzhaZFRuN1diUitL?=
 =?utf-8?B?Umk1eCtaUDdlZERCZVBCTWppcmtYZk94SUZzR1cvR2RFdWNnWVl1eHd4bGl0?=
 =?utf-8?B?b0duc3BraWlIbEFOL3hGMWx2YWdsQnV6UzdXQlBSVnFmYjNKNDFNNXFDc2JB?=
 =?utf-8?B?SktwSGkzbThHWU1kQUxnUm9DelpGZkZRU0VEYWp2SWVHVkVneERSU25yaDl3?=
 =?utf-8?B?dFkrWjZJNnJWM3g4d3BYY2JvejJMQVBnR1dEaE1sS01UbVh2NWk3OW9jejNs?=
 =?utf-8?B?YWlYcWNRNlNPT2duK3dxUHY5NzBXb3NjY3V6dkFkaGVlaWNMZFcxRFVFdWpF?=
 =?utf-8?B?Uy84Q1dKVE5qcVBUSW5OdmFyK0xDVFRWR2p3c29WM2xJSEpoK1QxSUF5aElU?=
 =?utf-8?B?dE5FQ2VJNEpTN0hOcVNYTWxOTk5CVjliOWVMMnJZQUlDL2p2Smxnc2ozSUxa?=
 =?utf-8?B?UExOSFJaWVNncVNxaGkrbmRHbSsxTmtkZG1zL0ljWVAyYTk4VDBDUlhEaFpX?=
 =?utf-8?B?cEVlOENGQXJ1eWxKNDJETE9icGlSbUd2ZGZ2TlFKYkF1a1VZOTRqUm9sRlVY?=
 =?utf-8?B?Mlk5b3FqL2hSTit6TzBFMU5HUmdYT3RPcjBpUURMVkhudmlqelhTZitQZng1?=
 =?utf-8?B?RnRrNkU5UG1DbTNMVzlQQmNKV2xPdnZiYkhLWTR2anRRVTE2cDFvZE14bnhW?=
 =?utf-8?B?bVZuVUQxY3l6dEFVZWtjSkc3ZlFNdzZYOU5vMGtxQlhSa3BKSUs5VG5Qd2My?=
 =?utf-8?B?NVU1cE01Ym5zdTNkWFV2QVBvT0xYQU1mMzZtU2JQQm1iV3pJdWF6QndXalN3?=
 =?utf-8?B?c2FLU1NvbnRnUHBHVVVTR21Od0NWanhxbjBJQmxJQzJBd1c5a2x2WndobUli?=
 =?utf-8?B?YWRkTkRoOVFybVpMTlVKWFA3bTVVUTcwVFBWNUo0WmtrbW1LVFd0aUwxOThH?=
 =?utf-8?B?YWRMTm04MXY5cmphcytHVDQ0QkJJSlhveWk0UDhRVHJhK0Vxb0xNNmhPRm05?=
 =?utf-8?B?RURRRDhRZW1URjVDTjM0N3ZrM0ZFaFloUncxUWhQejgyeTA2TEkrcWg0TVVJ?=
 =?utf-8?B?MnlQaEdVTWN3WUgyb3ZJNnQvVkZVZzc2aURzbkoxOTVFOW5relhZdFM1VjFp?=
 =?utf-8?B?QlB4QjM3NW5rbm9sMHo4M2FBSEFTbnlqd2ZONGJ2SnJnck03Y0NOUVJMT1RX?=
 =?utf-8?B?MkJrcEdGa1BvNU0yRmtsQUpZR0xjMFB6SE8vVkR4bWZKMzFJekUrNUZHUVV1?=
 =?utf-8?B?TmZ5cjRRYnVaZURYeXpoQWZTVVUwN1k1NmFVQ0NzVUIvNVI1SjBzWEE1SHg4?=
 =?utf-8?B?bDZGTFpocUtFOTdJS0R1SHVVTldJTFBRM3pMbnYrYUpLWkE4U3d2VFM3eGFO?=
 =?utf-8?B?SmFGb3dMUWQxTDZGRlBpeEk0Ri82WVp0YTNrOUk5cWFMS3g4SEt6cXNGamxi?=
 =?utf-8?B?aVp3bXJ6YkozZ09LOFFzdnE2MkVqc3R2V0krbWZXSnd1aTNZRjdZcUFtazNZ?=
 =?utf-8?B?Y0lJa0ZndmR3L241SmRVVmdJS3FlZDFYNVVNdW5lQklYcGtjQUxteVdIWnVh?=
 =?utf-8?Q?Fu44=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05792c1e-4f80-4438-0ac9-08dbe002cc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 02:31:22.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9k8QOeHxZsIiIiuLYho4mpJ7fhna7XUgykWyhxRxQS0zF+IH6iMAcXWKqaIrI/B8Tc6B9AJYe6o9mnoRvDJDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQpZZXMsIHRo
aXMgcHJvYmxlbSBpcyBvbiBhbWQtc3RhZ2luZy1kcm0tbmV4dCBhbmQgSSBjaGVja2VkIHRoZSBh
ZGV1Y2hlci9hbWQtc3RhZ2luZy1kcm0tbmV4dCwgdGhpcyBwYXRjaCBpcyBub3QgaW4gdGhlcmUu
DQoNCkJlc3QgUmVnYXJkcywNCk1hLExpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQpTZW50
OiBXZWRuZXNkYXksIE5vdmVtYmVyIDgsIDIwMjMgMjoxNyBBTQ0KVG86IE1hLCBMaSA8TGkuTWFA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEu
WmhhbmdAYW1kLmNvbT47IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBz
dGFibGVAdmdlci5rZXJuZWwub3JnOyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gcjgxNjk6IGZpeCBBU1BNLXJlbGF0ZWQgaXNzdWVz
IG9uIGEgbnVtYmVyIG9mIHN5c3RlbXMgd2l0aCBOSUMgdmVyc2lvbiBmcm9tIFJUTDgxNjhoDQoN
Ck9uIDExLzcvMjAyMyAwMjo1MiwgTGkgTWEgd3JvdGU6DQo+IEZyb206IEhlaW5lciBLYWxsd2Vp
dCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+DQo+IFtCYWNrcG9ydDogY29tbWl0IDkwY2E1MWU4
YzY1NDY5OWI2NzJiYTYxYWVhYTQxOGRmYjMyNTJlNWVdDQo+IFRoaXMgYmFja3BvcnQgdG8gYXZv
aWQgdGhlIGJ1ZyBjYXVzZWQgYnkgcjgxNjkuDQo+DQo+IFRoaXMgZWZmZWN0aXZlbHkgcmV2ZXJ0
cyA0YjVmODJmNmFhZWYuIE9uIGEgbnVtYmVyIG9mIHN5c3RlbXMgQVNQTSBMMQ0KPiBjYXVzZXMg
dHggdGltZW91dHMgd2l0aCBSVEw4MTY4aCwgc2VlIHJlZmVyZW5jZWQgYnVnIHJlcG9ydC4NCj4N
Cj4gRml4ZXM6IDRiNWY4MmY2YWFlZiAoInI4MTY5OiBlbmFibGUgQVNQTSBMMS9MMS4xIGZyb20g
UlRMODE2OGgiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBDbG9zZXM6IGh0dHBz
Oi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3ODE0DQo+IFNpZ25lZC1v
ZmYtYnk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMgfCA0IC0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4gaW5kZXggNDUxNDdhMTAxNmJlLi4yN2VmZDA3ZjA5
ZWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+
IEBAIC01MjI0LDEzICs1MjI0LDkgQEAgc3RhdGljIGludCBydGxfaW5pdF9vbmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsDQo+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpDQo+DQo+ICAg
ICAgIC8qIERpc2FibGUgQVNQTSBMMSBhcyB0aGF0IGNhdXNlIHJhbmRvbSBkZXZpY2Ugc3RvcCB3
b3JraW5nDQo+ICAgICAgICAqIHByb2JsZW1zIGFzIHdlbGwgYXMgZnVsbCBzeXN0ZW0gaGFuZ3Mg
Zm9yIHNvbWUgUENJZSBkZXZpY2VzIHVzZXJzLg0KPiAtICAgICAgKiBDaGlwcyBmcm9tIFJUTDgx
NjhoIHBhcnRpYWxseSBoYXZlIGlzc3VlcyB3aXRoIEwxLjIsIGJ1dCBzZWVtDQo+IC0gICAgICAq
IHRvIHdvcmsgZmluZSB3aXRoIEwxIGFuZCBMMS4xLg0KPiAgICAgICAgKi8NCj4gICAgICAgaWYg
KHJ0bF9hc3BtX2lzX3NhZmUodHApKQ0KPiAgICAgICAgICAgICAgIHJjID0gMDsNCj4gLSAgICAg
ZWxzZSBpZiAodHAtPm1hY192ZXJzaW9uID49IFJUTF9HSUdBX01BQ19WRVJfNDYpDQo+IC0gICAg
ICAgICAgICAgcmMgPSBwY2lfZGlzYWJsZV9saW5rX3N0YXRlKHBkZXYsIFBDSUVfTElOS19TVEFU
RV9MMV8yKTsNCj4gICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgIHJjID0gcGNpX2Rpc2FibGVf
bGlua19zdGF0ZShwZGV2LCBQQ0lFX0xJTktfU1RBVEVfTDEpOw0KPiAgICAgICB0cC0+YXNwbV9t
YW5hZ2VhYmxlID0gIXJjOw0KDQpUaGlzIGlzIGEgYmFja3BvcnQgZnJvbSA2LjYtcmMxLCBJIHN1
cHBvc2UgeW91J3JlIHNlbmRpbmcgdGhlIGJhY2twb3J0IG91dCBiZWNhdXNlIG1pc3NpbmcgaXQg
aXMgY2F1c2luZyBwcm9ibGVtcyB0ZXN0aW5nIGVpdGhlciBhbWQtc3RhZ2luZy1kcm0tbmV4dCBv
ciBkcm0tbmV4dCwgcmlnaHQ/DQoNCklmIHRoZSBwcm9ibGVtcyBhcmUgYW1kLXN0YWdpbmctZHJt
LW5leHQgSSB0aGluayB5b3UgY2FuOg0KIyBnaXQgY2hlcnJ5LXBpY2sgLXggOTBjYTUxZThjNjU0
Njk5YjY3MmJhNjFhZWFhNDE4ZGZiMzI1MmU1ZQ0KYW5kIGNvbW1pdCB0aGVyZS4gIEFsZXggd2ls
bCBqdXN0IHNraXAgaXQgd2hlbiBoZSBidWlsZHMgdGhlIG5leHQgUFIgb3IgcmViYXNlcyB0byBh
IG5ld2VyIHJlbGVhc2UuDQoNCklmIHRoZSBwcm9ibGVtIGlzIG9uIGRybS1uZXh0LCB3ZSdsbCBu
ZWVkIHRvIHdhaXQgZm9yIGRybS1uZXh0IHRvIG1vdmUgdXAgcmF0aGVyIHRoYW4gY2hlcnJ5LXBp
Y2tpbmcgaXQgdGhlcmUuDQo=
