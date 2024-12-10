Return-Path: <stable+bounces-100307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5329EAA37
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD67B18898FF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65976153598;
	Tue, 10 Dec 2024 08:05:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1B4964F;
	Tue, 10 Dec 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817931; cv=fail; b=DkV/XA0qTJyAfQP8kY47FQYv8kxYS9g3+qPorfpUt4PGfE18tvf8JG9RA6C6KPvrFsVbbmL1XrY229rjNP/BYCO9BZkcTin4hQVFuzXo7SVm92e8Ml5tlB/RBxWLjxX/iyc4r9qnGNXaR+DqbA+7z0jZbMWker0TW+qfJtcSYC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817931; c=relaxed/simple;
	bh=gh2OjsXblJ9c1ozWwe7nt35rDnBGMQ9hPnUzR+ZsUmA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PQODS7bvG7d+WMKwvrslshGmOGctTAl0diONHATX+SpxUEFXa5ZdjARcSWd3g258J8+uJBICaSfFOm2HV2/6pgeABahEOrMXcPUuHMOmV8+x318unY56eD31/LaFgUOaBDbUfccyOY5ViJZ32E2jiQNyApPaFl2jnG/kO5Rk66I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA7r0It014455;
	Tue, 10 Dec 2024 00:05:23 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1tevk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 00:05:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bck3wn0/iR9vXj2wFN0PsxqjNvP2SyCSK3i3swEjscr3NaIZn7zT64PNWO8DhB3HJCnAeIDpu7oLsi8qCYFHcNKuMtnOBrgLrUZD0xdbpKkhmPW3zcNynbHn1ggMi53JfRG8r2sj3fQloJP3LBCwADsKY4UdtsMiIUhxNykBjPzciCDdvVDC+5DUynwZtSrYxVEmyje1WKSvffIVh88tTskznRENCxIPxqgyQD/DJkdVrYBgbbKhFYHmPucMO9GT4AC3qck4VLm0wiZsIpfI3UB7AX27ZVWQPKE/j9KwnWPTQ7uJQCZhHq6+tK1ABxZV2GydYzgHDF0DO8y5anOW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uycOPBVoE64mbMD4lrXffZXP5yjo0GExpHBTdl9crh4=;
 b=bt3NYskETLVmz46j1QvRqBQbJLEHOfJTVIJnCUJKqNhHtV7H476IHSIddhwXhuZiNoyH+z5fT/13p40c3J+8n89jpjYuFXuGraZYcQUquPyXsoHVYCRk9KuCVnemRjsg7mJpKeeoyYyZWePuBjrfUT9s7a1RZJg9lu5LlHIhrLQF5e/Dr9c6OARN+cy0Axom/tva+vc1V342S84BbI6FPq+tld84y7YdEFwNhkp2B6u2BTVGlX3EFr31qKFi432HzhGNuW7S2SVEGQdiK5177fMla0uGLv8gPRj7rccrwuDlPhLj7uL2qxMjDWjNFWR3cPs03wU+esOTTOBPnLSyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 08:05:19 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:05:19 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org, harry.wentland@amd.com, sunpeng.li@amd.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Tue, 10 Dec 2024 16:05:00 +0800
Message-Id: <20241210080500.1417716-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|MN2PR11MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ea818d-86d4-4db3-8b5e-08dd18f1637e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BOc5DLk32oKC/i7C16NwDzk+O//RXjmL/vtIwlXbg4uqEZWlI3zUh2tuzxbz?=
 =?us-ascii?Q?wR9DGG+L0FLR+Lj8nxBniL3hBZuiBaUCCm/y64j6f9XykeZMd0a6txMZMbqh?=
 =?us-ascii?Q?qaCF5MSGuhsxYL+kcwtnnHkWFEgO+PNWLK3fHEVzmf0saczxL1vXsIYaOXcn?=
 =?us-ascii?Q?EV0ohcvmPznkgvPUDE5oYaWyfAVcgulXEDl/paWeAYjHA1rxddwQjYU+kQx1?=
 =?us-ascii?Q?6Zi3PQfU6kBLhbXC66LlzgsaNeoPWyaCR6fvc4W1CU20QhoNO8levlRu+5rp?=
 =?us-ascii?Q?hApzFaozoeItwgMYrEa7jW0ICpzhxZi/5B/QRSpGTA0l3E4XPM6R80Hwf/1K?=
 =?us-ascii?Q?RCWrK+AITOeprrJxH8gvJjabGydbFNHb36QtOZ/wBhcNrqMVlHeYohDRMWNz?=
 =?us-ascii?Q?14/x2Mws6jJ2HMgRvsZAXYkj17eygcHRpZFDWgFlx3c1KilnkGxdS0IDnGgG?=
 =?us-ascii?Q?D5CpYxdKUPONZpMDJ3mOTiv5UfBKOjZqYMz+pXlxa/m9BDZsLFolYif1KYOr?=
 =?us-ascii?Q?qbjdLoJyN6LcC9apJX+VNRjkcKAXYJlOlv/BdkfeY549WKJFCyRnuZ6R5NG8?=
 =?us-ascii?Q?tUZnssMeCnC9R5XhKzz0Tc6xuGC2/ozyjjhsr8jlAL/GTlKTNgi2Jiaj6qsP?=
 =?us-ascii?Q?GdL0oEsxyFQzjSHyBY+IQ0HIfF77W9+A8FG6LcBnNBNestaHm9RYNcEZJSvk?=
 =?us-ascii?Q?/u1GQz68T2XO5R1T9EF2ElsN5Qkt/vkZU5JRNKFJYt6ZGbHz/j4+EXreqITR?=
 =?us-ascii?Q?1zmKzOO5vaS3bjYqqpqQsNsXf5SDPmQRQaYnBsPgncKoOKZqCi4BQLplFCDp?=
 =?us-ascii?Q?062I+mY2aViTnJl6MOaPnaLmftBgb4BjdnfsmKgIH70vT8B5feSYjDYH8PvH?=
 =?us-ascii?Q?lwsrbEnWACHdWEr1Nq1m4Y4UfTpvpLlVcOPcxf78lyDwlb4MCTYQyXleuwr8?=
 =?us-ascii?Q?I0xjOWu2kOR82kgTge08e8cSaJam69/FxmkeiJw2Lssb2iKnJJzHOwiljjIj?=
 =?us-ascii?Q?LnZKVasZoZk1E6ObOgyBnCMMKMZmf90Kgrk+X6C7iONh98u/mBabx7OTHei7?=
 =?us-ascii?Q?zmalBiEyTIiLf2GBfQxZI/jezAZoZTImkve+VbaYlO2Sjzm2g1N3Wx4RY3DC?=
 =?us-ascii?Q?Oxg9A7hQJZmLoOfJFNbHDUS9AlSs8ldGvhfof4jzkR15LhP1gR0aEDrL8DpN?=
 =?us-ascii?Q?7dp8Uy5VvP8c7DZfPgfiSYG2E790n6fMt2/RIRLDEbcT35txIXcc56ZfDHsg?=
 =?us-ascii?Q?lU3TK55ixo1nqEwwC/467DJyKIj/J0H75ECxaGKTaAZTYs9DDdeux0ZVZm45?=
 =?us-ascii?Q?+0GVW7KdRsQoggvay9C8i+xfQC8uTJrHiEx4MuXV3/8u12DcLqE2NVw8ECsT?=
 =?us-ascii?Q?HmPKshZPvMDuZDJ6NKkhevfGyY4bDc/cI47HFIih3M6gbBBksg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFUN9bKV6IaaQxuEqkPD9rCNvnRyZeh4ZSfqfsRr0clt/V66qG5wYB1WEPVa?=
 =?us-ascii?Q?OoccIgOhE5lkPkK981QUTNH5iiffCim+CVyDU6lh2vSreC5rX5oPJ1BNpRnH?=
 =?us-ascii?Q?G4asNAYMJFD9hIGLFMe+QQ97KhD9H7va7REmGkpAa6Jm1E4sO/FeYjJOGEuk?=
 =?us-ascii?Q?LwlfzzEDLiVK+HSzrO36FMtAYoyUd85HI47uAJvW6fz1UvrNC07A9FJOwMG+?=
 =?us-ascii?Q?q7PL7ASq5Tyiwwe3iMAcaOmZl4QEjcZ80A57KCYE6FeaJNil1shFZhzcdYMm?=
 =?us-ascii?Q?+sGBl4cTnMNpzX9rbC4jdCv/wV7hdmE+N6GHWyFqKghw5b25GKtME1bOGddA?=
 =?us-ascii?Q?/7wBLyENrWjkwkJJx8kRja+Ueb+3zdrAmZMQG5hQOVvuugMHULbS+GG8+IMQ?=
 =?us-ascii?Q?RkdSPcIVgud4tmfsypeEYkx4KlqNL8pi5lD+pFIsYXS1VO2eaz3n85jtKpFI?=
 =?us-ascii?Q?Nb+eYFQdzfG3vUwK0rHwx1poZdPFPDt2GEp12hx4Ug4icp2d2JFfZy8VdDeG?=
 =?us-ascii?Q?xUChmxXs6r3zIQDavWcHacPK7bixs1NYPWpKGmSDMi8+gR5HcaM9rSCsTDsg?=
 =?us-ascii?Q?+T2aaNmARAzRwRPocvR0oOtPPNrafG/NmFTp6qZXFeD5VEUPDwAN9m/OWWb5?=
 =?us-ascii?Q?vxLAFPM3rZAHd0ffQ47aq9R1UUyFfIDtJQvgQfrvHCQn0piI6FVMLf7VS+D+?=
 =?us-ascii?Q?OruYoRockRlUE1q58EDhJy/3O0rxyZYceX9WrM3XU1JyHk560dtvl4sPqsj4?=
 =?us-ascii?Q?/xN0ql9SPr2hVZDu6IdGZ+XHUDzF/69u5TigkEGYDdtSArlCakHoxF4A/M7L?=
 =?us-ascii?Q?mlKYFi9BxCwN+rDpas8ksu9S/0t59A/XXeQ2Z/IROjuKPQF7sUNFNWz1+WoL?=
 =?us-ascii?Q?O82fTsoEs4BCOizVx15RaGacj4pXWH//qE+wTA+eRYn2TKUI3lau3Fo+8O5P?=
 =?us-ascii?Q?qg6+RXG9KQwTaUSM5D9YcUbElzifbdTouJslCkvSXtNism4ktinnTqO52T43?=
 =?us-ascii?Q?2KMChdcWoYv3LB0BS2grhwykIt5Lt+zu+fdmgAa3kgqayzZIFgtESFp5+iTy?=
 =?us-ascii?Q?T66BJFCHJ2Q7nM/n0OgZcNuDv0T3YBXwOFEa/hfnTdG29H1tg0Fhmz3t4fIp?=
 =?us-ascii?Q?I4zmA/67/oyBIj8XoGzKLLV8Nd4d6vpZmruRTIToJuwKhJ1tr+p8b+B7S0ua?=
 =?us-ascii?Q?J9WSTqA/vM72vSB1VD1wQItT4R9tGk9OvFlD14RfkquvozSijwCrohEY92+e?=
 =?us-ascii?Q?UeBJb8p6m/fITCc4GVTkVbh75yCSUaQME0wYgO3sSUQ5zcSIVXthYrAB7C3H?=
 =?us-ascii?Q?tfPbYfjP8HtguPKTaqMjfcBNq7VqAVTdDtv5Wm8JdfWGzWkzVQdkDevDrprj?=
 =?us-ascii?Q?1SL0ytRE8bG2L+hrORqxiJNNxb4hmWZ9dng9ob2zp2mQTckjThH2jfzma3/E?=
 =?us-ascii?Q?BQbyChVWsrOsKiUvLJFB5OdiMsJ+ZksFWJtpyN7cOURk1ic3x8qp7q1agxVu?=
 =?us-ascii?Q?a8IzbxuYGXlkldTUDti5gt6raBZGike9lWqgeFP9X3agUmHgPOBSbfNr55/H?=
 =?us-ascii?Q?x+Yfo5Va57Fbar53cGmdf25qLwvoC4d9siq4G9e1oy86MpQcllwiJXV3+2wy?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ea818d-86d4-4db3-8b5e-08dd18f1637e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:05:19.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BbjeKOuLNSEz2na4+0BeBDl9wVKIK09QI/EqcD9a3PuB/557toYLY0JBXSBM8diMzc+4En0EHg1xOldQfhJ0NE04kKz4FzptWSKXChQ1mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-Proofpoint-ORIG-GUID: zN5u5hPIJntbnwYufBfRRTCCrtCP8KON
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6757f643 cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=zd2uoN0lAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=sfojGrjkrMBDxRcDEHIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: zN5u5hPIJntbnwYufBfRRTCCrtCP8KON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100061

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit ad28d7c3d989fc5689581664653879d664da76f0 ]

[Why & How]
It actually exposes '6' types in enum dmub_notification_type. Not 5. Using smaller
number to create array dmub_callback & dmub_thread_offload has potential to access
item out of array bound. Fix it.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>

Cherry-pick from 9f404b0bc2df3880758fb3c3bc7496f596f347d7
CVE-2024-46871

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is backporting 9f404b0bc2df3880758fb3c3bc7496f596f347d7 to the branch linux-5.15.y to
solve the CVE-2024-46871. Please merge this commit to linux-5.15.y.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f9c3e5a41713..3102ade85b55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -48,7 +48,7 @@
 
 #define AMDGPU_DM_MAX_NUM_EDP 2
 
-#define AMDGPU_DMUB_NOTIFICATION_MAX 5
+#define AMDGPU_DMUB_NOTIFICATION_MAX 6
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
-- 
2.34.1


