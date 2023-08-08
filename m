Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BDC773D77
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjHHQSN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjHHQQQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 12:16:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBA230E7
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 08:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrVk5d1pMAbE4+aRbz2w2Y98aOYB+ZSBQTU7lKvxSJHkbOxhZQzDB1m37GwLQkmqDR565YBM0DBzI/fvSlokQZYFHb/PvwVDJ4jduymd3jAj4Qqgbv5K7IkN/bR30w8zfhYd0RyplTN/2erqlvIyqGoK83yFC+iJQJzbJyG+pXEiixe59HN277OIZBIyEspeekw0hz5o6wP7n17KbnQ84Hg8sCSNe39Mdl99V6xdtq8kvh2BxwZOLKPkGetlDldMKo4TiDEbzTocV2jhRhdeZhR/O6dt49unP9RbrT2k8Q6owcwatEKuMrYdTG2v445WxV2zUbfdo3sFTndunMzlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWcrJnv7QMqDnPLEP540T4BuNIOoTnV5jSoj4U+yVDc=;
 b=OJoCn9hT6Qj7kQhSLoCnMZj3pFyAMmSttwjmL59UMNccILa1ajKeV9r7sgcpM4t7CaYXdSy8ynv2vmKVErlo7PZaiuD0wzHZHwa3xshG3Vb/4g/rWdw7wwOu4ZYTwOjz8Q9yJfFVCKg1jSgRqKZR4aypqDgT+X0rJiObW5uJ35BX5OwOF09W8GJWqdCLMzpPm+OPR7AJs80NofSZshopvpclo8+echLkKKrNt572X4TiS7+YgP2lyIxdGMSAIti61UN2xxikP0fZhXj9NC6aoswP0JwBDKV38PknSiVWAPOcmTNQEVVRsh0eQLOD2N6G+viwc4P5Rt0deQXOrFiJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWcrJnv7QMqDnPLEP540T4BuNIOoTnV5jSoj4U+yVDc=;
 b=bNgWXGdLKlI2GiLzeNT/XRl2f4uU1tYtnAs8kX94gkxjjhdnvXQnGuN/BdymYIrvGgqVxw6gJOG69Ch2Eu9THDLFFn1nEppL6oTgnPFVf8UwPaB8G0UFv6QBTAOjILfBfRFTNDktP450EAtUQrPAglNvByJpxQloShaHTPTWr1I=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:56:22 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7269:df2a:4f85:3aae]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::7269:df2a:4f85:3aae%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 09:56:22 +0000
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
Thread-Index: AQHZyd6Vo9KtMTV9rEejEZX2hZH8WA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 8 Aug 2023 09:56:21 +0000
Message-ID: <DM4PR12MB52947645919B9B8BB6F9E713950DA@DM4PR12MB5294.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5294:EE_|MW3PR12MB4379:EE_
x-ms-office365-filtering-correlation-id: e5bbf36a-76a8-4177-15fe-08db97f5b86e
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TViJSO7ePQ+1xj+5uEozpONSe5ADMUeyNKqwBPTjgq2pmqws+7zBhRJPJ9f1YBtFKb4VOmFuIlu4xjikW4/RKPYqynnuaseonGhsdiOvvGVsmz40s7+WnRqzvFyIFcfoUKnM9gZXPdLnEoJ3BUwv75tBjk+ObZTKbC3bBEf1F9UbhELu46qfJM1eHPvrPPEJlqKFuZVS9lpEABwxbK2gZ3wx/LTTF/COre72xncjVT6ZKiPAwR2//bdYgaCVhZsx4hfoNWMwgEGBDB2mV5EcgrXIMh29oenT4VHTZEcKmWx5cL0DkG4o1CLDHdQnvjC2PTLLzHTpD/pw4oFTqjzkwvwVPKX5hDmDR05ffANsMP6QN3TxMJK9w54jUSeb/BSbilPH1qLhi6856ryf/8qGd9dOwYjFhqnODRCTs1atpA6GUbx9i+jFemL4HzMR2QTKt9Jl/oO6t9mLw10gtmCdINN6TwgjRdpNdwF0+tu/2rbc+tojp5BpcsjIS/nDPLgkSRRyhKuFo6eA/gsfj48FyWqDu3s7eKiZQM5JCzBVn5+DL3zeSi6Egq/wtOyrFkMM3pV+G7IE7TVuZZyAqWw+nAKkxpz5QC/R/YgKmjzmV1t/5f2WYVYtvi/2SW/3tOX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(186006)(1800799003)(38070700005)(8936002)(8676002)(52536014)(5660300002)(6916009)(64756008)(66446008)(4326008)(558084003)(41300700001)(316002)(86362001)(83380400001)(55016003)(15650500001)(2906002)(9686003)(71200400001)(7696005)(6506007)(26005)(76116006)(66946007)(66476007)(66556008)(478600001)(122000001)(54906003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sGusjW2CVAc9deEQ8WUzQV8wYPvjNBN/uzfh+JSnE42idI766DQXDIWXXKQr?=
 =?us-ascii?Q?sX/rCwLx6cMHA6L/h5zCjtpAqIxlFFvTD2iSysiKuyYiVfDMZZy3Ii7wgaGf?=
 =?us-ascii?Q?rQ7lwu8TbDhPUed1zvnVGg5I+jq9+jK6TRszqaHHqccuYj+tEhe/B163eNt0?=
 =?us-ascii?Q?KJzYqgdS8MOpF47wptXFOxteOM3CZAGcDcFEb6VXf/hzUFkmGk2EynruHD4U?=
 =?us-ascii?Q?aRqn3d9VQ5l01mUspQUbbV40gsQYJVECwMGaj5esssfIJKBX8sGJLMWBYwP6?=
 =?us-ascii?Q?awbuA2KlQNW99ZN1Pmp+yRG21YpYV3VhfsL9u2PtEzvwPUtSuzbduKJek3xf?=
 =?us-ascii?Q?42HogZiVhn6ug+i4qiJYBlW553LpEI0nTUa6/B5BKLxXIH/8RI3c9o9BUyIb?=
 =?us-ascii?Q?W3X90AyoGeiFtAKBNbYot4rzB73KzXG58vLxjrcNiALMG/OC4AFOjqLztXKM?=
 =?us-ascii?Q?EMdU39IkXBMuzzOMSFKmE82qstzR4Rp/CDd7B1fKzHjXJ/V29hILdUe1aZww?=
 =?us-ascii?Q?dD7GoHi2hKGpN/+1ngsNCYXDYvPHkCyBDhoXCgjlMkuKzLbbPHwF0aFEkJ2d?=
 =?us-ascii?Q?fF86HvZJv1l5g2ZawHxuoshVtPlDj1T9xyTfF3Zc2t6fwulZSrbRUTt2bjNB?=
 =?us-ascii?Q?XwnBUn2i+asUcKskRatm0RCm+/SLbF/hQ2rtnEnq63IQV7SSg4Fqd0N3G0FO?=
 =?us-ascii?Q?5Pq4JFxblRRT0lI5kai5IiLBCHDyD10sF0La0htOUm4d9AxphqFo6w/kJ3Zc?=
 =?us-ascii?Q?3El/2pgiGBqXTRGA/HdV+t+rr56hNpojleUeaAEw9zNpnduLeWIXgxD0bf4P?=
 =?us-ascii?Q?du0v4MacOlpToa97i9T8KxJhZAi4puDXOzAZZrxzhrJb9L3DX7KcMNLkxESa?=
 =?us-ascii?Q?A1gTkoEEd/K1dyMLZDZ9eT2bWazC6vfQZBk8MbjSuAR3ObhIuIn0uazvYISQ?=
 =?us-ascii?Q?o87Q9ydRXDJjoo1eoQpIez3nyDoQ6Gvvr4gRkhpJKA6k8lFZmWk0EpROnRmK?=
 =?us-ascii?Q?cj1eUtwArobU1CRJf9YtFi9oOBaIYhuPwZNWcuG5geYqylkz6Po8Q5ZklhTY?=
 =?us-ascii?Q?hSh/ifmxGARIPRo3O1cmF61eyDGcD7IHkO/It1jq8wac1713lua+mci0u20C?=
 =?us-ascii?Q?ETUl0oAQ/ZOFyXrUhScSiecpf9OvkcE7/0y/7iNc/qTnf4iadYuOhOg86n5g?=
 =?us-ascii?Q?arWyJjz+cWr+QJnPQFNB6oXx+6kWCj9OB8rKQ0fvGyQVU/OmW3aqoW5gHXJw?=
 =?us-ascii?Q?pf5iwIsG+4gezT3EOBQrshzR8Q+zZl233C8N+KMBT3f7VCJl6aglTngU0YG2?=
 =?us-ascii?Q?IOCw38M7gq8thogOz7I6+sAksYOZR8ul3NM9lacEY0YP0zGTHPP8b8AXasFa?=
 =?us-ascii?Q?rNQbLMlqgOq9GYReF26L6Y7XawFDYIotoj7rlJV1M3Cp4So8z8WhCjQEIl0q?=
 =?us-ascii?Q?ftf+yS4+GeQDWzThLPpAMzWd/4gh+8ueOAgzf8ob2KDuIA6Fd3GJcwEwLRq5?=
 =?us-ascii?Q?T7bzsox2KV/XUpntKoyWbCsgMpji5/tRAhg3zSAvDMAFOAhK1shXD3xN5Ey9?=
 =?us-ascii?Q?r0oNeqFAprFl4oTiyPE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bbf36a-76a8-4177-15fe-08db97f5b86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 09:56:21.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOat4PaPP/bQkvCGdRfgzkRQvDseGbxLa25oXH/vnq2SEQ0XqEXiJjpmObJt7w5vYv8drXT44OWmqQ/y1PFwBA==
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
