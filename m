Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E474A858
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 03:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjGGBGF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 21:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGGBGE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 21:06:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D0172B
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 18:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKjwB76i2HR0cIsJkvDYE+0BXju1ieyHZ1wd/CoswGGdC5pu4mIr9ZPK7y2ksTtQ+VH4IHFazHf1Ix1q5EfGQEYuhk+JMvXvItj8zhvJ2oyjnKw9bH9rPm8d5n5Ec60/Kl4XEKW+E8phjMWB6gNu9kCWKi5SwLAY2nL/sJSSzERfreQdGnesm6cbUbVWZ+dMdF/6mcBkOZMb5yOLklAOU5wdPVGTq409sllN+E6UWHIWY117Hr5RohcSQeJ0EVZ8SxDJsbZaJMdbXH3mz/X+qz3FwW40X7D0J+6USEQ8tgx91VDlQvONqr0aTRNmzW4VjLlSa7RwtkqOgu5jBpBeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su0q0yJrLmEYOcAfFs43qOTCfSj8oia6znltwPXLywA=;
 b=W9qBcLIzGHkWLncdBAZbczOLLqMvgFxRQIwtq5O6Hy3REe1eEGbDyvNdkvklq2QONnvyN9+wRlKp4StOhTH21ZevI0BzaCgS+trx6PyD31y7uvVmKhsPHHNb45i7J/Si/gvkFldJ6QbOsOExqadXNUCMweOthlpwDO2E8cJGlE3GMtFtIBs0XPejLeyQmrb51/xIcOk0Bor3//0XR9NRN3Pk/d5fBd1TP6ZsgOlj3kSlrkP45S1mer9GmfUHPCD/KqK+tmLi095QttcCnuVsbwWmwFuseRz1eFotHeZ3NB7mfmdl0SXOGz4t4vllzq2leNiyF3yp0IB/cuN1ITWebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su0q0yJrLmEYOcAfFs43qOTCfSj8oia6znltwPXLywA=;
 b=k0kMa41DXXj2lbFwJ9Z1jM6ECs+oa6KF+0xktAYIUjR6nyD+JriH70LgglFB/7c91Bq8zn2zeGR8q9AVyxv4xUw1RQ9NC/RcSJZZLgJ7NrGUB49COw9OarYj7VTcZMNd9aubuhtgwUt2iR0OLgMp63IGqp0EWReU7GPFfWYQtdM=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 01:06:00 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::913:ccd7:a696:649b]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::913:ccd7:a696:649b%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 01:06:00 +0000
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
Thread-Index: AQHZr+Tk7yz8ghlwNU24Fqiqxuv8Lq+smSoAgADlOCA=
Date:   Fri, 7 Jul 2023 01:06:00 +0000
Message-ID: <BL0PR12MB2465AC1703A19921F923BCE0F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20230706083523.561741-1-guchun.chen@amd.com>
 <c2f4bf79-c41f-38b4-8843-28ad520f24a7@amd.com>
In-Reply-To: <c2f4bf79-c41f-38b4-8843-28ad520f24a7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b60e8a20-8af5-424c-a655-b91aeeca3c53;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T01:05:19Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|IA1PR12MB9063:EE_
x-ms-office365-filtering-correlation-id: 114b2f8a-da02-4bda-fa8a-08db7e865439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YG3GVqvTCPZtLyacjadepfDTTbOZi1INRQByJZga6GktFT0ApZKx5AQSkgnEKNHdKvW1twcjaye5Vi2akC7akzGKjHwiJAAFgR3eKy9ypg2HUCae3g+8jprc/7hTeNKHnYlT8hodbYwIPyG4KYFVOJexm2jPpzK7/0FdSkaspTKkdR+5jauReGao1mga4hQ7bA7SVsibFItcURhxrcSZGc+BhfB1p4vZUdi+Fu0N2c9U1XuAlBp5l31wNN4VDZWCQ3XwrrugsiEzWlyU4SZPY6JDSm1IzpuTKFKOuAYQRir960V8t+brLcGvEW1lm/kzoLB3QKmCqhZ9sDa7aEL4LAmd08ZZbZUr6kbp4DRD8JLWzO8GsaVFyWmY6il4fpXdQVi/mrVlp0bZBz+r91OhzZ5XZQGTYD1GcIHtDD7cA8iE/vf64OcnoSrDmdJysHjINAhI8LNsTXZkOrDXJRVXYIkC4yuzXDoX3mJdgbGBhyN1CXwl2viyj2XyxY5XY8RVwgKVWSkZcpN5uGpUSoaH3d9IerF08mjMDGliBRZiiKMLSgyXf9aMnYSCcrauGgih3RSbTFt/WppWTre/M9cW5u1mnEx1YxVHRmajqNWlR86Jsbz7j/HLpOTCJpDxMxgpBOgwPQVlo4vA8Si4mvHGTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(52536014)(66574015)(38100700002)(921005)(110136005)(76116006)(66946007)(26005)(6506007)(53546011)(83380400001)(478600001)(86362001)(38070700005)(66556008)(66476007)(64756008)(66446008)(6636002)(122000001)(4326008)(2906002)(5660300002)(7696005)(33656002)(8936002)(316002)(8676002)(71200400001)(186003)(9686003)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm9zKy9JYStieEVTTTg1SXJ5amZFK3J1ZjJBcFNZUHlldVNxa0FKN1ZYWUJL?=
 =?utf-8?B?YU5VYkt4YmJCNEZZNmNMNk5LOVB3UytHeTRGVGszdVJHSEhkZkF3VDhhUHEz?=
 =?utf-8?B?VUF6NlVBekVXdXJnTkx5cmRhS21tUHhEc2hmcUViemlhMitVSGVITGxxaXhS?=
 =?utf-8?B?STAwZUVKV2o5Ym9JRVhrdGh4OWsrelhMc1AvYUdoSDRoWWxrQjRPZmFhVnRW?=
 =?utf-8?B?TXBpV0pLS01vWkZHbkhSTjV0bzZqWnNhM0JtN0J1VldiRXZyYjRReVd0NE9u?=
 =?utf-8?B?dDcvUGx4UWhUd0FhY3VoNzVSSk5mblMyeHh1VTVEL2lsZTgxVVVYYjZqMHZx?=
 =?utf-8?B?anN1Vm1JcHpvOWZpazNpeUZBZVhWUTJtYzRYOTYwQ0h5VmVxQ0xxWEl1Y2pH?=
 =?utf-8?B?UVczNWpGczNnZ2RDNVlGQnZMR2s5MWRxUlV0RXBwZktWYXhjaWs1dEtlOFhN?=
 =?utf-8?B?R0ttTkxFRnV3YVpSWVhjNW1zTUorYmpSS1dXYzJZRWo5Vk1oVWRFTVp4eEM4?=
 =?utf-8?B?UkxmUWdMSDB2SWFnV2Jqc2VSZXJ5TllJNm9NRTRlMklaVFhQVlFXdlllN3lS?=
 =?utf-8?B?QnBEVDhyN0dpdVRpQ2ZCWWlmNWlEMGVHdk1icVVFRXpmQzFzQysrUjMrZmRk?=
 =?utf-8?B?WHNzckZLOWJLYmNNd2VNVG44cVJRekxBRDMyT2ZzZGI1bm9lMzBCMThOaXpl?=
 =?utf-8?B?SFBlbTJBSFdSdjkwbjJZTVgxaXJNL3l0RklBR0dqTmh0cjhhQXdGK2RSN2ti?=
 =?utf-8?B?MWUwV3Zsc0lwdERiMS9VMytzTHl2RFIrS1hsM2c0aTFNbW9zREwzSnRYWUVW?=
 =?utf-8?B?N1RNUFUxZ0RYSEZ5cktoSTZRWVpuOHVPbXpJR0R2a2hEYXgzVDRVVm1xbXZU?=
 =?utf-8?B?bUQ4MFZLd0VYa21SS1VZNWhWUUVXREdPZm8rdThkblBEWDVuSEt2Z0h2YXMv?=
 =?utf-8?B?TUJRN2trMHU4d056aEx5SDFTdnFUdXVMY1JFRkN1OVBBeEpKMURDUHBtcTVZ?=
 =?utf-8?B?N1gxdDc4R0w4amRYZm93ZXpMa3k2RFJ6cERqTEYrcnJTUGhpcnhMM242TkJS?=
 =?utf-8?B?dVBzRDU4ZWs1L00zV2FZZno3a2VLa056ZnRIMmZucU1vR25zSkx2NThLMEh0?=
 =?utf-8?B?M3FrOVZlWW1GVzBndERZbUJuSjZhdWQ5R2J4TDRxcW42dkY1ZVpsYkdVMVQr?=
 =?utf-8?B?YUhmdXZ3WW1OSzJDR3lkdVM3MGp5RFU4bkpoVWlBUHZ3cnhjRW0xRkYvNEJI?=
 =?utf-8?B?ZzJUaSthdFQ0TmRydUNyMEF3MGhyK2txNUI1aG9pVXZoOHc0R1l5UWlra1hm?=
 =?utf-8?B?SzRmS2R0WG1HQ29qVFJaS290WWR4azdmQVlsOXQybVRQRzQ0dVFPUFcxOTYr?=
 =?utf-8?B?VXZ2OTN0MmJaeFFDNFFQaDlySFJ3cC9BYlB0VFhST0drTEFYdEtZbFJrVzNj?=
 =?utf-8?B?elpLTXhUVG5yT0k2TG9hSTRvdE5xZkFJZmdGcUJ0ZFM4RDF6eURIdHVtMTVn?=
 =?utf-8?B?ZzlRWXZIZWdaMUxMWW1BM0ZTVzBHUlNYVTZPWjNoTGUycmFpbnYxRWptWS9U?=
 =?utf-8?B?YlgxQ2wxYmNuTW1SZnJNN09WWGp4TFpQVmIwcWZNREFwcU93Wk9Zaml0MHZZ?=
 =?utf-8?B?bE9reSsvR0pOdEpKb0tRNnlNY1lCMDJnMnVHYWUyTStHUVEwYlZVZ1UzaUxx?=
 =?utf-8?B?TWRGSlVxYXNaL3BiaEpUUG5pbVB5ZjRvUXBZQ2xITm83a3FGRWZNalUwR2pm?=
 =?utf-8?B?L0kwVlFuVVZRT0VJUW44dTVSTkY3eTZEQVJQdjdNcmhXbVA3TUhTYWtFTlk1?=
 =?utf-8?B?U2kySjd5bFkwc01tQXVsaTFGVEtiSHRNa2xrMkp1K05iU2NkZWFZN0l3U1o2?=
 =?utf-8?B?VmZrTDljZTEyNlNJaXlLT0lBcGZmZWZMUGdZMzBNQ29NL0U1Y2IxdStST25N?=
 =?utf-8?B?bVNFN2ZQdjkzb2lHZ09QMDRUSG9pRFl6WTJQa3lIWEgvUVV1dHlvdW5mUFpr?=
 =?utf-8?B?T3hrSU1kSzBDN0wzalA1VWZVVEk0dUNlTlpRUGdHeGRmVHFPNENBSXhodkwz?=
 =?utf-8?B?aDJYOXZEa1B3Mjl4bklDSFVaMDlCdVJtdjhnaFlUQTBVUEZreHUvZmtQY05l?=
 =?utf-8?Q?6QLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114b2f8a-da02-4bda-fa8a-08db7e865439
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 01:06:00.6361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvANqSnasUCtbu5VJqtKqb5jrO+yL7uyis6tHd0NJB8gzEs7jefx5jmbCyjXxvY4kQdsaRkvNjs0nsGuIiAv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSA2LCAyMDIzIDc6MjUgUE0NCj4gVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1k
LmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFu
ZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT47IE1pbGlua292aWMsIER1c2ljYQ0KPiA8RHVzaWNhLk1pbGlu
a292aWNAYW1kLmNvbT47IFByaWNhLCBOaWtvbGEgPE5pa29sYS5QcmljYUBhbWQuY29tPjsgQ3Vp
LA0KPiBGbG9yYSA8RmxvcmEuQ3VpQGFtZC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUvdmttczogcmVsYXggdGltZXIg
ZGVhY3RpdmF0aW9uIGJ5DQo+IGhydGltZXJfdHJ5X3RvX2NhbmNlbA0KPg0KPiBBbSAwNi4wNy4y
MyB1bSAxMDozNSBzY2hyaWViIEd1Y2h1biBDaGVuOg0KPiA+IEluIGJlbG93IHRob3VzYW5kcyBv
ZiBzY3JlZW4gcm90YXRpb24gbG9vcCB0ZXN0cyB3aXRoIHZpcnR1YWwgZGlzcGxheQ0KPiA+IGVu
YWJsZWQsIGEgQ1BVIGhhcmQgbG9ja3VwIGlzc3VlIG1heSBoYXBwZW4sIGxlYWRpbmcgc3lzdGVt
IHRvDQo+ID4gdW5yZXNwb25zaXZlIGFuZCBjcmFzaC4NCj4gPg0KPiA+IGRvIHsNCj4gPiAgICAg
eHJhbmRyIC0tb3V0cHV0IFZpcnR1YWwgLS1yb3RhdGUgaW52ZXJ0ZWQNCj4gPiAgICAgeHJhbmRy
IC0tb3V0cHV0IFZpcnR1YWwgLS1yb3RhdGUgcmlnaHQNCj4gPiAgICAgeHJhbmRyIC0tb3V0cHV0
IFZpcnR1YWwgLS1yb3RhdGUgbGVmdA0KPiA+ICAgICB4cmFuZHIgLS1vdXRwdXQgVmlydHVhbCAt
LXJvdGF0ZSBub3JtYWwgfSB3aGlsZSAoMSk7DQo+ID4NCj4gPiBOTUkgd2F0Y2hkb2c6IFdhdGNo
ZG9nIGRldGVjdGVkIGhhcmQgTE9DS1VQIG9uIGNwdSA0DQo+ID4NCj4gPiA/IGhydGltZXJfcnVu
X3NvZnRpcnErMHgxNDAvMHgxNDANCj4gPiA/IHN0b3JlX3ZibGFuaysweGUwLzB4ZTAgW2RybV0N
Cj4gPiBocnRpbWVyX2NhbmNlbCsweDE1LzB4MzANCj4gPiBhbWRncHVfdmttc19kaXNhYmxlX3Zi
bGFuaysweDE1LzB4MzAgW2FtZGdwdV0NCj4gPiBkcm1fdmJsYW5rX2Rpc2FibGVfYW5kX3NhdmUr
MHgxODUvMHgxZjAgW2RybV0NCj4gPiBkcm1fY3J0Y192Ymxhbmtfb2ZmKzB4MTU5LzB4NGMwIFtk
cm1dDQo+ID4gPyByZWNvcmRfcHJpbnRfdGV4dC5jb2xkKzB4MTEvMHgxMQ0KPiA+ID8gd2FpdF9m
b3JfY29tcGxldGlvbl90aW1lb3V0KzB4MjMyLzB4MjgwDQo+ID4gPyBkcm1fY3J0Y193YWl0X29u
ZV92YmxhbmsrMHg0MC8weDQwIFtkcm1dID8NCj4gPiBiaXRfd2FpdF9pb190aW1lb3V0KzB4ZTAv
MHhlMCA/DQo+ID4gd2FpdF9mb3JfY29tcGxldGlvbl9pbnRlcnJ1cHRpYmxlKzB4MWQ3LzB4MzIw
DQo+ID4gPyBtdXRleF91bmxvY2srMHg4MS8weGQwDQo+ID4gYW1kZ3B1X3ZrbXNfY3J0Y19hdG9t
aWNfZGlzYWJsZQ0KPiA+DQo+ID4gSXQncyBjYXVzZWQgYnkgYSBzdHVjayBpbiBsb2NrIGRlcGVu
ZGVuY3kgaW4gc3VjaCBzY2VuYXJpbyBvbg0KPiA+IGRpZmZlcmVudCBDUFVzLg0KPiA+DQo+ID4g
Q1BVMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENQVTINCj4g
PiBkcm1fY3J0Y192Ymxhbmtfb2ZmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHJ0aW1l
cl9pbnRlcnJ1cHQNCj4gPiAgICAgIGdyYWIgZXZlbnRfbG9jayAoaXJxIGRpc2FibGVkKSAgICAg
ICAgICAgICAgICAgICBfX2hydGltZXJfcnVuX3F1ZXVlcw0KPiA+ICAgICAgICAgIGdyYWIgdmJs
X2xvY2svdmJsYW5rX3RpbWVfYmxvY2sNCj4gYW1kZ3B1X3ZrbXNfdmJsYW5rX3NpbXVsYXRlDQo+
ID4gICAgICAgICAgICAgIGFtZGdwdV92a21zX2Rpc2FibGVfdmJsYW5rICAgICAgICAgICAgICAg
ICAgICAgICBkcm1faGFuZGxlX3ZibGFuaw0KPiA+ICAgICAgICAgICAgICAgICAgaHJ0aW1lcl9j
YW5jZWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdyYWIgZGV2LT5ldmVudF9s
b2NrDQo+ID4NCj4gPiBTbyBDUFUxIHN0dWNrcyBpbiBocnRpbWVyX2NhbmNlbCBhcyB0aW1lciBj
YWxsYmFjayBpcyBydW5uaW5nIGVuZGxlc3MNCj4gPiBvbiBjdXJyZW50IGNsb2NrIGJhc2UsIGFz
IHRoYXQgdGltZXIgcXVldWUgb24gQ1BVMiBoYXMgbm8gY2hhbmNlIHRvDQo+ID4gZmluaXNoIGl0
IGJlY2F1c2Ugb2YgZmFpbGluZyB0byBob2xkIHRoZSBsb2NrLiBTbyBOTUkgd2F0Y2hkb2cgd2ls
bA0KPiA+IHRocm93IHRoZSBlcnJvcnMgYWZ0ZXIgaXRzIHRocmVzaG9sZCwgYW5kIGFsbCBsYXRl
ciBDUFVzIGFyZQ0KPiBpbXBhY3RlZC9ibG9ja2VkLg0KPiA+DQo+ID4gU28gdXNlIGhydGltZXJf
dHJ5X3RvX2NhbmNlbCB0byBmaXggdGhpcywgYXMgZGlzYWJsZV92YmxhbmsgY2FsbGJhY2sNCj4g
PiBkb2VzIG5vdCBuZWVkIHRvIHdhaXQgdGhlIGhhbmRsZXIgdG8gZmluaXNoLiBBbmQgYWxzbyBp
dCdzIG5vdA0KPiA+IG5lY2Vzc2FyeSB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIGhydGlt
ZXJfdHJ5X3RvX2NhbmNlbCwgYmVjYXVzZQ0KPiA+IGV2ZW4gaWYgaXQncw0KPiA+IC0xIHdoaWNo
IG1lYW5zIGN1cnJlbnQgdGltZXIgY2FsbGJhY2sgaXMgcnVubmluZywgaXQgd2lsbCBiZQ0KPiA+
IHJlcHJvZ3JhbW1lZCBpbiBocnRpbWVyX3N0YXJ0IHdpdGggY2FsbGluZyBlbmFibGVfdmJsYW5r
IHRvIG1ha2UgaXQgd29ya3MuDQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiA+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMu
YyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92a21zLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21z
LmMNCj4gPiBpbmRleCA1M2ZmOTFmYzZjZjYuLjcwZmIwZGYwMzllMyAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KPiA+IEBAIC04MSw3ICs4MSw3
IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92a21zX2Rpc2FibGVfdmJsYW5rKHN0cnVjdA0KPiBkcm1f
Y3J0YyAqY3J0YykNCj4gPiAgIHsNCj4gPiAgICAgc3RydWN0IGFtZGdwdV9jcnRjICphbWRncHVf
Y3J0YyA9IHRvX2FtZGdwdV9jcnRjKGNydGMpOw0KPiA+DQo+ID4gLSAgIGhydGltZXJfY2FuY2Vs
KCZhbWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyKTsNCj4gPiArICAgaHJ0aW1lcl90cnlfdG9fY2Fu
Y2VsKCZhbWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyKTsNCj4NCj4gVGhhdCdzIGEgZmlyc3Qgc3Rl
cCwgYnV0IG5vdCBzdWZmaWNpZW50Lg0KPg0KPiBZb3UgYWxzbyBuZWVkIHRvIGNoYW5nZSB0aGUg
InJldHVybiBIUlRJTUVSX1JFU1RBUlQ7IiBpbg0KPiBhbWRncHVfdmttc192Ymxhbmtfc2ltdWxh
dGUoKSB0byBvbmx5IHJlLWFybSB0aGUgaW50ZXJydXB0IHdoZW4gaXQgaXMNCj4gZW5hYmxlZC4N
Cj4NCj4gRmluYWxseSBJIHN0cm9uZ2x5IHN1Z2dlc3QgdG8gaW1wbGVtZW50IGEgYW1kZ3B1X3Zr
bXNfZGVzdHJveSgpIGZ1bmN0aW9uIHRvDQo+IG1ha2Ugc3VyZSB0aGUgSFJUSU1FUiBpcyBwcm9w
ZXJseSBjbGVhbmVkIHVwLg0KDQpHb29kIHN1Z2dlc3Rpb24sIHdpbGwgZml4IGl0IGluIFYyLg0K
DQpSZWdhcmRzLA0KR3VjaHVuDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiAgIH0N
Cj4gPg0KPiA+ICAgc3RhdGljIGJvb2wgYW1kZ3B1X3ZrbXNfZ2V0X3ZibGFua190aW1lc3RhbXAo
c3RydWN0IGRybV9jcnRjICpjcnRjLA0KDQo=
