Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A179EE1A
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjIMQOw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIMQOv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 12:14:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154AB3
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694621687; x=1726157687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gi7RXNugxSgg71VNSQSYa4m/jpsAkR9UoSUXYaG1XUc=;
  b=EDDdlkOEqbVpjiL0UkKzGwODB80TapCpFap0ZvvXGmJf8q3elVNq3ROH
   Z1nfduERur8IMPH0HPCtCp9BiEOj67PMiD8oCzDbudeaCivntvV/2DHrZ
   jQZhZbPY7cjWzJ7HXGGMTjjO5t4I7v1GuAUZa0AX/ZBDdpVo1QpfLeI0B
   vvZTJXCWYjsCXuNiXeHCVAsnK5GGa5ROESWsUsoRMU59AzpaBH67fJxzl
   8Vh/LofaLdb5Sg/XGvif/2jXO6+S4dSxWXWJGsvQ9rCLRN0SSGc9TjzhF
   aSuQE9Vcb2jJWVQR+HPVvEoTX1Uv2qtNSUG2GOzM4uhqQ0LPc+A6IEHqt
   g==;
X-CSE-ConnectionGUID: UmN/p/88QQWTLa/dCQcbPw==
X-CSE-MsgGUID: Lp0QNBCVQeedFQvBdRV9kg==
X-IronPort-AV: E=Sophos;i="6.02,143,1688400000"; 
   d="scan'208";a="355954185"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 00:14:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB+wbg/fjXgfwQtDMouNqjrFl8TiA0FlzgG33oVQVofB9/ZWnSdXV4pacYtkCR1KeWAU/rW+41NMETBzzRcAtv1V9s5pQ0Fo1PzwiyBZHEZ7akYwmmDAfa/mU6nAbmQD7qDnDOlbr6yTlHQLUQehx9o1KNz7kTpm/8crwERaZx9K62oSZBS9bVkgU/cVFxEl8qvsMOooLsC9GyjLQdpKfBgY/UAoHgArLyGsZJQ5TD44tr74XyXC66Wgy1jX3ughAIHvcPJN5k2PIqdG6KxmkukvZGmdW9J8DCPpmodqrE80YXFp5B57lljJ8gJ4SpMDiFnd8Ui7XiuJQkhP3phY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sSwQ2InDa9++Z/60PQWfE8TOudZY7ZzXJsn3LIVLqE=;
 b=YucPLEUYlslM2/J8sbgJCCf3s8LAEvUo/RYpyMNFIFTD4UFFxXQ8G0gORmR/BFWqgc3+cAd+uBBDlbUqvnPHWYwi+S8XTp/m4mvFE3jrUsOtQe2o1fitT+3ZPZU8P7P1gSM5fLpHOJa/9mYY4fmddWJge9vVP/TyncPiNweNu5KsrBA1gDZ/wedEOsoEItknIfdQMlyFOJwQM59Xt5ua6Vk4vbshfJD9osoIZALEilbnLI7HY25iHvpCg+9uA4ywmVhiRIYJh7A5jTk+JG+ooQD7f6zvPSYp5tz4/Clyna3X92URfK8sOsTwk2S/fipZPI30gxt5I9Dpgfdq9qwcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sSwQ2InDa9++Z/60PQWfE8TOudZY7ZzXJsn3LIVLqE=;
 b=yZm1GATk75T5AbH0RnIkS/Wp/P+z9j8/T6TwY0Sau/YP02blaxpfpOyArwSH0tOCUWdj8u8tC2kxz5WOk/3VvVcQWI1SmtU+xpVErYThJwFv1Mw1bc0orcHLFkaynQpQoOs1tMTFQFk2EnnCRR1GKlTmVzUqAa7d6WuGjH9HhDc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB6316.namprd04.prod.outlook.com (2603:10b6:5:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 16:14:45 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6792.015; Wed, 13 Sep 2023
 16:14:44 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Keith Busch <kbusch@meta.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        =?iso-8859-1?Q?Cl=E1udio_Sampaio?= <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Thread-Topic: [PATCH] nvme: avoid bogus CRTO values
Thread-Index: AQHZ5j1hsYCwaiF7S0KQOilyaTtJJ7AY3xWAgAAPPYA=
Date:   Wed, 13 Sep 2023 16:14:44 +0000
Message-ID: <ZQHf8Yyw+UC9ysDR@x1-carbon>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB6316:EE_
x-ms-office365-filtering-correlation-id: 09a11daa-a8fe-446b-400e-08dbb4748b46
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/J2uiL/RI9nIrZknhqHtCksHkYX4tUS4RJ6RE1OGcglQUel+h6a6iAvSktAGh1bNwVpAvWNUztIN5Ln9YHHd9FumfKUi9syvgRn4efrH+laWWvCY/IqLxaAaXXyp+B8ijWxabAv8a+Pt+i/lruCwz0w/mi41snL2aT9QaLNbkbFo3jrFMYDA2AackVFs3X3qkNA6N+UNIDHWkpGTBAkTnmkQJOFtKdasgqT1+q/2qpR2GW+sFEm4Y4F524VP74a3pP4exHEcbEeaKAqtmVpfzlEsiEkONYAbZRgbRgcIYbJJmmIUbUYTBziCk58d9C6TncZ+4jHX597ygkjTgKUezyWs6Ul3BAgT/g8cJN4lazZj2V7i9mibkPie0qn/pP1XoDroUDkTRURsGk8ypoKMnC5vHrdoyySoldf/bhC+EKwohhpQj432y2fBS1Kc70tyhSxMvnpTwBGq+PLt1Tubzb0aKzLYR7XosVSaLxWO8yVH0TfCLjbpI2M+aeMnRLS3VHLrZc4r0KxVE2EMXPHzjCno9Ek+3Rme2MgCKmD8Zh/ap/wkzS8LKynT0iRfg9oQO8UVAITg+3sZbcKevOvFg23p3ECzgkDNaYb32oxDopiNjtAC7ulM0ewSQEUH6Ur
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(186009)(451199024)(1800799009)(38100700002)(9686003)(6512007)(6486002)(6506007)(71200400001)(38070700005)(76116006)(91956017)(33716001)(478600001)(86362001)(122000001)(83380400001)(66946007)(82960400001)(26005)(316002)(66556008)(66446008)(2906002)(5660300002)(4326008)(54906003)(64756008)(6916009)(41300700001)(8936002)(8676002)(66476007)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nyB+fz32bYmyZ1+hFMz22u4UxFtY2H88qaWTBVcmGchdF4bKIZbjNoIs+A?=
 =?iso-8859-1?Q?2j89s2b6ZcacogNSU1lrj4DCBxilAtMlJvv43Xgvfrzg4NEvBtUBmNMauT?=
 =?iso-8859-1?Q?wtxqBQoTb1wmtMGF4TG17r4wYJmbg5Co4fLEi3OZaoETWCypPFdRqiIqjC?=
 =?iso-8859-1?Q?4k6ONIpIr2Jvyn4JNLjOChNbwHrDKw0+/LZxLEbfR/qeBZ2EyzBX+R0QIO?=
 =?iso-8859-1?Q?9wuBgZ5QGdiKOjsv6t2tukQyZvIXiMu+JXn7j4Sfvy99gClJwu0WNkd8Qw?=
 =?iso-8859-1?Q?8NzC1x7i/Fqz5bXO+Ybi8fr+W210HpFDqUVDhAY+c/To7YKQYqomF6gNAH?=
 =?iso-8859-1?Q?9eAg7Nn3wgT4LtB9ZWLObASN+sDNElvc8YTjLZIZ7NY0vSmBZOSle8ShiJ?=
 =?iso-8859-1?Q?R2CRVchM7KdmatPEz9CIXPmhMTDvZpndeB+S61J7kxx8NLsu4XCl+csaHy?=
 =?iso-8859-1?Q?kAul9rvZ7kM/C2EKqI0QqZWHeDSHvTAAR7E80OntZat5Ft2ox0v2vfYbqV?=
 =?iso-8859-1?Q?MIM/bUqkOihqPJURvXCtImje0kWjM0q66RLS8YWR9HN4VYHqR0NpRiYEJN?=
 =?iso-8859-1?Q?5WuWDI83ZuKhfqQ6x51qRdzBuOJmkuq0g3gY7XBu5V9V72SeMn8cP7tG6w?=
 =?iso-8859-1?Q?BSpWXUclsGoMMmWgFvfal8B1wS6NhHmdUe7SpY++AEmcXkNc+OCkkOo6H4?=
 =?iso-8859-1?Q?wtjpi2qSr293MO6yrqCkP5PaqmNdv/NrCX7gHyPAb3a36T1ihJt3ffDrAh?=
 =?iso-8859-1?Q?8Nfx5/CxS1quaIzHswGbMudtMNfrNkBnratV0nD2XjqihTCFeSfK1nUQCD?=
 =?iso-8859-1?Q?D2rFzewHhxiBbou9VUyg/+VWaqBOtgquhlh3TE1nrLkuDm2h+FQPDFiQ6m?=
 =?iso-8859-1?Q?a9p34uIkZbCOBggz7f4/2Wv2Ls/iK3/YDaqnHAM71Syqhqn8uNQgs9ThRt?=
 =?iso-8859-1?Q?w5b5+07NDlvxDn2W9jW9GlMqX/9vo8uUuiJw9lVHS6alx9Wvn+Y7zYKrRT?=
 =?iso-8859-1?Q?BQ0vRe+a3lGKfwU2ysJyFiRVV5NTtead1XE7UW0bp866WpNvtr952rs4ep?=
 =?iso-8859-1?Q?I7iJW3DbASwA626bEGV/hcC7fGtICmrMvQF9y97JI7N5lHdPyvlsL7ytie?=
 =?iso-8859-1?Q?ldTV2krY7KCO8ceF/4skujZzR4X+yM6Fcy0+2cplClRKnt2e3sHIaeu1wG?=
 =?iso-8859-1?Q?FSPoiL3Krq2f+zSwgY1GPgctdlL2yQuksgBd2qq0PF2Vq3OCFn7JVVk39y?=
 =?iso-8859-1?Q?my5JApKXNvxxe1+27RHW9my8I2JSOQGqQMPAoauNhI/7jvcWsdfxjq0y0D?=
 =?iso-8859-1?Q?cP5wC0ecE35808Eh60TIdSrGE7e/IfcV/6FUWz4O+MY/v2njwx3oeJIFtG?=
 =?iso-8859-1?Q?o0AWS+LQOqOvJ3v2yyzicTpiI4PhH6bCQGmkkfdiSvF/+ryP0RvvuTpqbe?=
 =?iso-8859-1?Q?5w6L0268WK+Bjn4Juaw7o9tI7oIi6843OXxD+xeNsjTpXlDAPNp7c3B/G8?=
 =?iso-8859-1?Q?ShSjLZfHmODNzTKsjcvVm9SG1k9q+lSyVrEMCNLrpg2Pq0RvGCCjrET7Yc?=
 =?iso-8859-1?Q?mDFG6QueR5qtHJqBCs14aOczfzgEb6J3jookDx5VkCeTeXwuuvkfZnH3QH?=
 =?iso-8859-1?Q?NzgLm3o72T8USk89f5FY3dKKUUGo8EUjC5o/c64OXzaHl02bauIRpj4Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DE9D11AD93873C4F90D583107F2F3275@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?6loYS0ckhKAVFuRBUIgB9otMAPy91T0K2kogEdKri2nTHHGGKXpVWOQREe?=
 =?iso-8859-1?Q?G4JhHVFaQzvjnhxYQJb1nwm17TgZ9fqa9pexoFFLRbGMaSVBB1kIqiMgAe?=
 =?iso-8859-1?Q?YU0ZdPjsvOlZ6CAVRIFgYV3wfO7pRG9KlKpZeYiyNig2Pwv3c42PUdyian?=
 =?iso-8859-1?Q?zFLzlWVKQGUB7AThPlURuIvuT2YicfJRgBb1tuMxPVHlwo3lCX3Ti0/0AS?=
 =?iso-8859-1?Q?2sWWvbl2dKDo0te1rkenjGHR4uYLg/cMsRD/Fkal+KTpP31v3LAN7Ks6Dz?=
 =?iso-8859-1?Q?0LfSxyacJl1LSBv/C46UjRMYGLew0lAq4S/UL4cZJ8zCNy8r+jNuJtYsU8?=
 =?iso-8859-1?Q?B2yXPKLVoz/pHS6+2BEyu2qPQDcTiNOas+DDHqPnutGjK9K8IL8OvRd59t?=
 =?iso-8859-1?Q?BySxGSp5eqjgG2DdqoJP5fU0in8kib2bUaZITCbGZ1EIEg8I4Lp4DRG37w?=
 =?iso-8859-1?Q?u6GEbgIrYViPvnEFCxa/Lq00eMTQ6myOSscU41ALHxKcTW9UL1jzEFiQg2?=
 =?iso-8859-1?Q?lnNU0g+wk5Ov7dbeACN3q45CQIrPCl88suAax2iSJydGj36JO1TxaxFXfd?=
 =?iso-8859-1?Q?QTA8o3TILJi+yVJIetjbOc94opWCMnDGwABeuWxYBkvvspiMVcuR5rZf9b?=
 =?iso-8859-1?Q?osJN8VgGwjZYCPoXYMbgNs+mxSgyfY1bqVkAVa9DcNsqKRu4Df6EOzI1bI?=
 =?iso-8859-1?Q?YsZwLUwXIcIcbtcuzfbsYyfbgFmAg06iRuLFqA/n1z6PTB2tn7vDEaUYBD?=
 =?iso-8859-1?Q?wQwR6dlDiC9DvOdwUg6kgS2L+OFR1QPCGjgoSHrwlOkZ5IHvY2rW5zfuV6?=
 =?iso-8859-1?Q?qd4u2EEDikweTjsE3seSpq/5zIH1mDwN5yP5PdsZHVz/P0gnUca6Yd2hVH?=
 =?iso-8859-1?Q?c3AHWqHQwzfJETUhvJO/KJWrnotsZlVial6lTcf+IqKos2CSgM4deV/uTu?=
 =?iso-8859-1?Q?7cEM9gtirGq9AXFHtzlW66zUgFeLy5RnFxzQaD0166z9Q5Xb3jougkduM3?=
 =?iso-8859-1?Q?fAZmr/KOgP08L3wtZzV3pFT5NG5/8OpN6fqAx8?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a11daa-a8fe-446b-400e-08dbb4748b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 16:14:44.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmselhAnINJn1I/zEp0uY5R/Ob4i+88qIrSf4vAQvlEBmaJzh4aW/V6juwVV5I8tz+D41C1loi1tn+HADTpwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6316
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Keith,

On Wed, Sep 13, 2023 at 08:20:09AM -0700, Keith Busch wrote:
> On Wed, Sep 13, 2023 at 12:25:29PM +0000, Niklas Cassel wrote:
> > > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > > +			timeout =3D max(timeout, NVME_CRTO_CRIMT(crto));
> > > +		else
> > > +			timeout =3D max(timeout, NVME_CRTO_CRWMT(crto));
> >=20
> > I saw the original bug report.
> > But wasn't the problem that these were compared before NVME_CC_CRIME ha=
d
> > been written?
> >
> > i.e. is this max() check still needed for the bug reporter's NVMe drive=
,
> > after NVME_CC_CRIME was been written and CAP has been re-read?
> > (If so, would a quirk be better?)
>=20
> The values reported in CRTO don't change with the CC writes. It's only
> CAP.TO that can change, so we still can't rely on CRTO at any point in
> the sequence for these devices.

Yes, I know that CRTO (which is the new register), doesn't change.
It is supposed to have to values:
CRTO.CRIMT
CRTO.CRWMT

The hack to modify CAP.TO to be in sync with either CRTO.CRIMT or
CRTO.CRWMT is really ugly.

Considering that CRTO.CRIMT and CRTO.CRWMT are also 16-bit,
so wider than CAP.TO, suggests that software should read these
if available, i.e. no need to ever read CAP.TO if
CAP.CRMS.CRWMS is 1 or if CAP.CRMS.CRIMS is 1.

CRTO.CRIMT is allowed to be 0, if CAP.CRMS.CRIMS is 0.
CRTO.CRWMT is not allowed to be 0 if CAP.CRMS.CRWMS is 1.
(and this bit should be set to 1 according to NVMe 2.0).

Additionally, NVMe 2.0b, Figure 35, clearly states register
CRTO as Mandatory for I/O and Admin controllers.


I guess that I just can't understand how a controller can set
bit CAP.CRMS.CRWMS to 1, without setting a value in CRTO.CRWMT.
Is it such a silly spec violation, that they seem to have not
bothered to read what this bit means at all.

Such a controller is so obviously broken that it deserves a quirk.

Although, I understand that using quirks is not always the best
solution for end users...


Kind regards,
Niklas=
