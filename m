Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E177CA41D
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjJPJ2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPJ23 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:28:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2A4AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7nfVooRIqnHQso6onG3rXnKn3iuRUS7yeO7nCwgzdgDioJwOxL4x0P4zj62yV1ag/fpqNV0pHd2YfFu7vgnKKwSZTbmg/POZL0B7BvVT2i+MqlwP5rtq0D+0dVpV4F14/OLx0pAQp3xiVUF94fP6ZKpZsUq0ZdEXpUGvAXoDSp9z/TDNj19v5LnuWTq/9qlSy2rT1D+Ld2BFNXyjwgblIKQCvggh74DKpAGIK1IrSrinV/IkSDNXbrAwA1vKpeB1+BjQcz2BbSQ+v5gLda6UQNOKRfF+LEG9bGxCgXmjxn9A+0iDIFO+2VH9vOWCvAhc1NlGmOQ0pUFnWNxYddyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRxdyc+mgISYUAYpLzschReorVQTiymcp1oYU1qv3YA=;
 b=BF3JixEk77ZYBvwf3Lj0lRCdDT5PceYpIueRJlfrOVIH2uVozu2z9G6K1cgiyjiBjWpHbNUzh01A2TX7yLLLvtsHqENN+ugqpnR64hWQhKs0iwdupxqocGYJNn4kUCxmbfwK5WO0g87dOCaXBOy2Csza0Ucu8oFB/KEHicU3F0JsWlKPYyl5LZEVF79WWgPMfFylsBjUoYuG/BEPMGGtEGIfgGOiqhVnVTLmgjaPd5scc2uIIL90nTrEi1o5/VbD0ycqROD++Of5W0KwrE/noiOJ4sXw6bXiC5XqYnBp0s7B5NCup9HwJfo1atbn0Xi5DqyPwe0KfP0Axoej0BRhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRxdyc+mgISYUAYpLzschReorVQTiymcp1oYU1qv3YA=;
 b=YTzrWtyhHv0UTHXeHklmTuDzV7E7O6Q6g9r55VbWHh/9K+vgyUMrpu8ce18W5+1bwIihnbz/UQHaTY3ooSQJMLXDAVdE0Flmr1FnWEjNSQCb5jXkuhdNgcxoOG2s65t1FOm7PIoct+RCtOp9Jq4WVjWpR9IUJ2o+Vfm8186FP+o=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB5890.jpnprd01.prod.outlook.com
 (2603:1096:604:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 09:28:24 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 09:28:24 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: RE: backport a patch of ravb for v5.10 and v5.4
Thread-Topic: backport a patch of ravb for v5.10 and v5.4
Thread-Index: Adn/2cQgEdmlpKFOSjuBOB6BJ3HKHAAK2VCAAANvVjA=
Date:   Mon, 16 Oct 2023 09:28:24 +0000
Message-ID: <TYBPR01MB5341F28625702C2BE8A1859BD8D7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <TYBPR01MB53411662F810BAA815FAF968D8D7A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <2023101647-repossess-humbling-54c3@gregkh>
In-Reply-To: <2023101647-repossess-humbling-54c3@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS0PR01MB5890:EE_
x-ms-office365-filtering-correlation-id: 02544888-0608-464b-d495-08dbce2a3f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66cOrNnF453lEiuMVOYCWlpLYu56FN0/67eI+i/auboPlX1RN2h1abNptb8c9Mhe/5A5Z2pBA5VE3RvIrKDOk2jGwNrE5tYq0K/WzpppkkTUNDxomJx8kfi5ak1Y04gUKF9bZ+3M3tzqjZQvnPVhmZ0tO4mZ+oAn1NDHWxCSfq0LGWz8K4eF3F/EJMnU0thaZKPXcJSwuGDfp7QkMJKFeJ/8t76XQufw3h3yBMeVvzOSD+oUeu3amAR98uQXGiahZAniMwgt4877Ls+/33HGB8Xz4LNOJc2bzTDfj79PVDMJcOd9EFXJi1fc+RGD5jANq5t65aXoio1k5ZXylpddG3xoYC1Dm/2h/JBCHp1pTMfpsV4NBSVa8PntoIiZp1IhBzoLGY8+xJVqIWEQjx88EB+ztJKmsfI8AqYe8cQ19MJf2SqIPyzGeD7WufY91DpTlcnw4Mp2s5c+/3tR1VP4e2JRvtojacTv8HzvOqFnfoM+SIqHZqPXDxZR4+j4Gv2D5X4+lvSrvgRYbvsBM9EXI9QX8zhwUv8yCzwd5LEM5zi0CMYE+s8akKiEI6gRDaWYrP2Zg7ZKrsXLQQuTmhqzSEW6QTWSK0kUnhRwOm8wwN4dhJQpoBB+Dr5NUs0PpO9N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(71200400001)(5660300002)(41300700001)(52536014)(8936002)(4326008)(8676002)(6916009)(316002)(66946007)(76116006)(55016003)(478600001)(6506007)(7696005)(83380400001)(64756008)(66446008)(66556008)(54906003)(66476007)(38070700005)(33656002)(86362001)(38100700002)(9686003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TgQ3GTmIQw6oOWdpRggJ81qjk9KTnkhllZ9kKRwtdeueyRyUz702CBVhRxbH?=
 =?us-ascii?Q?3h32ckc4TQt00JqGT9MH/OhxNECoafkqqr2ya+OdMVDPjTwndUe/mZrmLB98?=
 =?us-ascii?Q?mtw95rBWocACpIhRKjfXHPltJBj1UHOHO9++bBqVH0AZiKP5STA7v7m9nCIk?=
 =?us-ascii?Q?odERffzJm3q9WZbVNoFeaAo95uJSCn9kLfSywqlDcHzxD6CyPCz5myAIlDad?=
 =?us-ascii?Q?i3AGmdKPBUHFx86n/hqNOAdyzYWSkuF40ijKuahQ2c1B9dv2ri51WinKx04H?=
 =?us-ascii?Q?OGWMbj58BvjAkIm5Avk8Jt2hEFHk2iATNb9War6QWNu06MZFPK/FGP2thWiB?=
 =?us-ascii?Q?EqW9qClRweamlRD+bvVdf2sG6ZXeyiW/cZ9nFy0a2UOBgV+jI4/IPL/8YcIO?=
 =?us-ascii?Q?jPr7a14pvG9ol7xKY4BxYZ7A5kr5xNygYVrw+P1Y2UebCJ1Fq6DsiWrVfG8C?=
 =?us-ascii?Q?r5Br2KsXCBPV/czHHb+J58dJ+7THBP41UVN0AFuOjXrvI4MF/5jA3+mLE/dn?=
 =?us-ascii?Q?wZS/DgrDpA0X2L9SKu4+K3mFrqlXPdkFzBE20fyDANA6EzhZDSwcIVXfHMGh?=
 =?us-ascii?Q?n/H/0YTO/Tk+5Frq19Xa/Qgkt/km5YEKEx+935Oqy+VLyRyCSi/up874++kp?=
 =?us-ascii?Q?ZBKhkh0731T+tcnSu8uQUasrIUkcMP37gyxX5GRUSBnc+JKwiWm/x3nd9DoT?=
 =?us-ascii?Q?OFGIx2a1tw2Vjj+dwbsWUyybbd3p/8/zV1qVoqoENJA9bBsQw49a9cE2XzPh?=
 =?us-ascii?Q?cOrCEfKTtjTDPv+m+7QXmFP6bDzWAyW5Ja7cidXVuH+gRCJnBZXb7pIsYits?=
 =?us-ascii?Q?nVhtSBTv8+6OpNUV02tlBwgli/NWc72ILTZ4rpBLanLdtd8IMxWPl1JNaeQE?=
 =?us-ascii?Q?9Dfncr1Stlrr8jFt/DogJ1FrKj9tpH4qq9e7+6QbcsYa+m5TTXT9ignlXwxU?=
 =?us-ascii?Q?yVL2KwkYu8jgJCVz2MxcRw5E2XgRNZg6B9RXEBljWdLibNXD6bziWhCh5oEz?=
 =?us-ascii?Q?/xn9sdLFWMb11Z9h8dwbxP5anJ17L9nEJ58WFUDfzmmhCU8xZXXtkDTlenQr?=
 =?us-ascii?Q?prepudAH35/6infGtStcXhH1kz3ynGcfLJ1p0jR1r2d5P6MviJ2VcGswpOuw?=
 =?us-ascii?Q?P6ehQnyzedvqywhDu22Afdv5Gp1X7QWQimb8QRZAzoUYDWRqIAZVWbCNnGtP?=
 =?us-ascii?Q?G2vGMyMsRtrG8OhW7eOa8YYB+XMi7ZvG27eldtHclJF5XxEj/4dKVlrtqltI?=
 =?us-ascii?Q?X02AY2hvFXbNjBtaiBtyTuNSPxrIRGAtfAT3HzRyt/uDUJQ6CeF7AJSgl4rs?=
 =?us-ascii?Q?uFvMygwgdzEcKPs7WZBK3cUbyA+A2YULtvnuL8vK13OxqHHlAbdUVRllwsQE?=
 =?us-ascii?Q?GQEzL2bkTADwjtOYL0UIRzfqgaszDDvp0jb2FR1RyENis9YwMfNJJ98Rhpwc?=
 =?us-ascii?Q?uG6AyVMuzi3wVbNDcjbGvo3RdYz8cTIy6C19YEKiPZ5MS8L391mFo11k72rt?=
 =?us-ascii?Q?qDbjApcn/jHRW7oBNaUZ/3kEpMupEo2f7PrCbGMPFqy6JgK5Hy6KxD4I+OLF?=
 =?us-ascii?Q?hOycsP8lL195Zq1hoemlwVMuAaSXjIWtk1aXz9E9f2UQG6BmPUcpjqr/rDQ+?=
 =?us-ascii?Q?CBID5QClGBhPevRvPkq7Do4f0UmGpLbdyqM5N7YRL/VIlI24EdxTMbuAR2wF?=
 =?us-ascii?Q?iyIRDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02544888-0608-464b-d495-08dbce2a3f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 09:28:24.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zla4ToQNIG7qHovbfEjSRjN/KcdxvPelAcs22/DkeUPIf/5szQFPWDUqo6Jxq5qdlATJGzMmpo38ocYiy4AXVIf1CpczvHgkXOR7o6Zc7PTTO1fs9qJMVS4KfZwRl+K7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

> From: Greg KH, Sent: Monday, October 16, 2023 4:49 PM
>=20
> On Mon, Oct 16, 2023 at 03:04:36AM +0000, Yoshihiro Shimoda wrote:
> > Hello Sasha,
> >
> > Thank you for backporting the latest ravb patches for stable.
> > I found one of patches [1] was queued into v5.10 and v5.4 [2].
> > However, another patch [3] was not queued into them. I guess
> > that this is because conflict happens.
> >
> > The reason for the conflict is that the condition in the following
> > line is diffetent:
> > ---
> > v5.10 or v5.4:
> > 	if (priv->chip_id !=3D RCAR_GEN2) {
> >
> > mainline:
> > 	if (info->multi_irqs) {
> > ---
> >
> > However, this difference can be ignored when backporting. For your
> > reference, I wrote a sample patch at the end of this email. Would
> > you backport such a patch to v5.10 and v5.4? I would appreciate it
> > if you could let me know if there is an official way to request one.
> >
<snip URLs>
> >
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index a59da6a11976..f218bacec001 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -1706,6 +1706,8 @@ static int ravb_close(struct net_device *ndev)
> >  			of_phy_deregister_fixed_link(np);
> >  	}
> >
> > +	cancel_work_sync(&priv->work);
> > +
> >  	if (priv->chip_id !=3D RCAR_GEN2) {
> >  		free_irq(priv->tx_irqs[RAVB_NC], ndev);
> >  		free_irq(priv->rx_irqs[RAVB_NC], ndev);
> > --
> > 2.25.1
> >
>=20
> Can you please just send a working backport for the kernel trees you
> wish to see this applied to?  Merging patches like this is not easy and
> doesn't usually result in a commit that we know actually works properly.

I got it. I'll make/send such patches.

Best regards,
Yoshihiro Shimoda

> thanks,
>=20
> greg k-h
