Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9050773D76
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHHQSM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHHQQO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 12:16:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B930DC
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 08:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeiA75V3WWEk16f1EeOzcXFPFtoLAHASaZa+c21FrsS9rCScwKJzVcHVRAXrtOy4i310+EcT/RRlKbi+55GIWEXitnKVfiDw7ox2IhDvyrFWQyjFtUvMnerCDnU//sVvaqeGEh+VngO2vcVVDlcUKvdeuWvq0asV3yHtbzIrjGbosa9MtUgcTV4w/eYOXOqDWZGfEYEj+W30HItXgvVId0LoQ9JC9fV3tLMIk8CaQc7E7MFb7FO6fih0SdR6BoxFGl4WVz919zKCoLaJ6rDdmwVwVnDHvxwoG0kCue1oL7iwRRDLxGxS/Fa5RnqjBKg+osR0o+eJoAFB0dtBoMTx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWcrJnv7QMqDnPLEP540T4BuNIOoTnV5jSoj4U+yVDc=;
 b=P+iSVANCe2hHdtXzDQuiquDQ5ykDMeD0dnuyUbv+NzLiHa7gckdJj6k6b59winocRAMwe44C8c7paRRoKTRUTXTjH1gLN6haJkan3i2fLg0l/LkjxGkL6f3oDKBRJy3Xk8a6qlbsRxelA3IVgi87riNbXGdMRrshHBMcFALzuqIPwU6WZQ7qc2jK6bp7ZSHQFwAofKvQuG210KmElmSvrcapnMyoYS4lx3vke/Qjbo37qQBeaRRF2fTAY0fq4mcUrTqzkM4LIsKvzPxPlnIsPqDfQum4C6duc3FqJOkEdPXFmVzwD0XKLgh/AJ0wgDkBBCFIl3ZiGDTkZG0aIU44ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWcrJnv7QMqDnPLEP540T4BuNIOoTnV5jSoj4U+yVDc=;
 b=DuZ04X+rdEZRVh5Wr766WY6zCfxkvnb3roGP+MsMsvX3cya7ze9Y2hH6VV4trwFNdXGMO1XzOasRCgETNfl9I1B+fh+vetbLR6YQ0CqRAIvGn0xf2nTEcX1wZRelmNrm0XSeXlKSvvrsq3JJW3jDp9D4bzAsoVqUsiim0iQs7A4=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:56:13 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7269:df2a:4f85:3aae]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7269:df2a:4f85:3aae%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 09:56:13 +0000
From:   "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Recall: [PATCH 6.1.y 02/10] drm/amd/display: Add function for
 validate and update new stream
Thread-Topic: [PATCH 6.1.y 02/10] drm/amd/display: Add function for validate
 and update new stream
Thread-Index: AQHZyd6Q0yg77prryE+ZTOKodyfK7g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 8 Aug 2023 09:56:12 +0000
Message-ID: <DM4PR12MB52945F277BB4DC73FF170A62950DA@DM4PR12MB5294.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5294:EE_|MW3PR12MB4379:EE_
x-ms-office365-filtering-correlation-id: 3f7a7bcf-3871-4c54-c3f2-08db97f5b302
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2SGl/zKmKEOR9kDBpZRc2j8B3d9+g+U44Q30ISy2/mF6tMu7PRkO3EutYbuHfhTG0wrmZzW99zyttEsiNCcbR/b9QXlMTrYeTv+Y74yxNIhHd280hevI534TFKRrDgwPYaL29naNiWgkaYrT0VWZXKXvXCiCTSnCPbJoEtq0m8Zdo6nbFZyu/qDRZzoO0boxtLmSSW1H06TFeyitHegDzDX68gRpB295Tp9jZkBIkspqRv2dqd4llKC1uAtgcWYLIbZR7O35vtuXpc4R8enjkDhb6VgazJiNnExQzAgtHiRDO+XBFKkCwjhqz1k75Wya2cQh+bq5ZqB0VUi5OcgLGCGJ/QFt0CejjSiwB1yxBhoDNjRHEwnovuPeNvfNkyk6dALMhQZOe8v2MTkxpYtYRay5zkEAuWUCwpJP4Djrm4AxxHTwV2f+g8PMukkWTF9jts97HJWeqyARZ7N+6zuu7/J64pNdJld2SIfmmbcC0GwCWKiwrN77A5x8SY1RnGaDzfCBcLIwZovtlfBh5O7CarUcz2LfDRwiQsGSt6ukqGEiN/QziGrayt0uN3/9KRznsmkYdtPY79RNMxzuksHGaia0Yqug7bOIh/F0q/03g5k4fJjAQfv2YGy2L0A7dE9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(186006)(1800799003)(38070700005)(8936002)(8676002)(52536014)(5660300002)(6916009)(64756008)(66446008)(4326008)(558084003)(41300700001)(316002)(86362001)(83380400001)(55016003)(15650500001)(2906002)(9686003)(71200400001)(7696005)(6506007)(26005)(76116006)(66946007)(66476007)(66556008)(478600001)(122000001)(54906003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KLuaE/LiMzARw336mBiduDGWi18/V42g6QkcjPqgVVGh5jfDCIwnt7Hlv6kk?=
 =?us-ascii?Q?BJyAYFGSFfostFqEX48HVSfbTytd/XqGvIcp/hFEv9eNT+JrA8H8H+jYsYU3?=
 =?us-ascii?Q?pBRaPFQ1OSle+oUjBDLu4X47YIOooJEN9/l0+CkmkyCvP7migxd1qO0q1Br8?=
 =?us-ascii?Q?XJin58o9NEPr68UmIb5hTkM+ajJ9OpvlZsVo+j+8O6kVfLym6gexsXhTaVYS?=
 =?us-ascii?Q?VwAvsxQGOyo4KbTH5wRlfEUyQYRAC7LvF6S6WXbqbjDqvA2CIfqXNhJ2h2Jr?=
 =?us-ascii?Q?tdHZpjdZVBrZbJQSe98O6wTEcsTtu863dUzqJzNciaZBOdsjAHJ1AkQxl1tQ?=
 =?us-ascii?Q?QyG8ZxHqPEQ1ERbg8D1EUoq4vewaRaPghJGR3BokfeW7bTc+slbcswdmU9KC?=
 =?us-ascii?Q?HG5cllzCmWor0eutqn0SMcFYmhSvsMPXEmpPw8TYb0k6HM8RG9EONEWLndxu?=
 =?us-ascii?Q?Bs6GU5QtOy/9MkaY8C7gZsY0GZSeWVF2BtxSDY4ruzH52iSunFqpKIwFob40?=
 =?us-ascii?Q?JjNKAv+fBGsVYOlVaw10RpbNO/oaB7SfA2FoQoRa3nMI6lTmwcbUmD4eAFZs?=
 =?us-ascii?Q?T77sItMJ+ucMwzobEdv3CvvJ9clE0NpOGF97HhZi8Ff5qBMpNT1L4fMAOaao?=
 =?us-ascii?Q?J6DwTKQwnNx/S6GrZHVpAFBWVP+5dL/oMsM6PxfdvVuPFt+pGmFeUpaYW8mL?=
 =?us-ascii?Q?F4y3JriiZzJgFl5ScIF3h21Jjyxwxl8bl+WJpBJVEYWXJnDzPZIDhh4O5ju3?=
 =?us-ascii?Q?I5E6okukcD1RjZ/FsoaG8toXKDKGFcFoyfxbDcMerv65NS6EJvPBniJq57l+?=
 =?us-ascii?Q?iNBbO+fYU0suGjTjKpY8c0NIg+00Zr8gekQt2qxAVxiOuGW4LlAtMEVADxVf?=
 =?us-ascii?Q?Kelxf1F16CiwyQaIqj731Dag5q53bwQZS3i6DhK0RtseKKWQNhuiRTr3qZ71?=
 =?us-ascii?Q?ka/N2K5buNjR9jQSJe0ctvlVZtFw2b/xHn/xprvxya7OSgHNrYuSRV7iX9C3?=
 =?us-ascii?Q?xjFTeJ21R5dzD3jAhl7u+S2v5Uc/uQ/PjzCushc8VpbgSWA61aHhepqxBIwA?=
 =?us-ascii?Q?z9jvmK3KOk7H76kxb8PibiRLQqnohRlN7q1yjBIWqQkgymssQt4gnjn8zGSM?=
 =?us-ascii?Q?JD7e0mLa7XeT+PGTWJEog7cbokhoEkrdI08gSG8Ooe0dMbo8LtEX8JlHRHuW?=
 =?us-ascii?Q?8aV638LVWrMGFhCnnHKBj89eBFGlSE07XkqcEdn5pU7nDOi7H6ffIxW+AARr?=
 =?us-ascii?Q?/uTQCvMrBTP1sNL2ygi1UfEcdUBYwiycp8heuBX8CaEtxnciiK1+UUoIAfav?=
 =?us-ascii?Q?6eg+yQWhaxn8Wt/igiLWkYfrScBu+iZgsE05zQP4Emi5J5TDl+HeZr49aS3d?=
 =?us-ascii?Q?jg6bCrNdI0qYOVWRNp4h/ZB7qHCmD5nAUMgW0YCzsuX0jkIOayUy0HLnf/EH?=
 =?us-ascii?Q?4iVncfuOAq5xUTb4y/GZTd5XEIx2FpNPYSKSTMZqAF79oAKP0cYB6o1H7zGX?=
 =?us-ascii?Q?TuV+vR6SLQA5PkqtCW/F4YAUTbUMdRtCebQJLGMdn1wPYZeVCapMiH7dYZdt?=
 =?us-ascii?Q?FtEptRsL01McW1PpFXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a7bcf-3871-4c54-c3f2-08db97f5b302
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:56:12.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTWrO5tjpU8HFG6d8vpcZlIzg1r8TaEmhsDC6bgqSpuQdl10790FOajFEjWfuLFAlxng+MNFLMrobSp+LjGGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Yin, Tianci (Rico) would like to recall the message, "[PATCH 6.1.y 02/10] d=
rm/amd/display: Add function for validate and update new stream".=
