Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E757E51B7
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKHIMB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 03:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjKHIMA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 03:12:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEE1A2
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 00:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB++4Ft72VRSc3oxBuAEBgWrXINnU7kglu/RPWpjS4cxO8kss6OT63xfgDnS3h0D4YLjeOXic/YcWTq4GRscFNKSd4YW1WxPV+6PacFdi9o0CPVnNseXBHsastKvg/j2N6S7jQ6NlKPzGIsjKtk7Qr3FhTQ0SUktrBWKPotdKQBxdkZx98BPjaaaMfgjhxj6MESf63Yz8dKs6Ge7uFGcrrKL02bsXtF1E9hv3aeiq/88r9v/wP1hRHXNNulduqFg3RgykxlWMICBaFQIh3QbQX2uHY6lEBjQJUhXXsuCw1Fgt745zLq2N5oPHddNCdHAW3zu2GEE8YsRpldAy9sVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqOIQsL6grmvAasuqcSTzvgDRV9IhBcquqSc97S4Kfo=;
 b=CUS9XfLSbMvXVaPCoxNtoihmT9r/p773H3Fhx7CQG1NPYIy3xwtFPWbGS2Tw31qPWDeBj3qGRJ/9zEggpueDDMgjSn2zf81cA7xQ/tDaFYdg/3XwodNv2bk3+KEN+rEZMys6+qfRPXbASG7D97xmDQUzQET1IJnjWcC97A5+Ey2tahUwMF2jzOer6iOu+c5rWLZdhSDdPsRZ6Hfk0Ynxa9soCeC3YPi7oOgQuP+JWkrSOGj9NRs6nUEOXOKNvxAO7LeqkFEy+UPnWWdqiom6zpaHzqKwq2RHgfh4nEq6DTcGVUzoayUU3HXfMym6yqovvcyIyBrai9yMmAtJB8stWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqOIQsL6grmvAasuqcSTzvgDRV9IhBcquqSc97S4Kfo=;
 b=eYTHcy1/vbi2FTKjrINRUDKJtzeiFTMYPoDDmwhjXYPXnWvAmPnxgPZKk2xwjsy7McX1ST1KoNYD+6acaw6nmg2d7PMtKoYgd7hRJ60gEt8aADnFlPiNIsq08DscqKEegX8sagdhmGPaJ1MLkTW40DdajywR/WzxHj5cWGcWeOI=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 08:11:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 08:11:55 +0000
From:   "Ma, Li" <Li.Ma@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Thread-Topic: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Thread-Index: AQHaEfR8EWab8+jQ502vRig1927lHLBv/+wAgAAJ8gCAAANbgIAAAhiQ
Date:   Wed, 8 Nov 2023 08:11:54 +0000
Message-ID: <SJ1PR12MB607590C33100812C39125145FAA8A@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20231108033359.3948216-1-li.ma@amd.com>
 <2023110845-factual-dawn-7d68@gregkh>
 <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
 <2023110833-renegade-fidgety-a008@gregkh>
In-Reply-To: <2023110833-renegade-fidgety-a008@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=94f96113-f8cd-432f-99a6-551a53b9fc9e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T08:00:18Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7793:EE_
x-ms-office365-filtering-correlation-id: 4cf73b1b-7bdc-455d-071e-08dbe0325eea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4dhvUi2dZYeyWhzj3kHzNYI0fBtD4gjNR/DWcdB8cT0MYEWwv4JIH5ELDzcaciSIC9JIPrR47XSyIMlk3+lHA9pHKvwA1ImENKOsViPmnwcCR8LNBKNARhrfLo4KUY93r3JCoPynvNXYZK9EznC3dUzml9cvfW8lngvX/1Ho+b/bm36tEAnn8f9quQJxM2pSVZzf1q/nHP4ryY7q6Xx8ZdAdSkGxQyXyPJF45DWXEv9IcRK71QSNueg3ySfdD9tvfWIe6N7Zirx2KKyylBGAgex9LbZJU4eNEV9cNhwzMA5UUGAI+TAxwZaMtnmovy/lsFVJUq5RB91RgIyjDCgYeYOXlZlR04NKUHRSoGVObUFUuf4o7jMlkguY2jhWrB17ZVRHaewcFEZBKkH6gRQMxxgVeR3Okl69DqnKPU8WaxClsth5LsaUgzo7SHA/k0Zf6h200B/OaV8hmpvIMcxIVqFToIwbeOalOayznmKZvDlWi/w/y6kSZ8Po26+ndY3tC0Z+HesIFSXpe0OG9En8gPFr+RS8gwQqzShRbwke/Rd4jeMRtNo5xNED7Gt4DfUbugCD7DLDGIw6C1V5NKHi0jCXDO0b8kEQhwjyqByws5r472kC+hF81mpmhsV0RPzP/TB0IuWD+5eyNZAKE2X6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(7696005)(53546011)(41300700001)(6506007)(9686003)(26005)(71200400001)(83380400001)(4326008)(8936002)(52536014)(8676002)(5660300002)(2906002)(966005)(76116006)(66446008)(66476007)(66556008)(110136005)(64756008)(66946007)(316002)(54906003)(478600001)(38070700009)(38100700002)(33656002)(122000001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dVOHFHMEHGHuqcW/ia9+ElVUNDIEZJfYvEOb66MWXulpUSeXpoY3Ibr+U7Xl?=
 =?us-ascii?Q?wQLi8A4g3gD/i9AY+VL9Jhla+hPOLIZRd8Z8CgtPrgnLE1VMv535I3tlBmCQ?=
 =?us-ascii?Q?bNynbomcKGHwCXcQbmyjhaRp0n84g5SebdpJ8g0mgwqFvYzGnZv1/I1VS5Xq?=
 =?us-ascii?Q?xL/b9dePrGzKuf18RWD0eEswS8tCx8ujKlILOqEc+21gsNfLqmDvNBTnNfcC?=
 =?us-ascii?Q?vDT+Fm7RYqXNKpzGopBeC8C83HC7TEJZVKW+VIpFdJLh2VvHw8q0gK2d/yWp?=
 =?us-ascii?Q?j03vmsP7MId/yfCVwRtOuCjNSe9nlBOV4RDxNK3QP5291S48l/aLlyZ60Dpt?=
 =?us-ascii?Q?DpjU697Ban2SHIaahD8AeuABHPqCYZ4Ns9XWZkSIuiVtpXdkGtz8ruhfn47s?=
 =?us-ascii?Q?RcbtS+HXiAMeW2kRGUYw2F0cMf0Gfk4Zybalez6s1DPUYqa1lP90mn2LZTc1?=
 =?us-ascii?Q?CxZ/GJ+bcY+Y05AVtV/AuyOFw6huqRGgF+9H8xA+QthQd9fr7oAitZ0kA3dg?=
 =?us-ascii?Q?vO9FHzVgzK3NDJze+CQaEdicYjTBA2k3e8cVgYWDGaQdejnTWEHfCz4dKV4f?=
 =?us-ascii?Q?82syajJDVunPMxt11BSeZQNjSv/6LeCEzgUVCH/Y6865GExzZbBCi4hKuf5S?=
 =?us-ascii?Q?ViwLLbBGL1H86D1aZuFGtKc1gaWd1i0yVuhaDsrTVpzHcL8v+FTMeASKFs4Y?=
 =?us-ascii?Q?70Qelm7CHYzz/7UKNvAJQyWQVCKH/VApZNeg3x+kGUEliFtDefaCEnJR5zY6?=
 =?us-ascii?Q?0LFf0EzUzDzwens3yiMFJSDcj4GrPFzuvKmPuE369xCiyzUskk8BTF7FVaMW?=
 =?us-ascii?Q?Qt3qGfYyhh86bSIzMgnr3VC5f8tGSBByzM6CTI9tj99Zd1yBYzcd3LN/0I1J?=
 =?us-ascii?Q?LB9W9Oxovy7nu4rsFuijxUiS+EmCE9MZZOUvWiQGC8gb3RBoHrg5ugXmlS61?=
 =?us-ascii?Q?MRKgu6X7M+hKIWgq7oFYv+FwyNAgIzBnz40zm0qiS7/JPTb+xZU/n+cZvSap?=
 =?us-ascii?Q?veJ23pmdWp7YvVwIpgsgT0kS2niX7EkbTEwzoXECVf78UERLAdUcpSJ7by33?=
 =?us-ascii?Q?df7O4+yXACDt+5Ook2+b8bckxXfNTFIS6xHQzFiM6AoDVpt/UEa6Ojy6BqP7?=
 =?us-ascii?Q?cFI8wKfnkkZMDri3HrNzjv7DNB16KWG/BXblMTPRJBpPZcBWvnXCDe6TtSbp?=
 =?us-ascii?Q?KqchTaTKuGq8dntBq9hDxjD/kG9f8efMr5HmRYzoVN8HCRdXFr4g6q3PKLgF?=
 =?us-ascii?Q?xI1fn+cLb+u5DyMplZXLJiSUSxQXrISnGTtYz7caMilYfcz81YPiut61fj7C?=
 =?us-ascii?Q?R9x473tv/XUFAQZrDLVDGvbsBJyJhWBmGF4+g8lsFxRpZFjfzCNj0sGE/6nh?=
 =?us-ascii?Q?qkqz3e22g/lTvsx4VrF0v5gzpRltv0JMpYINKLiCMK3TyUCakHy31wj3iw8e?=
 =?us-ascii?Q?ZruTQ9qSNXNiUmMMtfSFNbQFgnq8EDQ8ujeKU15oHWdHfH5z5hDcR9VrpCXY?=
 =?us-ascii?Q?6OuSR8Uo2WrElXfygmf7j+Odygc8i9kg4Ize4LdUeNTEZEY+gUwzdJzsBxX5?=
 =?us-ascii?Q?cIhL4FcchORi02nZNzc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf73b1b-7bdc-455d-071e-08dbe0325eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:11:54.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o4S8qjoTrdGDxBvfY1wk0GefbiS5CfOGA4Z6svI7PO9bT4Z6TOvSrIcUgtjqO7bx3ErW3i0HrsygFubs9yuhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[AMD Official Use Only - General]

Hi Greg KH & Heiner Kallweit,

Sorry for the trouble, this was sent to AMD internel. Because I want to bac=
kport this patch to avoid a problem caused by r8169.
I forgot to clean up the sent object.
Sorry again for the trouble caused by this misunderstanding.

Best Regads,
Li

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Wednesday, November 8, 2023 3:53 PM
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Zhang, Yifan <Yifan=
1.Zhang@amd.com>; stable@vger.kernel.org; David S . Miller <davem@davemloft=
.net>; Ma, Li <Li.Ma@amd.com>
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems =
with NIC version from RTL8168h

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, Nov 08, 2023 at 08:40:48AM +0100, Heiner Kallweit wrote:
> On 08.11.2023 08:05, Greg KH wrote:
> > On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
> >> From: Heiner Kallweit <hkallweit1@gmail.com>
> >>
> >> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM
> >> L1 causes tx timeouts with RTL8168h, see referenced bug report.
> >>
> >> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> >> Cc: stable@vger.kernel.org
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217814
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: David S. Miller <davem@davemloft.net> (cherry picked
> >> from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >
> > Is this a proposed stable tree patch?  If so, what kernel(s) are you
> > wanting it applied to?
> >
> This should have been sent neither to you nor stable@vger.kernel.org.
> This patch has been applied to stable already, the mail is something
> AMD-internal it seems.

Then someone needs to seriously fix their scripts as it is very confusing :=
(
