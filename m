Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA47466F8
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 03:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGDBuv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 21:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGDBuv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 21:50:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F79E4E;
        Mon,  3 Jul 2023 18:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH1F3sbpsnDfh11DY6Cu/rG0b+mejs6PdM9varUQhqwOi1B8hRkhsCAlzln4PguPHNRPpyaJrhJuMD7FIpLbqxFjhXrRInhp4Lcq5ud2wWSXlbwQ7cLEZuTDw/oyFhiR9x95OFz20xb3B3fIbv7bEliSbSfZB0ZzNbigLDAiTHOUntleFHb5beqigLi7Am6qfFouOF3aib+5IzglXiwJVorGirOTEuG0RI6UArCG5RkHzGoVv4qp1fiyITu69q3iD0WgFMLJmOzTEf+UARPGUzzI1X3olTNMk7ZpPqwj+XvWXC9MwGze9GZ7rfNZabqpNrzjPBBC8FDnztcjBAn+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpfkhNlEzilo+GYwKeZUD6928TGv0JUMSuU30nUEyc0=;
 b=MYqC+ZjHOSc5J2Xe1Le66MYETPvmVW4qcsQv1W23XFE/9JQm2Zattz91t7ASXbDrZ5f/2hwpbVmQAimAFzjQM6MxgbafZUCIldN8BxRmI+tZeR8MNaS2JPztn1oXDh0GU7JHoGA/tMR8o+HSRE+EJULImD/+/HoGxRl61KGOXaaRaNhlDhDI6/iFvD+sq3Nf9W2zdU1AZ0TOeYJxKjO1lhJy79sWSMFAKLACRl5MVHNIbofYRTDYKkLon7FWTNmP9ty7l7CrwdLqL/6kC1xHJMToq5xzFahzWnn3cuyYGScz6LOW4jKnNd5oPBWCWn7OFTQzpGgr+QROcdvi2Jc/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpfkhNlEzilo+GYwKeZUD6928TGv0JUMSuU30nUEyc0=;
 b=pbnQaxY/bmNx1p7pEtvtSqSYbJzWpfsKyzxL44n4kED+ZHsLTgcwJStspe3GWtbnm05WrZBSIObQMRXgAp2ilslhPX+5RCcv2JETjcrhVhAIQCWXVY0oI8jiWo3H49vl1W3t0eHVQ+ul8genENhxo04cGSkuNM3lUHJ5oV9A6VQ=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by PH7PR13MB5432.namprd13.prod.outlook.com (2603:10b6:510:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 01:50:45 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 01:50:45 +0000
From:   Yinjun Zhang <yinjun.zhang@corigine.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Louis Peens <louis.peens@corigine.com>
CC:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net v2] nfp: clean mc addresses in application firmware
 when closing port
Thread-Topic: [PATCH net v2] nfp: clean mc addresses in application firmware
 when closing port
Thread-Index: AQHZraYpymGl0/jN8Eyn2LEMRoRamK+oNn+AgACeaQA=
Date:   Tue, 4 Jul 2023 01:50:45 +0000
Message-ID: <DM6PR13MB3705E98ABE2CA8B2B677E055FC2EA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230703120116.37444-1-louis.peens@corigine.com>
 <4012ae37-f674-9e58-ec2a-672e9136576a@intel.com>
In-Reply-To: <4012ae37-f674-9e58-ec2a-672e9136576a@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|PH7PR13MB5432:EE_
x-ms-office365-filtering-correlation-id: 9304a6c4-b57e-4f70-1dc1-08db7c311556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rk1P+66I8y5Z4S0DPBAeMCOqcX/X5RSX2Qad4h5UgyGfqjWF8Xvn7Wn6FEI2ap2aaZ/lMNumyDUj5a+xFHxuRUTnuNuqXAALagxdEjiXknhN5gxCZy8itUs/j0/U0xoy3tPav3Dx8hrXVC+4w8lL9YCaMSwu6pok9xbNChKNDYFpGu4tJaf1PLq05uF6pBvHbvDOvs3GGIoJVLUR1/ePm2FFPo5zfx8DGwIjvIUkv7TjfEBcwSr7JF8Yl9DY9fEhKh6lUvzUgdyucS1AQIrDnoD1rsX9o7OqwbQH9UKkPv+mbOOpeqocLDTjARx3N4UWfuHULaOXhFW836f0tymqmlnM3nRswrNMbHvKUfUh7Xowp0t4q946fCl4QapUmLmI7j7XfyU46TB09RdHRgF6byg4aC2MsCrxaOHRVaB+GgSqNkk5Rk+MjnPWRlEn5WGbqZ2QAdSNUId/o97L0Tlyk7j/iVH55E0NKiEA7/9A1lq48WAezbUn+/oSCCJayczutoh5YJxkvPuNasJxxpqUJFO1S1Fd65jFihX33guOusDQVZWRtuyL4EQsd+RlecQetGN2QPfy6qPftHgFk9P1V5f7Ehtjt8gRDZkGjYzcH4UNMG2BeA5E0NmujP/AwGWxr2/IBsss+8yLm41dwbxWcHpxTXGM4GQ3WCnh3P/tCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(136003)(376002)(396003)(451199021)(4326008)(316002)(66556008)(186003)(66476007)(6636002)(9686003)(66946007)(76116006)(53546011)(64756008)(26005)(86362001)(66446008)(107886003)(6506007)(83380400001)(122000001)(2906002)(7696005)(38100700002)(33656002)(71200400001)(52536014)(44832011)(5660300002)(478600001)(38070700005)(8676002)(54906003)(110136005)(8936002)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG9qdVJMQnlhOVFzeUdkMGtZY3dGSEVQREg0T284VVhXMkdZbzU5VndMQWs3?=
 =?utf-8?B?VjIzNG9tbUFFSXU1VmpMVWVSZ0FRWFVUTHRPaGJGMFR2T3VIdjdIMTc1OUU5?=
 =?utf-8?B?MkpSZTRyNlVxbTRUMmR0a2MxQy92WXBNOC9yQXhKYWNyb0FPczlFMngrOU5x?=
 =?utf-8?B?LytjdUpqTFVBTWV1SmJYUjEvMTNLdmEyM0UxTHFoeVZPZ2g2SFc0TllveklN?=
 =?utf-8?B?RURSK2JLT1dCaEFXUEZGMXIrN1FBYStyUmg3YlRtdk1SSXFYdnpYSzB1RU93?=
 =?utf-8?B?b0J5SUJqekRtVGtzTi9BWlIvc290bHBzNXYrRWNyRkRvWGl0QUhhZG9XZThJ?=
 =?utf-8?B?elg2dnNoZ3VhdERpeVl0Z1hGM1lMeWFJUDh6aDJOM2l6bnczckNwdHNZTGJL?=
 =?utf-8?B?ajFIRDgzZWUvTFFEU2hxUktGL1phUlJDUGNGU1JsKytDZlBFaXI4RjgwMjRh?=
 =?utf-8?B?Zm1LSkk2QURtUkJlTGhQZGNDSkxFUHpKdW9xUDliVUxtWnZ0QUNsbmZaT0tN?=
 =?utf-8?B?eTBicTJIVXBIOUZDNkN2RkYxeCtST1U2dXA1Q1BMYTVReGdGc2c4YnVnb002?=
 =?utf-8?B?WHY0dTFoTjQ1cFZZRWVIQlFTaE1nRktFVmpHV1E1bkNxNEhQVGZGcWwwUGlq?=
 =?utf-8?B?YnF1cmNpYWNXMXM2eFlJNFlGZ2dWUkNQWm1vYUgvK3FOejk0ejM0MkJ1bjdC?=
 =?utf-8?B?dDBHa0V5c1JDcWYvci9rUU1ERFg1a0g1cVZqcWhhWVl3NTMrYjRCUWZDbysw?=
 =?utf-8?B?a0VOYXdxdEdIZ2NXUGFqSkN5L1dkU01mUnJWbEhGdzMvUWVIUFR3TXA5MTk5?=
 =?utf-8?B?MXNJSmE3S0NuTm95dGErYzdDME5vbnhFbE0zT0JwdE56b3lZeTlGWW9BU2Nq?=
 =?utf-8?B?OHhaR1hUSjBTQ0pUTXBEeHlvWXM0UlA0NGhRa0xUSFpic3RlelpQc1BhZ1VG?=
 =?utf-8?B?eGRuZENWek81dENROUhrempKVVFmejFIV04wVU9reTZSVGlid25tT0pmZ2Ni?=
 =?utf-8?B?MFNFY1graWtWWkdTYWZzMHphN0JGaDczSjNUL0Y5TjdJYVU2ajFzam02cjUy?=
 =?utf-8?B?ZVZZY0xSRVdUWCswNndFeGxDVGdkWEFlU0xnKzdwZFBxMHkwbUpyM2hrRUxL?=
 =?utf-8?B?ZHlFaXlublQ5eWlWc0RhNWtNM213V21UYUgwTktubkFoUTV6Zm5RaU03VjVa?=
 =?utf-8?B?UWxrblVOQ29hWjdlQ3BRcGRsQkdFcFBSNGZMRnZGWDRKMjNFN3lxV2Z3ckRI?=
 =?utf-8?B?T2IyQ0dzL28vYVlFRGgxdWlrQUo4QUtIR2t3YkkzSVdFR0w2V0pETnZBRWZw?=
 =?utf-8?B?Qko5Zzg1OElmd0h5ZjhoeVBPeGdJM2xod2NCSllWdldGanFkenh5RVpMMitJ?=
 =?utf-8?B?MTNvcFBkVm5lRllsUjlTMngyK2w2WVFQbHBhTjJqNUNFVmtLWXVRR3pvRkcr?=
 =?utf-8?B?cS9nMGU0Z3hmdjFocncxQTluSXM4VlVOdTU5MFowQkhYbi9uc0lWZnMyWk5Y?=
 =?utf-8?B?dWs0NmcwSGo0MVJhTFZSUEZTbFNLZ3NwdHBQYjMxVitzM2lPSThvUklhNnBI?=
 =?utf-8?B?VVdOVDlhQTRCZE9yMm9MYlhIQmxRamkwOWxGbUFCR09iSW84ZU03cTJLUkdq?=
 =?utf-8?B?UzlYL2hqQWpnVkRWVTBCWlZkcDI2b1JucXhmcUswby9NcGVSbGViZDUySGIv?=
 =?utf-8?B?ZWtwRllOZnVscjhPV2cxYytwQXpKY1FVbWlvcXdWNWFPQVNYNGZpcmlDVkF5?=
 =?utf-8?B?dnFjcnNUNUJ1Z0FIVzhseXpwWWY5QTQ2ZU9IS280WGd2STVPc1N2akVFS3pu?=
 =?utf-8?B?d0xWRENwTDZRbDU3c0NOUkp0S01nMW9FZmRKT09PNXlwU2RobEpnYkFqM3J6?=
 =?utf-8?B?Z3EzU1UyTXNhRE5zWWtDSUJXVjhXdXJmTVN6N2RSek5UYW9GbVNiQzFkVktx?=
 =?utf-8?B?NlgxLzNQVDFQeTUxTlZGR3dhTkk0OEhRTjJvdDlna2tVdER3cUUrVmNHWWlp?=
 =?utf-8?B?aDIwa3FMMUIza0xBZXRwMlFOSkVmUzlzNTE0UTZZb0F2RlNTYmZ4MnJWbjlT?=
 =?utf-8?B?cjFPWlkyWnBuM3Vtb0ZGa28xQW1KK2RQVythejdqenlwRnZPL3lJMklUYzZu?=
 =?utf-8?Q?OVFmyKAEJpoPmFl3wg6+93y4e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9304a6c4-b57e-4f70-1dc1-08db7c311556
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 01:50:45.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IE7bUtG1KBB4gBdFpUIcJg666SFDsDBVn4LPnjFovfmxXOT4DPQI4GmA0P5/VawQKT6GUJu8uNKfMZ9xmICm2omixNUQyR4B4G4rO3Af660=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5432
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlc2RheSwgSnVseSA0LCAyMDIzIDEyOjExIEFNLCBBbGV4YW5kZXIgTG9iYWtpbiB3cm90
ZToNCj4gRnJvbTogTG91aXMgUGVlbnMgPGxvdWlzLnBlZW5zQGNvcmlnaW5lLmNvbT4NCj4gRGF0
ZTogTW9uLCAgMyBKdWwgMjAyMyAxNDowMToxNiArMDIwMA0KPiANCj4gPiBGcm9tOiBZaW5qdW4g
WmhhbmcgPHlpbmp1bi56aGFuZ0Bjb3JpZ2luZS5jb20+DQo+ID4NCj4gPiBXaGVuIG1vdmluZyBk
ZXZpY2VzIGZyb20gb25lIG5hbWVzcGFjZSB0byBhbm90aGVyLCBtYyBhZGRyZXNzZXMgYXJlDQo+
ID4gY2xlYW5lZCBpbiBzb2Z0d2FyZSB3aGlsZSBub3QgcmVtb3ZlZCBmcm9tIGFwcGxpY2F0aW9u
IGZpcm13YXJlLiBUaHVzDQo+ID4gdGhlIG1jIGFkZHJlc3NlcyBhcmUgcmVtYWluZWQgYW5kIHdp
bGwgY2F1c2UgcmVzb3VyY2UgbGVhay4NCj4gPg0KPiA+IE5vdyB1c2UgYF9fZGV2X21jX3Vuc3lu
Y2AgdG8gY2xlYW4gbWMgYWRkcmVzc2VzIHdoZW4gY2xvc2luZyBwb3J0Lg0KPiA+DQo+ID4gRml4
ZXM6IGUyMGFhMDcxY2Q5NSAoIm5mcDogZml4IHNjaGVkdWxlIGluIGF0b21pYyBjb250ZXh0IHdo
ZW4gc3luYyBtYw0KPiBhZGRyZXNzIikNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlpbmp1biBaaGFuZyA8eWluanVuLnpoYW5nQGNvcmlnaW5lLmNv
bT4NCj4gPiBBY2tlZC1ieTogU2ltb24gSG9ybWFuIDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IExvdWlzIFBlZW5zIDxsb3Vpcy5wZWVuc0Bjb3JpZ2luZS5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gPg0KPiA+ICogVXNlIF9fZGV2
X21jX3Vuc3ljIHRvIGNsZWFuIG1jIGFkZHJlc3NlcyBpbnN0ZWFkIG9mIHRyYWNraW5nIG1jDQo+
IGFkZHJlc3NlcyBieQ0KPiA+ICAgZHJpdmVyIGl0c2VsZi4NCj4gPiAqIENsZWFuIG1jIGFkZHJl
c3NlcyB3aGVuIGNsb3NpbmcgcG9ydCBpbnN0ZWFkIG9mIGRyaXZlciBleGl0cywNCj4gPiAgIHNv
IHRoYXQgdGhlIGlzc3VlIG9mIG1vdmluZyBkZXZpY2VzIGJldHdlZW4gbmFtZXNwYWNlcyBjYW4g
YmUgZml4ZWQuDQo+ID4gKiBNb2RpZnkgY29tbWl0IG1lc3NhZ2UgYWNjb3JkaW5nbHkuDQo+ID4N
Cj4gPiAgLi4uL2V0aGVybmV0L25ldHJvbm9tZS9uZnAvbmZwX25ldF9jb21tb24uYyAgIHwgMTcx
ICsrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygr
KSwgODQgZGVsZXRpb25zKC0pDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIGludCBuZnBf
bmV0X21jX3N5bmMoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwgY29uc3QgdW5zaWduZWQgY2hh
cg0KPiAqYWRkcikNCj4gPiArew0KPiA+ICsJc3RydWN0IG5mcF9uZXQgKm5uID0gbmV0ZGV2X3By
aXYobmV0ZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAobmV0ZGV2X21jX2NvdW50KG5ldGRldikgPiBO
RlBfTkVUX0NGR19NQUNfTUNfTUFYKSB7DQo+ID4gKwkJbm5fZXJyKG5uLCAiUmVxdWVzdGVkIG51
bWJlciBvZiBNQyBhZGRyZXNzZXMgKCVkKQ0KPiBleGNlZWRzIG1heGltdW0gKCVkKS5cbiIsDQo+
ID4gKwkJICAgICAgIG5ldGRldl9tY19jb3VudChuZXRkZXYpLA0KPiBORlBfTkVUX0NGR19NQUNf
TUNfTUFYKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwly
ZXR1cm4gbmZwX25ldF9zY2hlZF9tYm94X2Ftc2dfd29yayhubiwNCj4gTkZQX05FVF9DRkdfTUJP
WF9DTURfTVVMVElDQVNUX0FERCwgYWRkciwNCj4gPiArCQkJCQkgICAgTkZQX05FVF9DRkdfTVVM
VElDQVNUX1NaLA0KPiBuZnBfbmV0X21jX2NmZyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBpbnQgbmZwX25ldF9tY191bnN5bmMoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwgY29uc3Qg
dW5zaWduZWQNCj4gY2hhciAqYWRkcikNCj4gPiArew0KPiA+ICsJc3RydWN0IG5mcF9uZXQgKm5u
ID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gbmZwX25ldF9zY2hl
ZF9tYm94X2Ftc2dfd29yayhubiwNCj4gTkZQX05FVF9DRkdfTUJPWF9DTURfTVVMVElDQVNUX0RF
TCwgYWRkciwNCj4gPiArCQkJCQkgICAgTkZQX05FVF9DRkdfTVVMVElDQVNUX1NaLA0KPiBuZnBf
bmV0X21jX2NmZyk7DQo+ID4gK30NCj4gDQo+IFlvdSBjYW4ganVzdCBkZWNsYXJlIG5mcF9uZXRf
bWNfdW5zeW5jKCkncyBwcm90b3R5cGUgaGVyZSwgc28gdGhhdCBpdA0KPiB3aWxsIGJlIHZpc2li
bGUgdG8gbmZwX25ldF9uZXRkZXZfY2xvc2UoKSwgd2l0aG91dCBtb3ZpbmcgdGhlIHdob2xlIHNl
dA0KPiBvZiBmdW5jdGlvbnMuIEVpdGhlciB3YXkgd29ya3MsIGJ1dCB0aGF0IG9uZSB3b3VsZCBh
bGxvdyBhdm9pZGluZyBiaWcNCj4gZGlmZnMgbm90IHJlYWxseSByZWxhdGVkIHRvIGZpeGluZyB0
aGluZ3MgZ29pbmcgdGhyb3VnaCB0aGUgbmV0LWZpeGVzIHRyZWUuDQoNCkkgZGlkbid0IGtub3cg
d2hpY2ggd2FzIHByZWZlcnJlZC4gTG9va3MgbGlrZSBtaW5pbXVtIGNoYW5nZSBpcyBjb25jZXJu
ZWQNCm1vcmUuIEknbGwgY2hhbmdlIGl0Lg0KDQo+IA0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAq
IG5mcF9uZXRfY2xlYXJfY29uZmlnX2FuZF9kaXNhYmxlKCkgLSBDbGVhciBjb250cm9sIEJBUiBh
bmQgZGlzYWJsZSBORlANCj4gPiAgICogQG5uOiAgICAgIE5GUCBOZXQgZGV2aWNlIHRvIHJlY29u
ZmlndXJlDQo+ID4gQEAgLTEwODQsNiArMTE2OCw5IEBAIHN0YXRpYyBpbnQgbmZwX25ldF9uZXRk
ZXZfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5ldGRldikNCj4gPg0KPiA+ICAJLyogU3Rl
cCAyOiBUZWxsIE5GUA0KPiA+ICAJICovDQo+ID4gKwlpZiAobm4tPmNhcF93MSAmIE5GUF9ORVRf
Q0ZHX0NUUkxfTUNBU1RfRklMVEVSKQ0KPiA+ICsJCV9fZGV2X21jX3Vuc3luYyhuZXRkZXYsIG5m
cF9uZXRfbWNfdW5zeW5jKTsNCj4gPiArDQo+ID4gIAluZnBfbmV0X2NsZWFyX2NvbmZpZ19hbmRf
ZGlzYWJsZShubik7DQo+ID4gIAluZnBfcG9ydF9jb25maWd1cmUobmV0ZGV2LCBmYWxzZSk7DQo+
IFsuLi5dDQo+IA0KPiBUaGFua3MsDQo+IE9sZWsNCg==
