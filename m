Return-Path: <stable+bounces-100833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1499EDF97
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897CE2839B8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F881862BB;
	Thu, 12 Dec 2024 06:49:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA1186E27
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986156; cv=fail; b=YgdRGmSaZCqvgEhoSbIn/yq4Nw9qKzrSLCqzFXTy131gh2eDmXXa5Z9SwXpF9z7eVWQmdSvGmKznGyiLxopn9Tz/5kA6WbSDyG196vivDOEBPbEq1QUGqPEgJplWHPBDYg1kxbS+pGGHvIgIhWtuTyaCx0EmY11C5OCIHuCZo1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986156; c=relaxed/simple;
	bh=+WMERFyoaa1MVKRxvy0cGkBLAT/SLl+AqnCNuBZEpK8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iexjSDRQi2cvj+xd62tBSnD95htINXV5fM0k21SRk6nDW5UzIbEUUxvg/dsLveeWa5M+W7+epspFvnn632wu7N0E1xRo0XlRiwK3tSmzsvp5EzUZ7Nh2zqfoBPnR1XMteomJdDCjCsWeLTLbYxzjUR4O7vVDs7PTV4L+DR20qpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5S5Kc011531;
	Wed, 11 Dec 2024 22:49:07 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1w7y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 22:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnXtJ7HQPNbdFQHdIsRioECyXv2nl9WFQzeBrslAHMiN90IwQG/S8moFrgfYGbw1H8A0yr/i7eFP0Y3X6LZEQQN/8lDKoOcBBxlEUavcVneoMucbIDMfZGWzLtjfVCXKjKgLYOCATib73rthIZexyJ1t0o3SVDqeUD/4rMCd8MZuAW6XwMPl9oq12bh34O4+OjML1csiBg1WZosbReQ/Qhl4CPPNSdv5MP+Bfnp1C6lMQUwSYjsgbb/Hy6e4i28vw7AGMnpl2s7Y5DRhEAQcH+y3QqFGfk8mymL0lRlaCWflgEvU0OmCZ40GNvuHABR4xWv2ELwgmkYhv/ygLJXcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQSlePz0R13R+yK19jO4fYTlXWeT+jGST9vdAn/PTvQ=;
 b=BphTvrjNVQISqB1l8QtQMyLwaxSmXyIkwkuTQRUjx9rCxgUVOBFL+1Y22svNcOwA3mwd3PLhrWc9XXqyZ4YZ0I/opj0Rpcaf7AOnD6UX8NsFsfBZhbPvKUbFdVpH5iSgsPKrXq5THiPmaguk2zTjzvN5Mxno8s+CQOVH4d4n0rAXup59Ih8Omci1tmfvfjEwe/UlIaXL/SURaAH8KHIP/y2ovV3rgs3Rc5vsUIfnOjyPd/Ou45h64AcMKRHhziV7gFZqcKo+e3txFVXfcKHuOCs5QogTszOx8ML+ESt2Sw7X8YV0eScV3xfmEp03+VoxNXnOd03BkYMVVfYBVX7iDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 06:49:04 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 06:49:04 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, mschmidt@redhat.com
Cc: selvin.xavier@broadcom.com, leon@kernel.org, xiangyu.chen@windriver.com,
        stable@vger.kernel.org
Subject: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Thu, 12 Dec 2024 14:48:46 +0800
Message-Id: <20241212064846.1079097-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:404:a6::27) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dc0e67-b0f6-4813-1913-08dd1a791148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TWKTFAnWLmYT/0IIaQq6CgaWnEkENEw56/AHS+jq8WnYnCRQeduN9gDx0tho?=
 =?us-ascii?Q?qboCwbRykNDscu0/K74QeQ6So3m/fKH1jV8c3JWAXGuwYOgRfbhiuWBL8W2S?=
 =?us-ascii?Q?mXhG+iyXadnLuUUr+EC7gfWnfveNxDqMCVxPcLpSmb75+M+MOS64VLld1M59?=
 =?us-ascii?Q?h4HMQ+kEQIr40eG1Fhusba57Mgg5wHBJwEvSbWcW2sRCPPnzvsiw33o1SDUb?=
 =?us-ascii?Q?eXCMbvRaDWiVE4raIEE88VSwps+FtyYaY3yYKexRCC3KetDVzmgPQalIf4e4?=
 =?us-ascii?Q?D3SINCMLalVGQw8V8mGL45oTx9O4i9Ef258CtCBC+/F137q1zbXdgYNDKuY5?=
 =?us-ascii?Q?OHrrnMAYtD+rb43WFn+9dxG/W71U0C/j3SxUPMb4+IDPb4arI8LDed+BZl6w?=
 =?us-ascii?Q?LHBa30eQJdG7mCWIfnYhWsRRMrjbGAgWRTNBjnG60kovFiYNR0T5qpqpLAgj?=
 =?us-ascii?Q?mNbrhRJqO0v7RirkSV3d5AN2ima2ZgF2KvTKgApSSA71UVG7rL7E8mJXS4SC?=
 =?us-ascii?Q?1EbO+bXI/XI9t04R0cZqinoxXmkf5MUDtQCFJHJRArb3xp7dXc6MPqkJkGYO?=
 =?us-ascii?Q?r7/UUZ7AvGq3qnWyZPBiWB5Vf4DoSWyo487XQwGVsGuyEU7YYEe+TamaW972?=
 =?us-ascii?Q?g3CUvAP39oUnIBRUgE0uwdKs3Q8CWysa5vLQ37i+Mr4EdQtKarhockVmyLD5?=
 =?us-ascii?Q?H0FZ94U5v0gHoR1hUsFqcx1yLkkncN6ZHP+iWD0+nCPfWa/OBjKz7kB13xIE?=
 =?us-ascii?Q?shvOaJZ6pwk/xm84fjQP3Nv0Oi6yvEukqwwAJNQpJz/XGbTwR5wcREskILZf?=
 =?us-ascii?Q?mWRCH24RR0PIIyIHzH6oTGCzr4ZCouzQM0gRrLiF25Tt2U9QqlR/gExFX/Zh?=
 =?us-ascii?Q?mZBT7Ot6jk4sggamERgUWp5/B7Ozb6l2rR746lzRhJXodsVXM46yYFKsrlTn?=
 =?us-ascii?Q?P5NeYBW41s0Cfuodvqove69TekvrX7pBodRQ6ObiB5UlgWFgjFRTVmc9KF54?=
 =?us-ascii?Q?ZdNvcjRtlVTlecAC0y0eQ68nFH1RinBcndGCVVbhZDc6CO5YdN6SXHL5rYoM?=
 =?us-ascii?Q?b4teNvycNTMnJtTizg9eMjWo8QwYym/il/6HUlFE6OLTwSHrMdVk/S8KWleD?=
 =?us-ascii?Q?UrrICuTSD4bO0fCMsZlpdy9GeDXrKvzS/gF/WxRVG9RZfEKYdw+ZWggtQHqP?=
 =?us-ascii?Q?4MZFCGVWeSeCdBno6V4ykjj3rbSYL60Vou751Ahp7NCiA/IWVFTx4NnW0d4W?=
 =?us-ascii?Q?uyBMtyJ23rkVJYf8wdGnTulQkNugN47yXOTdd/xehkS6HbRfyAYmiyxR5AMq?=
 =?us-ascii?Q?Zok3RHuPqZ5QBbtc3gSaJ3IoiBzjq2R+R4YxUU2gqCUO8ndIVTYVYPRTkpUE?=
 =?us-ascii?Q?xIUEt/66iIC/P5UVdUtyeZqKsdpwbUBbhmmIWKZzm9k15ktq5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/yC0GXFOJgXVOYsPAdPUI3uOmkgB6PoUJu1DgTuU9YdDT2N/x0t7bq4bYm0?=
 =?us-ascii?Q?zCs5B02ZtgfBxLvOKiIPiAguW7FYXaoQg9na68u50jagsztF8B+am5oad4A4?=
 =?us-ascii?Q?EptfdehtGMNZ0DENJxoJayfL7u1VtRIPswDFhTnlvKvrDAxK5W1ZZAkpOJd5?=
 =?us-ascii?Q?0GjKE0MefnwNp9YmVqeY2IJ9cxTl9biXb7WHCfCf8LE7+Tpmov2MgTj9Sjww?=
 =?us-ascii?Q?8dMwcjfO1Qls+k3Oa4euxqnGRWH6Dhf1fFGakBkz7QtF/XRq5HOJEXe7ZNSB?=
 =?us-ascii?Q?VtdJlywk7YqJKTr7gvfvh8I7kXniWb17R4i/gvDJs/BWj9g+a9UHT1Z5QcZN?=
 =?us-ascii?Q?vE3nSAcFGaMSmN6RA+HXhLsoGdol9Gg7reex2poDgrOmX+JG8YgyQ7Hh+Nda?=
 =?us-ascii?Q?Mrim4Vr9dVIaF987djz9Iq4C9tIhLLNlNHa+KVPwWtNffMqgOZlcHjPqla4K?=
 =?us-ascii?Q?I4AiQIKwEQSZJaG0kJVmj7GGQwNh6+Zgk8I4lLGapeuSmS/R7ueAKvGS08b7?=
 =?us-ascii?Q?biqEPVI0s3C2unu2Ee0i10gLk47HQ15yhscq5cy5G9cajEdPMhfXTHjBgLBy?=
 =?us-ascii?Q?fejJR89iqP3oGKSPrhLayefRuHElhB84RH+/pHumyV5Djcxfz2NmjE7v5RRZ?=
 =?us-ascii?Q?ngnAjKUUs1fbHW7+TvukX10tcFgTRAKOyky23pkP5noZ5ZzAkFVvu7l4yXco?=
 =?us-ascii?Q?Fk76hemhBu7LRz0iYdAgBqqVoX3sEmPFiyrX2aPXW79AWomjToQILwshoizm?=
 =?us-ascii?Q?9CZRl5vZcpmel/V3vYvamNco08SgJrEMRBIpLMH8ekGDaThDL5hIsp+tdGOU?=
 =?us-ascii?Q?o/mRP/x4jEWOMlxbZqWpqL+3LxbisS7Iodr7nvd7E9Z/r62vIh9+JATwd7nY?=
 =?us-ascii?Q?/4oxoy+jOpPQTcAhVGmjzTG/G/OlN9973ncnNOaYZID081HtLQd7UDmflgvV?=
 =?us-ascii?Q?iHFXibuJhqa9SjZCGRgf+3TZG5EItEuxCl4td8j/TUGuulCg4w0eySIqPp4F?=
 =?us-ascii?Q?+bWHgzJshzK+ZKOfR1n9IegBfZwmBXLWSn7/tkbIVD2tD2UFJZXWpNF7tjNs?=
 =?us-ascii?Q?UvHxCwETp2m7nVYTrmh6DDUBd4VH6HX/DujWN37Xh45AHg9CLvFuxFSFWr4Y?=
 =?us-ascii?Q?5y1y41Gt6lqaqtsjlsBwGl1xsJH5/1iCctEk++9A0YjdGurBpeP3qFLq1Gme?=
 =?us-ascii?Q?g9kmLYtFC5QjUFIyK30qyN4mLW0kOmvyYtgHPv2M910Z3runlpgltMZ3aUZE?=
 =?us-ascii?Q?hKO+1HenWhwlvnESyEnyK4+uFAJ5YnQTJk+X7WIFpv8Pjey09TTBt+SIjTyN?=
 =?us-ascii?Q?zVzFiY2am9AagWtKsDqNJhuZcO3V5MFfpf4uaZxI7hW8MHTW+GiTH0kdmhKu?=
 =?us-ascii?Q?prlbhhJdMlqxq6SQB7ZEKKvS03N7HDRxl26gqnIp3q3v4YLjAubu7qhNwcjY?=
 =?us-ascii?Q?g0rj1+gvgom60WuxJUlQT4r1LdhF2HCm/Ao/17jPJi+xOa0VBSIh6wuTX8Q0?=
 =?us-ascii?Q?2WOqKXZ/nLzoptPbftIefPm4N4uCwWqO9sMWJuR6attHPtK0+AunUtMt74kY?=
 =?us-ascii?Q?L2O8c3ZQozRB1ztrdPfWKBeFY/lBmQ1kp/l7kBL4lgZyrRQ5P8yx4z3tlrKi?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc0e67-b0f6-4813-1913-08dd1a791148
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 06:49:04.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NryPsPzGBm/nXoM1+DJPwkCKk97TjhJQsv+lkzFuWx2sKL/ELpaDZ7voKjqFJhV2NCdkFDhebvhDb8nFJ+U8lLS1EbzZw+A44jGA2ei/I+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
X-Proofpoint-ORIG-GUID: 2VNJHuHwx31LPFCsDV98035mXt1fXhY0
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=675a8763 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=ELwp5h_-rpATTYAfa6MA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: 2VNJHuHwx31LPFCsDV98035mXt1fXhY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412120045

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

V2: Corrected the upstream commit id.

