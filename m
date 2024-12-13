Return-Path: <stable+bounces-103975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCF9F0627
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D5B2850AA
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA461A256C;
	Fri, 13 Dec 2024 08:14:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D0192D70
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077693; cv=fail; b=X7XOeJv9N/u176pYp37i4izeRtU6maxZ8irhspJmpL2Jjig2apo4om0rnAClll9OXMrFufMS5YYLYt7eFBWUotuKdA6IFO5mrk+nfxL1eJL7qyKYVaU6z/9tXNC0UGITSyCpXnj5O7nYzAq69Q/xUUQf/Yfxu+DvSaeoCiRlgTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077693; c=relaxed/simple;
	bh=kYR3NxpfiANkkINzM85y3oo8tnUisSH6bg+UI/1hbRk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OC717nCWspvNVy4p3q/JXTe4P0zPosdF6Ng9HFuLWX+J8GYs26ai9uD10lpZ4TP1u5Y4tgIjeuffHtqpVTyPSkPYrG4EOzfllkTe896TRit7XN7k8k5W8WmqQeIcYWhx2oUCJGfyU0bayLdmSWam72MhvTBxaC6yYOyI37G32kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7W6OS022091;
	Fri, 13 Dec 2024 08:14:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3putr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 08:14:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI2PpEOTyzKK9G9RbKCsOn5BFdYHpKviYAnhg0+W4eVOdVgxpvT34d3pn/t43WIvoJMExfgN7TlV/bZGeNL8RXO6sda3F9r6o8MJvzmIqPF1nYmHGlFCuDhXLw7QW6czrog8nUAa5rm/ouPR5wj88WUKowm1th4UPg5X1bVlBoU9ldaMhJnQ1ddGwEscbfruIVhKDGoxY1dWvegcwJmOzvxXv0PG/qJ1sIaKxUfVO+4wcaZJ/9HXy8+krsFoYgZ8KkTc+fLy21mGxLTEsqVYWKTA00SR+lDlZw1GyI8JF0req3nXZSpJ0fjTVDLHQchPTOR3GI5ROkDlkBlSzshE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JiufZvNkBnKX6zICgnh9Zz9wmOENESdWWAfOC/FVeg=;
 b=wSzy+umJSd1NAhlo4JrdfLPDHkW7oJFAcJONR/n2rrHTjk7ytUlb47YpF/tn3abFwzBh/KRqBlscSPz3Ysp4/cutWTI9rg65XV5nYG8Oy7VCGqiw0KAjd9pmBxtCjOT8HioTAGDHmx6RNAlD/MJVi4EFtwIvucqFKxVY06/1YJzP16DrWaBABDI3cj6YCyfoCe0PYDDd7zY4d+R/e6W79hxriPFjC+OOa5GP1y7RdIXTmv0HU1sio5TY7tfluQhSd+z9lWro/YGo8II7W3JRfcIjBOpRJSgk6XxNlLYbfjt4egc1N6nmt83lHHMzQNWyphzCJcwTWHnKJtIJP3D51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 08:14:36 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 08:14:36 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mschmidt@redhat.com,
        selvin.xavier@broadcom.com, leon@kernel.org
Subject: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Fri, 13 Dec 2024 16:14:15 +0800
Message-Id: <20241213081415.3363559-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3e7809-959e-4d34-2dcf-08dd1b4e2ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbkXHdtcasagGMitf9fb3hsqkcHIVxVVhXDHrqqAepPxTUnE6S3KZFnkht++?=
 =?us-ascii?Q?jd2JxJrpP7zQaYX4rN7SXZCgaYEFs8f0BTIU1Bh9u8MFTtm1J0VY2A+O2Zg2?=
 =?us-ascii?Q?2PaHvH++CTjfbL1NfhtHSyXUDIuzLB/kXO7jNGlp1h9YOawxgwBDLB5rPzVe?=
 =?us-ascii?Q?H1orvZ++TwEg0YrpWLfeXg0xilYMYpFqNl1qSYx4EtNKNVDjhvZdADolJbtZ?=
 =?us-ascii?Q?4+JrwjRJ+K5CD7lGV1FGe/9v5rnreEfW/Xu2FoVOj2vp75sB00nbjsImPWOr?=
 =?us-ascii?Q?nsSxZfzOiwSiymKiGfIJhLx6PeEYKz1+3iNQghpAAgt2d7sAhnhufh3fPVi1?=
 =?us-ascii?Q?YVDz/gG6MuoMW9uQ/LjhgaxqvIaUSXJLyYk/tL1k9gEPAGBPcN36Jl63Hxbt?=
 =?us-ascii?Q?OSuDhwYY1YEBI1ZgPwhqJkqD2Ncu5NcxTYMLgq2mdCoUi2ohE00X3gkeAJAF?=
 =?us-ascii?Q?lmyxpTHWibrBe+P7gl/YR99VwVOA9hZk5w87RcBOHBfQHylAMYwmtpQIlq+Z?=
 =?us-ascii?Q?v/FMRQWbRaDuHmCsWrr92cFozktbtlcqAy/tCE7D25ObbSL6fYjXaHqBIaHi?=
 =?us-ascii?Q?vmbZmSzF4BMkbByQz4JJCfL75pLKvgMjXm43tRfVrN1BKDo0njgQI2r0m79n?=
 =?us-ascii?Q?woMjDvyfLeCyAUPrk74/zhtlwQR8h34T26+akreJewvSPbwMvEZGI+TF5O3s?=
 =?us-ascii?Q?yns2QzdLK5L60GueX52IeVrmJ8p/a4iQtK1A0CIFBI53kr56dWP7UCLs3aRL?=
 =?us-ascii?Q?cAKTMavOvT8NhUcJmZ38Zlf4XqR1E5Wz8F8CcPpD6iGy0bCQTYW9DV4r0XmZ?=
 =?us-ascii?Q?tm6JH1C/aAc5AWNjSq+MMR54fLi3ecvCQzDqp4Dvw2pcon+Z0arEcGJRDP9h?=
 =?us-ascii?Q?apkFhW7g2dkykclrkI9aP/yHk5n6Y6kpuUAqvec5iuJYe767A5AaMM+uuKNn?=
 =?us-ascii?Q?ynMWWNy31x9Y89047as05oIUzFBgi8s5IpjNAipS9aB7cYnpJ7q605H5qJdu?=
 =?us-ascii?Q?GKBrkqyyp3V2Wcv9sn4vou3u2BQ1vQ7b9qaK0PDiIsA3vHq9cFD967+PbygS?=
 =?us-ascii?Q?wb6hrGux6RCjMxnUem4Bw/7NF4XWfhRfuc8rMUPpFUP7j6FqwITIXANWqwcG?=
 =?us-ascii?Q?NPjuvOzOJtPYfhWhAZJa3tcnsFG0yn7szJh67wWWLBwD87m/LbJOY7SIB4PS?=
 =?us-ascii?Q?sPPCEeGggCh+cBzaPa+zhA7TwKH8vgwQSsym3L2TAzkRsAe7CjHWCP+HKcxi?=
 =?us-ascii?Q?u8cJWhcBXJBIxFrNJWh3D6v7MYWi8afA/jr6P2aYB+0oJ/M+6UF2+hCjClG5?=
 =?us-ascii?Q?IeQWuF12EZk9h+S2UhXnY9gIcGVzdwYF+YvHoyvfUqvYNtwaqovrOuW//FWj?=
 =?us-ascii?Q?fcMQwf8pbDOer0YrVv9VWU6hcH4kd4PQzUNcomtS2RuN5GA2XbcPcCboqoYm?=
 =?us-ascii?Q?qm38Xwlcj4Fe83NjieE+E0FcmcDvEWtl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlZskSPamMWqZY5VAPAMpiiAo6OIw7a5O2X846u8eZzjHxMOPPLYMyZCm8mv?=
 =?us-ascii?Q?FvY3h7mjik0iLxlH2EFEsK4OTr+oCRROTvwouno183nP45Kbjb6RDA4fBGV8?=
 =?us-ascii?Q?IZFUT9gsjifrkPQ9YqzWAQiOAQqsUgLyVHYKnhZ2VO3wj1h7R4Cgnk2TLju3?=
 =?us-ascii?Q?qc5QMABrVEd4smGPz8XZ44AXc51zE61WvvOsZtF5ibvca+7/LYefsJK/Th96?=
 =?us-ascii?Q?7xoHHY5gn94bzhS74DJUwhUbFl3YlYNZ40/O25nELKOFtkBFhHPC7aA+iw/2?=
 =?us-ascii?Q?vm0Bz9B0wcw2mCHdwb8YfcNjlKqQvA5tvXlZIg/X884qj/0TMX/J2/ilwb8m?=
 =?us-ascii?Q?d1+L9hHDaFWuzz7FJM616CliAGgHyobIRUvf2lN4MLYEEwlI2SNwXHkvltD+?=
 =?us-ascii?Q?nUUdUQ9kR6MTMQjQzaNVlJjyMCuqOMs8gue50l5Zi1z8tKuMs7h7bl0rwvhG?=
 =?us-ascii?Q?DQmOmLVgjymtI3aDQF02iEKPUsYHTRGPI7fJM5v87F4/VAFb6CdzTJMpFbaL?=
 =?us-ascii?Q?0MrnyPgN26S+SygHkMpXCEkb30BSVU45zYj2OwZ0EnR7pnyMpopUfHfMkoRu?=
 =?us-ascii?Q?Xk6ERv6CKoruEuFieh52RwMmwOO+mbC2jzblKJ7QqprG8mC9y9orHLxFhwzY?=
 =?us-ascii?Q?SgtzTKetFBkwJZTQXcBH57CyAamCbqcnmS20uwnBcTMImXtRL/MYWdw7a+TH?=
 =?us-ascii?Q?ZPyL92Z444FkxhV8ThmPlC1pvfOAjlD6d+3Q/Khxs4rJJwjyWKppPkHUXGvU?=
 =?us-ascii?Q?npxlMbltmsTzGJlR0/pcgqF1NrFdNK8DPw7d94VGxr4dA4a6zeAg8G8TuWwE?=
 =?us-ascii?Q?dsZtVpTXySKoFuY4KDkEyEqiEfMDpxhqBLd643AHzRTCBW4Mp2+8zkullwUR?=
 =?us-ascii?Q?SaWBIj3qzENVqucRuyXLt3k/TAl2du7gIlH9YEnJ74mYYl0h/lrl84IIzqap?=
 =?us-ascii?Q?820/jnbdrhbULDXXJBseraBM4eH3wVLy3B5paFkrq79fcoMWvpAAOYnIvH5w?=
 =?us-ascii?Q?tHyae+gWJbn6XDdqoFxIZ938dIRwstiV4NGICHFRWAlfXS3eyrcMt3fukd5H?=
 =?us-ascii?Q?NXm/CtEA57eeq6UIRIhroMGl0zdL30N3qq3s48v7amCgHwKHVR0+6APOYgre?=
 =?us-ascii?Q?7s6HDQZXYI8P1zFs3N+ERPcBRpCzsRPTGlUtPv28ZjvPuQkcxPaUU97U9SYF?=
 =?us-ascii?Q?LzuAweiqk3A56svetnoaZbC8306Z6YRrAz0dMPyFhbwUflsbcojOEji4w6KN?=
 =?us-ascii?Q?2DeC6Z04YCe9nQzZW8NLJHuwYWZVQKj9GA2Sy3hKSlp+nmgsNQTwkn1UeZRc?=
 =?us-ascii?Q?O8tETWqwoaE8fT3cTLwBvQUnwpc8lSOyeZcKVnM6yKSzTK/l2Ws7cw4tNBLe?=
 =?us-ascii?Q?fzwnC8a+C61n3yYX//WPWgiftsWMnguXEKBysIislOXEdQ9XgJIDxrDCJTW+?=
 =?us-ascii?Q?7FUE/9Rx+41OkuVr8hg+wGp5/c2y1MTBlDx6NV0WB+ZzNFKgqsMsgUAXevy9?=
 =?us-ascii?Q?sjLNiPsvD96NQwe0RgXyS7tM6pVcxGht6g9yTkdrOv+OqbKYKB+LOlHXq81L?=
 =?us-ascii?Q?nxuaB/A1MU9JqQXYz0dqx04tPcFw4cQCnTxcVt2ibaijF34vmFUBP0UJl836?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3e7809-959e-4d34-2dcf-08dd1b4e2ea5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 08:14:36.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ks7j3IeK0sHkfz+qkpT6t8pE1Q6HNvEmXtA9YyRhe9a8gVjgJj/IwIqsrhlzXQNiTIAmE2CORgfMpGGRfkJ1dDHF5QgAM5MDPOwfr/YvCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-Proofpoint-GUID: GajtZ7-y23xAYSJgkHncK7nYWZM1EnCW
X-Proofpoint-ORIG-GUID: GajtZ7-y23xAYSJgkHncK7nYWZM1EnCW
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=675becee cx=c_pps a=7Qu+2NBwJcyibZ5HEcOKcA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=t7CeM3EgAAAA:8 a=ELwp5h_-rpATTYAfa6MA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_03,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130056

From: Michal Schmidt <mschmidt@redhat.com>

commit 78cfd17142ef70599d6409cbd709d94b3da58659 upstream.

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
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
[V3]
Cherry-pick not from 6.1.y but from upstream directly.
This commit is to solve the CVE-2024-38540. Please merge this commit to linux-5.15.y.

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


