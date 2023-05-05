Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D136F8C4E
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 00:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjEEWRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 18:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEEWRK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 18:17:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC64EA
        for <stable@vger.kernel.org>; Fri,  5 May 2023 15:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdeknTumcmCjNoiqYFxdHdY7AATCmhXY8Z7MO2kD8e6UEPtnDuooj1Nf8zs+ixhdfHjDVlnLPm9YL/zbiEoftazW8F2JbkcrAEGVN7En1SGDiWZL/Fu/QYOSywXDa7ojQlOuWXeABVMSFdWfzseTievYB0mbiJdOzG5Jo89EcLCJfIbaHsi+a4udXeVolMVrsxu3IZrZNPbOEGI5zNYmeTboDyYZMdi6qUGzkexPTXnYbB/PaSW986wAbAmHpYSU+S/sliR4X0fYrYJN5CZhXUpoevTyJS+cyMEPjazIippQUjAkKcBryv9Rx+llhJ1U1fN2j7Wk4+QlO/tJ3oXqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPgd3Ez4n8heaufJEFcxtJEW+E2cXaP0gp1KB/LA214=;
 b=XjutojxfOfLCOSi/BoiyqTZ8UY+WQNyO6IFfOwpDgAI+SQm99/WxoxPjMXM/RGQGLK4Dp3wDJ0lWxCWBKF7s9uzbUI91ggvqC9puk6UFYdGgqY1E/0TgFNLzFPCmS1W5GAUj/ZyaVHCvKinSwNqD51pG+ld4pJVSv+HBFVdS/Y60VJWPQ5E/ru6yQKu7mVK1bl0Y0ICby0nUWaSsEq2ECuGiJJBySTZ64ZbqQMAfCUJOUpdLgr3FqgoGqyBTs5Uzn9sDfDw3Ccq1GEV/4owERbE22w1a8LdpPOhkT0HCESTHLqs36M8g0y6iD7q2z8a/NCy9J36v1t8qud4kXxDFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPgd3Ez4n8heaufJEFcxtJEW+E2cXaP0gp1KB/LA214=;
 b=ryb+Y63aazVVjjaTbvWROEtiG63WX+0m98rewKTHGD3JeHul+1WyvVMfwMXIOHHdwidJT9lPkwk7b2ZvDt89eZ6Z6WG0/jtA/ueSVMXV0x8WlhlgTo2qS4kO+q7KfWtF+MsATlDHrnCvNF4jK11gagLS060j+GLMoW6hkcuQX5I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 22:17:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 22:17:06 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Gong, Richard" <Richard.Gong@amd.com>
Subject: S3 support on some GFX11 products
Thread-Topic: S3 support on some GFX11 products
Thread-Index: Adl/nvxx+Krpnq93Q7u3hNst46ORiw==
Date:   Fri, 5 May 2023 22:17:06 +0000
Message-ID: <MN0PR12MB610106E9988CC7FF8F0A95C5E2729@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cbb6a83c-efaa-4049-8c98-0fdf33ecb9ee;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T22:14:30Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH8PR12MB6841:EE_
x-ms-office365-filtering-correlation-id: 6e472477-9a57-4c66-7426-08db4db67623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4xanSuH/lWshpyG5tPUbt+EBtObN5Gm9T6Qxbt0Yi18pPAXbBL5UW1xlU6kbzBTEO90scOz0SCiEKRsDq7V+elgjkILReJfnouuQ4djr2sJhsdIC1FbpP8zANkY5RSn05dzim1fUxwCU5/wTf1aIWlub+VgDmvYMro9yUnBmk11h7g/qWW3ZN7iv9b2RrI+j/W9OOjuA0qtKkdgAVynxAvNORPGEFljQ12YMswYENsQtfRaLHWtyjZKJDItMA4pL83UbztFht7E4Bxf4PNova00QPHcmY8hNQBm/MGkg5g5bpjfGlQC6011VcoHvBX/B4b5N0zBvXsADN2Ku9+IVnH2Y6zw7KWMsp3rR8WmDTTb8R9XFS8xcVhUXNlddkjvubVZNaoxBsQq8kkJQhZffwcwNQ4T4+sYcFewNR7vbJ89yIxkUcj8/0d8R9BCWQE+kHzg/3ebaGi057XQomzZtLMYa/AHQa8nMgNNmrKp/hhDiob45K5cgn5VWwUqvJYnbM33Pvk3NpamCIoQyk9jAuTDWFJKjGy1nBhvn78xuDmKm+vxqF4oGe7z1aisFpydzuwYRtVe2GkiMrwncbNdpZILybRBJyrANPmtgHBxglKLfDmp48FA0AWbM4o7kX6o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(33656002)(86362001)(316002)(7696005)(66946007)(66556008)(66446008)(64756008)(6916009)(76116006)(66476007)(4326008)(478600001)(71200400001)(55016003)(5660300002)(52536014)(8676002)(41300700001)(4744005)(2906002)(8936002)(38100700002)(122000001)(38070700005)(186003)(9686003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yHN7LOf07hY7qgMMk6w09Rf4UF8gVVUJkTb+ZEDzpb19Hj52Kw49gMPYU+7Y?=
 =?us-ascii?Q?AX8iIV83ueaDJBVazQ31Y/RHI85UCaYzEs8Hs4VcRucLdwTWXzCS1aRbX7U8?=
 =?us-ascii?Q?Hmyu/SVjnJJPvhaZAggB769wADdp5Uj6Krg3yuBsMkemmtqygZHz19D4foyu?=
 =?us-ascii?Q?6dwg2FDO1he8CPSbnirfCQ9VsHhKOqKtbjzXBIVfz9/t2Fmzw2Oq3v2cMcCA?=
 =?us-ascii?Q?CWpOIove+j5GiPpymeQpkXqek437csIVkXtEJMCnaIL8UgcH7430r/KKuht/?=
 =?us-ascii?Q?oXc0mmHdy3tRiIbh32yPdluo6Fq6KW5yj/X5XI8C5JtKT6S+YPlN/I78ONqo?=
 =?us-ascii?Q?akl5tipXKuKFl4g+8ezqYxqkrEHOBv4TGghJ2CKlTGLJwDNxci/xwzOno6ng?=
 =?us-ascii?Q?qNZ0kZMHsznljopG51KnYLJAktGcZ/Mi9za0RZcHHu2j+o/jYKL6mKWHrlTe?=
 =?us-ascii?Q?kgGuKbUcIIUGAkYnyETiWjqZWVR5lUIS0YIF0vXYjVv1O6iS9ffhWni/rhb7?=
 =?us-ascii?Q?heihk5dvba5ZQcSSQKOuhbznQHBxMzLs7D/Jm5w2qh15gFxq9MzkryHQqsof?=
 =?us-ascii?Q?rGIbVBSoKKaz48eNx2AM5pxRkEJCu/+If3bDeZfYVFa9H2nrAS93bl1IAl0U?=
 =?us-ascii?Q?9KYtU8BMJi5sfWbdhOneoVmpOuz3W95iUFeBaHr/BVSg2CyyEEq5LBbT9snN?=
 =?us-ascii?Q?7DF1OadRiRdBfXYiKpKmHr8v0r15ECqVe2RpxWrbFvHSPESpBEiZ/jkOghUe?=
 =?us-ascii?Q?gjkiGOEfqi7XA4dEzBKQ9VYp6zcAPB4f64QlAlw2BNStRxSkrom4LXxk7qmp?=
 =?us-ascii?Q?YfdVRbw6KgP+Xy7ZNejAncy3h7aJ1acZY42TQEUq8zMBvtiKUOUDcEtxn4Ym?=
 =?us-ascii?Q?A1lPoSA2p5ZidqY5nWa48CGs7UoDjBkVBo/s26nsAZ7cwCdf14Rc22zm88Fa?=
 =?us-ascii?Q?q9ISaLnhqoPsYB0ohCJN8GTBUnYN7ylB+vZjjoqKjzELtHTsh3fONBhHw0P3?=
 =?us-ascii?Q?x1nbD7/Uy3eX+E7lwd/P1UPdpZ0JB8RNzJ7ZTfpOfM736wRevR0SNeH/TS4i?=
 =?us-ascii?Q?nSkoihTX0N/1xjWfSg3cBDIX5rZg5PlKu5tvl0/ioGwSjLvo5d2paGrm1DkN?=
 =?us-ascii?Q?zEjsYIBIzOp/q+wxSM16O4XzvZ0vzbAXe3z6UG4qztcM0EWh62ElpPmoZHq6?=
 =?us-ascii?Q?CWKn6PyFCQ1kdwyiNO0nRmmeEe+Tq9PfIJbA5rtKFeUGQ2kYRdBhDTQ69WDo?=
 =?us-ascii?Q?PnQwksvjOL5RZdpYj5zrr7QybH9fSxEpmHYRvM2OjhsWbIxyrLn7aTU1EW3A?=
 =?us-ascii?Q?/DUOkiO+oB086UnbzpxeHhEqlZW5cwz3fD8/Kt2+Tic2ck5pW/DZ2qcplQel?=
 =?us-ascii?Q?xut+GObBjN6vi8rwX3/d1odSIGKBQsgWER9/wPIDH7MQx+qP66KJ1dr6ABt7?=
 =?us-ascii?Q?Att4NzJ122RDe2WbkfqMTawnUOHzixgqJ2aToikREkNd3yL/Xly2z+X9mZmd?=
 =?us-ascii?Q?7aeBDc9e17zKO9gh3XcJS32+czCiw2A+PkVxszy5H8ZZhzspesy/8FxXP8qg?=
 =?us-ascii?Q?ZQbsvGPPHOiUDI8Gk+4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e472477-9a57-4c66-7426-08db4db67623
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 22:17:06.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pj0zb2IXDoue4ZM7XZfu0u0apOvbSjQqC3RT5h97mkOttJ28n8xFjnClhTCjHftZOZ/nKIX1fbe4wAt8gVZNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[AMD Official Use Only - General]

Hi,

Some GFX11 based products will have S3 support as an option, but to support=
 this some of the suspend flow had to be adjusted in kernel 6.4 for it to w=
ork properly.

For 6.2.y/6.3.y the following commit is needed:
f7f28f268b86 ("drm/amd/pm: re-enable the gfx imu when smu resume")

For 6.1.y the following two commits are needed:
484d7dcc709d ("swsmu/amdgpu_smu: Fix the wrong if-condition")
f7f28f268b86 ("drm/amd/pm: re-enable the gfx imu when smu resume")

Can you please backport them?

Thanks,
