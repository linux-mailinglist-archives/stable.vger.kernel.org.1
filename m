Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4A7973AA
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbjIGP2z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjIGPYC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:24:02 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2058.outbound.protection.outlook.com [40.107.9.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55B0CC
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKPj6rWOlnLYlb6lAiOMJZooNICw0VQk272IKM1WdHC3HJpQegiJljT1mUXumwPVmzb6Obi1SXCSiYJBnJwOK9Dm0KiHMNAL9GaDKRRGdQTohiTk3dfkYYo2/wIkg28DgLn1sipit6cApEnolABiqUcRAR3Ek3kPt9H23Hx68Gfv+uaiHc3CnkA2X3Vq+hhqAhzTVcsQls887yUXNqjcGalYv8iswZaeY0ULK0yPY5ZDxFl+dAKM3it2rnntquXVxWEVXbDUNa7Pw8MAWMyxQRtcWKN8C3WGjUrmxAsEThnByrYH/J4mmzQaFC6DAQjHKDnBbng8KpycIvEeY2hYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bP1p990fAeEVkLd19vcFmnZrw9rljTL9jCJD/jjhYg=;
 b=LljiMoE2xUexc+5dHxK/qt2I789RE4aVVOdAzamC1IXUGX8RYMc7MxdA+FLiLH9VUqCJ87bskQbGHDp7RwNDkCC4Kck73cEdHlCpyPNQVwPxvfo7Yab6Tyid1z0VI2ocZ1rUQ7fRoYjJ0O1Zqc+gmvkHhPB+tXz1Ki9o9uTml+abycm6m937vTFhkay0ujGY1LUOIVY0+g9KKTHpH7ZNt+URBuOmD9jR9Irj66e+EYrRLxv0pu5EHg75aeX8QdTbkQzylCW13mgf6Aywi2D41opmzd5UERJ/AZbPN7WN6xORuWfQPqhuPDr8e8+h/y5o4SlngVd0mhc99AF9yuzSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bP1p990fAeEVkLd19vcFmnZrw9rljTL9jCJD/jjhYg=;
 b=B9VwrUy5lmzrlvsPLk44jSldFRY3EU0oy/0dh7kexYzvncReE760kIUsj92CZctjTQhSOxgdMg+aATVuF5/ZcGzD5VCM1awKCK6yRfvIbEBs9tP2eTilGbSCLDATpC98euLZWI4js8wKGo4piW29GUA3oCe+jLaYLYrzIak3h626H3k8MppzCL6Pcg6+xsNcFHKeac40YklF9Q5fELsNJ2dVAXZqpI7a2ktmSnbIUEyvtPwNRcV3lCr4Fv3dO51XWXOIot1yWCOa0RxZ8DFfMihTbMYNaOyfN9ZU6TuMgQXC6qeqSOBjrTKEtT/3VaaCFC8fNVEKWm8Yn0Z4OoT0Bw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1524.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 14:50:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 14:50:50 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-stable <stable@vger.kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Re: Please apply b51ba4fe2e13 to 4.14/4.19/5.4/5.9
Thread-Topic: Please apply b51ba4fe2e13 to 4.14/4.19/5.4/5.9
Thread-Index: AQHZ4ZUC071+LDo/Tk2a1bXh5Eag/7APcUUAgAAA8oA=
Date:   Thu, 7 Sep 2023 14:50:49 +0000
Message-ID: <612440f6-2ff3-a054-118a-5f253eeddd7d@csgroup.eu>
References: <07cf81cb-50fe-591a-3c9e-5b6c39d311f3@csgroup.eu>
 <2023090710-perjurer-snub-bb76@gregkh>
In-Reply-To: <2023090710-perjurer-snub-bb76@gregkh>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1524:EE_
x-ms-office365-filtering-correlation-id: 4332a679-0cd1-43f5-edb4-08dbafb1d3c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sHtv+tz5K00MQfcfv58YyP3MzJkBEGOJNwv0EoAmxsAE2nvDsBlP/62SXj0YVmHvw2KakJBH2ZA8G7DSynkHHGrXWwa0yXkoWBXtXl+5h4g30zEN0DCWKCNSxJor9JV350aW2R/ElNwVyCKbWdgaJoKg7WSh3Y3huryLs16BOJcddInniwrZarqsUESS7pZ26oU4nhGz2O+IsgjW3YqaJoGDZVj0mfl/MRUie1+xwS3fMShnJ1VgSXlMWuO2QYreMrZjmq2jh7mj+0bLsuH36+F9wMfu2tY+7PAQ6KlQIZ9xA49m1Nwl8bGsgMTq3c3qFJUOVMZlpHkKm2ae3ZBDXn/rASAyMHtsNyImGJro+B4JDjAKMapV0PY2CYlKvtlSq/Ut6KqbJp9//0RUjepJ5IqdTvE1JyeT8rm7KNUrUnDaHfxYWSGfQ+y35kQq4ETFunz7B0G8h5jsRIj0DyETBftxtoM6fmcmt18zQ74mJPWvwlbyZMRBp4FF1SDLAJUlybEjfbXn/Q5HlRpn25NcKX0cNAe9CbIJEIRjcJnBuEBJLA637Z5P9/yjXWF6JY5gOriaFfg8AjNafvZY0Y3vnD4b9MdEUR5oEzbrS/TeNr2dIfX3+al93B2B1UjYMdjt4qIZ4hk1puw5CfpLadV4vc/u5ZXjIp/GUCjocbq7y+EjJ/h9mRX2MQO+TkVYpo2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(31686004)(122000001)(71200400001)(6506007)(6486002)(31696002)(86362001)(36756003)(38100700002)(38070700005)(107886003)(2616005)(66574015)(4744005)(26005)(6512007)(83380400001)(478600001)(91956017)(76116006)(8936002)(8676002)(4326008)(5660300002)(54906003)(66446008)(64756008)(66556008)(66476007)(6916009)(44832011)(66946007)(316002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1ML3dJWm5qRzFXcUozaDJHOTZmbjA4NnBmZUJlTTVjdDFHL0NVL29rZFJx?=
 =?utf-8?B?aWhpNWN1OGg3cDJwQkt1NmQwQjBDa3lXaHlnaFF2c0tSd3RLMDZZT0NjNDgy?=
 =?utf-8?B?QitXT2VFbmNHbGxWRjhkb3duWUh2UkRzZW50TXlhRzQ3TWgvenlyZmIyR21E?=
 =?utf-8?B?TUxwbTI1YW5Qd1JRSjFVYkR1a2RlQ1RFQWtieTZrQ2RlVXE5OENOWTJqZEtG?=
 =?utf-8?B?c1JGNnVHd25qZTVNcVlOLzlsL2RxeFEwRU4xVEhsajN6UWRSbEZZNkdnZEF1?=
 =?utf-8?B?UUJPY2pIVW41cFRybXZudDQ4RnNNWGVBZkRqcmlobkUzOWh0TlROUkJ5LzNM?=
 =?utf-8?B?T3NLcDVPSCtMdEhkSVl1SkM3M0xKRGRTTnhXREVrbTJ5TSswRTVWS2xiT2hu?=
 =?utf-8?B?dW1ycWNTb1hCYlBxNHlYSFYzTExYYTBrRy9JNllRdTJoTUlTeVlXRi8vSnpr?=
 =?utf-8?B?czZOSk5kc2NlY1Z4TXMwanh6THFDNnYrcWk3N3I5MFBTTVlIaHVRaU1RazVl?=
 =?utf-8?B?R1B0L2M2TlBZS2RhMEFQL2l3UmsrWTQyekZsQ0RqUlZjbXg5cVk1ZGoxRTg1?=
 =?utf-8?B?QXh0Uys2OEd6Uml2b3NZcGZIaEZIeERHbDdIQVhyRmV4Q2JoMUFUQXpmZUVL?=
 =?utf-8?B?bFdnTFA3NkpmV3JFN2xOMEM1S0llU2Q2TVFaQlBKRjE1K1J6TzljYkdlMmNO?=
 =?utf-8?B?b05PTzdRR3FGdzNjZnJnVVB6OHQ0NG85RWVGZENhL1Y2Z0t2eHpEQzAxb0cx?=
 =?utf-8?B?THhiK2VvSmJPTzJVcFI2bmFNSWV6N20xWUw4Z2oxMDJTL05hNm5ENVQrTEJS?=
 =?utf-8?B?MXRWZ0UySUFpZTNnTm1yYWVLUWdhc0lXZEdNejl4VnFGNDAzVm14cmVCRWo3?=
 =?utf-8?B?bUdVK09uVWJmc0d1Z2VJWXczVHFoNnptSUZhMVlETFRNWVZTaytYU3ZObWFK?=
 =?utf-8?B?WmVUdlRwa0F6Vm96Rk9MTjRCTDd0bjJDeExab01sSmg2cVVLZ0g1eHJDa2x5?=
 =?utf-8?B?MWxqbUNTMGlhSGxta3AxeFhVZWZjdnhPaHZUZ3orN3E4a1FXeGc2TWdIek1K?=
 =?utf-8?B?N050VE9YYmFCcUlnaTVyTmRjWEVoZzYxaWhMMXBLc2RJUVZZOHgvWkxBM2Y3?=
 =?utf-8?B?TmpyZ2VhVTQ1NEZxRFF1WUQ4QVhIOWFZSUZ0Qk9zWnIyTkVwaXA4YUM0YVp3?=
 =?utf-8?B?bG9aZXAvMWFPTktIWjByRDFSTHR1QytURUI3M2pXaHp2Z3l5NWFYZUpiQ0ls?=
 =?utf-8?B?L2hsU1JTR0xxWlJ1L29rNlM2Y1Zud2t0Y2U3SU52cUNReHcrVlhOdUcvTGRu?=
 =?utf-8?B?VDJ5YVVrVFVZOHh1TnM0K1FXMGcxdlFhYmcxZUxYdnhnQjBpeGUzYzA0MTA4?=
 =?utf-8?B?M2ovbFd0M3JYcFkxaGR1UVBRWWk2TTRKdGIrdmRwTnhpU1huSTM3WXo5R3Bp?=
 =?utf-8?B?K0FsV2lybUpqN2NZY21HSFA0ZExmSFh1M2JLLzUwMzFkZG1oTUNEZkYwSzR2?=
 =?utf-8?B?aWRubVFGSW0wL2Y4ckFqSFd4SE0vT1A0SGhHc0RSTm9TUmlCa0V3UE9FRWxj?=
 =?utf-8?B?SWdnYnlxWDVaRDI1RlNQbnl4TGs5MVg1Zk5kNVJseFkvOGVMbHJtMWVvUUpK?=
 =?utf-8?B?RW1reHZla2pPZ1FqMXQzQ3ZNREhDZzRudjdqbGt3NCtnVjM2dGRqVlprazVl?=
 =?utf-8?B?OUJiZG1Na09FS2x6NEtHN2IrUWtUVlEwSU1rMmpDazJ3ODljUHo5OXJsaUJw?=
 =?utf-8?B?TXNRbnRiMy9KQ2hHMnNsZWNsa09LRkJlZEcxNGROdWFmU3dkbFRuZlBYbjVF?=
 =?utf-8?B?dGJodzkzdXBKRURGVnhUOTZxejVZajhmNkF4RFdoeVlZSTEvQ0hmaVhtU3dp?=
 =?utf-8?B?cXdGTk55UldPNHYxekJUY01SQXNyRk1xM1N5KzNROHhRSnRkT1BzK0d2ZHVO?=
 =?utf-8?B?NW40cFVhVTYxZzFiOVZpdzZBYkV4TGpBK3pmRGpBb0V1NFc4Q1QxeG1mL3Iy?=
 =?utf-8?B?dUY1Z2lyY2VBVW5aUVNBVlIwZi9ML09IY1FwYkYxU1BDTHNld3V6RGtXTUFj?=
 =?utf-8?B?eWNuV3l1VStQR2gxOW9wN1hTZGthdUFucFh2Zzk5UlR4ZVBncHlmaUJxek01?=
 =?utf-8?B?dkMzYlgxZUZyT2VvNDhDNWNOUjhUU0g0MmdmZk9aR3Q5dlpxL0JPOXFrbTBx?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD31DEC9888B34C82933932880AAD68@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4332a679-0cd1-43f5-edb4-08dbafb1d3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 14:50:49.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksTwhPDYN+/sbL0BDW5lUilqlSFcrT/9hv84XBpN2bD3ApdMXfPlU2EiTI04o+yyYuiByjv83M8+Bb3iLYOufZzQ08FE+XKuuKKLGJkF7Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1524
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQoNCkxlIDA3LzA5LzIwMjMgw6AgMTY6NDcsIEdyZWcgS3JvYWgtSGFydG1hbiBhIMOpY3JpdMKg
Og0KPiBPbiBUaHUsIFNlcCAwNywgMjAyMyBhdCAwMjoxMDowOFBNICswMDAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gQ291bGQgeW91IHBsZWFzZSBhcHBseSBjb21t
aXQgYjUxYmE0ZmUyZTEzICgicG93ZXJwYy8zMnM6IEZpeCBhc3NlbWJsZXINCj4+IHdhcm5pbmcg
YWJvdXQgcjAiKSB0byBrZXJuZWxzIDQuMTQvNC4xOS81LjQvNS45IHNvIHRoYXQgd2UgYXZvaWQg
aGF2aW5nDQo+PiB0aGUgcmVsYXRlZCB3YXJuaW5nLg0KPiANCj4gNS45IGlzIGEgbG9uZy1lbmQt
b2YtbGlmZSBrZXJuZWwsIGJ1dCBJJ3ZlIHF1ZXVlZCB0aGlzIHVwIGZvciB0aGUNCj4gb3RoZXJz
LCB0aGFua3MuDQoNCkFoIG15IG1pc3Rha2UgSSBtaXhlZCBpdCB1cCB3aXRoIDUuMTAuIEJ1dCA1
LjEwIGFscmVhZHkgaGFzIHRoZSBwYXRjaCBzbyANCnRoYXQncyBvay4gVGhhbmtzDQoNCkNocmlz
dG9waGUNCg==
