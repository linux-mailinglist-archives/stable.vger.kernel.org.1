Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC57706F4
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjHDRVA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHDRU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 13:20:59 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012002.outbound.protection.outlook.com [40.93.200.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA9469C
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1OM7O2UF+KVtZ90nqA0YnRV8ILb/yZN8XVGn1vXBfBaIgRkn8aHD50Zj7aMVH9rKxaIGvcOU+cw3uOoLU7OrxYSLopdBwLuy/7XqHSqiXLNy0jKeSE22b0lpjLNLgEdWHtjtnw/3EO2dyHYGpoxVzr/iBwM/YkhanuqXYqNzceliL5w27jE5LZqxaPox1kveK684/ANXzvk3eHulJ6Kr6fbUDz4c+nL1D/E18l22YTiGS5C54l8VcJ+hMoxP4GRePI/PkEu0iUZUnaF/1hkxrsJ47w64i3mVBL0LCyWEEJeXzt9tVxuWQc0c5JgONUKuW7Yr+FObodYj973Q00LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2XYguZ91TQNKSK26tgIwkuD6H11Q/Tcs4fu6CriuQU=;
 b=Pfu9DeJtEHJanQzyqnKAXONvrKcY3TJBxheEnMQ6V5Xgce/q2v6P7gClZSVvp+qZVNnv94Hspzo2SXAvWuStDP6vGT7T0t/1EG7pm2V3l2F/+G+oxpwLQYMHTLboQI2A/9Prs+qWefRb2afvsMganw8ydU7+/TgaCdYill19Um2stoHwYEUD1bPpE3YIHoZOCT2x3Qc0GsI7RCgHltCI0uq/gUnQHdIwC+DAJg2TGaLx6ELWMFiqZ1F7kdH+jHukbp94usX2Q9E5BKzSlUEqGiQyi/2dcK5uKK+eqvVie7isM1qeMujsNLbV/eNzW/85nOdXA5Ze3Lb7LDI3C0F9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2XYguZ91TQNKSK26tgIwkuD6H11Q/Tcs4fu6CriuQU=;
 b=RLmGikMc6tw8sZEibyE9IQyC78LrDFZGwfUzCNe4n1S6+ipX35+Ufxdexp6BwNPO7KV1zOgcSa/rW0ybtqkg6qdAy6YZeYBr3VxUT9SfKf4q/XLJLXdxboV9IO9w9yoSWnnq6gz1cR1Dg8zCxTi1A0/Midb7/JwRRIFTr+cZu60=
Received: from DM6PR05MB6569.namprd05.prod.outlook.com (2603:10b6:5:12d::13)
 by IA1PR05MB9503.namprd05.prod.outlook.com (2603:10b6:208:429::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 17:20:54 +0000
Received: from DM6PR05MB6569.namprd05.prod.outlook.com
 ([fe80::ff0c:382:3baa:89d1]) by DM6PR05MB6569.namprd05.prod.outlook.com
 ([fe80::ff0c:382:3baa:89d1%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:20:54 +0000
From:   Brennan Lamoreaux <blamoreaux@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ankit Jain <ankitja@vmware.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Thread-Topic: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Thread-Index: AQHZxLIWoa2gruvNQkC1EKRxn0/1Kq/V80WAgAACMQCAA/wygIAAAf0AgAADWYCAAG+eAA==
Date:   Fri, 4 Aug 2023 17:20:54 +0000
Message-ID: <8A065896-FA1C-4868-AEA1-698166232149@vmware.com>
References: <86FA1210-9388-4376-B4A3-5F150E33B19F@vmware.com>
 <20230801213044.68581-1-blamoreaux@vmware.com>
 <2023080459-sprint-dreamless-eb79@gregkh>
 <2023080459-visitor-fleshy-7e05@gregkh>
 <2023080457-chaplain-tingle-1af5@gregkh>
In-Reply-To: <2023080457-chaplain-tingle-1af5@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB6569:EE_|IA1PR05MB9503:EE_
x-ms-office365-filtering-correlation-id: 051b8c66-d1cc-4890-f7bb-08db950f28f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlEs/0GbTjLdxKFFA3kVGKrw2A9dLFgZ5/SdVu9pz91KeJKR0H7F0XrnSwoc8VW32pIQUo5zTiYligWi9JKf+l7edwSXC4z3yWf50JUg0NebgXv6brbsJM49ZYpNqQqEDmKnqxzRkptZtNh5VYXTIc3jjL0wGGB9Sv5NRMTJUDw62m1z0PpR58S7MFzCvt0+9Fm+HIbu7Z5ebdizS61gD9pvUFFiwRfMZ+/C3JhWVnD8OK0pPiA3smJms7TonliVzcQHqt4/X9isFtdV+9V/3J9YmEa1+2YqRLwljkjfWCsYQO0pJAEhaxtoUV+J8yi97VrXizKGz9Wh81u3jHhKzLNUkTMnO0xFuSBYWc5T73ApIWNQe7DIYz59KtidVKK3tx5efNEtVwCucugBT97xVSzcUZNNFO8g8EOEGD7Kcogk0W309mHmtYo7KZ97fudtwLZYcJSXSdWs0Z2Kx50uX4x8/39gLFsmDq/5mR/9BEi+VgIehc4fJrNFvaIeWUDGur67xavh5vLL29vY+XE2jdnV/EKyto11ST+rVvCwAfeaBRxAUURNIGQ91DSAzTI4J+rmqSM3D0kZ8MkelhCdNjXjiGFL9JaAIDE4XyqUza1CMmcy868E7KO830rHpPUR04sgckzOC8hs0M53UEgibUXgMUGea2v7kVw39JK0BsPEFiWKgNPX7OdciC2GmiDA2LqK3u9L/xGlUzv1Y0CL0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB6569.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(5660300002)(54906003)(83380400001)(41300700001)(6506007)(8676002)(8936002)(38070700005)(38100700002)(2906002)(86362001)(2616005)(36756003)(6486002)(316002)(478600001)(122000001)(4326008)(76116006)(66946007)(558084003)(91956017)(64756008)(6916009)(71200400001)(33656002)(66476007)(66446008)(66556008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnB4L1hPMVdob1hCZ2d1OWJNdWE4bDZqRjVVWHRCNy9QSUw0RE9tNTdiQ0h0?=
 =?utf-8?B?cGh4emNRditIUUZlQ0dWSXd0UGpPS01Tckcxc1JaU251M0hsSFZyS2dDL3pV?=
 =?utf-8?B?RTNzYmdOMmFTYWdWVG4xVkFQRnFNcEhoRFIrMVdwZlZMUG1jTysxZ0UzMjhi?=
 =?utf-8?B?NmFTMExPa3h4UWhXWWhRM1ZJME83RXorVXJzWWtFZithdTFXMFgzZWtZT0s0?=
 =?utf-8?B?SmpuclpXYXRlbXlhdHJ0Um1vOUhodGFyeVpTVHd5Wm5KMko1UkNjbmlOektt?=
 =?utf-8?B?cFphaUQ3Q0xKRWdHRVR1dkx5alBZNlVKSTNtcGV3ZXBFYWVFbGFXSExpL1Rq?=
 =?utf-8?B?Vms3K0NoUFQ2UWRyYlJxd3hMSWprdHlCdEtSeHQyRXg1QVlpVEROSTFuTzZh?=
 =?utf-8?B?OGsxbEhBMUFPcm42L2QrdEs2aTBYQ09vMVhRTGFtcnJ2aXg4eUR2MmxNTDR0?=
 =?utf-8?B?aDlqRTJSRVFPMjNUTVdFUkdCMTV3enpGY3R0WG5BS1RuME9iWVBacnBWMThy?=
 =?utf-8?B?ZVF1L0h6WU1SbVdiMGZzNnJjU2NCR2d6VkZLWjJFdDdRUWtmaExkc3BYMFJS?=
 =?utf-8?B?aXYvSlVkM0RkVWNoYW1YQ0FmK0hSdGY3U3pYNitCWWxHcHBUS0JZTmppWFVo?=
 =?utf-8?B?NFNtdFRiRFlNd2tDcW8rTlFCV2RBYnFBa0JuOUcrckxzeEdENnBkMmlrWUZJ?=
 =?utf-8?B?WVNHcUlkdzJ3cFlTYitSZURhVVRIcnB4ZVZLQkVUYTNtRjVqRGI4NmZLZDJ2?=
 =?utf-8?B?Vjdsbit4L0s3ZzNicFc4NWQ3TU00SzRzekt4cTczZEREMmJkWnJja3MvVWxK?=
 =?utf-8?B?dFNWS3NOYmlsSXZnMGhwYktWbm56TGlrN2dQRXEvUWV5WDNjaEtoOWJsdnI5?=
 =?utf-8?B?RmRTUUNKVzE5ZTFlU3NlamhIUnJnRU5rckdaQUg0VzZ2ZzE1WVVuM1BldGpS?=
 =?utf-8?B?ZThIaVBLODJnZVZZWGJLNFBaOFdlUFFtUjdZUldVdndTY0FMN1NGYXpWcjlI?=
 =?utf-8?B?ell2eHRvWVRKRkNqN0twTG45cG1wNEJxa3U2VjE1UituNnorSzJpLzlrY1k2?=
 =?utf-8?B?ZmlZcW5EblNzeFhmM1N0Tm9PU05vWnJrbitiRkNZT0ZhRUhTVlJnWGQ3U1gx?=
 =?utf-8?B?SkxMYlFldWQ4WXl4b2hlWmdFc3N3Q3RTVmxUQmErcFBjc3R4Nmwya0JRR3oz?=
 =?utf-8?B?cDcwdkFsOFovSmNMZENzNVNiWHI4OGhCNC9yeXVIQjA5WlVudm1hWUh5ck52?=
 =?utf-8?B?VitRcGRUb3hlQkw5N29PbUYxUWhzMWtQUFU0TTlmb29MUklKSUZ5VUhYQUw5?=
 =?utf-8?B?ZEpGdUh6Z1JLMkhvbi85OElXdllZSUltWHlzM3FsRVFJYVpTelZacTl3Qk5j?=
 =?utf-8?B?MGtWRHVVZWVob2dndFptaTI5N2Nocnl5UXhYVTR3MWx4OVIvZFRFRGUxbUVy?=
 =?utf-8?B?dUlRQzNwWTlIT1ZDUVdteU95ZGUrc0pGTlJ2K3NvOEdQV2wxLzNCaXhwLzRB?=
 =?utf-8?B?Y1oyZTJwWlFwdEVnaHNiaTVIdk91TUU3UlpCb1BDOWN2a3pUUXVOR2tsUjlz?=
 =?utf-8?B?YURmS3NnSTY1NWRQcTFjYmJ1UHFKdFMrUStQd0toZTJBay9uR1BMSVd6QTZL?=
 =?utf-8?B?RGtua3lCSkRxZWJpVVArSkZPcktLQ0hzS0U0Ymg0RkdObk9FQ25VVjNla29T?=
 =?utf-8?B?UVk5RENjZXBnTzJkV3ZtUWYxUm9IOGtYVlN4TktBR0lBMnE3MC8zSXBqQjds?=
 =?utf-8?B?cTNPVTdPSlZGL3ZNUmV5MkR6dHc4bG5XbW5rZDY4Mis3aWc4SGlmMEttQ1ZF?=
 =?utf-8?B?R2ozSm9lSFJsQkl4T0k3OFJobU9wZjZrRmV6am5mcm15UU9qVlQ4Z0V4cmNu?=
 =?utf-8?B?eHI2MGVBUWFwdG1MU0hNRGFwRjVIK21scENGT05oWVRzQUhQRXMwRFpsaHJD?=
 =?utf-8?B?M3owL1ZhN2ROYzR0aUJHM01BNHZ2Q1hxU01NdWE3bnUwME1uVU9JcjliRFNi?=
 =?utf-8?B?aGsxOUhFM0RFVmJwRk1FdFpDWkMrWjYyY1BKQVk3OURkM0lDRUF5dzBJNnZ6?=
 =?utf-8?B?ekNJTjNpdEtCaFk5SVZtajcxQnlqZTJ1eGQ0N1hJeW4remh1ZWdHRm5kcksv?=
 =?utf-8?B?R0JJRVFxSTU0VVhSdnorMVFyOVVSaWh4ay9NRUhxdThsaWt2NWc4aVVsUmUw?=
 =?utf-8?B?K0Q0U0RKMXRuMGxKVGFGNy9zWUZMM3pURHZkMEd2RTVMMkRMclY3MEdWNXh1?=
 =?utf-8?B?blZZVDZUQlpvWUFleEtTK21pMUdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B6FFDC6AFFB7B49B5A2E87B1653935B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB6569.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051b8c66-d1cc-4890-f7bb-08db950f28f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:20:54.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKtEUNlq+EWz0pVWgJQoaKq8Tm7vnZxyYC2c6RtnjqOV7HrBwky0DZ8YtRy+YncoDTz6RunCyemblaQbVbRpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB9503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQo+IFNvcnJ5LCBpdCBidWlsdCwgYnV0IGhhZCB3YXJuaW5ncy4gIFdlIGRvbid0IGxpa2UgdG8g
YWRkIG5ldyB3YXJuaW5ncyBpZg0KPiBwb3NzaWJsZSwgcmlnaHQ/DQoNCk9oLCB2ZXJ5IHNvcnJ5
IGFib3V0IHRoYXQgLSBidWlsZGluZyBhbmQgdGVzdGluZyB3YXMgc3VjY2Vzc2Z1bCwgc29tZWhv
dyBJIG1pc3NlZCB0aGUgYWRkaXRpb25hbCB3YXJuaW5ncy4gSeKAmWxsIGZpeCB0aG9zZS4NCg0K
VGhhbmtzIGZvciB5b3VyIHRpbWUsDQpCcmVubmFuDQoNCg0K
