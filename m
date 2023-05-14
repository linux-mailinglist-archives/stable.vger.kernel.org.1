Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E47701C83
	for <lists+stable@lfdr.de>; Sun, 14 May 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjENJR3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 14 May 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjENJR2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 14 May 2023 05:17:28 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2070.outbound.protection.outlook.com [40.107.9.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67AF9
        for <stable@vger.kernel.org>; Sun, 14 May 2023 02:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjX+w5dASmap3xF6RHku8pl5OPzZhTgOSfEEvo8LHrk3bZq0lios1vHMTnUvrdBHuCCObM3f4c0tScMqvTt2DwyROnSkhvmgWYCPpRocx8Hns//hRHK+4XTXhRbN1UCsZp+Wquc0/1SvZAn+KUlYWaBd2SZM4FnmFG/EvkiKbkz597rP+rq+27HonPQNf70bIVJncaWcy/zjFWAyYpwusnHs9XdatdR5CwPPSMq/vG+LFOoko56MxQH7FMrVFGhm7YB3X757bk8LEoS8c5J/usF4+aqKq6fCqHOXJrzkpATXhvqw9uKW/EMS97sMGXvFCWrQldhffa7yAkDW6Yr3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGqB39fT44EkyQ2JX/N7+W8ci+AHdST1p/zR7Om6mJY=;
 b=L2OR5stdCB/fS+dtzgz1yOYmJKWU90BWpn+iSJCQgiYKCS/6SIPR8MCnqzhU2cAsEiEHjAQgmTxmiw0j7arSxlNSUdGEM4uOvcSWdEXEMNND2SzgxKDjOBx1GCAagpqQlD4UgBSd2TE6nX3yQfvdLtgMopOpeSW6OEzkpsKxb5lJ5PlWCdVa/MKWcgryLH7PE63kScNO9gnCuIDKLKe5RQ9d1/E0V3CL5VdnBgpnAySDr3xyJt3Z0A8tDnquvpolZt3JzjSQ3EU1VA/8Kt/RzpIibJfR1a7+Fp5hpZ3ComiwTBxoGOFGlfpfurs3eMmSUkP39FYe+lVrtpPc7NbCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGqB39fT44EkyQ2JX/N7+W8ci+AHdST1p/zR7Om6mJY=;
 b=vFxd3p6QhfyrNkmw9mbNZ6Secz59edxfb/3zYp4qxxoYtt2G+gm2fsXbDPmvvyGP6dqxSMlmyj2nKTZLIVYhJvCC4DJB4Pc4y8NdUH2lNOWjrg0U8kbwMvTPEAlnZiVWAYAiHnkqO2oBR9rdl+IIFGRfyFz1XVTAZAIqQleYvTKR93/shDEx3GPzeZZRWlnlyAy3ihZ7ERp7Xp/ctatfmzJ0LM2P/Lsqup7gZK/+8xpFOATZvvrmt01QSLH/hM3NMOx87k4kE2O+/qhzSnK+A2nID5MSp6kLsKaWzPHgP/yM+jIcdRIhhTM5cSTJN8Rup3qrdXkW21tD1ompSmZnMw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2037.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 09:17:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::447b:6135:3337:d243%3]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 09:17:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
CC:     TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16 bit
 mode for large transfers with even size")
Thread-Topic: All stable branches: apply fc96ec826bce ("spi: fsl-cpm: Use 16
 bit mode for large transfers with even size")
Thread-Index: AQHZhkTbHONIPOaSQkGj0jVQh98GOA==
Date:   Sun, 14 May 2023 09:17:08 +0000
Message-ID: <85d85262-30c0-6362-acb9-273c831c2c71@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2037:EE_
x-ms-office365-filtering-correlation-id: f8a0f503-58d0-4f73-11e8-08db545bfddf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ut9hYAsmWD0dNAestCeoDRn/z5pYMAT4f8iuKD92pcOCfy3STRNShw1oowE4/XMcQ0KkDK02raigiZHKmSa0DhfovctxqGDMCEGtV5tzrw40uao70gcu0xZN6ykYLnICKGk5tmr4hBl1N4sgJ8tsKyuxyawGcqQkZwiB9vK8Nf7pe31DxgQeddEunyCyjbgsoriAaTwbbaf41YfQ1ob/RE8w5EvvKKC6yg4MJiQWTYR04wDPKJLDbjtkU5vk2oergYyhKjzk6y9ZmBA0K4HMFPLWFl1QMuHp0Xg6uOe8lnzcg4GY6KFFMB42MQKQAaj1Mv9LCatZ90GpXzUtV791ZhCriI05IWpZ/3zEh3Ux239jOX5EmDI3kjK4VYaxKe3hoYxkpqlmi8si4Cj/iNt/FnyFd2WoQXPLcAgpNEy2SnePaDWmny9T0WyB48Gsj1cUrtrxQ+5HzQyQrYq2wNC+YDgfUKhncSNcuUl3DLkoJcNNGBXNiSL4y1XIg04IaMJbbP8cB9PdNyJhhozalU1zGY/nchOFGC3Ed9sPGl6cSIwtoxNVq8t2QNC0hV4EtQyp1iHAQ6pO5qsz7ftuM7fGXL+SdEqAISBHgNbJb5vSk+cn1rCdptMW1SnFjBCqculEjlXfVp49BmWLD2Fg5KS3jZL3bmU6RK4L/czxaD7EmrsQ3J1Og2Cu420pqS2WoZVA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39840400004)(136003)(376002)(451199021)(66476007)(66556008)(66946007)(64756008)(66446008)(91956017)(76116006)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(110136005)(186003)(71200400001)(86362001)(44832011)(2906002)(4744005)(8676002)(8936002)(31696002)(5660300002)(36756003)(4326008)(41300700001)(38070700005)(122000001)(316002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3ExWU1xZWg3SkkxMU5HVWg5TGNQOHBDQ3hRUXVWUWk2TjNkTDdJRm8yTE41?=
 =?utf-8?B?cklsOWtTWGx3YjJQVlVkVjIrMFV3K1F6OFpGTTNuOTBYNDlvUUMyZjVxb3ZR?=
 =?utf-8?B?UkRSbVdja21WZGIvSjlDa0FUMkFheHduNENtTnZnQ1VyaWJhRkJkSElpTmN0?=
 =?utf-8?B?OXovWmo5elpBdmV6ZTFwUjBOemptOXdDcHpDSlNFbW1RUUVXb05BZm8zMkNx?=
 =?utf-8?B?RlNpVHZyUXM5M3NYemZqcFI5SVpCT29tbGtndnRleVBnTWhPK2d5RWZDdHJP?=
 =?utf-8?B?SmZYdUN2bWpTKzV5VnBFSnhmanlBZVZTUFdVamhCOU9neHJVUUwzaXE4REJn?=
 =?utf-8?B?MFU5VVVHdng2R2FRYWZrVUNKdkdnY0F4cXAzYzJBU2ZDSWFVc2pIa3liRnZo?=
 =?utf-8?B?VlF4VzBkcTVxVFBOWVF4cmZEa043MjhGUVZqcytwWXcrWlgvdkpsWXoyeGU2?=
 =?utf-8?B?TXNkUWNoL1ZBSWlHaEd6M2VFTEs4UUJMUTBHalZmaHhsQ0NsY29aSUFFejVP?=
 =?utf-8?B?cE81MXE0ZzdjcXhJSjRUOCtTZXhNRDZpaUFCNDMxMVBuaWs2WHNvL1B6Z2Ja?=
 =?utf-8?B?UlZtOXlFbUhiRzhFdGxydEZ6RTlNcmZXczJBKzhlbWdNdWtXMmlzZ1RMdVdn?=
 =?utf-8?B?L3V5U2libDF6bWZldi9KSHpiNmtBK2pLREIxSnBWN3drS2pRaUdKUnEydnJ6?=
 =?utf-8?B?UTVmYXRiZmpFUSs2MDVCMG9QcTd2RStvcmdHb3gyWGx6L2R5dHZkYTNaVGt1?=
 =?utf-8?B?ckUzbDZMSEtuSEpGQy9OVXBlU080UXdlUHdDVmZYWjRGTE9jYjE3RitBRXg1?=
 =?utf-8?B?NEtZUTAwOFpvbnpSYmptQU90WkRYc1hIb2NIN0xycTNIQ01Benp4OStsWjl1?=
 =?utf-8?B?blNjWm9KVFBrbEFBeHk1L2VYVWY4cXNWQlpmWVkwcVNucW81NnU1bnBSZjQr?=
 =?utf-8?B?UnZ2TmN2K011OXJQV1VZK0ZxVXFyZG9EVDNZb05XYVNwVEw4NE9MemZKTUpU?=
 =?utf-8?B?TWY5cFEyMDFXZjZRL2pQdjNieC9sY3Bzc0dyOWZIMzBmL2J0cWJsUHE5QW9G?=
 =?utf-8?B?ZUVwaCtyRVNzdFhRVXlDMW9HWGtnZ2JXRWxoRGMxYnEzYjBBS0VUcDVNdFJh?=
 =?utf-8?B?cG8zWTE5YWFWVzNWc1VPcDZxTWc5aVBtN0J0N2M3T1RWVnZGV20xYmQ4eVpX?=
 =?utf-8?B?VWY2NEl4TlQvNTdTWmtrVk9OWlhKK0pPZ0JxdVI5KzZnY0FYSC9CKzlxejRr?=
 =?utf-8?B?WDc2MVFvTUljNHVid0tVaWo2anhSanM4Y2FkeFJKTlZEWlVEVmE1dlJieERP?=
 =?utf-8?B?b3NwS0xsdFVvbVpTUFFyaHFZb0tMY2ZwNktMSS9KRi9ZT1JGdjBCdkRiV2Vx?=
 =?utf-8?B?c0FJMlZpWEhndWZkSFJBWUFGSk1uUGhFVzJQRkJuMGFNNHBqeFIyUTVkTyth?=
 =?utf-8?B?VkM4OU1JYS90NlpLWFFvdW1PaWJRcmxjYnI3eWVWb0tMc1RFTC8rNkRJRzBo?=
 =?utf-8?B?eGptc2xOa3VPbXBqT1U1RjQ2d05yWXM4ODFwYytjMkFuWDA3S1lQbkhMOENk?=
 =?utf-8?B?YnA0SU0ybXJkSDJ2NEVWZ2QvYjBNaVE3UHpBLzRaZ1EzbXFMVThUVVBPbnVB?=
 =?utf-8?B?YVlWdXloaUEzT25IelZpR0ZyYXVwR3k3ek91RWw3L2c3ajZTdGhEajZOSEtR?=
 =?utf-8?B?bHBtem4zd3Z0YXhFSThYZ1VCcDFXK1NEQWdFTEdXQlNZdWFKSC9uRmVEUTZv?=
 =?utf-8?B?OTFkZnlUTUZuTlBKVFhEdGVXbnV0ZHRuWFNSYTJmcUp6NS80UVkzdlNSanhi?=
 =?utf-8?B?VUp5RlE4Y1pCVWVKcjQxMzdmRElBRGVKWk5aNVpMUUZlcHJCNnZFNEhLd256?=
 =?utf-8?B?eS84cU8xcHlTbThpQ2x4dmNyUnl1SENHMXVMWmRvQTlMVGp2Y2djbTBRQUw4?=
 =?utf-8?B?YkdxcDVGNkFkK2tOL2hnTGNEb3B1blFyU1NnK2U5eS9rWDVNTW9KbmFwNThZ?=
 =?utf-8?B?ZXovL3BodjFMZytOelpHNVZkNk9YeVpPck1DYXVhZU1nc0hnUGx0UElyb20r?=
 =?utf-8?B?RHpJalZ0cktXVWppN2wxUHR2d011bTlBVWRyOHNNangrY2t2Ryt0RnNIaldS?=
 =?utf-8?Q?/c6WB0SgScexuXhnG1mjkSP3x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <127C7EA9701B1F4CAD411F05A2BC828D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a0f503-58d0-4f73-11e8-08db545bfddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2023 09:17:08.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DG7laEEKk2BSFiFKhvWg44c//AXnhaKiujoP+ESoG59jstM4t7J4KYYjG6gYkGr8VWSk1P2bJgPPqxStubZ2aBFlRwsZl25T4UZptbNy2P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2037
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGVsbG8sDQoNCkluIGFkZGl0aW9uIHRvIGMyMGM1N2Q5ODY4ZCAoInNwaTogZnNsLXNwaTogRml4
IENQTS9RRSBtb2RlIExpdHRlIA0KRW5kaWFuIikgdGhhdCB5b3UgYWxyZWFkeSBhcHBsaWVkIHRv
IGFsbCBzdGFibGUgYnJhbmNoZXMsIGNvdWxkIHlvdSANCnBsZWFzZSBhbHNvIGFwcGx5Og0KDQo4
YTUyOTlhMTI3OGUgKCJzcGk6IGZzbC1zcGk6IFJlLW9yZ2FuaXNlIHRyYW5zZmVyIGJpdHNfcGVy
X3dvcmQgYWRhcHRhdGlvbiIpDQpmYzk2ZWM4MjZiY2UgKCJzcGk6IGZzbC1jcG06IFVzZSAxNiBi
aXQgbW9kZSBmb3IgbGFyZ2UgdHJhbnNmZXJzIHdpdGggDQpldmVuIHNpemUiKQ0KDQpGb3IgNC4x
NCBhbmQgNC4xOSwgYXMgcHJlcmVxdWlzaXQgeW91IHdpbGwgYWxzbyBuZWVkDQoNCmFmMGU2MjQy
OTA5YyAoInNwaTogc3BpLWZzbC1zcGk6IGF1dG9tYXRpY2FsbHkgYWRhcHQgYml0cy1wZXItd29y
ZCBpbiANCmNwdSBtb2RlIikNCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQo=
