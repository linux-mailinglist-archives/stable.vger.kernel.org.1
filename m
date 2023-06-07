Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8912C7268A0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFGS0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFGS0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:26:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747302111
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihbsktLXpbKQTaslYj13Q5ioPaS1hpG650aG9fzkXqMKAHCNJ8VwIts5pKQhgzZRbH4+UxuR5JpzGKQX47WSpBWx1IEFMLMb61hacIUxEQZKY9zRP/3Vfs/zhNHpNtsXdrX0TuTj/3fUYwfRTYm/HttSJjH1J6BjjEARNLyX+mUOLsr5hmoCkp6mYOCJ0iX85unuqCc0eyJimKYbva4nAYB+DRSm/MR/EZBVEs63nm1i+vgyabNsuWJKvHFKM2PbnRxhATKvDzNMS/qGkyCqlQpjiG6mZvUNbtNQ9waMCpscaq+SV+7lHFVIiRpa2agITK5s8Los390m/HwYwQWEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEESDYJtqFquVvv5Akql4QUOiC74BfYd9vxikDFJTMY=;
 b=dNSrDbTl6QRLlx1xMHEUsOVcUB4l4b1ML7AL8Zjk9tdRw9xtfrwCyM/5DRKhr/Tv0+Ei3xsWGekesZnIQm7lo5yU7uZ4P2QBvIAgYbkOz5iXR1dXDYB7iFrRCCDOTsI3yTtlnVdP/De7aipigAr19v7fHiIhOD/v2y3C3TO/E9XAhFGTpwOxpUB/LAKGX8gaOPwUT82ozfXnwuVvS07gLVVRcfUhySj7pViu2yZy4hJdOHtGWWfffqAwHmZHVFzPr8VvpfNunNrRNGUmqRoUZDLo9WgXA45hFKoAokmdQVjrxEtAF5LdLSG9kNkBVXigac0JkpX//+vZ5eqPXUqIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEESDYJtqFquVvv5Akql4QUOiC74BfYd9vxikDFJTMY=;
 b=Hbiw4+1tNlGxvTFxEp3ARABvfLs6/91vIjFQHVuMUUc7eabd6CaWQUSy4jIZo6nZ7aF+dDVD1zhASNMzU1eWKGaPUDINyjzTQsEvrdArmb3b1yAoTi8lTaRsam5MKeaJjutoqXstAaZg3k0Hmp6x6NL1AC7vBggL/TK5wz0CZNk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:25:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 18:25:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>
Subject: RE: [PATCH 6.1] drm/amd/display: Have Payload Properly Created After
 Resume
Thread-Topic: [PATCH 6.1] drm/amd/display: Have Payload Properly Created After
 Resume
Thread-Index: AQHZlW3ccgAqbG5SfUyUUc6shYFf/K9/qzQAgAAEgSA=
Date:   Wed, 7 Jun 2023 18:25:12 +0000
Message-ID: <MN0PR12MB6101C6CEFAE613E9BAB2D5A7E253A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230602035952.22551-1-mario.limonciello@amd.com>
 <2023060722-jujitsu-importer-14db@gregkh>
In-Reply-To: <2023060722-jujitsu-importer-14db@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9a2a6be9-4f38-4d15-be35-4a843b318829;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T18:25:05Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8283:EE_
x-ms-office365-filtering-correlation-id: be6d60a1-d907-457f-cf9d-08db6784885e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qTcDxk0IPWDEYJeYF9V3dLzMS6M08bifdy4ZFgnfHOowWf4hU8f47hd1jQJ9CXrh8x3eeXx5E945Sayhqy0evmFoqaNinOp2fexAzQn18lcD4Rb82M+vpE+Wn0VxooUo8Jb982A2Jzfb/PzB14CTvz0WnTOPYs5EVpjhDjuoHl7jkZGJmyQeohY/5d3etN32gnPfmtARteFavY5/eQk1GGi+YXFGr75Wi1fpPvTOeARVuI7kuYh9hezhmKR+S8OjocLN45QqZ5RyC7NyjNTUD+LdCiTCIwxXlPQOIfhaX2RXPnlZ0rtA75sKyN8vL67ugEoRlMwj/R1NKQyq9LbU9bDwnd+mxOT3IOud6KWCvB9vQI99QQwZaObVca5JGILXbgrU9poPtxFoXp+EhmCcyztrhtPCWnon/rixBRz1aVZJjW3r5HA97IKkCMhQKOTnu3mWY+0b/SIsNnjDJ9es+XSIfeTpxxNrwL6+1wlqlFmuXW3eQ1154Wn899iiC2A2OoV1pI2wFXrauDxWRXxcX4MEhjZvFacxwlT5gO+rzqAMKYLtGimr7s9EJA+jk4ZPOrGfOq/PV9QmUI1B91s9ChKankoQ/p5eUqDsgfuw4QiZXpKjLW+X3+oFgRTO53L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(33656002)(2906002)(86362001)(5660300002)(52536014)(38070700005)(55016003)(7696005)(83380400001)(26005)(6506007)(9686003)(71200400001)(478600001)(186003)(54906003)(66946007)(66476007)(6916009)(38100700002)(64756008)(316002)(122000001)(76116006)(41300700001)(66446008)(66556008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wpi3WkXYh4Bajt1168YQIfd0VL4DnQrPfZeU14M0qDK6ng+HLjKx/666L2Nw?=
 =?us-ascii?Q?MEG9sof47VaabvnXksqakjiDF+dZ0Z/YC4jnMr7FRRByy6G4atrM8eTWx9n7?=
 =?us-ascii?Q?A+AfGHTFC5LFZk1YsX7II/mbthLYoBcrhM/yo7kSk2Fj9dcgSXnoJJWuiJZc?=
 =?us-ascii?Q?O1Pez0kyXdTigEBALF9Qwg8ys/sIiA2wCOYVVtrUsQuOMYn2eLvXMgtDFDcG?=
 =?us-ascii?Q?OQx30mYmH58n+kbaAXEVhKhSLpw1yLXzazI5LlK63TLjCSLHy9noQf+WN1TC?=
 =?us-ascii?Q?PZDYa++zNZ6Vk3QZlJnNtjIOHA440grnxa8oi7bnTP7VoEw/b3lnLmbhU2x9?=
 =?us-ascii?Q?6DfWly8ICliR4CI4+GvnyCQJATJGH1NCpNBiH/klT2DJ7E2CsuP0aKuOMuBt?=
 =?us-ascii?Q?IQrhdIIqUhLHHTqz6oBW74cLhcTnYo7mhcnyKB78fAd2O8NLTsNSkSTjgBXW?=
 =?us-ascii?Q?7XX2dtOvRquwpGIbN7PoG4HkO3amrBMdTGW9cwFJT74VvZTbTohO1nGrLbDD?=
 =?us-ascii?Q?dWk3uSRzhcFWeFR8N8h4PElr1jhWD+opFtz9rmmJkULWscGS326m2QYyjWK1?=
 =?us-ascii?Q?6LIJTo31F7vOf/Hd0jPd5HAbdtIbuYxsqSY6U9M7z0QLjPBqk283VN6NlFVM?=
 =?us-ascii?Q?5uqMoEGMQ2V7EeQzx6bLwVexmMXdhBPTTPDY1nZBFs14ESSG2f9AJ0Vm6c5i?=
 =?us-ascii?Q?zrc4scxSfWh83pUSDb2vYuatLUEb1R9+fwpj2Af/91gxGAm0ZDJnGSDmsOBU?=
 =?us-ascii?Q?0r1hBhQymQddIi0qHXoLTUWjxXgr9AqbjvTsd7HfpPAcKtqnBwt1vbpXtaTU?=
 =?us-ascii?Q?5AMgazIPrX0BDhfyoEak90/q8BAC+GhFN9EugeX4pKl0H3HI1d9kac2aSoAb?=
 =?us-ascii?Q?pyGTBfUriSHEki+BBnINvYC6dgkNaDyqeniauBX8SMs1QVFeUQeQRdKBH5sT?=
 =?us-ascii?Q?Pyn3TvxTr1AlKrnoOWpvXNcvcjFWG/8TKwLTqIBz70O2R7TfpwnHKsbpGQaO?=
 =?us-ascii?Q?14NeL8sOUJqwcpPfSpgGjFGcMhnIz0Uzhpe8sgo37Z2GPgCa9QEWX4blCQMz?=
 =?us-ascii?Q?PMeXv/ZPMVgu1ztDReR4laib/tdtnMMnLgkjRHmgoEzrylS0mUQ44ct2Nf10?=
 =?us-ascii?Q?BtdknlpSvN/H0D2vk9Wv7bl+ww0j/zSFf/zJETEQZ0WWOiJECIaT4yPCebJ/?=
 =?us-ascii?Q?DOpKyyD9NXjy/0qkXcupLjQ1Os4dxomgbB4HuyBPh0HbVljLd0BYo2SMnHlK?=
 =?us-ascii?Q?79EBu+3z/kZ8BZFbHDnFSyyPkTskBvKPEfyFJ1UP2ARRJW6hgGHcGW8sBNY2?=
 =?us-ascii?Q?HQ3eefVUGZkeyIoxynoQkNOlK9q1lNLhnmFQ3oyItbpDrAE0N0Vik2FCPpig?=
 =?us-ascii?Q?ATczULygWadL5xvbH43Mp40h5Ly0HnWqUgLCgwG5gr+mH8V4x+VpJjMUlvG0?=
 =?us-ascii?Q?i9kAmbwRvwgGw7eo00Ap3RiR81M2pHqUaSIJ2wdwqyeyAV97HIy5jmekjHtD?=
 =?us-ascii?Q?t8DQYoZLcyN9myBkTfBuyIMnbrUDpHIFCkz1P3JucqEWo4y3U3bnNbH70KbV?=
 =?us-ascii?Q?jHygmZPvDIBTPRlBhZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6d60a1-d907-457f-cf9d-08db6784885e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 18:25:12.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccBtjYoekbyJC4rRFx40bBLPbwroIuTHVlW0GVzHoJSPULSCHYr3XCGuskkArZ+hS1qGFkuS0w5HwyQQ8w1ONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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

[Public]

> On Thu, Jun 01, 2023 at 10:59:52PM -0500, Mario Limonciello wrote:
> > From: Fangzhi Zuo <jerry.zuo@amd.com>
> >
> > At drm suspend sequence, MST dc_sink is removed. When commit cached
> > MST stream back in drm resume sequence, the MST stream payload is not
> > properly created and added into the payload table. After resume, topolo=
gy
> > change is reprobed by removing existing streams first. That leads to
> > no payload is found in the existing payload table as below error
> > "[drm] ERROR No payload for [MST PORT:] found in mst state"
> >
> > 1. In encoder .atomic_check routine, remove check existance of dc_sink
> > 2. Bypass MST by checking existence of MST root port. dc_link_type cann=
ot
> > differentiate MST port before topology is rediscovered.
> >
> > Reviewed-by: Wayne Lin <wayne.lin@amd.com>
> > Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> > Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > (cherry picked from commit
> 52b112049e1da404828102ccb5b39e92d40f06d4)
>
> This isn't a commit in Linus's tree, where did it come from?
>
> Do you mean 482e6ad9adde69d9da08864b4ccf4dfd53edb2f0?
>
> I'm guessing so, so I'll use that when I commit this, thanks.
>
> greg k-h

Weird!  I'm not sure how I got that ref right, but my local branch
recognizes both but the wrong one --contains doesn't resolve
to anything.  Thanks for correcting it.
