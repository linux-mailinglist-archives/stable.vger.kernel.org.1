Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDDF741799
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjF1R5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 13:57:13 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:60769
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231787AbjF1R4D (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb0IK5gu2aSgIfm33viAWAScDaAztV46kSdtC+Y3zXWIE+dgtxdMIG8khkoDW4uZ8hnN9RyMdh8sCijmzlyGWINwO/1zODkto53KxjHtH5StJXFtIsieEhABLaawCDfW/Q9vRSBUBaH42FDF4rV01aBHrTCtUoPrhYLvPKjRBU9HVBARVTL6beQNEsocGkE2XfFHWYJjcjkYBZv7XZameUvZ9anoMOJZ3fcTACvX1r3C92QLEuu+ESPmsXGDZsR5NnVJ6Uzfw+WW5rMqO7xYo27ZFE4rDzy/d8agJCubcvOqvlRf21OXOe3cOgTiLbKsNtY+zFAPfDFVmnF4E7wgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHN5cqsjZq9njV0ZTs4zeKLC4WS1/tDk+DOaJ7MaYdA=;
 b=lmQu0B+DDYS8ncXZlCzvDUTv4WMq0FFlsAEq3T6edrWwAe0Hth2uqIgRyjEq7y9epXm3pzwzIC5OxrNohDDp3FWNClhn7iYfC9NUvlRwZpXpJatYy84xkmv0Tmebz2UvNeMEWWJHTk72JWvSNMQLRJwBjVK5CQFEO7dBduA8y1qIeKV4QZH9hUC12wlka1fjtdNR71GCfiLhJCV71eMgEGLieMOKEZKPIqEjqsvfnra6N5jqDiKC/w4UVT57b81qSUT05JwPjTQRmAXhOF5uyatHuklNIlg9/zCRAlA0vm0cAxguQgGCPHymunCr43PK62giDTdATH0Hyg5plJ6q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHN5cqsjZq9njV0ZTs4zeKLC4WS1/tDk+DOaJ7MaYdA=;
 b=1YJXyj2k0xWXkuU2qU3q+LBrfm2mEC/wQ1r5i6B4llbiR88iDNisQMlCHTD+SmZmbV6bPqMc2ruZFcpi0fzfrGuN+skIDyUqRqkxKk0UFGzdRBJdjYbuq/fDd003JdPxA0wOl2Ke5BBAd+haUugmG1aN3YOs1SxYO+eqh0ltO/U=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 17:56:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 17:56:01 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Regression in 6.1.35 / 6.3.9
Thread-Topic: Regression in 6.1.35 / 6.3.9
Thread-Index: Admp6aVRqmLcJDKiRO61Gt8yn8Y9Mw==
Date:   Wed, 28 Jun 2023 17:56:01 +0000
Message-ID: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d4150161-6d6e-44fa-8407-b94fa151eadc;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-28T17:55:12Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4250:EE_
x-ms-office365-filtering-correlation-id: 75b2a4ef-83bf-42ca-c225-08db7800ef5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bK8x2iAnrDtYm3zw2zj3zRW/NHPP5akaSIP7MhwOEnaVoBRVz7ZdKp4lNLlc8uLgrAuziZfi43XQqhADfIb43g4X1YROprPZkNOHEkqVYhXO+fXwumwr3SGbxMU9y8O8T0nhHHijQrvoFHijjfGcEiEOW2byxHkZmR1t7L3qYuXyrNbxcKm5wTgW22x53KNLBqajaooiqQg17MRz3s9CW5/DcBgjgevL1F/ATlje3sB3NzK3Xik5Sam02MRFx03DnTOLNQV9XU5/EXIYZdebNvVBJxdULjq2OB8z4qrwY59h2fEpJL5XEY3XTrgYmNdGAYaSoUnklekHuHriAU2WzxJYT2xVF8iigrDXD90anuzwm3FW+S0LSxE6ISUxgXGr6/ix8J05YFS865ExcsYEgTf+zTv/v9SUYtBPaC8xBjv7ypNGSxtyI6ZrHoryzX17NEGFAkPtPbmqes8x4Rc6+JRNb0dAcrBIPrvmZcMM3QWuMd+TH5CiepGVvcWsjoQ91Kpq8Od/ZUVjTKOLLNrYwRL7Ie7qzUi59HLop3rJIBs2OAUGkc/Fj7fhV3TRiVBXcAXF54jrVTz/6kS9KsQv+yh5XNfJtS2dviKDDk5nWD9nJvcysaGYa3HXGEGi7DeNLmDSjG5ZjiwgUhL+fS8wAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(316002)(55016003)(8676002)(66946007)(66446008)(64756008)(66476007)(76116006)(4744005)(9686003)(6506007)(186003)(6916009)(26005)(8936002)(7696005)(966005)(41300700001)(71200400001)(66556008)(52536014)(5660300002)(478600001)(2906002)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NZyOgEcdZC1sD11oVc6xqcjs9BTLSpN23FHrPqzIQ4Nnk5OiDV5Le1avM8?=
 =?iso-8859-1?Q?FCeY3D9Cf7POncEpa8ul4E7RT1nfYwRQUVBD9BaT1VdbTAJZKNeAj1UoS7?=
 =?iso-8859-1?Q?9mGWyM1pkH+0YEgsnUA23GvuVPMNhr8dj9F9V3NEug16g9R7EUabGiPuqs?=
 =?iso-8859-1?Q?l3VBNq8ULp43dIc9TYDwUFV556++Ec0Vbl1ONdTVGjghsmZ/GZHlPLgbNx?=
 =?iso-8859-1?Q?DHd6/pW5i89awZLB3bt1d15pxeC5tR+JokXanD6qN0yM4f5V7Aoxz/ZH6c?=
 =?iso-8859-1?Q?8w5ArVQMh4vygnxjwAHoBKGdW9Qdorw1ky2ANxRzsZmranT1+U+I325GqD?=
 =?iso-8859-1?Q?AyQDQXqcEAcRGuGYz+++wjZB31TeSSHd15rAvZ5Ua4tXiqzcchb8PP72N8?=
 =?iso-8859-1?Q?7v6hF+l3dVMv+CtyXATC0CZ3c3NQ7FQ9Hab5V98eqrVA+19VrUmBRz2GCq?=
 =?iso-8859-1?Q?zQxLXG6CEuLBWqg280oMeT5b7DS6m0SDTkpBfAyWBV1XUF86Q0hvWsbPuW?=
 =?iso-8859-1?Q?SWw7hqUz32XAW3Mn8hdBPc29kuFIywt7JIzCYzYcd3EoKi9TlgOY31aqde?=
 =?iso-8859-1?Q?YikyoHZ75hJqzV95fZ5L/hIWT0ZcOx1mM6CvWG+YH60a0soBDdlTIl3DMm?=
 =?iso-8859-1?Q?eewu1CEYiG7QTMYBxf4ysDsBFJBlQMEanN2I4TxzBQCwUVhj+lVpQ4Op0K?=
 =?iso-8859-1?Q?uB+qiZEQYoheaanbFc9WGI5x138xduD6LCwlRLoOjqVwfHnV7oAA4mN955?=
 =?iso-8859-1?Q?iVhD+hLK67P9CrhnWicgHKK5n3l3tUsrPmTMbZCwz3RzV04gjRf0Zbs4Vn?=
 =?iso-8859-1?Q?66YYLTt3N/2R14Q3XyKv2NUupZjJmoalVXrG5rckFZ8++cBwZf3Yir1+Ms?=
 =?iso-8859-1?Q?7B3djw3mMBL41qeVqpE+wrfmCFSSS8IFXpSKPsaluDCvbENZc4G8XgSBeZ?=
 =?iso-8859-1?Q?W6bGdxTs7F3zQAoU9MO1BGwaFlXc2q6FRRgo7mSYc5R+JhQSwBPJ6I1PNy?=
 =?iso-8859-1?Q?QcQWuDxgQjOkC+65Vip41MCX4B/mf3QrA4j6Dube+frf/E3Ucbt/cXUNBn?=
 =?iso-8859-1?Q?XW04x49pcivJmFXzaxG+Bkp4H3wwsM0DsTyO8VWLyfArgZx5ylmQX8gHb7?=
 =?iso-8859-1?Q?wdSSC4mO+YjS5d0h3YCdIQ1MvLvBy7knHicXk3J3Tn7LXsBxIZFZd2ixYw?=
 =?iso-8859-1?Q?L07ycwOpXxQt7yMw5EICdpbEbmHZjlxXfWyFfKs3K3zsmwqg01w0kcvfsY?=
 =?iso-8859-1?Q?+lgniPhIOQHh0jZNGGqeswENG4Ad7hgn3lobEThFFKVpINbybVhkTCJBYy?=
 =?iso-8859-1?Q?CdWqhjdGYiBx+b9idS8yFk26RRoQoMSo2Ku0fNg//Z/Bbt+8GfUuw4pCuN?=
 =?iso-8859-1?Q?/siqSgLM71xMM433CoxkuKzuswiqQl7P0nkND6EvMqr4oJMTC2Vhkm27Zm?=
 =?iso-8859-1?Q?Po95ikUWcq5HiPE2SebU5MPFc8lIzc3B7e6sRw1a7zbcODObdb9Do62uSV?=
 =?iso-8859-1?Q?PYEPT5UR5JlKNO2o12ewuYslExQo/DtOzZY/siVKcs2cvszC9ahkNgJEvV?=
 =?iso-8859-1?Q?wnyMwyh93H2lGT+RGjqdidL6iL9/ZkBCnDEoUkeZ4tlNVjmgT27WbPVDli?=
 =?iso-8859-1?Q?YUT1uHd6PP4Fk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b2a4ef-83bf-42ca-c225-08db7800ef5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 17:56:01.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tV3/56dK1KrHodfHdJS+1+7f6gPLrOcKm9mGoF1bpKLgXwNM4cDCgaJy7N5FqlNFvoweVsDWYZw6WOEHhvr8mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[Public]

Hi,
 A regression was reported in 6.4-rc6 that monitor resolutions are no longe=
r present for anything but native resolution on eDP panels.  This specific =
change backported into stable at 6.1.35 and 6.3.9:
e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")

After discussing it with the original author, they submitted a revert commi=
t for review:
https://patchwork.freedesktop.org/patch/544273/

I suggested the revert also CC stable, and I expect this will go up in 6.5-=
rc1, but given the timing of the merge window and the original issue hit th=
e stable trees, can we revert it sooner in the stable
trees to avoid exposing the regression to more people?

Thanks!

