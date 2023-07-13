Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F52751B84
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjGMIaH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjGMI3s (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 04:29:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7983DE
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 01:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz+oKKrFFynmnqNUcbK6R7k8HTbU0CXpVmMIDO0pf/E2+AVHrrUfvl+eo2qVyJ5nKSAzT9hNYjCv3qDBkBqL6WrCmgtHvd3VrKBZAWjIwoT87dh1frmtbK44eABC+7XgrzNi90oAq5pDQlJVUQRtFAHOrgnN2xljcBWpSrpa5OxZf0yP9wjp/NG4C/IZ+uhc2KXIeIWDsvN5SwwCuyQ4X9uCYCgBDegiR5Ltk1AclOQMqOGCk2RgkXuz6et45fY0HTSReVfwgXh7sL5RKbSHy+3xi3LT51I++t7kWxrIOWeCYsoAa+x6bux+yowRqi+NK7iBhyA7t12Q/PkJeLF1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y63PvRceO7vzPrUJLqq1/tFKhkb7USKrsjNc49uMy8U=;
 b=Ta0iwbkOZB6qG46zU7z2bxGnclp+BOP3DAwQOK+w+tosi1l9QBmPvBezSgum+j/T+dHXkDSvQ0+m1qNTkv03Op1oLS/0pl+52FD90kZnxXzRqVvyWfUvthr0GiksRvuFvb0LmpKyq9PyeznGK1GdDw/BqoEPhxWDydzo3uZakwgjpUeLSwOyO6K4R27XNVavZBiuiYrqkSaBj4v7GqjHvvwoQx/ZNIbM35efS2fp51tqUDOPjCdKU/fvEeSZfa1bdN6BMnc3oPhk4Z/FxS7o6T7bx0lYo+8Y6/07nv4E9HRV1jFStHnFeCZdJFeOKHnCh8M0teEAM8ErHtyHBUg4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y63PvRceO7vzPrUJLqq1/tFKhkb7USKrsjNc49uMy8U=;
 b=TFL3FqOb87367rOEVO4QXM9PrXPu2nJJXnrgljXTvRO1ToG4PcCB/M1BSeBcxLYtyTW5woOaSXVhjdLmB09mlK1z0J8xpLppXbDeFsJ6YuIS09JlDSh8EkfhrSqHj3MU4OeUHoN/d152LrjRiwsw9NJD11xKBw+PnM2R0Dj2B8U=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:15:11 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28%4]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 08:15:11 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: 4.14.321-rc1 build error
Thread-Topic: 4.14.321-rc1 build error
Thread-Index: Adm1YTYRcHE2PV3AQ5u37vjOpUbn8Q==
Date:   Thu, 13 Jul 2023 08:15:11 +0000
Message-ID: <TY2PR01MB37883616B104E56A1DDCA286B737A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OSYPR01MB5445:EE_
x-ms-office365-filtering-correlation-id: 68281290-d400-46eb-509d-08db83794760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQFPZlOaGoEYo6v8Y/hNHLaocZSHdWzzRToJmH3lWTgireABmeRzFAe1qnZaSY/D3F8PF2GrzGJeg5m/iIX2DPJGYtp6lQHIiJmPF8LWG1lnFZhrj+iJlSXQKNuDhFmZ4snVXunZVDSji81IZueoS5PUN6q+o8ZY/BRNONLu57qExpgEGNMxsFJMsCwOj+g1lyl8Uv07cvRZoUlHL85QebAQ5NnXcAK7MqzIREiJ5cDZhwaduDVm36ll/JejIGsirffdsEEKDKQHj/aZKRb+C3qfV9Mlqnn5zTwbIyeQ2AZT1V55gLjcrQU0dE1RNZy1CL68H/GctJnysfa0to0Z8uoeG0BvE9IFcVu7h1VuGglUPyUvgvDIpy5vkZ/lzNU4wxgabEAi5JL+QknMuarXIDy293TCQxOWkZuqEv8ttMdlZDhgHF086KGen7zcCrFsJToroG1AJxUC5BaNuM7yU5DeWTuBbVcj5Bv12UPz7VNoEML7T3PNA5M4kkJJ1XU9Ark4BEZKv/YZrBhXD3f8wKwS9JLTkhra/lVuWaghd4r1gU2Rs5VdmANK0Ets6PTk7Hz/2RhJLiHnQWwPtzUVdHeIOMwC4UzKChbG1h+Hckgd4SBkngZwPYQrzMwzk3FQ8n0jMXNawSESRCNpzWsHCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(38070700005)(33656002)(38100700002)(86362001)(122000001)(55016003)(478600001)(71200400001)(8676002)(7696005)(966005)(5660300002)(52536014)(66446008)(316002)(66946007)(76116006)(2906002)(66476007)(64756008)(6916009)(66556008)(4744005)(41300700001)(4326008)(8936002)(83380400001)(6506007)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+mU86GyZDX5VNglVp5daORhA8fug3TAWF+Q6QQoThxhuQmP/eQ3m4TJEyj?=
 =?iso-8859-1?Q?2rabdEEZrIjkZ7AanNhnpc2HvhBlLHPA80h55XKq+JaGWTQpT+S+5vOug1?=
 =?iso-8859-1?Q?klNZKP5Yc+3GCuBrc9FizdJWtmTJ4wdTdZmkOnWqhSZ/46v12HTRAThsQz?=
 =?iso-8859-1?Q?sJSLEEaq6RotqDy3p8erN8tGBYIK855iLcpcICGAIx9n6i1YZy1GlTVdY1?=
 =?iso-8859-1?Q?8do8yLPrhmx/x/a3qxAlJpwxS5kYfD5HGjHjRw08ce+NDeMr6nblLQKfAy?=
 =?iso-8859-1?Q?ODNq6RqkqfIwZEveIXg/mQwShXYUmKTS60e9y3Rckq5PljnJdb9M7AqmyN?=
 =?iso-8859-1?Q?n103FiMxDuBDmOdpCRSWgCGaBrPpdwfGuFdEyBsPr+RLPQ5thtjZzAODsV?=
 =?iso-8859-1?Q?gPQ2loiqadRQhraFa+83ffPgOApBinTvCI5sPWYyazz6mjsJ9BgOrkSy0r?=
 =?iso-8859-1?Q?ZszfubvOIVK56yTJuMAJpBmdNuwIG2qN3ZpjgGuYWrx3SGwO8WSJQxP7MD?=
 =?iso-8859-1?Q?h5QQmR/jdg7XFSZXHr0O2BiQlgJVJzcapXpzQpUm0SH5OaGIORFMM+0mRT?=
 =?iso-8859-1?Q?cgidkFsSXILNBF1AncsWO9tEla6rxul/UUQK8Kh6NECxkK0VWC8pSsYmNQ?=
 =?iso-8859-1?Q?+ubNpoOElkSm9i5lxWcM8S11kBGd2IqD2IjdA3qcCE6wj2R1lMN81qYMpT?=
 =?iso-8859-1?Q?p0d5WX/UbchyEvv1UyZu3YRjLfoYX6qGy2DRV3SL6+8IueHoURUAAlvPQI?=
 =?iso-8859-1?Q?y0SFJ1dO2RQDHxuKR2IQDNWcUjBl46tRww/Zyvg8BOH9jRZ3SfwQwo1OMn?=
 =?iso-8859-1?Q?JjvB0rrKBXndlIQwfHTB60xJs+y8RB0KE1kop0bdFH+mrTEjTmaX47YTq8?=
 =?iso-8859-1?Q?gJ7eVFL+4+4glacWePKFvQkXQd6HNaClGcYK8JlN/Zt+A/LxWKXTCccVR0?=
 =?iso-8859-1?Q?D/f+2iHQl2UFh5zea8UUiyZ3uuL/QO2gSqtrC1xYm+WCIYreEjT11nDQNj?=
 =?iso-8859-1?Q?KiCo0+9FcBqsrdXZtEgu+LRUHV55bTRs86andWkih4iaGZKkr6RAOrBBRn?=
 =?iso-8859-1?Q?qIEtvd3V3pICotDt3LzUrJjoYHuL49+pG1FH9726Zs4Wx9YKoQv1a9D6YK?=
 =?iso-8859-1?Q?2L/odaSWANusdljV2x9DWQ0krjqDYuKqLKWOune903MFKekWBCnB67tXJD?=
 =?iso-8859-1?Q?5mWGXbfpQJp/fv7DIWovnRS11x8wSBdLfZLCT5catGV4p877CosSub2gvp?=
 =?iso-8859-1?Q?RZ+buDiFzaRzwoxLCb4cIy5aEBdupEQgMemN38wni4mMEneuXSljazBKUd?=
 =?iso-8859-1?Q?vcYfTC8VDJ6CUzqaXSdfxj9UeEsuuNqicmTDXqFdkLyGTLYScxvjrj1bCc?=
 =?iso-8859-1?Q?eBzSaMqX4NY52syvvvs1VqHBzxWUpH2PKTAaqI51YyiB43HuuAbjIU/Y9+?=
 =?iso-8859-1?Q?IpEpl/VcKLa2wLnPK7A8PbE94Jy6IILDd3g9TbQ+q8pk/JZzMblto0G4cq?=
 =?iso-8859-1?Q?Fj9YM1cXi6XAb3GFdMiuEQZKyEqgnojko7CDZQ55WAVYQ/W2viFBBLcSOl?=
 =?iso-8859-1?Q?070Qnv3bxIuQYCdg5YP+HY2tcACIKCVAgG+x8rtiCPC5n88LX/PE4nd2Dp?=
 =?iso-8859-1?Q?9LTTzv+kou4tLP6eKoWz21G4y504s0zqjsjX04fdx0dvWS1HfiFGsVgA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68281290-d400-46eb-509d-08db83794760
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 08:15:11.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZicivWoFEsHqiadAP/8kQXyNX8oYtOiNCEAfBmCuZnapHJ1K6ZAifawbmpH1Im0MQVUH9tH/8UZ+q9B/PrljTgy1Plle3CdCEDfQD4fhaoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

I know you haven't formally released 4.14.321-rc1 for review yet, but our C=
I picked up a build issue so I thought I may as well report it in case it's=
 useful information for you.

SHA: Linux 4.14.321-rc1 (bc1094b21392)
Failed build log: https://gitlab.com/cip-project/cip-testing/linux-stable-r=
c-ci/-/jobs/4635722359
defconfig used: https://gitlab.com/cip-project/cip-kernel/cip-kernel-config=
/-/blob/master/4.14.y/arm/moxa_mxc_defconfig

Error log:
/builds/cip-project/cip-testing/linux-stable-rc-ci/gcc/gcc-11.1.0-nolibc/ar=
m-linux-gnueabi/bin/arm-linux-gnueabi-ld: arch/arm/probes/kprobes/core.o: i=
n function `jprobe_return':
/builds/cip-project/cip-testing/linux-stable-rc-ci/arch/arm/probes/kprobes/=
core.c:555: undefined reference to `kprobe_handler'
Makefile:1049: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Problem patch:
Reverting 1c18f6ba04d8 ("ARM: 9303/1: kprobes: avoid missing-declaration wa=
rnings") makes the problem go away.


Kind regards, Chris

