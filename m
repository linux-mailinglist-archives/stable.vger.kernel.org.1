Return-Path: <stable+bounces-126687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA59A712A5
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 09:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7227B173FCB
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D61A2C27;
	Wed, 26 Mar 2025 08:31:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681C1A4F2F
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977904; cv=fail; b=Jnkap+AUMEnmAwu7tXYYO1J7KGHRXrX2tS+xs+iS3gQY0jA5LaBjr3604r6dTyZ9MbE6UEAbJ6q3gB/6l02r9AyqkFXTmHTR071irDbhhqU9EhVoz7LHlsKaWyYs56WWGmFAViZVa7HtOM9jmJBn9OjboLS0qsy6wgRGmmYAo5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977904; c=relaxed/simple;
	bh=AC6rtSGHjl3QBbtA4bBNr+BX9yWIaYTrCfyZU1LxRkE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Nsaz666z0/0eJHtVvxF6DRezLa1hatsmn1r8URioL83t7Kom0Dimal/P1oP9qlkihduWRjgekAbloM+EHevUcXkm1uopX8SAZJRQF/TPCH1IaU+2h7NKvY2TDt1wdZs1Gcyo2xaOagOg2xGMnBxqZICIRe3hvJI6QBXMCSj79Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q6PHFC011964;
	Wed, 26 Mar 2025 01:31:24 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkc4w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHcl85uOFsn3fHIKrgazV0qNvPJ9lMIlUB8KEl5/I79xo39LhxuJzfTRadeRvhexGQ1vEjI4AHkUxmukmwwtRHPZs5ZXlIrBCe2Ps6X6wDSbsD8Z6iP9WtzLOPVYGa/l2yIlGguCc/6GOC+L0i3KCX47KLMlPfg8r97UTL/l1SNRpor/C0nY6tBLj5BWJh1A9OP989bOOMec1Yp6VEJHHAr9rFiFnVRca6G4ITD9+LQxVQJKtBU2kMhwOeGi4a0W5W7iTml1QRaCaZse0L4Yuu16lUXWBQP9CTYhki8L7+ZcOtOIpY8ZgA1SKOsfInQLwKgOEmKllu3pRg8I4QnQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RKQTR9HFv8qcchtGvZuLw93ibYoNXkEpF/i8KE+0dY=;
 b=X4wECu3kTnuYv3ZrfyzbTGtea4Q9tgL3QVTK0piQrOREXaV+yCQDkjz7f+XnYst6B3I5xcuggQOXxPM1JW7OY8j0kk7hT6vX6Ew/Lq3Pw4DHcp9YaD5GTCu+KAFb8FDVGOW3icadj+y/yTsQ1iUOa+wUQKVGku0d9M/vmPOfpOo5V/Nkp8qnqsYYA9W1Foi8Je3aB891rB1/NJBv0sUbeO1rkeWlt0OnTosjGiGiPCQSmI7jBgjFAOyJvZmG8lxGVkMR0pIH1uUBuQiVuqwRYz7zSdQ9j7RDeL/qe9dKED5U1nSUC0w49J4SFysiJTGkttNPig18Ed5QRIRpZhOrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:31:20 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 08:31:19 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, stfrench@microsoft.com, linkinjeon@kernel.org
Subject: [PATCH 5.15.y] ksmbd: fix potencial out-of-bounds when buffer offset is invalid
Date: Wed, 26 Mar 2025 16:30:59 +0800
Message-Id: <20250326083059.3723005-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: e95367c1-940b-43f8-906c-08dd6c40954c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6IWS45RM7JUYbEYoiUIukf3Fi9ki8Wd+uuSQ7dXLojkldgdb31ZO1nLQqB9?=
 =?us-ascii?Q?4/CCSCExnGLRXNM/FC4vTiNxcWnchA/Zh/45Cg4oa0Lwf/D2ZQhl456CrGiZ?=
 =?us-ascii?Q?ud6QXRn/LnutRq+fTyWM5lwyopAmN2Xl0Cy1P1rOoxjw65zDo0Hb4vlkrfP1?=
 =?us-ascii?Q?shuGMoFpAerjsXZd0LB0Erz8blskR6nJ0w1ElkpxtKuoolWcA4t2HDJZ+A0a?=
 =?us-ascii?Q?VgmB9xOTpyJU6HLabrED5eRdWKZax6l4ki2U6w40HGcjp50hoeISRljFV3ho?=
 =?us-ascii?Q?alQKmHPXoAm/tjJzD8n6Qo4S5Q6+X3XSogZiwQBpBXsddqDLi5DNdHxwrWyP?=
 =?us-ascii?Q?omOcRAmGMhzwCVWpwHbKW0s5pXaM6dLBF6hW8J3KtDd3ZiY/6HoWnjjWtByp?=
 =?us-ascii?Q?ZDAhW4L/5MHmJbTKKQA83ZtrdpZlTQ5xFIi1hulAYqIs3qVDhCpEtqxscgiN?=
 =?us-ascii?Q?Qn19Ec/HuZNY+nNtgfDaPW64w0Gv7F9fkwsIXO8NUgf+PjCJWV1VJLmiytDh?=
 =?us-ascii?Q?NtS4FqH7ki4hmSEQxQ9NaKj/5U9HdKm6ubw47l7aZQzBRVLuQPh8gH31C8Np?=
 =?us-ascii?Q?iPXWr8sFG2lmbcO7TU5nkirYAWCF8v8GsVNWk4my4Z90daqvG1wgLXqwbW5w?=
 =?us-ascii?Q?krjkbepLA/xgwZBD5OEuWlJPOCIwgUN3BsZpf2DjERiQGZgyNbRLY7NMq1TY?=
 =?us-ascii?Q?AHaEQyj+FCHiOtlTElyIwCWD/lFrqQjmIqPKAhUzBBN29CVIKSzLujJLRowA?=
 =?us-ascii?Q?GwRDaiXn5ByJvknS9S8XxHLAGdC3eoS1fiIUHZQVLE7heyk6HLiApOp550uR?=
 =?us-ascii?Q?u5mYi/sXux18uxIT0Rvt+GzHjtlG7etudomf+PqHSAe+oq0nPyy1cjZX0d8K?=
 =?us-ascii?Q?+M/WrTCm68jXufyxsMoXiXByn7MO8AMr8SPIxMi2Hwv7i9vBMBjcoIIp79ZD?=
 =?us-ascii?Q?nQqLH+eWMy1a7e4qs1sgzAEsLS6noghOF926iLzleFrASEUp5Vp+COsnMkCv?=
 =?us-ascii?Q?QrqXcpCaXj9jw7WdgKYDUyMNOGIDQ6VOeS7LHybcALU+uAGHWA3LsI1NjvAv?=
 =?us-ascii?Q?1i+Vc2+M7oOUHhI7qOSiG7bNafebhRCkP7hBhQR5ypz1kDrpeAFUoiS/PdqH?=
 =?us-ascii?Q?JEVRERadkTZe1lasCQ/he5XGD5JcLtlsNXSCsvG4B9OUFOsxIRf9ZZiidRal?=
 =?us-ascii?Q?u8PsgVq6YDNhuqiIsR/g4rNKateML04+iUq2LJkbyvyQPv2pWxQFxiC6y0+Q?=
 =?us-ascii?Q?cJrrdOb3t2/a0d0PLXw+8kw64KYzy2/Kyj5S1xsp1CU+PXaST9CHdZ+4/V2H?=
 =?us-ascii?Q?jMye4IdXTrEod+qq/aPpcCK4kvKH8YPKvXIPda6IcPnZ6IOqPE8Iv7Z3rDG1?=
 =?us-ascii?Q?ZSnSLQheDuQxlQIc68jLpwp8AN/U/aWxGN7749o8gZRjDBUNeFwhZq7FhN6f?=
 =?us-ascii?Q?LKeyel2yZZdKYV5d0hjcdWkGextKuC0V/hyUym9Of35zXpYTSMStUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVuK5y2bBXapEJVPpdJmjTDonFi/DPq03ERqkMvWX2tP6/05Z2dcFlOb1KKM?=
 =?us-ascii?Q?/zSyNkJqDOfOA59hMKcFEhyzMZH9VIgtpO2hU4LaLlf0B3aios+mNFgx53wO?=
 =?us-ascii?Q?zAounDrfz13428ynQYQ6cPZZbPeu1wcGp9A3Wm+hmUMutnpr09F0DybBqRZz?=
 =?us-ascii?Q?yJfHVRw08Pr3Hc/spOSUNL/HN2Fs+xVqN3hkbGdJY4nzngWBPxwG+mj7LqSV?=
 =?us-ascii?Q?1oivvQJMKkM2Lbk+smRhvN/fLDB+jR5nau5q+KJi3Z2Z9/SDNv+jMiBZYogq?=
 =?us-ascii?Q?vM7ew+j85KR/iu11XoMx8HlemE+9okf5/UTLkGQ/10H3683nB4zViCnFDnV8?=
 =?us-ascii?Q?7MldSP4B0hr4Sp3h/oRkIKXEt3oAVkp7pinFwkGS1TefYtreBfra4s2Ypj8L?=
 =?us-ascii?Q?dBRKJcP5h3RxS2b0/2UqMHY4Sh2aTYwkQ9+nJ1zOgIQK767v6LtAOnm1B3yg?=
 =?us-ascii?Q?ei2EMUy3erdXYfk7B3sOia0t6eKRYLYlTMtSudE4ZWYJUc0UAvPeCdOMF/ys?=
 =?us-ascii?Q?s4AsxiIatKGsmEqYri9zgWQ1zd/JzPPRY6o/qsAM3v2sseF0izFJIOPzaRqn?=
 =?us-ascii?Q?/t7l7NCqXWJux2wiodYDU93bNessipgoX+45t16hgt7dn3SleCH1nlUfapZs?=
 =?us-ascii?Q?HMSqd4CN8XcAoVoHwlsGGWFa255QwcW8E4bmzBj7k3s9pSKM+ERZU1f2n3n7?=
 =?us-ascii?Q?8Y0CE5u+Tz2XwBHHHJnMK5/jLREdU9JCJdQt50MHb1khbifxAJZxEpit4c3d?=
 =?us-ascii?Q?zqb+xXXZsMZv99QVlgpc6/yRsL+ipjcB5dAFYnEa+7huIppLf1GJEcZRlWqi?=
 =?us-ascii?Q?WBzoY+MTsOmuLEkF3ohz4WQagsM7UxsOc6r1GCtC8Zcvp0AAWJaxTALpFivk?=
 =?us-ascii?Q?cNkYUcrjOIrVTv3nslVEvwu18zmj8crxAoIscntkPOvg1b5uCcEmjiEpeWrB?=
 =?us-ascii?Q?n9hcl3fZEXHU0ZRdg9WQ8Z3bRXA9nAT4X/5TezkvY9g0KW8zNDIaRKhAsi9d?=
 =?us-ascii?Q?38sA7Gfa+7aVavLxZiAfmysA8PxE2t8quee9X+JX44iSxGvmWY5f2Q1dp4os?=
 =?us-ascii?Q?brYiBHyt98bn5u5HTJo8ak++zuveb+wzKv+jq+4E9SsJgPyYw3Ck5vhEWNc/?=
 =?us-ascii?Q?R7u/MBv6geOCno/5jipTDrc0F/R6kEViSbYfi4K6O8iMdg0GW5j+bMlge5B9?=
 =?us-ascii?Q?70H8Ezqsz3645ODg7aNksIolfgibHIR+PEqPQigkf1v/ShTZVmcffhwTL9NH?=
 =?us-ascii?Q?9So6xuuBAYtyAnczQYURJrkHoEnt3AjLTLg/hKlljQWXvBqmCQiA1Wdzv0py?=
 =?us-ascii?Q?VpRBno6N+KrH4jDmQQT8unluNT9ccfYIq9HQlFMrWKwjryjtd4RcQ9XebJS8?=
 =?us-ascii?Q?3LCNivGRZ4/sI5uuYRtJvSWzdiaxCr7TfJN4SKN150F+1H0tvGWPdUlCiKm+?=
 =?us-ascii?Q?W7hVHT7fJakncGAuh8bRM7VHaM59MPj/IzOpsQPkJeTLbwCZpwyn8z90gZ9C?=
 =?us-ascii?Q?1c0mZ/ePZcaipNI8lJwWsyeSCWXBbDBoQV6MKWPS+x8/HsLyW6hfCSYIDSJP?=
 =?us-ascii?Q?RTH6KQ+1014LJpkvJg78C74rADiAJ02FJ1fLY4csGj+3X7e5rGy6sQNVta4i?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95367c1-940b-43f8-906c-08dd6c40954c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:31:19.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq9vuXKWGX4/sE5NDvw6oTYmGP6EyLUaVuREtATuh3aecIU8fq0hxjfuMCHwn4cPqvrCE7unbPHzBF2pDhVmiGlCpMEQC8oFdTgNSlLLRuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e3bb5c cx=c_pps a=R19XVbJ/69TrMGWtO/A4Aw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=t7CeM3EgAAAA:8 a=qC75Onc6s1Z0p8I1e1oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: rQNO0Lcvv8mZhIP-5O60R3awCMp_cVEm
X-Proofpoint-ORIG-GUID: rQNO0Lcvv8mZhIP-5O60R3awCMp_cVEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503260051

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da ]

I found potencial out-of-bounds when buffer offset fields of a few requests
is invalid. This patch set the minimum value of buffer offset field to
->Buffer offset to validate buffer length.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/ksmbd/smb2misc.c | 22 +++++++++++++++------
 fs/ksmbd/smb2pdu.c  | 47 ++++++++++++++++++++++++---------------------
 2 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 4d1211bde190..9e54ecc9d4ad 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -102,7 +102,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
 		break;
 	case SMB2_TREE_CONNECT:
-		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset),
+			     offsetof(struct smb2_tree_connect_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
 		break;
 	case SMB2_CREATE:
@@ -129,11 +131,15 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_QUERY_INFO:
-		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset),
+			     offsetof(struct smb2_query_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
 		break;
 	case SMB2_SET_INFO:
-		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*off = max_t(unsigned int,
+			     le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset),
+			     offsetof(struct smb2_set_info_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
 		break;
 	case SMB2_READ:
@@ -143,7 +149,7 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 	case SMB2_WRITE:
 		if (((struct smb2_write_req *)hdr)->DataOffset ||
 		    ((struct smb2_write_req *)hdr)->Length) {
-			*off = max_t(unsigned int,
+			*off = max_t(unsigned short int,
 				     le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset),
 				     offsetof(struct smb2_write_req, Buffer) - 4);
 			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
@@ -154,7 +160,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
 		break;
 	case SMB2_QUERY_DIRECTORY:
-		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*off = max_t(unsigned short int,
+			     le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset),
+			     offsetof(struct smb2_query_directory_req, Buffer));
 		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
 		break;
 	case SMB2_LOCK:
@@ -169,7 +177,9 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	}
 	case SMB2_IOCTL:
-		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*off = max_t(unsigned int,
+			     le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset),
+			     offsetof(struct smb2_ioctl_req, Buffer));
 		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
 		break;
 	default:
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 82b6be188ad4..46fd8d5a2047 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1971,7 +1971,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 
 	WORK_BUFFERS(work, req, rsp);
 
-	treename = smb_strndup_from_utf16(req->Buffer,
+	treename = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->PathOffset),
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
 	if (IS_ERR(treename)) {
@@ -2718,7 +2718,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 
-		name = smb2_get_name(req->Buffer,
+		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -4090,7 +4090,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	}
 
 	srch_flag = req->Flags;
-	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+	srch_ptr = smb_strndup_from_utf16((char *)req + le16_to_cpu(req->FileNameOffset),
 					  le16_to_cpu(req->FileNameLength), 1,
 					  conn->local_nls);
 	if (IS_ERR(srch_ptr)) {
@@ -4350,7 +4350,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    sizeof(struct smb2_ea_info_req))
 			return -EINVAL;
 
-		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+		ea_req = (struct smb2_ea_info_req *)((char *)req +
+						     le16_to_cpu(req->InputBufferOffset));
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
@@ -5956,6 +5957,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			      struct ksmbd_share_config *share)
 {
 	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+	char *buffer = (char *)req + le16_to_cpu(req->BufferOffset);
 
 	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
@@ -5963,7 +5965,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_basic_info))
 			return -EINVAL;
 
-		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)buffer, share);
 	}
 	case FILE_ALLOCATION_INFORMATION:
 	{
@@ -5971,7 +5973,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_allocation_info(work, fp,
-						(struct smb2_file_alloc_info *)req->Buffer);
+						(struct smb2_file_alloc_info *)buffer);
 	}
 	case FILE_END_OF_FILE_INFORMATION:
 	{
@@ -5979,7 +5981,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_end_of_file_info(work, fp,
-					    (struct smb2_file_eof_info *)req->Buffer);
+					    (struct smb2_file_eof_info *)buffer);
 	}
 	case FILE_RENAME_INFORMATION:
 	{
@@ -5987,7 +5989,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_rename_info(work, fp,
-				       (struct smb2_file_rename_info *)req->Buffer,
+				       (struct smb2_file_rename_info *)buffer,
 				       buf_len);
 	}
 	case FILE_LINK_INFORMATION:
@@ -5996,7 +5998,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)req->Buffer,
+					(struct smb2_file_link_info *)buffer,
 					buf_len, fp->filp,
 					work->conn->local_nls);
 	}
@@ -6006,7 +6008,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EINVAL;
 
 		return set_file_disposition_info(fp,
-						 (struct smb2_file_disposition_info *)req->Buffer);
+						 (struct smb2_file_disposition_info *)buffer);
 	}
 	case FILE_FULL_EA_INFORMATION:
 	{
@@ -6019,7 +6021,7 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_ea_info))
 			return -EINVAL;
 
-		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+		return smb2_set_ea((struct smb2_ea_info *)buffer,
 				   buf_len, &fp->filp->f_path, true);
 	}
 	case FILE_POSITION_INFORMATION:
@@ -6027,14 +6029,14 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (buf_len < sizeof(struct smb2_file_pos_info))
 			return -EINVAL;
 
-		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)buffer);
 	}
 	case FILE_MODE_INFORMATION:
 	{
 		if (buf_len < sizeof(struct smb2_file_mode_info))
 			return -EINVAL;
 
-		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)buffer);
 	}
 	}
 
@@ -6115,7 +6117,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		}
 		rc = smb2_set_info_sec(fp,
 				       le32_to_cpu(req->AdditionalInformation),
-				       req->Buffer,
+				       (char *)req + le16_to_cpu(req->BufferOffset),
 				       le32_to_cpu(req->BufferLength));
 		ksmbd_revert_fsids(work);
 		break;
@@ -7567,7 +7569,7 @@ static int fsctl_pipe_transceive(struct ksmbd_work *work, u64 id,
 				 struct smb2_ioctl_rsp *rsp)
 {
 	struct ksmbd_rpc_command *rpc_resp;
-	char *data_buf = (char *)&req->Buffer[0];
+	char *data_buf = (char *)req + le32_to_cpu(req->InputOffset);
 	int nbytes = 0;
 
 	rpc_resp = ksmbd_rpc_ioctl(work->sess, id, data_buf,
@@ -7680,6 +7682,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
+	char *buffer;
 
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
@@ -7702,6 +7705,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		goto out;
 	}
 
+	buffer = (char *)req + le32_to_cpu(req->InputOffset);
 	cnt_code = le32_to_cpu(req->CntCode);
 	ret = smb2_calc_max_out_buf_len(work, 48,
 					le32_to_cpu(req->MaxOutputResponse));
@@ -7759,7 +7763,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_validate_negotiate_info(conn,
-			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_req *)buffer,
 			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0],
 			in_buf_len);
 		if (ret < 0)
@@ -7812,7 +7816,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		rsp->VolatileFileId = req->VolatileFileId;
 		rsp->PersistentFileId = req->PersistentFileId;
 		fsctl_copychunk(work,
-				(struct copychunk_ioctl_req *)&req->Buffer[0],
+				(struct copychunk_ioctl_req *)buffer,
 				le32_to_cpu(req->CntCode),
 				le32_to_cpu(req->InputCount),
 				req->VolatileFileId,
@@ -7825,8 +7829,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		ret = fsctl_set_sparse(work, id,
-				       (struct file_sparse *)&req->Buffer[0]);
+		ret = fsctl_set_sparse(work, id, (struct file_sparse *)buffer);
 		if (ret < 0)
 			goto out;
 		break;
@@ -7849,7 +7852,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		zero_data =
-			(struct file_zero_data_information *)&req->Buffer[0];
+			(struct file_zero_data_information *)buffer;
 
 		off = le64_to_cpu(zero_data->FileOffset);
 		bfz = le64_to_cpu(zero_data->BeyondFinalZero);
@@ -7880,7 +7883,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 		}
 
 		ret = fsctl_query_allocated_ranges(work, id,
-			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)buffer,
 			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
 			out_buf_len /
 			sizeof(struct file_allocated_range_buffer), &nbytes);
@@ -7924,7 +7927,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		dup_ext = (struct duplicate_extents_to_file *)&req->Buffer[0];
+		dup_ext = (struct duplicate_extents_to_file *)buffer;
 
 		fp_in = ksmbd_lookup_fd_slow(work, dup_ext->VolatileFileHandle,
 					     dup_ext->PersistentFileHandle);
-- 
2.34.1


