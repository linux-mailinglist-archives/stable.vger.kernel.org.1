Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB210710220
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEYA4w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 20:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEYA4w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 20:56:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF19E6
        for <stable@vger.kernel.org>; Wed, 24 May 2023 17:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/9/+/Iaakyc4ZW12r2KI4LK9lIq4YQ5DnqoZ3KGQr01/Fn8hu1jKICFp85nLXD2jbrMZuU0wzzmDoxhI7KtVmxItIN2NnBvem0b9t5dJY5ZgEUC9Uo94u027HDciZH2HtiSbKdh7O0aCoNkTi9yXR1TYwJciDyoK3aMKlfh5Ro08UfJj0M9RxPIL9GeVve1HqqLLnYdr5pH6Zzj8bpwx10VWYqXIZ3hH/sv+kdHX/Dc5QEDyDGOycWJ3c1XVn0IuwdE5tWyxvGyMW1TdA5SZzDMvuVAmOQ1oq68NIIfMpRNVzRLUedzN6H6o5c5sXb+XRSxrrCD8p7Zy9rsbc+05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgbDzzONGAvEuL8695joXvV8tNGoydeSwkNDSHeoBSM=;
 b=M6UkXTLfrqr+Vk+idFe5UhIvyVsNPjteL7spyMHCyTGvyI6DG2SO0S/Fq4KZHKMnfBa1cS0h+yERr7DJdfAq0PFytSSqWlxpiA5I48wnmmtXTOpVb3ZduCgP/NUUQOH+qaAYeiMlXVQcZTl9pEKsyp6OOa9ARM2TL4pD2ICCx0gU//fcbfMaMhQAMF5k6Bb9U/wL27WUDWlC7KF3VVqUfY39rNKCWo2Wo/A6gyQxmyCr+ZXGUzQD4ObdChrExCxyMbmHXbkKQWY+33r1E8e1ulreI/83cyxE5sVJ7IHlfc7syAA/sgOgRsuqqWbbPbIKAkMeDV0tWA6bPtf5/+huyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgbDzzONGAvEuL8695joXvV8tNGoydeSwkNDSHeoBSM=;
 b=DAb69hcugj9/gZ7iv8sQRGbzLf/MoyWHzwAIJBVpmxJm5jzpTZWlh+ztmFQ4yGE7FCDtTsCu68hlGe06hmr5AViEb2V2BB2VCFLMTiCkVMJLNbvypZw+ZjJgykRZwJF1pAvkU53e6ii1vCfLPMzEbljNYSqPkYb6GwWhQ7y/7hE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 00:56:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 00:56:48 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: hpd rx irq not working with eDP
 interface
Thread-Topic: [PATCH] drm/amd/display: hpd rx irq not working with eDP
 interface
Thread-Index: AQHZjqI8SJ3ECAdV0kqwU+6uRwki2q9qKeig
Date:   Thu, 25 May 2023 00:56:48 +0000
Message-ID: <MN0PR12MB610177142B98F11B8E022130E2469@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230525002201.23804-1-mario.limonciello@amd.com>
In-Reply-To: <20230525002201.23804-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=31d53aae-3893-4e3f-8724-0e1cff20ba66;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-25T00:55:24Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA0PR12MB8929:EE_
x-ms-office365-filtering-correlation-id: eb91199b-6cb1-405c-d68f-08db5cbaeb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDIWMUTf7KTbgCMmKRYsZXBD8Zcs1AW1/zljxQT0xLS3Nf5PaYxiqQ5jp/JuAPOA/2Eutm2esvDeCHlL8QuIQynMCoOvwUxGaMtQCU5z3gpGNHPqmetRRr2cLAs+B4ALZgdtPQBNYmTRaJ4Oc9i+AJhMfc/OUGSwFwWO6iFzviCs47aN2zqUdFsRer/3iNUdgWOeObW54M/d2y/nl3CMOp094a/uIRxJzA/fl7TJVDOHPSrFcvTtmpq2XkO2ac6U0LBoO3SfEZeExFCO/ZEarkKnqocCd/cnpqXf1zYEBi5EJeBcI89YrXhVZZ4vqydqF46ECPSkCCeI1cgKqgj6w+1B01xnYWYwutDqqQcozo5nRDXryXIchExGE8VAx9cPLJumAdCqFhYIV3Lm7fBskk3YstAJiqiwQKKmCs9o0cyCcoTapNkWy35gpfHyYFwbIq7blMwPGN7iJsXBRFsNN4fHgufZLFAt6k0jmwNDYCKztdRvnf2Ew36RUPqUK0FQIZhYgBlfvAdhdMHKtm9OlsPZboUjv7l5U2Aw7N3KQOWShw9wdgJ64/8dpsTTbzUFmINub2wnREaEx+5YBh7XUlO5rMRnoOF2XDG0CQa06vUHP49oUsK1DOI0GRcyU9nn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(76116006)(66946007)(66476007)(66446008)(66556008)(6916009)(64756008)(8936002)(52536014)(8676002)(5660300002)(71200400001)(316002)(478600001)(7696005)(41300700001)(38100700002)(55016003)(122000001)(6506007)(2906002)(53546011)(9686003)(186003)(33656002)(83380400001)(38070700005)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVnr1ilTYA1s4IY+XbSliU6DEJRl+TymFIM5YK0/xoYD1z+43RNYIfs8B3f4?=
 =?us-ascii?Q?WVgRd8XkUNqWhaCkRmsWGac7P8hqLgFwZTMOXvJdiEcM/CrLU7nPa/dGIpkP?=
 =?us-ascii?Q?956DJaWOtcUrJ86sLB5fgHB9eUVkEYDbDy86XHLnNUiLnas+e/gOA0MHolqM?=
 =?us-ascii?Q?3v+N9w1kNg0kejCNSsZ1AN5AOteRy4ontGt+wtnrY2GXSgzU78PTRZMsl8lE?=
 =?us-ascii?Q?jPYBqvqjQ9qYHwAm3jjdCjJhNNpRjKVSY4ZeVVmwNaNTvmuYJr1/0ZmZ48Up?=
 =?us-ascii?Q?gwSYNcV0mqm3FrlK2iBhzDfIH47mXbejM4GYhZdibor6m3AfuXij/m2uUnum?=
 =?us-ascii?Q?7JjEncTk7ouUy080UQwYvsus4TBDGJnpGCKRKNcJP1eHLI7Dk/Cf5lTsp6HT?=
 =?us-ascii?Q?xJbgARvh1ydlfmokK/7nxhLiOrVxQPctJB76XkJf27O6SbOmjrT5rSZYivE1?=
 =?us-ascii?Q?7lDd8ximrDyj2/46Ju8TvyrKe2HCbPRzIcmzdXKqIWS1xF/F5N0UESYjCsti?=
 =?us-ascii?Q?6nAdAz0EB+qchU1CMvf2kHH7zo1T2uc7goy0LmXi+vAmWyaXndfFXBIveNnT?=
 =?us-ascii?Q?cO2Lq2o332fBtBPOlyUuCUNjSb6sXuymWOnHv14AuC6zhJCjR5jvFFbohkdE?=
 =?us-ascii?Q?rZTRxKucl84aAuyNylbGmegiJKCKiw6TQWuQ4sCQHZSRrsOsY5tsKcXkfkf5?=
 =?us-ascii?Q?dA1AMjy6CpKIarcPVVN57+UrxemGQIMMgOg46dEYDVCH61PmLSHYzXbWdthS?=
 =?us-ascii?Q?pUT8bsU+cG445kRajcStt2henAVzCji1NQUh1MyfncGtCKPgwmW2UdteqWzT?=
 =?us-ascii?Q?RWhRB6TeIseuCvRhtvS6t+AUENhFtBs1qdPltzEin+UmOdCog6zMYr1FAWuT?=
 =?us-ascii?Q?dUhkao7ei6Q0zycRhxKoqNvy+CpMt+MTslBlVvWbas2W7KA+rsuDQ6kSDfk1?=
 =?us-ascii?Q?Ulsr73H5SXLvzN22ksj6Pp3F880xyTlelvN5+/XN8Nz+4yba760M4ALewFQw?=
 =?us-ascii?Q?LGEUpI37NJ1FSCmqaEWns7av+rMRKQ3qhgMEPGEOOeTPG0wQ8530kkQQh23b?=
 =?us-ascii?Q?HYCST9QisNRcSCVgj+lb/1/VjE6K+21wdIkHqygSYaf2Ky4RqWi1vF9zIQsf?=
 =?us-ascii?Q?PG6i6ER+PyVWZNPYepdFwufLlI2EvE6AVgaDbLFzuy1px0FMpqD8pCJVpUr3?=
 =?us-ascii?Q?mViQbFW8ifRKfRn+MIBAXqFmpY+5jTaEw4RdGbf4a4z9Ieq2i+4C0kxY+RHV?=
 =?us-ascii?Q?hcj/ZKipkSwNTpxe0xygJiXMU7VQm1TUN/Zgro/GdGQ0OpiCJtuhseBI8U1c?=
 =?us-ascii?Q?tPJHHfA3YtsSkqSWB2PeooJUjOqzkGdNwNtO6C3aJ1x5PwT2/8ybZSpW/8zL?=
 =?us-ascii?Q?vQE+Jn6b+PZBerrKISLjVJmaL2WkaO4vBR3HcJjliuiIke611914SmwdJf6p?=
 =?us-ascii?Q?oN58ZL2rd/DfPtMn800awYcDSAQbjEZewSMTk9jK35sIFPc9+ZwmgO4C3COZ?=
 =?us-ascii?Q?aGi37EK/UEnsReoD/HcqTNMUIBkMOOxEbpXa96uHcFr85vTG4NrrMJzQIiUg?=
 =?us-ascii?Q?cAwAiA1yfYkMmueEp+Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb91199b-6cb1-405c-d68f-08db5cbaeb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 00:56:48.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQgig1qRZxyJOatlCgG3sovHxFUepfTBNss8iWT1ojNUTE0YY/RdKu8x04CBLcYuNXaFjJECGff6fOR/hp2n/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, May 24, 2023 7:22 PM
> To: stable@vger.kernel.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amd/display: hpd rx irq not working with eDP interfa=
ce
>
> From: Robin Chen <robin.chen@amd.com>
>
> [Why]
> This is the fix for the defect of commit ab144f0b4ad6
> ("drm/amd/display: Allow individual control of eDP hotplug support").
>
> [How]
> To revise the default eDP hotplug setting and use the enum to git rid
> of the magic number for different options.
>
> Fixes: ab144f0b4ad6 ("drm/amd/display: Allow individual control of eDP
> hotplug support")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Robin Chen <robin.chen@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit
> eeefe7c4820b6baa0462a8b723ea0a3b5846ccae)
> Hand modified for missing file rename changes and symbol moves in 6.1.y.
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> This will help some unhandled interrupts that are related to MST
> and eDP use.

Apologies; forgot to mention in the message this is ONLY for 6.1.y.
It doesn't apply to 5.15.y, and 6.3.y already picked it up successfully.

>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 +++++++--
>  drivers/gpu/drm/amd/display/dc/dc_types.h     | 6 ++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 6299130663a3..5d53e54ebe90 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1634,14 +1634,18 @@ static bool dc_link_construct_legacy(struct
> dc_link *link,
>                               link->irq_source_hpd =3D
> DC_IRQ_SOURCE_INVALID;
>
>                       switch (link->dc-
> >config.allow_edp_hotplug_detection) {
> -                     case 1: // only the 1st eDP handles hotplug
> +                     case HPD_EN_FOR_ALL_EDP:
> +                             link->irq_source_hpd_rx =3D
> +                                             dal_irq_get_rx_source(link-
> >hpd_gpio);
> +                             break;
> +                     case HPD_EN_FOR_PRIMARY_EDP_ONLY:
>                               if (link->link_index =3D=3D 0)
>                                       link->irq_source_hpd_rx =3D
>                                               dal_irq_get_rx_source(link-
> >hpd_gpio);
>                               else
>                                       link->irq_source_hpd =3D
> DC_IRQ_SOURCE_INVALID;
>                               break;
> -                     case 2: // only the 2nd eDP handles hotplug
> +                     case HPD_EN_FOR_SECONDARY_EDP_ONLY:
>                               if (link->link_index =3D=3D 1)
>                                       link->irq_source_hpd_rx =3D
>                                               dal_irq_get_rx_source(link-
> >hpd_gpio);
> @@ -1649,6 +1653,7 @@ static bool dc_link_construct_legacy(struct dc_link
> *link,
>                                       link->irq_source_hpd =3D
> DC_IRQ_SOURCE_INVALID;
>                               break;
>                       default:
> +                             link->irq_source_hpd =3D
> DC_IRQ_SOURCE_INVALID;
>                               break;
>                       }
>               }
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h
> b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index ad9041472cca..6050a3469a57 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -993,4 +993,10 @@ struct display_endpoint_id {
>       enum display_endpoint_type ep_type;
>  };
>
> +enum dc_hpd_enable_select {
> +     HPD_EN_FOR_ALL_EDP =3D 0,
> +     HPD_EN_FOR_PRIMARY_EDP_ONLY,
> +     HPD_EN_FOR_SECONDARY_EDP_ONLY,
> +};
> +
>  #endif /* DC_TYPES_H_ */
> --
> 2.34.1

