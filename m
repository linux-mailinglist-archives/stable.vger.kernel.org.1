Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8674CD44
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGJGkm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 02:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGJGkl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 02:40:41 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536ED8E
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 23:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDV7shoq3ayJuAMlGu/7CARCZTOcjlkGmRC8gy2f3ydj/tR5tn/kCeAknN5A/jlL18pu1YvX3/g/lAneRxSSaGOauTTNWM9ox+xp2GoUxp3Mi0dsZkHHaF74FehQp5QHvyLburBAcK2Itvb5s6z1b38f/I9HDXyT506kfLLOXX2JPGaWbG+ThH9Vqr9H3sGMhjAwCTFKwU1yUIFfCwmFrHuyiGyL7WpTmZ2tb150O6V/Mtip/HpG3+LlMKWwJFekTObzLXGOhOWffmPyqrcGD9jteHM9nnruPFrYygKD1eCvu5j7pN6ZPnnVBpg/CqH7wYbEBukWjWlJipYAzFwWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7WjUPoOf1Xm8GMhRVFjU3LabJRW+v2B6jG3q7P2Qmk=;
 b=ogsh1gVqBXk5IQY/ixkyyq9M6UPzyLJdlrpbhGmm7x8r2oM0e2GFKjvxE3dblIS0GCuj5gn+euSo4ZuLxl04H8JnE2u/GRRvEZ8UjlNQVMQ6v0Bv342RscsYRc+u4Ul4RCuF2yzallb6THlNTlxIhRiI0KNHe1pRAx6BSh0VYMReentHHUIrZRP5HoqYHkZxVHJaeGWXzOHVTMZSSp28hl3nLd1lohtALbfs7PmDXg1WHQrKD8LSt6Bct85mdDUu1KjohBZwg0bqtHjhxFB2QjsJRFDQlUrUzr8fghJZlKdajxD6XTeL/+zzQbByb6QSiT+VMlwVtKvhX38/em6ABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7WjUPoOf1Xm8GMhRVFjU3LabJRW+v2B6jG3q7P2Qmk=;
 b=HCrwAYM63odnIwRHOPhhcCO+mkIp+wX+Wlq5bWBoxzrHHyLAcoXLz9EhP37EUOEjSl5ncnx6efXsHdCoFRwMo00pAH1eMDgF3wB+BArq3C0w9Ex3j/Lg2NWZPd1pok2+oRU5pbVO0dwIHN7xK/YFvMVwmF1iXxPHKot3t6JU6ZI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 06:40:36 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 06:40:36 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
        "Prica, Nikola" <Nikola.Prica@amd.com>,
        "Cui, Flora" <Flora.Cui@amd.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Topic: [PATCH] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Index: AQHZr+Tk7yz8ghlwNU24Fqiqxuv8Lq+smSoAgADlOCCABRQksA==
Date:   Mon, 10 Jul 2023 06:40:35 +0000
Message-ID: <DM5PR12MB2469355DA1B91857933D217AF130A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230706083523.561741-1-guchun.chen@amd.com>
 <c2f4bf79-c41f-38b4-8843-28ad520f24a7@amd.com>
 <BL0PR12MB2465AC1703A19921F923BCE0F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2465AC1703A19921F923BCE0F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b60e8a20-8af5-424c-a655-b91aeeca3c53;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T01:05:19Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SA1PR12MB6870:EE_
x-ms-office365-filtering-correlation-id: 39492007-85a4-4c2e-f9bc-08db81109100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCcgWyImtr6kIPAoEdJMJQ3oELQR9dd+RBoXku1YAy3U+2h90Q61vNsVxb7Bzwwb/uHy537io70/w25XdPGQ3WP0yG5byTnobgJ5y/KiQGIAI4/oiKD34z+EhqmErfACiwJFwcNnpudli5a8qUwuRCaEhnyU5U3oqRmWUJf3pEUJryS44tHvL7mP8uRKJAFckVioeI3GZH3bDFfqfluq4Jv1iCr+/9mAMahSi3tGw66OGqmPx8mLjYkCQ6nILptscIESmYmrtcDCddTciGLGk2ArIYQq5sQGi+NZ3IVfJZaQWNQFMWdx/gQ6ARGqA7fRLZoI1a3kYxCaQZS4AbgOQY8WRM6lINyUvO2tF8dquS3qj6yskUHzJClVGHwERtQ3eytCHhPj2gM4UIyVFuwXXFhba7EXnRXpVbAuMoFe/NzYxoRATYw4FeEWVhm0SArxHhxrH9QZ9ByXPwQtN4iwHIYKK8nRHLiwKoP3BS78JAt1gvkN7u4FxXftx4tVr5H3JIg5AK0m8K7/zW3IKV1krJA51UA8iZvY5/tGwou50fzA8d4hcu5pRqVapcQ+9F8nKW81zDnzdLgw4Zs0R7X6vUHwrCY7RQtMqnyRvucrIv8id3ixbDNoy8NMyhAfvTWALYWR4tXqBcGe4eeHyEJcyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(186003)(53546011)(26005)(6506007)(41300700001)(9686003)(66574015)(83380400001)(7696005)(478600001)(921005)(122000001)(110136005)(71200400001)(6636002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(55016003)(38100700002)(316002)(8936002)(86362001)(33656002)(38070700005)(5660300002)(52536014)(8676002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3ducmFzWlhJVU5hZ2JUNjd5cVB5L0loZk1GWWpIUGluZmNSbEVNWGtGM0Y2?=
 =?utf-8?B?M3czOXIvUUw1SVkrUEhReFQzcU00M29hYldsbWZVQ09YalQydnZscHh6MzBr?=
 =?utf-8?B?ZWl4SGRNZHU0V05zZUgxZkxUamRzR1YxOFFjTG5lRnF0d3UyRWZrR1o3cjRy?=
 =?utf-8?B?U0FCL01yNmlSdDR3TFBpTXJncXNCSitRVy9rUmRpYlllNHpubU13bngzQ3NW?=
 =?utf-8?B?ZG16OU9FTDM0c2hsRkFvN3g4elgrbmZndjVMR2FpWjJQWHh6QlhMTXRCb1VP?=
 =?utf-8?B?NEcvMnhTVndJdHpPNVhyY0trUFBHbGxyMEIxUlh5WjJDc2hMV05ucDE5aEJ3?=
 =?utf-8?B?YlkxK2ZMN2RPTkJraUZWVVZxL2k3VUs1anZEanFSVjg0Vmp2cFdpWmRPS1ZU?=
 =?utf-8?B?ZHBXM044SUE4Zm15dnBkcTNWcHF5bjFmUG4xQnNSVkEzcE1ENE55QXEwMXFF?=
 =?utf-8?B?SW82aS93Ri9ka29VekZkWFBPWTB0bnRURytjLzdIYUFzbTF1RlB3TDlwY1N2?=
 =?utf-8?B?TVlRNU5JY1VXeVdjTFIyc293OThmekdQUzlQOGJpRTV5UEI5YXA4NFQ0Z3N6?=
 =?utf-8?B?Q1JtK0FjNWN5dWVSdnBweTBUWDErb21zREZGUG1YOHh3blRKM3FhZDRSTWZn?=
 =?utf-8?B?Z05mMWdGN3pvVzlUWGVoSVphQzRFZG1Kd0x6WjlzRVJVKy9lRi9oUlpVNnRq?=
 =?utf-8?B?dVRqT2Q2OVM4eGNENDM3eWNOSU1SejhpemduTVpmN3V0M01CWVVONDcxaUxX?=
 =?utf-8?B?SkJ5Z21yM0NjbkY1b01nV3M4RjlocE1tb3EwcktGd1Z5bXZDOUh5b2tNQmJF?=
 =?utf-8?B?TW41RENISFZCZmZMaC9RdldkMENmaUVPb0dBaUN3VGNJd2FWUkdDamhVV0k2?=
 =?utf-8?B?b2RraGVmY0Y0N1NxdWRNVlRNSm5GUGNZaU5CTVFZV0MvMlRPRHpFYWFhRGRG?=
 =?utf-8?B?enUzU2VEUGF3cWdXQ2JJaDdFSmpYY0pJQ1h6WVJIL25GTk0xMzkvQU1jR3RN?=
 =?utf-8?B?UzROZUlOZFRBNzhwKzg0akJCZFp4bDNWeWludWg3NkIyZVRzY2hkckw2OE1R?=
 =?utf-8?B?N2NpWXNmYmQrVHFXYmFRTkU3dmVCTlJHb210Sm9jTUFXUUNEZ1NCWkwzd3hj?=
 =?utf-8?B?ZzBHb2pHWUE1dElmYnZ0Qk9XeXg3dDNUWmkvSk85YWFSeXlHOVM4YzVpTGlh?=
 =?utf-8?B?NUU5K1dRWHRTRmpXc1ZTMjNYekZCdndtKzVUK0tqaVNiMit5NVhpUnkybWZQ?=
 =?utf-8?B?OGlrVzBqczFuMmFUbjgxRkUrbVJ4YkhrdjhoakVxK0l6bDNnOEwrMzZveGVW?=
 =?utf-8?B?dTlmZEQwYWVTZS9ZYnZPOENXWHRPN0hmQW9ZRUp5TzlZNEhpMmlGbkhJUndE?=
 =?utf-8?B?Ym5IM0RGeDY1bDdmRWROREpvdDlHeFg2RldSTFYvaWJKNWUzOHRUU2lQMXFi?=
 =?utf-8?B?c1NEYUpSMkRWY1ovVFVZZGFuZHlBbjZuNjdYVDg4cVV3NHkyRXRiNnlJbm8y?=
 =?utf-8?B?ZXNaeHRVNFZBR0hzNkszUlUrTDhSamswanBIMkh2cGoxUjJYbkRGNmVweTlJ?=
 =?utf-8?B?Slg2RmhPM0hqb2EzSTI4WDlpUlBKNU9OUjlmSy9jSzd6R05KazFabjdENFhP?=
 =?utf-8?B?YTRUSEtLcEtiOXExaGxua3FqV2RnNXNQK25laVZLbkUzbnhxaldKbGptUVJ2?=
 =?utf-8?B?QWhiZCszbEM0dVpINHlkNjMwZXNxZm5MTjljMDhlNUYxR2ZHbEJkWHBEMFQ2?=
 =?utf-8?B?SGRjUWdGQlo1dDVISmV1WHcyU3ZacVZtZlUxY0hXdFZPSllFeXpieXo2VlNC?=
 =?utf-8?B?VUFCSDlvOC9JdnQ4OVZDM1FDaXh5OXBFZXNwZFJUam5wdmdUdTRHdW1ienpp?=
 =?utf-8?B?SnpaSkpLcDRHa2o1WXl5ODRPbjZlcjZDWkxjaVZwbW1LVnNvbVVhaVNQRWUw?=
 =?utf-8?B?MGxNMGFuK1U2V0Z4QlJOajBKUFcxZmpEQVp4UDcrdW9LVTdhOXBOd0Y5bG94?=
 =?utf-8?B?UTZ2dGYvZ1MzWEtiNXdjc3NQLzl6RDQrWmpVOHFDTUhJclVyWUFWWDY0TWEx?=
 =?utf-8?B?YXAzaXZ4RlgwTjQxL1pwbm1Kc1BkZ1BDdnJMdGVzTEtPeVNUZU5CYUNjT3Yr?=
 =?utf-8?Q?Xjxw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39492007-85a4-4c2e-f9bc-08db81109100
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 06:40:35.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLFL/c8Noncf15olQPlpwxs+rTb5XgEzwEmFHxEWoky26zCobabhlCrLJTnBR1jotN4f4OXDN7xwPfnCM6oJfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuLCBH
dWNodW4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDcsIDIwMjMgOTowNiBBTQ0KPiBUbzogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IE1p
bGlua292aWMsIER1c2ljYQ0KPiA8RHVzaWNhLk1pbGlua292aWNAYW1kLmNvbT47IFByaWNhLCBO
aWtvbGEgPE5pa29sYS5QcmljYUBhbWQuY29tPjsgQ3VpLA0KPiBGbG9yYSA8RmxvcmEuQ3VpQGFt
ZC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0hdIGRybS9hbWRncHUvdmttczogcmVsYXggdGltZXIgZGVhY3RpdmF0aW9uIGJ5DQo+IGhydGlt
ZXJfdHJ5X3RvX2NhbmNlbA0KPg0KPg0KPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gPiBTZW50OiBUaHVyc2RheSwgSnVseSA2LCAyMDIzIDc6MjUgUE0NCj4gPiBUbzogQ2hlbiwg
R3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLQ0KPiA+IGdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47DQo+ID4gTWls
aW5rb3ZpYywgRHVzaWNhIDxEdXNpY2EuTWlsaW5rb3ZpY0BhbWQuY29tPjsgUHJpY2EsIE5pa29s
YQ0KPiA+IDxOaWtvbGEuUHJpY2FAYW1kLmNvbT47IEN1aSwgRmxvcmEgPEZsb3JhLkN1aUBhbWQu
Y29tPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdS92a21zOiByZWxheCB0aW1lciBkZWFjdGl2YXRpb24gYnkNCj4gPiBo
cnRpbWVyX3RyeV90b19jYW5jZWwNCj4gPg0KPiA+IEFtIDA2LjA3LjIzIHVtIDEwOjM1IHNjaHJp
ZWIgR3VjaHVuIENoZW46DQo+ID4gPiBJbiBiZWxvdyB0aG91c2FuZHMgb2Ygc2NyZWVuIHJvdGF0
aW9uIGxvb3AgdGVzdHMgd2l0aCB2aXJ0dWFsDQo+ID4gPiBkaXNwbGF5IGVuYWJsZWQsIGEgQ1BV
IGhhcmQgbG9ja3VwIGlzc3VlIG1heSBoYXBwZW4sIGxlYWRpbmcgc3lzdGVtDQo+ID4gPiB0byB1
bnJlc3BvbnNpdmUgYW5kIGNyYXNoLg0KPiA+ID4NCj4gPiA+IGRvIHsNCj4gPiA+ICAgeHJhbmRy
IC0tb3V0cHV0IFZpcnR1YWwgLS1yb3RhdGUgaW52ZXJ0ZWQNCj4gPiA+ICAgeHJhbmRyIC0tb3V0
cHV0IFZpcnR1YWwgLS1yb3RhdGUgcmlnaHQNCj4gPiA+ICAgeHJhbmRyIC0tb3V0cHV0IFZpcnR1
YWwgLS1yb3RhdGUgbGVmdA0KPiA+ID4gICB4cmFuZHIgLS1vdXRwdXQgVmlydHVhbCAtLXJvdGF0
ZSBub3JtYWwgfSB3aGlsZSAoMSk7DQo+ID4gPg0KPiA+ID4gTk1JIHdhdGNoZG9nOiBXYXRjaGRv
ZyBkZXRlY3RlZCBoYXJkIExPQ0tVUCBvbiBjcHUgNA0KPiA+ID4NCj4gPiA+ID8gaHJ0aW1lcl9y
dW5fc29mdGlycSsweDE0MC8weDE0MA0KPiA+ID4gPyBzdG9yZV92YmxhbmsrMHhlMC8weGUwIFtk
cm1dDQo+ID4gPiBocnRpbWVyX2NhbmNlbCsweDE1LzB4MzANCj4gPiA+IGFtZGdwdV92a21zX2Rp
c2FibGVfdmJsYW5rKzB4MTUvMHgzMCBbYW1kZ3B1XQ0KPiA+ID4gZHJtX3ZibGFua19kaXNhYmxl
X2FuZF9zYXZlKzB4MTg1LzB4MWYwIFtkcm1dDQo+ID4gPiBkcm1fY3J0Y192Ymxhbmtfb2ZmKzB4
MTU5LzB4NGMwIFtkcm1dID8NCj4gPiA+IHJlY29yZF9wcmludF90ZXh0LmNvbGQrMHgxMS8weDEx
ID8NCj4gPiA+IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCsweDIzMi8weDI4MA0KPiA+ID4g
PyBkcm1fY3J0Y193YWl0X29uZV92YmxhbmsrMHg0MC8weDQwIFtkcm1dID8NCj4gPiA+IGJpdF93
YWl0X2lvX3RpbWVvdXQrMHhlMC8weGUwID8NCj4gPiA+IHdhaXRfZm9yX2NvbXBsZXRpb25faW50
ZXJydXB0aWJsZSsweDFkNy8weDMyMA0KPiA+ID4gPyBtdXRleF91bmxvY2srMHg4MS8weGQwDQo+
ID4gPiBhbWRncHVfdmttc19jcnRjX2F0b21pY19kaXNhYmxlDQo+ID4gPg0KPiA+ID4gSXQncyBj
YXVzZWQgYnkgYSBzdHVjayBpbiBsb2NrIGRlcGVuZGVuY3kgaW4gc3VjaCBzY2VuYXJpbyBvbg0K
PiA+ID4gZGlmZmVyZW50IENQVXMuDQo+ID4gPg0KPiA+ID4gQ1BVMSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTINCj4gPiA+IGRybV9jcnRjX3ZibGFua19v
ZmYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBocnRpbWVyX2ludGVycnVwdA0KPiA+ID4g
ICAgICBncmFiIGV2ZW50X2xvY2sgKGlycSBkaXNhYmxlZCkgICAgICAgICAgICAgICAgICAgX19o
cnRpbWVyX3J1bl9xdWV1ZXMNCj4gPiA+ICAgICAgICAgIGdyYWIgdmJsX2xvY2svdmJsYW5rX3Rp
bWVfYmxvY2sNCj4gPiBhbWRncHVfdmttc192Ymxhbmtfc2ltdWxhdGUNCj4gPiA+ICAgICAgICAg
ICAgICBhbWRncHVfdmttc19kaXNhYmxlX3ZibGFuayAgICAgICAgICAgICAgICAgICAgICAgZHJt
X2hhbmRsZV92YmxhbmsNCj4gPiA+ICAgICAgICAgICAgICAgICAgaHJ0aW1lcl9jYW5jZWwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdyYWIgZGV2LT5ldmVudF9sb2NrDQo+ID4g
Pg0KPiA+ID4gU28gQ1BVMSBzdHVja3MgaW4gaHJ0aW1lcl9jYW5jZWwgYXMgdGltZXIgY2FsbGJh
Y2sgaXMgcnVubmluZw0KPiA+ID4gZW5kbGVzcyBvbiBjdXJyZW50IGNsb2NrIGJhc2UsIGFzIHRo
YXQgdGltZXIgcXVldWUgb24gQ1BVMiBoYXMgbm8NCj4gPiA+IGNoYW5jZSB0byBmaW5pc2ggaXQg
YmVjYXVzZSBvZiBmYWlsaW5nIHRvIGhvbGQgdGhlIGxvY2suIFNvIE5NSQ0KPiA+ID4gd2F0Y2hk
b2cgd2lsbCB0aHJvdyB0aGUgZXJyb3JzIGFmdGVyIGl0cyB0aHJlc2hvbGQsIGFuZCBhbGwgbGF0
ZXINCj4gPiA+IENQVXMgYXJlDQo+ID4gaW1wYWN0ZWQvYmxvY2tlZC4NCj4gPiA+DQo+ID4gPiBT
byB1c2UgaHJ0aW1lcl90cnlfdG9fY2FuY2VsIHRvIGZpeCB0aGlzLCBhcyBkaXNhYmxlX3ZibGFu
ayBjYWxsYmFjaw0KPiA+ID4gZG9lcyBub3QgbmVlZCB0byB3YWl0IHRoZSBoYW5kbGVyIHRvIGZp
bmlzaC4gQW5kIGFsc28gaXQncyBub3QNCj4gPiA+IG5lY2Vzc2FyeSB0byBjaGVjayB0aGUgcmV0
dXJuIHZhbHVlIG9mIGhydGltZXJfdHJ5X3RvX2NhbmNlbCwNCj4gPiA+IGJlY2F1c2UgZXZlbiBp
ZiBpdCdzDQo+ID4gPiAtMSB3aGljaCBtZWFucyBjdXJyZW50IHRpbWVyIGNhbGxiYWNrIGlzIHJ1
bm5pbmcsIGl0IHdpbGwgYmUNCj4gPiA+IHJlcHJvZ3JhbW1lZCBpbiBocnRpbWVyX3N0YXJ0IHdp
dGggY2FsbGluZyBlbmFibGVfdmJsYW5rIHRvIG1ha2UgaXQNCj4gd29ya3MuDQo+ID4gPg0KPiA+
ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYyB8IDIgKy0NCj4gPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmMN
Cj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KPiA+ID4g
aW5kZXggNTNmZjkxZmM2Y2Y2Li43MGZiMGRmMDM5ZTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gPiBAQCAtODEsNyArODEsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfdmttc19kaXNhYmxlX3ZibGFuayhzdHJ1Y3QNCj4gPiBkcm1f
Y3J0YyAqY3J0YykNCj4gPiA+ICAgew0KPiA+ID4gICAgICAgICAgIHN0cnVjdCBhbWRncHVfY3J0
YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsNCj4gPiA+DQo+ID4gPiAtIGhy
dGltZXJfY2FuY2VsKCZhbWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyKTsNCj4gPiA+ICsgaHJ0aW1l
cl90cnlfdG9fY2FuY2VsKCZhbWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyKTsNCj4gPg0KPiA+IFRo
YXQncyBhIGZpcnN0IHN0ZXAsIGJ1dCBub3Qgc3VmZmljaWVudC4NCj4gPg0KPiA+IFlvdSBhbHNv
IG5lZWQgdG8gY2hhbmdlIHRoZSAicmV0dXJuIEhSVElNRVJfUkVTVEFSVDsiIGluDQo+ID4gYW1k
Z3B1X3ZrbXNfdmJsYW5rX3NpbXVsYXRlKCkgdG8gb25seSByZS1hcm0gdGhlIGludGVycnVwdCB3
aGVuIGl0IGlzDQo+ID4gZW5hYmxlZC4NCj4gPg0KPiA+IEZpbmFsbHkgSSBzdHJvbmdseSBzdWdn
ZXN0IHRvIGltcGxlbWVudCBhIGFtZGdwdV92a21zX2Rlc3Ryb3koKQ0KPiA+IGZ1bmN0aW9uIHRv
IG1ha2Ugc3VyZSB0aGUgSFJUSU1FUiBpcyBwcm9wZXJseSBjbGVhbmVkIHVwLg0KPg0KPiBHb29k
IHN1Z2dlc3Rpb24sIHdpbGwgZml4IGl0IGluIFYyLg0KPg0KSGkgQ2hyaXN0aWFuLA0KDQpJIGp1
c3Qgc2VudCBvdXQgcGF0Y2ggdjIgdG8gYWRkcmVzcyB0aGUgcmV0dXJuIHZhbHVlIHByb2JsZW0g
aW4gYW1kZ3B1X3ZrbXNfdmJsYW5rX3NpbXVsYXRlLg0KDQpSZWdhcmRpbmcgSFJUSU1FUiBjbGVh
bnVwLCBpdCdzIGhhbmRsZWQgaW4gc3dfZmluaSBpbiBhbWRncHVfdmttcyBjb2RlLCBJIHRoaW5r
IHNvIGZhciBpdCdzIGdvb2QuIEFueXdheSwgd2UgY2FuIGNvbnRpbnVlIHRoZSBkaXNjdXNzaW9u
IGluIHRoZSBuZXcgcGF0Y2ggc2V0IHRocmVhZC4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KPiBSZWdh
cmRzLA0KPiBHdWNodW4NCj4gPiBSZWdhcmRzLA0KPiA+IENocmlzdGlhbi4NCj4gPg0KPiA+ID4g
ICB9DQo+ID4gPg0KPiA+ID4gICBzdGF0aWMgYm9vbCBhbWRncHVfdmttc19nZXRfdmJsYW5rX3Rp
bWVzdGFtcChzdHJ1Y3QgZHJtX2NydGMNCj4gPiA+ICpjcnRjLA0KDQo=
