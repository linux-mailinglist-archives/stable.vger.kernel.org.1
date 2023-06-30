Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771817433A8
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 06:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF3EnL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 00:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3EnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 00:43:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20716.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6732112;
        Thu, 29 Jun 2023 21:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuhS1+S/+K0ZNfv88RLEBnUrBhSiFtxO32/PObCM6n4oLH5WpblvsI103Pfb4bGJRDItiCCuLP/iZIN8tidLIM9DziWKRcERDhLjEzzFv4zOYfRM2rK+lf+sUxRkBWmahKixfMCrWej45aSwKOZkUchw+JGjhe4+Rdz7kJzlti5X07itLOo/HoFST143nHxiYhdxSxr6gkKZJIZHdal6EAUQ/eB6lLQ4RvYgVBMrXOg1uC5B2baWoN5D9z1It7deix8Dofjm7+6sf3J/dVA6lFzmEp4krj+yyu/j/oM5AD2Fg9XXo9+lFaRCgflanV4gPuew6TZ37yltDizl76Kivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXgH2cOV36/i4nebbpjc0LBGKo3iUAb3tsUC+Fdluqw=;
 b=YMRqPwEP9HdH75MGIcXaJ/aqjRR7ADXrUXuB8w0rH0slWJQNMm+t0vH/vTsMyMSzy6xxdGzEfbIbw0WO/UzDF4syxEpsWT0C0qO+7nCKu77Lm7+adzP6Fn885cKhyhfU92zL4fxJoiKqyDXoYKa7soO3ndw6R/aXJGtO8iaRmy8c9rW1yZib8Sol4gcr75UJ0Dvu5c8/dpOPwJaxHL024vsLxBhpoKMdmu4moiq8hYi3ofz02a3Ludt6NVqUsfwy+7+p9ZmOvVCi9SlMVGFjMhP7l+X10s8dBDpiLbbj+6+87NjYSnqbpSGIWGvdmjuIV72RkNKdRuEaR3qY62iOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXgH2cOV36/i4nebbpjc0LBGKo3iUAb3tsUC+Fdluqw=;
 b=CyvfxRLHKtu1z3jWvd+PLZzaNj2vHLUArJMxyHFyuh0yhKFUoIxSHZyG5jtVTBnZPXzmxLZVyd7ZzUq6g0VAKqqo5cRkYRlv7dugMMsMfBB6mXGMshlnc8upOZk/qnrwTcV/toL46MBbDxc259oQvGhk32sGbE3vEyyZfTdpIHo=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by DS0PR13MB6173.namprd13.prod.outlook.com (2603:10b6:8:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Fri, 30 Jun
 2023 04:43:05 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 04:43:05 +0000
From:   Yinjun Zhang <yinjun.zhang@corigine.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Simon Horman <simon.horman@corigine.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net] nfp: clean mc addresses in application firmware when
 driver exits
Thread-Topic: [PATCH net] nfp: clean mc addresses in application firmware when
 driver exits
Thread-Index: AQHZqaOLXOVk2Xo1CEa/r0QfN3RTBa+gh2OAgAI9Z4A=
Date:   Fri, 30 Jun 2023 04:43:05 +0000
Message-ID: <DM6PR13MB3705404F697F02EA464D4C78FC2AA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230628093228.12388-1-louis.peens@corigine.com>
 <4cc91766-998a-697c-8adb-fcc864f1be62@intel.com>
In-Reply-To: <4cc91766-998a-697c-8adb-fcc864f1be62@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|DS0PR13MB6173:EE_
x-ms-office365-filtering-correlation-id: 9d57204e-222a-47ed-f583-08db79247ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZK97osE7l95gJQbMA9oHbWh9tO2DqniRki3jRZcQA5qPRR86JEVbjo7HITNXgE6XgtENQ30bTuUwy8GXhtkBkYXDCb4g9huZttQZZArHwT0MYILoH4WRO41q2rQajUZuXGM8FKIBIbznNMtDHqhkVa96ascqXof/obVn5IpuQi8Y3ogRY7oljxsNPpDWRqjmU6JA8+Td6V7Elu6AInXWI6FIti50+htbWqUKubarKbe2WQVQZaoLyh2k9O89gLMtUpgQmTMWWMYfxNfFNG9O45r3Fwq5zBEtfgMBq+Q7m488os4y5jSLxPB7kNmG0GBpzdhxmuUQeEC/gXbnOY/+3yNDKXM9IsKIGpsoNmNbm3uscUNr520HsCQFJ/kehUHsn3wjsOMWvy6+fddF30M7LlVge8wMv6qSHCccnsdWDj3f/Tewfb0U+7rwWJuBs9UUH9WFw4v+X9ig/lvdMJXbBH6tJfd+1ygW9RbRN34qRnttamXpmQrrz/G524sGQZb0VdSugBpR6JCQORUv+20Cg5hWyHnYLOLuSnMAQQt3JRioBl2pkt16gvvMKD1mLgQITsiSeobATsbc4yZbD1CLXm0J/ww3RbB6+W30GvwwSXYDp1nIXfBkkHQDpLTyl980uKmuexz8lq3NcxrXXRkXA563zOLatstLqvds1zguzug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39840400004)(376002)(366004)(396003)(451199021)(8676002)(44832011)(66946007)(316002)(4326008)(76116006)(66476007)(33656002)(66446008)(66556008)(64756008)(8936002)(5660300002)(52536014)(478600001)(38070700005)(4744005)(2906002)(41300700001)(6506007)(55016003)(86362001)(54906003)(110136005)(26005)(9686003)(38100700002)(71200400001)(7696005)(53546011)(107886003)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZnYkpPalFuVXlXU05aZ3l3eWd1K3VXTUJ5NEFhMlBmd0FzTmp1eUxqMldj?=
 =?utf-8?B?UnluOExHSitCL1A2cUJpUVlieWliK1d4TW4rL3p1MnRTS3VQQkJJR3dyMXc3?=
 =?utf-8?B?MVlONm1uUDlHRlZLRjZnZWp1SEJpMHU0R3pIVkNueUlMb3Z3TU9FelE0TlEy?=
 =?utf-8?B?djBVNWNHeUNUMTZJVlNTRFF4ZzZHaVUwLzJnV280YXZiZVVlVnhFNHl0NG85?=
 =?utf-8?B?ZlczdFM5OGZJeTJ3K2VtTGJsaUVPSlhqSWtXS1V5NG9ISGY0Rk5lY0pJYW9l?=
 =?utf-8?B?aVdHWTMxWWhyUWR4UTFDNE40ZHdVZEp6UVdhQmVkd1JjTzBzcFZHUXBsWitw?=
 =?utf-8?B?L0JPZm0rMFNDN3d1UEJvZDdYR09lNlg4dURZQ1NNclBMeVJ5bVdGSEdZUmFk?=
 =?utf-8?B?YnZTS09lZzNrbC9CcWdwN1dhRjA3VHNtaVVwYjAzZFhvS2UvdkNpNDJxZXJU?=
 =?utf-8?B?SFh3anVHQ3BCNWwrZnpvZkdoUTRFaVpSMGFFakxLeXdLNFZEUEl4eVBaaTFL?=
 =?utf-8?B?d1VpL3pHNW00dlJWVldqakM4VXhQZkgvQnB0RGNCL2c1OVNYMU5wckRFZFA5?=
 =?utf-8?B?K25zUFJvU0FFS3ZXTi9tVUcwK2VFRjdOV2tSRk5LRFFFUnpzVVdRR2FOcjdq?=
 =?utf-8?B?emV2UXFZQzdnQkRDNVA5eGNjMDVmblF5RDhVUlpHTW5pQUdtNk5hdmdpY1FI?=
 =?utf-8?B?MWxyK0pqWXozMlFBYnAzcDQ1bVpubVFFbk9HVUhTU0NZcUdjWHk4NUZ1T1gw?=
 =?utf-8?B?R0NZUXNwT2Rla09CeCt5WUkybGJNTDhhK1FVTklyTTB4ZGY4K1ZtWkFJTjY1?=
 =?utf-8?B?OFFHMmxjUGhKc1hiV2xnbWxGbnBnbm5JOERUQW9iM0hQd1M3cVEzUW5IdHRq?=
 =?utf-8?B?MjVlSWNPTnR3elJYYzQ3YTlYdmZsS0RkajFFdHZUT0xJMDErUzlHYWswdHR3?=
 =?utf-8?B?bTlXY3dMd0dheTVJZkNzTkRWOUxXcXlZRStIa1gzby91WjBDSEpSY0dLSFow?=
 =?utf-8?B?ZW1NQlBpTEZwdm5PT25UUnc0S0g3ZDcveEtBa2k2eXIwUzRUWmJ4TU5NV09a?=
 =?utf-8?B?TVdsZ3NlclRQUjRXTzVSeTRoWXQ0TGFRN1FrSWF1cGltaDM5SDlvVzQrTXlj?=
 =?utf-8?B?enFBQkRBck1GdGRDb3BZV0NqcDVHZmkyZ094MWdEOGdlMHo4VmloREdZeUdE?=
 =?utf-8?B?cUNYU2FiRWFueWllNU1zNExCV2sxTjZPWFdqa0E1ckdhVVZvM29mTkdseFIz?=
 =?utf-8?B?R0pQYTZIUFhIeVBnK2pOZDFEd2RDcXNFdkxxS1RvTzdWelZ5S1ZEaU9xNE4v?=
 =?utf-8?B?a080N0dCNHhzVjh0bE9YWDBwNTZGZ0dCU0pLeXhNVTNMK0ZsQlVmais1blpY?=
 =?utf-8?B?NGhxYi90MEpaWDg2UWRudStSeXI5U216bFVVcCswV25yYXU0NFlGVlVmdk5x?=
 =?utf-8?B?WnFPbkhxTEM3STlQMVJjRkNRbnA4OUQ3N2J0OXh2b0syV0tHbkVyeUtLYVRs?=
 =?utf-8?B?Qll3YURURGlnQUd2UVhCWjl0WTJFUFd4VmF2NVNCc0tKTGJ6RUFQZEp0REZ1?=
 =?utf-8?B?cGw4QmJ0TnY2YmMrdGNuOFNsemZxUlY3c0VscHJUemFxWUVDWU1FcENnSUFv?=
 =?utf-8?B?TTZlRHVhTEJsSU5mTTZRZURSd3YzR3Nwd2tLdDNsdjZEN2hjcmtpbGUwcmhu?=
 =?utf-8?B?SmJQY1duWFJQa2U2QVJtZUVJME85MDJpeFRGNFQvV01KRmxGUzRwY1QyQS9E?=
 =?utf-8?B?SkhvbjVsS3lTbUVYVXU0TkJMcU1VNGFwZWFJck1OelFzcUdzK0hRdWltNXZG?=
 =?utf-8?B?RlJERXRWV252am0wODJwYXlMODRlUWRsQ3RGTStzUWR5eFpGNWNMeXdUL1Rp?=
 =?utf-8?B?RzJvOU1nNzJnVGlPbmgzYk9wRm4yTUY1R2J4NWtsZnlGYWo2M29vM2lRMlYx?=
 =?utf-8?B?R3NRU1pvMEpPdWEweXp0M2ZFR3ZuTzdlVWZhVnhzaFA5dHUzTTYwbm5uZDFS?=
 =?utf-8?B?SkJUczRTT2JRdzBkb21YOS9QcC81OXRjRmZpYThtYzFvL0I5THU3UEgzMmQ0?=
 =?utf-8?B?bjVyUHRXaXFlL0JDOWRlM1ZXUjV4VjV1eVNVSExhaGF2V0hSR3hvcXIveTRC?=
 =?utf-8?Q?k+7gFUy34HarDvESR23uTCwWu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d57204e-222a-47ed-f583-08db79247ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 04:43:05.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4LbtzlWO744DVpueUkWIbvWZEhD7BJ33PXyVeeuj8+vWIZf6xJ2TLWRO893QuT456puzDe+kEoLm+w/NASuVavzLNEcMyV05PHHUOMYFHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6173
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVGh1cnNkYXksIEp1bmUgMjksIDIwMjMgMjoyMSBBTSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0K
PiANCj4gSXMgdGhlcmUgbm8gd2F5IHRvIGp1c3QgYXNrIHRoZSBrZXJuZWwgd2hhdCBhZGRyZXNz
ZXMgeW91IGFscmVhZHkgaGF2ZQ0KPiBhbmQgYXZvaWQgdGhlIG5lZWQgZm9yIGEgc2VwYXJhdGUg
Y29weSBtYWludGFpbmVkIGluIHRoZSBkcml2ZXI/IE9yDQo+IG1heWJlIHRoYXRzIHNvbWV0aGlu
ZyB0aGF0IGNvdWxkIGJlIGFkZGVkIHNpbmNlIHRoaXMgZG9lc24ndCBzZWVtIGxpa2UgYQ0KPiB1
bmlxdWUgcHJvYmxlbS4NCj4gDQo+IEluIGZhY3QsIHdlIGFic29sdXRlbHkgY2FuOg0KPiANCj4g
X19kZXZfbWNfdW5zeW5jIHdoaWNoIGlzIHRoZSBvcHBvc2l0ZSBvZiBfX2Rldl9tY19zeW5jLg0K
PiANCj4gWW91IGNhbiBqdXN0IGNhbGwgdGhhdCBkdXJpbmcgdGVhciBkb3duIHdpdGggYW4gdW5z
eW5jIGZ1bmN0aW9uIGFuZCB5b3UNCj4gc2hvdWxkbid0IG5lZWQgdG8gYm90aGVyIG1haW50YWlu
aW5nIHlvdXIgb3duIGxpc3QgYXQgYWxsLg0KDQpZZXMsIHlvdSdyZSByaWdodCwgSSdsbCB1c2Ug
X3Vuc3luYy4gVGhhbmsgeW91Lg0KDQo+IA0KPiA+ICAgICAgIG5mcF9uZXRfcmVjb25maWdfd2Fp
dF9wb3N0ZWQobm4pOw0KPiA+ICB9DQo=
