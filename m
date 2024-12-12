Return-Path: <stable+bounces-100822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1C9EDD89
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 03:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82CE188A58D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC1126C17;
	Thu, 12 Dec 2024 02:21:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B6225A8
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970115; cv=fail; b=rxx7Zi+WSl/lX9y84zbe2mQOQk19s5dEYEgtFbfOf558aKpJ8CnpHs5Lc2/OunmkN4WutFrd+7NIZO7173/j96WvwCS49C47VKYi+kH11/i3mxyYaz5zhWYRwClqFXNiiImNOTjMlVvfJzlw7DB2C0kimAVe6aeDbjaO676zG80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970115; c=relaxed/simple;
	bh=Omu15eggIbpv0G7JBDjUUmh6Nmv0wKVKWr2nGMV17lA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=so4zpLwOBTs2mMSsecBvKw72BRHXIVXYLgqTHTq20ZC2ClT8Zsih4PUWHLDGq+VrI9+aEq+DE+HlnVRxl/cy4Eax7gdcpKXy0NT6JtwAsJskXsmQXc5hAPtoUReYtPUiWdvGX1LvoHJVzOhGds0leyvDnFYr7j8I8vLdm2GX3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC22FA8021006;
	Thu, 12 Dec 2024 02:21:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3n0hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 02:21:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKzV1i8I29lPMdr3X9eLctZNZCAepvGzAlCk2YEOtHS9C99P+quoxlzU37gzjxW377WmD2DPWD5bieK/C4scDONQmjIXiWEGLrVRfaHerw8KZpHxsF6k2y9GZg9KWin42CuuvMXDIfIpJ8Us0CzbA/y5/kBw7PqmPQ3c20jdWM/pIwe6azs5Qzc/rAqhDRakBKtVoCKe39nuE/Ud1Lpqqm1fC4ec5yG6PLB/V2W8RK63u5W6tEzmoOeGY25EkKHL7MFVmN0dbiKfrI4GPpiYcBdspO9XilovOrBHsS3nriL9zVXdbapfscrjKrr0HnDboYmT9D7KvADHJCDlBNwi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1qkoWOnljvgUwksy6imkEkqjUMnWLWdDZ6MEFL3xO8=;
 b=kLUdOULKWxWeUHX3LJ3b2+AYp1PKEU6pSPjMInqSR+cBKN2bL88pojZXR1Fss5VsltDdIw7xNn2kYT+8W0kcGSeskrn4iQUOPh5bUFk/TAouz0Od5ErLExQ+xM88W3JPOqN/8qfaZlySPHpA8q7J2cHH5C+x2y/tPgHRVgQ1t9WHBgCPHoub/aJpT6Gy0/m/+x1rTqFC4V+KpgOf6q7hjjIFUMUpGkbcT1WU79MMW26HcISbPth7hNY9V6QH7XGo61vrx7cmJpSTTZ4DdFY2fRQ84MBtOUUXdY187doMcWm3NYPVfO73fBtsda7PVI1lzxwXDEnv/2hVXRtpkFLwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 02:21:44 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 02:21:44 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, mschmidt@redhat.com
Cc: selvin.xavier@broadcom.com, leon@kernel.org, xiangyu.chen@windriver.com,
        stable@vger.kernel.org
Subject: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Thu, 12 Dec 2024 10:21:21 +0800
Message-Id: <20241212022121.618415-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: e4615a1e-9797-4881-8766-08dd1a53b8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rTpfDUcKu4vFHrhfiNO/ew4ucR7DCXY1xa0g1EDG3FHgdoArDcrQebSS4KTa?=
 =?us-ascii?Q?i1tHez3IPmLLkdHjkjTzY41WorfOX0sSrHfpMLNtcVeaQa5eWh/P4b3gqBW/?=
 =?us-ascii?Q?D7dB1lo9/KG4viJa0jRNR81+wfpL/41Jk77HYKHnuR/5jxwIFVV7b8sdc774?=
 =?us-ascii?Q?bPUGxQMb0JzANBTf9BtKezdxLC42WBNd8VvGqhWRnpu+nrwFvqKml4Rpraj+?=
 =?us-ascii?Q?HQcQ9Sbdr+/y6s9PVdNBlcIGLj0jXaXT2gW1togCGPUsZeH/PhQdOlkOMHua?=
 =?us-ascii?Q?vP3juK1p9Sl+wAueyFLmH1jHXSix52OWQSI0RWq/F0u1MxVDHQq6V+Tk29s0?=
 =?us-ascii?Q?JdcShWoqnPD7thvqby2w53Hko5opdZjSQNlGM7ma6ieTg6hYViinINCJanv+?=
 =?us-ascii?Q?MtZojIrfvNxmU66YTXRy74N+wlOOUK8SIEWup+bVJbA3Md9aekycZ7ffiXM6?=
 =?us-ascii?Q?flIa6XgG4Sbz602pud7SOAw34RUi0+vBxdgeN0FR7Xr8k/NRLsU6jJDHCX8a?=
 =?us-ascii?Q?wYU6XzoZ9CYc99xK8mi4UQFf8Jpv1/adWimGAK4xadtW42uBRH1anc/QT4j7?=
 =?us-ascii?Q?GawbOwD70cZF61V+vSIiJV9AHNHPErv+QdYZqBuna4YRZ5ldw/q1HcwhsIQ1?=
 =?us-ascii?Q?yC8KFoqR0xh4+ENU9DwOk6l2xZVH6CPpmdzdV9c1yMuGsKKEhOJdDTfCqkq8?=
 =?us-ascii?Q?UeSbqPrVUZxMUlewIg4RPic96SpGNTkbFc0kwJ4yObkDLlMoVz9esjwYYQDd?=
 =?us-ascii?Q?1uEe8qlyxQnyAkryWjIHXoQIqRiHYMmBXjZMOfTFyfE2fWHZFvHdwl9jppcP?=
 =?us-ascii?Q?cuHK0sxagjoy0pbinUKvJPgez6q5eJc76VfZ8P4PIOfy/rubFinmJxSlPahZ?=
 =?us-ascii?Q?Gnu6dyHW1bnd5LhTLXcO+dfFkW0mYVzpEe8jzkQFxGN4uWLi+KbD+ahm0hd4?=
 =?us-ascii?Q?XfyyizwhQ+xXK0ORiA2j0+Nw/SBiBxzropqCMcHoxkfPLz9nvzou+0YT65ge?=
 =?us-ascii?Q?nBDtyu98S4qzGRR2dUnSvay5f5aB7oFXa+hH9LnJK2UHhUO/PciTB9IfJEMY?=
 =?us-ascii?Q?1pxgXoUEEPl86hEJCl4E1tkNc0z/zz7H9lXVwacoBWiAj9LVm8DZFZS7MSGO?=
 =?us-ascii?Q?0as4RuidXV2SEsAey5UdhXoRpsbwErvouDZrWNOPhPwvfYfOGPwclSBpiV/O?=
 =?us-ascii?Q?g/JOrlkCIGtXXvD94MKKD2l5p5Qj6jb1fYMfA1+rH8VTPAYihGdgY81PT4/T?=
 =?us-ascii?Q?hpfPgWamjffQVVBv0KWog8QRD4AA8l19/6lGV/vJx5Fv8nlM7dtpOgtztig4?=
 =?us-ascii?Q?5KoZs8STsn3Sessmw2q7UkokkPHPtJceFOwX8z8ddAJAHhLK6hSirW+K64OU?=
 =?us-ascii?Q?4WeOMcoLLsFVkwCfwcmpHsxg8ZuiklGQ5Ko7ELVcD74ccbGWqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qB9gxhzm/yFHSdhh5buXmalmDgcsiBcACnbb9tP16I/qX4BYn7g5bKioWXxU?=
 =?us-ascii?Q?tuwfkSLA34uondGG85g6jAN7WZkHe/NkUIPXADrLQ+fSJiJgv0Cn9R6upnae?=
 =?us-ascii?Q?SlkDxSCVEq11pPK5koYYbmw3wJMLeL3mEINU8pEmOnPqwiIlMtE5NOIq8LAf?=
 =?us-ascii?Q?yLKKwEueEG1A2AKnz5FLDvQvUXK0JvjdfPvgPtBXkAtxpE0Gabi8P4+fmSC8?=
 =?us-ascii?Q?YNZJb2N3bklkRUD7V782soi891vUUJJ9GgG90bd11sN4swvQcbWtwfbVseRg?=
 =?us-ascii?Q?Sh9Rg0qpXHZ1u9BBEheWGnNg7aPYgJ1GjbkxxHC3/oYrFkYAfNOxwWBdTh72?=
 =?us-ascii?Q?Jv8n1TpnSgpaV2qFLwKFZ/xpALl8DGUPd663TUBykpzoMhABX26gnDZBSnlM?=
 =?us-ascii?Q?96kVRgfGKXAFyAdFxWXyntCTEuIg6j3kXXWhEGX9SxXSIvezhpkkXCpyfIsc?=
 =?us-ascii?Q?T7w77mplDO+l4n0unfnFgDYnpX9ErLd35RgVqULnqoK+9nnVvAj88B5d6jRm?=
 =?us-ascii?Q?oNqxKqaU4mYwlNdh16LjD8V2xT6QTbYWxtUliQgt4Hru+x5lzRTcsNZVf18o?=
 =?us-ascii?Q?IuQjSS/fxQtLxJJ6GW9Xv1qRUQ2Ynjc0KLM17Ut+fpnpooOyelXnw9Fa82vl?=
 =?us-ascii?Q?gPl31gzPF2BfnQzEn2C2yvmo3abg+plG70oj5e9TXZ8iHkqHGIt2eJ4PvtUe?=
 =?us-ascii?Q?orBU0uehhr6i48PfYjt8cHxBO+J6s6P6/vOLeP+zcWdo5C3b0XwjYRBbUNqa?=
 =?us-ascii?Q?X2mIRCOcXKs6uGRQ0e5q+pZ/8QDe/KG9L9E1c3HWcJqti3Fa3F4OqSjA0SwG?=
 =?us-ascii?Q?00JaY2PBWrb2V8WCO3VVaweTPZJWTmn2f2xJpeC/f0oKj//kr8F981y05Gv5?=
 =?us-ascii?Q?R2H/k3In2NsPrHc5+FG69a96jFVIr2vahiEICdNJouBiyl7+XcjScueAJiel?=
 =?us-ascii?Q?2q2QeEfFfKGJWwgJOw9dRotCkuT3GgQWZuRBmviYjkafDHa0chT+rONng1aW?=
 =?us-ascii?Q?6fu60gw42a2nPYJTcA4w8DFuDE3NFSGrSpXE17CXNW90OPEpNQPitEDoiywL?=
 =?us-ascii?Q?OkOGY8K6A5C7SWpUufc8lxIsUCRM9enGNkRFx93RgQuv9fni2Wa8iCRsEmUc?=
 =?us-ascii?Q?IOCWZl0G4+FOTK3h8CnVI9uMIS1ChfczMlWHn1+tk9hcHo39x0MGXADDzbir?=
 =?us-ascii?Q?8czstPPtBCWu2Gj0LhDsfkhwcRg4GLPu+Xo8Xmqhur6yVxsqCcVbX0UjiT/K?=
 =?us-ascii?Q?jkn3ZQah2V7C4KqHJOh0sGRqPY7L80IZ5V4q3MYKnhbgCJvpCsqbSXk2HtCp?=
 =?us-ascii?Q?mRrimhGH8xqEvbMoFAUi02fgC5tWqlUlJFsuz8tFFhTinV7/1PvOXvQmicHz?=
 =?us-ascii?Q?pCSdEeiIzPJxLwmM0fZ1V5mckqkUmCHtfsXQ4qPaFYYsB3jrlkQgvUkElm/t?=
 =?us-ascii?Q?OZCrLq5fn77Aw5/B+lh9wCzE+ulvNk/rUtFCqBx4gBWctis2AYtD+cXCTq5S?=
 =?us-ascii?Q?uij1wZQf9sk7WM7AuGyFDVjKWRvHQJdJBeoOxa7oHbfBxc5t9RdbrJS7LmwG?=
 =?us-ascii?Q?A67DVvp7pVvZNJsg4GGUWr+GampZC5ce+05TCnd/dAyoREPjll3PXXzMKhXI?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4615a1e-9797-4881-8766-08dd1a53b8a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 02:21:44.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsdOVq8BzJYTe6/nz7oyGSnnfzbP0jRb1XY/Qr7p7JQz04EOlixvyXKY8NU+fW3tpZKiSyR5c/Qt9RXuCscQ4TWoZRSCzmnmVuP8KveXu+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-Proofpoint-GUID: I0uLkHYcmVne_g1JiktKCdmJ7gfun2aK
X-Proofpoint-ORIG-GUID: I0uLkHYcmVne_g1JiktKCdmJ7gfun2aK
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=675a48bb cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=ELwp5h_-rpATTYAfa6MA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_11,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412120016

From: Michal Schmidt <mschmidt@redhat.com>

V2: Corrected the upstream commit id.

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
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting 78cfd17142ef70599d6409cbd709d94b3da58659 to the branch linux-5.15.y to
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


