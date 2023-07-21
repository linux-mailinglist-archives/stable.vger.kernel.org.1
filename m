Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAE75C72A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGUMvc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUMvb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:51:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053510D2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0VZSL+k28NG6nV3VxLS9Pix289kr3j4MShoACIDnAiWbVl0+DZhEonat0fCIQHaW6ij7LWApV2cHsZ3NT6Ugz92tePSz9582GaHiJnnQRM4KSINtCzmhFF5Xv3RWJJwypXGsxMhvEY5/og4Ls2oikkeaVNLwL9KZp0HH8phTiNVFMfXCQradtKyDquuBO4y3ABRicJVVWKwxHaWYqvmfUAiAucDhNFPxZsQmG6BFVRdX+iH91sC5jSy+yDe4s8aND0UmwBsasPBXpyhbJ6bkuP049pMTTOpSuvEfL6KU9iLZ5dqxpvldhLePe0LuSfPStCoocoM3Bu3dYc9M+mogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrRobJwT4hLNaEagFBbdYn3kS3daQBXtk3xi+SYwBhU=;
 b=JregZAB6vRafz75rf0iAr3nnpNJ9B2XG1sbvMbrB8TQfo3NjVqSURsWh9kilCR9GUgnRgCADSB3jXITCzVIjdvr7imcZk8Fh9W2i52FdvcTFuy15bUik1Q6C1r5mzVfro74UBctMB20Xw6ZiUWIBVKuwIg28++CtKdMfdt+DdP0e5tFE9CCwPuFYC6y74a3eprAu45ND4Oc/LFRcU+OiuNcBS0YysMX5BLVFmxM0p+2/8MwYrpUMRTfPPphrA/IZ8BFq9Zc48RJ2Jl1Zo0rUbOvzURJw3vVc03cc8QonC3zhXF9BWcW2AkoxOGBGHFHjoemcTfd/1/uzmXH2kAbXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrRobJwT4hLNaEagFBbdYn3kS3daQBXtk3xi+SYwBhU=;
 b=iMcvLwoJlEG87MxuZiS078U4PZH+GwIBuqwCnkbfbXSo9La6YnEBVFPrRc5/3pT4TkpyQ2AvskUzsTAh04ww5UVOiIMnmtgUckanfmGr52eIZIsbHPH0OQeU1xMP6dkbOENhTnYKaOOfLwkuapX96f5Cd0uOCBDLA3Vk5XBHZwE=
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 12:51:27 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::81dd:ae36:d1e2:9a4]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::81dd:ae36:d1e2:9a4%7]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 12:51:27 +0000
From:   "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Thread-Index: AQHZu83Ly/3OdGNWUU6qsG/Om4ezUK/EK8nA
Date:   Fri, 21 Jul 2023 12:51:26 +0000
Message-ID: <BL0PR12MB2532C071AA71F63C61113B42ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <2023072146-sports-deluge-22a1@gregkh>
In-Reply-To: <2023072146-sports-deluge-22a1@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=770bb508-edae-43d6-9e28-c043809cdd6f;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-21T12:49:48Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2532:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 4e4d26cc-ce0e-43c3-bf30-08db89e9326f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xjyI6AzeC40W8DDzmpmYFQ6eR2buKfc77UF+4+lhU9bmhafVJ2jm/mxxekhSszk624J9dIPoA3cae4Z7B7Wb3hXB7GKDdNpa8BoN5YIzJFWp8z1x8KhYWzukeAU2pNNPqEo3AdufuhCHGs7lgSdAG8H5dCquot/y8Glr5/YPBsv1k3gMqmLvSuLEU8foVCF2gIvATGe/vxEYGbAu5CmEhCyutG2FWShTmCE6f+bFrNYxmeirguammZdgp3STfuuquemkwcbzEPvxwsv2fsP26exkIRvmg4ssKcrSEEWxZ5Nk3iL618ANzKZr9SWJZDB6e8H9lPJ+Rt4ViO0nAcjYWY0bf3Q4JBNd1F+A70GgyPSHORYwE3Ruz/fhRTUMfKR+Thqb1kiPt9I9Et6awNbeij+U8bqvzawquhI3qnt2r7CduZBeSjht8fS83odl8Ft0EzQoSnt81k1akwiopAHBrLZ8CRFm0QTP1ds8ZKEhjbnNfwyn0R4vZGdYZg83Y+cvX01+W0UNX7JWBlI9lPKm8/sew3zS3JFGGxVY3F8KTXlTfWLKcHyV6l05PY1VHJ6Vp1zQhwpSxXhoYpSb0uJxIqAIr7cDKqhpyTkHMFKrLf90y37hhf6/NZuvFklFsKRNvaxqgEhQUi5YJfNBeG19w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(53546011)(54906003)(478600001)(7696005)(9686003)(55016003)(966005)(122000001)(6506007)(26005)(186003)(86362001)(71200400001)(6916009)(64756008)(66446008)(66946007)(66556008)(76116006)(66476007)(316002)(4326008)(8936002)(52536014)(38100700002)(8676002)(38070700005)(5660300002)(2906002)(41300700001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1lQaCtJNkZ0bTVrbzNiMGdmVTdJMFBjdzFGSlp5NXcxNXJsSnR3bWs1TjNL?=
 =?utf-8?B?YW5qV21qZUp3OXozdFRMajF0UWF3di9LelRBUU5jeDVzQTNPWkpsb2ZtWHVO?=
 =?utf-8?B?d2dmcy9xWkE1cE52VGpSdWtHNDN4MW1mMmsyNVhwUlVXVmV4RElQYWk3L29F?=
 =?utf-8?B?Rm9xbTFRbS9OTVppMjZ5VjFCVzZsUldYQ0xNa2RyMUZxUTFPYUN5WVJvYUFJ?=
 =?utf-8?B?RDBBeTIzK2RLTGRlT3RQUHpyY3FVcENkQjU3OTNWanZWa2RpUWZBcEEwUzJF?=
 =?utf-8?B?bTY2cHAvM3pnQmFzZFdXT3g2QkpJR3BmTndNZVdnRUNnMlBUajJvakFzeFFS?=
 =?utf-8?B?WGhnc1N5U2F2ZlhWTE9OTkkvS21RMCtndEZ6bjdaNVZrOVJlQ2pLSUZaMmpB?=
 =?utf-8?B?UzQ5cEhMNzdtZU5qb2hucUVsQUViRDBzS0s1bTA1ZmVjejdLbFpEUTlVWGRT?=
 =?utf-8?B?cXNwMmpLN2xFVVlKVkxqdW1iSER0M1ExUlBQSy9Lbkl1aFZCMG9mMFR2SHk0?=
 =?utf-8?B?TzFHSEtiSDg2UGNKMk9tVlFYWS9yVTVvUjkzWXRsb3FPbmZiT09UdkZ4b2R4?=
 =?utf-8?B?bEpBK3VXNlNpY0hzdndmcmgrOWN3ZmNxZHVrMkFDbncxTE9iY2ttUUtuenh4?=
 =?utf-8?B?YXhhVjVLYWRWRHIxa1ZYaklQVEpyelZNR05PWVV6V1BrdDRYMCtlbGdQRzZC?=
 =?utf-8?B?ZEdPV2dsYVI4bXp0Vll0VUFDU29YaE1HNW55cW5OV2dxUzhWVVlIRXZPM3M1?=
 =?utf-8?B?WE02dVNyWlNPZXF6WnFqRG02Q05hcWNvVUQvQXhVSkFxNElxT2JPR1l4YzFy?=
 =?utf-8?B?aHJ5VGR1WE5LTE90MVVwUmlPaHU0L0NPQ2RXcmdxUjVFVFU4b0dleW5WN0lZ?=
 =?utf-8?B?RzZ5NGkrdXdzcXlRREJaRzdJblYzcThINzZHTFBweERBVEN1MzFoT3h4c3J3?=
 =?utf-8?B?UlZaWjZ5OFZWK0ZyUzMwV1R4ODlZV3JBUVgzbDkzN3FiUm4wbnJmMHVNTFVm?=
 =?utf-8?B?WGN4OFBDUlRXclAzei9EU2dkeERFaTFQL3ZjVWlnSHJEeHBCOHlsR1kvcUI0?=
 =?utf-8?B?U1BuTHV1R1BQRHBNT1JqL1JnWXpqNytiTm1pMFhEOVZHRVNXbnNmVWZEMU52?=
 =?utf-8?B?YWQrbnRFSHJpSWptQjhmSzJpTEJGa2dmVUl6cHpzVGZ4MmpDQTV3UWdBTUl0?=
 =?utf-8?B?cFhsS0lsRElTakNIL1BsbWVab1dTcG9JTHdYZmhXTk85WWd6K2lIUHkxUEc1?=
 =?utf-8?B?dEV0anRUZFM2WFE1ZE1YYkJnSlRPN01zaTdXSEdsQTM3OWVMcXhzTjJjNDQ0?=
 =?utf-8?B?alUydU1IcEhpTVNTcWVmQlVXRlpyZjh3NWNyeXJTU0p1c1RpZUVhK2F5M3BW?=
 =?utf-8?B?Nk10ay9TbXU1N1lVUVliVjQyTzBvK01QV0tJWWNzb0drM3hnYStuWGdseEcz?=
 =?utf-8?B?M3RNQlE0M2p1dUd2WGJWYnBtZHEzOWlWVmgyWVVUczc5MzlJNHUwdmh6NnJ4?=
 =?utf-8?B?Qi9zanJhcFltZG5aalpoRGgxcDVmVk42MXZoQWVySmx6aURnRE95S2xUTHZV?=
 =?utf-8?B?MFQwYlVnSGs0T2Q0aUg5TlVoRlhXbCtXZmhqdGxvaFBGZGt0UW5mcFQ5VnZz?=
 =?utf-8?B?V1hXeDY5WUpZc241SS8vdy9Ob1g4eUFCZHVLOW9DWmNEanlZRzFJa3V1Rjgy?=
 =?utf-8?B?ZkpOSkVpRko4ckZLczhTSzhhUldoL29QL1pnelQ1MGtrZ1o1cXpXa1NpSjRu?=
 =?utf-8?B?WCtCcFErYS9sV2tsVHpHM3UrdWY5bWQzUVh5Y3JOdjh3MWpnQllmemR0OU1k?=
 =?utf-8?B?UC8zRnlNZkc4elhCcGhtSkhNS1gveHh0ZGgxRGZEOUF0eGR2cENNWlZCWGRH?=
 =?utf-8?B?NU9Qc1NDd25iTFpOdkMvLzBWQ0hiNmQ5V0c1TlJQdnVHNW52R2gydmZmU2lt?=
 =?utf-8?B?SlljM2lxN3FnYVpOQ2lyNjQ2TmtKOHNNcy9FTWJVV3B4cXlIblhaV1VZMGo0?=
 =?utf-8?B?M2RKVjA0WW45SzBYblVZVXk1MjljN1NLSEdYaURYM2dXZkhhQWgzYWwxeDBq?=
 =?utf-8?B?TzUyRUpyblN0NFI5aDdKS0ZrdXNRN3pyRzVBcW1oYXlPM2RRNjd6dWdSeS9R?=
 =?utf-8?Q?sM2M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4d26cc-ce0e-43c3-bf30-08db89e9326f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 12:51:26.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVG/+NVkgUxKyTXeJRfNOtIXPQzei55CXOZDvOb4cKR6+ozxCjnq0r/cAjbHXVajmi2LABDVL0y2vYyKyCApGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W1B1YmxpY10NCg0KSGkgR3JlZywNCg0KSSB0cmllZCB0aGlzIG91dCBvbiBteSBzaWRlLCBhbmQg
aXQgc2VlbXMgdG8gYXBwbHkgY2xlYW5seSwgdGhlIHNhbWUgZ29lcyBmb3IgdGhlIDYuMS55IGJy
YW5jaC4NCmdpdCBmZXRjaCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9zdGFibGUvbGludXguZ2l0LyBsaW51eC02LjQueSBnaXQgY2hlY2tvdXQgRkVUQ0hf
SEVBRCBnaXQgY2hlcnJ5LXBpY2sgLXggNDQ4MTkxMzYwN2U1ODE5NmM0OGE0ZmVmNWU2ZjQ1MzUw
Njg0ZWMzYw0KDQpSZWdhcmRzLA0KWXVueGlhbmcgTGkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NClNlbnQ6IEZyaWRheSwgSnVseSAyMSwgMjAyMyA4OjIxDQpUbzogTGksIFl1
bnhpYW5nIChUZWRkeSkgPFl1bnhpYW5nLkxpQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClN1
YmplY3Q6IEZBSUxFRDogcGF0Y2ggIltQQVRDSF0gZHJtL3R0bTogZml4IGJ1bGtfbW92ZSBjb3Jy
dXB0aW9uIHdoZW4gYWRkaW5nIGEgZW50cnkiIGZhaWxlZCB0byBhcHBseSB0byA2LjQtc3RhYmxl
IHRyZWUNCg0KDQpUaGUgcGF0Y2ggYmVsb3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDYuNC1zdGFi
bGUgdHJlZS4NCklmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90
aGVyIHN0YWJsZSBvciBsb25ndGVybSB0cmVlLCB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3Bv
cnQsIGluY2x1ZGluZyB0aGUgb3JpZ2luYWwgZ2l0IGNvbW1pdCBpZCB0byA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4uDQoNClRvIHJlcHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3VibWl0LCB5
b3UgbWF5IHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzOg0KDQpnaXQgZmV0Y2ggaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC8g
bGludXgtNi40LnkgZ2l0IGNoZWNrb3V0IEZFVENIX0hFQUQgZ2l0IGNoZXJyeS1waWNrIC14IDQ0
ODE5MTM2MDdlNTgxOTZjNDhhNGZlZjVlNmY0NTM1MDY4NGVjM2MNCiMgPHJlc29sdmUgY29uZmxp
Y3RzLCBidWlsZCwgdGVzdCwgZXRjLj4gZ2l0IGNvbW1pdCAtcyBnaXQgc2VuZC1lbWFpbCAtLXRv
ICc8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4nIC0taW4tcmVwbHktdG8gJzIwMjMwNzIxNDYtc3Bv
cnRzLWRlbHVnZS0yMmExQGdyZWdraCcgLS1zdWJqZWN0LXByZWZpeCAnUEFUQ0ggNi40LnknIEhF
QUReLi4NCg0KUG9zc2libGUgZGVwZW5kZW5jaWVzOg0KDQoNCg0KdGhhbmtzLA0KDQpncmVnIGst
aA0KDQotLS0tLS0tLS0tLS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAt
LS0tLS0tLS0tLS0tLS0tLS0NCg0KRnJvbSA0NDgxOTEzNjA3ZTU4MTk2YzQ4YTRmZWY1ZTZmNDUz
NTA2ODRlYzNjIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogWXVueGlhbmcgTGkgPFl1
bnhpYW5nLkxpQGFtZC5jb20+DQpEYXRlOiBUaHUsIDIyIEp1biAyMDIzIDEwOjE4OjAzIC0wNDAw
DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS90dG06IGZpeCBidWxrX21vdmUgY29ycnVwdGlvbiB3aGVu
IGFkZGluZyBhIGVudHJ5DQpNSU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBlOiB0ZXh0L3Bs
YWluOyBjaGFyc2V0PVVURi04DQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQoNCldo
ZW4gdGhlIHJlc291cmNlIGlzIHRoZSBmaXJzdCBpbiB0aGUgYnVsa19tb3ZlIHJhbmdlLCBhZGRp
bmcgaXQgYWdhaW4gKHRodXMgbW92aW5nIGl0IHRvIHRoZSB0YWlsKSB3aWxsIGNvcnJ1cHQgdGhl
IGxpc3Qgc2luY2UgdGhlIGZpcnN0IHBvaW50ZXIgaXMgbm90IG1vdmVkLiBUaGlzIGV2ZW50dWFs
bHkgbGVhZCB0byBudWxsIHBvaW50ZXIgZGVyZWYgaW4NCnR0bV9scnVfYnVsa19tb3ZlX2RlbCgp
DQoNCkZpeGVzOiBmZWUyZWRlMTU1NDIgKCJkcm0vdHRtOiByZXdvcmsgYnVsayBtb3ZlIGhhbmRs
aW5nIHY1IikNClNpZ25lZC1vZmYtYnk6IFl1bnhpYW5nIExpIDxZdW54aWFuZy5MaUBhbWQuY29t
Pg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpMaW5rOiBodHRwczovL3BhdGNod29yay5m
cmVlZGVza3RvcC5vcmcvcGF0Y2gvbXNnaWQvMjAyMzA2MjIxNDE5MDIuMjg3MTgtMy1ZdW54aWFu
Zy5MaUBhbWQuY29tDQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9y
ZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcmVzb3VyY2UuYw0KaW5kZXggNzMz
M2Y3YTg3YTJmLi5lNTFkYmM3YTJkNTMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9yZXNvdXJjZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9yZXNvdXJjZS5j
DQpAQCAtODYsNiArODYsOCBAQCBzdGF0aWMgdm9pZCB0dG1fbHJ1X2J1bGtfbW92ZV9wb3NfdGFp
bChzdHJ1Y3QgdHRtX2xydV9idWxrX21vdmVfcG9zICpwb3MsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICpyZXMpDQogew0KICAgICAg
ICBpZiAocG9zLT5sYXN0ICE9IHJlcykgew0KKyAgICAgICAgICAgICAgIGlmIChwb3MtPmZpcnN0
ID09IHJlcykNCisgICAgICAgICAgICAgICAgICAgICAgIHBvcy0+Zmlyc3QgPSBsaXN0X25leHRf
ZW50cnkocmVzLCBscnUpOw0KICAgICAgICAgICAgICAgIGxpc3RfbW92ZSgmcmVzLT5scnUsICZw
b3MtPmxhc3QtPmxydSk7DQogICAgICAgICAgICAgICAgcG9zLT5sYXN0ID0gcmVzOw0KICAgICAg
ICB9DQpAQCAtMTExLDcgKzExMyw4IEBAIHN0YXRpYyB2b2lkIHR0bV9scnVfYnVsa19tb3ZlX2Rl
bChzdHJ1Y3QgdHRtX2xydV9idWxrX21vdmUgKmJ1bGssICB7DQogICAgICAgIHN0cnVjdCB0dG1f
bHJ1X2J1bGtfbW92ZV9wb3MgKnBvcyA9IHR0bV9scnVfYnVsa19tb3ZlX3BvcyhidWxrLCByZXMp
Ow0KDQotICAgICAgIGlmICh1bmxpa2VseShwb3MtPmZpcnN0ID09IHJlcyAmJiBwb3MtPmxhc3Qg
PT0gcmVzKSkgew0KKyAgICAgICBpZiAodW5saWtlbHkoV0FSTl9PTighcG9zLT5maXJzdCB8fCAh
cG9zLT5sYXN0KSB8fA0KKyAgICAgICAgICAgICAgICAgICAgcG9zLT5maXJzdCA9PSByZXMgJiYg
cG9zLT5sYXN0ID09IHJlcykpIHsNCiAgICAgICAgICAgICAgICBwb3MtPmZpcnN0ID0gTlVMTDsN
CiAgICAgICAgICAgICAgICBwb3MtPmxhc3QgPSBOVUxMOw0KICAgICAgICB9IGVsc2UgaWYgKHBv
cy0+Zmlyc3QgPT0gcmVzKSB7DQoNCg==
