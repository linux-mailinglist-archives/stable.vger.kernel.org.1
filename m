Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17020702CB9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbjEOM36 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjEOM34 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:29:56 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2053.outbound.protection.outlook.com [40.107.9.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF890E4F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9xjSpD2oVH+fOsMa1yFMDFb503ElUE7cMqNwmg1MPEtfDPn/TmloFKzvVTxvD4kg6mXHqwIV5L4tIrzX8ocn8P5fGzjh2wRicYBnb8QqGPp/z2fhvjwRuKIIvCojXmvV7Oa9FqJ+CiBTOqzqPRgg1hpQkmVL0AA9mSwMC2PT0incJJZhRnjbEd9Y1ggI5YXRErgFUEU3LlY8v2MMpaA9scGGW6nsq71IPLBT5yzg0OVCDMsNZXt8gKj/Ary/WGde1ZJj81myiqTtCE0gzlxZ6r5M1N1ofpXCbydVBpVSZgVexCpQkkBR2kGbHOSdkCOzWD0ovFwQblv3dLWWjqspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDmyY3t/Oj8UVH25fkZhAIgprzDt/wHSnId5xl6Pk2U=;
 b=P2BXp1B2GELpri4CO5SoNvKxGHGQSDiMJ37DMIpHLYBh3zMwF4Zqc8880FL6NzxvBCsTcNQanpiaBD82SMn39P3eTHZhy+Equkpoc1Ffr+55vgKSXj44VBAf/2+FFdDNS68DuBxpGNJnHW7pdYZXLeYNmHu2Qda6CmxfhdoEdUDFXBL3KayB/UfgRh7/k0c0U1UwWcJkLm/UtkuXhmsIKpMIJYZzvX9YD5Dy5xSZXeG1gyCw2Jh42KFFf9eEgCbM1wT3VhF27yct1b94kiZxuUF5M1TmF495Z02V2JR7rjSgT2VhQ03hXDoh5f3It3JrwbwVFnopNmZ7l7YkRjWAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDmyY3t/Oj8UVH25fkZhAIgprzDt/wHSnId5xl6Pk2U=;
 b=EEq6cpAIMu00GI4Eo/jXthLA3u/cWrVHexmYYUOMrbxd2vBLyUGUVl1r64sWJoZtQeHR3zU83qf/EGAINoMDfGe8MFm/TvY2twQvfHi3GaOQDsKTd7H49f3YLXAyEZoDfuV5xdOQQEohtc9V/TRiksWZAnpm2+KmucwNb57eHptzvFWkjdX/fpgurW5E4NMEPyDTaLj0qxZPx//N+me+uliN53T8gYx5tQDfz+1U4gVSW5GIDDfVkc/c/fexrLEura2Ai/z1BhwmaoJmA0cEnaaVo636i1PPJ3GPqm4obkl6oqloV6J35Ljax0lVqyrDqCFC51Mn5FbOj3d7rr1vag==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 12:29:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 12:29:51 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: Re: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Thread-Topic: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Thread-Index: AQHZhkTbVUQXDTDFfkyFfCTXeXaZY69bQhWAgAADRIA=
Date:   Mon, 15 May 2023 12:29:51 +0000
Message-ID: <1b880684-6e3a-08f9-f442-c5e0553f5eb7@csgroup.eu>
References: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
 <2023051534-portable-scarecrow-ec3c@gregkh>
In-Reply-To: <2023051534-portable-scarecrow-ec3c@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3141:EE_
x-ms-office365-filtering-correlation-id: 6e51262c-3a24-4f8c-270f-08db554014c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Nz/voWHxYSHxR3AdNAv0LN5Grz0rro0locnoCKAy9Fc9MUPCebjvGHIhBr+JFlXP4dItDghV+KkI0XAH/B3RlTwFb3RO1viGjq8UgjKuhwBPZdoR2ggKl469gg6nng/T6gdR5ymdDw0ETpHaOajE6X3HHvplv50S0dqSmtANewitojc7jLQyG2OrUlCgLMIDndZR/c+cJ1Ej7UARMDb//gyzyw/ya8P23VQ0JV/iwk/51pq5DnUDumy9bL7dig8XbzyNTNqezQVPFPSC0/iTQPDUwobNbafNN7Oorr9gZlKk2kixmyWgmEtJX7IUNV10UDn3AedBHnRdTWSyQm080UHhoPwLuhpN3+DhtihYiN/oxRMu2lks8Xl+EtaQIVj4gmxURgVQTH2D4+onDUIpxARHJzgivkljuhNBveLAikKH10PGStIybNOW3YUpfUUmQnY6Ho5YTUJXmD1vwT2hgBygZ0stpFJqSbp32A5ODbyQzW3DEU/AYtu3sbsLq2qDtXqJ9uBU7B/B5SDs37DWhoRj73RrNrPBfwc47nX0konu6BLuc7/AXL9riobH6cR4ZaKZcip8CmbN40EgQBeE5BfR22UdAl9sCLuD68Tc4sFBexccocH6QwIQkfeSyJcGXwPYrcn4Lc23p8v9UUkJ3lEhQuH0vmcqf9YXpEHfbuI43+fDgfR0dk8YH+D6Vw6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39830400003)(451199021)(31686004)(66446008)(64756008)(66946007)(66476007)(4326008)(6916009)(66556008)(478600001)(6486002)(76116006)(86362001)(91956017)(316002)(54906003)(36756003)(186003)(107886003)(26005)(6512007)(2616005)(6506007)(71200400001)(8936002)(5660300002)(8676002)(44832011)(2906002)(31696002)(122000001)(41300700001)(38100700002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDB4MElPQ3ZhZ0Jkc0ZnTjRyelFvWlFuTndHUnEwa1lRZUpmejl6VUwwc1kx?=
 =?utf-8?B?S2V3V1daci9TMWhueGJzU1NoQXBWN3ExK3JGdTBwZTRyTnZpbUtVOEsvVGZ4?=
 =?utf-8?B?N21lY3F3ejlGcXlOdWlOSkFVRUEzOSt3Q2xlQ0tHQi9lcE90YzlCejFTd2Ez?=
 =?utf-8?B?cEtGeVBOTmpldGZiODJUTUh5UjhtVFYrQkFCSVdpcnhaaUUvZjFrS0gzQkZ6?=
 =?utf-8?B?MlNBa0tzQTNIWE1DaWc0b1orOW54cllaZWJUKzhJZzBnMldPRWRYV3d3alpt?=
 =?utf-8?B?cXZFSk5La2ZreFFLMURwaFl6cWlzaFBGbHN5cGhrZCtBK0ZrYW92czJBZ3NC?=
 =?utf-8?B?UUt1YXd2TGNLa2w1aEI2aW9IUzczQzBUSEZWaExVV0twVlExTTY5cW1xVmVF?=
 =?utf-8?B?d3JZYkhEUEYvTEpxYk5oaTgrVkFjREFxTXN5VWxPUnYxT1hGOUFNZXIreXZP?=
 =?utf-8?B?blJHZ1lZZ0g0dENqRG85ak9FWmFHZ3ViVTh1aC9qRG8zKzl6RWlSTTNPaEdY?=
 =?utf-8?B?N21PQ09KdnBUNDNsS1crWDFLMmlnT0ZNWWk5OWVNTXFpdlgxTGRDVENvMC9W?=
 =?utf-8?B?OWJsT0tQNTZKdnljQ3h1TENuK0xOYkdhOVg4L2o1d2VTMFd4S29WWVEveGMr?=
 =?utf-8?B?MVQvNWI2bHVlZDl5QkJJWE5JUmEyaUxlaGZ1cUhYMmN3b1gzRGFjTDFIcXR4?=
 =?utf-8?B?eWIvb0p4ZDI4bzB3cmR6Z0p0NzBTaTNnb0pNWFhpWEszbng1NGtzTXRsRE9h?=
 =?utf-8?B?NHZGVWg1VkYwZTZ5cWJVbFR3bjhlckZwTlh3SW5HcjBEUW9PZXU2K3pNYTB3?=
 =?utf-8?B?UVRxQlVpamRFNUtGSXM1YTNRMGNqSlhqSEU2UlUzTVJWdG1vekI3VDVacFJW?=
 =?utf-8?B?ZGd4MmovZWdSVTdaQmdEdHBiSmdtUmhUcFQyNGtpaUViUEVjcjViYzVHRGZj?=
 =?utf-8?B?VWxlTUdYZEZtZGZsbDRJTmU1Mlc4V1BhQ3gxcUJTdEx3a3o3R1lQZndsTjlm?=
 =?utf-8?B?eEpJaFlyUU1HTXNzZWo0dWQvZmJHanlnelJYZHE1bnhsMjI3dFppbGI0bFFW?=
 =?utf-8?B?b3R0UlN3cDhub0pwbkxxOHpqdVpoaTNrbDVjZVc4SVBpMGFybndGTzdmaDFE?=
 =?utf-8?B?MlV3Njg2cGZSeWhSREF3aDlOeXVvZDBwOGNvRFVpaklkRTFLOUhTYkFuZWVj?=
 =?utf-8?B?cG4yaStWN3ZIUlFQUVJYMjM2OXJ3dTRSalNGNFZUUGhNdE5Jd0UwSXZPM1k5?=
 =?utf-8?B?ZStJQnFNcVpFK0R2clVlbnFtVVZnVWtNREI1TXpFdFVpL0RFYUhWYm9ubk8w?=
 =?utf-8?B?RzR5ZVdrc2NKVDVsaUszT0syb1o5d3ZndEJaeWpSMk1sUGxGSjBoNlllaW01?=
 =?utf-8?B?Y1Fjdi9MYU5DWXNBR1c4TCtvNWdtODcvNTZ6dnZ3WUlKQlRDU2V0T1Z6MzR2?=
 =?utf-8?B?QWFWaHF4aU43dGZoVFhNdEIzRWIvSjNmWjE3NTV6K2xVUGhuK2VoQzEvOE1Z?=
 =?utf-8?B?bUNzbXQyTU9JYnhYTnZ5RFBJN1QvNjd5VXcvN0JObkZyMzl5cjJ6YUNKSXlE?=
 =?utf-8?B?eHlUKzhQYXBSNGN0ZnlUUWxkaTU1WW9sdkxFM3dCdFBTYkxsc0ZHeS9LRjYx?=
 =?utf-8?B?V2pUK295MTVNUUdUdTVOOHRBMjFtRkNxSFdVZjM2Z3g4THhtTi9RODdIMm4r?=
 =?utf-8?B?Z25BKzkrQUFKUGdqa2U5MCtoZTdDYmMzbjI0WWFJT2xXWGhoYW5VQkFVdkMz?=
 =?utf-8?B?VFdwNUZjekNxd0dCMDJsT3pCTjg0WUdWc1B0OFh3ZVQyR2pCMVRSak5jWWhn?=
 =?utf-8?B?Qi9LM2ViNzV6QXBRQWNta0RabW9zNG5ubzhmR3hrYjgyTThmODM5cWVLMy91?=
 =?utf-8?B?elNSRE51a0doTWZsT2Z1TTlJRWJVUmdRVEJxeFRNcUFSOTBjUmt0S1hIenQv?=
 =?utf-8?B?ejM5UkdkdElnZ3VEVXF2YXFtRDRLTG9HTElEY2owdWFaZS9HR0dST0xmYW9Q?=
 =?utf-8?B?TlhnV2dma3FjVUZYZjd4SUJuVy9PQjZ2TTRqeEFZZWJIK0E2YW9XY2pleFJ4?=
 =?utf-8?B?bit1VzhWdC9nRHgveTF6c0lLdGR4eFNQU1pobG1iZjN1YzIzSmNMa0xISXFU?=
 =?utf-8?B?di9sNThyOFFaSXdmNjE2Zm5pTlM2TVppa01PTDBVaU5HRi9YeVlIbW1lSUtz?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55B1991D6E45548A9080648FC091534@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e51262c-3a24-4f8c-270f-08db554014c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 12:29:51.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5MgORJ+eIdHrhqrTYD2pjP+vf6rpP/rUF3W+Aip99Oa2xX/Bv78P1JVT+YThB64WZzAF98EE1gn3OMhOiuSA8StXcMeb3KfvnRy2J8/tX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3141
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQoNCkxlIDE1LzA1LzIwMjMgw6AgMTQ6MTgsIEdyZWcgS3JvYWgtSGFydG1hbiBhIMOpY3JpdMKg
Og0KPiBPbiBTdW4sIE1heSAxNCwgMjAyMyBhdCAwOToxNzowOEFNICswMDAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4gSGVsbG8sDQo+Pg0KPj4gSW4gYWRkaXRpb24gdG8gYzIwYzU3ZDk4
NjhkICgic3BpOiBmc2wtc3BpOiBGaXggQ1BNL1FFIG1vZGUgTGl0dGUNCj4+IEVuZGlhbiIpIHRo
YXQgeW91IGFscmVhZHkgYXBwbGllZCB0byBhbGwgc3RhYmxlIGJyYW5jaGVzLCBjb3VsZCB5b3UN
Cj4+IHBsZWFzZSBhbHNvIGFwcGx5Og0KPj4NCj4+IDhhNTI5OWExMjc4ZSAoInNwaTogZnNsLXNw
aTogUmUtb3JnYW5pc2UgdHJhbnNmZXIgYml0c19wZXJfd29yZCBhZGFwdGF0aW9uIikNCj4+IGZj
OTZlYzgyNmJjZSAoInNwaTogZnNsLWNwbTogVXNlIDE2IGJpdCBtb2RlIGZvciBsYXJnZSB0cmFu
c2ZlcnMgd2l0aA0KPj4gZXZlbiBzaXplIikNCj4+DQo+PiBGb3IgNC4xNCBhbmQgNC4xOSwgYXMg
cHJlcmVxdWlzaXQgeW91IHdpbGwgYWxzbyBuZWVkDQo+Pg0KPj4gYWYwZTYyNDI5MDljICgic3Bp
OiBzcGktZnNsLXNwaTogYXV0b21hdGljYWxseSBhZGFwdCBiaXRzLXBlci13b3JkIGluDQo+PiBj
cHUgbW9kZSIpDQo+IA0KPiBUaGF0IGNvbW1pdCBkaWQgbm90IGFwcGx5IHRvIDQuMTQgb3IgNC4x
OSwgc28gSSBkaWQgbm90IGFwcGx5IGFueSBvZg0KPiB0aGVzZSB0byB0aG9zZSBxdWV1ZXMuICBQ
bGVhc2UgcHJvdmlkZSB3b3JraW5nIGJhY2twb3J0cyBmb3IgdGhvc2UgdHJlZXMNCj4gaWYgeW91
IHdpc2ggdG8gc2VlIHRoZW0gdGhlcmUuDQo+IA0KDQpUaGF0J3Mgc3RyYW5nZS4gSXQgZG9lcyBh
cHBseSBjbGVhbmx5IHdpdGggJ2dpdCBjaGVycnktcGljayc6DQoNCiQgZ2l0IHJlc2V0IC0taGFy
ZCB2NC4xNC4zMTQNCkhFQUQgaXMgbm93IGF0IDliYmY2MmE3MTk2MyBMaW51eCA0LjE0LjMxNA0K
DQokIGdpdCBjaGVycnktcGljayBhZjBlNjI0MjkwOWMNCkF1dG8tbWVyZ2luZyBkcml2ZXJzL3Nw
aS9zcGktZnNsLXNwaS5jDQpbZGV0YWNoZWQgSEVBRCAwOTIzNTM5ZGZmMmZdIHNwaTogc3BpLWZz
bC1zcGk6IGF1dG9tYXRpY2FsbHkgYWRhcHQgDQpiaXRzLXBlci13b3JkIGluIGNwdSBtb2RlDQog
IEF1dGhvcjogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQog
IERhdGU6IFdlZCBNYXIgMjcgMTQ6MzA6NTIgMjAxOSArMDAwMA0KICAxIGZpbGUgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKQ0KDQpJIGNhbiBzZW5kIHRoZSByZXN1bHQgb2YgdGhlIGNoZXJyeS1w
aWNrIGlmIGl0IGhlbHBzLg0KDQpDaHJpc3RvcGhlDQo=
