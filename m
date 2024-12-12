Return-Path: <stable+bounces-100824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA39EDDE7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 04:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709542815E7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 03:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037A126C01;
	Thu, 12 Dec 2024 03:26:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB062F44
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973999; cv=fail; b=HCjrX1/+1YESzzAXuTopBddkkBg7arxOY6aCA4pXjJQzfVzH2kVtP/rWt7+yNXJFQhun07GVjVcPHplzaAFN1SiYeM7rPsuEp3KCk4hdnZMSc37OUv+jk59QVcRYdWwQvg8tzBxnwEERzxiJ9w8LB4kGGIBbXRv0PBeuRGC6Gyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973999; c=relaxed/simple;
	bh=xxHKCPehuvwGqus6Fsr1XPXmtv7Zfi98xoyUiPaLDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LaR0XXGhcDL+c4ctXBgUFMGz2hR9ELaU2IFcZQzDejViH0ZWsy8zGrGF1zy6aTx45YZmwFnQQFQ9DOlfu5YcNeKUmZCVGwkW8IDER8YAgJvDGpt/lJvSHJvgaW1Y/neY44gzxHjiT/6qSa6uSdtz4xj2zNSvbo9VcJAgYDNCtWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1OkE2002395;
	Thu, 12 Dec 2024 03:26:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xd1pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 03:26:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWZW83Mb8TAUWU8MQ9Narps/oBsZhBcKQE48sqv65N0I8qrfGLNdhjIztq5BylBDpB19MvXQ0pV2qIWM01tD9vTPp9zopuZZ1sX/xRbcstVgCX1kFp0/jbXfZ51a5ZVpkOeFPMW314ZXYBe2Q2KdLXmBIg67Om4YOyF+0H6dHj+htfAa91J1Q260aO8kXp8Ccc0CTNdy0UvdOIdujHbCJucmX3qSWRgVdoPbKXoTcFbHMSLQBF1B6ySzMWFwIqvf+tWVRhksDcCbzxfa40XN9W9GqEMbPgBLl/dBzuox6bU8FOB8qBxXbyKxezCmMHHRCgcgcJp3RpKVJw535Km0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o/Tbf5rLoOsOrc59nZD2tEQnp4bYixSCOnvvezoGLY=;
 b=KFpziOwq+ftx0oNWBIjQrunjfPhZCz5lqa2qEHPbPQhBX8A4TsIvr7p0XTcFBrVd3xwShckk1k/zuQ+s5tBmoowMq/9uCpTsmM5WugnkNWYY5agNajsExWp0csQECq2YIC3kvra0G+0FnfjAqJ6XqDLunPJfQFtM9QJf9Qygzu2rV0xQPAlh+PQyMNCRElXRW0X41I5nwhwe8kEBL1mJxa592a693GIjWxRYWe9kzvHRr06whChW8t8aMIJhgim4YWa3kWRFSL4sKtSUiA9qcL4XyC/UP7aimB1aoXhn2zK3DLWL4zDFCAgR5rHhB7qlifcw8NtMDBfQI78namhOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 03:26:30 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 03:26:30 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, ebpqwerty472123@gmail.com
Cc: stephen.smalley.work@gmail.com
Subject: [PATCH 6.1] mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Thu, 12 Dec 2024 11:26:39 +0800
Message-ID: <20241212032639.3020089-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: d72dcc55-8580-48f3-0752-08dd1a5cc4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SphjVY0f2VjfkomzHtQDCcj+50zCQpdlYy8W4rBJ0lVbnerj1CtBl1nZweVP?=
 =?us-ascii?Q?YEJR9/ITL1fAWYvre6KleDlyeHx5UsbrezYJOaVWCN/dAx0Bk4Yt6fa4tN7j?=
 =?us-ascii?Q?Rh0YvAwDf2Okh5x+FjnhDZ/EVFxzTFb7gA6FiTaxgMbplEn+TbhjHfZ6MKd9?=
 =?us-ascii?Q?3+MKj8h9HU7Qpq3gyhIklsbiCbIR5rnuFRTrgSgH68k9fnuJk27uKPVoTs8r?=
 =?us-ascii?Q?j7cNTXImt5Q14EIYm5JthET44qo41PifbItAeSBNvItVMkhRqR9JMVuvsVoa?=
 =?us-ascii?Q?4PP81TeqG24vS7RV3DjkB0wswYGXQfTzfBTf3eECscspgpOZ5pAAw8zqpW19?=
 =?us-ascii?Q?scEjlP4t7BiuL7c6HoM8ncqcCpSUa/Cyl7VaLigj8/Jlp4NWULC3Wbuw8ahg?=
 =?us-ascii?Q?7Ah3g7FPQ/t0M2xs7fKzYcZhh4YXEBWNysqoxRE4Nr3Ede+xaokuKSmfVVzx?=
 =?us-ascii?Q?45133SkES+uUDsIIoTxHfYO/T0ldG+neD5fqoNzPJp+lrFUmbXwwYeB8xTnZ?=
 =?us-ascii?Q?XsMHO+uYD/wZ8xBfEZLnSreGKvgwTZfOFLxd8FRpwjMUd/aHpKTdV+dYGerD?=
 =?us-ascii?Q?fYUdEq/XcEmX1LoYVyQSBNEQmn51OPdsoaSE/Kkehgl5OiAgu8X/FzsuHh6B?=
 =?us-ascii?Q?+gr4+nx1ZuJ5FQa2E6i8exCu1Cn+p4edJtxekkRT1m3+gxu14t4/908RvmXu?=
 =?us-ascii?Q?TFi+TjeKFLgISWILnIUa/qaeVuDS85ZFeqLD4ty6nJwxXWywYUPHWobvR5DF?=
 =?us-ascii?Q?9lLqbqNwdcVizsnlU0eGZeGXxasUVWOgMrdK82SXYSWu5EWfOT+tdXrmsdCk?=
 =?us-ascii?Q?wKDcGBgmJ/k1yzzTs+bmN2E86w22p+acO3yHyraDUj0sCQpRdu2lCMDKSeeW?=
 =?us-ascii?Q?TMYZm2162dRykKWJ5WQZOmyyd3cHacHE/15K/y/Gk8+AFISa7K5ursyPDtxO?=
 =?us-ascii?Q?3lDoVeoCNzZ/KrFgJiqQh7TVzylG7Klab6tF1iS1ay6VlTo9ztwvQcQ+y2cx?=
 =?us-ascii?Q?kJwyF0eLgVHqcI707ewqEvndbKUkkRf6qy0WCwJaeKRkfBsJFYgyJUW1fa7F?=
 =?us-ascii?Q?hyEhW93ncWGj5DCHQ9wieYTUJWm96buEVzAHu/9dh7syMbc41CBKauh+6fhu?=
 =?us-ascii?Q?9EaFaTMhWsOQonyHkn5McYz4bydOXr77qe08tevEru7hOhVlfgycFYuNUNha?=
 =?us-ascii?Q?DLbsw3FRgdXEv2ZZJwisQ2+ekV/bTLgJXvIDBLwzJIx1jIy7yJT2sEVluadJ?=
 =?us-ascii?Q?X0moj2SUuepETbZtp5Gj6Ssp0bJOSevJ/mlyd2CeNWhjuSex6yhl/dNLgYwg?=
 =?us-ascii?Q?Xr2LgJeVNNiSgQGws8bSZgf6M4bdmvIYfPKKNvmKGl2AGr4pkiSfGKtThfoE?=
 =?us-ascii?Q?dCqpHpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VovWUxIUqr+Te+2o7NsPqPAPaDtyuJni/C7U2niXdvoi0tpAU6/UR0FK9Lhs?=
 =?us-ascii?Q?QfkgS79BFHh0uLEeH1irr9f58kOZYYUI7zU8BXZy5vr798hOh+jmMPbTEtIy?=
 =?us-ascii?Q?De9mqCFv+67QdytWtKRtvd1akLkxbaRhor1v/uZ4x/DOPY3DxKT1iW5rBGCS?=
 =?us-ascii?Q?Ic88fwxVhdnN0KrhoBUv2Te2mqJ2fFZncyxlVKCvJ/DExrN70z4R1ThrGl02?=
 =?us-ascii?Q?a3uT524DeBIR/7ag/sudlHGElEOov7RcpawB/cnJ421DBovXPFu17pwbPGZd?=
 =?us-ascii?Q?GmTLN45D6/rRH/l1J9T+ICMyAcU7GUgrIlasit2TCzScsoL0m8QeAj/EGeV1?=
 =?us-ascii?Q?/6M6CijXiFJpmkov3GXRgPau6+wsIcfv57d4sejmtEqq3FupAY6wlEPFdRSP?=
 =?us-ascii?Q?rWzuC3/CYK7t8dYHQ14ADOgY6L3iDFiaa9cMslVowPazIw8Tp+VCEwx4uaar?=
 =?us-ascii?Q?OwG9tR0mQyE6PobTDCRje4fSERx5TSjdk3LD07/tVlCTKemm2z55sIiIONGS?=
 =?us-ascii?Q?abnymYf5EX2PbM+HHxFPnDA0gDlFiOaEWU+m1GOtI7JAkzJg69gtAdP1z/LR?=
 =?us-ascii?Q?AKJUzNMjbqxniIhkjBkXo0HFE1Pp4qMoZd2RIGbzsKNViCTE518j/EWtX79A?=
 =?us-ascii?Q?w1oEDuUDMf4IKkrrexx49QkQcB10BjBTQUhjRk0Pm4761FpjFZFXLCDZFCOc?=
 =?us-ascii?Q?+6M8jh4ghF832Yyup7b6ontcsafXS2zX1OSH6iF9LqTI01QCFgP0DfdpgvK6?=
 =?us-ascii?Q?2v0SmSYr/s6mjIUGvbrmnpVxWG3pvsWizokAbSsG5+Ho60MZgQqG+sEmLgTR?=
 =?us-ascii?Q?tXzcgJL6ZncOESn/HAUbBxFAU/gM7HI3/VMm71THGfi/3oHIYDfK9jq4qblp?=
 =?us-ascii?Q?/6NKI4SyxffzGUiJqhhY3cQAZZ86wEzGpdlrOHlzZM+MiHcVr7okosGq9EzZ?=
 =?us-ascii?Q?j+OUTI/IUjRYPDJSGdS+7G/CRvSW5NmAoC9dXtO6QB9UrX6POEEZg5Ghd3gU?=
 =?us-ascii?Q?pl6lruoxj+LjtYcRP1o/I4A4w/A7F98FQbKoUq5QGg/4ZRoOgsSHH3XvaS9T?=
 =?us-ascii?Q?p/BPw7kvEZz8c47REZajovXWX1R4dL9rTnvNeslzkbqCd5ZM2R8sZ4lFSRa/?=
 =?us-ascii?Q?FdDVJOJEDSOX8HxRiw/2PA8JbvDdRRmK2VrCrIJA2gQ/ehPA4moaF00GMhfR?=
 =?us-ascii?Q?BDmnIYK3BPKBGS0ntIM9wvHllFQ4SvfMV4SrvmCxKsGym8wYLEdiGdfF/r1f?=
 =?us-ascii?Q?/VyEu4qrRxW+IPiIwd72+26imOKPFNP2AOnxNS093hRr174+2i6CtCZXBlxj?=
 =?us-ascii?Q?Eztz0ilIm575Vpf/5JSHNBMdcCM6gLvTBviML8vOS6GPdNAN1sJ/heGxcAgq?=
 =?us-ascii?Q?ipxfhuP0KNhqgyL98CXp5n2oDSnHA7w+cKHy6omZjbW1Jlk1ezeNpfsu0N8F?=
 =?us-ascii?Q?iikJMY1zJBKS/gGhapKlEK8tRAlkf0HweWpzm+LCG/vL8PN+y7M3vqfj+Y6i?=
 =?us-ascii?Q?fmm6NbYkFbImHdOR0IuPdY+bfGEsyDODVH8+9Su3jRTV3hVVx8I9b+okNSQk?=
 =?us-ascii?Q?xO1no/+HCyilHL7ZQhAfDc/jUeg4YNDDmmQjlk1DYv8fCvdxzcjuwfq6446o?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72dcc55-8580-48f3-0752-08dd1a5cc4d6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 03:26:30.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vTatGW0iTMMYD+X3u3KSdDU1jX+x8HMtvXZa9smpHkvUvHNW1UeBqEg7KZdJw5BLHQtmWvI2XUUZhT749dVV0Tog+JDpbFMSNh9PwHN55Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-Proofpoint-GUID: UnTelAQS5yiBz-M3J9glCjyf3Ab8ijzc
X-Proofpoint-ORIG-GUID: UnTelAQS5yiBz-M3J9glCjyf3Ab8ijzc
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675a57ea cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=cm27Pg_UAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=xVhDTqbCAAAA:8 a=t7CeM3EgAAAA:8 a=tVaNqRs1M-AsdpZa9YAA:9 a=GrmWmAYt4dzCMttCBZOh:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=916 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412120023

From: Shu Han <ebpqwerty472123@gmail.com>

[ Upstream commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2 ]

The remap_file_pages syscall handler calls do_mmap() directly, which
doesn't contain the LSM security check. And if the process has called
personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
RW pages, this will actually result in remapping the pages to RWX,
bypassing a W^X policy enforced by SELinux.

So we should check prot by security_mmap_file LSM hook in the
remap_file_pages syscall handler before do_mmap() is called. Otherwise, it
potentially permits an attacker to bypass a W^X policy enforced by
SELinux.

The bypass is similar to CVE-2016-10044, which bypass the same thing via
AIO and can be found in [1].

The PoC:

$ cat > test.c

int main(void) {
	size_t pagesz = sysconf(_SC_PAGE_SIZE);
	int mfd = syscall(SYS_memfd_create, "test", 0);
	const char *buf = mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE,
		MAP_SHARED, mfd, 0);
	unsigned int old = syscall(SYS_personality, 0xffffffff);
	syscall(SYS_personality, READ_IMPLIES_EXEC | old);
	syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
	syscall(SYS_personality, old);
	// show the RWX page exists even if W^X policy is enforced
	int fd = open("/proc/self/maps", O_RDONLY);
	unsigned char buf2[1024];
	while (1) {
		int ret = read(fd, buf2, 1024);
		if (ret <= 0) break;
		write(1, buf2, ret);
	}
	close(fd);
}

$ gcc test.c -o test
$ ./test | grep rwx
7f1836c34000-7f1836c35000 rwxs 00002000 00:01 2050 /memfd:test (deleted)

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject line tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>
[ Resolve merge conflict in mm/mmap.c. ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9a9933ede542..ebc3583fa612 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3021,8 +3021,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret)
+		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
+out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
-- 
2.43.0


