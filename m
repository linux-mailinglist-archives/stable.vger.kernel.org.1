Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C17B5395
	for <lists+stable@lfdr.de>; Mon,  2 Oct 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbjJBM5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 2 Oct 2023 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJBM5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Oct 2023 08:57:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FD99
        for <stable@vger.kernel.org>; Mon,  2 Oct 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696251441; x=1727787441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i23mx+Ww4imfACid8LBjMAoNWRgY5GbkaIhZMXjYrhw=;
  b=lnAaMXRfw+1ZNcskaFfNu8bPUyrWX7WNhpS8sKsoSErn2bV2p+1AaG/7
   Dpkd3tDWM/Ew+Eiwsd0jogVZmxZm52HwRguiRxWMUOpNtiO16cwIYo+zU
   cX8oGcL/9hOG0+aZ1IeY0QS6cDFPT866+8+kWUM/Z2tO6f0g8YEKdWamC
   2n+LjZpu5xqaQoETfyLiMN8k9LlB3sY0sBjFe6BvpAIL3YN+0qjPeUj+x
   j4EBZIw3TUq8d7zfwJYxfljeF45+njq5ALQteLVawoQJh1SoD1hotsYev
   eg9e7EXm6DYNcTUVepM+Y5B8+HsafjFU3anJPQ8PnaGKOqprjiCbXd8aG
   g==;
X-CSE-ConnectionGUID: aVqXuCtLQL+tTDBtJPxH1A==
X-CSE-MsgGUID: Lk7e8GieTdmrE+o4ySIhMA==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="350849037"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 20:57:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxhaSQgx06qOIMRQ9hkKQ/I5aqfqQ9pNrF7L+UEtTKE7TRiD3wMdnux237EIi8p9kduWnJN+H/F4AQHDUjKtzG/E4vrVapXM97ythnw7cGjrP0/9+6D3Jqe9Z2UcPHdJd0Rl9JjCaXEHJWYfSwcDLVgmJOPAkIhuF17GCXdwI/APd9Umj2dWG82T5javCZqOY/wbycz15L4IQ5EqTyuo2icP0kwm6nuofJT3XmCWEeSFzddYpLbNwrPD/JYHe0quQVEJ06+rSy2vnqUgTjwvb4RX+51708eF/oKOrXNn2qlTEnUVC0CWD9IHqLqHLfyd88AVJ8D5kpGwn/tDDrjfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOLTr6Cgg8dD4g0fCT5ZN9ntzPBq1yFccXIRTET0MLQ=;
 b=RXBR1UbSCty4pM6zKa9NJd30KfSeeMaHSJNaFFjVP5a0B9eJWiXOVMqbcm58fECpFEwxAWFJ5zVFfYifyNfjHUUx4tuTRD3Gzt6Xa0kO1W77DUtzMS4J+uyrWu4adE2xc6aPZhv8PShA7ytmeBzAnrcyv9qpHi/LWzTeJiR4G/SVSTsRpY3uFicanQSOf7PlA2YSGJfBJB/nPG6cLaeSioCA41+YYtt+yjRsWnRSAxeWVPIUPB4qB98Mzfs6g9VsT5HdcOeffbuY7YOsR8WLx91Su+nA5KYpF4aKh1YGX2HmSoICQNyetEKIe1ZSZBKv5vwuSCFDFYvknsc6Fc045Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOLTr6Cgg8dD4g0fCT5ZN9ntzPBq1yFccXIRTET0MLQ=;
 b=N2q0SyCWOakqwJNxDXEfpsFCMJD/pEz/5QwGi96uIL7OSgcESIVR5fCiToIjn6dFx1ptF3fVs9XDLvikzWVF+k00kL8wBmFktWicooQxiqs6jklyoWrnqlo7+ZJ2wwu118bHCPTXFNiHq369XzaIFRI7EXyR9HGM7LEo/0SKH4I=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8083.namprd04.prod.outlook.com (2603:10b6:610:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.20; Mon, 2 Oct
 2023 12:57:18 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 12:57:18 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Topic: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Index: AQHZ8iQIDu+bHYRGGkqKyy+/v0NIM7AxaGmAgAUTO4A=
Date:   Mon, 2 Oct 2023 12:57:17 +0000
Message-ID: <ZRq+KUh8fwb8N7ru@x1-carbon>
References: <2023092002-mobster-onset-2af9@gregkh>
 <20230928155357.9807-1-niklas.cassel@wdc.com>
 <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8083:EE_
x-ms-office365-filtering-correlation-id: 943ae5ed-38e8-4e23-3561-08dbc3471bc5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xMBhjwj9RWvkVMBUOAP730WieipxInJaq6E/f+3FcvGz/YmDvld6ryjuq8o2lzXaC8DQUN4Oj77KfsLGQ1JfXRZKCqkGDu3TwRuDzReNg1AztNX635rrbxXEU2BFVmCBICl8LF9MSuOnEhvNdP18SpiwAJ5F6yCBHRQ7krZDrgqLPQttWzKJRu/8ffW3MqUpgXSzFkGdidPWx48w/8HbHJ5V6Xet23clyguq6RIoQqYjVwuaaJzPCbzhjnuC3KGF9F7UBljg5SgQkztwOkiKCervnJ1Z7BJmNDABx8eUNznbEA2kJ7421YGhMFsEJKbJitRegtIgi0xDsesacDKSPgYpnJ2oj5tTrolRz72Foluf5Y6oMCr9QRzRym2K9V3lznx5NIx1h9WL6y7z+SinPfqa7W4p84mJK+43aGfhFhM0jUXfHQUQcQ7jZz1hfXUXXCl+45jGlDZKGJ/kVrTCsDyradHMkydTwue4aQMyvVlIEmhQ1OhE3uaqY9vru1b0MqxB0PNREe6+4li9rRwSK4MlmwVe1Fw8GwRlaZrzgcOAEqPIjxqz5ONCYe/pTgN3hycC8MC9TPCXN4LdhDd/HXYXNvJHq/nFXGBS3J7Yqz1SJuDP5zQoRnLgBiHEeZC1TtqsJEM6Eqd2taxYDaRYa9GnKE7UD8UZKMaXKje6mM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(71200400001)(478600001)(966005)(6486002)(38100700002)(122000001)(38070700005)(86362001)(82960400001)(2906002)(41300700001)(33716001)(83380400001)(6512007)(9686003)(26005)(66476007)(66446008)(64756008)(54906003)(5660300002)(76116006)(316002)(6916009)(66946007)(66556008)(91956017)(4326008)(8676002)(8936002)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v0ab/98oWUquhc+P+SKuXR8D7OWAXpYHDmPPXwSsRNojGRoI6LT6h0ZbcDEx?=
 =?us-ascii?Q?h2wMt1bWeWflb9I/mMul3ftLvrqd3rwFLHsWfRrT8KX2wdJyNldUZdOdnBuw?=
 =?us-ascii?Q?h87ar4b8Y0W/0ZoDEEmvHEbotHJNSEL65UxSwm6f9GmaHlbqaOkCQ4tf9TbU?=
 =?us-ascii?Q?1EEyD+VJpQQxt2X/41sBLQyNg1GO04eJxSmuNTjfg3Ixt4Fqf2OX0cturt6Q?=
 =?us-ascii?Q?Xn0LbPkDG/ntdSslgCMCfdkY4ofkmI90D9R4mIUxnW6iIqOZqoATUUQZdVcq?=
 =?us-ascii?Q?TvZL4UjwQM/ajSsq54ZiNdDatQg6T12LA0hHrfuhnp+T23C5Rmdr6kqPhkFW?=
 =?us-ascii?Q?CZ+RrMO7Gl95dG7r3rEcSyGp6y4DgDnganTkbiT/r9lJh3ZP3v2Gi43XoKD3?=
 =?us-ascii?Q?AzANalZJESfJtxEHNywoGxmNV8t2oH0fqUaIW8FLT58rXP3Er7/qo82zRSbH?=
 =?us-ascii?Q?ojYcd0gFMVEJKwiC8/qtG6Ne2dq1v6GYGkSC3GgJ/chzPGIYhp+1vSTMcu5n?=
 =?us-ascii?Q?taJCdU+56yCsfuLotqS1v78BXanIktNjME8W8E3ZbDgtxpPbzsCwL4ULSzd8?=
 =?us-ascii?Q?2/Oax0HSSjOBCIBehe+FSf/hgyjK6bblJZYWiOsxoqWiUrp938dzFaVpbROQ?=
 =?us-ascii?Q?ialOwU6l5MdJ0kXQx7phgBAHt92f56Y56UuIzUjxocnLE3Fn8OkRN/e/iYBp?=
 =?us-ascii?Q?uGbm6P4GlmH0QKg10MOQrZlxTXHe4ffYP230O2utkwjfB3VbGQHzHhXiovf8?=
 =?us-ascii?Q?9hlu6qAp1YDNgkI4QI5dtShX8eqCqQkueznRzP4SGvdDzVRUt8BfA6t44xlf?=
 =?us-ascii?Q?xG3u6F/WsDF4rUO1zGlUkxZW2e3hyx7mUku8+6e9kptkiMQ/fjeY+9Gfhz0H?=
 =?us-ascii?Q?FK0jqgGz8zL7oizChsjXm/mgAv/pFvJYSUoZY+XWkwHwu6/V+25ZD+MxyiUS?=
 =?us-ascii?Q?LT1aSlLXVUGeccWaf2lDZoR+H1szRcjJtjZgKCftV1M1S2nnvQoy8ODCC0/F?=
 =?us-ascii?Q?SF6B+W3f/Y+qn3JeIz3mkJdUNKm0Zj80j0mLiHlXyYhSfceVC8O0KwCqK7FG?=
 =?us-ascii?Q?pHoKEJs3tlnm8kzkDPITPKl0ZSYYBujR+StTEIFQaBZfvlGo+U+r+IDmtjZv?=
 =?us-ascii?Q?xxTiqvhdA+6BZC2jwofLigCPw0LA9zxjLPkPiJHkYX9i4ND0KTEyV2e+W1Lo?=
 =?us-ascii?Q?5lrlG6Dzt258g1VfE8wutqdQ/TANS9UaOZXwB/PldIutb+8MadFzdTXmQ8ci?=
 =?us-ascii?Q?TDSNUiBFfbmd85g9Ac9+5O/x9ethO/olFT+OUtPrJAvjabdNJq7d5Lp5KPd/?=
 =?us-ascii?Q?UISNlQqT91QO3uN++u5GOsc9xR1YmZ515E3xxE/mNXU/6G9St1OnRlhb1zXe?=
 =?us-ascii?Q?bxhVeBGN7PDhAyhQuQJsTq1o3vFGNih9IPgXLQxiBeSl1Vwecz2X2YXcmvxz?=
 =?us-ascii?Q?ZlR6NEoV8Avq7p1HFqA8otE+uvQ5m4ggpT2ziLOkK3sKTJB2KbuwpQCGRs7y?=
 =?us-ascii?Q?/JJnwd9yJR55RcoSH4O7GqRztkS8ze153skT5+qQ6hftofskpaakuziwc4p2?=
 =?us-ascii?Q?3A4Np47sJQPIY0H2iCVcBxbDwm3YbB1lo8OMJtpiE5JxBecBwCvTIzebDn9H?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9E78EF3C9D0FC4DA2B6902BACF9B7D8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rastamWTT0KVhXKL9WsF2z8acKCinpib48U77J8Hlns+NxbBLA1zEgW8hkBa9oFZyQToblLtiB7dQa3PvLNALOVZnI/rL+igna4/ezID2jW/40ZY/iGc4oV2r3bb3U1ipG2dUrXsuQvH0nHXKzqi/C6djllvzUQpHhGTP32FP7d/3J/4HUIyRADKWeCEHPu8yBP3kgh1LFFhgU5wYJqJ2yED1ASxqdDDym5GWlXJ6xqRwdpyKrbhWFOUXmIkBdR8lSIgHdVfXvUM/oeMzJ43agEeSMxatS7ED5SJEkyI86Ej2L+j6lSDj6XmqGy4b7f00XNiWoBmqrxGNYkl+H7curSjH/86UaAlwbuzlEuBMOfiv9gMCr51Sg9sL7H/DIwvWVILuD7rD0mh1omHGRKtgXPSri8nltVHmYI7Ejd7agBvmyvA+HrMuN7o7lUOpnZO9bXRV3X+BGgnYtP2Iou04omvHcFbTQMA0cQ0lKyL5g9FhaKHQFe+1SNu3YNJofBqxm2Xsf4VCfDIATr+L8n0csQV8ZYAlcou/qZ9rIkgxhtU7f1+9mk2fFCQJK0clUQpIXGmmdxN5uOaC8AUqrQP7yabUpZnsOqK4Of+hd7SjbWOMqzjWCbgDFcHYZRz5s8Ds31Ao+tzC80gUjJ/xRhflUY0fR4fEB6HaSz0vOrLyPOSj3k32B2ioLnj5Bpmj3pmyuD0rdQV/1LnWkEYExdllZJgxkZ/UTW+MFV2NVGi1x5EH/CGPvVHVu62CQh1FuASb4kle18O/Ep9iLwAR5F0E9pWQQ+DPBe3GQqMJhPgP1K0p6hoo22HoOG9/MaT2ehGW+RbdkMS2JnbinVH2RcLfpuXxVeCIliKXePjvGrwe64=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ae5ed-38e8-4e23-3561-08dbc3471bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 12:57:17.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLqpKEmRt4qcCzDe2MExJ0QC2cPMq5N+GOrWgMISvy136VkTO1djKfWU1EXADs6QCbA1rV4gPzcHuRHFWIMx/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 29, 2023 at 07:27:05AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp =
wrote:
> Hi!
>=20
> You have forgotten the upstream commit ID.
> And there is a message of cherry-pick -x. This is not necessary.
> Could you please add commit ID and remove cherry-pick message?
>=20
> commit 24e0e61db3cb86a66824531989f1df80e0939f26 upstream.
>=20
> Best regards,
>   Nobuhiro

Hello Nobuhiro,

The Linux 4.14 stable kernel maintainers are:
Greg Kroah-Hartman & Sasha Levin

See:
https://www.kernel.org/category/releases.html

I followed the instructions provided by Greg Kroah-Hartman in email:
https://lore.kernel.org/stable/2023092002-mobster-onset-2af9@gregkh/


"""
To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
 linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 24e0e61db3cb86a66824531989f1df80e0939f26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092002-mo=
bster-onset-2af9@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..
"""


I do find it slightly amusing that the instructions,
provided by none other than the stable maintainer himself,
which mentions linux-4.14.y, should not be good enough :)

I think you should bring up your concerns with the stable
maintainers. If this is really an issue, perhaps you can
convince them to update their instructions.

Until then, I will assume that the provided instructions
are satisfactory.


Kind regards,
Niklas

