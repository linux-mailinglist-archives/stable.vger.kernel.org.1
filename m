Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D87A2968
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjIOVcX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjIOVbx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 17:31:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A618D
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694813508; x=1726349508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wb5mR4h+Pb4OHt2Zumq7qmjbScl6SZelE8TiKtZZzIk=;
  b=JjLTINU+jJH79nhph/De6LQFLLAd9OPHSGQaKYo0gQzyozdVOekgfOU5
   tfsIFpwrsEUCDh9sPwZHrqPTbXIrzMaNBWF3+huZT3Pncz30HWsJRpXs7
   wsiwA6uPT3k3AKpGb1ha7E5wN5WjXJS2Tsbp4myk17nTFRt32Ub0ZHsis
   Nn41n5keWdy47w25jcTKBNyKBNj/mWXqDnO6kTjW1+I9G+G1ozNVMj+rc
   y9MxzXR2AFEgzmogiVIG2k9cHob2pf6VtMPJXF+tJwX0rdkxavXrGdjyX
   jJVAPR5IcupPQ56XjrVfTSIqd5d03hZCwtzIDhJR+8n+EQH0HXlXixgWt
   g==;
X-CSE-ConnectionGUID: UVYA0Gz9Q22OFh7Z5HzEmg==
X-CSE-MsgGUID: x1nVhUkoQKenYS8wwzh3kA==
X-IronPort-AV: E=Sophos;i="6.02,150,1688400000"; 
   d="scan'208";a="244097042"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2023 05:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDsAye8IrKPJyPuJ7DgCIMjf6oczQo4GQhmk45hquPvTnanLDUeYgdbW0LW04nEeDl/Wd+D1m3BzuMdHhMY4Fe+LKMAXj46AGXJwa3lTJxelb3M+Kb7vOsbk7Jf4C3HBIW+d+AmapEKLinf7MOkzGSayHiZEs9n8iAgIcGW91ARnZgPldZZjQfSWZZIvGaAMNgNnWcBPexttlLYzwanjn/TgaGJYAy7iyj/+A9r7RmkFurUpjZe1Hcx2q6RUF8xdjNTbdl8w6ZwJkR0ha7m3xpt/2Wb7FY7OrV9wDZQmKY6UxF7LPBF0fvvDsSzqjlFcZxEmVTUgQv7gsw5CvR+hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb5mR4h+Pb4OHt2Zumq7qmjbScl6SZelE8TiKtZZzIk=;
 b=XDOPm1zuk7P6qWZ0+5joPHqtJkakGd1MYDqKQ2x5xhdcT6s0fkMYHs2gEZ3WJYNJL01T5ZlfJxUFjv/Inrw8n3quGQQZ5IMhZHTLPir4VhkmNO+kCSUSUvoJXweFXkWUMB4yHpUNcr3vnb+HUsUhRY3acESat4Ylc9KBpuVz1dgKno071oBSvLlOrBDf9DAIV8D3Bm860ZcXvve/fnaG8ErYGQ8kFUSgKJ5uzFxKJKap4Sj+LU1Sd5KyYeFnNevicfXgKihy+8cqB7D3VZXdeTO4kDqjSkjrFfi0lNIuVrt2q0Ep2Wd451aWtWFQaPaNpVSwz1nMjoZMoslffAsClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb5mR4h+Pb4OHt2Zumq7qmjbScl6SZelE8TiKtZZzIk=;
 b=XLt7arypLygQyAqcenO4VDt3903iYyI06zhWZivUI/UDbuYwZZkPOM8FCpZjj6SXFLV6lgBGWZTY6uxsD29MaWqprqejoIC0lZeCGbvMA6i/S/Rzx9FZUQhhUrh71dPVI8xFUh93pB56B7Ltcl7HQSGbECyOEby7jG0m1wDHqSM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6463.namprd04.prod.outlook.com (2603:10b6:208:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 21:31:44 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Fri, 15 Sep 2023
 21:31:44 +0000
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
Thread-Index: AQHZ5j1hsYCwaiF7S0KQOilyaTtJJ7AY3xWAgAAPPYCAAAjJAIADdHSA
Date:   Fri, 15 Sep 2023 21:31:44 +0000
Message-ID: <ZQTNP5lnFFn8ThkZ@x1-carbon>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
 <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
 <ZQHf8Yyw+UC9ysDR@x1-carbon>
 <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZQHnUMlm80Xzxn6n@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6463:EE_
x-ms-office365-filtering-correlation-id: 8b42d63a-7d9c-4bf0-7156-08dbb63328af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTaSkgpaCAsNkSw4UVkGsH4dfykGAgZSH7DSmC4K0JwQkyVT30bROpxIYwzbU4MU8T4jdlSIE9v3/tlgUJOu8vDgprPT5j59Ke8tzE90XfCa1XlWOZYNvzHW6Genwow6c5KzUcFjkOaKQr3YUeJ/yL4jTNMH1/SZVjzl0nhmglSvuSEjsP7vdUOijLwsNzR7YCumVs5cfqjkpqo58xO9YqoqfaWDyhhO45glQXTF4oPo6y2OV3slCWRrDNvdqB/kh8w5/2Pog1tU051Hte5ry/j6nwLtK6t9ZIKthAS1yKAoZqIFlWWXg3s2czl0MyXmOd5EYdlL1GunD4WjjIe6+E4duFKMPqL6mUWD42W8pamtJgx1OTIpdYZr9qAFMudtdCHnebbIT62zyWLN1hf0muVWk+tDnqLsQ8GFck4she47wMgizpiFPjM58/p0cm6tMn7dP4Rja5+TfTiDbuybG5Q67OCkkgjdgrdARBpvt6fYLNJJInJJ5PQS3pUp8X67tm03/eEb/gkYurtQFiJq3s6tZFpY+IWBagTU/J9Ek0lBmfJFUZSgZSjtm9EZu3q4La67a0ugDAJIwd65wnqoebzvtOvDryDvYqGVbTNc6z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799009)(186009)(451199024)(5660300002)(33716001)(6916009)(66446008)(66476007)(66556008)(64756008)(316002)(66946007)(91956017)(76116006)(26005)(478600001)(71200400001)(9686003)(6512007)(6506007)(6486002)(82960400001)(38070700005)(122000001)(86362001)(38100700002)(54906003)(2906002)(4326008)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IcAsNe60BSI5NoN2I1fSM9+ySlT0laSEcaDbJ5NW5y3dPI6UxMlYpLUt6y?=
 =?iso-8859-1?Q?eRgwbT6+hJfFc5h3AXCEKenvGIsfh04GbaGcSBW/89g+MjFu8FyvyEnFGV?=
 =?iso-8859-1?Q?GWNi1RLM0O9ebjkl3QapqtFBvG3BF5813fr1v5etq7b0CDtWjf/f00WKK1?=
 =?iso-8859-1?Q?Qt3ngI926URfMkk90HS0HHZ7sitKp+otKljRDZ4czrA3K7wQCDJatZaOhw?=
 =?iso-8859-1?Q?yfnVOc3V1rZfcJSAmTumE67ZQGMYRdNAqqeUFh5BuA83LW0uPWU5h20SRG?=
 =?iso-8859-1?Q?tTB12+gtwhjbmRTsVJjwcP5SI7F6xgtiM1p072whWxuzg8SJ33g1O7zOsU?=
 =?iso-8859-1?Q?qnoutGN1pHO/dvw1bHe38lrmxRnJrZW+ETBFq/bOGcaIAzIRa3eavTm4bc?=
 =?iso-8859-1?Q?wlID8nLhLW8jsaP+Vac50v3hhQDutomTdxPxXO1dK1t3Ojwn3hEWExnJoA?=
 =?iso-8859-1?Q?BG9humPZQUlP/AUfx6hv3Aa3x1kMkoDewz9/NoYd59DfzoJXXCcbn+4zNU?=
 =?iso-8859-1?Q?dPBaCD2R8Qi2JgE+6SU6vu/NeXhbYqBaVmcZGZNfsiyHmiC1bKrd8infx/?=
 =?iso-8859-1?Q?RHlS+gHcldqPzq+OqtQw6StP86hcin3Keu+L9kjaV8GUQ4dNRjFif7/3N3?=
 =?iso-8859-1?Q?hB+VKiWtJRv3PWWzK0gae1AbzRPbj+LpZteRZ7mZApeq6Ni+Rzr3dMpk6X?=
 =?iso-8859-1?Q?/bcu2ek5MxCoSfUceShggs+nVFvnqle9yqkVF6DWi9Ek3xAbuysrp8qlVB?=
 =?iso-8859-1?Q?yOaOjokbdePGeaZg7ssHqTv8YcGb9mXs0RK4eFK3Of/07ISbWaNyyf9mbR?=
 =?iso-8859-1?Q?XzHCOsL/nkCSCmNJuoPoSISl9NKejiZhkeTca6DIP8aYJdpjfCbJhh9/fZ?=
 =?iso-8859-1?Q?iSUzlEdELoXtHiNcUGP9v+3PbSRPyzwkjFhiS3nNTBXvLmXJpXJm4F9mYJ?=
 =?iso-8859-1?Q?pinIfe1n7iB+rZ/yrd9Tj/6A7bdz3LSn9FAIIvu9vmrKBtpTCokSp3heJ9?=
 =?iso-8859-1?Q?pt1XK5BsT58kTkiBfBmzwH/1+L+db7GehA9MTa7zWrPZqfRfSXyTdHkR6L?=
 =?iso-8859-1?Q?cP+xDYSCUnC/jOMuLqVXF0FlfwIl5+9GQ4yjk2T2HddI+M+GNBABwFQPT5?=
 =?iso-8859-1?Q?elfvZkuNyVarI6cNatLSC+kET2WyfLxpNtGuyvOtdzvNuDoANS4DaMf2Hk?=
 =?iso-8859-1?Q?3sCoAW4JaqmDs7Pjqm4SJocOi52bOq4fFQr5bDL50sdX8glWHV5B4Jy0Dg?=
 =?iso-8859-1?Q?MmVyITg2/YOItr7qx34GcS/fbf9zfyfIldz/sNr2LAjwohNEeMCbzNvaDr?=
 =?iso-8859-1?Q?Gc1AyumQ1a6zoqplDATi81HcsYkZCj6MP53nJhA3ydUkckD1ikp6vYz3FR?=
 =?iso-8859-1?Q?YgTCB5E+mbYpVgj6mow6+njbHj7yvRtG91bassRBTqwxb3nNSokx/Os1oB?=
 =?iso-8859-1?Q?A6WNSbu3tfd0C25d7MPQsn2QCm7Wn1jptSWgck2o/KuhEc1Xpo1fZ730Ty?=
 =?iso-8859-1?Q?d5HLNhSpbhS1BS5uRCkNKl/JZuXXCGHNMZI2jVl+iRwqk5DZCzG246x8ht?=
 =?iso-8859-1?Q?wSRmtQN4xybfkiT/QEHKmti7wlvzGhgj8nehTgJJUd+0GSb0tqxnWANfxY?=
 =?iso-8859-1?Q?ENJzmqDbvvvJ8PFw6gQJYQhWQbGOhFOSjcPYYNrYPs5jaYsBTlgQEv6A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B65362399F30FC47A8FB80AC912F4C52@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?rmH1uvch/bbC35S613OIziFJMX7Y704fO0n6FlmCX4bDO2uDmrJBixQMFo?=
 =?iso-8859-1?Q?LlXJuk5ZwSXL8TgG+rATsgwiFmRoNCSERbeh2o3dhQxvL7K41mCEh5iFKd?=
 =?iso-8859-1?Q?QNVybTW19LRZO7j+A3hM88ZnW5ig2OHC8ZCp0BeBnUZn/RVO5JcMx+O1Of?=
 =?iso-8859-1?Q?0IDfatJbpIF1zvjZRY4x7nQ6CwU9Zovf9qX4i9WBLL4FgdZmnYvvYyrpaZ?=
 =?iso-8859-1?Q?9n5UNqMA7MkE8cMhXDk1aVE8E8oFqjacFWe4oQMCQX3cBFuGOxxmOtiEzN?=
 =?iso-8859-1?Q?paA+/buwyz80VSeSeIj7H9VqN9WfTaWB7BieBkHVONQ6oqoaFvkWn+OSK5?=
 =?iso-8859-1?Q?LVYDadvJ5JkHwCnG05Qm3brvBH3IeKSkwQ7ESiQVc/yL/hsV5MS70x/78u?=
 =?iso-8859-1?Q?YwRmEaJ3Zr3wqgCUcadB4KxeXhgRZbDBRwLqupaWQFTrPe3HHykXF9MKxd?=
 =?iso-8859-1?Q?AehKXfSpwUBlgeiZquXBzXkMPXtC+Y29sx8jbVgtcgumF4KQuGbStHuLaF?=
 =?iso-8859-1?Q?sa1Z4fNVv3r3LKFiVxLscXCsLPnFUcObDr27Of+/0mCr2vHfQRBNmuNYVn?=
 =?iso-8859-1?Q?HCmOuZOJeptJV/CHQCLxlgfK02GRn84DJanpJB2LWM354pulK3TUrWhTX6?=
 =?iso-8859-1?Q?tbLHsTyJOhdKvnEBQsOOldZW2myaXtTMX8fCD1ZxMCEjrBJE8J0U4H9rXL?=
 =?iso-8859-1?Q?hh80+QtDBJsFdszFAbct/2r4SUlLwU+3ixND+37zHVXv9pfOcVpgouOlwO?=
 =?iso-8859-1?Q?CMrR1zgI5K8eo6OeEBsvGPW96yF8k6lOCgtB/mRBYfxDIvPAFNyVxQkiRo?=
 =?iso-8859-1?Q?coAbr7Q3uAgmr+WHdBMDNLG6AlEGlcFuHDppjVmhhWRlrWLyBHZTzeQIwe?=
 =?iso-8859-1?Q?vLBowTkfImgJNTD7IXsYwRuTGO94YDP6gUQze3jMwfXcdTOwBDNibEH3kH?=
 =?iso-8859-1?Q?BiLvO4eMoInGg6J9BsFHakTw/s0g+diNcTyqDiCzlf6Ow137ogSkPJ6ynV?=
 =?iso-8859-1?Q?FLK/z46WWBsLHZlNMpsxo2+RL4nRX2DEs6dKYb?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42d63a-7d9c-4bf0-7156-08dbb63328af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 21:31:44.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7GEr0IGhbtk7M5Pc0z3fNz0SQvOddBfqF2lJHtSm5vP7JwC9DdiMwME+q4pTsjo4/1esmvfgTcyEXu7pHNdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 09:46:08AM -0700, Keith Busch wrote:
> =20
> > I guess that I just can't understand how a controller can set
> > bit CAP.CRMS.CRWMS to 1, without setting a value in CRTO.CRWMT.
> > Is it such a silly spec violation, that they seem to have not
> > bothered to read what this bit means at all.
>=20
> Yep, but broken controllers are broken. They used to work in Linux
> before the driver started preferring the recommended CRTO, so we gotta
> fix 'em.

I'm not saying that these controllers shouldn't work with Linux.
However, these controller used to work with CC.CRIME =3D=3D 0, so perhaps
we should continue to use them that way?


My reasoning is that if the controller did not even manage to get the
most fundamental part of this new feature correctly (i.e. defining the
actual timeout values for this feature), then perhaps we shouldn't
assume that the rest of the feature, setting the NRDY bit, sending the
AER, etc., is implemented correctly either.

When CC.CRIME =3D=3D 1, both fields in CRTO actually have a defined meaning=
:
CRTO.CRIMT is the maximum time that host software should wait for the
controller to become ready.
CRTO.CRWMT is the maximum time that host software should wait for all
attached namespaces to become ready.

So having both fields defined to zero, or rather, to have both fields
defined to a value smaller than CAP.TO, regardless of CC.CRIME value,
is quite bad.

So perhaps it is better to keep CC.CRIME =3D=3D 0 for such controllers.


> If we have a way to sanity check for spec non-compliance, I would prefer
> doing that generically rather than quirk specific devices.

It's not going to be beautiful, but one way could be to:
-check CAP.CRMS.CRIMS, if it is set to 1:
-write CC.CRIME =3D=3D 1,
-re-read CAP register, since it can change depending on CC.CRIME (urgh)
-check if CRTO.CRIMT is less than CAP.TO, if so:
-write CC.CRIME =3D=3D 0 (disable the feature since it is obviously broken)
-re-read CAP register, since it can change depending on CC.CRIME (urgh)


For the record, I'm obviously happy with whatever decision you make,
I'm just giving my two cents...


Kind regards,
Niklas=
