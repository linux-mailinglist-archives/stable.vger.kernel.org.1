Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADE76BF2B
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHAVXW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHAVXV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 17:23:21 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012000.outbound.protection.outlook.com [40.93.200.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45E62115
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 14:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb3xeY1iV80gBZ/MledSGsesmgg6Rsw7ytpCr2zgM4zUJaWcm00WN6yETHw9SgDzqrDT4xx3zv5XN1nS8quZ240WFW89kxetOT3fVBPcn/YGauo/PkdpxnHEYjBYZxl8SUFcgC1USgGrVUtIaZwzB6F450bBjoknh61VA30itX2lYkLk8xvGKkgZ9aCh+XNcQbuu4DXYOGNXh86GBkh7xRsBcvlD74aXUKEryeN5M+MDpduBPSwU7A00h/m8ncz5ll67X+JYp4PzKaG4t5SLDlrNEoUOw1B1MArRQJrqNHM6Fdp7jTe1pRaYCjpEzLn6QoS0hPS9D4JHPOBLynlsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3sSCuu3CF8qIe1L1FRnzBcV0b9+DjF2iDiZtn499bQ=;
 b=iDD9O+jEeeqGNox8+cpRAhJWkqWOlLvsR3AJk/13DT3nVW29jfwwNl0cr7QjCebBJT8ajPGPb22ndAxXvH7Sh/r2G/FQnPPMopx3EaqE9bJup+5Q4PsvGs0jEmmQP8/7P7dVAnrnfZwIlI+nuzON4DE0q3CMNFs9pUctuZNg30oKmoHcwX7kn/IY49+CpkZWT4nEacY3n2AhL1gWzTg12MawOXPwYukvGm7iH/XvySpCPEUlsbYoMDmZ3xCe+m3yfoCuHuQRzX/1Lf3gpbmSrIxO3orv9avhqngcMTQN27WvU30DRkXtwkz2PPDf6moMoA+F86MltTsNr34GJoB5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3sSCuu3CF8qIe1L1FRnzBcV0b9+DjF2iDiZtn499bQ=;
 b=BFdkKpNs2qElJHXqz+X7lvfZxnPqoDZ7HPEIEapqmkxJffEn0sxpElNvVMl891nalkx4d1ED7gt778Q7x8Yh8giLbmGhJyLL/vrg6KWPdNqszHbO08yRTl6sW43R05QX0uoR8qr7rVtC8UZ66zO+s87c6aGxZanhKxIyPd1aG7U=
Received: from BYAPR05MB6565.namprd05.prod.outlook.com (2603:10b6:a03:eb::33)
 by IA1PR05MB10005.namprd05.prod.outlook.com (2603:10b6:208:3fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 21:23:04 +0000
Received: from BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129]) by BYAPR05MB6565.namprd05.prod.outlook.com
 ([fe80::45ae:2369:aa3:4129%3]) with mapi id 15.20.6631.035; Tue, 1 Aug 2023
 21:23:04 +0000
From:   Brennan Lamoreaux <blamoreaux@vmware.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ankit Jain <ankitja@vmware.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Thread-Topic: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Thread-Index: AQHZxLIWoa2gruvNQkC1EKRxn0/1Kq/V80WA
Date:   Tue, 1 Aug 2023 21:23:04 +0000
Message-ID: <86FA1210-9388-4376-B4A3-5F150E33B19F@vmware.com>
References: <20230801195238.68158-1-blamoreaux@vmware.com>
In-Reply-To: <20230801195238.68158-1-blamoreaux@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6565:EE_|IA1PR05MB10005:EE_
x-ms-office365-filtering-correlation-id: b62c189a-87d7-47a1-4dfe-08db92d57df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XB/X0OLxfcol36qL9z02DDHZD1vOjC9Ybdv7+rir7m6SceamsYLIv7vH2DqM3t74K21QQj7pat39kvdZcRpfEkZtAFbXFEPs5/MNzzvm+Qukr4q3Df8QGdAONeRSt32j/HOwcn/YO102lgAYBkc4nfdY0UxBQY0rHTlaQul0fv6VxqLX0/7dMcn13dVX70QF26jNXBiDVv/kaAFEIhM1sV6TYW0xanMF0SUU5WV1xxhMPqjFPvlcvLyzKsgxFciKboMRXYMiLAfi1v29C2nxaGeiZONy7VVpqMTax/b/QYCUqVv6/JiuITTd32blzoo/CcyQCVHkm6IyXqNqJTGxm+UUbH6MPaLUw412gBFWEUAE2qUSJTzaGLxBVPFTtMnqp75+z5azaE96cTI3imUZjDQ3XC4X5h58yC/3PUvmeCR0y+UTmKYBauJLVOm9BQvsnnTlOc88EvucoX92pghWfBzQ218UV3+HhlOIcsogULkZQ1fL7XcKLPMSCfOEVFr/RnX/ZIJPTiDT9kXVlXC6cY7uTz1kEdp/rGr7C8cCfbfJ5UztjuXidf6y2QU8cDrlp+UJEj8N+QqBq2bgQDBp7O0rlWo8pIviXfvjkXKRuOUbi0PtBN911T8SN59aGpdIPdE/S8J2P2/UTzQxeR05XWKwTvogTYsnCs+jfz8ts1vQ9E6DA9f2N6IYcU2p2ARwewsuki/6t5FRRQ4BdMTImQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6565.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(5660300002)(2616005)(8936002)(8676002)(86362001)(2906002)(41300700001)(83380400001)(36756003)(558084003)(6506007)(186003)(33656002)(71200400001)(6486002)(54906003)(64756008)(38100700002)(66446008)(122000001)(66476007)(66556008)(66946007)(76116006)(6916009)(4326008)(478600001)(316002)(38070700005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2MzUFR0NllSd2k3N3lvSnFJdkFZbTlLUDVPZXFPOVpmdmdzdjk3V2t2Y0xU?=
 =?utf-8?B?djdob01SOVNmTUcxNnM2NUp6YzJUYS9YQUcwQUFpZXBoeklNOWllaitXNUFD?=
 =?utf-8?B?RlMzNjlxcG0vWm91dTF4c3htUlNtcE82WGRTWTAxQW1VWXRFZWl2and3bmor?=
 =?utf-8?B?WEZhUFo2SWZRVXdKMlUxbmNkOWJYKzFCdEJPTDEySXgxaWh3Smdkb0xpaGtQ?=
 =?utf-8?B?RGNDZ01uSTBIeFJ6S3dHNjlDZjNaSjFpajZ3U1pkR3FQN08rcHVwNTRqTXVS?=
 =?utf-8?B?Ym1SeVM2ZXpyUHdJZDRXV0JUYUVNdGNkRDRpbDBjb1k1MmxRZUxUeUR1ZDlL?=
 =?utf-8?B?L0V2V3FVVDdoWTBGRld6Y3FacmhHM0ltcFpJdEtRdUFLTTVvZUtSVzBjekR4?=
 =?utf-8?B?TXlhWjlkYXZ1V1I2a2dXcDNldTIxSlVRNzZyZTUybllvUXgxTTRuZGFuY1Z4?=
 =?utf-8?B?TE43UFpCMkFJTmhjOWVEL1NteUJIbGhPcDBSWTJ5YmtGUFlrVXk5eWJIOWZQ?=
 =?utf-8?B?RXJKa2dQNFlrcnJuSGdJdjNzUmszSWUvZ2M3SG1ZQWdjSGRNN2lVUkd2aytD?=
 =?utf-8?B?Wm9TKzF3emFjY2tXTFlDdnUwZkxYYlU2ZU5nQy9GNWFtQ1g0QnJ6eFJkTU9R?=
 =?utf-8?B?WDBRdUFOSkF5SGJ5ZFJNQXdiYWprb080aDFYWEFCR2M2aWx3Z09Ibml0RnJl?=
 =?utf-8?B?bnV2QUloZTZHOXRqWFdIQUxBWUtoZTgrdWszaXhtRWtBaTJPd3FDNitBZytV?=
 =?utf-8?B?QkJ5WVpmUWs4QjhjR21DVkhkekNrVi9VRXBFRnl1MzU0Qmc4Sm5qbWlGTFBR?=
 =?utf-8?B?M0dDbkdsdkd0UzN1NmtEcENBRllqaHNYaVlCZnV3K0Rsa1cvVUtsRUlXNTh0?=
 =?utf-8?B?L1ZEZk1YT1p1OXA2dit0MTJmVjZDaWtzTEk5Zjl3NVRidmNCeDdGRkJCbWFk?=
 =?utf-8?B?a01NSnNycEFEZklwa0NnY0YwQWJtNFZDN2xBWTIwUlhvbWplUlNkRExFTnJM?=
 =?utf-8?B?L1E4Y2docTRlQzAwZlhZWWt0RGRMQ3RQakMwRmpWYXg1TnVXaFBqZDVOSEk5?=
 =?utf-8?B?NVE2Q1FNQ0ptTHBSaWZ5cEF0MlBkaW9EN0g1YXJTR0s1V3dOUUFaZUwwQTlI?=
 =?utf-8?B?SFQ2UHFTVlZWT1BsMTJKd2R4eUNtZ00vYTlLbVZWUEJRUnRneVRGWGpMalM0?=
 =?utf-8?B?NjNWZUFNdVRmNERZZU9lTTY1VmRrZng1ZjdEWUV1bGlnaGhLL3dwQ3dYZmdn?=
 =?utf-8?B?dGtXeWFsemtXcjZhVzk0aGVGUnJScHQ2QzhZNkdUTVdWQ1ZmYmxIMmVSaE92?=
 =?utf-8?B?bEoyMElBUXBrb09DZzZHcnpyM2I2bjhteTE4cENiSm91YW5peStaSWpxclMr?=
 =?utf-8?B?VElLL1ZWa0Z6d0owYzFHTUFzSzhZREozUitTVkJDalN3U2QvbkZjSTM3bXV5?=
 =?utf-8?B?ZGE3S2V6aU84ZHNZbUt5MDg0UWhVc3gyeWg0azNkL0M3U0R0NkJnZGVqQ3du?=
 =?utf-8?B?MGtxOERoeGhZQjdIY0tnbjFJQkFwSVoxRGdzZ1hhbXFvZGd0RlJ0TVVvNnk2?=
 =?utf-8?B?eHNHdjZlSzh0Q2ZJVjFqdkxyZi8xSWNOWW5PekttWit4WUFxQ2kwSVJwSzBK?=
 =?utf-8?B?eEVicEpYMFFFSmFFSitlZUJqTkJPU1F4Ry8rTU5GZ09RZmNyVUsyVFZPeHRp?=
 =?utf-8?B?eTNKaE9ZaXNydG4xbmhFejNpLzZkSVhSQnQ0WFREK0M0ZU1RTis2cGdSY1lY?=
 =?utf-8?B?Y0lyQ2NVTDl2ajRGQXgvVjAvcGxaZFFvS3U2WS9YL1luZHo3dVZ5TVhMM2Mr?=
 =?utf-8?B?SUtTMEg0aDVMWHNjbUQvWlN0ZXNhbnRnWU1NSkQ2WUJEazZwaGpGTTNLNC9k?=
 =?utf-8?B?M0dGaDZvZjd2VHlyZWpDWWY4RzZjZGZib3RzZmN4RDBmK3VaOGtCQ3pPMTBP?=
 =?utf-8?B?L3FvN2oyUWpQaS9GeHdYZmNFTmo2TGVWM3VNVFZrMXBIUU0wS2crL2hKT3Zl?=
 =?utf-8?B?WlcrZ1RjR0lDQmtOTkE2cGJib0g4S2hucGE2cGhiUG9oTk9ZYklhTU1HaWxS?=
 =?utf-8?B?bEY1Njl3TEt1c0l1emZBbVoyaXFJL2U0OUJpYkVxRWJlZXpUT1dRMGtRWlFw?=
 =?utf-8?B?WmZabmVYaXRaWkQ5UUpjTllLeVNSS3ZzMHJ4ajJEdnFOK0hCbTdZcW9Md1Yv?=
 =?utf-8?B?djlZVnJuT0t3TTExWkZkUk4vYmpOWVhUczlrc2R4Qi9PYlRkZVBIWWZhV2RW?=
 =?utf-8?B?eUFIY3NPZ21MdEN5ekUvRFJibHdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345D04337F587445B93F84D4B7454FDA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6565.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c189a-87d7-47a1-4dfe-08db92d57df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 21:23:04.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfSe94K3kRk7kyjJV7WDDDtnc0MX+r2GW65ftlsYoJ55Zj+HLBtEOlBdLVcd8ECLt8VASHBVFG2UTdvwmVxjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQpBcG9sb2dpZXMsIG5vdGljZWQgc29tZSB3aGl0ZXNwYWNlIGNoYW5nZXMgc251Y2sgaW4gc29t
ZWhvdy4gSeKAmWxsIHN1Ym1pdCBhbiB1cGRhdGVkIHBhdGNoLg0KDQpUaGFua3MsDQpCcmVubmFu
DQoNCg==
