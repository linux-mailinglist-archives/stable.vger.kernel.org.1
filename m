Return-Path: <stable+bounces-95622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF519DA811
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35571658FC
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A51FBE8C;
	Wed, 27 Nov 2024 12:49:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865318DF86
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711799; cv=fail; b=T0FVD/d2eOMwvbBq0jjhYg4veqWlGCxUofIKvnEVX3ebw1uDKSJdKQP4nSmDin9LPHQ1Dj1YtgaLfx2gnay0LhWWyKGzWIFnEDpic/dPAo0EAN1xBgpDj8DJTb072nNxsc5mBS+tZUqTnv72Q1FkqaNhs1ZMNP8bMyt+Pc3Tkg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711799; c=relaxed/simple;
	bh=WhG08G8dh+Hg0x/RJhMJIVl8Mt+UWFFzkrkeyznK7DM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jx3jCtfT7UMZwQkzYB2YAzrm+fThRm9voycDs2A8f7ZHn+ytTsVjUN6CFbt6kXN3+7ACLKp1bYokznikF+G21pvYRHEQ4tSHtZwSzwEkynNLTJN4Dxow4erzn1XcIh1zi/Wj7MXGbKfouifEa6Zydqlo4j5h6B3zo6xONdrDHAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARBwG9Y026495;
	Wed, 27 Nov 2024 12:49:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491cjqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 12:49:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcJLnKc4TwmtK9qhl5aslOO0s+5g0rrz+KlUfLsHv6y9a6j5vZCQciC/BroKpCAOdbDaTQxJhem485P3Z3R4VyDAWQ2X/GFGAWhtqh0AVzbsxLePPyfhgCwoTUj2r7JttXRuDm6ZGoX7HW3a/4kL82T4VP561FDSzoJVCh5h8E/y6NAT5roRPSQjH+9ZymtZRtSR/Jn8uU09yeIK7E5ZV+pEnluheHJ6a2paCwW9oFLBP5hS8hOKi33IsGMEiaqLe+TY143xl5GBGdglTleyxBY8Kz2RMGsaMet0C+7Wz/Xk6nTvq7SoCFJKCf5KxsQVgZert85xQTJwlEeyDAcG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raXDKK3+8gXlW/gI4kRh1CuLkmB4bSivMWPyUHsbiUM=;
 b=KvkNnnImZt8+HF6UjALLim1C+w1PpcIeskQ1g9g0VCDlxzGdEHpUyNwGTAvLvsoZP21n7Ij/t2MnJNRxe/ucAjdhwkzU0+u84ijHOGLm4SjBwGkVSBYbckLt2Ml6QB6AiYjM6VhD9VLed431jdukJet8dNLB1Entw8tHdnrrDy4j/XnaPCgC9awan0KHjlz6l4Uaeu1QE+ODO3ZWFn7T98WGw6n7bWgmlPLLNnHezwVFmK1FhDCzjWZ6J0B0f2zg+srN54qRxjULWfR5EFxaUdczu9T7E5hKoZ8TaO9VLxKmZpDmncCb2VQsehwrm1L3n6w5BzDzCQCjtRY8BEvCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 12:49:51 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 12:49:50 +0000
From: Bin Lan <bin.lan.cn@windriver.com>
To: stable@vger.kernel.org, llfamsec@gmail.com
Cc: bin.lan.cn@windriver.com
Subject: [PATCH 6.6] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 27 Nov 2024 20:49:31 +0800
Message-Id: <20241127124931.847488-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac5aa4d-356b-41e1-f80e-08dd0ee1fb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPYOVcAQk+TyHQ2rXBg6OcnL2nxnt9aiOOJzjSQtTAPWXCvQ8+QuVHjV8ujA?=
 =?us-ascii?Q?71S7cNchyoe3uIq1ONG+8dM2c0BV3S7UjKPCqqFKQKwvaVHmpRfhTw/b/MFE?=
 =?us-ascii?Q?WPv334AVUfI8kWY0nqgvKJan6UE48vRW4IIdckIQ9A0sdJGHEjFvxP8AOoVt?=
 =?us-ascii?Q?w1tOgxxrrXdIe9RStjim7ibKVxRU9Vu2NdSEu5vFLpVjQmTxHd7mYQ5eyDuX?=
 =?us-ascii?Q?1S7vC9oJJpKYoHuPLV9wk/qoizgC8+kMIhjX4qr1BYeuHIjFhn8LJogIsssw?=
 =?us-ascii?Q?DZsXcP1u8GzJOnXTNiDZl85XnJKmi5gWJs/Oj4uFa8L4jNyV8K7CAEtPr7AJ?=
 =?us-ascii?Q?c2wlmTlLAO8AeWm4mEeZWnJClRguz+koxQwPLCDPBDaWkFjAbWyp+qmbsl6m?=
 =?us-ascii?Q?vOjACL7L8ydupp86PYVTzPLPyH/DlBMOlGbnZ8RbXJKx3lRHN7WZ57EUNKxj?=
 =?us-ascii?Q?dKuucerDZw3lNx5rDJjJ9wI5NrEjx16hrjS4z0sKEKH7hfEArt/z2bSDInze?=
 =?us-ascii?Q?RrV7CSECBUjtuVPce3tOT6KXYJQpC4QzuJvPyD1uvnvSjyNAWowqoEs7sCZz?=
 =?us-ascii?Q?r+ioc24mRMEhLWdGcR7lzvzqwosSXL4+2HKxqkE68MPZeSs+dabZauMVA6Fs?=
 =?us-ascii?Q?7jRzAxbxg9AyMPRUFfhsCBLITZNusZJdWRLUQdULImveejDPdxaKAK2sznn2?=
 =?us-ascii?Q?X90moNlFq+Zp5aK1LkfYjBDMxecGbaiAAJFmWmYGXjy/l0d9hrZgBN5AugId?=
 =?us-ascii?Q?9i1v3WxUiA+tiKDMo7IW8dLFrUha5uAwpC4hOyJITawVUbxiRb3ht4Mu9646?=
 =?us-ascii?Q?BFwWksSFWY+UYmeV3cCJA6pzpocJgeGQu6CUnkiF/tGKCwM1MILa5ugCFAGV?=
 =?us-ascii?Q?YDgPy9lt7RrjLjl+xlTKjEvq/MYC2Zpda+I11BY89Ax8wSHcgMt6IclE6kxd?=
 =?us-ascii?Q?qbdKqyvgEFkX6IEE7MNi3HTFZ4h+wBh3WQhkbGrUvG5DIxrJ7EjhyqBBImfU?=
 =?us-ascii?Q?YQ/eUG5gAgDCyvWqleCK2xutzPMh7saGuiTtw+TA4wMQvXog3tN0XY3juAR+?=
 =?us-ascii?Q?B0hRDwdnoHsqwvwTqe/SWw2LvMcj8iJzamaHbF1zzkF/eMbDJ0QsfCLvEP5l?=
 =?us-ascii?Q?Wj1wvHWzPPtzkBZxjtMyXmqDQ3g8lN+TKbsACzELGkYRqWSRcWMQcnxwk354?=
 =?us-ascii?Q?3ecs0K7Mpc32wpDJBmadY1G8aZfzJEVU9qJIAKNndGaXjOouyO5PhmBXX79s?=
 =?us-ascii?Q?5ZuCqSw/ZTx5Ai6aDNvoc5wvZivRKTtSE2zJvtf4ej6gD+TkMn/adLkpTRUs?=
 =?us-ascii?Q?eqnSzioxcXcXWboCvJ23An2gV2O1LWX+yHAbu7cHzZSeUmv0lQMRK9Ul5Djt?=
 =?us-ascii?Q?/1MkxympWbRgDt9tRelBPF0XkkkNvzagqpsx2vMP41MuRpNemA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/LhkTsg6r43PmDPJrXRpflnAoFvBZDTuMEV/CX5Ak1rbUZsn8WSMlBvc9AW?=
 =?us-ascii?Q?mwVrK2fWCJTtm/DGTbcDFQeM8iAeiOF3hECb2ljmFsmLmugUJjGcJDojtaK7?=
 =?us-ascii?Q?VBTtvn+Hl5cCLL2ufMq3sHJKqB/dAcvXaHfms6UbqqFCgc8YrIJ4hkPMmP2r?=
 =?us-ascii?Q?rwklhtAObHfOoGuE1nRR1Akb2el+0JAHIimQmkEvrHYz0dcSPwz3Kf8KKSVF?=
 =?us-ascii?Q?NRT7aFvJPmJ+macTuYEUu9ApO5k853mY/NCSQO5BgSpMnTNJIOIm5hK0C2gT?=
 =?us-ascii?Q?dgaNYZeUQqSjMGeZA4qEJw92sEIYED+398uIu0IGE+xWovlvYHCbcsBm0X/E?=
 =?us-ascii?Q?UdjBMvkyhFeJ9iWghWKYzMcs6yvvvNcwZtmZJB7UkvCdjHFevwSSy3KTEL3j?=
 =?us-ascii?Q?wbt5HYQEjfS0HfnKaWQVZbcV9vKv+R2TIXDuP84YkAW6tyP3gICsbV5pOWzA?=
 =?us-ascii?Q?1hLEQUm8bkhbX3PItcabK0/o2+RS/muEFAt0kDJhkPhPoJuTXDV3YphmXIG+?=
 =?us-ascii?Q?C0X+K1WDwidR/pwyok72Y1T3aTfsOcbnnNLe/itBG0EOCSFpxX0Q9PP/eCln?=
 =?us-ascii?Q?2pXdEi5fokhHxkqE7sL+sF+Pi/e+iOc+h7VqX7uGzg+8CbolQTbCzD9rF7N/?=
 =?us-ascii?Q?ciFUIvj26dJXt6V8KyUZ03Si4VFSugNETtgwVQqgAmfD2wgkyYSfXI/5Dcfa?=
 =?us-ascii?Q?bVtPLt8aVPuUp4ir8chwCAqeW8IL3ojLRkN34d6KVQfMRolnhE3grNuLYqQF?=
 =?us-ascii?Q?LJSyyxIsjZbNW+TBA6aTsoIBcMnwfZhKGO8y0P2RnQqdkptVDcPfhysTOsT1?=
 =?us-ascii?Q?UZtoYVOOqMMpmyMyooFu99S/ETmRNET1sdKYmxGNW/ILKjRAtD3CTqfS7qrP?=
 =?us-ascii?Q?joJEO7d1vRTc7vPRYyc7bsQIJlsj7w5v9ppET1rjGJK2kKZXEhs5v3Xqh4iS?=
 =?us-ascii?Q?VYuoEYlEvuN16WE79t+pxLnLndOd6ojj18FG5wPASCkog/hkMVTxesjppm5n?=
 =?us-ascii?Q?58b2j5KJprfuVkQhX9cIugpRXTE3PI4leOwbdTflW4Pu7nORHVyUFqXCvyjH?=
 =?us-ascii?Q?9CVcxZMq1+N7XAY0Mx7xVPfZdmw3TnevtOKMqODO0uzThJYq7qr93iBPdUlJ?=
 =?us-ascii?Q?tMzNVD47N6IOA7jCQopJGWMcwZaoLU0d2iWaHBD4dtdqI/wWlWBqQWMVHhp2?=
 =?us-ascii?Q?L0yup8nyB5hpMjy5g8uXXGSmasVdT+zMdY3Ofa4b0cDPZOSxEjWkhsumyb6Z?=
 =?us-ascii?Q?1bR+6vN2do+PpOIOlYf6/xuDKpQLAuQdAewfjM8g8Eg7pq7LHpssbJKCg2ui?=
 =?us-ascii?Q?Y+2hDCerCa1uIM6zMWS4aYJe72kJAS+72ZyIGoZaFzRZFDLVhPFOVeoIYazn?=
 =?us-ascii?Q?3pFDFVn2SIPMA9TD8W3JYr1J9MS9OCfwOOVBKXX+kMmaqATXlHWKA64zipil?=
 =?us-ascii?Q?P9jJkBIWJ8o5pcQ451yKjt3rYI6ayBAdCG5PNqD87sDQDJEq6FzVobGZV/sg?=
 =?us-ascii?Q?0TAdOXxYqOoKZVij6DOr2IE3MiFmdD7bDoILnf3Hept8V48TEtLYdtl0VHhv?=
 =?us-ascii?Q?2qxpnpkiJXFMrNx8Ymnpbhbten+s/TfLFFNoy96l9ovOTXWYTc/JY/1xgGmv?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac5aa4d-356b-41e1-f80e-08dd0ee1fb36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:49:50.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhN7/IfrqoP+U1dT31hyecrBg2DZeeKDbm32LlWILUXs1rMaf9x5TweioqMrbcqX3VX6ehtASyZflnjeFH1TC8NbdygHXAzzli3Vg8FipqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=67471573 cx=c_pps a=dbfzVNK0jQbpEhEqKt7tuQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=gZ8OVRd3LIMJ4GaTPUUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: qPGOfeBt5bGZmildanY7TSCGP9b7zN55
X-Proofpoint-ORIG-GUID: qPGOfeBt5bGZmildanY7TSCGP9b7zN55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270102

From: lei lu <llfamsec@gmail.com>

[ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]

There is a lack of verification of the space occupied by fixed members
of xlog_op_header in the xlog_recover_process_data.

We can create a crafted image to trigger an out of bounds read by
following these steps:
    1) Mount an image of xfs, and do some file operations to leave records
    2) Before umounting, copy the image for subsequent steps to simulate
       abnormal exit. Because umount will ensure that tail_blk and
       head_blk are the same, which will result in the inability to enter
       xlog_recover_process_data
    3) Write a tool to parse and modify the copied image in step 2
    4) Make the end of the xlog_op_header entries only 1 byte away from
       xlog_rec_header->h_size
    5) xlog_rec_header->h_num_logops++
    6) Modify xlog_rec_header->h_crc

Fix:
Add a check to make sure there is sufficient space to access fixed members
of xlog_op_header.

Signed-off-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/xfs/xfs_log_recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 9f9d3abad2cf..d11de0fa5c5f 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2456,7 +2456,10 @@ xlog_recover_process_data(
 
 		ohead = (struct xlog_op_header *)dp;
 		dp += sizeof(*ohead);
-		ASSERT(dp <= end);
+		if (dp > end) {
+			xfs_warn(log->l_mp, "%s: op header overrun", __func__);
+			return -EFSCORRUPTED;
+		}
 
 		/* errors will abort recovery */
 		error = xlog_recover_process_ophdr(log, rhash, rhead, ohead,
-- 
2.34.1


