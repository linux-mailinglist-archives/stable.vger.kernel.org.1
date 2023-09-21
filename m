Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E477A9612
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjIUQ5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjIUQ5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 12:57:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F8E41
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 09:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyxS+zVhYEDXC9fRjignFeB4PjnZlcp/zmQBK/TPJnGnuMxy29FTiLzfAlmgciO6QXMGKYEuISLM+KIpTL4Yz1T/eEWjSPIEIPABAElX/p10WykNahx60QL+BwLKoRmJKINnUJE0CNBbGt64Gw2XloduS4+BoFE8beiPAF7+BU9MR1/MMyw0ml2Qyk1p0viQxvRXCGYPCPp400Kj5NIxyOcOq7lhrtoblU5trY/W3ehV5pkbhO0SrpTMsrLELa7fPtzCRfM3tnsBqSu8hR82UkwnsdD3xFAtTYTGlVjrssfTGMlvQDEqvuAlkdcR5h02l7KpxllxSSlfamGHYvTFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zVvTyMdgghHeT1WX0y1jqyy+sl3BQctdk0PsKX1R7I=;
 b=GXqAZiWz/0ypVu2Eg5l8poF1uE5cP2lA4ngNpK9VJXHCojfXRRYGMpwxWc1XNGjjTWJC3NN/hlEPuH/ES+k/LIY6bsyQsJIs5XBh6XrD2bhFffn3JxcAD3lAxB3CPuZtbE8+NdBaH/9LPjycPfYzP/RBmM400FGay1vn7c3RD6GO7BxOOCUsfKX5AF/sCk+vcyaHZzcBbLLgdFamF5CP9SDGlq0TiCty4DTHSngeiZoo7CCvfBHQBV7E6cxLOQVbNX4JuN86uQuf6Nt4U2T1H9MyLpsAqbS5hgXe/WseVNiuZL1y+lN99iqPRpvJd2UIISnAKQjckM16lQKsk2a5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zVvTyMdgghHeT1WX0y1jqyy+sl3BQctdk0PsKX1R7I=;
 b=3j2vKuWkdQA4rvtW8zPi/jckN3Fb7AJ+GuHl8U1Wzqxhz9RSPNOm8vqg8cUkxUtMtnqD+gTqRtrf6Mt3dLlW+keyG4hz+WsQgWM1mWkLw8MvOmoFsgVTM6VJCZE8mDU83A46T71WBq88krcywMEueqEmPQ0UKXtzaZysCj8KrmU=
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 21 Sep
 2023 06:11:59 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::aee0:f69d:3cde:65d4]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::aee0:f69d:3cde:65d4%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 06:11:59 +0000
From:   "Liu, Aaron" <Aaron.Liu@amd.com>
To:     "Yu, Lang" <Lang.Yu@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan
 skilfish
Thread-Topic: [PATCH] drm/amdgpu: correct gpu clock counter query on cyan
 skilfish
Thread-Index: AQHZ7FA96dU3hrLIL0GVK8Jd7AsF9bAkx4GAgAADH4CAAACDwA==
Date:   Thu, 21 Sep 2023 06:11:59 +0000
Message-ID: <DM4PR12MB524827A887101B94CE1E6C7FF0F8A@DM4PR12MB5248.namprd12.prod.outlook.com>
References: <20230921055421.3927140-1-Lang.Yu@amd.com>
 <20230921055421.3927140-2-Lang.Yu@amd.com> <ZQvdK1e5XZB1jRII@lang-desktop>
In-Reply-To: <ZQvdK1e5XZB1jRII@lang-desktop>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a6387268-df96-4e50-ba64-000ead92a9e3;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T06:07:21Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5248:EE_|IA1PR12MB6482:EE_
x-ms-office365-filtering-correlation-id: cb40eb38-eb15-4be6-5b83-08dbba69aa2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iCSw9q4cg5+VL80Ar0imweT2liJKa3xPZVBXxR+c1t/acZ0t4X9lUTBGYpWtggghV6xQJrrklscP4FCdR7NEIGVdT0rQzHko+kHegdgW89KkYlRBQGAEM5fMG1lX4qa9ZRN/ut00QhNY3hOUjOl7B7rRiexrn0xuagzx0JlW0xvvUE4RA5Z/vdZZtAgmUIVxW39KcOOd0Nccy+jHVV53DE8CWoPzylRySsILjFj+BQgbho65QAS1/EpUdebfGoiSkH+OyhdwXm1KWoppy1wq+A7GUY5eogO+rIIOF2j3Ly0A0rH+xCuEWXvQIsKMwGz2vtJlvrQm+kMUnRZsAko9ffT32XlBb2GG8kD0BIck97DhEedkG6uTObgr0gfJkAE4bocNus8edndchZ3rpjaQdYLbdux97aVbx01+wE5r2nfWBz6cgHKEvM/tWAzWmaGw/aeY/nqhppAFYI/QjdF0uwmAnxlcYpGhlXozjo6mdJ+uvBP0FoHtt24+l3Xh1xXVb9kpTOnDyD2LGtmewqGnh5Yu3IDf9eT/F8PItu8FxlnPGxPHK49hsPrmkOykAc3ofOcc3jfyVV28+Ib06f78zR4oX/PPzAeqeQvn6gND8sBw8jlEk8nb1LArYsEkCjNS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(83380400001)(71200400001)(122000001)(478600001)(38070700005)(38100700002)(7696005)(6506007)(2906002)(9686003)(55016003)(53546011)(52536014)(33656002)(66946007)(5660300002)(64756008)(66476007)(66446008)(76116006)(4326008)(54906003)(110136005)(41300700001)(8676002)(86362001)(66556008)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWxLbDg5SXVnNEJHeEM1TzR5bVJWbGtvMGJ4WXZXVjhRbXl4dk55TGRKTWJw?=
 =?utf-8?B?TStvS2FhSWFFTnlOcFV1K1JGZnZvS0ZkQ0lDZDBFWmVMbjZOZktPOXhzbHBo?=
 =?utf-8?B?WDBKUHVkWFZLSWtzNVBWWTZQUEJWcDFNZkNPL3FwS2NpeFp3UkQ0elJNbTd4?=
 =?utf-8?B?SEZidTVwNHB6ekpxOWFza0tPcVIyT3Zzekt6N1A0aEx2QXZsa1BwQjhHVzkw?=
 =?utf-8?B?QlpTZEt5cGlkT1c2RmRqQWEzcys2M1JMUDQzYzJIRUZPeENnWW1GaGV2enBu?=
 =?utf-8?B?VVJWcW5pbmJsOEd2NUc4NXczUmhTMXpSRnFRVlBnelF0bC9yK0VtZ2ZoUnNB?=
 =?utf-8?B?TnV2NFZlM3M4bGJCZzFMQjR5RXdnQWZGaWtkMktoQUF5RWZGWnVJMy9SbXNt?=
 =?utf-8?B?TVQrY21rTTJObHVvaW12eFFwV3pkZFJuM3J3WlR2ZDM3UHd0V2JqTzl6NSs1?=
 =?utf-8?B?RnFEMnJoRjRQK3ptQVhoU0FWOEJhYzZhaHppOTN6WjE0K2ZCYjV4SERaMzVE?=
 =?utf-8?B?bmxnNFluWEFuN3ZHeXZQbVNpbTJxUzFvaFhpZ3dKQ2NGS3o3djFTOWY5b2ZT?=
 =?utf-8?B?cXlQTlI3UzlWMlVpdGplYVkrcjZ1Qld5bUNJZ3I4YWJXYnBvYmVLMCtvU3RG?=
 =?utf-8?B?WXd4bVh4K09UZXNEbEg2N2NPTmNkT3NRa0N1NW15MThwK3paVEVHc1dvaS84?=
 =?utf-8?B?eTZaZ1FHclR5eW12NTZ6UEVsZ3hVZWlacXljb0kyd2FQak0xOEZ6T295aEVT?=
 =?utf-8?B?RGJLZU5oU2ROUnZqc2NkMWVFWUs2TWhnSnBydHZjM1ZpcmZhMDF1c09sNmFW?=
 =?utf-8?B?UXJQSVlRVEFuOGorSnQ0SGdDNGlSVUtMdCt3WlFiSW8xRCtYYWlkQTJxRld6?=
 =?utf-8?B?MFZHd0ZlUUhJc0VwSDhSanpwK3JKRlVxd241SGk1L2huaE85Z2hYUXEyS2ZU?=
 =?utf-8?B?VTloMzhUTTBSWEFhOVFqU0htYzMrREVBWmZrMjZydklsdDk3TDkveE1JeDNU?=
 =?utf-8?B?YnBpZDNEaE9RQVk3Smo2V3BQaUhlY1RHREpPMmNZWFlQbW81ck95ejlRbTQ2?=
 =?utf-8?B?RHA3STBQVXJlQVlvNUhyMDFwWTFteUR1c1UvaDl6VXhGUlZFdFUxaVZZZFhl?=
 =?utf-8?B?UFBkL2RVOWxnVHBJNUIxR2Z5NkhZRWtINkNQbVQ2eEhwNmtpOG5Lb2xMcnQz?=
 =?utf-8?B?ZXltdEhYVld0N1hyZzdQNEZ0c3NUaFNYanpEcWh6T1FLR0dzbENScHozcWg0?=
 =?utf-8?B?bUd5RFJoRmlpVkUvY3VHd04zTEdRV3BLVEtmeS80czNIM2tBR1pBeFdsZ2M5?=
 =?utf-8?B?RWswdXN2R0p1dXZ2UWZ4KzN6NVNwMTJKQ2NibmUveDNLWG9NdU1TM0Q0dW5H?=
 =?utf-8?B?Z2t0L240VitaTisxT1JBZWdHa3BoRjE5NENWRklSdG1WUzc3V1ZKQUtrNVFB?=
 =?utf-8?B?eWdLVW40Zll4WU42cmRwMHRMR256YzdUZ0pIMFhhTTFhWnBLcjNiSHJNQlFl?=
 =?utf-8?B?Y0JraW4xeFZCSjNsREJVa2RtWXI5MEV3WkdRdUcveHdWV1BoOWNOaThUM25K?=
 =?utf-8?B?Qld0cmxTdktQSlJSWlhIN0tPZy8wdXlnUTZMRFlJdlYvbHpKakoyZElkWWdz?=
 =?utf-8?B?UUlVSWszZW5NMnZqSUpsWTRnb0dxejFidm9BUW1JY09nR0VWSnVEdHViUHIy?=
 =?utf-8?B?bWkrUmltN3MvQ1pEemJLSGxCUnI4NGpXVVBTTjBucmZpZmNYTkZMbjVsbkxD?=
 =?utf-8?B?TlR4ZWlBMCtrc0RyaTAweGdkd2ZseVV6RmV2QjJMN0NlbzFIUUlCU1BvQnBj?=
 =?utf-8?B?VDNTbld5eFAzenA1a0d5Q3JsVkJweWs3Q244aUpSVXRITFFwVkxZQ0JBKzJQ?=
 =?utf-8?B?bm9yZkVjRXVzcWhrcU84VVhtL2NuMVhZTmxUMzZQdWloRjQxWWIzWFBnUllT?=
 =?utf-8?B?dUhlSmE4U0VHWHFtempOYmNUYTFva0tMYTFoZFVXcGpTamtTK1EvUkJTRHVu?=
 =?utf-8?B?ckpKS0tkVzRyc2VqeXZEZkllMTBHeWFKUW1tTnlzNW1EUFYxcnlEZTZ0QThM?=
 =?utf-8?B?SDVwVUFQWXptVjIyRm5mV2VpUHdrTlZPL1lTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40eb38-eb15-4be6-5b83-08dbba69aa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:11:59.2220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNMSTlgqhMpkyMBFlxVyN25JjvqNAaBifba/e9sbMfbzCVCO0gidYRqSnvtdtPs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBBYXJvbiBM
aXUgPGFhcm9uLmxpdUBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0
ZW1iZXIgMjEsIDIwMjMgMjowNiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IExpdSwgQWFyb24NCj4gPEFhcm9uLkxpdUBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEu
WmhhbmdAYW1kLmNvbT47DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGdwdTogY29ycmVjdCBncHUgY2xvY2sgY291bnRlciBxdWVyeSBvbiBj
eWFuDQo+IHNraWxmaXNoDQo+DQo+IE8gMDkvMjEvICwgTGFuZyBZdSB3cm90ZToNCj4NCj4gU29y
cnkgZm9yIHNlbmRpbmcgdGhpcyBwYXRjaCB0d2ljZS4gUGxlYXNlIGlnbm9yZSB0aGlzIG9uZS4N
Cj4NCj4gUmVnYXJkcywNCj4gTGFuZw0KPg0KPiA+IENheW4gc2tpbGZpc2ggdXNlcyBTTVVJTyB2
MTEuMC44IG9mZnNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVA
YW1kLmNvbT4NCj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjUuMTUrDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMjEgKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiA+IGlu
ZGV4IDFkNjcxYzMzMDQ3NS4uYzE2Y2E2MTE4ODZiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gPiBAQCAtMTAyLDYgKzEwMiwxMSBAQA0KPiA+ICAj
ZGVmaW5lIG1tR0NSX0dFTkVSQUxfQ05UTF9TaWVubmFfQ2ljaGxpZA0KPiAgICAgICAweDE1ODAN
Cj4gPiAgI2RlZmluZSBtbUdDUl9HRU5FUkFMX0NOVExfU2llbm5hX0NpY2hsaWRfQkFTRV9JRFgg
MA0KPiA+DQo+ID4gKyNkZWZpbmUgbW1HT0xERU5fVFNDX0NPVU5UX1VQUEVSX0N5YW5fU2tpbGxm
aXNoICAgICAgICAgICAgICAgIDB4MDEwNQ0KPiA+ICsjZGVmaW5lIG1tR09MREVOX1RTQ19DT1VO
VF9VUFBFUl9DeWFuX1NraWxsZmlzaF9CQVNFX0lEWCAgICAgICAxDQo+ID4gKyNkZWZpbmUgbW1H
T0xERU5fVFNDX0NPVU5UX0xPV0VSX0N5YW5fU2tpbGxmaXNoICAgICAgICAgICAgICAgIDB4MDEw
Ng0KPiA+ICsjZGVmaW5lIG1tR09MREVOX1RTQ19DT1VOVF9MT1dFUl9DeWFuX1NraWxsZmlzaF9C
QVNFX0lEWCAgICAgICAxDQo+ID4gKw0KPiA+ICAjZGVmaW5lIG1tR09MREVOX1RTQ19DT1VOVF9V
UFBFUl9WYW5nb2doICAgICAgICAgICAgICAgIDB4MDAyNQ0KPiA+ICAjZGVmaW5lIG1tR09MREVO
X1RTQ19DT1VOVF9VUFBFUl9WYW5nb2doX0JBU0VfSURYICAgICAgIDENCj4gPiAgI2RlZmluZSBt
bUdPTERFTl9UU0NfQ09VTlRfTE9XRVJfVmFuZ29naCAgICAgICAgICAgICAgICAweDAwMjYNCj4g
PiBAQCAtNzMxMyw2ICs3MzE4LDIyIEBAIHN0YXRpYyB1aW50NjRfdA0KPiBnZnhfdjEwXzBfZ2V0
X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICB1
aW50NjRfdCBjbG9jaywgY2xvY2tfbG8sIGNsb2NrX2hpLCBoaV9jaGVjazsNCj4gPg0KPiA+ICAg
ICBzd2l0Y2ggKGFkZXYtPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdKSB7DQo+ID4gKyAgIGNhc2Ug
SVBfVkVSU0lPTigxMCwgMSwgMyk6DQo+ID4gKyAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMSwgNCk6
DQo+ID4gKyAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+ID4gKyAgICAgICAgICAgY2xv
Y2tfaGkgPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLA0KPiBtbUdPTERFTl9UU0NfQ09V
TlRfVVBQRVJfQ3lhbl9Ta2lsbGZpc2gpOw0KPiA+ICsgICAgICAgICAgIGNsb2NrX2xvID0gUlJF
RzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwNCj4gbW1HT0xERU5fVFNDX0NPVU5UX0xPV0VSX0N5
YW5fU2tpbGxmaXNoKTsNCj4gPiArICAgICAgICAgICBoaV9jaGVjayA9IFJSRUczMl9TT0MxNV9O
T19LSVEoU01VSU8sIDAsDQo+IG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUl9DeWFuX1NraWxsZmlz
aCk7DQo+ID4gKyAgICAgICAgICAgLyogVGhlIFNNVUlPIFRTQyBjbG9jayBmcmVxdWVuY3kgaXMg
MTAwTUh6LCB3aGljaCBzZXRzIDMyLWJpdA0KPiBjYXJyeSBvdmVyDQo+ID4gKyAgICAgICAgICAg
ICogcm91Z2hseSBldmVyeSA0MiBzZWNvbmRzLg0KPiA+ICsgICAgICAgICAgICAqLw0KPiA+ICsg
ICAgICAgICAgIGlmIChoaV9jaGVjayAhPSBjbG9ja19oaSkgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgY2xvY2tfbG8gPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLA0KPiBtbUdPTERF
Tl9UU0NfQ09VTlRfTE9XRVJfQ3lhbl9Ta2lsbGZpc2gpOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgY2xvY2tfaGkgPSBoaV9jaGVjazsNCj4gPiArICAgICAgICAgICB9DQo+ID4gKyAgICAgICAg
ICAgcHJlZW1wdF9lbmFibGUoKTsNCj4gPiArICAgICAgICAgICBjbG9jayA9IGNsb2NrX2xvIHwg
KGNsb2NrX2hpIDw8IDMyVUxMKTsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiAgICAgY2Fz
ZSBJUF9WRVJTSU9OKDEwLCAzLCAxKToNCj4gPiAgICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAzLCAz
KToNCj4gPiAgICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAzLCA3KToNCj4gPiAtLQ0KPiA+IDIuMjUu
MQ0KPiA+DQo=
