Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF766F9270
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEFOKl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjEFOKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 10:10:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715D1887C
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNSgZcYAtMy+zBqxYVqLDbOBNhvgHqzIA9lzblYeNNMIacO2fg1Wn/jCetgnjpHnDgqQhuQ5Ruvgi2NRo4PJTazO7eRt11LTvCVZmg19jWRXOS1JXxvJRHMfuKNrfYioTcw9neDa48Kjba1ApHuaJywHWX+xe6AidndN9oS005HtdteuMzoJ+mkC5D6TIVYm23fzw9/sY9sZZ/XBsVXaq3rSH45qPbl8kmTVeQoI6Ncl70M4gHwIPTSpj1EHovK+l5VQP2+IoUgHM4gh0bytOJTYD29pflV0CeN3oZlKJ4uDmEch7PGC6QE/t2qrnZV059Xo06wmkNW/RG3Xlpo6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joZ8WwJWCEGP6Sc9qC3USg6T7YlRtxBn+XvXIs+Yops=;
 b=Zvkz7PV/ZpGLDyWklxcI9sdCY2vKURhTF4XNMONv7PliMznUOXQHkfpRuJeIyx2OVQ12A/6WBmIaaIXoy/yY59c+DwqrQL/7Grw7CNxfY95Bi2qxEX5vXCzaNh3I9ql7hfUEP2wt8JBhhLMmNkX+X4xARShR8NkN8fumjOUNz5MVPFXkU9GFhBqEHBAM9/8iqDVB8/tEdcN7oPi6J3MdfiRLG61Ao0Nm3+pNSuBxPa/6BfTlrFWJF2G3ReTyx3DkMFKNiMVfGNEJzCAmp+rJV8+nqU0iVCfmGELK9UVjUdi0BPO8b0vr2BPMSxsJiL5cWvH3YcCOVBrSC8wPuqGmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joZ8WwJWCEGP6Sc9qC3USg6T7YlRtxBn+XvXIs+Yops=;
 b=PcplQWJ/1re30Kfw2ozpG2fLzljk3ZCwCA0GxOSPOQyjRQqhhdaYhsWK/VWGeS3Q4UAn/chsiOd1MIMPDOawP3Pqy8YreaubvadTB23B4+1pD+5wm2h4wR/BWDUfen4xh5e2lNQQdG6nTVaAZ7DU1bblVFUGbYDQ8Q5/S+K+3e0=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PSAP153MB0456.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.13; Sat, 6 May 2023 14:10:34 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6411.000; Sat, 6 May 2023
 14:10:33 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Thread-Topic: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Thread-Index: AQHZgCRWEtoq+lOeVkOlTP4MXzDh669NSIHQ
Date:   Sat, 6 May 2023 14:10:33 +0000
Message-ID: <PUZP153MB07491E5811390ACA70222AEEBE739@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683382134-26152-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1683382134-26152-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=12222124-1ef7-4dd3-ab22-f145276f76f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-06T14:09:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PSAP153MB0456:EE_
x-ms-office365-filtering-correlation-id: c31cbb86-27b6-4f1c-4919-08db4e3ba855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dgFJicaxIdj6xCG1XYE5u9s+XAwHroedY71mkbcDih2X9nPrMnXo0lAYZIafeTanWoFMnTj5hsKNID5k3cK+I6cS/bSLG0p0V/h0/tjpW93EuShfxozXWv6zq4O9Hl1OmBNVGOJamLdZCf2Jw6uy3mkHMufBla5xnzBtDfD2t1ODItDf4roGku3EwtW5GKgUTI9Rz8iQ3MAaf5AbbGN6E2zxVh7m2HxGlEbTzPoyC/HlVRs1df3A7BU/+4HWb6CwwVh8klsNi7y2f+EzNyUKOisGrdVxlOHDsy7KfmUrw1bWntCsE1bPYjK0u/El9r1sw7X6PRaT7EyhnvIAxhYpOcB+ZB7hXbLQaZoBhFELk9BKse5SozH++xyqei8/M9LGRQnUB2grqmwSh/vlO//uMfGggUVg2+QB2idYGbfgNdsAk54nAOEsNqZ3Ndnrmzr88CDLRmzlEKxfsomeyZjmXSUldRXP6+Bgjo7vsDR1J8HjzSeyR/9xs/fyo2daaSo0bzljd3ledmlL5SoP3HRV27IVhEYPW8qDGXCtw006ou4YATIGJAK3xZAB63aJ4vucGP3ZkaxaOzDyyGioEFQQDCOsfLeP2YaW4t1LY7whgBvB8jrQirJfc/mA7Pc+1An0bGne1I+C2NYJOVAKl/gjzV7dpcdP21hwB7FzK/4lPGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(71200400001)(7696005)(66476007)(66446008)(64756008)(76116006)(66946007)(478600001)(66556008)(316002)(110136005)(786003)(86362001)(33656002)(10290500003)(83380400001)(9686003)(6506007)(53546011)(2906002)(5660300002)(52536014)(4744005)(8676002)(8936002)(41300700001)(8990500004)(55016003)(82960400001)(38070700005)(186003)(122000001)(38100700002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZT3FqytNLiNWjt56ewU2Wsv8TaOpcsI9ZC4XJXHhpZKfxAIEzD70Djbzue5E?=
 =?us-ascii?Q?hxaxtyBZ0Vb0ai3dGObvH75xQN5TzGw3BeLgeo8/tSr4Edhd8lcZZshJx+ma?=
 =?us-ascii?Q?gh/Fdfhse1QJpbLvW2c1wn9X+8zlL4AicD842ozsZiIghbY6gh9Qf7AwtjI6?=
 =?us-ascii?Q?TO+FpkH3oeCcCj/pty1c5gnLnAyEz3PRkn+EW7X0PGrt6YSOtGSz/g+f3icV?=
 =?us-ascii?Q?Hj2illZvu7hF5r6Gbu6t7QSWeSpELGSjpL1dNBPx728epcmU6vwUuZsF4lfa?=
 =?us-ascii?Q?JdaZK2owAHtxxh8HzEjRLpg9eG7t3piRRyREGe4c3ppSPqaHx66MtPH18cJW?=
 =?us-ascii?Q?1lmJ+8T29TjOTkSmLZKeLLwh/fj6SWH+ZhENu7tvp2Fb1wlcmufVtQTmeuPW?=
 =?us-ascii?Q?BpSA0o8bSpeQ1TXbjD9hOahpQNbJQxSQZVhgRi8/S9gX0Wr+xBTfcEdysaoD?=
 =?us-ascii?Q?izAVnYV2PkxUemtcSf94/3JH5dgXt/B4zr5lwNVragsYGjuSx8nESwOP2zOw?=
 =?us-ascii?Q?VPd0UxlqnzlTeN66CokQsZkcWVOvnAWDhlBJTlllKMk63Wtg8GgOuq+FPTfh?=
 =?us-ascii?Q?wSys4QSwV7+dTUH6PHMdKf9sNksp+xwK2xvBm1DW8QZiCJUh/02pc2kxUhd/?=
 =?us-ascii?Q?kRhgkXW/MFCLxQttjcZ4RgvrcuwcZVFDqIYiuY/t4agHcf+EsLPvURMnxsjP?=
 =?us-ascii?Q?a3e22G1tMNBwumCNdKf+2KwlClu0r1njNzJNS/4U5gBNokvTo0OC0ZgYs/Nd?=
 =?us-ascii?Q?Scggt9QhrEpnXQt3A14RDbuJX0QFR3/qp7S1NfWgBKvBqCKkKNfqTjl1zvqD?=
 =?us-ascii?Q?7KJgrxQbp33sNDzMKLdzGTh3xeS++cm/En0WpznBm2HLuxSzfYWdMG7MSZmE?=
 =?us-ascii?Q?HhNEqX8Ly83jBOlecBGbfFQZL0BFxw86JnQvsbLsvb5J+cr0esyHUFAtL6l7?=
 =?us-ascii?Q?OM9Dri7/N9J/w9Hh3gnGK39PAVhbhbsjpJtZNwCUospALaVA+zsy4RaQLuQd?=
 =?us-ascii?Q?oYd/pHahyYh3Deqp+A1TFfVQ9ZkVbRUmYoDTyyKSqZi7fDj4X/b+BUGuDXct?=
 =?us-ascii?Q?f0b3i5hQLk8gDzwXGOtWKGLZaLEZ1NjgAuMJHk2CSy6Y9v0qp3b+KFaHqkuB?=
 =?us-ascii?Q?qo1fUca73/xy16DAEOzLoyImLGl68TOKFDKAaRUUVY8L/wdMjdODvXvYxG/Q?=
 =?us-ascii?Q?2y/aBJl0Ga9750ARGKCKu8Fq5arJ1MBUjMa9v6VFGjAJQCsJQKSG/tX1Yoif?=
 =?us-ascii?Q?DgkxMljW7budkc/Z/jyit3dTlRBw5YT9jmyktJiP53ApUPfN8K9ICd439Rxj?=
 =?us-ascii?Q?rZVL5rkMpqVsRxuay8HlIB6N8nVXWawN/GWkYQklTQM6a3Id3uYAQdE89mow?=
 =?us-ascii?Q?J3u3gTUHB3/Y1PkD089rwPwUJqxacymHe8Azj0xFS7b6Zh1mydtpZc1K9MNp?=
 =?us-ascii?Q?oLhjLGdqPRaVcG41u8hTyp0DUMebVvd73EUGaI5ftIe3Crq/obnRSOIOIYnA?=
 =?us-ascii?Q?L81jk2CaYotskEhojjFyKBSzl3Y2MxHklHfHuFauHDc1OH6tkoFYm/aKOVz+?=
 =?us-ascii?Q?wCd6GMZDjWB5ehPkGo1KlMHCjJgqxS7dYTrkvsg/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c31cbb86-27b6-4f1c-4919-08db4e3ba855
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 14:10:33.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlBnW6OUWUB14PhMn225lg3bVjjwB0q8V+OsUQOtOnmBcqY42IIJJKiIAwXV/RdEVl9Tz6AHorQzF6PbBoYgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0456
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please ignore this patch, sent by mistake.

> -----Original Message-----
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Saturday, May 6, 2023 7:39 PM
> To: stable@vger.kernel.org
> Cc: ssengar@linux.microsoft.com
> Subject: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
>=20
> Assign the realmode pointers to noop, instead of NULL which fixes panic.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c index
> 1ba5d3b99b16..85d38b9f3586 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -20,6 +20,8 @@ void __init hv_vtl_init_platform(void)  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>=20
> +	x86_platform.realmode_reserve =3D x86_init_noop;
> +	x86_platform.realmode_init =3D x86_init_noop;
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
>  	x86_init.timers.timer_init =3D x86_init_noop;
>=20
> --
> 2.34.1

