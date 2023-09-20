Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22A7A7C0F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjITL5i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjITL5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:57:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1699C6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695211050; x=1726747050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gZxTWezlv/3Ov2H1OwbAHyNyQUsTnlVKkUvwjaPagq8=;
  b=IE2n1nFRk5o9E4ZhRrHxQ4kW1NH8DlRS1PffOs4IQ1dVK3whwTQ2ByWg
   47UdnXB2e7uK7zubGBMKwwTDoccnRpTCh1lqw7k32a2gpgldmlkBJcHlA
   BmFq4uIJOZZYFDnXzhyZ0jJAfwcbP/nSjLMAzoSt32nv/X99aprV8imjK
   aM9hWeMJoDmSWhPeb6nrB8knF7JQiorSVd4iRIMiZlRmB6wW8EcCJf5kU
   9HKaZRUrpPGZZT8ghcRO4GukeNtHJsR4RDRh0nnRq0B6N6zHExZbJsD3h
   mAmP9jyVnisZ0SJaqB51o/cisScSBwamm8QA+359M3NPGsjOXOMs6Z+u6
   Q==;
X-CSE-ConnectionGUID: IPUr+aSGS42ak8fnPFUHiA==
X-CSE-MsgGUID: f4HH/joDSemwV2i2YI+iPQ==
X-IronPort-AV: E=Sophos;i="6.03,162,1694707200"; 
   d="scan'208";a="356512039"
Received: from mail-sn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2023 19:57:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIwep8DvktKowAV8CWC4nbd8wGbPlAWlhlswLcrkGsRn1PQI7FcHavc1Yjj2sfj+KiHw/tTc6p3p6OfatJK+UKS5jNEEgK9ByZYThqZW2kSToy7wX42Gskg7ok0zzgOsuAAMnGKZyc1eSMDu2IAQ/aKoRbSLDPPkaVaJOegfQIYlrltE4S5gp//jed0OzNTPa8t1ZpWoe/HCHEtUVrok2Ly05hcx3JOx+jdpHTulxHeuqQqRW/DwwiQ3hBZHf0vxa95G9ifwn50+S+0PZvg3car5KMDM9U5UXCRu+XKfBdcaM1UezXDn93YVLMtHdVH5DCd7H6otWjeyILTI684b8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZxTWezlv/3Ov2H1OwbAHyNyQUsTnlVKkUvwjaPagq8=;
 b=ZXOiFG9+1BEw2K02b2oMO3M/sy7MEj8sbQAOjhMexjGOOfnBkCBQgHef/RXIXagPnJ6H2TTKuXbzQo9nZG8g3jdHkyVK1BPKHqBY4mGkA7I1/R3Sl0CyRd5d6+Mc5OhaH/0QlIyHjx5i49AC3ZJqTpkHzZZrtZiOVkxtonhabUALGuEg+lw95zRr7efHv2md/mrYKNoJ+T8S9c0f9JGBcHUF/nAW3fkZaeDbGdmr8yHFzGSDB2YjiwzWeEyLgj99+cDVK2An/eH98hVZpg1Z61++ydzY+ejyh7mspGQu123yaGfHeyx6Z4XXtcwsxSulSAI7RQQKpfPom+rUe57fIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZxTWezlv/3Ov2H1OwbAHyNyQUsTnlVKkUvwjaPagq8=;
 b=C3RyqJHE0BKpLkTZP5rZFnXCQIsYw5qCpe/dyV/68/moWRENiFuTVrlLI2+k8fBVNnt6JNu4IxvyrzTviZVy2tplnYaUyH9j2H+W0ONNU+J6j6a67SsO9KZQrJtZHAjCBuCVkNClR2YN7dAo8q4o0/W12QGTAYjR8U5Jmisl3zk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6292.namprd04.prod.outlook.com (2603:10b6:408:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 11:57:26 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca%4]) with mapi id 15.20.6813.014; Wed, 20 Sep 2023
 11:57:25 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "chensiying21@gmail.com" <chensiying21@gmail.com>,
        "Chloe_Chen@asmedia.com.tw" <Chloe_Chen@asmedia.com.tw>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] ata: libahci: clear pending interrupt
 status" failed to apply to 4.14-stable tree
Thread-Topic: FAILED: patch "[PATCH] ata: libahci: clear pending interrupt
 status" failed to apply to 4.14-stable tree
Thread-Index: AQHZ66jhy3WdMfARFUqFIXcRox4XcbAjm+eA
Date:   Wed, 20 Sep 2023 11:57:25 +0000
Message-ID: <ZQreIV2lk0OKSuju@x1-carbon>
References: <2023092019-aptitude-device-3909@gregkh>
In-Reply-To: <2023092019-aptitude-device-3909@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6292:EE_
x-ms-office365-filtering-correlation-id: 5ddc766f-3248-41dd-f2e1-08dbb9d0c17d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9199zcn+3uuJ7lkWMb8n8kST666lcNET0JEvSj9628kjRVkcODKB3H5/G+KGb8/YTUxgQWfMbTAm0Wc+ddNmfo+hBx6TAJ05R68oDL67e0FuGNkH4qAqD+7PdaNusdOhehvwj/EZydH5FgAdzYaX5zS3v1lR9cFLXc3OvOXxhB2mr+1ZMkvj0ccJEedZBjKqy5gekVhfI0XY7yhh179zKY1k5AoI4nBZWHwqipvkYkRIR6NKkfUM1UZX7xCr/aoWNyZ/1afv295Yc+5ScBxBTguxFKA3PQ8yOOdwkL0hKpFNskuhtxe7xBUxStSA6bUJZdCvZQi0PpuPzVyglm2dIbGAD17ghV6OyEeNuh6f4qB9hqesXboFX24KuI4TXPz17cCPTDKvQNSKY7lAtgCioPrXGIj/0BHj8UxACX5m1U14wZT9Gp4KKKlGm1cjAxfGyJwGknyiX7ThDC6ISJ01ecdnSrrMr2tw6r+6iZvdUPi97UKF4A4hMQZR7yqCCIv0/qrZWLd2FX/u3rB8vOTfrT2dUc1USAaRlrPeShQtTle+7JEuFBhxNK3ZokYcPqahWCZe0AthILsmaDF6LtSJMMhvbxdU6U0HIOOfAAm7Ob8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(451199024)(9686003)(6512007)(71200400001)(6486002)(6506007)(86362001)(122000001)(82960400001)(38100700002)(38070700005)(26005)(2906002)(966005)(478600001)(5660300002)(8676002)(4326008)(8936002)(316002)(6916009)(33716001)(76116006)(91956017)(66946007)(66556008)(66476007)(64756008)(54906003)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zGyDlv2zkvhatz176bsedw3rPldMPSDV8BlWSI/UxVETCkcSlHbnYDjQ2y5g?=
 =?us-ascii?Q?W89PqO2VSKcnkT6ete+5ssy0/77i9cTNyHO0KuLCXPmHLuwyXfDVEZZk9gLT?=
 =?us-ascii?Q?dZihkt4aMUg7FjCB3SjHY6nYGatU2GB2WPT0TKFH0hQ8ScARWgigOL27OMBY?=
 =?us-ascii?Q?FruX61wVu2ZmmYxdeMR9IN9DpaZeGJlz98cqm4VBO+3L+CcLlcmQltO0dKwO?=
 =?us-ascii?Q?F4WK7BhTOP0TCQo7unC8zdb4ClTE0PP4/aMD/vt+FZM8k8/g8ogwwJfbNz5M?=
 =?us-ascii?Q?NIyjkuzSnlEggpzzWvp1UQEqZ+PLlXPaJT07PzMNdDd8roTVdVSXnoRQMocF?=
 =?us-ascii?Q?Pn0gDEZZOFEzjVdjBUdQqUxBUMbw52sN0/qM+OMppL7rNssX1nIs6lYPj6YU?=
 =?us-ascii?Q?baG+LG+JQzM8/glhj7sRWVVoQ2YpPk7mYId8ravv0vJJ0ooQ1jMPVxlpoiOh?=
 =?us-ascii?Q?14ZbsLxsDMghLzUvgjEWOgK/BMsxhIubxj866/iITVFdcWBgpLyfaavc9EZG?=
 =?us-ascii?Q?+UcvMMokLOCz4//bT1mTBc7VTXyxKDOfJq4LNBuH7p9d7lW8HtTztUDd5K2T?=
 =?us-ascii?Q?hVEt/mPg7xhAYrDMer1AvMJ4M4Ktxso+bta+j3QbbfW0iaxLxEaOxyhIyfZD?=
 =?us-ascii?Q?alA5l5g8FziBv9AwLQfGhs0n7IhH/9A5HNzTk7WXH4fV2wS2SDcCXM8uaZAw?=
 =?us-ascii?Q?uExDKnLeW3SpCgL2kvMaEmE+yQf6suRvlmcctKQVAQ1GXfGtUpzQaCJefD3R?=
 =?us-ascii?Q?KcIeAB3qBEjGRfRaw2VVYPNF6cmOeD99+ygASwi+uvCSiyqSbscZKyumQfcT?=
 =?us-ascii?Q?ll7ZLfUqePcCpF3rwXv3voWPmGLe+MOX3ffWVRXvDdtiP0UheKTsRx7T4jDj?=
 =?us-ascii?Q?e2WlpSsdH4NsoIdSu4J3rGMuBDxLpiwPOVTnpG0iVcQ03blXlSwl47LIRhHg?=
 =?us-ascii?Q?7fL7EY7S6HJoRQX+D0O1YrhTyXzJaYauRjOAy/PNo7ZnM/WmDdHnPprQzqMp?=
 =?us-ascii?Q?mb6ml2hlINzrgwHGlziq8N8hYIyF+4usLrdeeVaB3raaRa4RIWE+K/rSCBjP?=
 =?us-ascii?Q?xW9S5BA8M24CHN3htcs6Ex1dMl5WaISXakxjrp6+MXtXox6WEuqlGtAMOkUa?=
 =?us-ascii?Q?HkcBd72mUoZSuPxx3Y/g73IXJVFuLAGMPO+zIPBJ9e+chOQTILaDa42epjtO?=
 =?us-ascii?Q?inNOxQ275zDhzgTu6HAswRMuRqjlFEb2zWzyXhV2HmjSKpImhuiMWe/C3kg7?=
 =?us-ascii?Q?TdF2OIMcgDlPDcL+1E2OJr9sbl5t6sv7goydom22XajuKN3cwLS07NHQQV1V?=
 =?us-ascii?Q?FcSk8OEZNYjcDX38jVWaNwWp7zGI4iu0c0ycie5YqE5hD1i6JzLuvB/mvzbI?=
 =?us-ascii?Q?yZeWu5fBXKgCFZHUzRN50Re4af2cHbhGDretIKRKuspvI1h3rsFPiwdPAb5U?=
 =?us-ascii?Q?HgLUlZiNOpwr9ru6ARs7efRd2m4SbzDIkAeyIN+eMgOfl6VIm35cssZk4EUG?=
 =?us-ascii?Q?mCpLatQnjheK5f7D9o8AFRUOlkuJSEn63124NMVi3vyT88xfaotXmJgRtpfE?=
 =?us-ascii?Q?Xjs+PPmlacuCDuL0UplFFV1WbjK5zs8Tto38/IBNaXD7CvAIPnSiLjpI/1mS?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85907857F7F3E94F85361EA1EE1A3A67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UYHnA8NqEGduYTMtyM1zLbkpgB2yEGdxcSHarsvW8/sM7FQgKqbVv3ztUhHo?=
 =?us-ascii?Q?10NLFC/9fzgsNKzSPvhW7j4uF+EOi/RyY07jD6Ks9k6K+RRFnczRlBJJAMAP?=
 =?us-ascii?Q?pJhIDnCRLNFcXUK/rbVJPQHklzRkPN5tKvNS7h1EIi3kOLsuzHnR22wfMkXz?=
 =?us-ascii?Q?0EG7sK+uK6lUpUFT9QoI49Inj/M5ZLv2jg0/NTo3rZSWk6SjJffBWpKKkuhh?=
 =?us-ascii?Q?bq3pYkfn4RAb2boNpyhKy/BHVgPu8W/IPWf0hL1piiwHIJONNY+Hlvp0hHR3?=
 =?us-ascii?Q?JtoDr+mC/nhibAwXg8+yhyCL4ZMkA7gonuefgGZYh7ZpKWogt1IBXA1sFrtu?=
 =?us-ascii?Q?hRHuOiJUWQDs1YZoegU9BRHnGpnpudixjb7lur+XaDC+sCyYHdEsUsAztSTw?=
 =?us-ascii?Q?u56P9L4wqr14k/js8uErhlyF9kILKb7r6jrNj3CsoO351gkRumhDCsamH8MK?=
 =?us-ascii?Q?47Vha64yhXTB/4InlacmL3yGXYh4BD1w8b7Gc5zktS5HUqpYB7DG0uDiS27N?=
 =?us-ascii?Q?P0AxNiqGMwoFRNpm4UeRuQcwPA1XdxZIeeK/tAq1AMAW/qD9jXYh+nTFGdhF?=
 =?us-ascii?Q?RFeNaaQ5kLRf3z+gsvmsBWRN2QGrtaqqmv7RhzpZ4FK970ykzEafAzTEemob?=
 =?us-ascii?Q?umwsXLgyTpX+oMDhfoImUPpKfEey28XyjsAb5e6YeUzuxocluvnsOmmMkz9y?=
 =?us-ascii?Q?yebIVtg6JHLDgXNbzFMEaLNdYLtBBXb2TefDVogV14R2/nrtT5cQKr8hq/sd?=
 =?us-ascii?Q?/ihHbVnU4P2QideqxcGlD9K5JCtNOpDnNRsFMGCUSd7hHVIg3JB8dekVmA6G?=
 =?us-ascii?Q?SgAxXNKGNwRLdZiDSc2wS/FyAxgM0nO+R2y8g69r70tQ1l1ZSP9kFrhC9zrg?=
 =?us-ascii?Q?xQoPBB3XiXOLmKjVNEDbgCN6gxGL5293e8IDJbQCEIJGpUMIUfF+QIMAtbhe?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc766f-3248-41dd-f2e1-08dbb9d0c17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 11:57:25.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNR+fSrI5BiZ2G2qFDLPxqdSToHt/cHCW6e/9gppEUq7M1GFxTKb+2mZpy3nilHEMY6yC059jNKWNPJlw0RlZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6292
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 20, 2023 at 11:57:19AM +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 4.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-4.14.y
> git checkout FETCH_HEAD
> git cherry-pick -x 737dd811a3dbfd7edd4ad2ba5152e93d99074f83
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092019-=
aptitude-device-3909@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..
>=20
> Possible dependencies:
>=20
> 737dd811a3db ("ata: libahci: clear pending interrupt status")
> 93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert the =
remaining ones")
>=20
> thanks,
>=20
> greg k-h

Hello Greg,

Seeing that this fix failed to be backported to 4.14, 4.19, 5.4, 5.10 and 5=
.15,
simply because of a single pointless VPRINTK() call,
may I suggest that we cherry-pick this very small dependency commit:

93c7711494f4 ("ata: ahci: Drop pointless VPRINTK() calls and convert the re=
maining ones")
for all the stable kernels listed above.

After that, the original git commit can be cherry-picked to all stable kern=
els
listed above without conflicts.


Kind regards,
Niklas=
