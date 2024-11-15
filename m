Return-Path: <stable+bounces-93529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3354E9CDE6E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0D01F2255A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3A1B85E2;
	Fri, 15 Nov 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dn/PEFfK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEMCULmx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451A1B6D00;
	Fri, 15 Nov 2024 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674440; cv=fail; b=hICvkdj2o6kyf6ldVeFungLaJjjnVjX48lg70z4uKQdcNAoqa2W+WSIDm+7T9x0n7RaYYrvqYq03/CoEmZ+FN8GgP92ICQTwYSUP7uhBHhstlbxrRQKc+rApe3ZlqsEyJn0T439BhdajgDOL3MlbTx4l+3KTzeGP+nWcWxHd+1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674440; c=relaxed/simple;
	bh=AqwLx89/tejO6jbqVOXyowAY7Xu4r7vHseMy2tvsRe0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z/wYn/LBeJhBHCNVBv+6RS4DSNhlGFhLsNgiLs0vSGRjBCRVhEcWjbT3+G494X/IkHN4I+H2ft73AHJOH2jMCKvtfOfiu3Oi6aNVFevkRzBMlAS4vyuj34tPLchM5OP0Z0O+Yl44FF9psRFciFVFSmtCrQkQhmA9jIrfjItnm2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dn/PEFfK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kEMCULmx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH0Dm014169;
	Fri, 15 Nov 2024 12:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=haq9W/qmdoauko/Z
	zHiSrwOQZijUicsgozKzOLG9egM=; b=dn/PEFfKmdi0OFc1PDlCqUcArYfhnPfF
	EfxzmG+UVBcWw1D4lf/PRineqUIt5XqDcZrm+iZhLt9jAG9AtvI5A3/Rvt+/pjFZ
	IOBoXaE0bbyAfAdlgV3Q8O/Buc7d3zQ5Pa9Wmo6YY859YXHr9xjKb8i4kMPwQrhT
	+Wpod7AnM/Z6DyufZXDSbG3yPRMaHgf5+LW4MA82ceepO+s0ZkkEYcwvyOSlr18j
	m5aSclTMxd1lzgJBakDzFc8dwyuGz/n0njAXz5+suiuQCUhwbEBRBybKcAS7Rj9K
	Ps1RXEZcVxDoNJatZnj0GtgWzAedNMwA+jXlv7vKs6L5MheQ7ou2Xw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5k5vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCaBKh025914;
	Fri, 15 Nov 2024 12:40:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c5sbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFbctFxXha1FS4/QJtjo4FD+91wzZX6wERHO+UzXmU1eQuJBNqui1yeno83eOg04vSzta5dpcN090nrm8zfinY+U+8+8c5EK1aC77yNmoqDKVhPYOXyl88kuWS3TKeXFVOZe5Frqs/d4PD6HZ7j31IqkwmDGGFCpQ7LmePPPfMCmZi7aHYhJq7NQj17JAcfPcGbNDuS1A2t87W6uEX9zdUe4rbVdJdZAYndxtFDWSLK1bAmVBGa6eTDWz3i9SVP6w6BA5MsoUSvI5HRVIEY2Z1vIPbeOQWw4aADXHYkrzT+FHJPOPe6v60yYleRwEVRqwOAfCfBCM7bRSW3mBJz6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haq9W/qmdoauko/ZzHiSrwOQZijUicsgozKzOLG9egM=;
 b=YtdV+F6TpJUXn+eV97j4IkDuiE1sx5Blt7frVlgmtC73ortC5Y70+A8UTXxw4FcFGgTBLdScruqbTLgEJI6dH7lNHuAas5UwvycMRmvVrqQSFd//71MKdC9tTwCHYs+FZhHvcOH+mNQwvhhMBi+Iy/5TVvToV0CR+2XxQ9o2xh4IsbJxESD2tX3FAXQ8qQRTzK0adOW539xB9ui4tABfhcLW6IVBC1ubate8xcGTfqM/1eBYzoQF/T45CAxgyR9mWGeN+TkWu//kvc70KHVMR6+EX7gcBkP+WINp4WDsl00bV6iQWZsfuNuAjrkqPccpJpGsz0qCy0njMfg/xDm1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haq9W/qmdoauko/ZzHiSrwOQZijUicsgozKzOLG9egM=;
 b=kEMCULmxRWrED+QMeKbY2uzgpMpfGruiEdbdhEKp3InZklJAbmvNjBsgV60TH2KbDAp4w4NaCgynKvZI6ZcokvM/Prq2MkLYY/zr2ABsNS2CRAjI30UI01qudZXDyr4us5JDTOUr7AVS4Iw5uDLmxeHQx6YxYztbqRbxmUX5ROs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Fri, 15 Nov
 2024 12:40:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:40:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1.y 0/4] fix error handling in mmap_region() and refactor (hotfixes)
Date: Fri, 15 Nov 2024 12:40:06 +0000
Message-ID: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: dd14eafa-db77-4b72-d0f7-08dd0572a6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmJt6aFXd56z3C/RzOF2Qlnoz6wj9KGCRYDOpERJmNJ7OiCM38Eck3h2e3TB?=
 =?us-ascii?Q?baQfesGEgcfmm9WYW2GezPTfh3tDSYAncSeg/AUtaLE13as+4ij+dHvLfcyh?=
 =?us-ascii?Q?HYuFcD02IsqUxVKYlvq/FnSA4TZpR8EmUbINoLG9wSVSk1OkT7nqMASEPbJT?=
 =?us-ascii?Q?H8OHFoQSGhqcrCMVpywO/olIwsH4OzQJ3uigVCUJRfg9nJlzLSHxLzNWCKUJ?=
 =?us-ascii?Q?VyWZffXwisV6OwdAKBQlRF4B1Cbr69OR061Ecr/DuEhvmXHnw70zBSZpi9DF?=
 =?us-ascii?Q?ChurIVo/bkpMQUGp74VtXEEfjwwCxa02c5qhQUG9BTmJ1HLuB/+GV7GxExSC?=
 =?us-ascii?Q?UGYchvyV6eKiNzTO4++AbvOCj+/Fc8unS5850cb9luBF8m3d4lH9J/iVgP1h?=
 =?us-ascii?Q?mdgD7hpqiV3ndzK9Gy/KBKZAcDISr2lBpbkh+zR2wDuYi4Po/zjYNc7C+1UO?=
 =?us-ascii?Q?jSBHpD+JF/AJonFm7A/jppC+62rQX9jjf0V2x97k6ORRIVQAy516KOtopKzT?=
 =?us-ascii?Q?Qqk8t2HXUHTJe4F7I7VqngDXYZS4eWHF3KtA5ozSiSc6cbpDzbtsmdKkLrnJ?=
 =?us-ascii?Q?vAlTFp+Ptwu6UQ534uYiO/65ne8K5gyrV9yoSYeNhXiWVW+9n2wfvuxbTAAq?=
 =?us-ascii?Q?2TCpOXq766bIN3dTa5B8CFgjXEmCg760wamU09cPKve4t/ZdnVdFnoPehjvH?=
 =?us-ascii?Q?lTcc4Tt8uRQNftIEj3G15RzkTMecg1XXhmqSMqdzJnB1RL8x+KpKT6hpuEbz?=
 =?us-ascii?Q?4LEU1R/3acaKMpRGUtzRPZWxpCEvMcZvaKzPdM+acJio09uK+CqdlizmXGRn?=
 =?us-ascii?Q?bT51VRlOezL5IoRAeSGJiDKgCPh+qbAZ4zqnmGWNtGJT6ZSAu3MLNQ6t3MWU?=
 =?us-ascii?Q?E42BzqTzK6IFLVsgaOKxDnvEqM+Cv52bsrXeCmGaec3yDdYVUrg/tYZbp8n9?=
 =?us-ascii?Q?Su1bbdLk3gTX/tAtLvcGYyP8uzo6t4DQBg04iCxNqFxe2c6D6wcwJgA/+yPU?=
 =?us-ascii?Q?J0flV5LSiuaAvcWK+ikcVy0TYq6bbW9CQS7ldUZqNVyyNRv67lURA0yGpfAx?=
 =?us-ascii?Q?Myc4nrLYMzGAhEhSbrrqx8xLKSm5OKoEoZ32jst0gqX4vvtsjVSYmqS/RXoB?=
 =?us-ascii?Q?ncoyH9M++x4ZJVF7UzjsT/PLaLf2ZhRHKq+ryxXMfIndYoAbm9uZAi274cYw?=
 =?us-ascii?Q?rxx/orx5Q6IooNQDeiiaQteXqh4gxLGcgYaQ7pfhGRLadmNwKMTJZIQkHtCE?=
 =?us-ascii?Q?ezLWFGgHpooBo22ZDXXVbNjON+SUUJRXDK6P0/prkTMyz/9Zy9A/0/DIySTU?=
 =?us-ascii?Q?8SyowJ03APeY128JVXmmDWR5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6csd9WHQ7qgflYcMJQlaqHJKY0IS4gaQx7y5CU0Wfph5SWBNJqxfbeAFKOcO?=
 =?us-ascii?Q?GI/Kcp0DlnF+1Mzo6ZndXOKys4j+AZywyukukv1lfgW6+O/MQpxvSwDJt9wA?=
 =?us-ascii?Q?xl/qXS8wfMKKMcH0ZIFUlrAcslrvWS6NaGgEGoJ1ahgLG23BZGNDLVIBstpQ?=
 =?us-ascii?Q?tQMki1Tu6cxuDCrr7O8buzY+VNNNW9/nz3hbgRG7AEVmvkjf5TJp4CEk5g22?=
 =?us-ascii?Q?oRXcs0OHjExkMesKm5fe5WS9JkMqf/b/evx48f0Cp7VOsdk6uM/maNwRMsT8?=
 =?us-ascii?Q?3DPip5j9UMAvkY3kASJBs0wIizIDLg/cQVX5Alfbi2pmnAApBg/WCu6drHUX?=
 =?us-ascii?Q?xZ6sObM83aMiqdSd+hWO1tg/vUJOeAZjYsphwvfRGFlZ6ae/H0/852BozVJo?=
 =?us-ascii?Q?RPOiICzS3QMfkq/jnmz5Jgl7tyGzy9Y5pwSVGMaevQjlzMKNH6kMs13Uvnau?=
 =?us-ascii?Q?0iiI6Ox5ilzlb0fivSR1nPEgGWACMM/icQQWGOruI3VdWPzyxX667KNIgW48?=
 =?us-ascii?Q?2QyGgT0qK/ZZtjUO3yoI1im8lDbhwd9C4dQIgOBQv29u0Xmp3wV5sDE2mysU?=
 =?us-ascii?Q?6g5EBjGtWPrsb6LSRpJ7UR9FEaZIS8Cv2JdgEyMwR/8NN/K5+OvIBAtnGkbR?=
 =?us-ascii?Q?ithS9evBN8KXbqfjs8TglR12nKD3/M07iiyjCewaY5YygtAGKe7nCS5frBBD?=
 =?us-ascii?Q?13RRr0tdVRAL6Bz3garGIPdNTUdDtQZnbXrveBAJlgP7Q8p9UtteNyamEHjQ?=
 =?us-ascii?Q?hJ/CnjjkaUmdqYMkTz7qV9lPBwe+AqVoknhvm8bVsMXTmNDHGiv/Jd7OJBTl?=
 =?us-ascii?Q?H393IDIJCJoI/z4GSex/vzsJQUAg/StKZgx2HgyWqEjPZ1CjStatguZyBrRc?=
 =?us-ascii?Q?2T6jFuV5QVyRoXxORtA6NNK3qJeXuoRlpgGR6lRwKHzsWndu70vYt3Ol5d69?=
 =?us-ascii?Q?/Lhhqir8UjtZM3uL9vKwmNY8Bmu5xXnFVp2jW8XZ5Cfa4iRy4kcKsIdwl8BY?=
 =?us-ascii?Q?bSrUmmaUBJoiw1NYGQ8Cqv+9uQbzPW9L+NokS2vqKvOKP23qhPWoebzeZ9Es?=
 =?us-ascii?Q?0ZvjE6kIc+CAc6fswY5ShVP4NCgqq+Ltk7rHYWxIQR2LzJsTZZLfIoMxd18B?=
 =?us-ascii?Q?gkJHxgWo5HVplmUlFgGxrnzB6vhNJt2p2zEpLRuy+YQvUMpJ3jd51KJtTIHx?=
 =?us-ascii?Q?eq/K5sCa9YX6levmAII4r3ceiDyR2TVxPnmwJAPS3exl8kPDZIOVW1q2u9VD?=
 =?us-ascii?Q?DR79mdwlZp4HWdfwxJ/X7S220yvPIGywNPIrv/tzsTbmuExlpdZmwn3Dwi/k?=
 =?us-ascii?Q?NvgO6YpjFEjBJUyrSNb1Eo+UvL/oUstgM4/rZj7AYrY43vbDfslyGj3cnVzz?=
 =?us-ascii?Q?FC4O7tu1o1IUPK8zbuvH4i36mU/byGm5l1yXqV+oU67xzcWXy/fhTYKhM7Jf?=
 =?us-ascii?Q?8o+eszzYAW99UqXnfr5Nob69p9+mmu1i6M6yaKzYD/0U9bJI5s7dLZXL19tb?=
 =?us-ascii?Q?0849Q4HA+l8/ZgyUFPmTbZSIHEtJCStSrFUgdCwWWj63Z7Qg/AhLIRw/aoWN?=
 =?us-ascii?Q?/aMSsP9CWp5jCFlaNDuGtjbl7oby9vE42/TWvTQZokktRTRTvaN9w0ASFdfX?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5DamxVBdZKx585ii3atzimgjGo5sQJaLlOXR4yIdii6dvStV4zPGwWoPZ7x9fM94GDcAyMFlI5YqPjCbNYdiW9uuVNmHV7tc8i1nJ1baO3BRE+BTRrHTWHa2eoD32Vy+9CvH/az0yWCqhsYkrgdDn81WnCnDcgiySZCZE5hEZzDle/LO3cBptsVAPLjBPeHoABkdEmtqSSupMkGRfB+Z0+arh8AKyTw/VeRvSzImJmwftS4hJqER5SEc9WE2VXNQqLFqrFrGvsAXIwsXg0K7y53SEjI+WTwxdjiicfG26/mR6Hbt5v3vB9ly6DS7RmiNFssv1bYK4un+jYWXNN8P242XFCwUrt2JkNUNaO7FtoFSIIs9jn9fgCQgAHSadvF8KfanQkoZuNr3W0lD8fvNPNlPv6+u/Iludd30otEtvw3oHWiGGYC802l9kvtHXBZ7ymPk8Saiz9iNOzJFo05IaHWMOilT6cVydMynKeVOEcmMPwbFcr8cHElRTiOBMaC51Lq+SpvZxgWTcsf4BC0KT4EPgK9kQv+OtSHiHeDJMEFBhaONipa2s8KDSm13TfPDtm/IL7k4mwQ6zYymLl9/Hd2qx3wNdiQyxVwbBsgdzWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd14eafa-db77-4b72-d0f7-08dd0572a6d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:40:14.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7x/IpRvNqg5FEFNxFBj7swT6L9MnjjaakodVbjM9ORChWEL2VagOKAp4IIqggX6fdedCuA6zvjymfzb7g7I2eHHF2sHtu7GtBmhAHGgM6m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=548 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: 4ViWLTU-hk6ONoPF0yBGG2YqjZOLkZf1
X-Proofpoint-GUID: 4ViWLTU-hk6ONoPF0yBGG2YqjZOLkZf1

Critical fixes for mmap_region(), backported to 6.1.y.

Some notes on differences from upstream:

* We do NOT take commit 0fb4a7ad270b ("mm: refactor
  map_deny_write_exec()"), as this refactors code only introduced in 6.2.

* We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
  handling" to parisc, but the referenced functionality does not exist in
  this kernel.

* In this kernel is_shared_maywrite() does not exist and the code uses
  VM_SHARED to determine whether mapping_map_writable() /
  mapping_unmap_writable() should be invoked. This backport therefore
  follows suit.

* The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
  use a local static variable in mmap_file() and vma_close().

* Each version of these series is confronted by a slightly different
  mmap_region(), so we must adapt the change for each stable version. The
  approach remains the same throughout, however, and we correctly avoid
  closing the VMA part way through any __mmap_region() operation.

* This version of the kernel uses mas_preallocate() rather than the
  vma_iter_prealloc() wrapper and mas_destroy() rather than the
  vma_iter_free() wrapper, however the logic of rearranging the positioning
  of these remains the same, as well as avoiding the iterator leak we
  previously had on some error paths.

Lorenzo Stoakes (4):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h |  10 ++-
 include/linux/mman.h          |   7 +-
 mm/internal.h                 |  19 ++++++
 mm/mmap.c                     | 119 ++++++++++++++++++----------------
 mm/nommu.c                    |   9 ++-
 mm/shmem.c                    |   3 -
 mm/util.c                     |  33 ++++++++++
 7 files changed, 129 insertions(+), 71 deletions(-)

--
2.47.0

