Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B33702FA3
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjEOOZQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEOOZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 10:25:15 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2052.outbound.protection.outlook.com [40.107.9.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66719F4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 07:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y12Y7BEauCRr1dFfGLp3WPe8BM/VHsLQ3m78gXuDo0d2cNoVphV/Ak/BI2/bIkxM7SL0d/NkGcvnSbxhzyoy2wc9UzGhCEhzSxUP5S54nBZIHdCKfk1emo7NepcpAcGhLNl8chg11D9syHl4iEEF3tdXk/mdTKn1+Mz5/XbXpw82xav6U8A/j8rfr2pmiuBADwEJEax9+GQaRtnsfUESxZyIuT6+iQ3UzXuHQyE/KP7fqtYi0z/e1xYet79C6ftVJt3TNy5WsEDnjhJu+RBsSCyZSSjybYi+StiuP56YlqCXl4pX28qniarRAuGhesNE+MT/zoRh0chhSerITo0mEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQeiRvvGt1hx69pll0BclBwwdSwCQdJXHduQohnFZsE=;
 b=LcZudXlk7mb5Bf8f8kA1IpEnlfQWa4VL+gp+gWig2qprU7jW9reP3xCYdvKgLsghiAcAF9/xPA+0V6JsEhGDL8NhI0oHgPg1Lno8fTjkfX9fkZSm2PvFONz4sI5eJYwDsMx4pWsSodS5dXh0jmPRdGsTmUj7Bdjjxrgk9taBUBlYG9gFUbvsbkCXoSDsMqcB1oM8IIdAPWwp2D6XxCapKydgro2hQHHGCUqH/rrZfrFJLtoH7oMooZV7bKqNiIYrTJpUmgQ726ahsRpmZBDQBIW76IFt9uS66b6BXWT+587/f5C0NyoXK0MohXaOTfYZbRzRck2oYWgFBxka/Iei7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQeiRvvGt1hx69pll0BclBwwdSwCQdJXHduQohnFZsE=;
 b=bkC5WecP6VASQISTa2EATg2c6j8jv0hed99SZsmPCCBIa6acQJt2ZYMeuZ2z+uO9V9srwLVg1EcvGHYh8Xul4QurSw4QvPG1laFjjI/mQD81ygCRZah02r0I71GZMZqMbKMBXynhk30ZLP1phdw7Pa5I/IursXrWEFSikGBnSmrqIN+8yVoD2nJCWBNMmZyb3X+9Rk4RbaBOuU34mNfOHP1IVJxgaRwlVMy2jcOSadiOxNxQYZaUiWO6wZ167l44TKtBMmKf39IFcP31j8U7z6BcPAw3FBlk+vJNgJUeOaqFr654ayZ57y6i5anU1Npe8hpHKndd97OUBLRQzmKjbQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2431.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:25:10 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:25:10 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: Re: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Thread-Topic: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Thread-Index: AQHZhkTbVUQXDTDFfkyFfCTXeXaZY69bQhWAgAADRICAAAD6AIAAHz2A
Date:   Mon, 15 May 2023 14:25:10 +0000
Message-ID: <c4f8a49b-76b8-0b72-3ea0-86c591bc28a8@csgroup.eu>
References: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
 <2023051534-portable-scarecrow-ec3c@gregkh>
 <1b880684-6e3a-08f9-f442-c5e0553f5eb7@csgroup.eu>
 <2023051543-unwound-squealer-f3c9@gregkh>
In-Reply-To: <2023051543-unwound-squealer-f3c9@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2431:EE_
x-ms-office365-filtering-correlation-id: 9de472e7-c33a-48fa-6b33-08db55503075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Z2XUxvtJnLn/rWliRn3N8Son/qaXOlWFORn1hCXMZWQjrt4FkXk4QesCZuqOK9ssJDBh6Udi9m3gqtdD3sBez7htiYcvzHgWP9F/HNdYSiIeTRgh7zkrOgsmbUyQL1QpgSTg2k8rl6IxmRgWeUna3QxrbfQqbwngSYUQQr4nplpwyGlLQi2pOEdQyGiBGE4rgztwlgl9YwPeGJfEFqYozpt41/ckxhMOPz1fg40OosOcnoz6Goxzuk8EpePGOjtDm8QzWDOk+7jIrCv+zIlSZ6585ef1GNQ6FmLsdWseHt6cGsTgdY2SjWP+P3JrAhmT6yPJJkWxd+xK3ntKHRQMBQzAANe12gIvgUDxgy98suDbAr8WX0uwSCfAuKFXoid9qGFN2vERCTOnKZQLy/uKQK0kxLF1YCeAV4HwJX7vBK9k8B6f/Kux/zp4uaDsYDlO6nJ4cLC5/psZqbBXymMvGlSRAyZJOvLOLXHFQIKtQ5SKbJnGFKQqzQT/NxaqTgPDziyRLQ4/zunDOpDC/NUiRBNaHcaGkJEJIZ/BbSFURKm/kU/GvJvCd0Xz2u9ND7oPNj08u0pmkiBNauG44hRsEDUoj7/l7GN4/XcSJw8fuFSaq1rS67nQxLeg4MU8zKzR/lI0Jfk/cNUeY9R9HR/rXRn+Cev9NxCiAy4GV2tCdjc5F56Z5zzOEGbxSGl8CZ6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39850400004)(366004)(451199021)(66556008)(54906003)(478600001)(6916009)(4326008)(64756008)(66446008)(66476007)(66946007)(91956017)(76116006)(71200400001)(316002)(6486002)(8936002)(2906002)(8676002)(44832011)(41300700001)(5660300002)(26005)(107886003)(122000001)(31696002)(86362001)(38100700002)(38070700005)(2616005)(6512007)(186003)(6506007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFZ4LzdYQUUyK2YwL3JNMWxSWC95NzJzU3Q3bkFqeEVJdGR0allpbml4V1FN?=
 =?utf-8?B?ZGREM21OblRRbllYS3hBV2ltTHFsK1M0dCtrbXk5MWNVOG1kZkNsRjUwbjQ5?=
 =?utf-8?B?WmNiMkdheTJoeVNqRXRUMk1EalBnSklBS282d0p2MndSbUlad2tKVEdZSW1z?=
 =?utf-8?B?MklCVnlqY1VkRStERkh5cWJyemhkNVNaaWFaMXA5dE82MDdJVTIwOGw1emlh?=
 =?utf-8?B?MjF5MkZ3VWJ6bzhjZDcrZE82bjY4cVRPVC94VGJmWFB1WHI4RDlHK0ZyRjR5?=
 =?utf-8?B?ZDZpZFRteDN0VlZTVVA1Vnk0eEFJOFJISXJJRDUrTXllUmNnWnpyNXhZT0w0?=
 =?utf-8?B?TWZDejQwb0xjK0ZYWm1MKzBRck50WHpycm9qbTlzR0lIaSs3OHNZaUlQdVlP?=
 =?utf-8?B?anRKRDd3dG1MWkY1ZzlBcmpSbjBOcnFnbzNYMUh6Y2RZU0NzbmJSUzVOczUv?=
 =?utf-8?B?WW9qUjlDZXgvYkM1bFpYQ2thWWIxTm5lWmV2cXg2YVNQNVZ5cHRIVThpcHN2?=
 =?utf-8?B?ZGliSldEdjJxTUFTUVNmMXRTKzliNHpRZ09RU2R0SWtNS0E4OTBodmVRdEMy?=
 =?utf-8?B?SFhXdHRJdFFUWDNLM2swUVVMY0NNVVZVd2VvVWJrNmlMYWl2ZGxmNDAzQXg3?=
 =?utf-8?B?MDNaWmZrV3VNMlgwVm50Ni92Q3N2M0lseUhzVlNyWEREdk9pUnN2ZUI4cVJQ?=
 =?utf-8?B?OFRtb3E1aWRTSVYvdjlBODhvb3o0SjRtekFMMHBYUkxBT0hjZUxGdTNXcE5k?=
 =?utf-8?B?dldvbEdydnp5TW5ESFZBQjQ1ZEViSTJLTnRoOFpsaHdIc2ZIS090S05nUzVw?=
 =?utf-8?B?TDB4WUFnYzY2Y2dTRjlGSUwyMGRjNEF0dGhXbDBaWlRGZnlIaWczTnc0ODVq?=
 =?utf-8?B?UHZkclhGUUx4dlo2aWl0WjgwaTNUZDFRRDNvcm9LVkN2a3FQTEdGZjVWNFhh?=
 =?utf-8?B?c3lCb3p2RjRBUEtrWHBtZC95QmUrbmcrOXhGblVaRTkyY2NuWDZkQXdWL0Fy?=
 =?utf-8?B?SXlMbnBoTy80ME9VRHlXcXQ2SWdiMWU5OTZnaEIzSVpNblFqVmR4dERPWGpz?=
 =?utf-8?B?TWU2cGdQTG90U2M3QlhlakRnckZac0QrK000S2FXYjN4RDNHZzJZcGdVcmlY?=
 =?utf-8?B?SG1QSEc5YWhSUC9vNE9tcHVVN2lqVlp3K2ZLbHZRYThnVTc3OVhZUWIxN3VK?=
 =?utf-8?B?TUdTcndNRU41MHhRRzR2aGM5UWgreGVxNDdXWWdyOVNMMDVGS3Fpazhjb2tE?=
 =?utf-8?B?VnhWM25LOUZFTkR4YzE5bHE1NENUM0hkcFFVU3VBRDN3LytjNXVDWldsT3Bz?=
 =?utf-8?B?ank4WDlMOU56Qy81N2ZOV0JHanRnMW1NMVBXN0FITXhpUk9nUWRTZ3ZiN1lr?=
 =?utf-8?B?bXVGUmJlS1AwUzd4RHJSRmo5dFN2VU5MUnRKa09kUHlpODE0cTNvZTlYWUJu?=
 =?utf-8?B?bllCK25QSEVaTTZ3K2tlRzVVTnV0L3AxbWpoYmptcFdiMFdMdFlObUJ6QzZG?=
 =?utf-8?B?UEhiMGsxQ3Fvbnh5ZUE2TkZtKytxV3haNjk1Y1l0NzBOa1dOaGMzZlRoQ1lF?=
 =?utf-8?B?ejg3VHI4UnQybU1UNm15cDNESWZCQjJlMldEM3V6aEswT2JDaXBGdFcxU1lR?=
 =?utf-8?B?azgxZDJPcWpZRFJqcFFxTXFnejB0NVJzSEhIL0Z0WXhtelpHakQvazNvWm5L?=
 =?utf-8?B?MFlkM3F6MlMzWDEwUkpIVW52RjBtZzB6ZnIrOERobW94cmdrUFRvcW9pMDlR?=
 =?utf-8?B?SmdlS0dnRjJ5SWR6SURqRVRCdXE3cVhsK0xHMmd1cllQbTdXSE52NHlVdWVV?=
 =?utf-8?B?cjlzUlFEd1gvQlZzQ2hpZWgxUjRWQmI2ZGY3SmkrT0lRSDZycWZkQ1daWnpP?=
 =?utf-8?B?d3h3UjlUNzdEaysrWGNwelZDV0c1QXIwaEk3TUlXRUJWSS9ieDlZQmFzdDZm?=
 =?utf-8?B?bnh5a2x4WkNTWWdpdEpNSmN4cTBkSjVEcnpMcUZDajBmUUpWbUhIenYrRUNU?=
 =?utf-8?B?eEFXYlRROG43bVhDazdjalVnK2RFYkY4MzFsMTJmZUNMcDZGQXNWRTd1WTZz?=
 =?utf-8?B?eE13SzJMdTlFVVRRaFVPZFVkUnZDUGcxRnYxUGJPOUFRTFI0RU0yT203cVFX?=
 =?utf-8?B?UTdRL3czSk4wTWN0cHhtMXI4MmdZOU0wcnBNVVJHaVljU3VGU1hpRUsxSDhS?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFED5CC357ADB844833046EECF65DC17@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de472e7-c33a-48fa-6b33-08db55503075
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 14:25:10.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQX33iFRH9JbUf5qO5ikNhV0x0sMSeTaegv9aCGdxNZD0I4v/wR279dgp7vz0GUXlRRZU4WCTT1DSm5PI8LLQeBGbSOaFzvlEemDLF2ZrC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2431
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQoNCkxlIDE1LzA1LzIwMjMgw6AgMTQ6MzMsIEdyZWcgS3JvYWgtSGFydG1hbiBhIMOpY3JpdMKg
Og0KPiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAxMjoyOTo1MVBNICswMDAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAxNS8wNS8yMDIzIMOgIDE0OjE4LCBHcmVnIEty
b2FoLUhhcnRtYW4gYSDDqWNyaXTCoDoNCj4+PiBPbiBTdW4sIE1heSAxNCwgMjAyMyBhdCAwOTox
NzowOEFNICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+PiBIZWxsbywNCj4+Pj4N
Cj4+Pj4gSW4gYWRkaXRpb24gdG8gYzIwYzU3ZDk4NjhkICgic3BpOiBmc2wtc3BpOiBGaXggQ1BN
L1FFIG1vZGUgTGl0dGUNCj4+Pj4gRW5kaWFuIikgdGhhdCB5b3UgYWxyZWFkeSBhcHBsaWVkIHRv
IGFsbCBzdGFibGUgYnJhbmNoZXMsIGNvdWxkIHlvdQ0KPj4+PiBwbGVhc2UgYWxzbyBhcHBseToN
Cj4+Pj4NCj4+Pj4gOGE1Mjk5YTEyNzhlICgic3BpOiBmc2wtc3BpOiBSZS1vcmdhbmlzZSB0cmFu
c2ZlciBiaXRzX3Blcl93b3JkIGFkYXB0YXRpb24iKQ0KPj4+PiBmYzk2ZWM4MjZiY2UgKCJzcGk6
IGZzbC1jcG06IFVzZSAxNiBiaXQgbW9kZSBmb3IgbGFyZ2UgdHJhbnNmZXJzIHdpdGgNCj4+Pj4g
ZXZlbiBzaXplIikNCj4+Pj4NCj4+Pj4gRm9yIDQuMTQgYW5kIDQuMTksIGFzIHByZXJlcXVpc2l0
IHlvdSB3aWxsIGFsc28gbmVlZA0KPj4+Pg0KPj4+PiBhZjBlNjI0MjkwOWMgKCJzcGk6IHNwaS1m
c2wtc3BpOiBhdXRvbWF0aWNhbGx5IGFkYXB0IGJpdHMtcGVyLXdvcmQgaW4NCj4+Pj4gY3B1IG1v
ZGUiKQ0KPj4+DQo+Pj4gVGhhdCBjb21taXQgZGlkIG5vdCBhcHBseSB0byA0LjE0IG9yIDQuMTks
IHNvIEkgZGlkIG5vdCBhcHBseSBhbnkgb2YNCj4+PiB0aGVzZSB0byB0aG9zZSBxdWV1ZXMuICBQ
bGVhc2UgcHJvdmlkZSB3b3JraW5nIGJhY2twb3J0cyBmb3IgdGhvc2UgdHJlZXMNCj4+PiBpZiB5
b3Ugd2lzaCB0byBzZWUgdGhlbSB0aGVyZS4NCj4+Pg0KPj4NCj4+IFRoYXQncyBzdHJhbmdlLiBJ
dCBkb2VzIGFwcGx5IGNsZWFubHkgd2l0aCAnZ2l0IGNoZXJyeS1waWNrJzoNCj4+DQo+PiAkIGdp
dCByZXNldCAtLWhhcmQgdjQuMTQuMzE0DQo+PiBIRUFEIGlzIG5vdyBhdCA5YmJmNjJhNzE5NjMg
TGludXggNC4xNC4zMTQNCj4+DQo+PiAkIGdpdCBjaGVycnktcGljayBhZjBlNjI0MjkwOWMNCj4+
IEF1dG8tbWVyZ2luZyBkcml2ZXJzL3NwaS9zcGktZnNsLXNwaS5jDQo+PiBbZGV0YWNoZWQgSEVB
RCAwOTIzNTM5ZGZmMmZdIHNwaTogc3BpLWZzbC1zcGk6IGF1dG9tYXRpY2FsbHkgYWRhcHQNCj4+
IGJpdHMtcGVyLXdvcmQgaW4gY3B1IG1vZGUNCj4+ICAgIEF1dGhvcjogUmFzbXVzIFZpbGxlbW9l
cyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2YXMuZGs+DQo+PiAgICBEYXRlOiBXZWQgTWFyIDI3IDE0
OjMwOjUyIDIwMTkgKzAwMDANCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gSSBjYW4gc2VuZCB0aGUgcmVzdWx0IG9mIHRoZSBjaGVycnktcGljayBpZiBpdCBo
ZWxwcy4NCj4gDQo+IE9kZHMgYXJlIGl0IHdpbGwgYnJlYWsgdGhlIGJ1aWxkLCBnaXZlbiB0aGF0
IGl0IGRpZCBzbyBmb3IgNS40LCA1LjEwLA0KPiBhbmQgNS4xNSwgc28gcGxlYXNlLCBzZW5kIGEg
YmFja3BvcnRlZCwgdGVzdGVkLCBzZXQgb2YgcGF0Y2hlcyBhbmQgSQ0KPiB3aWxsIGJlIGdsYWQg
dG8gcXVldWUgdGhlbSB1cC4NCj4gDQoNCk9vcHMsIEkgZm9yZ290IHRvIGJ1aWxkIHRoaW5ncyB3
aGVuIGNoYW5nZXMgYXBwbGllZCBjbGVhbmx5IHdpdGhvdXQgDQpjb25mbGljdC4gTXkgbWlzdGFr
ZS4NCg0KSSBoYXZlIHJlc2VudCBpdCBiYWNrcG9ydGVkLg0KDQpGb3IgeW91IGluZm9ybWF0aW9u
LCB0aGUgcHJvYmxlbSB3YXMgdGhhdCB3ZSB3ZXJlIG1pc3NpbmcgdGhlIGJlbG93IA0KY2hhbmdl
LCBicm91Z2h0IHVwc3RyZWFtIGJ5IGNvbW1pdCAzYjU1M2UwMDQxYTYgKCJzcGk6IGZzbF9zcGk6
IERvbid0IA0KY2hhbmdlIHNwZWVkIHdoaWxlIGNoaXBzZWxlY3QgaXMgYWN0aXZlIikNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGktZnNs
LXNwaS5jDQppbmRleCAxYmFkMGNlYWM4MWIuLjhkZDZmYjM2NzEwYyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMNCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtc3BpLmMN
CkBAIC0zNzAsOCArMzcwLDggQEAgc3RhdGljIGludCBmc2xfc3BpX2RvX29uZV9tc2coc3RydWN0
IHNwaV9tYXN0ZXIgKm1hc3RlciwNCiAgICAgICAgICAqIEluIENQVSBtb2RlLCBvcHRpbWl6ZSBs
YXJnZSBieXRlIHRyYW5zZmVycyB0byB1c2UgbGFyZ2VyDQogICAgICAgICAgKiBiaXRzX3Blcl93
b3JkIHZhbHVlcyB0byByZWR1Y2UgbnVtYmVyIG9mIGludGVycnVwdHMgdGFrZW4uDQogICAgICAg
ICAgKi8NCi0gICAgICAgaWYgKCEobXBjOHh4eF9zcGktPmZsYWdzICYgU1BJX0NQTV9NT0RFKSkg
ew0KLSAgICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodCwgJm0tPnRyYW5zZmVycywg
dHJhbnNmZXJfbGlzdCkgew0KKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHQsICZtLT50cmFu
c2ZlcnMsIHRyYW5zZmVyX2xpc3QpIHsNCisgICAgICAgICAgICAgICBpZiAoIShtcGM4eHh4X3Nw
aS0+ZmxhZ3MgJiBTUElfQ1BNX01PREUpKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHQtPmxlbiA8IDI1NiB8fCB0LT5iaXRzX3Blcl93b3JkICE9IDgpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
KHQtPmxlbiAmIDMpID09IDApDQoNCg==
