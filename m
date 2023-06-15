Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7BD73104B
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 09:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbjFOHNt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 03:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244644AbjFOHNM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 03:13:12 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A73C04
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 00:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxViIUm6+UG+2Kx/HuLv+daZb8euN8idP0PBhocIgwUgCzTzXcTfNbuSww4t8RI+t3Dh/iPc37M0UiVax9tRf3bDb4XL1o1qxr/j7m+Lu2iLvZA8QnJnI+IwRak2+YxMufKMKY4ztlpdbMfiq2wQMYRvCoe5JwJnOcOypla1MeDj0Qi0WA7THl7fqnABPzjKtUPrTKWzm8PmwLcuH2KBR6iAXp6ceKnGQiifjKGm6YLp+WeVNg7Ds5PG4bmI2CwJIDxDw/Fx/Yxoom5R4dkt745I212VbIR3HeNrSAJVCz28HhWjL+cOjuYhZ/sbR0gakr+vfeQhsrnbtaSe6N9myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5vtzEM5sXl2aj4FnFh4lAobzxzuWp8J7FVrzvfs7ck=;
 b=dRZdxj1DlVBTdZh610ca6VpZePsPO7GpK8SfveIaNVrqAIlrq2FY3TugM+US8DAh10wxxn0IU23oE79YQK2yqAlvsgvQhdvm9m41W1af4mwpJEh8L342pJ00DtGv04Py2ZNnj7Szj/eEIpQmiKrrMNW5bMA1Jw79dsOzI7uA/urvSYs8XC4PtX+7NwEJwZGtha7XedvSg9+q+g+j6OCodI5/CBN7eojbxuo11cgaq3C7juUVcdKDfnyUSZVIlir0CRURD7nwrHFLF4ibS0ZrKdDp0pdP772hxykjmaWnARcHGRFBJ+8BZYjXsAqqAxUJE2TK0dXA2PB5E14H4V61Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5vtzEM5sXl2aj4FnFh4lAobzxzuWp8J7FVrzvfs7ck=;
 b=xX5IK9JcG6e9b7NSs24JFsAlDAHXadeSI7CwgfTQV4bKAnL1TRsHELU6qH7990+CTJx3HzqEtir/DVQ2GZ2lMx0BjvFYKCDLQUiEFr8/pS3DZbbR9CDAtFRdnY6GUEADoZwOuRC1PZPNiEvf+gt2wDVxojWm/gIK2tZ3BYyceSfXwi1ImkKQ0w7gZWOXhLJZTTuWchzjDeasXTF7XQ2UccX8/PRH/FVk7IoAL05GsTN4g3VGBDjd52SgLjSLOh8FDKTgCshuX3helBPbZLWN386IFaEWQ0sl5C2G+VO8glQkyH1lYQH40+A16kdenGXK8kyAox10ppgUJenubXU9rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS4PR10MB5741.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 07:10:54 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 07:10:53 +0000
Date:   Thu, 15 Jun 2023 09:10:46 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?B?Sm9zw6k=?= Roberto de Souza" <jose.souza@intel.com>,
        <stable@vger.kernel.org>, <holger.philipps@siemens.com>,
        <wagner.dominik@siemens.com>,
        Clinton Taylor <Clinton.A.Taylor@intel.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 5.10 1/2] drm/i915/dg1: Wait for pcode/uncore handshake
 at startup
Message-ID: <20230615091046.620dbe2d@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230615001735.GV5433@mdroper-desk1.amr.corp.intel.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
        <20230602160507.2057-2-henning.schild@siemens.com>
        <2023060719-seminar-patrol-68d8@gregkh>
        <20230612093030.03336764@md1za8fc.ad001.siemens.net>
        <20230615001735.GV5433@mdroper-desk1.amr.corp.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS4PR10MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5174cdfc-5fe6-41f4-15a6-08db6d6fa844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExajT9LeLvGI+PCulGUH9M4pHa0iQcE2iOePTJmBJ/AwqnODp6Cx/QVeYa5V1wt0tvO+jjYkACqwE8lkgGbqhw/4JPsnr1aVIatGLnAf5HSscQ2TMHUZMiG1vuTyNDP2Yhn5EcshXShWm8MlJXBJt4oF7oL7742TnHz5hIKZpjbaGs6j5orAHmleaex7LtWuds2bJnT06hcxiuLNJJUjqLClZAhPkpzRx+FectQJ3mTeJAR+/inY2cPQboPgq87m0n/4G3G/gYbC9nEn/dpbIq6WRKWPss1nuuKdioAtvXwZRP/2Z4AC9JmRfVfnTD+De5M85lxuQPSyQhacUa+oYeL45nG/FCOK70pQxGHI7ublUC9h0Y4xicKxd2tISZQjHKr9TE2ZJNxs+nCWA7gncLxJl8uLTH3tVR6KZxlkFeD6QZ+nniGLz1n0KbdmuBPEFPNeeAblLKC9qau2CSNo/+r8VN9wVwJPDPBCTg8QWq6+izGimRr8TFsB8i4arVS8skAaNYmDrBza+4wVF5+AdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(9686003)(6512007)(1076003)(6506007)(478600001)(186003)(966005)(6666004)(6486002)(2906002)(8936002)(316002)(41300700001)(8676002)(44832011)(86362001)(5660300002)(82960400001)(38100700002)(54906003)(66574015)(83380400001)(66899021)(6916009)(4326008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1Q0TVc4cGJqSEVVWVg2QUI3RDgwWTdHaVhsMHBhOVFuVTNMTDV2OHlHMmpC?=
 =?utf-8?B?dDZpUWN5NngwaFNEdFpDc21vUGNpRGJTNHJtbDlsT1hiRmxNRHZQRVNaazV0?=
 =?utf-8?B?aWpoYmZQK2xVbm9RSkRuMWdRRjFwR3JxS2RrVEZKVmJ3NWkzdzNSQU9YUU1C?=
 =?utf-8?B?SEt3UzdqdHBWc25hUUtkZUxBQzk3eGRHTVdBZ3JnN2RDdjcyZy94WmQraHZn?=
 =?utf-8?B?aFVqQXM2VU1OVzBGN3VCYitOUFBvL2VIcFBvQmZHZVlvL1dyb216dml2VVBi?=
 =?utf-8?B?Wkh1NWpwVGtuK3pJWGhsWXZOWE1udTE2ZXpmRHQybWNRb3hUWEhSckZyREhY?=
 =?utf-8?B?R0gwUEd6MzFYMGdycWo0SEkrbW5PYUFNVEpWR0dZdUViYlBtSVN4WG5MQ2NN?=
 =?utf-8?B?YTVhNy9vSEZuMmtlTzV0RzF4TC82MUdXa0NkNE5JOEFzWkpXc3ptZ20zczFD?=
 =?utf-8?B?SU8xTVFITjNQRGNINnFqRHhrNElpMjdWTmg2TENYOUdnVHMxdnRERVd6RVg0?=
 =?utf-8?B?MHRDTUpzYWdsSnhNRG1HV292ak9BallKUEFBcGM5d2lJckNrUE1KdytFbmJJ?=
 =?utf-8?B?YTVsTkJBUXhQNzdQeHJqTTM3enQvQ1prYldzaEFmdTBWdVJOMGpUeDUzaWty?=
 =?utf-8?B?clFiZ1RCWFRUQU9sTThtZm9Cc29QYnUveUxYS3BWRkhSU0RWWjVNWnd2U3Nt?=
 =?utf-8?B?aDM3VVFCUlB3RE5iOURsWWhoc1NRdU9SOGRYdW5ZUzcwQStZQ2NnV3hTRUlu?=
 =?utf-8?B?M2xrYzdHMEJHd0ZHT3k0eDFFWi9OeUdHeXhVb1RoTXFVZTY1dmc3UkRKUWhV?=
 =?utf-8?B?SFBIeUtoa2MzQ3NiNnoyQVJjOTZINXhCN1hYN0IyZjNjN0ROZXRBQ1FzNDIw?=
 =?utf-8?B?YUZYNHlmcy80ZjJVK21PbVFBUkw1U2crNVVsdFBmejdoQ0RZbEZXOGd3ZmNE?=
 =?utf-8?B?YldPdWMrOHg5d1VhQlhNRXVOY2pIeWZCNXcrL1JpYWlYcVBpZmVCVWFvN3Vp?=
 =?utf-8?B?bFNpeENONlNFTU94NmYzQWtnU3Z5VjV1cHorWWN5bVh1L3NWRTFFbUdhQWVY?=
 =?utf-8?B?VG1CQ08xbHFwM0Zjb04rUml1c2QyRnVKTFU2Yk1nL2ppNDk0V2hsdHpQWWRh?=
 =?utf-8?B?bnlJeXlrMVgyMVRWa2VmVGFreVUyTThpNVp4cUQxbDRaeHp0SlJIRFRmbVJm?=
 =?utf-8?B?YjRrWHZlL2wwN3BBcUo0SFhnNFVUMTNIdksvdnVsYktzRENvUHVHNWRaRUhB?=
 =?utf-8?B?VDd0OFJFZEYweUhCMHVDRGRXcDdUQ0NaOHY3UFp5ZFBveUIyQ0NyZTJtY3F4?=
 =?utf-8?B?TkljRlZBRUFNMDR2NjY4N0R2K3BJNkgwMnRzV1ExREt2bW1paURKWm5TQUJl?=
 =?utf-8?B?ejdSRUZobmtudmRnMW5BNjJZMWtLSGU4TlBob0JiOU5jTGkvRk9yd3B5NkVn?=
 =?utf-8?B?OVo3Skh6OUR6RE1Ia2F6UTdjcXgrOXhtMzhTdW5ocWVYTktLZXBXaldCYlVr?=
 =?utf-8?B?UXJPRGozaUdGbk9zN0NNSThienFoSXBmaXFnVEZacFNmQ3hYYzFqTktBMG8v?=
 =?utf-8?B?dTlaRG45R1NTVjYrQ3d4OURaVUIwM3VaVkU4NkIwOGFhaCtJWkdQNzlBWG80?=
 =?utf-8?B?R254Nmt1VDRxeTY0MU0xWUdobDhxSGk5Sm1XZXhFY1QvTUlleWljdXZaQmg0?=
 =?utf-8?B?L0pwSUQ0VWxlTm5xR1BqQ3RmTkV1U3FjTStVUWwxQXlsUUlQSkRWR2Y4N1Rw?=
 =?utf-8?B?UHBBb0pwd3JhRjFEN3o4bVVXcy85ME9jQzdyZ2luVFNBL29WTVpOdFlYcUw5?=
 =?utf-8?B?OGI5QjhFVm9zTWU4bWt5MklpL3dJeDdXSzZ1T1lCaEdVQmNKWEpwR3lDV3VZ?=
 =?utf-8?B?aGV4MElOQlNOTk10ejE0OHVUek5XNUhab0t0MHExc2dLMExMZjRvK1FWV2Vp?=
 =?utf-8?B?eGVPcU1qSDFCUWVPUmhjYzJ1SVMxYWVFQUgvWWwxOVd1NWRwSTNTVE5sUTFK?=
 =?utf-8?B?ZUpxM0FFMkdMcUllY2plbnBNVmhHaUxXUFNuTXBNbmRZUkcyTXllQXh6c21o?=
 =?utf-8?B?MDVlVWYraEhNaGZ3Q0R6bFM1UzhxZzlDdTZtTDRMMG9Zcyt4R2x4N3FqZDhS?=
 =?utf-8?B?YVF5dXkva2IxNnpiQkw2MWpsckl0eGRRVXh0OGpzdXljcjZyd2FWMGc4Sjla?=
 =?utf-8?B?UmZwWU0wWnZtcnlBQ2JtbFZ2Q1lUTE5Zd0UxNm1iVDZ0NUgvVlBsdURaSUMx?=
 =?utf-8?B?dWtUV3Mrb2tlUDJZL0cxL0ExdlRnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5174cdfc-5fe6-41f4-15a6-08db6d6fa844
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 07:10:53.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv9lLRFSFGOMFo80XktIcuOUcz2GQjTehueqRGp1NQEQt1ROr06tew5bhaJvH64nvAYWlf8mqQFaL7E5gtakAGpPPO6D8yZvWvHLNSr77XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5741
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am Wed, 14 Jun 2023 17:17:35 -0700
schrieb Matt Roper <matthew.d.roper@intel.com>:

> On Mon, Jun 12, 2023 at 09:30:30AM +0200, Henning Schild wrote:
> > Am Wed, 7 Jun 2023 20:09:58 +0200
> > schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >  =20
> > > On Fri, Jun 02, 2023 at 06:05:06PM +0200, Henning Schild wrote: =20
> > > > From: Matt Roper <matthew.d.roper@intel.com>
> > > >=20
> > > > From: Matt Roper <matthew.d.roper@intel.com>   =20
> > >=20
> > > Twice?
> > >  =20
> > > >=20
> > > > [ Upstream commit f9c730ede7d3f40900cb493890d94d868ff2f00f ]
> > > >=20
> > > > DG1 does some additional pcode/uncore handshaking at
> > > > boot time; this handshaking must complete before various other
> > > > pcode commands are effective and before general work is
> > > > submitted to the GPU. We need to poll a new pcode mailbox
> > > > during startup until it reports that this handshaking is
> > > > complete.
> > > >=20
> > > > The bspec doesn't give guidance on how long we may need to wait
> > > > for this handshaking to complete.  For now, let's just set a
> > > > really long timeout; if we still don't get a completion status
> > > > by the end of that timeout, we'll just continue on and hope for
> > > > the best.
> > > >=20
> > > > v2 (Lucas): Rename macros to make clear the relation between
> > > > command and result (requested by Jos=C3=A9)
> > > >=20
> > > > Bspec: 52065
> > > > Cc: Clinton Taylor <Clinton.A.Taylor@intel.com>
> > > > Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> > > > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > > > Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
> > > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > Reviewed-by: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
> > > > Link:
> > > > https://patchwork.freedesktop.org/patch/msgid/20201001063917.313347=
5-2-lucas.demarchi@intel.com
> > > >   =20
> > >=20
> > > You also need to sign-off on a patch you submit for inclusion
> > > anywhere, right? =20
> >=20
> > I was not sure that was needed for a backport, but will add it once
> > i resend.=20
> >  =20
> > > Please resend this series with that added so that we can queue
> > > them up. =20
> >=20
> > Will do.
> >=20
> > Matt would you agree? As i said i just googled/bisected and found
> > this one and it seems to help. But you seem to say that it does not
> > fit. I am guessing the patch might not be as atomic as could be,
> > that is why backporting it helps. =20
>=20
> Sorry for the slow response; I've been traveling and am just catching
> up on email now.
>=20
> Since you're running on a platform with integrated graphics, this
> patch can't have any functional impact.  The function added in this
> patch only does something on discrete GPU platforms; on all others it
> bails out immediately:
>=20
>         +       if (!IS_DGFX(i915))
>         +               return;
>=20
> The only Intel discrete devices that return true from IS_DGFX are DG1,
> DG2, and PVC, none of which were supported yet on the 5.10 kernel.
>=20
> The dmesg splat you pasted in your cover letter is coming from the
> DRAM detection code, which is what the other patch in your series
> ("drm/i915/gen11+: Only load DRAM information from pcode") is dealing
> with.  So I think that other patch is the only one you should need;
> this pcode one isn't having any effect.

Thanks for explaining that Matt. This patch was just backported because
it introduced

void intel_pcode_init(struct drm_i915_private *i915)

which is needed to apply the patch 2 (the one i really care about)
without modifications.

I have two options now, still cherry-pick both like i did here. Where
we accept the fact that p1 is essentially a no-op. (1) Or i remove the
call to intel_pcode_init from p2 as i cherry-pick that. (2)

IMHO option 1 is better because p2 will apply and compile without
modification. So i will do that again, fix the double-From problems and
include a message why p1 is needed into the cover-letter.

regards,
Henning

>=20
> Matt
>=20
> >=20
> > Henning
> >  =20
> > > thanks,
> > >=20
> > > greg k-h =20
> >  =20
>=20

