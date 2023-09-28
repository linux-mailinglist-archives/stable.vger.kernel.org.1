Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22427B21C3
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI1Pvb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjI1Pva (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 11:51:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5EFD6
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695916289; x=1727452289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=er1m9ZQMBJYchdzNByidE6FD7+IvhKMvTShczI0Sr1E=;
  b=rSjlxK3p826bVE47+Zc9RAA20bSfyImdzb2Fehf9dgZ6lMGGofjlvSF1
   7iXu7fA6cC1xO3/UgbApcGs8Lp4x5XFdEdmbnkTVCKzujYRDIDVQ3rltl
   DC+i2QdlLcKaI/gZ+p3iDE4N6MKZmx+dReXXKyYy1WQgx8BxLqU4Jo4q8
   6ovklsCRoU4ouM2y+8hiEH4HPkpffJ0c1GXB+nnBIqqDkFWbVzXVRClvn
   VR84R7+KL7gQekE1CHBX6V6lJt0X+kr1UZsh0obQLt743QWfcgrVpAhf3
   xbBMQqrpWxELSV8xp7Wrg8DCJWjdgSq8KnXYaN9kcJXjyjolFBEWMl70T
   Q==;
X-CSE-ConnectionGUID: dBIxrm06QfWTtiYE2aIaBw==
X-CSE-MsgGUID: TFuH9IotS52KZzpCaV5L3w==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="245195157"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2023 23:46:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odLWmKIi2rfRQhdQPhZHHgV434+h7kfhWOi//NJcKyEyw2YxZN593RQXmhOhtqSMrVWPnYl8pqR18TO+j20lTEU4YaHBYylKqPRiKWGEY2tieiSa5pTczBoca9oOVhz7L9yFN4CsyAxR7fTkJIAYNuQSp7oo4BA2X5XCMe0I/QPXKNoXsUHLxOGq1NJ41TICzP8aEBlEiXvj6XzwFa/JLE118nQDIcJuRn+HPEdFG1NEBxltrUm0bVSswe8umMzBiKUzLNKDMd/nl7ks+PxECBQXmWufdzz5BWQLRumvPLgynutMY3Fe2E6e53PGh/DO/uvC+kFK9ETCEVmq0nksng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er1m9ZQMBJYchdzNByidE6FD7+IvhKMvTShczI0Sr1E=;
 b=jb1R/0bGtL3ah/LjgaRydokl+ickv1siyeQJyBlFwpCtR1u7q21ToZ//xOv+fPjl0BXPIsEzgc+w7cFiqHV6nAEP3aKSeZ2ITwjOyvkDGkPBKsE2bbFpTQrnDOiT/i6S0lRyzb484hTrlvgRMvc3uetpd8LfQs+rvymMakMRX84K+WKutZwsQwyQSltdkLX7EYakyBARU0fB/UaOYUlWTBZJmOOqBlF+W4oldnzgAko464U0t4zBX4mu6If0uEBmFzsF06WMwdxi7tSzm2Agy4jRTPwVE0QcPFQkrh12hoQXudUvADZppKpqN9X3IlXJqWD51Zc8Lek+EiOGXJtsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er1m9ZQMBJYchdzNByidE6FD7+IvhKMvTShczI0Sr1E=;
 b=Xx3rI5Z3QgQpaY4l/wyDXBy4mtJzEPWv31cDGoK8LI+Vij1X1fPVERQVornARxdN/U2sNRi0OEBsdYpX4mP0WtAPgCzFa+EaoL1kwd2J3m1mnQbV+lIqrHjW7xlY/piCYtLImC6OJB67c5xdTWR1aaBBPwApH7Lq2GISZIQG0HQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MW6PR04MB8819.namprd04.prod.outlook.com (2603:10b6:303:23b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18; Thu, 28 Sep
 2023 15:46:56 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 15:46:54 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] ata: libahci: clear pending interrupt
 status" failed to apply to 4.14-stable tree
Thread-Topic: FAILED: patch "[PATCH] ata: libahci: clear pending interrupt
 status" failed to apply to 4.14-stable tree
Thread-Index: AQHZ66jhy3WdMfARFUqFIXcRox4XcbAjm+eAgAzSxwA=
Date:   Thu, 28 Sep 2023 15:46:54 +0000
Message-ID: <ZRWf7Avtdv3DeqCU@x1-carbon>
References: <2023092019-aptitude-device-3909@gregkh>
 <ZQreIV2lk0OKSuju@x1-carbon>
In-Reply-To: <ZQreIV2lk0OKSuju@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MW6PR04MB8819:EE_
x-ms-office365-filtering-correlation-id: 24bf885f-8d02-4eae-2ab1-08dbc03a23ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pf5C4pHsZcAni6rgKvMcLLeO0bstSoWLiJOYOvzi8AfEnfFTvYx0V8RfzffaWAhmEkUBsvjgKdzK4BHp6N+lDryixyv5L+MnKmHV7xyScvyVE8ynZ38A+IzG1F3XhLawohriO2Mfbh+qm4O02cVqP/aG2IXKVirCTFueBCZLyxlGLYSk6RUCwvvOFxWsJwV7sNTXMbt7kFPSqiQfv0l9Dg2wZ/VPToP9yk/SaIhn5YQdj9ajL/7O9YpQ6CXoQtg95VXVnA8LBTw0b0IxTsBI2LWiPh//yRWV7V0hjKOeDuHmUdZmHcltw7qO4czLBEB9RNy0+ashGUPnSSpHD62OwuDaY6ooQUVQM4xDwkVXVe9onPEi6Yzl4ZQ5UucGW4EFi1qJlVhNa8aTw05/+dXQlQDtHceUf7GHD9eHkpoZ7Ja+MnRmpBPwzuS7mOxJ5/MKbyjZVG8eFOQYDJXj/mM6YVOdPuBiRusVbdh+HKZCMZ6Ab1TQ9MmRlpCFm1NJGYeauWNSnOSVzEgC9eIqNpcUdfPsSbuw5o4ByDe4t08blHDcfjtQ8rbMXO+eG8aCewxcI/Kcazzx/VMIuqpBzmFuStsGpblTy2BXrUbXzc9gKtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(71200400001)(478600001)(33716001)(82960400001)(26005)(122000001)(86362001)(5660300002)(38100700002)(38070700005)(6506007)(6486002)(9686003)(54906003)(91956017)(66946007)(64756008)(6512007)(66476007)(6916009)(66446008)(316002)(76116006)(66556008)(4326008)(8936002)(8676002)(2906002)(966005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wW5YuDh6JiAQsKlrEF3N5hqp+Jvs1AirTCkznvFhsZ9A5xdtJeLUP1pIvFvS?=
 =?us-ascii?Q?jwaKS6zM9KbaiumRqRyDXLBJ9+lWHPQ8UoNSTaNq7xr3DRiqqM9hrKjCCZw3?=
 =?us-ascii?Q?cwrNnYAEoHr7ld/SlTslXZ8tkZ6OfqkRYubbho8WhpfSvg33sEqSJAkW/JMz?=
 =?us-ascii?Q?HqHm+J3eRpJxSTek0xYd5uUnvm+bzgaRR9GoHYPTfTFHvU2dLJSo7V3fieyz?=
 =?us-ascii?Q?+dRd0Nvx4LTaDzZXOmgVeZWfeC9WHf+LRVWzxzzmygAT4STFYw6j8frNY2M1?=
 =?us-ascii?Q?vEwINPj04bUaw1NR2C7NswUG0wjYOBTx4buyg23SRmliz+GIjzvLIx/uIjSp?=
 =?us-ascii?Q?Dtvbk1oAjT+TNaZ2eOykM9yzujvd3TTLEEzhYkxawPB7FlDkSIXUxFF43X0Q?=
 =?us-ascii?Q?jbVaCCvB6kx6gFc8b9R/LXMSvMw6NH67CLZvWtEcJ83kiKJsMnobyGbIXd2n?=
 =?us-ascii?Q?ZcyhO6n2Ma6kmiasCB4Ns+AQyz7LFdH6GJ1EhyjtZU9LnlaHeP8hObJQoTNb?=
 =?us-ascii?Q?4eMAjbZLeUpftpz4+PsvdoQfET5B2b3oqdMXfIVPuhIw3wGBIFvEMLIeg4SO?=
 =?us-ascii?Q?n++hbWIOzFoT2T6UkArQARvZnSArPwrR+qUlJp/Wy5/tEOt7bvHNbEjiIsl7?=
 =?us-ascii?Q?ImAE2NiuPnpxUx6mA8yeQrxH3fOc35nXdkhkLHrRtAyj7De8KC/vJ4OWsCEv?=
 =?us-ascii?Q?QHBtPEhMtUctcIcHzPERgJ3JnNWG1bBOAyajbXzsqpStS0xy+dNcpzKCvEwO?=
 =?us-ascii?Q?UF25OdrQo5cfuKi/Geg5kUGSfPqnsgby+zEB9Zx8lbrxvFemllQe15iMYcTP?=
 =?us-ascii?Q?+ORMGudgdNLaOp+GfRDNw/tcMJRc0xEtVbF9y590HajbR7n1yOxxy7X+8/pw?=
 =?us-ascii?Q?muf756pGjw0z1hmwo3USQ9vdkvmEcACG9zWPiBPfWCkbJQNwrLnUnlK+01Ai?=
 =?us-ascii?Q?CrPY7o+T9n1MXJnaz2HX3UBJhBnK3JQP5A8Q1MMRFg7CSOnX+xG3/SNrkGTC?=
 =?us-ascii?Q?3IhrEgWqFiw3UTHr61Y8t27+mGiNa2bX7ZnzEPNeyjVm2l5rNrVJuLtfIFjg?=
 =?us-ascii?Q?wP4NjDycQRpv3VwCiYCGKqGWiSKzAWJvFe6A7m4ydiHXLBWhaQCSYD0T5VCS?=
 =?us-ascii?Q?I0kwMDiXJBUaA2+m6uP2A6dz2Rrg09mahP6TCrSkVAhQmgwBAPVRcHH98EPd?=
 =?us-ascii?Q?U+249U2wwX3XCDgIefAybJfrg2uUGL3BJsaUc4Ki9pIH6uC4j0iBHMRmpNmi?=
 =?us-ascii?Q?ojx01tQlPGX9BINlFXj+tv1n9AbUx/wdjegtgl20/ArvZPgGPiPpCS2r/1Fg?=
 =?us-ascii?Q?sCd1HpJkltvKHWSm86RTsGZKZgq++ClFjZXOIB+IqPyqKp5+PZDOINLlC6Yj?=
 =?us-ascii?Q?3jHYjlGeYpx8FRgPaiv5NJ92J3OdtfDNdupaPC4R6mpjV1Hgc9bDMpe04sbH?=
 =?us-ascii?Q?3fEo5dZR3AnGT8QaEdm4EB3l9oaGaG0/nFbafgVrPGGofbG3osjTwZId69id?=
 =?us-ascii?Q?yKdaHzxZKZVh+5JiEqemnymqEBbsnshnZqzdJfp/SZNOmiluFwvPfk4Lj3Qg?=
 =?us-ascii?Q?OTz8zpwMWKBE5xK6hfUUM9+DV/OMU+N/4V+fSriq42s9dMdElHxln6Rlnf1u?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0B95B3EB7806842AC27E41907DF6E61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3XDktKMYHa7cy3ySyzns1Pfna8d5sUoiHA9tqDiewGrIo7oAR3Lc1LawyXTs6iN2Nm51rO7iowdOtPebfeQyWCi8BC8KxvxXrP1UqxDBSmJPZe4NipT5yJ4dqEJMWiufHoUvnUrV78egT4kEIEn4DXenmGyCD5+Sqtwx1XEu7D4eC9j8NV2TqKOYhjsSwTPw6Y0vF6PmhkLVekGjIFC7i5jeR2SCaWHf4pxsCijyYiozAsfRpfIFraOfgfuTqTSLJJHfu53y8vXoM0LKAbKX0d3Ocklyc16gb1NQ0/6WL5oE4e66AT7a72ecDT0LdZoBwbmS2Ito+65PFFf7EaKezUq9wN5JYJa2Gou/PjFeI/FNPVUv8bxwPcFlJBqBJJS7xGc29dh1K6H4mRhc1vF1MGV+DzfOO5fDw/XEl0iAQYalBA6olek5ym34qNlszmNTn7W//6T319UWYqZ0wdZKBIFxG0RGOk0EzhA9PbZUAb7AbJwvKQf8jWYIynMV7h2r0V8LwLu0wksM5hWj1oeuXIRHM3WtuxXWcb/+/8cGTfAWt75cOTRRwDX2esVovulPE0MLucSnoriEDwKlCKZl7EEnpWfklkG3+YksjULZbPSIK8jwokprsuAtR8d1eNFqhN7KVPk0OPk4Gxn+xS4OYTZeHPj0t9L1k4cn2sJTaVyGL8Gjn0/wHBEPH6bnAB4yfn6029p/pc7FfKunTJWQ07jLVwJ2sqbOWl2eIw7dPDzP/6JIDVinArmHNiMidRIo/K35ggoheQsAOmraAJ8ClY8YmkCoRNeKEd0JkmKjKoGm2wZLTuHsz5pJvMmYAzyCBZRBduo7qiS0EeOCr2ouelMX8W0tRa3lw1c3N4wSTdc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bf885f-8d02-4eae-2ab1-08dbc03a23ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 15:46:54.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ec+wwYz2541R4HoZ/YXp1Lr9G1DZOOTzx9e6LaU5PAOIxbtiYPwDysZWrdsbtj6euoEN3HK0NM5j5fFbKVJc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 11:57:25AM +0000, Niklas Cassel wrote:
> On Wed, Sep 20, 2023 at 11:57:19AM +0200, gregkh@linuxfoundation.org wrot=
e:
> >=20
> > The patch below does not apply to the 4.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >=20
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >=20
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-4.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 737dd811a3dbfd7edd4ad2ba5152e93d99074f83
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202309201=
9-aptitude-device-3909@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..
> >=20
> > Possible dependencies:
> >=20
> > 737dd811a3db ("ata: libahci: clear pending interrupt status")
> > 93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert th=
e remaining ones")
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Hello Greg,
>=20
> Seeing that this fix failed to be backported to 4.14, 4.19, 5.4, 5.10 and=
 5.15,
> simply because of a single pointless VPRINTK() call,
> may I suggest that we cherry-pick this very small dependency commit:
>=20
> 93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert the =
remaining ones")
> for all the stable kernels listed above.
>=20
> After that, the original git commit can be cherry-picked to all stable ke=
rnels
> listed above without conflicts.

Hello Greg,

Any comments on this?


Kind regards,
Niklas=
