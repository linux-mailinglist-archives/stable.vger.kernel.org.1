Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E675D550
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGUUBf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGUUB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 16:01:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39CD30EF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDykT6qMbVJp4crEf/ns++0NYTPXNervOQNHT6A0x4/++A5ai5u/IQ3bAf7URMRw7s3HztjZe53h4Xc4cB3ZWmwBwzjunNLb4HXcdly9pUSzK61LhHZL4A7GJzIibCyRMNSERCAJ7Hl0YeUvlrgT71SowMm9zML0VZyyK9jzrQI5Dcl7QPBleyXldTnkBCv3kquf4ZEEy62Mf/K66MoDGcZveRbZXiE+H5lH13D8Af0A+hxG8sfNLif+Ar520P8MzNYw6faAu2ZWfTtfZmBL20YMTal2B1AOPfdp3w9EWhLRVNu/aF7zhkw7jnl6A2/phmHylRZOxAB4ga+3LA90Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8I5wOlHhdWeWpLjRcqNkIkokWy1vatP4QbTjOt4LvI=;
 b=iGbRrsC7yHUoZ1EYnyLyHTdeu4zEYzjBJdOBnrX1VqykXyDc7lbT1wJBQVoi9ciO6tRSyqwsddOCg8Qdcp//oxN4yIoZrRSVn+nxh8lDmp7x7gVcojwLcBfwwivnHpViciJBCz094CMm7K0VU3p9Ne/IezfQGPX9xTC83yxNE426vLoXrJARi16Y9i6Gygdt6P7cIJrUwg+ETgcD0szjH8/gK8GnsgCyx4ylZGyKDSDxkGcJC36fC2YoXTlnKUlnvdIC48Jk1RQyBOgJTE5SBAQX64gXFzP6h8eW42QDX211sRzrQunCKecJPCzUjYzSILzV0COBHcHBpM2CJGw7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8I5wOlHhdWeWpLjRcqNkIkokWy1vatP4QbTjOt4LvI=;
 b=2f0q8RDd1LpNyeDOsqyhC5dUd5UyFNBT1yjAmLkkAnm93y3P6YlsGtDLBl5+SKOpsCPT5RRTgztbX8+lRwABa12IGzsND2NtIc9QSdLUZ6u/sIx/IpLJf2Vu1FaR6ihTENo0Au3IrgCW/vw6qqoDjwCZRPxbDWquODnbWeurHF8=
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 20:01:23 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::81dd:ae36:d1e2:9a4]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::81dd:ae36:d1e2:9a4%7]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 20:01:23 +0000
From:   "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Thread-Index: AQHZu83Ly/3OdGNWUU6qsG/Om4ezUK/EK8nAgAAK4wCAAGzTcA==
Date:   Fri, 21 Jul 2023 20:01:23 +0000
Message-ID: <BL0PR12MB253239BEB59D9B2DBB6B47B1ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <2023072146-sports-deluge-22a1@gregkh>
 <BL0PR12MB2532C071AA71F63C61113B42ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2023072136-laurel-tightwad-9492@gregkh>
In-Reply-To: <2023072136-laurel-tightwad-9492@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ec8f00bf-07af-4118-ae4f-6ecc097a98ce;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-21T20:01:03Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2532:EE_|MN2PR12MB4376:EE_
x-ms-office365-filtering-correlation-id: 9e356390-dc74-4620-8ead-08db8a254252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPrhDb7wUUnfIXUnmUIpxVjwzvxsqbu29yoopCdsLzEXQXRO5sfahzGJf6Wura4QZMSqGZuq7EeBlGqtF21tsG2lAMJ7QG13KfCfxNMpp1HWtUe7DfZg7HnwapBv0BGX3Y6a8PbSfV1yu5GTxKh2fmqSKLWJ7aze9CZoHu8js8HmAt3FcTLLQKuGYL6cIn3OIQKoK76fG2wkV7WnrF6nC7xRWX24NSarVspNYCH1kKrw0kD732zGqu4G4wiNgjs36mYLfSiqj162r7qUFDHCUXL+Zlq7qRwqbAHIN2DFMn7ugrUGMtno3wBceCMkAcWIcFbEqDMvMaeJOa1p1U4QA4Czh6SyEWRDcTqIMtqIRzmafggCIl+9m4RflF1kp5v86Tmxfdm/ZyUWlmSXlVEwSgBZPs35lW+y44X95vKdM3fsXFtlb1815OxgYBoSnj818k9BVMnzuCTYLgo3HbWRMfzkPl1LgyeZT8fYeoOkzo5vyMEddFZn++8/w5aysum1pEh+hrj8/pAtqhiEE4zNQVt5QHIhrJlIKflB2Cs+0u8ki6kpvErTiZlhUomF67xovrZcTo3ylFC1YBRcbZuadJy5qvlp221B4JtuvhJc7hvKRRTl9gVgXEXGJwHaouch
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(2906002)(316002)(41300700001)(38070700005)(52536014)(8676002)(8936002)(5660300002)(33656002)(558084003)(86362001)(55016003)(7696005)(71200400001)(122000001)(54906003)(478600001)(186003)(6506007)(9686003)(26005)(38100700002)(66556008)(4326008)(76116006)(64756008)(66446008)(6916009)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VjYPfXxWW/hUadLmtfqgJc341tNLv4VAnvcP0JUMLNZyzyRhFDuq6cS7SJ/e?=
 =?us-ascii?Q?9MblDsdEfulDulusUajI5KFGi19OjdLe+BP87eThS6d35xk8GySVJySwfm+c?=
 =?us-ascii?Q?Ght31PKT4EDU+WtON1i2qlY/awH0hqnoWYjCrIPu3HqosyWVDfvconAdKAmv?=
 =?us-ascii?Q?H9ubDoD8IGkZNydGp0f2/cWk2ltJ7zLHlXQzwPY6nMcJ8w8cqaSA+3VaRipJ?=
 =?us-ascii?Q?NGKOnQfi6+13OePxz9xydRkMc4eq11Yg4XSWiGWWAJ7vrXnHPodRsySzPIii?=
 =?us-ascii?Q?pPdmmknvIpFPa7W0dihZDPMnm56LDWxbpe4cIxamWHyDfEBoxJl9qgck7iNU?=
 =?us-ascii?Q?r4qWcpgjb8Ztfvodt9+V5H/tjiUV6qHxhVCyl0G2yvbB2YGaYG8tUFvAo4KE?=
 =?us-ascii?Q?iLuC5I4F9l6IwK4qNd6OMLkLmAwC3As23QL/dFK0CVpjw7eVFhbSUe3Vx73Q?=
 =?us-ascii?Q?FXav/9L5dqfI8vLpRle6CochXuzCWkrhgVB5sbWZFgvuqPy8HX+TKdhltrmK?=
 =?us-ascii?Q?RPdgtppkZ7xQn9OnHAPIypvUxoDsFwnkityymw/Jm/tPGGMGJ+5xT//9pXj6?=
 =?us-ascii?Q?EqO0V810zyMJbh4saUJgnoyHx4R4610FznJ82m6uoHXkc23xuScJkyWgd65h?=
 =?us-ascii?Q?59u2DPPbhZRvHYpgEOAL1gfnklE9jwc27MxM0CgPW2JY/7GHNpvJpqOpJJBx?=
 =?us-ascii?Q?er5SIXsM2yeiq253N4stBjRCAQKeEvLzB1gjoXHOR3yMjgVuWNz5fDo84/+t?=
 =?us-ascii?Q?jA2tQbqMeCCOKIKvZY+Eb2ibE0DnwSJcHGpu9XWKP65O3yvsCnkXAe8ZBrgP?=
 =?us-ascii?Q?oeO0KInbQYGhXe1HxWHNIw2fQ511m25NnZioJ9748AY0fcDMi0Xh0ghfehO0?=
 =?us-ascii?Q?DC2qQ6tgOaJRs3j4pSdEluSxR2oCNWXNObyrBayKS2tJd5PCKbP/sU20GHDZ?=
 =?us-ascii?Q?s0ixLSliVmKgZOEQFTDME4F81wNNC6nBy9PIJFqFXjtMfpaGCucOkdiIrCXe?=
 =?us-ascii?Q?teWdbcJang+1lQYQ4iHlxZobG5LHpujWajMuLz15epMEC8t2zWJwv9JWjkvS?=
 =?us-ascii?Q?wR56sjR4SDTu/s7aDdAI4vc7CDsr6u7OLXqgkINqULemcd8qLQSbL1qYw3ej?=
 =?us-ascii?Q?HN6ecB+9LHipY2hCk44sC3WtL4DmXWCApMY+XnGo2do8WvLYXLle+wAvq+k/?=
 =?us-ascii?Q?B90pEbK/146qriSAP6DKuTBsixjd4tKTE0QVsuvpjpnEvvKN/uUWAhYTD53v?=
 =?us-ascii?Q?BDg6V+GpaszqrEaz7TBU34EL6D9ROVQ2xkgKV1JgjWDbaU3d/TdFT0Ve3zy/?=
 =?us-ascii?Q?7NQtGqiaXn8AgzZj5eJ3BE4gOJHw2VQHqgx9JMWb3zVrprCnI8ui7Pk+H5w8?=
 =?us-ascii?Q?rXd5WHhDBeuOSXegGHrGhYzdpMJ+LCl10I/8uEGeNQINxrIx8Mx9b9VUkOHb?=
 =?us-ascii?Q?XvmLD7Bii7ZVH+yfFVwJU7agxo/4iIaVXEYJvKgspmgeZRgvwnzUEPREO8KS?=
 =?us-ascii?Q?dJxAmglUf0D0ve6V2UA/DllzVm9EOnlj/I+3o3+aw7fV1vQf/boOPzyLKyRI?=
 =?us-ascii?Q?IEucr8dfCfQsqzadAIQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e356390-dc74-4620-8ead-08db8a254252
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 20:01:23.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Q+eD9pfFGAhWH/aolVKkD7yZ6Xx60cI0J0FLau3wNI+jjugzKDOAD31pEZn1bNRipxU7W6j8osMRa4yK8rSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[Public]

Found the issue, this commit is also needed, commit 0c3855ba8dad41c4113e73f=
77eb926e44577e4af ("drm/ttm: fix warning that we shouldn't mix && and ||")

Sorry about that..

Teddy
