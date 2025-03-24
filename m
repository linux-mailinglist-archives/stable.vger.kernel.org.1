Return-Path: <stable+bounces-125849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95267A6D4EE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF0616A434
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBA433B3;
	Mon, 24 Mar 2025 07:21:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65195192B95
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800879; cv=fail; b=L2KEY3Im9SepZIWQDhsAckweXWpawjyY9aX5A8eIq6SIgBtmcBZZssuzs0Ot8t3AgDHdK0TjEaPijNDIKB8AQcgSt9er3np9KSr2c+Lzgnm2iakaOHSNQ85O+wDbpiAJHz0AkvHLiojhhvMIunKim2htavNLLbnbPyRJzbVB9YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800879; c=relaxed/simple;
	bh=GyI+QFbaPrOHbxt/z71R37asJfycVWPyjukujMaT4z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUrGXVQVBPAEwYwz20frWTOosROK4AefaXKo8ZiW35lR4tk+i1xy5YYU9C9w5DvT/rhpbyBcVVfU+uJKoiymv3P5kBPVZ9LZ7zy1yKCYkg5oP9ATE6X0M5BFSMFItOeW1gLZOmQOD/Iaew1otVygbjWZcnKRflEGOPYxBi7X0qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6Q73w015713;
	Mon, 24 Mar 2025 00:21:16 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9ffw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnzz5zk9INhKGVGeyZB6rIPtpbz+NrY/UyC5ff67iEvK4RjeZQUgqGxrBXLweLixvK3ez+s+bcTZqH3c272PVXbDobJlcfFVP7GaLBQXtN4vtb9bv2kn4wRRLZeLUndxgnFxnoBia3uilFzEjtHJ648RqND1JzXdxyzaP1sR/oxOGZ108YZEICC+oMzcOZjsyydjFIh1UIFnBAVku5EgqpfP35VOP0VM37U/fkxkXfa8V1OYeAaEkPjuWMIw/w+e5GO/rUwO299jc3CJM3tyGtplXC60TM45bqjhyyUwQ87tdjLc9jmT5Un4qJ6V7WvJJuxEPKd4GCo4nefbMfAoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvb+K+wC2dwf9Qnrv++q86OslVaWvJWDWrZaP+Pl4s8=;
 b=c+3Y76POxNFmAYETxmLOroNeP4Iu4wDVvwzipFl1lddvw7P+2G8BDNN+LDgLBUoaurAKkkl5mb95hgsffSlfm3t1+wUDsjBPTwdusiZcJmMs+p3MxEc4vHM4jJ/uG6zauIj2xdNEF/0qOEsMA+O4M0TTFTZLy4LYdSRU2reYuQVykY32ODxEU/WMwi6g4QPZNGAx2TOiu36pJhWA7KUaDvsxLjyKWo7bUPF2Z/89ZxTW2SnpHG8DQB6zXogPg1pu7uVcfhrVTGMFFJSUUSxCkmswqds51TQlOGymwlcN/FJt2lC6xqDSg9c7TY+AlUbhJwq7L/PUs6cLFocsTR9Q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:14 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:14 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 3/7] binfmt_elf: elf_bss no longer used by load_elf_binary()
Date: Mon, 24 Mar 2025 15:19:38 +0800
Message-Id: <20250324071942.2553928-4-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed3929e-17c9-44bc-9013-08dd6aa475c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCddy0gP+G827md50joDlrzZmmyXAMM5PT/dfF6o5SSBHgMJM+n81Np3ntdC?=
 =?us-ascii?Q?yDRr93LkmfCty265U8m+MXT4z8MMcVtflUdd7FVyEcpafL9jIwSo8kBbe63w?=
 =?us-ascii?Q?DGwlnD83WgtGNPzwec1+uPdKl/eiztjgWdyj66WJcjZoFshPvRONdJeVj32f?=
 =?us-ascii?Q?dL74fH7abSrBi/9YXi0FDzy6a9eCgLxwcnZA49UtKRb2x7nckbuqZbpN6fgW?=
 =?us-ascii?Q?7KQThiJ2fzLvcj+4NGUUxml0/L1gci18d39f03SHGKO+M2jtHPvLkP+pFUPD?=
 =?us-ascii?Q?n6kNrJQoOeT16SKbO4g24jAH9xMjEEARFAahjsvwMRruW7SDVUG8MSzr89mD?=
 =?us-ascii?Q?p2NWwYk1S8j5NsS/5xItRos0BeX6ZcioaLJdHSqar/fO4j4yd0HvBhOOBFnI?=
 =?us-ascii?Q?sqSsPhWPCrJmXLG5OmdTIaNZpf46EBzzk84zO7GwJT5H0q2Tw/MUMiVPp1nL?=
 =?us-ascii?Q?2iH/F02Nw6OUHaZV5s+l2N5XIuglcCxKU190UPkwaubLjirta5GmOgOp/tZC?=
 =?us-ascii?Q?o2H3XFpHFuOy73BeMyUB1ie+Precb7qgr8TWG0+6URXVzuMUKmLJlcENbdKj?=
 =?us-ascii?Q?vdTFWdbDITJrpYo/iPzfuzYL8nnMO2sJo1upp9svJavfKWvyzv8Bs1o/uWO1?=
 =?us-ascii?Q?yvALyh3ylEbmsM3k80O+tBAPF+Xw8V2ZBZtIwFFnk+vTDAgRXAk9iUjmyk30?=
 =?us-ascii?Q?n63OLjaG270upPLqg0kvbpto9/V6P4zxtfAJtV4HqS7pF/FL84jRwzDyY4Wo?=
 =?us-ascii?Q?4eac7oyspKPxlRUgCTeShN0fTxc1PlG6kCVwJ8utbQEhU8mMbatWdPdkYvLp?=
 =?us-ascii?Q?8dJAruzZJVWLiLV6Ipys0A8ILxsq0OjFxM4sthUw/GiaKG8jBes1AttFA795?=
 =?us-ascii?Q?pzN9tLoj4PCLLtg8HNqwdYgPY8kU1MaumYh6DkgEkwAFQHoholG8nizYAqeU?=
 =?us-ascii?Q?LGB2ji182xi0LQKBTHd3RdgMGJKCS+FXbgFk8PVJzIM7NKwEnelzvxoXDzlC?=
 =?us-ascii?Q?/UaYKhNvsjx/jJYrgiYQBiWpCXZ37NY6FVzlSpWNfmLOMEMsqR6vyGdmxFOL?=
 =?us-ascii?Q?FhNoZx9H0O6Mw9toq5Z+53LQDpnUdCYk62BO6w9u8+iNAvg75mGeBUfoEeWE?=
 =?us-ascii?Q?u8tHZvyO/X7bPthWwFOYBpSRAbZKOq0hfkipPK81ONSiQLfeE3aA07i406qO?=
 =?us-ascii?Q?ACaxGJERvOpmtXSPmY3rxlUGRCyNlIRRKRBqGAXbsa0+sRSbQTJgOLakFtcD?=
 =?us-ascii?Q?oshzLQ4bamczIn652xaBLMeqBAG8/iSxRBzQ5qvOPALlVJtqiIGyPGLTkKNN?=
 =?us-ascii?Q?R3jAai5in5eBuwIaXotUWN5rmL/MjiylOSK7i5UWmGUXZYMMGjFd93qYQo0X?=
 =?us-ascii?Q?59DIzzk8bz/IhnMMQL9DH90YHGZphjfdnkp7PWLS7+1wixHbcsaSVOnD34uz?=
 =?us-ascii?Q?UJREg4/KLkTjK9Im+QrEOhdp8LxYR4ps?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVvz5fAlO+0hYRdIwpr2Kzc86qiZnjs9722uvhm2L9BJlsGGaormrUJ5ArvL?=
 =?us-ascii?Q?moW/kPuQZSaM04B4CREPM4mowhRdpW9YkZUjOvfPeAsVolPQnSkvHvqUmuQi?=
 =?us-ascii?Q?pRdu/GTChfbV/IaX18JEKPE2DxI8v6aTSOEQ6Ij1W4Jjd8FCxt1hNUhqpKti?=
 =?us-ascii?Q?Bk+wYs/CpWW5ba+s1nOq3I/DjONwKChVDloMMy9YkyZeXg4eRTyaj+wcp08I?=
 =?us-ascii?Q?F4CMAJ0+1VeQq4LEhJYgRr5wiq/7vaV0RwdzEegtnPgJlCpI4KGFpiXOvFms?=
 =?us-ascii?Q?+m3ayXPBT9dAlioMPClm9GmH/jOZG3hoTXvfkLpAL6G1tgkVy1ZwWIODGlXh?=
 =?us-ascii?Q?lQx1edUUU/QjIxEIyUp8bOuydYEZpzqKzuMR9Q8trO4mbqNlXJO6KkruPvaq?=
 =?us-ascii?Q?MFSz/7Yp2UFtOG8KCzTv9iihnN36B99uYirQ/FzdVrTnw2gz+FVqVuoS7Cqq?=
 =?us-ascii?Q?Z3at6xffzthstvgMnUR3R7yKRE57S8xL3K7pMxDBRy298tCEqQpkkrJC5xOO?=
 =?us-ascii?Q?EVlXt3HurVc1X+UWZlY5QoEPOgv/wUDyz94WRlNeeFB62PRVgCY9bnzArdVD?=
 =?us-ascii?Q?0uTcjF1+XfjoJj7wYpqoLF1Esa3OK02rC+U/ACWgerg5jmLDKT5o1J9qJGeD?=
 =?us-ascii?Q?+UxG8+AyXtNv+XCguGA1oNv2a1dlp2fgE9clNddPoOL1anDprcMErq/2N9r0?=
 =?us-ascii?Q?b4DDQwjd19QqQYMOfcty36gD0GIzPoK4rwm6yBREMos2DbFvK+EwHfV6zcp+?=
 =?us-ascii?Q?cSFXkzSI9Ccwq9vU59dW2iU0Pu93sXbhQAW/WdpaQxx9F6eqsJo27MNmMUtX?=
 =?us-ascii?Q?l3sqHJUko503pTXbDmrjwLVrYu8YJLMXlHjiE7wfCCIqK+9cZQFGwAK24LSn?=
 =?us-ascii?Q?UaSsoIT7RkpeuC/jVEshpXjTfuohP8i9nTc3j2Q8IJwMe0893vIEwHbMz1c6?=
 =?us-ascii?Q?fPE+h77m4SvtfO/ppMsesEq/eSp8Og96hUxnfl91YF1Nx0ACUfW914CVmVar?=
 =?us-ascii?Q?V3y3fb9MxNdG9KHGtbSYja9apgdcD78C0AFvBlXArruL7doA/eYEOD7z/iEl?=
 =?us-ascii?Q?lkIkBeeATGDFduXcb+G2b64PHnLRNdDvXbCvEZoF6d9wvm9lQpPqElpEn5b1?=
 =?us-ascii?Q?1NCq/O0zZfQQMRQZGWM1vZyguBDYvRpe/lGyktbpoYyUgBEN9pIFMHQkPwR/?=
 =?us-ascii?Q?d6YM6J1OkJBDsHRn6VF8bGbM9nlNI0wWa+sGIP9NLY1Nnf4iUcZXYoJXDhyT?=
 =?us-ascii?Q?rLJQtzBxNyTxWiP8fioUBpuDTN2RSscKMCJZbt75MK4+qvXkW3Ri/vvUe+9L?=
 =?us-ascii?Q?wRGF6c/UJFmY+/gZcc53Ssu45LXrU7jwUlDW4c/EMtgyDHhlGHYc80qJ7nIL?=
 =?us-ascii?Q?0zxwecXEtN0UOuauyTQRZpRtrabujbcL3ZM2+knhmvBf9BtOUkZ4vbTQheNO?=
 =?us-ascii?Q?iAfbuwbpIn2bAwMuneMfchvy8/sJ2I0V1MCfeYXlYBzJFZmvIsuB324gvDza?=
 =?us-ascii?Q?XgTUZsO6ATGLy6NT4ntpTGzV5YtyWibOavPbfqB9z6gqO2Z2lj7x8l0Y9AIO?=
 =?us-ascii?Q?m87hzfqnJ0GHzOuxBH7i0CTGUP9Wqru59LTfvDLBvM/DXwYo5wwozW15/1Rw?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3929e-17c9-44bc-9013-08dd6aa475c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:14.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQfa8xqIe+H7moesHpwNsXd1FpcpICIbQx3BvVbF98TwOTIbgCm5Oo/uJ2ro7zVHc/+TQXUpQy5SHhjw7sxGuJ+tL40EmbPSiVS4pDRQ/PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e107eb cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=khlNtBpU2iGdVRXQu1UA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: U2TQiJ-nAz_cTSt4aJK_QN2BqQM7p-iV
X-Proofpoint-ORIG-GUID: U2TQiJ-nAz_cTSt4aJK_QN2BqQM7p-iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Kees Cook <keescook@chromium.org>

commit 8ed2ef21ff564cf4a25c098ace510ee6513c9836 upstream

With the BSS handled generically via the new filesz/memsz mismatch
handling logic in elf_load(), elf_bss no longer needs to be tracked.
Drop the variable.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-2-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 90151e152a7f..631219c3ace9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -855,7 +855,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
+	unsigned long elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1047,7 +1047,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		goto out_free_dentry;
 	
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -1210,8 +1209,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
@@ -1223,7 +1220,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
-- 
2.39.2


