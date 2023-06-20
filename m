Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D473688E
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFTKAa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjFTJ7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 05:59:14 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2114.outbound.protection.outlook.com [40.107.6.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF12E68
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 02:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnNaROFneSo1OjjELJtu0nbuPMRbWxE3+xJB6ixDjhEeITf6mXf4LjCKBs8cpv72x8szUUxdrTJegW+pnz/zeB6vHBqftNjDn2SkdS/isz1ORZWo8sOZLNOjJ4wEny1YWuyHXQzCzlQgLsrNLfQEJB1UZ2FMmPzDA84iDOhbfOtdjc9Utygx0m0tAeMYaOzzpDOnt6z8fXA5VQg+BT6EfRw/RToKVXZDg5glckzRSNQ0lhkkQ0OJAtto+1B1gUq3Kr85rNNrIZTfz2RbFiGMdRRouNFr2mjGUA9pnwN3zUYX3/QqzmPe3KSXw2dkZ1iXqDe1Xn6PGHZ7L56/ciMWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UodnhZfMwJFgfiUdfx/FLlbYClSvaNbRFMMEVFFZYJ4=;
 b=hgb/X+cHjH3PQDAzgEtqRXDd5sUBSI6Njk9O5pGH7fqpe64X0tcFj41ONjzC0+3plwJX1yaphZSH1UNGYkNEJXXrJUjRKa5dHD5IyAYqye1OgDxb+TJ8+ZFn3EimwZUv5Lqqi6+qb2URZb6/TF0J6YWbN5LcQBxVJEMbGoSy1fTNMzADqPPIBE6ZDPEYj1jwgbvrbDTDoUxFkO1bdI945ZwyQWwED9OPbCY/3pNP19XQeOUWti9GVWKbgEtxgWXc67kYkyyTIEkSdAliM5NoOWkws2oLr72XqZN0sRbEPUFVKAiBDTo8J2j9OqWJn+b0poZ9XJcuICgnM7IHvNWOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UodnhZfMwJFgfiUdfx/FLlbYClSvaNbRFMMEVFFZYJ4=;
 b=kNknXU8x2UNfGAIuiZMV/bA/YVG9dwj2OSLWCzZEpB1X/LTeGhVE/9kGG86qj9clB8CKc8zQy1RoI7zfsHWf6pLORDtgc2j9/tqJIXVGxsvHAoCGgw64K4ZrusN/WKSfouWMAiwBbPP/4Y09WjdHBT9W6GRATVdHzJMPqCNsrTaSMnvX+FBqlUCAGVxOLV8u/BKJlQvCcxlRy0rE22tTLOxVvuYkeY3FvFNWmeOXk/2zMltz4EZKz8/pmEsMthw2N/JIYJtodR9vdjYcX+J/dvJYU/wItykGlpTBN8FsDOE6bCQXdBqnWSYDQXJxBwDAC3aCUBFZUF1v/knoYilZkQ==
Received: from DB7PR07MB5707.eurprd07.prod.outlook.com (2603:10a6:10:8b::33)
 by PAWPR07MB9712.eurprd07.prod.outlook.com (2603:10a6:102:391::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 09:56:51 +0000
Received: from DB7PR07MB5707.eurprd07.prod.outlook.com
 ([fe80::65e5:226b:7ac5:7787]) by DB7PR07MB5707.eurprd07.prod.outlook.com
 ([fe80::65e5:226b:7ac5:7787%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:56:50 +0000
From:   "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: IPMI related kernel panics since v4.19.286
Thread-Topic: IPMI related kernel panics since v4.19.286
Thread-Index: AQHZop7EusuFK+H0sUGnG7bzwqy5Aa+SFJAAgAFhQwA=
Date:   Tue, 20 Jun 2023 09:56:50 +0000
Message-ID: <dab0ac65c452ba3af6837b268a1d5d9d280360eb.camel@nokia.com>
References: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
         <ZJBPjOL8chqtPck2@mail.minyard.net>
In-Reply-To: <ZJBPjOL8chqtPck2@mail.minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR07MB5707:EE_|PAWPR07MB9712:EE_
x-ms-office365-filtering-correlation-id: fa33dd15-8c1a-44db-5b49-08db7174ab56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bG7v3eZXgOCTjOj6gfFiRcZv9E8AJxIlPMvznXQlGjjcXBfXtzN4Ljg5t1CTS5enU+w0aW1kYG9ahghHf/hkH/WFrg/mlAAMHPZowt825z05g8x4Af2viSnsrTIwBNh/tbvGOk73lFV0zC5orrGrSQr0GEH4u65qeTHdseieOU+TLiUrITraIqFRCXqEe+pf/MuyewnkBGOTKZEgXpQz2jslbKgw86XoK7/GF0rACXRb3A6rgBD1xuaQWD8bZgtPahyyjAwkUNMA3rL12Gf5XAAr+rxFBD4aLAIIg8THMMn7rPzudMfS7upmgvdRq03RW97EJSsgkmNB7LRly64wKsr/zE998iP2AFjodz61LCqY18gvUx9hJma5RaEJncOX/IA66OxDixlxXbLBf3pzjNM6DdcmSK2gpLOzRoxMmRFuVMTfZdeYW9624I02Qb/ZOJbDJoXItGCEYsN3xY/ZunMSpALXZ55yZVXvU3cDoN0SmL7NAXOGfczxxf/CYcDiK/0dkO6+os6srLCUnpHldYdfEK7DGNoFdXsuh5Qfs/1FZ/efSBj/mDLHCCS2rAAk0vrtVNUHHSaY0p2xglKKzIfileJLBuEYSPRTjo5Lm2W31yLULGMvco7Wsv0AlMp0CC2AGqYFcILMoWUbOVh3Qa5PuQ5e8AfxCqBpfXMbxg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR07MB5707.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(2906002)(38070700005)(36756003)(86362001)(26005)(6506007)(6512007)(54906003)(186003)(478600001)(71200400001)(6486002)(122000001)(76116006)(64756008)(66946007)(66556008)(66446008)(91956017)(6916009)(66476007)(4326008)(82960400001)(316002)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkllb2ppSnhhVXBHSnBaTjdmc3N5R0hWbkFITVR0MTl1U0FraW1yUGo0eEZB?=
 =?utf-8?B?SG5UaGsyaU1rMGw2TmFyR29PUXlSRkxCWU43RnJsOUNZc2hsbEYyT2hGZ3Yr?=
 =?utf-8?B?MUcxRG95bmNvRjBLN1NwckhqMXEyaHJBOTd2UzFuWkxKZ05DdEtIMHhWem16?=
 =?utf-8?B?dGxXYlppdVd1MG1sVmJ1SkhqYTNJaGR6Mk1Hd1FGRTJEMmlTVXdmaGhWdlU4?=
 =?utf-8?B?OXFJM0ZRd291MUdlT2NaOVpkTU1CemhMUVFua2Zmb0VpUUVhdnhReHhKb3Jt?=
 =?utf-8?B?cnI5UW14NStaU2pBaUlnM1RjVHpJNHprazJsLzhuL0dJSVVCRGVQZXhrblkr?=
 =?utf-8?B?QTBNQmV1amM4RHBwSGQyNEU2QkV6emlrOGNVUjhVZEJTc0dlV0VYTWxNdHdD?=
 =?utf-8?B?Y3gxc0Qwc1ZqU3Z6U3VTZ3NhQldRaktBeXpoNk5tcmJHenVOOHlycHQ4akx1?=
 =?utf-8?B?cFZ6QitWNUw0NFJBbmFQenZzOFBJUHJsV2tIVEFlNEFpWlJFK2lzQURhNENt?=
 =?utf-8?B?eWlRY3pINW44bzc0dkpqbTA4a2wyWlVTd1NsdWpzdHROMFh5bVJ4cGswRWgr?=
 =?utf-8?B?elhXUmltalljSkJHK0x4SFFvNDRrKzB0SDdGeDF0eG0vUFAxTTdmYWtJb1pR?=
 =?utf-8?B?Tkl5bzhEVStYL3lZdnBhOGZyeE5hOFhDNFE4QzNxK0JlMmMyYmdSTXZqOFAr?=
 =?utf-8?B?dEljbkVaUDRJWFhrdkZxeUYxSFc5d1BmTVNVUmVGcjVRNGYrVm94ekRtdTFL?=
 =?utf-8?B?OE1Ma0RDSm15MHBEUE9VbHJpdTFzOXp6UGtJbkY3b3BOZDM5NlJUdk5WOStm?=
 =?utf-8?B?SlVadFlYdU9VL0pmT0l3NEhnY3E2SzlmQm5UdFd6cWM3blFzYXRwRjRxRG8y?=
 =?utf-8?B?WmNJZ2xhWUg4eVQ2SEdReWk0aEkxZVQ5MUtOd3FEdGxVcXdiV2tha01iMVN1?=
 =?utf-8?B?QmMwR0NVa3hzQXBNVEg2Z2ZVZ0FOaFZzQ1RtVUxWQ1o0NzVxb1p0MWk5NTJx?=
 =?utf-8?B?VE1nTGFIeXQ2OWhKNzJhbFV1d2pjajVHUmZQT2RpclFYRUVnTXVDSkt1WVhT?=
 =?utf-8?B?SmJ5VkpuVGZuWFpUYXBrQTYxcTV4K1pqeHBTTmsxa3NnQndMVTB0ZzZUQlA1?=
 =?utf-8?B?cEU4R1NBdmZNODdJZWhPUU9tVDdQQlBnN2E2anJydnZFNmFzVVoycEtPS1JL?=
 =?utf-8?B?ejBpNjZUWGRpYmNxMkVmOWsxb2dwaGcrYzJhNGhpd2lqbVFXbCsvazh4WVpJ?=
 =?utf-8?B?T1o1VS9adTA3WkR1L2oyaWV6cFBxNTdabWNSS1Vib3VUYmFjUU9ERzhBcjc2?=
 =?utf-8?B?Rk0zbkpjSW5IbnVMSUNLS2NrTnVZZ2E0THRTRzRZRlpGMC9kczNrYkRBOS9V?=
 =?utf-8?B?UWhmSEZkUnNZUU90Tno5UUFsY1plK1c2dGVGa2c3ejNnZElzNmNoUDc0djB2?=
 =?utf-8?B?MitUVUxiQ3JTei8xb3h4aGh5QWRCQ0VxaTViRlBjVDJqM0RqRktMMm1ISVp3?=
 =?utf-8?B?VVI2c2JrWVN3OGxmbVBrOHU2c2x0cFRkeHQzbGlBR0p0RS94ckFNZjZHcnpx?=
 =?utf-8?B?MTNYUlh2MUpOSkJNaU5WUXp1ZmpJeGlzVGlURFNqc0gvUjlWN0R3Q1drdDFK?=
 =?utf-8?B?cDBRSmRpL1pZNHhhaWtBd2tYR3hMR0xRRkM1ampGYnM3SU8zQ2YvTkI5L3lT?=
 =?utf-8?B?aU1JbzBwUWUrYkx3YlQ2M1ZaY1RUc2wrR2U1NTIvQWdyQTB4b1dTeGdiQmg2?=
 =?utf-8?B?U0VEaWo3aFU0TjgxbVBONDVLZnlDcmJrWEVBMUl2a3hnU0lDc2k1M2JmYjBn?=
 =?utf-8?B?ZVcxQ1R1N2k1TWtRL0d1KzNzU1dvcDdmMy84YkU0d3FUdi82MXloTzVONWNO?=
 =?utf-8?B?NUhRNmdNcUpVNkxXcXQrcXFYM0tUWnp3bDlybCs4a0cxUXF2RzQ3am5neldh?=
 =?utf-8?B?bTF2SFIxaHVJUVVOWmgwZVdPemIyYU1qZHpsVENrMmlrckpvL1Z5bS9pY0lC?=
 =?utf-8?B?VmFDaFRhSmp0U0tQYitJSDBmQU1DZXljbGE0KzM2bEEyRmpsZGdtNW9NTldi?=
 =?utf-8?B?YjgwR3poRHRLMkdBQlE3ZW1qblU5aDN2SDc2YlNDd2l3OVpDZHg0VytHMzM5?=
 =?utf-8?B?RlZGd3ArMDlBM1g5NUl0ZkgrcVk3SnNZWENacXR1ZGY1ZG1rcG0vYjJrNnVD?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F922F8D3D06624439C9FB1D9A2E765D8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR07MB5707.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa33dd15-8c1a-44db-5b49-08db7174ab56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:56:50.7396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXZUIwk0FjIACI3uz+GE3299aTvIA7kZfnkd+mZyU6hTfZYfaEecgQ2lpRE3l8teMihTYM5ybgg+0YzTfIXws/HectHRO6bdVAPQiydNvCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9712
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

DQo+IEl0IGxvb2tzIGxpa2UNCj4gDQo+ICAgYjRhMzRhYTZkICJpcG1pOiBGaXggaG93IHRoZSBs
b3dlciBsYXllcnMgYXJlIHRvbGQgdG8gd2F0Y2ggZm9yDQo+IG1lc3NhZ2VzIg0KPiANCj4gd2Fz
IGJhY2twb3J0ZWQgdG8gZnVsbGZpbGwgYSBkZXBlbmRlbmN5IGZvciBhbm90aGVyIGJhY2twb3J0
LCBidXQNCj4gdGhlcmUgd2FzIGFub3RoZXIgY2hhbmdlOg0KPiANCj4gICBlMTg5MWNmZmQ0YzQg
ImlwbWk6IE1ha2UgdGhlIHNtaSB3YXRjaGVyIGJlIGRpc2FibGVkIGltbWVkaWF0ZWx5DQo+IHdo
ZW4gbm90IG5lZWRlZCINCj4gDQo+IFRoYXQgaXMgbmVlZGVkIHRvIGF2b2lkIGNhbGxpbmcgYSBs
b3dlciBsYXllciBmdW5jdGlvbiB3aXRoDQo+IHhtaXRfbXNnc19sb2NrIGhlbGQuICBJdCBkb2Vz
bid0IGFwcGx5IGNvbXBsZXRlbHkgY2xlYW5seSBiZWNhdXNlIG9mDQo+IG90aGVyIGNoYW5nZXMs
IGJ1dCB5b3UganVzdCBuZWVkIHRvIGxlYXZlIGluIHRoZSBmcmVlX3VzZXJfd29yaygpDQo+IGZ1
bmN0aW9uIGFuZCBkZWxldGUgdGhlIG90aGVyIGZ1bmN0aW9uIGluIHRoZSBjb25mbGljdC4gIElu
IGFkZGl0aW9uDQo+IHRvIHRoYXQsIHlvdSB3aWxsIGFsc28gbmVlZDoNCj4gDQo+ICAgMzgzMDM1
MjExYzc5ICJpcG1pOiBtb3ZlIG1lc3NhZ2UgZXJyb3IgY2hlY2tpbmcgdG8gYXZvaWQgZGVhZGxv
Y2siDQo+IA0KPiB0byBmaXggYSBidWcgaW4gdGhhdCBjaGFuZ2UuDQo+IA0KPiBDYW4geW91IHRy
eSB0aGlzIG91dD8NCg0KWWVzLCBzb3JyeSBmb3IgdGhlIGRlbGF5LCBoYWQgYSBiaXQgb2YgdGVj
aG5pY2FsIHByb2JsZW1zIHRlc3RpbmcNCnlvdXIgcHJvcG9zZWQgcGF0Y2hlcy4gSW4gdGhlIG1l
YW50aW1lIHdlIGZvdW5kIG91dCB0aGF0IG92ZXINCmEgZG96ZW4gb2Ygb3VyIHRlc3Qgc2VydmVy
cyBoYXZlIGhhZCB0aGUgc2FtZSBjcmFzaCwgc29tZSBvZiB0aGVtDQptdWx0aXBsZSB0aW1lcyBz
aW5jZSB0aGUga2VybmVsIHVwZGF0ZS4NCg0KQW55d2F5cywgd2l0aCB5b3VyIHByb3Bvc2VkIHBh
dGNoZXMgb24gdG9wIG9mIDQuMTkuMjg2LCBJIGNvdWxkbid0DQp0cmlnZ2VyIHRoZSBsb2NrZGVw
IHdhcm5pbmcgYW55bW9yZSBldmVuIGluIGEgc2VydmVyIHRoYXQgd2l0aG91dA0KdGhlIGZpeGVz
IHRyaWdnZXJzIGl0IHZlcnkgcmVsaWFibHkgcmlnaHQgYWZ0ZXIgdGhlIGJvb3QuIEkgYWxzbw0K
c2F3IGluIGFub3RoZXIgdmVyeSBzaW1pbGFyIHNlcnZlciAod2l0aG91dCB0aGUgZml4ZXMpIHRo
YXQgaXQNCnRvb2sgYWxtb3N0IDE3IGhvdXJzIHRvIGdldCBldmVuIHRoZSBsb2NrZGVwIHdhcm5p
bmcuIE1heWJlIHNvbWUNCnNwZWNpZmljIEJNQyBiZWhhdmlvciBhZmZlY3RzIHRoaXMgb3Igc29t
ZXRoaW5nPyBTYWRseSwgdGhhdCBraW5kDQpvZiBkaW1pbmlzaGVzIHRoZSB2YWx1ZSBvZiB0aGUg
c2hvcnQgZHVyYXRpb24gdGVzdHMsIGJ1dCBhdCBsZWFzdA0KdGhlcmUgaGFzIHNvIGZhciBiZWVu
IHplcm8gbG9ja2RlcCB3YXJuaW5ncyB3aXRoIHRoZSBmaXhlcyBhcHBsaWVkLg0KVGhlIGFjdHVh
bCBsb2NrdXBzIGFyZSB0aGVuIHdheSB0b28gdW5wcmVkaWN0YWJsZSB0byB0ZXN0IHJlbGlhYmx5
DQppbiBhbnkga2luZCBvZiBzaG9ydCB0aW1lIGZyYW1lLg0KDQpBbnl3YXlzLCBsb29raW5nIGF0
IGUxODkxY2ZmZDRjNCwgaXQncyByaWdodCB0aGVyZSB3aGVyZSB0aGUgaXNzdWUNCnNlZW1zIHRv
IG9yaWdpbmF0ZSBmcm9tLCBzbyBpdCBtYWtlcyB0b3RhbCBzZW5zZSB0byBtZSB0aGF0IGl0IGRv
ZXMNCmZpeCBpdC4gSSB3YXMgYWxyZWFkeSBraW5kIG9mIGxvb2tpbmcgYXQgaXQgd2hlbiB5b3Ug
Y29uZmlybWVkIGl0Lg0KVGhhbmtzIGZvciBwb2ludGluZyBvdXQgYWxzbyB0aGUgMzgzMDM1MjEx
Yzc5IHBhdGNoLCBpdCBtaWdodCBoYXZlDQpiZWVuIGVhc2lseSBtaXNzZWQuDQoNCg==
