Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C38797578
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjIGPrS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbjIGPbn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:31:43 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5341FD8
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr8b0sVZciqDQvuPMAeOoTPetMmuxUQ+SnyIEV/8LQLAWyS/bk+/pWVo9Bx1zYju6d3KT2nf/o6luCp6h6a26/e/194Qk+jUuoaZ9svES3Rtr+o7KzIVCkm9OF4rNMvMOCcPEaJknCnIn+qjacBHDrheCoyyp9tLtVbL29IPsi/L336wsbu95qi/yJ/qES140y+4ohmL4hq694ri7tmNZodqjsuqmlu4uTYsazpUa4GEvaTndb2K3dHXcPM+EQodmrLQFS+K8zpE0GfJjNu8U1xp74lMSqMrwK8NXL0abt7ehfxO0kLZZqhuSxkGAAVA8uBn2s+hWAgd0BCkGHcrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsXiValkcwEFB5Fcdu/6h3lPqwgNcQUL9WP/Edo4PTA=;
 b=ocjTvbzU7hr6Xd5tgSfcLb3uwb/XLLqGs4o5BK6ePUZkhHjBKBVfol//uXu4sx3+AhdAcSOTJdlCONTgV7+GTzxJu2W1SXguXT2xH5a9OVIZCb+DWh4/oKL6EAmQ92cxnLYLZ7O3cC6LhDS9xp7eqJNsm6mJ/ARC30tQtkoAF6EC0T1D+4uid0FlBL2DXrp235cBAcxQhhO8ny5EX5q94lOYG559o2g46NXhMBJ6aomq8Q5RvrYSIW+IVek0Wmx3qg27ouJbCC0ZkBuIMzgvmfqxyhyDSr9HvxNrkeYVZ+DM3nELQrdDbK/g5utnKJN+8VgHb2aQm5wqA0ASdsfSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsXiValkcwEFB5Fcdu/6h3lPqwgNcQUL9WP/Edo4PTA=;
 b=MxJGVQrdbSneEt+ET6JAIX4Zx7bJ+0vqXPbUFpRoaNUkOYsCWCpZ1UfTVmvfFa5meVSefE9f72OyQA9VN8MJUUjXBhM72E9+Dd9BLO3v+cH5NEW0N8DgFLHx0i/RFGjSdyUBkluo8hfsLQdgw5OY8Kdt2CW5QFfh/1DY3Sy79q0A9fvj8FKK1L+lMrU70aoUgRUVRuR8NSSpaCiTXhygHNQOswWM+YfByP1EX6nvpXRDEQCR53tLbQ1zDyCnhZUBqN4RPjQErKdue709SoguoVzN5IQ/TFdAqmOxLxPz1HDfKWxXH86NlW6eNcnB3yIBIr9MkGSeU7B8GWC0mjrp1g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1929.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:10:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 14:10:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>
CC:     TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Please apply b51ba4fe2e13 to 4.14/4.19/5.4/5.9
Thread-Topic: Please apply b51ba4fe2e13 to 4.14/4.19/5.4/5.9
Thread-Index: AQHZ4ZUCQP8Uoz/kaEubWaT7dgaN5g==
Date:   Thu, 7 Sep 2023 14:10:08 +0000
Message-ID: <07cf81cb-50fe-591a-3c9e-5b6c39d311f3@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1929:EE_
x-ms-office365-filtering-correlation-id: e8d48d72-4e37-484c-2cb4-08dbafac249f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1rkr0OV7WADLi/o/t2plBE8TwhMYt+6kalLmK26Me5TJT/zzoB5Z25GJ2ZNnlWyqLTmszFx2cDxq8m5H5a12jexNn0J4RAxe0iXJtnwohR/I2SE3tfmjFgmfYlnGlQcBMj3lxlPnHtezpPZk42Ny7iwzhbz/2aIO86lHUskOU02vArj3sPLSqYIfwGCvO8uE5zmRdDr53V+Yfnz2Ph+gnFnRrccuI8F8Bvpfn+oiBkyOq+FRrWh2vqTPWN4o1l2WhUbjxlqIZHGwBcarMClUHLuK5q2DB5/OMhbuKHy0nwY35ZEDxxYMw65pdII1aqENJAWIC+GdCqAYx/KI867tbm98nsC2i3T8CvKluP/kDBVk9IQ0E9/TpUgsanRnBxwK+tniPmof9CJwhduukcU86e8V6N+ZttzHylkur7bpGDCZjvhEQf4uulKH8shMX0/rcUDWGWq2mslGqfUGtkKn89TlRmWIS202wAedS1rAAiaHeAkla0K5BhCN8hyUiFIXvu3ShL/D4bPLvvh9fM6FRkW6yVWxmSnLckHK+Yfm08h/QJggeXvPaIECmnFRIuHywPqHulo3UPsqfJqBun6ZIErjOaDDxln0MhKy/zTb9Y/WfvvnjkAPlCEL4s2nQumjp27l8nH0qklz+sww240XKe+fr2keP7HG60olGT4wkR1YMnnXWQVPDWf17Gn+5lt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39850400004)(396003)(1800799009)(186009)(451199024)(31686004)(71200400001)(6486002)(6506007)(122000001)(558084003)(36756003)(86362001)(31696002)(38070700005)(38100700002)(2906002)(2616005)(83380400001)(107886003)(26005)(478600001)(6512007)(110136005)(316002)(66946007)(8676002)(91956017)(5660300002)(4326008)(76116006)(8936002)(66446008)(66556008)(41300700001)(44832011)(54906003)(64756008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWtOOC9KcjczSUZEMXRsblMwalh0blM5ekNoc3p3c1pZa1dHd0s5Wi9jZ3BV?=
 =?utf-8?B?TGV4WFBFMnJWMWxjZU9wZThkcHp5MGJ3MlcrcGR2eWpjR0dmZFJWTS9sZkRJ?=
 =?utf-8?B?U0VyNC8zWTIvUkxxNjE1aHp0aUpaazROWHJ1SlpETzE3QXV1YlgvZ2FoZGdP?=
 =?utf-8?B?cHMxcUQzQmdRejJXaWRXQnVQN1BMZTIyWlVKS0libENMNkZCVEpCbUJFSzF1?=
 =?utf-8?B?TzlhNG9jRmxmSU9UdmFOWjFudGtid0ZCUUU3TW10Nmhwd0FtQTFMSFZEUHVD?=
 =?utf-8?B?TFF1N1FRWS9DbmNjUm1tU0pZalF5MkJPS1J0Zm1rejhXYmZleS8yQ1lZVFRs?=
 =?utf-8?B?OU1XdkthTFllcWRNWVRkYVZBeW5ndm5XOXB1Yi8wVVlCNmkzNUdYUHZoZkdH?=
 =?utf-8?B?RjZaTjNWUGQ1eHF3aFpudFJjOGRlWXFyM3M4SHJ6aUZoZ2RxSmo0NTNuelpy?=
 =?utf-8?B?TDBOMkRQRVdmRkp4K3R3Y3MrTEh4anl3SVJTamhQelQ0SWpVQldjWHhpVGVo?=
 =?utf-8?B?UmphY0NJNExFWVVScHdrUlVZQTJFVGsrMWFzTUpvczM0RW5GbTZwc0IxNWUr?=
 =?utf-8?B?bzY5ZHUzUkkxLys4VnVGRU5VdW9Lazc1K3phU1JPM1pTRFFGVTdOSFBEcXBh?=
 =?utf-8?B?K3N3eE4zWEhGN1diRzBwaE5EU0xzcG11czZvSjlvTGJkK3R1YW50WkhYTUQy?=
 =?utf-8?B?eEZvZ09NQ0d1aFU3Ykdvdm9CcWk5N0xnQmtLT1Bkd1NUMlBiWFBJVUpUVEZP?=
 =?utf-8?B?Q2phZnpVa3lUU28zY1NwMXg1Sk1ZYUVuWFVoeGc3RTRJQkhXSDdaazNWYVZS?=
 =?utf-8?B?bDJNTzlPbTc2dSs2LzkyNU9HYnZ3SWNPc1RETmlNQ0ZQMWFEOW4zZm1mRXhZ?=
 =?utf-8?B?T01CbHdUQzAwRkJJMUJnTUkvNGY3SzJiSVNnL1kvbGlKWTZzcHg2b0NsTTVv?=
 =?utf-8?B?T2dmb2pWRDRjNVpaY1J6THo0Y25Wc0pYdGM3czZuZDZMbHkvSW9obnBoTURt?=
 =?utf-8?B?SFd5QUliRzVFMHZLUFBjSnZXdzJTbVljVWhLemJXelljdmZNMGNGTk1pc3NL?=
 =?utf-8?B?U2xjRFB3Y0ozZnZJdGE5TlZXRWk5NmtBeUl6RFo3b2QwRmhxdWFOenV6bDNC?=
 =?utf-8?B?TkNMcm5FOFRVaTFVMEVUR1VhODFUQUFZR0dqMmN6YWZBcmhNbWtBYXk5U2dJ?=
 =?utf-8?B?VElHOGo2cUoyK04zT21xa3oza2hPN0MyZ3Q0ZkRWaHJVSG9tNzcxYTZxVDQy?=
 =?utf-8?B?UnVxQlVpbERHZVN5a0FYUitqRGJHNmJWOCtoMWhuMmdldlB4T0l4NnluWG1q?=
 =?utf-8?B?ckJnaEEwQ0JhdWxvNURxNE5HTDI4bUh0eVBJMDFXeDI1QTZWd0pOQkUrdGg4?=
 =?utf-8?B?eTNtcFRLWnNxS1pWK3EvMGJRNk5uWGtsMVNNc0FHUVpydGhuQno0OTdjMkxQ?=
 =?utf-8?B?WTcxdW45N2ZKZzR5SVE3dlRNek1iakYvYjViT1JLS3NNUWNuR0piaU96Ykwy?=
 =?utf-8?B?cFpjRDB3WGs0K3QycmE0Q3hjUkdPem1rQVFPQ2FZR1l5aVRraW5rTCtuNGIy?=
 =?utf-8?B?SW1oQlVTVnhzK1prSStESEVCSmhxV3RRdU1xQzhSSHRqS3N5Z1Z1Y2pocTlH?=
 =?utf-8?B?cG1yeTg4UnkrSXEwMk43cHBNY2FLYzg4SUxWVG1PRldYbzR0OUlxL3BQUWxM?=
 =?utf-8?B?blpxSUVJV3cyd0ZEN1NhZDZLMm1Bd3VONVp1OHVNWmlKQkc1dDRRNU9wdENn?=
 =?utf-8?B?dmtuMnRVRUpoVVdlV1RhVVJIUjg3TWV2dUpUNkJ0Tjl2alZOM2EyKzZLUVhn?=
 =?utf-8?B?b3VNaGtuU01QUW1ya252S3J4YW5yRC83RjBSSmpmUm10SWdKY1JyNzVjbUxN?=
 =?utf-8?B?T09JSVJFdWNPWlozVmVPNzJrYlIxUUtMRCtDRklKN1pvczFTUGxVVk9oSjFx?=
 =?utf-8?B?QVVhNlZmMTFjYnN1SEV2MmRNbVRoN25sWjRiaGdVc0diK0lEbXZycmpGZmxJ?=
 =?utf-8?B?UGVHbkpnd3JPY25aS0dQY01sZERNbVpWd0ZZc2xaR0E5ZnhXQW5JWS9MKzNk?=
 =?utf-8?B?emFJTGYwNnpETmV1NXBWdEhZRTd2c1NZYWtCU1d6ZENuUjkwQzlJL1kvM2dw?=
 =?utf-8?Q?jtNCWcnNcAOI+J57kvf2JmF9Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <329B31B3D0687A4DAFE6B576F133527C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d48d72-4e37-484c-2cb4-08dbafac249f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 14:10:08.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9nEdqUcIUP1oLkXk0+NKhUlHEVwZweHmDbUONmJGPS38nhj6qddmBt10wUh5qUNqi/TVwR9hQ88w3aSkBVXYNQsKtHyN/WGAZSnqSikvPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgY29tbWl0IGI1MWJhNGZlMmUxMyAoInBvd2Vy
cGMvMzJzOiBGaXggYXNzZW1ibGVyIA0Kd2FybmluZyBhYm91dCByMCIpIHRvIGtlcm5lbHMgNC4x
NC80LjE5LzUuNC81Ljkgc28gdGhhdCB3ZSBhdm9pZCBoYXZpbmcgDQp0aGUgcmVsYXRlZCB3YXJu
aW5nLg0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
