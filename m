Return-Path: <stable+bounces-103959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C19F033D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 04:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D7169B5C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 03:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0A7DA62;
	Fri, 13 Dec 2024 03:47:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A797748D
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061621; cv=fail; b=OlLuG7WxfjFs3Zad2P4Y+pzeeK+9HhD4dc0IkePEEwgJJ8qHQN2y20zzSiBzUdc8LrhBo8elBwFrTkxcOIsc1MZz2t3w2Skl3JeAgxwnYAeMjQsEFyLXXu52P0QunPiJLfb1VMUp6GsbBi9kHTgBLjH52RH2SH0L1wcfnomHk4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061621; c=relaxed/simple;
	bh=9MSsgFu1TnFtjMq2xRPjIzRCXURdRasDW3tqdOtNQyo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ft/WJEasxV2Ia5/rKRJiqklQYQN+UZgNvxJUvRF96ZIGABlSjqy4sJgjtFTX5635+bsOLAy+MLDOFuv70U6nObjZW98/ihuN8EO0hUl3lrfziYLSINSngwYT4/LBX87akq8q6DtcWF/XlbtslKUL05HJ2LH7YvO8/sswgsgBDN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD07Txd016753;
	Thu, 12 Dec 2024 19:46:46 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1xn8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 19:46:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3BYi2ThjDNikjY1BAHm1eGKqdju+K17vSZYOVJIiFXWfO+ogRtdVsp0x1sPNJymB8JSVZ/JQvTFYclZJ/hnOkfRRMnuE5Q3fYir4Kl6U5FSXppfI4x/4T9epDKQS3W8ta5RDoxeFwqpeepnilwB6+xn+bjfTIZkl8THUDxHJpsDp22O/wTucFmfZU0tRRSsXJRekLKXxZCNKTdnncpukKMm8Fq4zb88/sciPF58XxDkF+lNCQzAwUGnHcOQbVPL8ffqiKzgdGnOAnD/dBBf2x8fTLgvacKa7sap2uyS4URiTNYMxTGwa+PG47W+ISDmUolIpZrHAw+eE010DjfD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn5fEdaKBQbNBciey6IVlpdFj5fQoxFkWbqBkTNnImg=;
 b=x8nL/5CsTEHJFpliA3YpvJEpqtiiOGCtERl5w4D2NF9r67vW0ipu2RlrUtkRyWm+LoVF/GQ/wR1LBg3oUqgo3iThq9xMfAwPr7WCA8xHRnwSCNpPad+7iXyizS+sSLCvtC5EOZr9FTG4qlqPBIPcboc5xWNjy+afm6fWOWea90bAYwUctwFDFbMsup1N/SDwu2Vz+QKGe3/mBBMLk1PBNo5hRrYF3tscNMGlH1HKfsg/o3ilJYaJ9gVFEQ+5YSGzKbQuMwbPSS4QR4vZQSZjhVFi+0kDwT4lHw+HCu3Klwtm+/QptNW7jAODOHExcNYBfkoRFEkKOrcxpQAewxgTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by CY8PR11MB7060.namprd11.prod.outlook.com (2603:10b6:930:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 03:46:43 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:46:42 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mschmidt@redhat.com,
        selvin.xavier@broadcom.com, leon@kernel.org
Subject: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Fri, 13 Dec 2024 11:46:20 +0800
Message-Id: <20241213034620.2897953-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|CY8PR11MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 455af824-f4c6-4e3a-18af-08dd1b28c21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44Jwt3TJXhNGLAKCVUfDBMf+m61zTYR83kUwNJZ6N63f5SyvjBVI8a//18cu?=
 =?us-ascii?Q?Ijyl3tj3TMgmZsF919a8ol+NYSoJVeCnWmDcR894eTjXjOc2aZ6EfW9R+G2u?=
 =?us-ascii?Q?kO8APXI4d3TZFYsqopKrGp0VIVmu3QQWhfVDfPSHWovS9/jqQCGfhv5ZVFp5?=
 =?us-ascii?Q?g29fS5Iaa17OoroXdhrFmyfOdfvkUH8tfpZSbywGM+McoFl//N/hnEE6wrZ3?=
 =?us-ascii?Q?eVQRu4EHNCSdXCK/Y/cSdYk+Dsfm6T3LiAH5dsLGS5M7IOXwOYdKEm5xyd5t?=
 =?us-ascii?Q?4/WWjRAbfc/gsN8TT7PIn0tMEQwMrgLClRL6p3EkgM1CS6zM+NlAb4Y6DebT?=
 =?us-ascii?Q?HrosapluKntfxYpTSGb/DSuMysaT5sBvvXe5VhQYWw/UCOvg0evOXgMfrokF?=
 =?us-ascii?Q?8olvva2omVEnSCbGYk8aUp44pc8gU+yy44xQzvGfD/7gQDqnzniy2E1KAvml?=
 =?us-ascii?Q?N40nNhYAlT8lZ8QuID+JI1jqoZcqRcm3fA/X6NoiUh7ONDSetIaDupP/3bPX?=
 =?us-ascii?Q?ssQtFoQLEEjGjKRoCqDMJ7E0yJEXMscIHMzMtr0N8hdnBcNwf4nVirHqB3ts?=
 =?us-ascii?Q?lofYxfVJkxqxKtoBgCYSh1JGewK32FiYth9zgsXE4OW1jcpG1pHRwgJu8rt3?=
 =?us-ascii?Q?OVW9iSVoUwiFENSk4rWc2u+7UYqaR1VBQqVHD7iCXN521McMQdBJGedpWbtR?=
 =?us-ascii?Q?Rh5jGxgH8g67zG9LM7BgA7kExVue7telrTzIzWBNDcIErImD51BtGiSBHiV5?=
 =?us-ascii?Q?RVX2GdPK7bmv6UDQTThI0znbLcC2/eEp4ve4Q67ijo0g/t41scNhUJnImaVY?=
 =?us-ascii?Q?EY/CTBYleCafIQYftGmF2zbT2Jxxs6jD5tObG9uEpiXfrCWcXrv70igeFXjP?=
 =?us-ascii?Q?suyvQHMZyvsrYtUYYHesQKivzH3ITziOw5XYUNtyqS/46BCyC4tnwAWC0GS5?=
 =?us-ascii?Q?lVblbc6y/Odwv7z66NsCzAXsIZJWxirKerLm6UBER0wHJAo0O5iikNgarLrP?=
 =?us-ascii?Q?SqBT6qXtin6C94JhFMkI4+RJXAgUpsQCqHX+i9bRtpevlduC/EY8ami6jWuQ?=
 =?us-ascii?Q?VG95WIBepAK5L6yF5v5HV8QtuODmXIOXzAUPHeROObjvWwWoMolwvvBu87Xw?=
 =?us-ascii?Q?m3T/QeBotYEHJCS/12b4qUEGHv+GGc8k2vLNmuV+RQzxNeJTtTIC4vFIm2BD?=
 =?us-ascii?Q?x0Zuroq3h8R/0lwHTmTYqM0JQ3TEaH0ogWaR70pz7eL/V+FFnZb1rCTOJS7M?=
 =?us-ascii?Q?v3ZjYl9j1z0GDXHXDFcgkWX3FVREWS7KiFr5eKwJF8UojG9H/jqZrp2FSifh?=
 =?us-ascii?Q?fNzFkmnVzXxajQJ1AVOsgQhIzzYMH5eBrUkQHoOTYjjNfCtm7nqfq8xtoXAU?=
 =?us-ascii?Q?v3V1U9V31WXU29OtKZlRZjDwGJd9kQWckgl7yhnwnsV/JIDG7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EUCAYczPUuRdBotIVi4yZnNRAxBqTQ4cP9cdgz3BLaFs3cig7c5Rv8jLpJG4?=
 =?us-ascii?Q?iTKKMuFGvMgN3a1rKdrCe4q2y6yseagLeVeBLNjrqSOUl+MOrBbYSv/+YlHQ?=
 =?us-ascii?Q?zW1i3n5PWCZzfXe8LW0qp0LhCI4FOoCWasaWk9Z2j6IGpq2s3UTSxx1Z1+jx?=
 =?us-ascii?Q?Ro5oUI+WRMg3TsNh+jO1iKp+mqEj4UBrX8cezNme0Lyp7Xks6EHQAZFTQSIQ?=
 =?us-ascii?Q?mK7XghewrgsfzxM7oAzYp/fPZvNDweKt/P0bnDdw9ak6lutbg2YADf/dE8Tz?=
 =?us-ascii?Q?hD0WaOiYwea9n4wG1VAQVVmdJH9e3HOFA1IqHDzVFXaN7p5fkeS0/njQAQl1?=
 =?us-ascii?Q?AGPfKLGwR4p0kgmxpuVKNHnCe3epXcBmZuxBOFNIV1b3e8HkTgesFRaA3xlc?=
 =?us-ascii?Q?TTdEC4tOwIxCWJxaPF6d0JtkbmfUtrCFU+aAl084WzXXPDIFSM6GQzAcg/Cd?=
 =?us-ascii?Q?fnCTBF5imN4lDn63WT4RNNmqt/7Rx2eCP2ajpJ/cgz7oCnxwzUbXmG5cMYXh?=
 =?us-ascii?Q?ALtODo2oAKybnJjwyRzNxEhhtIL6XKLMAeIHzUj4h+LVKVWtUxvXAHobYtqy?=
 =?us-ascii?Q?z2M8qy+7auqiiXE3A68wkuG4IzYfAFXrsJAajyePHreFMk0a8zL4CRLfNbth?=
 =?us-ascii?Q?sKPtHVJsd209zKJkVUoBEZ5WYev+J2QM1JumPGf63IuQ5WYCV0bGeEbeGqxL?=
 =?us-ascii?Q?+W016t0UFqpXI5vRw8i9HkO5xN2dHYB8MXIGv7+A1iUuD0vwRARhc2v0ADVh?=
 =?us-ascii?Q?zOnfrDRkkIZ3Jz2qe75+vVSekrM+cw0kEaxlCF4DywsD8oCVNITt5p3Lf4o/?=
 =?us-ascii?Q?ywFmG2A/gwkIF7ROkSLSXCAdPl3DPERGD6NkPDO4N2s5VEX/lxLTUUgCxnYa?=
 =?us-ascii?Q?yBDcEXHHRp8sMrH95T2DkQjAZ1V1lOY5Ybu3iE2CSTIxo2+ZchSYR+LKjgt1?=
 =?us-ascii?Q?7/ppqALNqJT6WXugASi/zDEwcY9M6eHmtF3SuQ2piW/tZc/mU6sFoRoDfqrx?=
 =?us-ascii?Q?9oBzgzXjUSHdcCU9+VFGKLpxtypAQxe0D7zUYrhMiOLAyrU0LtdNwSFq2HPg?=
 =?us-ascii?Q?nI06GULtUybtY7yhqVQ5wu1OF4WrJi+gmf7M4jLAVTgSsB3nlVhnB8o8ShV2?=
 =?us-ascii?Q?UomtkrjsoH6ZY1z1Xw/yn+5xGX7i4z+UDQe8ePp2s/pCSGb3ewQXdjjykmYe?=
 =?us-ascii?Q?gL5Q+0En6gLYpmkwo8nSiKmft6AyTFhn/zt876Myk9P7EtF7H6ViFlnT5MMV?=
 =?us-ascii?Q?zgiRrhmn0rm2za7ef/ArGKVCHX0oSY3+aSkBUvPvDDerw7vfQ77113875M43?=
 =?us-ascii?Q?cQy+KApv8Mr3Uka1U+W3oybkDw2YsFE4Q8QLnZKudjXMHg2tA486Dqsiuchv?=
 =?us-ascii?Q?kNknERi0U35W2zuuDi+rpEwgDt0ayMXODF29B+jx+IHS7WBGM7BZIrHFTmXm?=
 =?us-ascii?Q?BPXtmmc+RNuRM/dS/4s+winv42LXwSZd+GxFiPDyuHFXhkLVhomqgKVTbSXV?=
 =?us-ascii?Q?grlBZzDUmnlREwch+DWbtWSGJGVaH+LQqV0YIrwNufQS3Tk0sDyDyxQsixSl?=
 =?us-ascii?Q?ZjxKUD7Psmhiwu+e7lI7A88d82PZGN+fIxyNmn+Xonk27YymbU9RiAxC7Kgl?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455af824-f4c6-4e3a-18af-08dd1b28c21f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:46:42.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKP3C2gkdJCP0Ef7URYjCn11Gvb810/whSkfY+Uyl6dV5zESGcsD9ujYnol96cKiV+6vNvA6xUFklu+Hljjo3gMExaj+57bwIl/CrV17u2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7060
X-Proofpoint-ORIG-GUID: XgTHeG13MkBWS-y2pFiuUkes5VUzosD0
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=675bae26 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=t7CeM3EgAAAA:8 a=ELwp5h_-rpATTYAfa6MA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XgTHeG13MkBWS-y2pFiuUkes5VUzosD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130026

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

V3: Cherry-pick not from 6.1.y but from upstream directly.

