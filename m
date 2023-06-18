Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424EB7345C4
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFRJ6V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRJ6U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 05:58:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F34E7F
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 02:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MviSbQTQZI0E3Q/xVLZJQPXMEohkhhrrswOuWR9nw8TorTpFYsbP+m9MUZiNNFdWty701zfC7zq2ZZuNu7y4cj9tY0KP7Izgm4ZqMHwYxnPxlQBBGvwpsaTSQ79QtOBpOWCPGaLomADEcX+Dj0cMk6ZwAw3F02oGQoidQPy0mBE4rgQ4UaKoEmn5987/obdxtyCTrxrkjtq7OriJ1UL+Pv9/FHLUrBtGSprULIBIOiEBgRXb7FFfufEickN1cUTzdV4bcnCaPH+Dt+IfqiNeIUJTKJ8YwtxPDa55tUKjiG4qKtGNzlIt0bcP0/oTZUqCatD14syMO3tMSgkg0mzmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48YNJS20ME8wfo85FEw457aNo3aAIdspkXCmSGkO1HE=;
 b=Vbw5XYoNRL5yjoG4YyZqI3gVz/pcAflA0CNdO0LUoINPsFkXi7yxu+CeF7rrBLP4qT9/Vzxy0s10wrHDTwBysTVzpyhmZ+QLq4BY/iCEmxvdyQ0CoC0fEEOPZ6NlGrMIXFdgzASKcBd1jIFSAZr5jxo+0pS39hU7U9NP0nj3Xyiygiuh1ikgnsdoyz0R4bglIGcqcZ1rtAkCs0r6zDbUfV64JbWjv+pI8CtzPPbzAf2RREnhRgELLjw5OvEF+GolYYv9Ty2eahMTbEGRGCpV6QDFxTj2If9KRCOPtyHf74aK9r/EcVQGG7KuvXnQPgui9+OpOSXyIFmy2cC35WOkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48YNJS20ME8wfo85FEw457aNo3aAIdspkXCmSGkO1HE=;
 b=ofCXOcxvRkocXAn5RZDT0few8l6xjG8OpjTF5I8p23t+MVsO13C4yUP3x+oI0PBQnDDsDENAPl6Mrn5Rj7bVtwYLnydP2SI17NYUjq5ngFMZwz5r/kKvq3zNIrgK9U1HkiqCCmc9A7l0QDaddHpC+8EawXLtWNv5dX+TcuTmm0f5IEvlqmBVUv599Q79zqXMRW7QRAUL3dftclpPbmmmtB1SB2A1ADPQEkK2Mmv8CKaMIEdWG6dmSrJm5ii4ekp5VCL7/ya1B0DaLYzdHa9wyNMtHoJ7sDzT2As9B8kszWRr6DvpluH3vmkLUCDusNBDVX32Gz1EvpBUUaCm8DXPhw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SA1PR10MB7856.namprd10.prod.outlook.com (2603:10b6:806:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 09:58:14 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 09:58:14 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "romain.izard.pro@gmail.com" <romain.izard.pro@gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Thread-Topic: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Thread-Index: AQHZk+YYeEDleSDzUkGuOQMGB6y2ZK+PQpqAgAEEt4CAACeuAA==
Date:   Sun, 18 Jun 2023 09:58:14 +0000
Message-ID: <afbf34e128a744bb37f8e533248b69c2b0fdff9e.camel@infinera.com>
References: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
         <5533972aab4a15ab2177497edc9aa0ba1b97aaba.camel@infinera.com>
         <2023061854-daydream-outage-de91@gregkh>
In-Reply-To: <2023061854-daydream-outage-de91@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SA1PR10MB7856:EE_
x-ms-office365-filtering-correlation-id: 54f1553a-9a20-4683-fd52-08db6fe28885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ghNBnqMwhq67WLiGBQeAh+q3tUpQg2xuJ2m4F8kxHz/aBGDll9WCrlLN9nt7QGGrqp/CR9gu/kDIHfeWdvftqXKlo57LC6mJE4qjCsB/C7NHsn5z5jLo+mlNryDJNAj13ID+iwy6hqG2Ms+Qfy156KTx82TMH9pAEWjdLbX6IeYylV2JxJCiOw1+3KvtdEAMHs4oY2ea564fY0mUCjEfIBtLML2PfuNKBLyJhU7dINIB1ja/W6YN3bW1PgyBl3BoTAjNzdwyLXIreU7O8Fm1/ar6A+vg9XwTgguD+Jx1AZFAsp8C7pj6O40D59ZLlbpZs0twyBWGugBgFQQLvkdBLH3IPKaoDjTaw96l4IG9JCq0jBkom12ilc4tyAmSinI68wwWxkdXHZOGw286AIjUx2KWmaGxwzz3I8AxQe0XgGvCh8Cm8T/xNvVM0l16o/FLEtJWPzMf/cnRHQA7lmwdHNBZ51YC2w+SibHBLTnFEsu/c4IO522++3Zx+q35rqs6oP8hLfZFqjzxsP6aNPm9CgeT3CJLP/8UT4cqvQOS+Waajyk++vMj2seqdQEixWF6K0nQv9B64d/fqbpSbgW/jCad2Hd3sQqpTcGdGpR1FjR0FiXFnI/GittA7kDbt1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(451199021)(5660300002)(8936002)(54906003)(36756003)(71200400001)(6486002)(2906002)(41300700001)(8676002)(316002)(4326008)(66446008)(6916009)(76116006)(66946007)(66556008)(64756008)(66476007)(91956017)(45080400002)(478600001)(38070700005)(38100700002)(86362001)(186003)(122000001)(2616005)(83380400001)(6506007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d09NaUxMejRpZkw4S3ZPUnZUbXY1aFVCcDNkelJBb29CdnBDaWJ0NlZTeE9I?=
 =?utf-8?B?Y0poL2w0aGcwUkRwbTlUUTB4bXpRQytBcGRYbFc1Q3Q2UTNHZnNZQVRFcmJi?=
 =?utf-8?B?MDUxam5VY2lsblJLK2t5UkEvWnJ6TVI3NHVlRmJ6ZkhHeWN0andCWjB1V2dE?=
 =?utf-8?B?RDRiNEtUYUQrV2VOMFNTWU11TWw1ZEt2ODljeWF5dmIwNHJ1Uk9rMzI0akww?=
 =?utf-8?B?NURKYzJCQnM3Q25jaElDQ3dRQkJGQWpTYlNNNklBUVFZSlRGbnF5Z01MeGJY?=
 =?utf-8?B?NXM1Qkx1WFh4cnptczF6eXU1UGdOSWQ0U0pEeDdEbUlSSG16U3R0c3hQdlAy?=
 =?utf-8?B?TmhyT2Rna3NNMWxuZmtVazJpOEd1S3pjYnBHd1Yvbk96OW1WZElzcU1CNWlC?=
 =?utf-8?B?TFhoZ1drb3ltNm5CYkxiVFpjeG1ZdmxNclUvYnRWKzBnZzJRVGpSZFQxY0lo?=
 =?utf-8?B?S0JOdEdNamNpTlg1SWIxeGk0eTZLNTR1UWVQZVhneG02OVNrdkVGVFlIS21B?=
 =?utf-8?B?RGk5T0ZFT2w5cXRWb3QzNWw3dWFRdDRaeHgwcjJRQlFBMjdKZjdhT2EvZkhh?=
 =?utf-8?B?NFpIdzh3aHh1S2FXQStaMHd4VDJWTDZ1SDAyWDcyNUlSdGUyY2VnbHJSaWdJ?=
 =?utf-8?B?elZzM2xOaWtWK2xQWE00eEhWR3NmL04zWmoxeUo3UHp4eERvWG9nT21sVzUw?=
 =?utf-8?B?WlA5T0Rtdzd0OWpPd3ZsNS9BMlRwRjQzZXFXYXBsRmFzazFsazUzRTNwdXZD?=
 =?utf-8?B?c2sxNmhWRjQ4RkRiQzU4b1ZOcXp5b0QrMG80MGxnUGVEVUJXMFZteTBCOHhO?=
 =?utf-8?B?MDRQM3l2S0VYaktGYkFsTWpReDlCUXZkRDRXYjAvU1k0UGtSdlJBMzhUT2NQ?=
 =?utf-8?B?MVNGZ0NSTW5QdVQwQkFIbTAvRENRNS9lcnAvZ3RhNi9EMlpsTXFtZHoyZnZj?=
 =?utf-8?B?ZnZLSzhPUzRUeGJaOTQ3dnVkc2w4dFVvUnhDNmVTZnpjdUs0VzJ1czlMSkEz?=
 =?utf-8?B?STl0Sy8yZ25KSThnb25PenNBTXEyc21jU0pJWE1wcHR3OTgxdWxvMVQ2R3gr?=
 =?utf-8?B?QmlLVzFyN3ZON3Z5Uk92bjRVSjZTYWNEOHBsV3psTk90bDlJK21Pa0RTWk12?=
 =?utf-8?B?SlZwOUg2RmlYRGQyTDRiL3poejdoWVVtVVdmL1ZiMWhSY29lQVF5M1d4c1FF?=
 =?utf-8?B?UDFzUW9rQjJ6SDFxRUxEYTE1UllkM3gxTy9IQWU5MHJKTnFwbUVaemZ5ZzVx?=
 =?utf-8?B?VUZYa25oQWFIZkllTEFXZklxeEYrY3NCYVhwR3h6L1RIRVZuTG41MGp6MXR4?=
 =?utf-8?B?UEx4S1EzQVEvbmdVS2V2VzZEV1E2VFBvTGE4QkoxaDdoREdPZkdVQ1VVU2Yx?=
 =?utf-8?B?U2JPZ25aaitscU9MWWo0YzArQS9oZjlWRlV6TGRCU0hJV1NMaElRdkFRN3d5?=
 =?utf-8?B?MHUraGt6RWhsOWZvYnFpMjJESjdnOXdIMG1kbTZESEdnZ1NQbVJYUXkxck11?=
 =?utf-8?B?OTBFdjlFcmZsUEgyL1Fkb1Z1RnZveGpHK3FyQlVMOU9IcG82VVozUFdvK2l3?=
 =?utf-8?B?bXpORDg0cmhlVVpXUlNjWURiS3NCdk9pckhELzNybmthWVdaT3YyQUhlT2xs?=
 =?utf-8?B?M3NsclVjWGJPOGoyVlF0M0ZldU1mMkU5R2J6YjRJVm55RzNIVERiOHMxU0M3?=
 =?utf-8?B?Wk8rVG5aRVVXWE5MaElkTUN6cVdHQXY0K21ibG9MRHJmYXE2YTB4emxNZU1T?=
 =?utf-8?B?b3lURG5WWVYyN0NFeExtNTdvcWNORTFhMHhjeWhXRzc2amo2SktneFZaMlFQ?=
 =?utf-8?B?cG9RSjNWUC9uWFRPdi95d2l6MG5EVmZGQ2RIQWRaN1EwSUNtUlpXWm5uS29h?=
 =?utf-8?B?M2pmN3BKZFFjb1Zsc2pONVNXcnp6enJPTFFvRWFRVFZWSDc2dUN5N2ZYSE5k?=
 =?utf-8?B?MWRNV0V1Tjd0K2xNejkxUlFiRkJFVGkzNGRaM0VHeFpYeDlMRTkvaDJZRFA5?=
 =?utf-8?B?MHR1YnVYTGFENEN3OUxCZ1RlcmdKd3N2WnhEbXhBUkd6OFJzb1ZJNzF6eTRo?=
 =?utf-8?B?TlAxRDI0SGlqdzVITWpGZ3R0cnBjQVgxbzlURGZXWTRFcjNhU2g3RVZHTnkx?=
 =?utf-8?B?aDRvZXBqQjYwREhrSGNiNDMzanEwL2dTSCtudTRRWE1XSzAzdE43L0REemFL?=
 =?utf-8?Q?tEJHvm+tj4lUEm0Zyop0XEUTnLh354MJ/gijHb4RL4vA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6DE0A94DCE34B4589B4D061BFCDD99B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f1553a-9a20-4683-fd52-08db6fe28885
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2023 09:58:14.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nmcrAnEXbGJ78tph9LgC8C0Cr1R3nnb7xRaDJZrzcqRgh+mnSx11gFyob/7SXgGUPNMrLXe1s43fFPETUbogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gU3VuLCAyMDIzLTA2LTE4IGF0IDA5OjM2ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBT
YXQsIEp1biAxNywgMjAyMyBhdCAwNDowMzowNlBNICswMDAwLCBKb2FraW0gVGplcm5sdW5kIHdy
b3RlOg0KPiA+IFBpbmcgPw0KPiA+IA0KPiA+IERpZCBJIGRvIHNvbWV0aGluZyB3cm9uZyB3aXRo
IHN1Ym1pc3Npb24gb3IgaXMgaXQgcXVldWVkIGZvciBsYXRlciA/DQo+ID4gNC4xOSBpcyBtaXNz
aW5nIHRoZXNlIHdoaWNoIG1ha2UgVVNCIE5DTSB1bnVzYWJsZSB3aXRoIFdpbiA+PSAxMC4gDQo+
ID4gDQo+ID4gIEpvY2tlDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIzLTA1LTMxIGF0IDE5OjMzICsw
MjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0KPiA+ID4gRnJvbTogUm9tYWluIEl6YXJkIDxy
b21haW4uaXphcmQucHJvQGdtYWlsLmNvbT4NCj4gPiA+IA0KPiA+ID4gVG8gYmUgYWJsZSB0byB1
c2UgdGhlIGRlZmF1bHQgVVNCIGNsYXNzIGRyaXZlcnMgYXZhaWxhYmxlIGluIE1pY3Jvc29mdA0K
PiA+ID4gV2luZG93cywgd2UgbmVlZCB0byBhZGQgT1MgZGVzY3JpcHRvcnMgdG8gdGhlIGV4cG9y
dGVkIFVTQiBnYWRnZXQgdG8NCj4gPiA+IHRlbGwgdGhlIE9TIHRoYXQgd2UgYXJlIGNvbXBhdGli
bGUgd2l0aCB0aGUgYnVpbHQtaW4gZHJpdmVycy4NCj4gPiA+IA0KPiA+ID4gQ29weSB0aGUgT1Mg
ZGVzY3JpcHRvciBzdXBwb3J0IGZyb20gZl9ybmRpcyBpbnRvIGZfbmNtLiBBcyBhIHJlc3VsdCwN
Cj4gPiA+IHVzaW5nIHRoZSBXSU5OQ00gY29tcGF0aWJsZSBJRCwgdGhlIFVzYk5jbSBkcml2ZXIg
aXMgbG9hZGVkIG9uDQo+ID4gPiBlbnVtZXJhdGlvbiB3aXRob3V0IHRoZSBuZWVkIGZvciBhIGN1
c3RvbSBkcml2ZXIgb3IgaW5mIGZpbGUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJv
bWFpbiBJemFyZCA8cm9tYWluLml6YXJkLnByb0BnbWFpbC5jb20+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBGZWxpcGUgQmFsYmkgPGZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBKb2FraW0gVGplcm5sdW5kIDxqb2FraW0udGplcm5sdW5kQGluZmluZXJh
LmNvbT4NCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQuMTkNCj4gPiA+IC0t
LQ0KPiA+ID4gDQo+ID4gPiAgU2VlbXMgdG8gaGF2ZSBiZWVuIGZvcmdvdHRlbiB3aGVuIGJhY2tw
b3J0aW5nIE5DTSBmaXhlcy4NCj4gPiA+ICBOZWVkZWQgdG8gbWFrZSBXaW4xMCBhY2NlcHQgTGlu
dXggTkNNIGdhZGdldCBldGhlcm5ldA0KPiA+ID4gDQo+ID4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfbmNtLmMgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+
ID4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X25jbS5oIHwgIDMgKysNCj4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBX
aGF0IGlzIHRoZSBnaXQgY29tbWl0IGlkIG9mIHRoaXMgY2hhbmdlIGluIExpbnVzJ3MgdHJlZT8N
Cj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQpGb3IgdGhpcyBwYXRjaDoNCgk3OTM0MDky
OTIzODIwMjcyMjY3NjlkMDI5OTk4N2YwNmNiZDk3YTZlDQoNCmFuZCBmb3IgInVzYjogZ2FkZ2V0
OiBmX25jbTogRml4IE5UUC0zMiBzdXBwb3J0Ig0KCTU1MGVlZjBjMzUzMDMwYWM0MjIzYjljOTQ3
OWJkZjc3YTA1NDQ1ZDYNCg0KVGhhbmtzDQogICAgICAgSm9ja2UNCg==
