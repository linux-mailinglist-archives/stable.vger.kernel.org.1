Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7272B8D1
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjFLHlX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjFLHlW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 03:41:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35110D3
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 00:40:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3S1fh21U/VCBYquOvXismTRUxD/f0J7MqkrasG8sCOWhZA6rzKsN+O5iTmSC85KrG4jfJitPfs4fHF82NNk9xpJj9CfC3oyAugaDhHsmMb3/WyzLZuQfKkbMnf67Mkoi+OoUpWAPthiv9HAyzRBiXlfc12oYx+2J5UsErPnjIPoMNuXiYCl7FDkH6MHIH0ZX+2jz7l5Po6y18jnUA69X4Q8/fILtFoUBC4noCTPbTqqyjh9yzm+cScgVrwoca6oMEiLIGgm/n+KAu2SJnQWI1uESt0uasiBRS8boqdjjX9KuFFKlSg4yvmXVdvueZf1zkUqP8bQ+vDbdrATmIOjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTEIUwQEzaBPIQJV43H/cERIY/A7LVWnrk1OPMV6wXg=;
 b=mpKBSZPe9TbtFK8I+SXehNV0TGnNfTCiBkivIKaXGJHHzWrzK13UniA7JbClY58uDxZDwMQBeZnX1zdTqq0KMMyn0n3eRkS3XEnX9H4lL2mJiH+jYTgkw5gmxNv8vBZYH/YthSTIO3vR6nAn1RLRwIh93K3bKMeQTTIjGeAk8LSEWu8sXw8+7d1nTFFgWhicYk2XA0SGxhAYLieex41OUJwwiVgBXzTian2BxwBNr/J8rgblP1wvi1XjtxNzHAIAVafO29mahFyB2TOUJ7YgH5h/z8BPECIJDF4CC11wcw8RAqh2TX0//a+ZeXvBjMqd1PQAZG00SzDuSzRM+ngfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTEIUwQEzaBPIQJV43H/cERIY/A7LVWnrk1OPMV6wXg=;
 b=JJbwDj76IoflN362ciRhj2Pkg8i0BhpUt/XIKE5SbxIKGjkRTggH7QCUmYMvvvwt3xXA1e+vFIa6xSzqMJ2B/3oT22Bwc1hipirRpcL9wHOLAcQODJzs9sQQEyo/1OrGXfPMQfzA3u2KtkWYKoxaXxORBzCfIZ1fSR2DsktBAXmPoGFp6s1vuKs81c7KtO2SLqemvFEBf3h9KgJjSK6AS72WPD7R0WoEN03rC37Tl+caBI72YfM4y9egwi/TnVryIPngXMenKwr0AyGB40FdkFDo0C3kwxhJ3KqRQrOraXUFjymmJJK5los5Q5wHDt27GMHDqedoT1z7SaVKb1JKyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB6295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:560::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 07:30:42 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 07:30:42 +0000
Date:   Mon, 12 Jun 2023 09:30:30 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Cc:     stable@vger.kernel.org, holger.philipps@siemens.com,
        wagner.dominik@siemens.com,
        Clinton Taylor <Clinton.A.Taylor@intel.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 5.10 1/2] drm/i915/dg1: Wait for pcode/uncore handshake
 at startup
Message-ID: <20230612093030.03336764@md1za8fc.ad001.siemens.net>
In-Reply-To: <2023060719-seminar-patrol-68d8@gregkh>
References: <20230602160507.2057-1-henning.schild@siemens.com>
        <20230602160507.2057-2-henning.schild@siemens.com>
        <2023060719-seminar-patrol-68d8@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:610:11b::33) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: c2af69f8-f96a-43f3-b2ba-08db6b16eda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3RWpo5q9Yv8Kr6hS37ZBAQLfy2XAXbwcS1/Lnh8MlgxGZIwvy59jS0PEj51r0FWu1RKETDU0bPTX4gbpCMZi+SFA4LNL9EDtIHTeYfFLoljqcR8jwjOP3JjxCn4H/DvHdv0lDDs7AaA9NYr52ZQBbWRaTv4Knzz54RRep9L0jQ7FQ9/Tu6hat+GOvlKFru3PwSxa8fWRAIGbIzRlDJ0hTL84tGWq5SmQ17i8x993KE8TUutpUhNBjUxeP0RalOsYjuj3J1YWg3R2hVAYCn2wtLzh6xgzpEqmmn6bKf4Vlzi66U4vTv4EOOuMr79gAPXII0Gzg4k8zVMUIPYTlTSQGlKO8ndBXCVk1mqO3GemBP5aZFxZ3qjoxQy9tWE5xpZD5QGyyWU008TLDY9V9nGmdbtNfjU2BuVPMnSrsayzmzbNHKMVmfCxd4u8ON0xMGGsu3MmKSIGF6GhW8Oaf5+zUbTVQr4Vhnrp3s4O6serABlcyLXkKdmGWIb3nvZgWhuSaGC4Xza8dF7KC2U6IDfsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(478600001)(66556008)(82960400001)(4326008)(66476007)(66946007)(54906003)(44832011)(110136005)(5660300002)(86362001)(8936002)(8676002)(41300700001)(2906002)(316002)(83380400001)(38100700002)(966005)(1076003)(6512007)(9686003)(6506007)(186003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tmd3lFemZkNHZMVnZVeldFYThheFRobFVUaExVV0w3MlNQRHRib2hqMUNy?=
 =?utf-8?B?ZnRaaWtESEZib0lNS203MDJJcVBxOG9YQU4vKzFzV0xQYWJXSjlZM3E2Ukoz?=
 =?utf-8?B?ZWs5OW5EYlEvakU5Qjh2WG5lODYrZDZ3aUdwSlJ6S0x5a3hvSk96bld2SjNq?=
 =?utf-8?B?amZudVZ1V3EvSnJaZythenlVeXpkUzRFSjdGdkNZOEtxZzRrTTJldjcwOXhv?=
 =?utf-8?B?RFRqa3U0UFpuVVNXb0x3UStEYThaV1dyOHdQUjhNaFZ1bGhSTGROa2FoT2pl?=
 =?utf-8?B?bEtyL05yVnAzOHNsTFlGK09oMlFLUEhzZU1RcnJlT2pOUTltZHJqd2NoSHMx?=
 =?utf-8?B?NkVLOTNwNXhMTzIzRElBMEl6dTVnM1lEQmFPNkI5U2VPUU9iYnY0Vnc4d2dp?=
 =?utf-8?B?Ri9mQ0VzU09MaTE1eDZFYUF3NDNPaGZ6MU1MeHdkTUIvaFdlZkZkUzdQZFdk?=
 =?utf-8?B?RGVZZVBNWk9LU0o2blFGMjVFZzdHVmFQT1Nyc3N0MTU0VytId2dlNy9PMzgy?=
 =?utf-8?B?Si8wVTdIcTUrYVJ6aFZHaWYrZVhwanRLN0g2dU5FOUZtSGg1SFYwYWYzVHRx?=
 =?utf-8?B?TlkwQURMN1FJckdyYi9LdHo1Y29YWFBQRDRnUGtiMGlYaThxUzUzbG12L0gz?=
 =?utf-8?B?OHNOTWpGVnhxV1d3dloybDVOaFZudmNETis3a1dGaWVvRytSaG11dmJ6QkNw?=
 =?utf-8?B?d2ZKZU80V3NmRUJIV0hPa240MzFrTDhWMEpmc1VDdE5Lc3QwTmxQWUN2dWJl?=
 =?utf-8?B?anM2NmQvM3FUVDZna0hFZHhRbGZnUVoyU0RLUWpFRFpvb29KTHR1VWVtK0tR?=
 =?utf-8?B?Qk1uZUdkTlM2TXBNdkErNmxUdTVSamFxU09RQlhuUjFhOXdJbzJKWEx2di90?=
 =?utf-8?B?SWx4SmdScmhoem10bm8rQTFEOG9QWkJxblgrUUNvVDRxUHpMYUh2bm94VVNN?=
 =?utf-8?B?bWJCbFBuWnBpa0FvaG9YRndHZG5SaVc4Tktwc3BFNlBGb0pMZ2FlQVVBaXR3?=
 =?utf-8?B?c3c0ZUhyK3lqNXlYRk1wMUdTajVUa1BaeXZXSnFoaTZIUWRHTllvS2ZERXZ6?=
 =?utf-8?B?ZGMvL1FxUGJDZDNHL0Z4WlIwZXhKK0FteFVnSllsRExSNlpWSVF1UmUrcHNY?=
 =?utf-8?B?ZGVVeEljUjlBUnQ2M29oUkJqVldvTlBSWWt1Sk9RQ1g5bk9yLzRoTjQxREhW?=
 =?utf-8?B?dnFFcGFEYUhLcCsvc2paMmZTWXJsYU9HZmpSSzViU0ZRbnVISDdaYS9BYmNa?=
 =?utf-8?B?MFZraEhhS1d0QnRYVmlPVlp3NkFPQjNZWGx5K1JmemlJdmxiUXVjSXk2RTRI?=
 =?utf-8?B?bWQzU3VIR05TOGZzS0RwZllIbE5xYjFZc2xySWdhQTg3TjJhZXNrV3FUZlFI?=
 =?utf-8?B?enY2dkVBNzVCS2xyYjJxcFBhVjNFUHB2OVNUZ2tlbVk2bk9hMlA0ODU3aGNC?=
 =?utf-8?B?NGhtc0NVSVlTMnhmSmJhZGxZMXBJNHRoTTZuSDRCUFhXZ2g5ZUxTZlN2MEsr?=
 =?utf-8?B?dDFTVjMwRDRtUC9KSHFqNjlCK2dFdXk5emlCbW9uL3BCT1NJWVFVbXRJQ3E3?=
 =?utf-8?B?ejJXUWQ5Vy94ZEpraXFld3BiOUF0eXZEZDNwY3Rpd2pqVWk5cjZJS0JPYXBk?=
 =?utf-8?B?TzdmUGpJdGNlSC80eC8zVldocWdNT0wvcjcxYyt4KzdaZWZncDZGY0ZVVE1Q?=
 =?utf-8?B?R1J4L0kzSERCYTFLcndrc1dVYXlRN3dnaWZzcFBXZjNNVEpqSHhmSXVYMnRz?=
 =?utf-8?B?SmgwNDU2ZVcrODF0dnp4c3BWdWF5Qm8vaUVCZkx1RGRPM3RFc3REZU9EWW5m?=
 =?utf-8?B?RVBTZU1LM0NGaVZYVkVLRTUva1lXY24xZGdQMGl1M2xkMy9lZi91cWhTekRK?=
 =?utf-8?B?WTk1c3dLN0VqQkpOaGdwREU4YnI4a0VCT2JsWG52MTVVSy96Z0lidzluNnQ0?=
 =?utf-8?B?bENrUG1qZ0ROMWtMN1U5bkYxbHRvSTF0MTYrVjVmRTZod0ZMTEp1NUgzQ1NF?=
 =?utf-8?B?NkVWYUV2Vk04MTlBK2JPNk44cnhGM1NsK0x0N080UExJQ1lLSXc3eUdJVVgv?=
 =?utf-8?B?Z1dQMElRTFVDamZmeW9rdzFjTlByZ3VuSVU4SUZybXdNeEkzWFEwUE9tUmNC?=
 =?utf-8?B?d3NNQ3l4aDVtUGRuaStCUmsyZXoxVU5lc0dQN0xWakJqQWhFVGRKSy8ydTFn?=
 =?utf-8?B?TWxsWklRaW1HbnN4Z3liVHhzczJ5VzZxazR1NHVHaVZLbHJDNnBHZFp0TVpH?=
 =?utf-8?B?b0x5ejVhYmplelBGWkNxNXlibjB3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af69f8-f96a-43f3-b2ba-08db6b16eda8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:30:42.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh4p++c2ySAbBksRYdx6UGVvlc/ZyI4T3AbEQRipIA6QtRM6N3fjHMs8RI5OrXLjTh2vHKMn1w8qKRRFikyKCObYKi3CQCPWnrIG6TUt018=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am Wed, 7 Jun 2023 20:09:58 +0200
schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

> On Fri, Jun 02, 2023 at 06:05:06PM +0200, Henning Schild wrote:
> > From: Matt Roper <matthew.d.roper@intel.com>
> >=20
> > From: Matt Roper <matthew.d.roper@intel.com> =20
>=20
> Twice?
>=20
> >=20
> > [ Upstream commit f9c730ede7d3f40900cb493890d94d868ff2f00f ]
> >=20
> > DG1 does some additional pcode/uncore handshaking at
> > boot time; this handshaking must complete before various other pcode
> > commands are effective and before general work is submitted to the
> > GPU. We need to poll a new pcode mailbox during startup until it
> > reports that this handshaking is complete.
> >=20
> > The bspec doesn't give guidance on how long we may need to wait for
> > this handshaking to complete.  For now, let's just set a really
> > long timeout; if we still don't get a completion status by the end
> > of that timeout, we'll just continue on and hope for the best.
> >=20
> > v2 (Lucas): Rename macros to make clear the relation between
> > command and result (requested by Jos=C3=A9)
> >=20
> > Bspec: 52065
> > Cc: Clinton Taylor <Clinton.A.Taylor@intel.com>
> > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > Reviewed-by: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
> > Link:
> > https://patchwork.freedesktop.org/patch/msgid/20201001063917.3133475-2-=
lucas.demarchi@intel.com
> > =20
>=20
> You also need to sign-off on a patch you submit for inclusion
> anywhere, right?

I was not sure that was needed for a backport, but will add it once i
resend.=20

> Please resend this series with that added so that we can queue them
> up.

Will do.

Matt would you agree? As i said i just googled/bisected and found this
one and it seems to help. But you seem to say that it does not fit. I
am guessing the patch might not be as atomic as could be, that is why
backporting it helps.

Henning

> thanks,
>=20
> greg k-h

