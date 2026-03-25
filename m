Return-Path: <stable+bounces-230290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA8IMuOqw2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:29:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBA3223BD
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2324D30B31BB
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8023B612;
	Wed, 25 Mar 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QQqzUhuc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515913537C7
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430618; cv=fail; b=GtuzoLD6XojXZ0KFkio/So3k8EO/5Tw3LegnSk983yFziudYOeYTxgauU0dUHPlX9tj7I2oA54ff2hwhrDyfxIHHhXW347nR63NDE4QUGuChmfddpt2Gjo+oOtr+/s1ditk7gciU6crO56LEx3p/Qeg0j5lfZ2v0DLACI5hk9z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430618; c=relaxed/simple;
	bh=ySSZatwkdLyhl2PJRkd+tkIJI3fCrIZlY1tqhDIb7Jw=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y4oIHmV7eFka4l62tYWiVKrhbTMenA09tW01+kgiWvtu9wS499ZDCpD8+QERvOGTw3g14s2E/6qNmkMV5SaXzyJXCGOMGXIz+iC7BRtj6yNFLuk5QTzEABWQQYgN1rbaOvOv4ws7/DaOCzL2uE+UyAM2bumAxCBaET0W9pqqNBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QQqzUhuc; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P63pX12104771
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=thQY2C4Dyf/yz/Dd0+dw
	dzQJ/YYUteqgASbmN/IQ7mA=; b=QQqzUhucYDRShGeWK9iC6Xqn0EQrCR8kTw7p
	6qgkT6cjoMD2WLeMxlmbKTlf225g59S8yvyjqxCuUpUqlC6FSTcV+Q+K83Xs6CW5
	fi8gPiic5VHRuVhFADGEAJ0yEzWmuLh0M774OQ8CWAttH+aMsFHumXSLvKsAxvGL
	GhnvmjmnxxBfSEv5G3X9dQoHbZ/eF1ju8YV72azNo8CpNGZlk/QtQ5yjFNOjEjmL
	8ISzzHmxgR0d33hIHy+O13DzSp/kWxxLMFNk+JawygHLljiEV4YtcupZ7PKsPzTj
	/nas4Oc7ZFqUGtcNhecE6bbet2SXy5358wl4ycK3FlBdwDWotw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vrbs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2DrXnZJppSA7FBqfTuZ2uJ7AtvtYrZg4oMohnK6dUd2INpNPImA9DWVqM04BSFlUM5tUmAWe34jGuWC7/p2bmlaLpmQzpmne3Y7PK+O77xW9eHINM+E17k7njOFLUBqTumeMu05OAZhFpeBhndA8S+BnuNV0OuoeaWoQPVxeDFQWYoqFP8yXp0AQl4p/X7p5XxIBjW7dbk0w/XuEmlr9jlxQi0jBldX7C6v+sG3ILK97DQ9gM7SyG3YrPSboR5vs6+GKJhxPgPNeByCqonxnnBVK6XuBEQjE4KF0H/gGJACAV4gDtMkAnaZmqU/rqVcgfWv4+Qq7JULrhYspKk6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thQY2C4Dyf/yz/Dd0+dwdzQJ/YYUteqgASbmN/IQ7mA=;
 b=D/dCIvX/pYajqGaps6/xw50OFkkc83DGfMK4r5AEeTk2RIgemsQlXOvxbowGGW1jH3Ov9M1E2GtXX77uDOREtx/aq5bFj2ds3Yc63Npv7MZ8KnHCDWZIml8sAnqCYuZtWvGSKnq7kRaMnSOKmacRbucuWj2jd5UC0UuuaKlsEsriU5I5PbL+MSLKWNbyk7z1DpqHo+l537vJ3haMLyijhWMppsmTu/pRJ/tg4JEWP3Iphw8nlyJU6JHn3NFfTJCdbhpnfL3dkb34vkgXWDE/J02fn4pMf1KEDiySV7QdF2Df78OtEMIHkQst/v5NqKMM0hqQEJ93LElAZ7gIFsb7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:23:31 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:23:31 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/2] mtd: spi-nor: avoid odd length/address accesses in 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:23:13 +0800
Message-Id: <20260325092315.956451-1-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 217d2e44-8494-4875-4fc0-08de8a502df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kn8x/QJ0hlN8e8Y3/4yuSWcvwMSuuR79WZc2A6R5+Rdam3e5Eci7LbxElOorUsk232qCWbW+sy4b9AqNM6IsYijIxsmRSNRyIISJHQiSGJn9XiJJvJY6P9x/ZTnVkYeuQcofTVHLHsCfnOK+vq1a2zXsvAGqGylTvNnm+kzeCW0QXyyj+fKbBjaWP25PwOiRcNrOws8nIR2eLTj6Sl5S8eAPcx/fYGFvVJfGZ9BsrKt8aSAcz5yMKSily0isw6/NEqhX/iRFsyUkB1zcA9zB/0HoTiMm/xo80ZV8LVdOpY9ruYen/nqc6hm5GjcOHh9hyfxFHWJCowAjbyMjf26i3pm7Mz3Zi17kLt4n5qahMrlTul3DP0O9fqs8MWLvmJiDtcQWOTcMuQtsJRm/qvP7zXHgZBqkqU18br7wmBKQ9lFXevwHrn5IHmt16aARZLUa7JRhUCOWAEhSTUAgG7p3iBbcXmeDOZpgTv9J1/mQrVO7O4AkogHsIr4X7rlPwG4pivtcpBkJS0+NwF4N1Ctt0J8Usv0VDGOEpuLndDNZi/ToEYvfSOBZX3n0YWG+rC3ynbFYB/YmNs6T3WlqX8lqD99ZTOFMVs27om6pdzE/Y/D7HJ1JGEMwkbicLWHsGo3SPVAe1FFJ9BAmcStquGreJCtNnXzkWcnXC9V26H/C+yrk5bM5nt1yD4XzMkIFGkjQuBaf5zSaNwQK7jmWs8J1uvuvHBcquY8ynHVgxG3K++vnlfxRkhaHut9qq67A8kosVyp7hHsBxCzTZfcMMhgH00bldSteAkXjjxUW/SvLCos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dXTJ3+pKhTUkpGNCVxcsdbItvRmIIIuURv1bWWiQXFG1oiWIFeWVd7Ex239?=
 =?us-ascii?Q?2iVfXs6PPyvWgaxZFBcJqf7XhW8Pykw3VNwr0/rx9LJVMjiJNCzYnlD+YMwx?=
 =?us-ascii?Q?6X1SJU8lrGE7SYsAG4TWxrQG5DeS75dqnvVnroQeuG9AXjVLVoLi5OF+HxgQ?=
 =?us-ascii?Q?CUmKeP6h4c+dNHeYfcuQWu096XBlkkjHSOvYWPJwILJHJrFKQB6no/CftDs4?=
 =?us-ascii?Q?GZaXu21wRjHpzcFlO1l+naHa8gVhWm+jeHx2wBBbRQsynI4xQEgu6rlI7VJG?=
 =?us-ascii?Q?DI4KXmOaj6pxADZHtRg0B0QsiDl2eOJLgTY1G6yxs+4lqcQlqR/E/LmvRFzg?=
 =?us-ascii?Q?kAT/OqZ/kNghOw5P16SL8ZFry3Pm6wLqW8Yn0HZlBbA7OpR8bbOPGnhyuOu5?=
 =?us-ascii?Q?30VsQhe/V6wZ+Xulr9iEaIMgC027QTPOt/JYf21k9wxjBFFjuA1JQIyYDzA1?=
 =?us-ascii?Q?cWV6Dzrfzq0eHtuyYFXUGl7A/pLA5Iby+LxB+dg9PsDNhQkGFihtPUhk/NQV?=
 =?us-ascii?Q?vm9qwYbmiLdC1IVQJ9vFaSaudwyA0PfYIm/NYItib6XGUkRfBBKhZ0DA6ZWu?=
 =?us-ascii?Q?4O4xp6Frldx3ql9cx7fBnB0isB19rP2ZhoOv8pSJ3qeeKmDdyUAD7jnV3SxI?=
 =?us-ascii?Q?c7FAaPbDN7OIpqr8WKy59j6Bb2zhMXzpUAbjgtrMjp3Cp9BkHdHPqdhqOdat?=
 =?us-ascii?Q?92egiyKg6aU8y4tj+C1Gls9V0KN5hAZ9Zo0wCai+mqF6ptTLmj7bPVvunq4+?=
 =?us-ascii?Q?4vb58XAM32T57HcqZ3f0EJy7vHDA9B0kxG6jIcRGWGpDeOall4ChBZtcZOC0?=
 =?us-ascii?Q?xxesJefm1467wKR4680dG++YLfRE3yysoGAmbEyL+Youqi0MTuabQQW2lQro?=
 =?us-ascii?Q?KMLhPE85a0g7RJcA/vN5K8E7Qm3fH6EXZBb+jdn7UZSgnp17K4eIOTqJCRyP?=
 =?us-ascii?Q?FSQ5ULDDCnqxnV1cJGQwrY8W2wRukVTB4j2OJ9VJ/7EJ4WLsMGTiEoX3qsU3?=
 =?us-ascii?Q?WFBq1s8I7m3iFAZeKKx3V8KuR7E8okuO5cv/NUgaX5nmv9xeq8N0cfDsoihf?=
 =?us-ascii?Q?2482gDdZGK52rLrnyq70rUE/REX2kZRHhnrkW+JE5reSatzC/j2vcpj2lptt?=
 =?us-ascii?Q?JDX3IeDYiCWXvU6Rx4IPEvKsSVAasvbx7+euiKu8W/7tLaZFN/MSGZ/dnzs6?=
 =?us-ascii?Q?T5reJ61kiIju5mxDeRL2fTMTUY4XoW43jysWzpn3dVMUACXH7RGLUyA23T1s?=
 =?us-ascii?Q?Qo4aM6Q9gwPJ1GdJ+cV+ugsyg8xChMXg7hSkYrGzmQX9xUxxcaLjVAYJxyib?=
 =?us-ascii?Q?YP6u5JnKYza0QsP/bYzy2N1Wvc72QZEWk9H6gb0OAYTLgMENQFV0AYPtYoe+?=
 =?us-ascii?Q?DHfk1qQV3rYY59GZn+qAcIbsmF9NWQRT0r0TxYuydsRSD01GiXIs7oPIRYeJ?=
 =?us-ascii?Q?ocN3MVCFslRnxTrOKVhmozeC815LNCuP4EY44p8yLRwuhhH2akSi3kr9+jly?=
 =?us-ascii?Q?oxGIwxCEt/nO/3DH0fkhPqwtHjEdIHh7LVlYaw/0rQW9Pm83rkV39Dy78zt+?=
 =?us-ascii?Q?86ObjGsAl8qxjj6YyBtrfBssqjt/x7DiaM1yyC0+zs5AQMIqmHGggXKRs38F?=
 =?us-ascii?Q?mx4kPfgRIITEa4WgMJz5VTk1lTaA74czxqvXtc1xfDNzHPjVYm5rIKuhse4Z?=
 =?us-ascii?Q?PNEL3NUNVVazV7ZBi5IIl5RA3kypqJSWf5cUrDBy3fkglDZVlqPtT8qsUXA/?=
 =?us-ascii?Q?6in9nndqzHR8tlWgDru9PYm3174JJeE=3D?=
X-Exchange-RoutingPolicyChecked:
	Hhec/+bBAurlXKZKP01sBneZE1PMs349FrVt+74+Z1/E7pYJfKBAjvVt63lkdKMZqOdMIfsjJmhMjUZX0uaK592ZViOQxqGGAHRGnn9s4tIMvHLLl+yuMBphIJ9pBua61Ikc2/mYETMJce838gcezd7cgEEsZqfm81SS0zRzOOquuhGCt9wU5gdVKRKBHNtP3QiXL7w8ERzunRpjHbdNHD7ro0c11sT3xQ5k5f4LlEcjl7qW8TDrE/uC5VnOLfjQFS+KX5YsY3KDUoeJq7XDFYfXq+/uC9schaaBc3aWQL9Na9bH61ur3c66JY84V9qxo1fdGnVCjDlksIJLJrrwCg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217d2e44-8494-4875-4fc0-08de8a502df5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:23:30.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d64wqsSuNdnO/ywH7PqmqIs9/vKuX0jzBfP0p7KyGs1Rx+P50BZYLE9NIp07eH5DIIGCxSD+oDp79IF1W76I/bkpQNw5RBzMoP/sBVdwpOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NiBTYWx0ZWRfX/CJMSLJj2SjD
 6hHrto4X/WU/DcjYKRUNydwDZc0LC/0rcLXhmz1/DV5+kvZDHrRy/rv5Y7fyOiZSzQh7OkHWnk9
 oUeb2dN4Jcamm13MhScR1w2GR5FewUKbnDjexRz1w5brqLvC66/+e+OSd4TU/5Fs1Q86us2dceJ
 1ReNCVB+v9DVbIzoekIcU3TGpcdy28DZDqULQvxFqraZDYxgn2U2s0WhkROwHv4vbYH/xi9nZAF
 VJWkm+wPP+lViyHyaFN2jUfG+BSW+UrjcZ/gWXpigGoZHb/MydwTiE/cM9V7Z2o4jkblnNqLxDT
 o+TXj3z4Pn5ub9T2iT15/p1ASjaO4Q7tOJpOlQS4oiCycBDxPniyqBv/+iiia2oDHd20iPJzg5w
 b8OhqLZbBhZBWbWUyqM5E+Va6/Zq1mpCgLilNnbEg1MT76FLo+WLep9Bv3u6rzEPLXmCttvgD0w
 +TN9XTyf9KyX9bmy23g==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c3a995 cx=c_pps
 a=ubRrNrA1i3DLWGMHTGxaeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Z44AufGueorxBKJd4XQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: BlagzcUFvYdVjHfz7hZt_EzslfdOYU40
X-Proofpoint-GUID: BlagzcUFvYdVjHfz7hZt_EzslfdOYU40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250066
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230290-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77EBA3223BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Liyin Zhang <liyin.zhang.cn@windriver.com>

This series backports two patches from Pratyush Yadav that fix read and
write issues when the transfer length or address is odd in 8D-8D-8D
(octal DTR) mode.
And we actually encounter the same issues on different hardwares which 
supporting octal dtr in multiple earlier releases.

Now, both patches are already present in mainline, 6.19, 6.18 and 6.12 stable-rc. 
The patches for 6.6.y have just been sent.
This series is for 6.1.y branch.

Pratyush Yadav (2):
  mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
  mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode

 drivers/mtd/spi-nor/core.c | 145 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 2 deletions(-)

-- 
2.34.1


