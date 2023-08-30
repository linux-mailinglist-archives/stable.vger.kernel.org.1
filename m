Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45378DB62
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbjH3SjI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbjH3Oen (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 10:34:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4AB193
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 07:34:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyEM+/pD6tXslLPIYVWtifuQe0Sj+GABmMtgap9lziaE/AvdG+JmbWrOC4Uo7SQNuDORKvIWmM6rPQT2OJVwfpByCrxyRRzt4T3F3PwL/sEngihXQUxfpdxFWzVEGljJP7ehshHGnzWiSLjcaGGhtEtNPLJrb8cxrXRz5IWyl8IkJre8hLd9I27MJSHNrVmPO1isFjtMEuqttubaE2qYoqn0+e6+1D7bZ4X1GoTeorJxOF4xPzVQgF6MtEQQQjXF6rJacR9GakpVnN+WRCaorgaky5xpEcePrd3uONSm8Ycbetdub2vz4iNXV0LkHz9VIFnRR0h1m0B9bjWflFGWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0q7sTVLM8koCHUC6mvJXl8vhNVxQFM0WiW+L8Fx1dk=;
 b=G1iLBrQY2J0EkZdWUCSD9mLV381KCGpY+0lJgPoF+MF5ExNBDK3pqpHZkst/KEd6maReEdYIUu496K2sE1q9Oe5zBKpJlfKg3um6jFLxnDtpgCeZeVMwY8aU5F9EJkGBQpEF19XsFy/DRachbt7Cw357o0LKPv03KYDDz2bVNhbD+E8egNSAx3jsde0Cu0yowSaB43IMVAWkn5ep1K37jHqocT/2xNqNW2ybOuyz67tHBsF20d5zAKOkPZVUX3uiJHUrx0/Q4OthNQGBL+xbZ/CEj+Nk77WMi/FydK/kyOQiFbuzg5RlHTIBtzntB7zfz5PoXUwGVJZUMZh0nlS6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0q7sTVLM8koCHUC6mvJXl8vhNVxQFM0WiW+L8Fx1dk=;
 b=TlHAG+nikNP9ianMTTgDXsTD+vgE/awx58ez45otPkJLwG1xztzotlaEe4p45Sj8IdlvO0Ck7ppImfmYLg3CU9yPLTQtDcclls/G5CkOn95VFBVLDyClEZ2vzAf6+CTRbyRrZX24Uxv2lCfzuhCC95pIKKN1JDGIFxeYfuWbS78DkwIIJQ8nqJsboMS1bEMR75P2yQvV2rfRrqsqbvelzofe+93UXZcpUMV8em/Fkm5iCzNGtKtKm6KS9xf654WGnSFyX0I+RfRqkrU+bNvDykQbyDxExSiaE60XD6K5GgkZU9zFS30WCg+8lSdWGso1qBFbw6gFNTZpyurUMdIPiQ==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB4453.namprd10.prod.outlook.com (2603:10b6:510:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 14:34:36 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::7777:4ee1:2806:a6cb]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::7777:4ee1:2806:a6cb%7]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 14:34:36 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: 6.1.50 misbackport ?
Thread-Topic: 6.1.50 misbackport ?
Thread-Index: AQHZ208ZtfhYJs6j9kiQ2A93orIEtA==
Date:   Wed, 30 Aug 2023 14:34:36 +0000
Message-ID: <28b5d0accce90bedf2f75d65290c5a1302225f0f.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH0PR10MB4453:EE_
x-ms-office365-filtering-correlation-id: 0da640ba-8ad0-4775-885b-08dba9663c25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SO9Tl2V485Q0jUJpy44nZMfEY9+ubVe8V8qR7pOISbPje8q7JHk2ZwjxSU193Dccmmfa+TNTFgz4ZlK2Ic+1qEYHTc6ri3Bq92jmZgMaCU65rkpWBfa70uOo1VPKx1HxSIiz3QkoPt0+pQnxpgFhfNlWySJmBXgjoQcOuwALmDojGw2QfcddXW2GxqBzN51BS+nnrn9DkR7nHT1+8J/TunoNz8NTnuAWvrJUIca1EQXuKLg0h8lNcQGSBW38tvg37Mr/kUfPwtokCnRnS68rYk2ptBkeq8PWdUpHaMvRZyQkxchPP8U7B8EqxIcgRFuAq3b+KnpQFmsmJXYFkqsiKLDMDmqsByhtnXPP9pNSij/k8osg70VKEkC+w1KoPJs7Yf/NVUjl+pLAbN33YQZ3YMsfxy+m6hUDtUKqIOFadqHiRL1TOVNOcXzGIOoYDbNzP+d/0jAzmL0Hn0FftedZQolcNlR+CTigUEqtd1jAYlIZ/kJati+EDM3oaTehN4hfOPLf+VAWojAsLYlR2tUNYRrdfRSP/DYzI50DXOflfR5/N49zpLoQnLr/r/WSNlOH8xfS7+xJ18Llk3hQqLG/ub+QhKfIgHxrUw6pPae/noY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39850400004)(366004)(1800799009)(186009)(451199024)(8936002)(122000001)(91956017)(66946007)(76116006)(478600001)(6506007)(71200400001)(66556008)(64756008)(66476007)(6486002)(966005)(66446008)(316002)(38100700002)(38070700005)(41300700001)(6512007)(5660300002)(8676002)(36756003)(2906002)(2616005)(6916009)(86362001)(4744005)(7116003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmF3VEh5WTYrcnAvWnV3V2Nnd3hSOTduMzBic0VzQzhaSmRxWHN5aVlvdThU?=
 =?utf-8?B?bVA1WmI5ZTg3RmJoVlN1SmJUdHFERWxYR2Q4R29WMzliTThiL1A2MkNqNUR1?=
 =?utf-8?B?a010eDNSN2Y4alBzZGUzMTllZWE2YzRyWWNaQXBLaUhveWhXV0taMWtHSXhr?=
 =?utf-8?B?V1ptczVTR0w3UnlsWUNNU0NUM0p5Rk5SQXROc292MzBMWGdkd0h5clNLSk50?=
 =?utf-8?B?MXI1UGlncEZQdTVCaEVISDNOeGlvNGNHWXFkRTBJV2pCMlUzR1dMckkyaWh5?=
 =?utf-8?B?cjlOYXozZ2JpeDRaZmlydCtJSmVXVTdobjhDRXAvMHhPVEkyaE1VQ2EvNG1o?=
 =?utf-8?B?N1JCU1RUYUREbHJsZHdmZ05wRTFGQitPLzJDT0o1U1hFdnVMcXdZaDlkVUUx?=
 =?utf-8?B?bnZFTkZrL3p2WXRIZ3gvVEZWMUpNcGR2Zk96Q3VNMTBFaGw3NnV0ZDlBaDZl?=
 =?utf-8?B?MGtSMS9SaVRUd0pLK3pVZnJDWnRDOGNpejk3VkZ0dHhzTWc1UTNrSWc1c09Y?=
 =?utf-8?B?WTVBWGxlUkV4ckhFKzR5T2RiTUFaMkpTaHNrNlhBTVRqRmgyVHBacmJldXJO?=
 =?utf-8?B?dndJSDJqVzM2MWJzb3hoOG5XVzJnMFFkNFB0NHdGWE1mR0xoMTJGTFFoTzZH?=
 =?utf-8?B?VkdsWEZFcmxvVkM1d1BWcWN6L1V1bFBqeVB4U3c4aFVIUFZ3STFpVWlEUElj?=
 =?utf-8?B?QkxsWmRjdFc4SWl1eWRhRkZKei8wRy9WNnpIdnFEbmFJYUJFSjNOOC9mbjhn?=
 =?utf-8?B?NUY0RU1yR0l6ak9HVlh5S01vMk10WmhhcTNrNFVvV0MzVWF0UE1oTVBhVDBJ?=
 =?utf-8?B?cjhEVWFINnhyb09WdC9yd08zVTRJemdZWkJKNGN4QWpNRDIrNHVDNXhqb0Rk?=
 =?utf-8?B?b3JORkFESTFWS3ByK29yRzJMUjhVVnJyc0pGRVVQZStDNHJydmRubHhuNmsy?=
 =?utf-8?B?aHMzZWFudnNpUjg0WkpXOTdYOXkydGU3azEzUzk4KzhtWmRPNkxyR3NOODl4?=
 =?utf-8?B?MGNyTkhQT1hlaHBmUjNFL0Q3Zmx0TjExVlVUVml2V0JKSHc5Wm1VV1ZsOGph?=
 =?utf-8?B?QWF0NFlVNmhTM2VyWGI4UkRPTFgzTyticzZ5enhVYTlWVDZjSVQrOE1oQUpt?=
 =?utf-8?B?MXVtVnZ1UW9YR0J1R2VVTlZoNmlQSG12cVM3RFk1UUxhZ0FENEVWSnhwVW5B?=
 =?utf-8?B?MmRyTVJFRkt2T3lTeG1jdEdYZ0ZwZGozWVJYWHRwOUV5Z2pDcktlWlFrTDly?=
 =?utf-8?B?MXhsclNaL2xMaVRTUnRXeks5SlM3K21xN2VPMExRSEdBMEU1Sjl1L0orempX?=
 =?utf-8?B?YkxrODlPQjRKSmdVTHRISVgvelhvL1JkNUtseEtLdWVyOGQxdWs5Q28ranNq?=
 =?utf-8?B?NXo2V0ZxY05vRUthSThqTUxSWHJUVkU5clVGRU9PaGt0Rm9BR3c5TitRYnNG?=
 =?utf-8?B?aW9sbjFXdHE3aFZhNThqM1JhbmJONW1hZGVPdURoK0VLcWZsMmIyWUorS215?=
 =?utf-8?B?TmVvNEhZRHhPc0VOREhsdmd0U2NhcXBac3JhQk9iOHFvZW5nekdZSTNBZ05a?=
 =?utf-8?B?aVNaeGIrOW1qSWUxWTN3bU9UWUticHlSa3hSNnR6YU5TOHpRRFpuNVJ2R3I4?=
 =?utf-8?B?Z3NQcUFoZXJEZjBnaTYyeDRYdWtZS1grd25ZS1AzN2thNnRaM2w5Q0U1YWR0?=
 =?utf-8?B?SnRLdWxVbGN4RnFyNCtIeGFsMzR3WE8yY2IybitPa2NGdE9BaGx5Ujh1djdk?=
 =?utf-8?B?MjgxSXNqNXQ3Q0xsSVRpR1BPdkhPbit6NER4bDEvMVpDTHBhYTI5SUtQRDRR?=
 =?utf-8?B?QXR0dUN6Z2h5Vk1TcGJsWWZGc0lSVnBodVdjeWpmaStXaGxDOFFPOG5ZRGNN?=
 =?utf-8?B?NGIxdkZOWlRzZFB4Q0xjTDRoNVVSUDZsR0RuL0ZVQkN6eU1mZW5pOFV5a2gv?=
 =?utf-8?B?b2hsWVNMYnpCc3h2UDQwRktzZHV3U21zcTd6dzdUb1YrOGNIZWQzUkZ0WC9T?=
 =?utf-8?B?MnJGU3RadUVZS0ZMYkswazY0WHd3QkZNMEtPUktYMGlNbVhkREpWTnVBcERQ?=
 =?utf-8?B?M0xzT3ZJbEc1ZmlCM1cwZjZlOXVpSlZVTHI4MUdKYTVncDFiNFBLY1ppamps?=
 =?utf-8?B?WGhhcnltMHZMVFRKak1DUWN2YVRUQUMrYStKVWYyQWQ4UnJIOXpHQjBxTWRH?=
 =?utf-8?Q?kucPaYzok76Z82BkBglJ47kN3NPJup8+JYK2rQKO4tz5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D245D7EBEFE7EB489D6C1A1F70309286@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da640ba-8ad0-4775-885b-08dba9663c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 14:34:36.3778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX2pLaPTUqDq6IVm2GO8ZOO7bd2Ziv1iLFZx0HNmmItu2EadbqVZKJLebGZJMRKQ5/sgeU3xjGXynq+UnyBbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xp
bnV4LmdpdC9jb21taXQvP2g9bGludXgtNi4xLnkmaWQ9ZjAxNjMyNmQzMWQwMTA0MzNiMmExYTA4
YTQ4NTZjMjE0YWU4MjllYg0KDQpoYXM6DQotCQl0Yl9zd2l0Y2hfdG11X3JhdGVfd3JpdGUoc3cs
IFRCX1NXSVRDSF9UTVVfUkFURV9PRkYpOw0KKwkJcmV0ID0gdGJfc3dpdGNoX3RtdV9yYXRlX3dy
aXRlKHN3LCBUQl9TV0lUQ0hfVE1VX1JBVEVfT0ZGKTsNCisJCQlyZXR1cm4gcmV0Ow0KZmVlbHMg
bGlrZSBhbiBpZiBzdG10IGlzIG1pc3NpbmcgaGVyZSA/DQoNCiBKb2NrZQ0K
