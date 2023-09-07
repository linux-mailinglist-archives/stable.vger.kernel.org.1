Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8E797580
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjIGPr3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345144AbjIGPe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:34:57 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e18::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64D170F
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ2lY5zFriBcaIsHD2Sn4lNXCNSWXPPvivT+sMjyR2uKHQ/dfdiwiRM5A2fUemCtNxhdiVRdwHe0iZMNFTqSZ1vu6E4C1zRTkRH2v3VQqIwJjCzQbRCHvJ7FW67pcBe6wNBHQuM9/rDFkNXBgi3hQP+szo2duOFBGDropX9GVO7KL/o0FPj7S1T3svGsTLQf9x6Ac1DbRBJaXuGzxJBgojvkTaeZ9MOzTlIkmRT8R+yG4C9XDHmajJWjIAY109Ki3O8uWYZOJ2PRVL5507DJ/rShdCa3DMfR3g+DRP0nzqlv75DskmJAwe2InvZzwvV5epeNHS2FvqE4fyyViKXOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c+dbqrWxw9S8iZoq67rMfDM/k81ZclB7qWBdH9QtSU=;
 b=eZcA1+BjXPAi+EmvGlkeRvZUTPKSEdUmNMfVUVlU7FvtV7iO0EHAUVMzT6N3PT8brFQSUvBcfeMcHb6t9ZVkw9hEhF8DCRkNgPZSgVD0nHLss7u134AtHWyGyWztPQzdPQrCJBKQU6hYIwaCmUJRVJ+rINWrAFq8/FGg6kbXQDEwwdME7rcMgWtDNFQ+oylost3uQ2HM6m2rBEnR+oOC17A8qx0dlkRseRRMz/ONzr98GJ1JSbp03mBhoxzNJoBT1N+GgZ2sRZ1lOcANrU/qhytd5vnDBs13p5WzH8HZhXfGQN2muPA7ewuSz+WfHW50+YcFJf84Nq89d5ub/iuamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c+dbqrWxw9S8iZoq67rMfDM/k81ZclB7qWBdH9QtSU=;
 b=HLE9sdyFUlZcqlkBVaiObueg5iP4Js/b28HnL82TZnVtfEWLX4+rIZFHpEj5IQ3os1jSgEPfx69r8UZsS3sdbhcLsNR5LmEcV08aI08zUxu7kGiSRsfg4KWRZ9Oedm1IMiosXmPvUNhepql+4u6IRZmxrNF+2N1Eicw4TdjzAy3oIOI+U2435WI21u7B1//zsm7jDhqaqWYcM0oGXwc9ac7XSx2yYpW66NlSkXjJEek6y02vU1DRTRFL+2gPy2g7+LD0RfkcGEscC0WQUbbf1nKgohDR3fpjHQ4JvGY3dwHHFlmtsccbALUVGISPgGKvtScx6SKU1dAZubbv6YV/ew==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1717.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 7 Sep 2023 13:37:19 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 13:37:19 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>
CC:     TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>,
        CASAUBON Jean-Michel <jean-michel.casaubon@csgroup.eu>
Subject: Please apply 98ecc6768e8fd to 4.14 and 4.19
Thread-Topic: Please apply 98ecc6768e8fd to 4.14 and 4.19
Thread-Index: AQHZ4ZBsRpSQS3/Iwk2qiX1flko14w==
Date:   Thu, 7 Sep 2023 13:37:19 +0000
Message-ID: <77d5d7ea-6526-3f42-7d3d-3c11b0fd3770@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1717:EE_
x-ms-office365-filtering-correlation-id: 99539e56-430d-4a69-5f65-08dbafa78ed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yY6Lvlk/NuHOXxekcjsN+VEqi0ZpkMG9rSq6ctVW5NaObMj7k++rzDd7+j9+OZl3trMfHo9WcOnu7zAKU79ouK0m0tUQOAWxC2GQfth4LHStzK2D6MDq2b4lXxvRt5uyiiYwuJWBAneX7lpN+ff0j3Njgxd0GUjTOBGiPSF15vw9lKAkYXDzUP+HeSSP1I3WElvM0vDnwuUtUUY7Lj8kYYMlu6DWSW0mujWefgy29MuamH5LubOZ9MwLmreQrL5/lJtVdCY6rslsc5j+26QO+VDMXboMdnq6Evq0N37OpY2b/3AiH8U0xB/yRxbd8cDii0odMO4f6257Yuk/ycpgHPPEcxOBHePOOgWVAdTdIDScHOvqkY2AYvHygVu3/OxEXtCb8UydMdASq9M/iznqgTbRGKBy5679KK6QjjfWxcQkFeJI4mSGV+2vk7m9QgIevoanyC5W9SHfaDJWDnv2GfYZ87nD6m7A5GRFlC92k39uXQ8hckbZHW5bRrN5ab6GAZqFQkb4lNZbdDZeZHB3CPbnhVlYJ0NxIU2RBqhBI1jvfz473Npj0Cqd9/KHlQS5GIjIDbbcFHiIILpRm4Kdf21a2tXOvISM5jWwuP66JkfdVU+g2XfQr5eDkeeYCbuviMK1i6WTeatQcJmh/vvbQYdr5ZRIDfBZj3ksjRXdBUfoEa/dPA4oWYBCSO4FkLlKNTpQQmZCUVIy4mHNZmTOZMsslPzYUnGNuYS1YzOA9NY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39850400004)(396003)(136003)(376002)(451199024)(186009)(1800799009)(122000001)(31686004)(71200400001)(6506007)(6486002)(31696002)(558084003)(36756003)(86362001)(38100700002)(38070700005)(107886003)(2616005)(26005)(6512007)(83380400001)(478600001)(110136005)(91956017)(76116006)(41300700001)(8936002)(8676002)(4326008)(5660300002)(316002)(66446008)(2906002)(66556008)(66476007)(64756008)(54906003)(44832011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2Z2TUN0Y09YOXp2VVVPWHRvRkVvYWY3UXZ1blZWRk9XZSs0NVdsemtiR2RK?=
 =?utf-8?B?bTZkdmdieWZKU3F3cEZnaTYzQ3liWEVlNGVQR1l6ZUpaL2hCNUd3dE9ZdDQ2?=
 =?utf-8?B?QUlmYzdPTkxqZkZmSzBXYVJ0MWFKeFFxeE5mZ2VMUWpyZFNxNWhuYUlFWGQ2?=
 =?utf-8?B?YXpYMnRLa2s2bEJBMzlXeVozL013Qmp2VDBrcldHMGVXdGViUjNJZTcrQ2Y5?=
 =?utf-8?B?bVpqVmlkbTUvQ0RJK1MwL0JaeXpmbVNkeEllSzVmdVFOTTNDbWtXcWxSbWxO?=
 =?utf-8?B?cE9qTWhONUF2cllSUUd4UlpUTGROUFY2TlVjczhEWGovdkJzaWVoV3B5YVJt?=
 =?utf-8?B?dEFkck1XTkNCR2JWa2VleWZJLzd6T1ZCTTl5d2JsaGNvZjVOVEFzclZQQ2pt?=
 =?utf-8?B?VCtQSG5JK2RkN0ZHK0dhaW90cUxGU1I0VVRvTENvNXlXZlBXVVBhVDRnKzBz?=
 =?utf-8?B?dGtMTktMd2tlLzAxazludUZGa0phREQ5djZjM0IweUJPWERhOVAwcmN1VjVN?=
 =?utf-8?B?T0g3bWU5Zmp3bVZmeWJOYzB6RExSa0xieGp1SVM2eFlESVdjZldraXo0Z3pP?=
 =?utf-8?B?VVFkL3lqcjJkR2dZbzNqWkFSaDF5NUttZFcvQjlhZ3RQQnBLSEtiRGVUUkhC?=
 =?utf-8?B?UTFxY3BmaG5lREk2b3d5WkkvbTd3OW1kMUNEUTFtR29IY1RSQVpnWTJZSUZo?=
 =?utf-8?B?TEhlaHI0SmxKdXhOb3BheFVZU1c0NEtvZHhxQXNCOXN2L1gwS1QrT3JneVZQ?=
 =?utf-8?B?bU0wVjBaQTFiZmRiWFRHV0M5K1FINFRUMmRZZGFtelJ1aHo3WWtERGwwZEZC?=
 =?utf-8?B?RlJGdWw1UUtsUnpDUVEzWDF0QzJPSHpuRTBEaDdQdzlRUkEyR1dTSDFMUEdD?=
 =?utf-8?B?enhDaEVWcDV1cHA3bnJubFpRd0FRYWZpQ2JuT09XSmZSMFlub2NqVWd4Q24x?=
 =?utf-8?B?N1AvY0RSNGN5dW9ya2lTUGFJZFRmMGRpODJtT1dSY1pqSnhIcW1tUDZ3cjcr?=
 =?utf-8?B?ajZjeWQyUzQyRXAxQjkxcWpBTUM4MDdsZ2JiR2p3MzFEbXkvTDlwejlOMWR5?=
 =?utf-8?B?clh5ek1kazlFTkRQWGdqS0ZpMXpLOHpjb0Z0UDVsTjYrYnVaN3RqK3BVWjA2?=
 =?utf-8?B?RG92eVpsaDNPMWR3NldIZ3ZNWFMzVzd1ZjkzZWJ6U05JQlhzVWE1bTE3SXdu?=
 =?utf-8?B?bXM4Q3ZVODZSZVhRb0FCaFJZbU9VbXY5NjZEVjFmRTcxMlZ6NEFBNnh4SWgy?=
 =?utf-8?B?R0Z4VGk1V1I0RTI1TndzM3hqTjBDNHg1Vkt1c2t3RUVLcjdKajlYNjc2dzdz?=
 =?utf-8?B?YlhhaUtmTTNIcTFmUEtSdWQvdm1YOVBZN3JpdW44MlJVdVVQVyt1QnUwMHF0?=
 =?utf-8?B?blZydllBSWVRQjBGV3FWQW9oSXlwUFhvelIwb25xRzVyNEEzRnBYK3dHMXlr?=
 =?utf-8?B?aGQ2T0NCdDdIVm9meis4elIvT0dNdWYxM2RJQ2tFMFdMQWEydlc2NDRkV0dU?=
 =?utf-8?B?eGRDL3RJLy8yWldsMS83T3pFQWViMlZNbEdMd1E1bXVnOEtnTnRKRzQ3QUR2?=
 =?utf-8?B?ZDFiWFJJVDBpZm5lNGU1blZGSEFrMHFyNzlGdXBSdUwzUHREWjA2cVdIWnFw?=
 =?utf-8?B?MGRKWDlsdnlScWFCOFl4QjJYaTBWT2JrL2MwUzVZVE1vRG9VUkpBNDlQYlFX?=
 =?utf-8?B?cEJlVmRwZXZIZnZNSjlUaFJSZU1TcmhlaUNoMGpSTjd1YUhUYTRKZDRYUk1y?=
 =?utf-8?B?M2hrZWpKK0dMa1BvK3VvclF4T05QYnlWd21LVUhBRkpiRS9BT3pYSnVBS2JM?=
 =?utf-8?B?U01hWTRIYzk5a1NyMDZaU0ZlbFVPZmFJb0hndiszSytnOGUwTlVPOXBPR2po?=
 =?utf-8?B?aUt2YUF2QzQ2dFBnUC9TNm8wbExkZHpibGppUFQyMVFZM1VSenc5eHZkVDda?=
 =?utf-8?B?WjhkZVQ5K0MxNnFxTTVOUmQvN1VzMk5UaHdvM25YK0l2UDg3UTVxNjlROGxS?=
 =?utf-8?B?OVl2cyt1TS9TcjVnNUZ2T0JtMENJUTViUW9SK1E5MUtDeXFDbTRHNHJibHRu?=
 =?utf-8?B?MjBtZHJRdm0vU3Q2RnF1eFJKS0lES1RTV3FsakxYK1hvcmtGVkJ1RGs1RnlN?=
 =?utf-8?Q?BC4aBhtWkYaEK8bkZSWI/4/Zr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F14BEBF15B3F443B4B51126C91A5A1E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99539e56-430d-4a69-5f65-08dbafa78ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 13:37:19.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O86qnF4BLBKij40eN1rALpiCQQ4uduA3WrAbZG06LehVhnZK3qSl+IVa00NO5O1yTdvm0ziGs3x4v4Mh1y/9nQ8R9vYVMMRPPWKGzURBYJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1717
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

SGksDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgY29tbWl0IDk4ZWNjNjc2OGU4ZiAoInBvd2Vy
cGMvMzI6IEluY2x1ZGUgDQouYnJhbmNoX2x0IGluIGRhdGEgc2VjdGlvbiIpIHRvIGtlcm5lbHMg
NC4xNCBhbmQgNC4xOSBzbyB0aGF0IHdlIGF2b2lkIA0KaGF2aW5nIHRoZSByZWxhdGVkIHdhcm5p
bmdzLg0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==
