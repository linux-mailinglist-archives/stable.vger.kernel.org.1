Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86576443F
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjG0DT2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjG0DT1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 23:19:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7981FC9
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 20:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W43R/uAGeky8h/YeEhB4CgKwH3zK5C5zpr/0fFkKh5Awik/3sfIeGLPdCnjnC5IXHjXagbQLq4ECAGaqTKMtKCadiSwQZp60ViBa7W6HME3kOhbwDkUgZPgLJpEeRLpZN80MxVcEROZ5ISnNLtZAis2m6ifM/YseXbT2BoHl21kRW2CqBivcP6zgkLXd9wBeZXBCsd82NhWV2jMdAATrXxRXu0iwo7pF1MSezT8YGrNd29QfQB9n16n/cLNCbWqsLLvap8oSF72ecseFFozMLDf0XXPY4oZcUUV1fUSaWQh54lgbTwmcC3MGyMostwolH6XXMJgV76sNjEQJqm66wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZwpdpGPYfII1tPIHxXDT8Fk0nx8Yj/LfmJR6k2GEMA=;
 b=mgwm2T+k/aoAur6Dp4vnmmORFSWDaGHzzmNT9p3w8Uw+SRuc2i5vgYyqYuZoUbvtbDB+zewv72LQDpnwQ+pNQgIM+MN+NjLCyDuWgG0viNekGyHR13V1qHbjjJjpVeh3osniv1CR7u7MXP2UkdMBhVEKRO7GKEKi0X7gWGFELfcvRQ0WPyAdTQhJZYnrxrnRnWdVVPSYptexqKzGeGmceZ/JZRTe9CSS4W60bg4HhwCABBKjQqAbibvhONGK5sgNz/6VniTswrIoMCv20NgxoBeD8lHFNNEskug2NjtE3Rrrl/ThFbXH7qhiCkqRXHI93zxHX8J20BwTiD5S5kU+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZwpdpGPYfII1tPIHxXDT8Fk0nx8Yj/LfmJR6k2GEMA=;
 b=NCaCY3zLtXd7DzMCnPD/K9FBvNmO4V2ElgVFTsyoCKLGnZk7u0+rgxOROovtbBUQGjoLHZpqQYOr8vrHLpHKxcw+u0130zoHHQy+PADEhY7vSlHO+fONeRutghvSrbckwORtXvZOqNqwJeu8p5lgYFHLqDTO1gkOo3RLRZ5CH9A=
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:19:23 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::2dbf:8d49:6daa:dda%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 03:19:23 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Kernel 6.1.y backports for "dma-buf: keep the signaling time of
 merged fences v3"
Thread-Topic: Kernel 6.1.y backports for "dma-buf: keep the signaling time of
 merged fences v3"
Thread-Index: AdnAOHXTS7c4xwGKQAKUMM0+LrBX9A==
Date:   Thu, 27 Jul 2023 03:19:23 +0000
Message-ID: <GV1PR04MB91833432B91E4ED2F16E63F3FB01A@GV1PR04MB9183.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9183:EE_|PA4PR04MB7950:EE_
x-ms-office365-filtering-correlation-id: d7760bda-b922-4146-5946-08db8e5046ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzN0NBGHeGObY1cqx7TiTlhdTTh3Xo76u/jpMdbAOjL3QtsPWP4oyi25jehBLncBDPXPVHzLjrRkHLdLtRbhDDOhDeP0mDvF5vzqcsxoXg8DI1WeaYovrGnK8HT9RL0ZPmObjlq1dgIKC8bqyNzcGyN6DH4V0PUk71nSYu23lgmvN/yIoCGApPnuHr3IliY0A0ppri8xzWzH4jzWquVZ2oGClCzxDSrwgskkWeKxSom7xazGAHDuVfiXZXpCT4O3w2TS0PivG04XiZe4rrO6iDUfOddR0ZFqpM/tprmp5oxgE4zsJKPPUCpSr36SiyT28fSj6NIeISFgQE1UUuUixT+4Q33MU7zvwaLEzTaAuUiEKUuQs3dN6CpPwE8gbqpQVDJGebIVFad/B6UhMg06fmnYXUp9DNFfoF2rhPA6ZwbPpPl0oHVZWPF45inrZN8AdMy+1I45crhNMA3hm5SbOfriEhN9t57hNr84aFXUvpYB3R+ZXR7lp0taVu8VkvPyFz1pLgveBzn6UZesCsCIVtlLIHYIh8l+cLjSIjDw3tH1oyi2mE3kuvioFxBAfmqDv28vgESjOnElMb5JFRCNOPDH3Tye96HyvZkoIP2/Sr0S1Oj2++/V5X5i5cBb2XXk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(2906002)(4744005)(41300700001)(316002)(5660300002)(52536014)(44832011)(38070700005)(8676002)(8936002)(33656002)(55016003)(86362001)(9686003)(6506007)(26005)(478600001)(71200400001)(7696005)(83380400001)(186003)(66446008)(6916009)(64756008)(4326008)(38100700002)(66476007)(76116006)(66556008)(66946007)(122000001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XMs/mZgtNXHMR52Lw/tQmDGH8zI7iUZa1uys+NEVtyLxO3JQxN7Dd05/pMJN?=
 =?us-ascii?Q?GReQs/iSKqThpmiwbvVz7W5MMh8WufF1mouoxNRdROlAA1iGDLV7Ij2SOVnb?=
 =?us-ascii?Q?XioLQRIzA2VrKApr7Cd9LVOPJsSNq8WJVs10L74kSh2lkaVDi6gOg/OvrJWn?=
 =?us-ascii?Q?qaeu9PTTM9amZmrm3i7G9S1Gu1wiePp0zLOx+KNx7M/Yja01RpVG7EXme1zC?=
 =?us-ascii?Q?5YgtNcZa9UCWFiJCbNIdoJL1RZG6qZrfBXWtf1xFby+HQR1Q0J7JWe3iAiNL?=
 =?us-ascii?Q?bTlB9MubQX1Z/C+GdojiJ4BisOYYOZG5Psc6v2Ln5brz9OII1d6/fTuZi+gJ?=
 =?us-ascii?Q?bYrBrOpJx3EdkMHDYcCe+iLHyW/CIEX8u5L6EAi/CjQkVlD3ToE9OIoyzJro?=
 =?us-ascii?Q?qg4fGabAZHNxvsmMXrugZOeizea5amYrbQ/Mnq6/qBTxIdP930Uj4mMNZoUU?=
 =?us-ascii?Q?yQwzY84kgJVfx0KZnA6krpFKvVb5eix6QZjTK3Puibit29k0dOK/YPUX48us?=
 =?us-ascii?Q?1RGBZymM28lpof4pBww6+laV9l8SIO2B2iZ8KKE9j61DOpmlwN09F4+D+DFC?=
 =?us-ascii?Q?fmj+dFX125d3sAzxJv4zFOiuz4MUQiGXOYteqEiS6UMcVxd1G4EW2grt1iTd?=
 =?us-ascii?Q?TtzCO+hYHimfy83yrjuImuDNTRIPoVO/ejOOb6Ap6PXqAdorvmjbF5C+2o7I?=
 =?us-ascii?Q?3RxGupFg8xvLGC7PjNR52F3+wQs7d6T/GWcVIRh69wZtHj5KsqhpIkKtujFU?=
 =?us-ascii?Q?zchi1SDMqKVVK61EaWyOArxgWf4wvepwKpJpbSG4gPplMqkp8sBczAcB2CBB?=
 =?us-ascii?Q?Z7JN5HiHxLKAKaSL8zDlwDGIAfPCUkSia5JUG2OXGxk5Rylnu0UO2PnscptB?=
 =?us-ascii?Q?9Gbi/n7Jf0w8dgIJkqN7XN9+ooZpNR4f4xMZX80hKMQTAaTW3Iiyt6zUo2WO?=
 =?us-ascii?Q?kZysl3I00fQD58RiOMnnlolCUTD6DSg+EA5q2IS4dCck10CL4YZmyXZ28xFo?=
 =?us-ascii?Q?/DVE3S5RjNzX3ihBeUQzcBxFbhSQYUrkcaIHnItJU7HnrkXEt1z5F6RMd6f4?=
 =?us-ascii?Q?XgMofSfUuAdm6NyzMabyFhuuoTlHpy0GFAII1fBa9fJUXMbXo9ZpHzsQP24g?=
 =?us-ascii?Q?xzc9X2mWRuyV9nWr3Gk1cKuf9YU3gekisO8Trm7ijdDBZLB7iD+5NF5864UU?=
 =?us-ascii?Q?Je/tjgRLIvf1b7WVIcvkG5hp7BIRwKp5ZVk3E9LSA2ZcRLnFLooW2n8nK70Y?=
 =?us-ascii?Q?7QM0RoQESzMHILsJWPNBTshYc+CfDkKctqHuoTHPNxfP4x6S5JfphAEfe4aS?=
 =?us-ascii?Q?oHXQtTsSZafnjbcis98NFZemqqz2TSpWaD6gdvskjRzTv36ySn4fM2G1QAkG?=
 =?us-ascii?Q?6pHIukUcNmD3zobt9qNC1TXnzewfOj9lYe9NoEpJ2TyXViUsDUtggpF818d8?=
 =?us-ascii?Q?A/a0Dn13BjsQAASiB73lGHdAGuEdn7b8Je/gbl/QnD5otu8HvIg3BeC7Kq0z?=
 =?us-ascii?Q?znfPLAsV+mF00Q5bbN9nZCrYFQz+/RsYqqAlkvkDLMppy01Pjxl2ylo1mYJT?=
 =?us-ascii?Q?PNZB7Mzfiglig92DXdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7760bda-b922-4146-5946-08db8e5046ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 03:19:23.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRexNxYEBf/ta6MtTmLIuQuXe2/+os7SkeTg9s5pYUQ8cUwL/PHLIqpL0dES6uzPES8SFgty6ZFDh113GGrAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Please help backport following two commits to 6.1.y

f781f661e8c9 dma-buf: keep the signaling time of merged fences v3
00ae1491f970 dma-buf: fix an error pointer vs NULL bug

The first one is to fix some Android CTS failures founded with android14-6.=
1 GKI kernel.
	run cts -m CtsDeqpTestCases -t dEQP-EGL.functional.get_frame_timestamps*
The second patch is to fix the error introduced by the first one.

Thanks!
