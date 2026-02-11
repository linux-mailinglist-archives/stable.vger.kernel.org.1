Return-Path: <stable+bounces-215858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIXmHlmejGmPrgAAu9opvQ
	(envelope-from <stable+bounces-215858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 16:20:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC012591B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FA7300E5DC
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE228850B;
	Wed, 11 Feb 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Bazo5dRY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="CJsU8AmI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B624BD1A
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823252; cv=fail; b=grV2FZxWiR3DDblBYc/bdL333tIyHC8YySTOoiZaGZWU13OJQ08nMyv1AcO5cJFcI6bEj8h3Cc5uMetxkmnE6Pe+zmKUiI+y6A3YvCGZsWrokuMQXeefrLZLRDtx0QQqpgod1JdUp0HzaW04bBcq2un4Dre66SZADQe4DRZ765A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823252; c=relaxed/simple;
	bh=jvrHhdxRt6SxNuPvqmIvacFHrvzPOlEZ1h0rxIllsyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tce1FMdq78hCSp36G3/wHeP15Qy8nwQe8v9Wg1+QFfeDQ4OFiYc6pA7ROoNQPuv+cKwOYi3E1EkpLMC05NEmE3i0pGDtHaoMsnvxJjsDj7CANwdNexQl/WMeQvPguJdIj4FDKQwwTm4QIR2oUjSEuLh+KNRdNYm0eyD6knoghG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Bazo5dRY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=CJsU8AmI; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B6Y9Zh1457703;
	Wed, 11 Feb 2026 09:20:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=4ssUegy9VfkT/j+X
	UQqKMDu0aD57ld/0zqF/ulOYlvE=; b=Bazo5dRYz7d6Jq+myw9FZ7t4DS4hgJXb
	qHJHC5ieq1GT9URfL5Fc8U0ei+NqPhCkIu+ys7nESXkY5RZiBHdU2qMHp1SPIyxD
	bB0AG2IPXM08Kbqtm4H2dqK6XeqA2C4crk7y+RAe+MP60Z/Gpllk/8S3s+R+UPqh
	kwiX5CaQtvRQ9U5Cz1el4LiGlQKK/uh2YnQmG+k3as2tmoOFry4ol3gB/EdabGqH
	4FMAPmm4TlUrpJg4i78W+gf2ROFfOB2OlmOyBvMqZNh4aNnv5UUrZ4CJtcAXZPns
	G3haZeKHcSvfhV0k+UKcddnzvUeDVO3yEaIcz7UAINQaGjefb3AILg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021119.outbound.protection.outlook.com [52.101.52.119])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4c62pk4xnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 09:20:45 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncKGi3gJXxXD6j/qiP802OOo7cl55DoSOO5mNXsTBeb4/oZaHTXdsIykcPaEGqZVKUzZns3WhbWrEExakyitfOigkzyK736WGAWP28x8+6jygzkCNk+Q16dvfH0Lp/Z76BRthNDrW9Z1Dg54a3MD1aKO/Da6Se7htyygjQh+FUnPSTuszdCl/1M6Q8WyplBCX4PdbZIjeI08D782KLoJSDw3HyVE9gSl3snE1mGZsgu2zFwL3TuhBL04g8tokXsoFG0UVJbjjqwH520QnyjPnfLE4GyBxJ84ZNxBLtjjUPU14Wm7su8a+1vEIcdkQwp+lUUmb2Mugzt6LAtpD6J9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ssUegy9VfkT/j+XUQqKMDu0aD57ld/0zqF/ulOYlvE=;
 b=QKT+k1zM+mfWRivHgKgj7wSMcv8LmWWL9b+bEI/gt9w94hKT0kRi2tCPEZDtOEB3YLv1aIV7U+vPZMvDLzrBMYVNzxuxDIZaZV7FbQOdGbLuism5TdL2CKG0zL2W6SVJ7e91hONyR8xJlgBfS0qvGec6jUu9y6PnefpTgzfK1SmcQPlUaZ9fIuRNWENo1cM23B7rtXWeiAwyPLKmUlxXsjhryGsoGkY+aJgwP2PqsGXuQ3OFPwYs3+XBMb8qqyGg/eUvxRTC8GIvNZTw+l8mx/nc7NAMpvAbifquSxsqrbPfli4LGveA7hlk2xUTs9Xvi+K/zmYxgI2IqrniDY+sDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ssUegy9VfkT/j+XUQqKMDu0aD57ld/0zqF/ulOYlvE=;
 b=CJsU8AmIVfK5kncsHgx/CIvWQaJgbwQaJM4bPNQCzpUdItr1HFkNVAIHA7Wkg6U7D5ZAK1VKuL8GzI81Csi+rD/OzWwiDBE9TyvACaBNUhc0UXIsY2/e6mSN9Eul+VBj0s8XwQVL+W2tbLlPSkP1+taHzAKS0lR+5njwapYudnc=
Received: from BN9PR03CA0281.namprd03.prod.outlook.com (2603:10b6:408:f5::16)
 by DM3PPF95629A250.namprd19.prod.outlook.com (2603:10b6:f:fc00::747) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 15:20:39 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::63) by BN9PR03CA0281.outlook.office365.com
 (2603:10b6:408:f5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 15:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8
 via Frontend Transport; Wed, 11 Feb 2026 15:20:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 980BA40654A;
	Wed, 11 Feb 2026 15:20:37 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 97ABC820249;
	Wed, 11 Feb 2026 15:20:37 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, niranjan.hy@ti.com,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: ops: fix snd_soc_get_volsw for sx controls
Date: Wed, 11 Feb 2026 15:20:32 +0000
Message-ID: <20260211152032.1075568-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM3PPF95629A250:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e2f2031-f9ec-4811-e1ec-08de69811cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|61400799027|54012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MRnHAPMpk98dYwRTNMvY+3tiUDI9KuHwOmvl007ASUz6LwryT4bTVxLQAQB?=
 =?us-ascii?Q?hb6xc8lrXMoCTn+oS45EEHVtquR+YTASS0mBD0qoMNjEHo4Ofm4RYhbjAdRv?=
 =?us-ascii?Q?xt1OzBwdXuGcwTWJDlfcNlOZJoNt/E60T4dB8eRh11004rzjy17Vl+OGuG8h?=
 =?us-ascii?Q?/FaWOA2EhmEjTEOmyd0NYVicMBMW7ly5jsumDgcfOMbdc7vfi1dB73qcfr7p?=
 =?us-ascii?Q?Mym9kKrgkEevynCCN+MKxqysRVXstc3Dt1kXZ9Y2/O3384GCQY4hh647RIxU?=
 =?us-ascii?Q?DTWDu/uMJN2iYCi4Q+NGuSD9lMWQ5DhXJmbWHAPpICtfJVpNZAfQma+5F59P?=
 =?us-ascii?Q?EgvzLA1XFVwGaSeI3VK8EA6rpUVOP41ETEzGAfps3KDCBI1Bl1/A+muu2GFh?=
 =?us-ascii?Q?2bbICqwLqHqC+IVVlxB8WVqj1pbKnrfbMrB+mysmY8rlPZzThREFENEVeAxR?=
 =?us-ascii?Q?6pKgNLfmbuuLFDQ4HghY41EZmIj2zRkG/Kx9Y5ska/nMY4fKtluRBqN0qsd6?=
 =?us-ascii?Q?3dgdPtkZXfTYMwtjXV3VibMc14LjZhZQxucYFy4OF5u2hwGK6JgR+iqVk4jU?=
 =?us-ascii?Q?kd2gQSqCZ+KIzKBJd6C/PIoojBNEbqmMrWG96YRsRoE+R3sx1TwuBp6+gK/r?=
 =?us-ascii?Q?1hNc5bUKn2zDv7yXAFWX9tLQuKJHHAiICwJbm2rKNjXHx/Kiq08otsJRZS94?=
 =?us-ascii?Q?oYQx6q2SiHdprJ/pBz/UKhQxzW0ofT0ABmfFctkRRC88yi2q7ot2LdbGhJb5?=
 =?us-ascii?Q?xaofeudV9Ig7JzlyWoVt+zo/BINbkZ21SMviBfr6JIPKJYy7Amr0eJbvFtdE?=
 =?us-ascii?Q?BgoTZUpyFRlBtqtKxcvnTEd+TJdBD7h7zrYHd30hWWED9p0g4yXFP6VLkKQd?=
 =?us-ascii?Q?WarN0GIniWSfKn5gJLPMbIXGJjU13D8xMKddFrE0VX0y42UMFZaH8swGW9OY?=
 =?us-ascii?Q?h8Y56UIsOoYm0eTpxkChE2SUqzBfgw/P+6xmIff+IoLXqiwelQq4FIDFyMdt?=
 =?us-ascii?Q?+qVo3cHr40YZsIvssBXtGKJgXPDYUK3skoiyT5ZVj+dDqyIFdTX0uB3BkPty?=
 =?us-ascii?Q?1yR26OsECi2fYzuxjX9lvoayUXmhzpJOZUHGY9KP+Gun5K8sAVG6jvJconSf?=
 =?us-ascii?Q?5rYy7RGcXKZb9XawqPv7DOR33++k4akvKNRKreMPaO87QBqHCyC1/YZcmEaA?=
 =?us-ascii?Q?MhZgfIPSsM9KD3aJ2OaqSflF3YUWRjYbT1B8L6zlYAI64tdSnyclVGJrFT46?=
 =?us-ascii?Q?5UM2mDKKcaJRGcGgcpG+Iv/M1t2UmmOLczBNZSVPvZl/cKADoeZ9jgA3FOl6?=
 =?us-ascii?Q?Ftq9jHiEATyz2aFELL793ZnTqTwhQTrYdcW4XbmKVMwiByRxOc9P/SFEX5My?=
 =?us-ascii?Q?KaNHrths87t3fr7nb+yS+FDYdCCDJ0GrCYsoOyKUH9B/5SXB+w9G80UxCNMw?=
 =?us-ascii?Q?PFndesbtsRozlKNfV5sj5uK2G5xiQVN5DZVamsw5r94ApjVnRMLkun99sJhL?=
 =?us-ascii?Q?Bc+Rr6dnyiBASYQLb8mttUFEJplySnsGQ6prHELcQd1d13arz6om0cC96VQn?=
 =?us-ascii?Q?3UoyJ3yZethRSnvfy+MMoc5P0kbEqbO/IaSqCKcV7c47urUCkpc5XIssRHH4?=
 =?us-ascii?Q?Brw6eou9oVnNZSf7sUnWOh4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(61400799027)(54012099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	higi0GFgG+CIqKC7iHaidiOF0UdfTwKVRr8Rzd/uGaZzad4vSbz5Hyi3vgDRyy3y1s29pRRDTZtOwOjrMCEPFWjB/YVTGIvbKGloSgjIYkWJ0UtobeXV/YBC1hGvdZpbrrMrSlHZFQMsYj9XFRXsBdEQ9PyGc0qj8xdbwbhd1YR6CHZz17iaOqrMqOlUairwpMOMAGFWEgmW53uaeQWG9yu6+jCEq+I4YHmQXVLMWillOIPuJZqP2ejFkLLRuafIavBNVHsgXOEeANk8dcKfSrX1uaax5802f7cHka22TtM7d6DhH9sbVr3XuK1UZKL5ajHJeaIaGblkta9PpKLJcz+YB7wkQnaPaHKsU1+n3KgsFMMCwFtAeS08brFCFbfcv6rnBlopR9Z83pLDvqrjOt4UXFC6HSw8C4iyKVEXwUm5EzvNKzca68rTzaIBka/p
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:20:38.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f2031-f9ec-4811-e1ec-08de69811cc5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF95629A250
X-Authority-Analysis: v=2.4 cv=YeOwJgRf c=1 sm=1 tr=0 ts=698c9e4d cx=c_pps
 a=Sttmeoj8PKbKCQDeSgXeRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=HzLeVaNsDn8A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=bC-a23v3AAAA:8 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=kMRoYQQLNiL0ZyXUIwIA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: ODJqOzblQt3ZSC-GOuY5f0Mboxw_HZRp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDExOSBTYWx0ZWRfX3Er9sFpKoPk/
 qWmwcraMISkA3eugg28I+0CnzFjxdv+8Kf9BbEHPRpFhvR5WM+NfxndmIWJtlRXJydbclUiRHW8
 Zwa2kbJskE10L3c4qI4k2DR8JTqSCK+nRPDwFuWIWX1Ux2T/NEkB5xcg1fauQMLHjl9crHyAdhb
 DkZVNJoWQhoMc8g+WhAm7WDBiuZHLe6oy8Y679OXhRh/lhIex8y8yDxm6HbmV7O7C4cg7bWSBpY
 2j6hrNGKRkHqJLD/u46T2QbiakyCdabHcpfORcZpi1cB87JdWYx7nBduzaPk/bIhqjaFdVF6ard
 6dc6fOgSIcAi+Cnj++rMx/9P89Xj26qYP/Ss4Re7bbo9ELmcKHo9eecnQRkiMOY4Jhd7jSwitlT
 kE72H6Zvx5LOsYNexSLkEdONkKCkF6Jj0KYCFKPf4XIJZEyUrt5fOFpApycqKSBJ9YAD96UB40Y
 L6BJgzrkeJs3pNdQQcg==
X-Proofpoint-GUID: ODJqOzblQt3ZSC-GOuY5f0Mboxw_HZRp
X-Proofpoint-Spam-Reason: safe
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215858-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ti.com,opensource.cirrus.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,opensource.cirrus.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DFCC012591B
X-Rspamd-Action: no action

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 095d621141826a2841dae85b52c784c147ea99d3 ]

SX controls are currently broken, since the clamp introduced in
commit a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw") does not
handle SX controls, for example where the min value in the clamp is
greater than the max value in the clamp.

Add clamp parameter to prevent clamping in SX controls.
The nature of SX controls mean that it wraps around 0, with a variable
number of bits, therefore clamping the value becomes complicated and
prone to error.

Fixes 35 kunit tests for soc_ops_test_access.

Fixes: a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw")

CC: stable@vger.kernel.org # 6.17
Co-developed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20251216134938.788625-1-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This is a necessary fix to an earlier change that broke SX ALSA controls
(see fixes tag), this causes volumes to get set incorrectly on several
production laptops. It has already been backported to 6.18 stable, however
seems to have been missed on 6.17. I suspect it was missed due to a
minor conflict that I have resolved here.

Thanks,
Charles

 sound/soc/soc-ops.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index d2b6fb8e0b6c6..e2fb1b4595e05 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -111,20 +111,26 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_enum_double);
 
 static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_val,
-				unsigned int mask, unsigned int shift, int max)
+				unsigned int mask, unsigned int shift, int max,
+				bool sx)
 {
 	int val = (reg_val >> shift) & mask;
 
 	if (mc->sign_bit)
 		val = sign_extend32(val, mc->sign_bit);
 
-	val = clamp(val, mc->min, mc->max);
-	val -= mc->min;
+	if (sx) {
+		val -= mc->min; // SX controls intentionally can overflow here
+		val = min_t(unsigned int, val & mask, max);
+	} else {
+		val = clamp(val, mc->min, mc->max);
+		val -= mc->min;
+	}
 
 	if (mc->invert)
 		val = max - val;
 
-	return val & mask;
+	return val;
 }
 
 static unsigned int soc_mixer_ctl_to_reg(struct soc_mixer_control *mc, int val,
@@ -246,23 +252,23 @@ static int soc_put_volsw(struct snd_kcontrol *kcontrol,
 
 static int soc_get_volsw(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol,
-			 struct soc_mixer_control *mc, int mask, int max)
+			 struct soc_mixer_control *mc, int mask, int max, bool sx)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	unsigned int reg_val;
 	int val;
 
 	reg_val = snd_soc_component_read(component, mc->reg);
-	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+	val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max, sx);
 
 	ucontrol->value.integer.value[0] = val;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		if (mc->reg == mc->rreg) {
-			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, max);
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->rshift, max, sx);
 		} else {
 			reg_val = snd_soc_component_read(component, mc->rreg);
-			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max);
+			val = soc_mixer_reg_to_ctl(mc, reg_val, mask, mc->shift, max, sx);
 		}
 
 		ucontrol->value.integer.value[1] = val;
@@ -331,7 +337,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mask = soc_mixer_mask(mc);
 
-	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max - mc->min);
+	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max - mc->min, false);
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 
@@ -373,7 +379,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mask = soc_mixer_sx_mask(mc);
 
-	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max);
+	return soc_get_volsw(kcontrol, ucontrol, mc, mask, mc->max, true);
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 
-- 
2.47.3


