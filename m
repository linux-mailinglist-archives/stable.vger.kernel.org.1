Return-Path: <stable+bounces-158487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC62AE76AE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6717A189908E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5E1D6DB6;
	Wed, 25 Jun 2025 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cwi4QrPi"
X-Original-To: stable@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021084.outbound.protection.outlook.com [40.93.199.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A9367
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750831530; cv=fail; b=HDsi3vf/PdmYvESSfcBWVjOR25BoVlZUSPc3khA8BbNE/CRnqi+qSDPKTsc7ytxrDTCfw3jzLUp9aNJQef83PzP4Vmj4aY0WJUOM6XMl7hJ1xPfJJNkTyXLtapUHe8HL805alGbPrTikxpZUKR4Q7YlSBxpBhcxy4triRXniK5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750831530; c=relaxed/simple;
	bh=XB/axAAhX0wlHx2h2Kb/VEFQItjAUcxsgg0kQQBPAqE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hns7e+WGrYkpwFOxruStCPbaLyT8gkPMBGhR50yYZNnI+oTscH4icYtCerQgZiKzoAnlCg4/uZfUpkl54dsQqV9r4thvb85EBcpNu+SQPRIkfEGcmRVtt4Mxl+evghd6GBVcXOfU1T0wLqByONzozg5VhnZ8bPsKGkk4DZ8UgNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cwi4QrPi; arc=fail smtp.client-ip=40.93.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiWvKteNfVbJoklb7I8dHO/+s212LGmQowJl+Shrj2yqbpvkBTKfUOVU1QdjkJhFE4wFiFpNQwdcTWfqB5eL7XzBfVXHZ98lx7nMz9C8BTi0Gm3sMconlYZvf0+EktfJQdf1S0p35ri5kGO/zuHWQaOn2fOUuhbBgvAfeA4zWOKoFy4U3PrOIsd71TDmn1uEnzw8RLLwGYo3wP9kp0O64ckGrNIMgepjkrYA0osMcRsu2rj5qTSf9ky2hbc6MLh7QzwUKt0ayywWqj/SxgVH1h92X7gp/BxVwzHRePW6ddQb2ZGq9/ZgQ+ZQbRW9BQBx4PFkoCu5mNc7wUhoKE/uKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOb6wEfEdUqtRsHMgOyq82n0d5Cl/VEtx2xlJOZw5RM=;
 b=W85zuMrxBHAmDoMzAZMGoXVxMqa2T6PxR3XmwacjAmkH3qnHQlkP6ZBMiaB/VAgUJjHveHwFuW3dv9wYdAvqeEbCx8BsfepGesPFpDVqDpoTy4npG/Ju2qzBEqs+5q2QfAgPMpF99F7QrqP0NVMN4sZWxNNFRvDxsOR4az2BFsI9mXHyVrXk32v0czm2Lr2dH7cyDQBC0mXxoF9ZOm1/KBiwCXVmWaxc4UCD4ezJRZwkMHFzgOiROW1X0My3OYh4K9OvehEhHuFN2XU1ITIt5I0jH+9ZTLeHkrIdmxNfJ9nbuvzqbueX9emzxvHQRyiMDOXp1yY00OdZEFpv1YHOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOb6wEfEdUqtRsHMgOyq82n0d5Cl/VEtx2xlJOZw5RM=;
 b=cwi4QrPiVQNQsGPT+A3peysYCxTqT/yJ+l+auz0IL0WaZt9tMBBfYGZ872yrfz6ujWgB/JI2Myp30IsrUL54hNo6GJD/rDbfK3GyIJZTzJ3FXttngNq5gsbJ4MDZJtZfr6ez2R826lg8+NTZnsjJq+/GizxHWBpKB/u5qKtfyL8=
Received: from BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15)
 by BL4PR21MB4558.namprd21.prod.outlook.com (2603:10b6:208:586::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 06:05:26 +0000
Received: from BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79]) by BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79%3]) with mapi id 15.20.8901.001; Wed, 25 Jun 2025
 06:05:26 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Stable <stable@vger.kernel.org>
CC: Long Li <longli@microsoft.com>
Subject: Please cherry-pick this commit to v5.15.y, 5.10.y and 5.4.y:
 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time")
Thread-Topic: Please cherry-pick this commit to v5.15.y, 5.10.y and 5.4.y:
 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time")
Thread-Index: AdvllVoB26Bwt2gvTKGjPCsNTOJcQg==
Date: Wed, 25 Jun 2025 06:05:26 +0000
Message-ID:
 <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cf15493c-f3b6-4fe1-afc8-f6a5b0e69b78;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-25T05:49:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3115:EE_|BL4PR21MB4558:EE_
x-ms-office365-filtering-correlation-id: d5e29e87-7548-45b9-59b3-08ddb3ae4774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jkylPWWA+SbYhtWqNC8IH+R5sZKZ4dtFWBvQU4JM8+lWUeod9D2XFpzFmH6Q?=
 =?us-ascii?Q?MhHHSvo4bXGGphubmIhMYgDp8KMEU1rIvrTG8RV1jEDfwBXGRo5e9NnxHRxL?=
 =?us-ascii?Q?LAgfUj8sn50MusXAVYEzLJ5jtFlRmw0J/92+J+SxN8eJKfsZKU78fpDVDr2H?=
 =?us-ascii?Q?+Qsj8Vpf+cvyJJm9molBKRZzsET7i1Tp2c2IyMPeEkyOb765CvTnXPsue5jD?=
 =?us-ascii?Q?muNPzIXD7WpTP69Vnpk0yOfq02Q77GXp6Juk4H+76ztJ8SlXNtO7l0vnx9cH?=
 =?us-ascii?Q?ylPR4UgPQPA2Jgw+lwnWSOL00zHdMhh9hHrRifOObJC3YOXttoexHuuaC1Sj?=
 =?us-ascii?Q?AVp/SmN8qgYnxtxDgbD09rRBXGS/+5H8ZMs7vqmZyZ7qPZuWRv+heZkjP03R?=
 =?us-ascii?Q?VHsYXgQOGjMTfSpsLQ6v90XpWQjSvYlLyYqSGoB8Hj6rlHoMpMOLtG2DYrNf?=
 =?us-ascii?Q?sd4aR18/TF6jh2qiRjkDq9K9+IQrF0bvTgBVDJvFl7Rb0eP2zTlXyscMxQ+b?=
 =?us-ascii?Q?WQmiEeCmZa1neJosbcOQUYx2rGFAOQIXIe1KAHcqiSQ/AD99Ohz3pm6AxrqJ?=
 =?us-ascii?Q?xtLaXsXipt41zr8xsxdwmsBLaZHLsOmxJ8+ieyZjTGyWDH8D8anwdLqhYKBV?=
 =?us-ascii?Q?P2jry2L2uK9EvjUaHoC7vQGcLHjqlxKxwCfbHx46vUDACzti3lHyYHIGxIyB?=
 =?us-ascii?Q?lxrsltdWb1bbVP7U1gh1oW+AUKfvjIkfr0LhUOg19qS6T6w8ELMwDGDWHh0a?=
 =?us-ascii?Q?n2zsomTmsqixMxa5PXyc+RoPAfkXiS5Fe6ttvYuNEVypUEQqvPDFbylQ4Oly?=
 =?us-ascii?Q?HIi9nvEZMImHLY5XD+60F+lgw7UvdRmRUMIQRZZ458bNXSNm3Q6TekGYDNeF?=
 =?us-ascii?Q?/HlxByWJPp3hjnX4Q7ORsfx3XIHeZu4dmubQsJLiZ+bYTx9KJ04OY3uKO/2s?=
 =?us-ascii?Q?I2D9ED+CnTOAvA2VxhMhuGzlJ/7OQaA+999gSrYLNRnwX4OL+UkoHBgXtLtI?=
 =?us-ascii?Q?soTS2zN0/3coRNo/AcqrjsR8HbQI7T+5ZmTq5UDplXiosMdHk/sqbxe5SPme?=
 =?us-ascii?Q?ovd8oODxzfvUtHqadrtzbUK54h3u3FwgRVuiEsiHN2tlw7eiQT7pxmkRGg8J?=
 =?us-ascii?Q?vlkLnzYFHTNXS9Cku89DvtHwjAZFm6PN3zC4bTKDKf3d2mw7tUrQMfUbqAKV?=
 =?us-ascii?Q?sJCNwjE+n/fYcUsRhrTguDF7px2AeMPzbxVn5Hh9OuLoMwSuImEnuyhW7WDV?=
 =?us-ascii?Q?HNUzRSiOasawJWoJpr+G/eN2wSiRg9zn9pm67PygQlW3zvi5XjVaT4mVDM30?=
 =?us-ascii?Q?rRP17zCvRm7VkTW/aZr188ibYLaZ0PUIaSfUhUdeQi8F2mu32wGzi2itmSq4?=
 =?us-ascii?Q?ZdY5MQsOOpY9kWMYoClT9+DUc6ZUbblNDEMUzD8ITCpnsCyNqs8INQP1zHR/?=
 =?us-ascii?Q?pi98MFBIO61MegkK3spC5Uf8xwC0ccrgMxQh+M5vo3pUZuWnrcyTZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3115.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1ODOHcW9/WbULHES727ib/P809Tv8f3cl/S3zGm0Eqx3pPlvUVCYFTY+NcaY?=
 =?us-ascii?Q?qY6dgPIRZuNBfFj2ZL34FACsQTe32QBRZ3cBcJEgVZ7Dnhs8r7zbIdDmfhnh?=
 =?us-ascii?Q?toASqdM1GWHIfPLZxZq+H6pky27fUr9WViXQjGMkW+tFuNo0ZRyscQDJUYAJ?=
 =?us-ascii?Q?gsNeoNhDlpD/HbWHD8fh5y0TuIdFo4YwgG9hMLUQfINY2aL50u/tFxB5oIPe?=
 =?us-ascii?Q?9Nm5/qW/Qg3TjOxdQwgqDbfmJax92NPpQ00GHAuWX0StLT4XY9CVPMm/1/1P?=
 =?us-ascii?Q?jnJnvua48jp9q/ZWT/gBRhcgZjB5FFZHECaVspk6uabJZFYOO/BpW6fHtcPb?=
 =?us-ascii?Q?6pTBH8yGpguwIRPZ9ume62vxXllY5t6Vc/9ANN3c3UGziRq+x2sUKjYMOlFk?=
 =?us-ascii?Q?UHCz9tXQE+kcoMmeR2qVI5vAwI/60dqHzBFAp2+YwfK5HbDZ314FvMkAqlzP?=
 =?us-ascii?Q?VFbzZ6HYhy6CkB7N+t1HU0CStCUr4sEuadlMGEtVAVzbPkiPlXJKMBFEOodY?=
 =?us-ascii?Q?PWHZpEq6DfhMKc4RCmHDMhJ9Mj3zzy5d1m5JkW8dR5T6qKdkCVMRcCs2k3rk?=
 =?us-ascii?Q?91w55dF67VOkIWuflrN+1vPwDBqNFQqIUiM6Vu7Ae0dpsknbPw3K0C8yhDGZ?=
 =?us-ascii?Q?sNgQquOu69pMcJ/yy683P3OSQhJ7DlsX8nkvdtQOeh5NfFkrvHEnwkKQrpBp?=
 =?us-ascii?Q?FAtWF/nWdPH22IF5atvXB8c6skxfWETHOgEhCri+QOUA3HmcPtxCyUl4NxD8?=
 =?us-ascii?Q?JbArmusN14uyqsR13ISIZUZJ8Q0gb7UMMdqOTvl9QfRBKXbLHdjN/Ai111O8?=
 =?us-ascii?Q?7gO1LyRhlvAFz7uaDkkL0oVcW53HmWCZ5ar5RjEunSoXtYeXgKFKxJtwDvY0?=
 =?us-ascii?Q?uox69uV0r6tmxP776bznv4twCWQbX7MEWi3l74W/JoJE/uwlJ91FQlB0TXo7?=
 =?us-ascii?Q?FUhLTvhCBEUKpCynIv7flUMTgRfmWRM/JhhI2vXkXUzulDfiQtkYOCvk5/nh?=
 =?us-ascii?Q?3TEuHw35F2MD+pVRQjYKN2Tt2Heo6ILO2aA2lrlXw2/v/ZHu/N8iaQvQqY2a?=
 =?us-ascii?Q?a8L2UssGxVoratHYA8semi326Uzv650EZRnN2zxSbHMZ0FFaK6Lt6ldX8qY7?=
 =?us-ascii?Q?Bjp6vHxLJK5XWrJm2s1R9BwYLqkCJeoMFRorH4cdehHSqlkrH/LWY2z78oak?=
 =?us-ascii?Q?6n1Whmx/e9Rs6OKF0AGVQOCO5/UrIy3/Ct40mPUq6rUD7r/o1YHl+lhgLilL?=
 =?us-ascii?Q?L4y+hHdCIy5nX6YRi1eLMiSMBNXwHqWhQuQEj5OHJulySRvaLHUomAxP6kmD?=
 =?us-ascii?Q?3v/soeIOCp9euVUKmN/bdQtwbXTQPuQ4yuGjvWHQnqoBn56NgtYk41SsryxV?=
 =?us-ascii?Q?RqZ46xZ26ToFSOcGV0rAX1ylOB5sHVHyqEkOAAhmzcBGO+qQjkaF9ZwdV2b2?=
 =?us-ascii?Q?wGTa6OaSOHu54OnyXEF+uzMxLVvdH611emw7Cxdwjjg3SLEcKF6W4j+bWxIg?=
 =?us-ascii?Q?fVZGDULf/z27qY2RD3SbQQoBteTQbHwsOgiFkvcPIG1jJWFVsojD83BJMN+v?=
 =?us-ascii?Q?mm3Xx+C/gBWuPVIKBZuaPCO3FFokoAofkrYp4wB0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3115.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e29e87-7548-45b9-59b3-08ddb3ae4774
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 06:05:26.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XR2MVK1HQ8Ex4kD+Kg94ukJ8O8/fk3DJfGG6kU+N0yyBmrWkuwPrK4dzCiKYAxmsEqTDTtcqZepsQ8Zm3pwdrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR21MB4558

Hi,=20
The commit has been in v6.1.y for 3+ years (but not in the 5.x stable branc=
hes):
        23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM =
boot time")

The commit can be cherry-picked cleanly to the latest 5.x stable branches, =
i.e. 5.15.185, 5.10.238 and 5.4.294.

Some Linux distro kernels are still based on the 5.x stable branches, and t=
hey have been carrying the commit explicitly. It would be great to have the=
 commit in the upstream 5.x branches, so they don't have to carry the commi=
t explicitly.

There is a Debian 10.3 user who wants the commit, but the commit is absent =
from Debian 10.3's kernel, whose full version string is:
	Linux version 5.10.0-0.deb10.30-amd64 (debian-kernel@lists.debian.org) (gc=
c-8 (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #1 SMP=
 Debian 5.10.218-1~deb10u1 (2024-06-12)

If the commit is cherry-picked into the upstream 5.10.y, the next Debian 10=
.3 kernel update would have the commit automatically.

Thanks!
-- Dexuan

