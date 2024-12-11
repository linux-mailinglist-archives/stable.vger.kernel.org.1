Return-Path: <stable+bounces-100601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574CA9ECA28
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C59188B2FA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642501A83F6;
	Wed, 11 Dec 2024 10:18:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772CA236FA9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912315; cv=fail; b=WDcZXDwGRBnkewR75LSNJwL0MvRidg6lDRMMiNmk7K5c7eby0btNybkwOJ/tozpRcUQ8o9Mq4Kr6KD7XBjiOZN4XZ9+ej3iQa4PmKOQGyPKHXXwC6tYdl/eI6OZs+7qtwShQyTAMVTHy57KQ2/47GfDE4TMA1iDgeCIO6ygW3Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912315; c=relaxed/simple;
	bh=jbmgzOLMCzYbq3W9Bs4J3ft5CwI/sfOmyoBw37+g+dY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c0NRceDsrPyUwlt4BB1xxNLdd5hifAOE+jD10AEqOsOkedEr56fbYPeX27KcBbvS4NYcU33y0FzFklgWwYONY7uUG9iCUIHQpQ/bQoDI88S7MB3o1hFodUQdobXAGn3jEiYT9Cyv9rpAYCIBn51aRSrqEDN1tBY0gJmxUyXAZkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5K1kQ031960;
	Wed, 11 Dec 2024 02:18:25 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u41ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 02:18:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjaTpPDR6yS0n0P/iFH5G5BieXuHqLBobaGtaLZoZuGLOL22vZ2SactYlompuaIFcBLLoX3T6xho2/u105eifLwSDQ3q1rs2OCMLp2at//pCYlUUySaiY5e4VceuvSUoHJmmiQbzrhqvmNRV7udD3Le3wTT1V2tiUSq8Ace5r6epcRyFFa60FHZbklL0iIrm3CybYypsdxFDKtr0cC5uWoWzQUqtSK0/p5x/Zm7oZ6hfNCNOqTpx7J8E9Y7xzH8Oa6ZW6EfUEzuAPUOb8Z9z5wc26D5NroXjAy+HepQs0SLb5jtLN+zMexYHoJhrO5jYnkvD6DGUc1cNUggU9Og0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnxHbuEYgRzK+9lCOAy4hugQ3sokb59D+CAO6AFNKRY=;
 b=b8glcCwb5EqlycBajxo7nMBI9KOjmRBObtH+xdYCdgyzed0PMrtvwmtte2MLDyCSOdrAafY5HV5AZ1BlW9Q0Eyoebz8gDVwDc00umwDkiiYc+HgBbB78NwufdVtO1spoO5xVzCj5b9i8lM5L2Kr5lPvi6jIdlvgzV4DEdpZrqV6IUPWzz7n/pg2k5fZ/B6o5+YLTZzXJutFXarwbNRi73g0E6f6DChdAPlV3N7TBfsRrsDmJz3GNcKgCEaoL8aVKSe7KKKjZeb+EcCmUOq9RwlO4pFDup96hHc0xmWSiUutd51r76Re+g/l1CEflIme+FK7dTa3TsEUShm6HdGxsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 10:18:22 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 10:18:22 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, mschmidt@redhat.com
Cc: selvin.xavier@broadcom.com, leon@kernel.org, xiangyu.chen@windriver.com,
        stable@vger.kernel.org
Subject: [PATCH][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Wed, 11 Dec 2024 18:17:59 +0800
Message-Id: <20241211101759.3534900-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To DM6PR11MB2665.namprd11.prod.outlook.com
 (2603:10b6:5:c3::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ade351-0315-423e-2d06-08dd19cd2413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QUOjL11uGu/R3ghob+dgDS2PBvn7X++0qhTI6pF3a3vbbNblYzDJhS2v1ct3?=
 =?us-ascii?Q?6stqUj9rrHGrSI6wwrDDV9kEfuvKN3D1MRqbeMMonTk5U+LmgTp0wFPcTc+4?=
 =?us-ascii?Q?IVzW7KslctLG81gQN5dyrqXmuxe9efPxqFvoldbJpYgYIyIe5aGg+b8zJzUp?=
 =?us-ascii?Q?tHtk119l4C6gmJYmQ0LEqfIiML96qwBOSmj7u051VidPaQGbHLxHP3Eh/gi5?=
 =?us-ascii?Q?U9521+S6fxlpExLVNbLdpLgfud0DEw2b4Yj6qpGdd0++R8SEPJDhjXWcVCs7?=
 =?us-ascii?Q?/IOE/Qr0BXg3P1WSWPMSJib9qDnriJuWdu10XsEY2yenUpfPMGTtGIow+Maw?=
 =?us-ascii?Q?c3d+jLi+nW2Um7sO1pCgqStuNUfILhaxsyyYUO1G2b+COzK+15cM1WqhFeoq?=
 =?us-ascii?Q?iCsF6bGBC+sYXalVTIl9EcS3V6TgNlvNi9uPCeQjQJjvwhqRnTcCbNrUy3Sf?=
 =?us-ascii?Q?pgHwmETksGJLdlii2QGajj9iVjPJRDZny8TWCDZc6hPfwkoATXmhvT/HNMpD?=
 =?us-ascii?Q?wpXsSHzQM7GkC3v7Mn++9nKQm4eHkRAYYYCijLt5A0vPBsUdXU9VNSXI/yyB?=
 =?us-ascii?Q?27QUpy9F0cCTJ094GdcqXrC5uY1bOdYtByfeXVRqt/o/WSCPaxlLQORLljWx?=
 =?us-ascii?Q?xwV2y/pxhN6ON/ieIEaVKN476mqMg/WgFSt7Clows9iZyEcgC3wXN16urlSL?=
 =?us-ascii?Q?4LgycVxMebynk/xBDqfzcJBStdpSoXElhsL8gQy4T3vqGIUKFaxU8xu2Dd69?=
 =?us-ascii?Q?6r/KFVItDtUx9cyumRuK0YZK0A4FWcY5vmHPr82TNkrIADiVDT074XfaTt9n?=
 =?us-ascii?Q?F9D2YiXjncPp2uCSlz+NTie7t3ICZaiLf8oEJKWIo5oa+HqgPE9jn4zH+TXu?=
 =?us-ascii?Q?d8ru9WjTQr9+DSZoZhVSOeNp4aWbwe7XfekYFPlH0smF3NqbvM5ZdRQV/iQ5?=
 =?us-ascii?Q?jb9KfLsUqnYzuPcTInVD4EGaQVMN5yMSWMwNseS9kySv81WAlH6ePZMZEKUw?=
 =?us-ascii?Q?PUkLlk/w1TXv60EjoEA3fa8lgZWUuJuxgoiWTE3I0De5moqeN0uqBXYMphak?=
 =?us-ascii?Q?jXf9oAxBbSiRC0Dt0QYnhSdokY2gsfOZL0GrDuChrPx+6QD0DiD5Qf0C/CYs?=
 =?us-ascii?Q?MqxvE3XsPUinIXMYU0aJe/8SeHs4DhxMS6Smq+E53QBVEqNuNqXxeNrI2W0N?=
 =?us-ascii?Q?5NefQ2FjW/CxmiUpsiiHgm7nTW2YMqgX9qI+6Msc1SAtC6582KjSZsSV4TN/?=
 =?us-ascii?Q?U/NKgQYAIiCXn4FhZibhpom9MFJZlS9AHUBNl26wi1rH7gOkVcPM+JVrqOQm?=
 =?us-ascii?Q?t0EwLunnsel0AgxSFf9emSQG2eSTi44P8KnTwilP8Y7RAh4jaAs7vHRL7yNe?=
 =?us-ascii?Q?m+TEdzQ75cg0EQ4koeSOMQ+CzNzt20QvV8iwQKpat6yK1lm1GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNd+EsauOe2KcwkiQglDZNVUgYkb9ORURvvvoq04zoT0W9nHTNEy9mULBVUD?=
 =?us-ascii?Q?jhcp+qfYedZ7S0sA1oIos5QSUeKwD31O1decj3JU8LZ+HX2sKf60P1crPrlH?=
 =?us-ascii?Q?l0nyHEFJn8+VR9EP2FJ8+0pD/R3XNNBs49IXoKpKEh8FSFZIxuvJqPKJf06n?=
 =?us-ascii?Q?f1XPk6iKODRZa0ic+bCE4+OaieOUIfFfhZxQwn21dcFJtjar60nPlRaz2N0+?=
 =?us-ascii?Q?MJsKbatCO2V/sCwHKdqyvc1h7ovMCqSC0/IBSnWCzi+a4gODeuvSydISjr9P?=
 =?us-ascii?Q?5UC+RkTV+RWZjN/3DG9/4vXI6FLqreCGzT4y4wBLtX4NLTtTA9aTEcJe2wsD?=
 =?us-ascii?Q?T58WUgm64B73CqM+jM0xqJHMCld45R8FmynbgfARM0wM70SOOjXttxauB6lf?=
 =?us-ascii?Q?2viq1CSE+z8AA51ro+Lsb+Mx0hRHM5TY+4cOK9yONKVZnK+CVEaWOcGqCkj8?=
 =?us-ascii?Q?Od58BXga9Ok0+lYlaYRsEhDShWJZBB3Fv52Cg6+khSKXK4Rx2XiCtr0Vfuw2?=
 =?us-ascii?Q?s7PNKGg3/d8MyEMrNFCHRm9iuir1IGJE8ncrUnb94CDeNkqlaXJFI6X+xmFj?=
 =?us-ascii?Q?BYpdDBxYAcBPTmU/OxGn5QEKpA7fQc0fMTxIYnbkTCgMekQSL9RK4Dn+O8B8?=
 =?us-ascii?Q?RQYBZdOum5IjlXJw+W8Es7hmBlCODwy2X3SLhyYpgbGOr11R9xzxVOBdyziO?=
 =?us-ascii?Q?AqApKTzHnncVo4RlgqnCHrBXRhtlzgz0lPwP7MlpaiDYNX2HbzR6jGtbwQM7?=
 =?us-ascii?Q?nGnvHGwtfdG+7OLwIvKDPNNGI5m+ZBPawxDPp2OeLjnWrSNIoHMKivCh9y26?=
 =?us-ascii?Q?16JOoWIm/P7IQtaUpafM2R95gnYLO3E8Wbnb2704dmWNRNGHDbOYHWkH9k0m?=
 =?us-ascii?Q?p50Zeo9WyPsE68M2UZGHfGkUsKWniXoaDC58lGf9a2sFDU2FPSBkD4J2u+xN?=
 =?us-ascii?Q?R2HMibzeYMPYLQCMm4jowVCeInEG7DBz8A22FCyVfsh7mMsoE1CYpYXjNeWH?=
 =?us-ascii?Q?elSV+ZL6EVgh+CZSHJNrl8DDObWpHIlZ5e1uKTOpHTI9ImNw8HiKhzJRoVwD?=
 =?us-ascii?Q?3ehLDIiOJso+4kTUidDkrlMIU3uN4VV0RvoltR1CteLIzPguFLKg/0jqOg3Y?=
 =?us-ascii?Q?tbgzR8/xqAUkGELmxR6/nJLecg8mtnaOF0TMi3OC82nwKWtiyT2VWvc28mHu?=
 =?us-ascii?Q?O78mR6iM2KPfOxo35aUmXGfkBumTu3o+YL4CfyrUMjygtkJ3dRJa67hBz119?=
 =?us-ascii?Q?eqqHG7YcSaACqFysLP3ZyO7bc5MexjhvOb92rWQ5Yt6Vx5L+GQcWNBjxbhfS?=
 =?us-ascii?Q?uUX3VJQmCWAtMTF/ci+SW4vTrdzixhB4nyDdOrUro+M+VimGWtPV3BjLnvLm?=
 =?us-ascii?Q?Nz5bIT/9Gm3FWpKKD813nzlmhyp8kjzsFAT36kCyBRN7H8GIzkA+owbvqMNd?=
 =?us-ascii?Q?BrINCRoAKA1OKsxqXz/QkEKprXM8+KbEO4FGkeT97N13XFF/yFku0wtK1SSx?=
 =?us-ascii?Q?8OQ76beolAe00gtSAl6617ZgQvKu1iRTEb7aE7ByrJGFQ+Pl0j5VfqCJqWpd?=
 =?us-ascii?Q?xRGsKB4tK6rBx0LqebEko7S6NVWqgQ2H5xT9lyjop5glrSZn4mn2yrIzBTXS?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ade351-0315-423e-2d06-08dd19cd2413
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:18:22.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+uICh8y/+WqcfyAlKLnrS2z8H2dxIdu1DeDLNMhQKq3KwaY50J5xoBCpOtUaqHaji6KxbJiI1ALb7cbjXs4hMi1Z6fBETaa8CLW8x16INM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=675966f1 cx=c_pps a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=ELwp5h_-rpATTYAfa6MA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: vi9MaztTxRi5mQU4TtZkWJZPgl_D8FDY
X-Proofpoint-GUID: vi9MaztTxRi5mQU4TtZkWJZPgl_D8FDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412110078

From: Michal Schmidt <mschmidt@redhat.com>

commit 84d2f29152184f0d72ed7c9648c4ee6927df4e59 upstream.

Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
roundup_pow_of_two is documented as undefined for 0.

Fix it in the one caller that had this combination.

The undefined behavior was detected by UBSAN:
  UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'
  CPU: 24 PID: 1075 Comm: (udev-worker) Not tainted 6.9.0-rc6+ #4
  Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.7 10/25/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   ubsan_epilogue+0x5/0x30
   __ubsan_handle_shift_out_of_bounds.cold+0x61/0xec
   __roundup_pow_of_two+0x25/0x35 [bnxt_re]
   bnxt_qplib_alloc_init_hwq+0xa1/0x470 [bnxt_re]
   bnxt_qplib_create_qp+0x19e/0x840 [bnxt_re]
   bnxt_re_create_qp+0x9b1/0xcd0 [bnxt_re]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __kmalloc+0x1b6/0x4f0
   ? create_qp.part.0+0x128/0x1c0 [ib_core]
   ? __pfx_bnxt_re_create_qp+0x10/0x10 [bnxt_re]
   create_qp.part.0+0x128/0x1c0 [ib_core]
   ib_create_qp_kernel+0x50/0xd0 [ib_core]
   create_mad_qp+0x8e/0xe0 [ib_core]
   ? __pfx_qp_event_handler+0x10/0x10 [ib_core]
   ib_mad_init_device+0x2be/0x680 [ib_core]
   add_client_context+0x10d/0x1a0 [ib_core]
   enable_device_and_get+0xe0/0x1d0 [ib_core]
   ib_register_device+0x53c/0x630 [ib_core]
   ? srso_alias_return_thunk+0x5/0xfbef5
   bnxt_re_probe+0xbd8/0xe50 [bnxt_re]
   ? __pfx_bnxt_re_probe+0x10/0x10 [bnxt_re]
   auxiliary_bus_probe+0x49/0x80
   ? driver_sysfs_add+0x57/0xc0
   really_probe+0xde/0x340
   ? pm_runtime_barrier+0x54/0x90
   ? __pfx___driver_attach+0x10/0x10
   __driver_probe_device+0x78/0x110
   driver_probe_device+0x1f/0xa0
   __driver_attach+0xba/0x1c0
   bus_for_each_dev+0x8f/0xe0
   bus_add_driver+0x146/0x220
   driver_register+0x72/0xd0
   __auxiliary_driver_register+0x6e/0xd0
   ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
   bnxt_re_mod_init+0x3e/0xff0 [bnxt_re]
   ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
   do_one_initcall+0x5b/0x310
   do_init_module+0x90/0x250
   init_module_from_file+0x86/0xc0
   idempotent_init_module+0x121/0x2b0
   __x64_sys_finit_module+0x5e/0xb0
   do_syscall_64+0x82/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? syscall_exit_to_user_mode_prepare+0x149/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? syscall_exit_to_user_mode+0x75/0x230
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_syscall_64+0x8e/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __count_memcg_events+0x69/0x100
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? count_memcg_events.constprop.0+0x1a/0x30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? handle_mm_fault+0x1f0/0x300
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_user_addr_fault+0x34e/0x640
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f4e5132821d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 db 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffca9c906a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
  RAX: ffffffffffffffda RBX: 0000563ec8a8f130 RCX: 00007f4e5132821d
  RDX: 0000000000000000 RSI: 00007f4e518fa07d RDI: 000000000000003b
  RBP: 00007ffca9c90760 R08: 00007f4e513f6b20 R09: 00007ffca9c906f0
  R10: 0000563ec8a8faa0 R11: 0000000000000246 R12: 00007f4e518fa07d
  R13: 0000000000020000 R14: 0000563ec8409e90 R15: 0000563ec8a8fa60
   </TASK>
  ---[ end trace ]---

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting 84d2f29152184f0d72ed7c9648c4ee6927df4e59 to the branch linux-5.15.y to
solve the CVE-2024-38540. Please merge this commit to linux-5.15.y.

 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index dea70db9ee97..82d7381dbd6d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1013,7 +1013,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.stride = sizeof(struct sq_sge);
 	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
+	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
+				    : 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
-- 
2.34.1


