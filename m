Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FF7433BE
	for <lists+stable@lfdr.de>; Fri, 30 Jun 2023 06:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF3Eto (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 30 Jun 2023 00:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3Etn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Jun 2023 00:49:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17E213D;
        Thu, 29 Jun 2023 21:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSUXg5WOoGZiwIr6upXEagutvBlKvYnz5jh1O4FZVogiLBOSsNPClgHJeLrj2sRbW1cdXg9EAMGjWOfu7jvAbeL4Zd/dfjB40hS7wFx0DxmmZp1ZDhYykFrHpJ3Pu9AkkTbZxsJ7zc8BQDpnyzCwQjFLvuFUrk1A5rrIJHXsJaU4m5XlZDwlcxY8ja6K4Jn1BxDBLm+Dr7fBgupwal7+bjt7kWcmLVOQV9sX8prD7owKxVeNDOzaiIpH0Qj5yss9Gl8TH0rEn4FD6Me1n3/a2cvDmIXRaRNuMW7pEo7fDUoojCXT26D97inZVW2mKfmIl2giVnt1Ng14zvjoI1a+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCd5Rvs58Mq3+LLLB/f08cVskClwyI8JlS9mnpNRHFE=;
 b=lrccui0qJ9U5eCqhCuyoHZB2eajnb2lcpTFINa4vwsCiQXe7aL1ETjjVyDL6q4fRcekqOErw2guEVx16wGKyOpvFXGkvny5dytNeYZVL4S+YZF17YCcrTJdkYUayM/gOCwpphnFsyNfpG0A47BkysTfr9SJRwGaLgk8Xv4kdv52p413elyfCgtaiGjCkN43sXIL7/YTsWk1nNCfkgd7WoSIDn7yw5OdfK7dt15Q4RoupJwr9zHXitw8NORfA/oqNLggI1Dr/I9bNAM1iOsl0dwzOkfWmJAOmNRtN4y2+rCzU5vTy43mruBtn3bAXE97eJNQhSObAM79DAP2/Z0M6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCd5Rvs58Mq3+LLLB/f08cVskClwyI8JlS9mnpNRHFE=;
 b=f7IE9VJ8+u3lIR5gq0TiYKegbVGbDiVkP3/zhimgxC/UE2pQ6Lzs2QMpdzgadp5MhMmL9LFdnC+ped+XaYKQzrZa5GEfdGf7cEoXdEpdOCWuIG26GJJmmPganl0+5yp5k/lNnnBZZAkrKjTB7lhb8EZe//VdvESDfVDZgvb+vrI=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by CH2PR13MB3862.namprd13.prod.outlook.com (2603:10b6:610:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 04:49:39 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::2aec:8e7b:b75e:78%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 04:49:39 +0000
From:   Yinjun Zhang <yinjun.zhang@corigine.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Louis Peens <louis.peens@corigine.com>
CC:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net] nfp: clean mc addresses in application firmware when
 driver exits
Thread-Topic: [PATCH net] nfp: clean mc addresses in application firmware when
 driver exits
Thread-Index: AQHZqaOLXOVk2Xo1CEa/r0QfN3RTBa+gs4wAgAIUfnA=
Date:   Fri, 30 Jun 2023 04:49:39 +0000
Message-ID: <DM6PR13MB37058006B5841153E6B95E59FC2AA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230628093228.12388-1-louis.peens@corigine.com>
 <20230628135922.2e01db94@kernel.org>
In-Reply-To: <20230628135922.2e01db94@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|CH2PR13MB3862:EE_
x-ms-office365-filtering-correlation-id: 52556b1c-8b2d-48d4-5cd5-08db792569ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJJKzW2GEhklqNR+IN95VEpsz4+OuyDLDhUrCkPOjObWGn3yLIcGMZ9DrklLHkJgl/UWQPUNUhlXHN5GGGBf/ddRtrx8OGH9kxbG+ATgyxUxA2/SNyWhCOx/g6ZPm3PNaSTNkp0cbfRDYfn/7cSER6/zGASo15but/iRgm5K3NRf3rx9h9HLUVbJRkRgbobMgHzqPYRmGyybWzNz5FMyl/AiX5dLNK1BOTcxgKbFT3pgC2tnPKjW4sa9jRwqk8/Qj7LdRr1HUccz2IU5lb98wOhzu8HOyJZVpreg3hm9OprgIfuEdr4F0r7onfXfU8cYmaPDG6sKEEi/bpRYt6eO9EWlVotzfsADN9myC+2jjClWWhpP8DB1xxMJIwPIDHY4wio9JnoCN2ozbUr4Mnw1C6wOHtLCf9g4tI7LaLF0A3HiRmOjZkbxA/QPB4urbUqAjsvTkQ6YuSo1lIb/eShvY7NhFhtgyLTphrAnEWpUQdUvcOYGkUS6Qz7mcHZ5Wf97F+f1m5Rf24wBU6y/95ASKUBHb+O6cJpdI/p+JDNLlX5BxBDgiih9VhQwj9k/y0thyRfn7d/RhtKDORlO0Pv3Qm09mQ4DcRjx2y9qTbpRko9MZTQx6vCFPiOwW2ftszbkA7RWRCMpZGYvaVYKN3YkMbJOkLWliE22gdenRP8rVLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39830400003)(346002)(396003)(451199021)(5660300002)(52536014)(7696005)(54906003)(110136005)(478600001)(8936002)(41300700001)(8676002)(107886003)(316002)(26005)(9686003)(186003)(6506007)(53546011)(66446008)(66476007)(66556008)(66946007)(64756008)(44832011)(6636002)(76116006)(4326008)(71200400001)(33656002)(86362001)(2906002)(122000001)(38100700002)(55016003)(38070700005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vaY3Jf2caEByw5+2TXxNKVgzNtHFSH9C6k2DUNfN/TEPHc+kSSHfVt66hFFm?=
 =?us-ascii?Q?zf9HIMvnfrzZ4Fd666d3c8nz0afGrNeXxOLzgVkEMu9QezUE221juSJ8Uudw?=
 =?us-ascii?Q?VxZwZCntCELCYOhYVtpSfsEtZxejwZ4oEb4nEeXoV9CKPmHhtYReb3d3snor?=
 =?us-ascii?Q?jV/vswCt+dkNUnbUF1YdZ4GFBZ4RIToJkBbwQ7hsofF+rIFCVCj+1LOgPpv/?=
 =?us-ascii?Q?l7IRohspxoU1aHX28UBHMtOFot0yxDDuARk354/T9pzd0YYpEnew/5xZs1Fy?=
 =?us-ascii?Q?R92gjeAvv0tm/IyuM2/ZXMAqIs4+orYlpzaEKxpvokEzZmkcQWr3lgpcZrf8?=
 =?us-ascii?Q?0jJTf7W0v8NThSijyRGek53cyE3p0DkcIJDWcZcp3Naok2e2TheWfBk2o9xC?=
 =?us-ascii?Q?kBwCx0fXQXF06lB6qu5D7VWYhg9VSByBauMTSrZ5upYqY6yN1UTsgU8OstuV?=
 =?us-ascii?Q?QcyHrffU2K2fTg8NhpOGC/nfubw9jP1S26tSmf+a0i1VN135uQHHN4AL5o3u?=
 =?us-ascii?Q?s24P2HFDm28ERTsknQWB2ynPxPoSb1jEh4blYSjjsbhEpFKLtfIb6GRL9JiI?=
 =?us-ascii?Q?ImqKCqrynenS0C5GCsPvzHy7Toh2a/3QUFauNipy/w1oszZ5R6747aWiRHHF?=
 =?us-ascii?Q?BxIkNz3CoaReyecTm4/RTwZopr87V/04g0PaSGFza8bGoAUWkW27tTBrD2eF?=
 =?us-ascii?Q?BKVH4UmBRKDMQYv+EzPZ/8ccd7n5G9xZ5HQUIJ7z5eiW212dd5LXMAWWfQcU?=
 =?us-ascii?Q?aBeTVpnF6n4nsRD72QtH4WSAzwtgc9yjnmOdcifLPPJFr5KJHXrb9bI68uZl?=
 =?us-ascii?Q?+oIUV51JN2a/Ce324yFzGokcNRPfY2QznUSMwTopbwNpyKPEZ6MoRYnKuDyX?=
 =?us-ascii?Q?DfFL9vMokE9o1jorChfEn2Fcvr8/cy2IBJY/SDQY+sQO34Sm+EyhR4yPJ+8B?=
 =?us-ascii?Q?8jvd1M0OaMqLvZu18XRlQ3yfS2w1va8tQt7eZww80j9ya5EwQuCa4xiVJbcQ?=
 =?us-ascii?Q?ow5qxLHHmGcWooDHlJOk0cKXBeUP8i8ttteUcq4EkP/vvvmQ8lcaOrQMhWoq?=
 =?us-ascii?Q?iYGKTRR3RFMQ63Zo/SjbE5d+XPR7Hd+ChyY2pHyarZb1SIF9+ZSI2wihUp5o?=
 =?us-ascii?Q?95ct22sF7aWyfrlevUvPTf1BnElL2EHwJZ00VidXSgZQSCg4CYQB31AZd5GB?=
 =?us-ascii?Q?THXRLn8nPyDWZ2aXSudDnPS8aQbNjNGDhjt6Y2vu2CxUzq4GVf/XB0dd3GSA?=
 =?us-ascii?Q?dEzwRiPMR6Qm681P14XBTldoK863/VLCMi4odHnYiIJ/foYHVTHOqSIY2iFb?=
 =?us-ascii?Q?e4OBKTJ92yU9Itl2x0qk/za+ne94OjSn6loD15ZCl+PKI/Yp7a+20kolgK/g?=
 =?us-ascii?Q?4P/mphy4VzsWdviU79S59s0+rsgWWgpU83NktXpctrq0Xy1XCrxwVavGKCdg?=
 =?us-ascii?Q?EzXPXjz125j+psQP1k0BtwxvjuOXzGBa/wwKSoFLeCCo5nBQXX+dUb3w7ubi?=
 =?us-ascii?Q?8fBvIBn2pHyBhVE+jviGEH5BK8Cxky+3rqEEkp5yXufLoboqXZtp6NtUQi7q?=
 =?us-ascii?Q?OF4B0gYrqQiy1J81SRl0ltDofLdNExKt+7e11POS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52556b1c-8b2d-48d4-5cd5-08db792569ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 04:49:39.6558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruBHqy0ka6DXa0zU6c51wBZeiFMKn5oT9lHPhZuYa5hJpyW936BYvh+2s/tA4a9JVcsDh3g/8/hEZJPDmd31g0wjtOrcENdGVYmFsciFCpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3862
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thursday, June 29, 2023 4:59 AM, Jakub Kicinski wrote:
> On Wed, 28 Jun 2023 11:32:28 +0200 Louis Peens wrote:
> > The configured mc addresses are not removed from application firmware
> > when driver exits. This will cause resource leak when repeatedly
> > creating and destroying VFs.
>=20
> I think the justification is somewhat questionable, too.
> VF is by definition not trusted. Does FLR not clean up the resources?

Sorry, it doesn't. And I also find that moving netdev from one namespace
to another causes the same problem. So this fix is not for the VF case only=
.
