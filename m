Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED617BEF1D
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379014AbjJIXbw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 9 Oct 2023 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379043AbjJIXbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 19:31:51 -0400
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93369E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 16:31:48 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 399NVYOI981073; Tue, 10 Oct 2023 08:31:34 +0900
X-Iguazu-Qid: 2yAbIh4taqaQvwpTXd
X-Iguazu-QSIG: v=2; s=0; t=1696894294; q=2yAbIh4taqaQvwpTXd; m=SN0tDj022E6Fbx959RyRaITQat2/+TmVXs8VoSLCQps=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1801) id 399NVXEE643264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Oct 2023 08:31:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hasGpMkD4Egrh2eP0e9qZ7gn60cDpiNKcHjgvHXPtCTMR24rZs8CKX1Jotwnt5GB3chMbx3VVqnGYeqnejNXuEWlHCDAzUeV5Ra3ByUiFeSfqPnWLPR/KxKsCjQmHJMzQnbu3k0QS9GYSCQGJ2+e3r3uecm+wjaQwfgNxbvixZlisKKga1/Ky1TFQOwwqqtUBUhWAEjj10N7mlgHLqCM+896zQ8mW1qBVZYqt2/oHXFcPmEOZHuZzgpaiueYYmPGG5792W93Hhbd0arqVYlRtWCEMZh+gdSVtTbt+w8fD3SaHvOU9u4ReddPD+sQ8kDCN1CMBbPGz8QGq3iEzuHAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PfGMBG5Tdi0XYqsYt/ctHJqqiNbKd9TNE2hRCj4kj0=;
 b=DcLVue9zkA85TLN0kBFzv0WSgP0Tx8l5RJMPiIe1lGL0kQUNu32pRyuPV/41HUsxMhQApgnjfd9KvhxGrfhXWpDhPpqanLT8rqmp3S03z+Hwvvbpn81ZOUAWpVek65jjaGouPSV6gOtZcIh8Tmb6hB2fBiaRmPrjvHWm9lm/VygUfmerjwcryb7MeR+vqoc+62VvsfTAnoMSua44yLr9b3aa5yHeYebOfb5cICGMbCYBPiI5nr5VCw1foHj4L5+jEtWCuNJVl7bhJ+3RsurZ2PdpU9bvtkeDzG5smg2kPI6zZzoX3TRWHKZaYh/H20inF5/dEHHRj75vwXKVKD+DUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <Niklas.Cassel@wdc.com>
CC:     <stable@vger.kernel.org>, <dlemoal@kernel.org>
Subject: RE: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Topic: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM
 transitions to unsupported states
Thread-Index: AQHZ8iQN94PjqEJFuEqbZm53BEhwO7AxZztQgAUUboCAC7CQ8A==
Date:   Mon, 9 Oct 2023 23:31:31 +0000
X-TSB-HOP2: ON
Message-ID: <TYVPR01MB11245597E8816A063BBE718C192CEA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <2023092002-mobster-onset-2af9@gregkh>
 <20230928155357.9807-1-niklas.cassel@wdc.com>
 <TYCPR01MB9418B505FA508B884166798192C0A@TYCPR01MB9418.jpnprd01.prod.outlook.com>
 <ZRq+KUh8fwb8N7ru@x1-carbon>
In-Reply-To: <ZRq+KUh8fwb8N7ru@x1-carbon>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYAPR01MB5545:EE_
x-ms-office365-filtering-correlation-id: d42151b9-9a17-4fa4-3b6a-08dbc91fde39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3hZmhbj6x2Osfz4tL1fG/2CcSgxywoYVSEkWF42TrGYEcdBcQ+MaPmF3CRvNYYL9ihT5+hjsdJWYf3zktO4rrWwjzhb+8oeSdHX6U9+Y8pGQVxXUjI++YbO+A0rnZXxjj37FScKHHg9zZUuly8bXtOw0EWJBu0NShgpgC2y+vWnEn+V/mlotXpew3T9p+JU+omI7sUBgovniXbrWrpoizlFmtr/cudYYEJsPMN0UP8wX1naH/gjw6CVcTdusbZjQ6dOgBKnrjd442Xxb6kOrj6Pn1+8egaAF70Ab2KGdN9QWJOe+DIjK87ZrbwAchZeWcTwaNB4B6QKG5AFwZaPr9PxS09gK1FoSDEjKcY5z6/0++Ar/a+vRJ7QIfYNhQ6ztQp2ka0MHWqIPlHfmSgyZCoyEvf9kO5wFBUFhDfSRmnwh0DKoAAug+GfCONUN6hQ/+t3WIlVNKB9Yii/ZoYSc3mrS7pnTDaITgmzIw+LhxKCWp/H3NLoNAIXHpCUiQGtbyNM+D5veKAwf/gz4tcauUnG9lSZ4Qi1k9xSDCS8KBpFYimB1+0z/7n/zjbSN0V4wWMAQ8AbaheFx9/h5R8E+djxftpBUmw9tBlyaKT8hgyiKwxDYFGTZ5UBBebfyfLFrKbDfdgMQZ4E/xBzVjO+qo3eR3fJuZfQa0jKiY0bik2LjOgjvcfVX23J06zfVdtE1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(86362001)(33656002)(122000001)(55016003)(38100700002)(38070700005)(7696005)(26005)(8936002)(8676002)(4326008)(71200400001)(9686003)(53546011)(966005)(83380400001)(316002)(41300700001)(6916009)(76116006)(66946007)(66446008)(64756008)(66476007)(6506007)(5660300002)(54906003)(66556008)(478600001)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?amJEVEdocHFLaUphbXVZQTJsVU0wamUzQWtOeUx6MTdXR3JKM1k1T0Nm?=
 =?iso-2022-jp?B?YXlwbjNWbm5ycjg0NlllS0M2TFZsdWsxTGtuV1RPN3g0RDlTbmEwcWVu?=
 =?iso-2022-jp?B?eHlBV0VndVdRQjFOUEdFM0FqVkJXYWNaMmQraVo1aFZJM3YzNnl1b1M5?=
 =?iso-2022-jp?B?b214ZDZVRzYvN1hpZmdSRDFJRmJkdjd1YU0wZ2Rkc1FrUHpYaHc2eUJ3?=
 =?iso-2022-jp?B?RHVobU5ScEpkYUpaYlZRUDFWalNlSEhVeTZwbkRzUU1uWDVxaHhIaHJp?=
 =?iso-2022-jp?B?c29BZzJzRUVvR2d6STRYWVhDa2VMMmJUU0VtaWFzWlVVNC9qZkJqMGlO?=
 =?iso-2022-jp?B?YVNuQkhyc3lxT0RYdFVSeTNTQmZ0UU9qNWZXUnQwRlZJTzNBbXUvUWxG?=
 =?iso-2022-jp?B?Nkk1WjhTbEJ4OHF3UTllMHY4Y3NQaDZGc0Y1MjBpaE1DS1p1WVlkcjBJ?=
 =?iso-2022-jp?B?SmFFQ3d3bXZGcDdNRzhsaHYzSHNsVjAzcVdRSmV6UEQ4TVJwNFFBK0VJ?=
 =?iso-2022-jp?B?WUxOb1NSZEFpcjF4Y2k1Nnl1d1NvbURUTnZ6YkdxSGxXanNqeGhFM3M5?=
 =?iso-2022-jp?B?NlRWQTM5dzB4c0FhNXpESFdmclh3NnI4TW41M0NLTnJMSkJhWktMZTFj?=
 =?iso-2022-jp?B?NDEyYW83YXluV096Yzh4KzJueTZvaHJTTkRyQTI5U3dMZXVkUkZhNFpR?=
 =?iso-2022-jp?B?MmhKb090TUhmQnJuUVpFZ2I4eHYvMkpDNWRyWWhOV3N2bEM0Um5EMEVq?=
 =?iso-2022-jp?B?ZUx0TGJjUi9OdkErSFhCZlNJMjh5dTc0bU1pVnQ0RXhWVk9zUHhKNFFU?=
 =?iso-2022-jp?B?dnR2cXJpNVU5RDRMbWNCTkp6RERVRmFKdXBydFRiNUVLM3c4b0o3NG9y?=
 =?iso-2022-jp?B?NnFMbUloazl2TXJ5ZkFHNTBPRWNEM29hR01PMUpucWRYQTRhV2hTQis0?=
 =?iso-2022-jp?B?aDFpRXdEelFUcHY2THBLU0xFVDdMWDhYYTlGTExNMWpHK1ZLbmc0QklC?=
 =?iso-2022-jp?B?Vk1nbDBFTE5Xd0J0OEhqR29lWkptd1VBK3BuOGt5Nm9pWCtzRFVCaXdC?=
 =?iso-2022-jp?B?d3JKZFlkODR6ZUkvaVZjcTBhamdQT3c4enVxaEdFWkdtOU5IYThxellU?=
 =?iso-2022-jp?B?NE0xTFI2Y2FpMzh4NjUzaUdWb2lIaGNDdVhDcW9aOVFLcWhFbXdjSlh2?=
 =?iso-2022-jp?B?dVZEeTEvZGg4MlNJdlFqK01EQWNvaHloR0JIMVBZRmVEL0ExK3RjVkw2?=
 =?iso-2022-jp?B?ejVkL2hOZDMxRDVhbUo5ZVJoT0hkZzVLRTd2U1VhV3RUbGpvMW9acFBG?=
 =?iso-2022-jp?B?NGw0SDF3Vkw2TWxwR3FDQUNjcVVueHNyUTlYZ3grSS8xNXo5SUN1aXdx?=
 =?iso-2022-jp?B?Q2piUlltYnBSV0wweEU1SExrRS9YWlJQNGJ4RzdkRmZPTmFjTW9acHBC?=
 =?iso-2022-jp?B?MXhJdUJ2T3Jubk1LMm9oaE1jOGRvcy9IZFNNcU0vYU9RT05nVUExWFpt?=
 =?iso-2022-jp?B?K0FqN3VjUnhzSlp4UEpJald6dlY2Q2piQ3dxdDZMZ2FKTlFlK2twWmhp?=
 =?iso-2022-jp?B?ZExqaHFMc2VjZGV2WDR3R1JwYU1LT1BGYUpFNzNMaThUSzE0VzNML3Uv?=
 =?iso-2022-jp?B?WTJlMnM5dmJsa2dVT0VWN2FLWWJFWFZFenZ4UEhaRlhJTE92bXo4bXl0?=
 =?iso-2022-jp?B?WE95aHBPMTA1cllIeUUrYzVHT29VSG13ZittZWlEM1U1NUFLeXdZb2Ev?=
 =?iso-2022-jp?B?OVFmM1JGNE00U01XRFNDTFdQWkx4NDBuV3hwVDkvRTR0V3Z2eFZqYy9W?=
 =?iso-2022-jp?B?ZFd6Z2c2dWNMTTJ3dFFsUXJSK2hyVklyelhBWlJSckdhNnRKVjlKM21v?=
 =?iso-2022-jp?B?RGg4V0g1a0pYbXAzQ3dMMTJCakMzMkV3azRScnp0K3c5bU0xdFB4YUp0?=
 =?iso-2022-jp?B?KzRaczA3MEIyNDVKejF2dFRXZEpBWnBnMXhxOWY3b1djcHZKRWZ5b0hE?=
 =?iso-2022-jp?B?VmVQRHU5djYrejJyMGpCYjI4dG0zWHRXL1prd2tldWJKQjN0UUJScEVq?=
 =?iso-2022-jp?B?SFB2Mk0xd3QzdnhteWxYeFFVWkxLOWN0cW9mUmJrcVZCUnJWdXNMbW5F?=
 =?iso-2022-jp?B?V0FNOGRadllPL0FSRTlRcDFSa0t1azY4VG1pL2NPSTk0Y3NFZUxoeHJE?=
 =?iso-2022-jp?B?Sy9SRCswV2ZtOFl6VHNvb3dTckkybTIzYjVMdk9XZDYrd1JjYmFBcFhp?=
 =?iso-2022-jp?B?VkdxVlJoNzlTMU9NZ3EvU2FQcjJ4NWc3SHdIamVqT3B0ZjBDTmhiU0Fo?=
 =?iso-2022-jp?B?bUFoeVludWh3N1RaU2JQZkJaVGh4aWFLRWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42151b9-9a17-4fa4-3b6a-08dbc91fde39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 23:31:31.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESPu+01kQUKBojMAZLC0o4wKaB0UExiGTr6mOsP8QBZ225R13xVmyQYghFwddcIq8XXjGBXudO2wteKu9Hpkgs2dINJ+koxodmi+WhIymVugxNs6PTZMWVleLKAAJlFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Niklas Cassel,

> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Monday, October 2, 2023 9:57 PM
> To: iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: stable@vger.kernel.org; dlemoal@kernel.org
> Subject: Re: [PATCH 4.14.y] ata: libata: disallow dev-initiated LPM transitions
> to unsupported states
> 
> On Fri, Sep 29, 2023 at 07:27:05AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp
> wrote:
> > Hi!
> >
> > You have forgotten the upstream commit ID.
> > And there is a message of cherry-pick -x. This is not necessary.
> > Could you please add commit ID and remove cherry-pick message?
> >
> > commit 24e0e61db3cb86a66824531989f1df80e0939f26 upstream.
> >
> > Best regards,
> >   Nobuhiro
> 
> Hello Nobuhiro,
> 
> The Linux 4.14 stable kernel maintainers are:
> Greg Kroah-Hartman & Sasha Levin
> 
> See:
> https://www.kernel.org/category/releases.html
> 
> I followed the instructions provided by Greg Kroah-Hartman in email:
> https://lore.kernel.org/stable/2023092002-mobster-onset-2af9@gregkh/
> 
> 
> """
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> linux-4.14.y git checkout FETCH_HEAD git cherry-pick -x
> 24e0e61db3cb86a66824531989f1df80e0939f26
> # <resolve conflicts, build, test, etc.> git commit -s git send-email --to
> '<stable@vger.kernel.org>' --in-reply-to
> '2023092002-mobster-onset-2af9@gregkh' --subject-prefix 'PATCH 4.14.y'
> HEAD^..
> """
> 
> 
> I do find it slightly amusing that the instructions, provided by none other than
> the stable maintainer himself, which mentions linux-4.14.y, should not be good
> enough :)
> 
> I think you should bring up your concerns with the stable maintainers. If this is
> really an issue, perhaps you can convince them to update their instructions.
> 
> Until then, I will assume that the provided instructions are satisfactory.
> 

Thank you for your point. My understanding was not sufficient.
Sorry, that I have made noise.

Best regards,
  Nobuhiro

