Return-Path: <stable+bounces-214689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJDrE1EehmmTJwQAu9opvQ
	(envelope-from <stable+bounces-214689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:01:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78621100A98
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8247530095FB
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75072DCF7B;
	Fri,  6 Feb 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImvDzAL8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wPTuT1W5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6F2DC76A
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397149; cv=fail; b=Oa278m7n0dHSGzzmDx2aqMf51ZBB3Vz4SOhR7vvwEh2r4T0LXYlEUskfMkwgUTFlXP+WJzl4wQgOZHo5seL82slarGDsKiskWCleWMP1Z6wY/e5VWTLKfz4SLpIG2RlAoagEV57uhckVAA3F2yEx90IEUscl5kDg18lcd3e9MHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397149; c=relaxed/simple;
	bh=6A+XWIX+4e8abJ65vyYE+OufTvIOVWATjE/0XpAkZII=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FQ9xHOEkHM3BPcoDpMAbXgnNFQxAnk0glES/rFM6uZ9IWTgLYlF4I/bdAbowGoInL5KRNmvAFaC0bkyhfuOPYgNPDJPPscHkSQ7mfdMg9Y3oYfd2IzbpPVgy83pdaGfqLMTFR6WyGvqjmYT/qlbUAHiXhZPbIM1GrqCma8epyMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImvDzAL8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wPTuT1W5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616EvFbp3619868;
	Fri, 6 Feb 2026 16:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Wyu0Zcg8f8GMJ/Nr
	CzGjkTwr6cqHdMQOMJ0+RWO45IU=; b=ImvDzAL8exlnEOF+Zv3GtGHbr25HKeuj
	79x2WE/33FHAmpq5MPLsY7F9fD3QvI7FtGC6L455RYFOhYM/TsicBMnt7sQuEvf1
	hgKl1J5rhldvOTkkvffT65DV+IeuDmZGYE4L/zRljREd1/Pfpnt1idxjBEcJ0ByL
	qiYy2jZBTEMqw5hx6zBberVA7rCzZa7Zw5NDh5oxGfyaBxmlfYX20xxsrAKXvoOa
	8cDXbWjNPLDvYtRmVIYuGT36736GlSwgcjk19KMy5LiGyExAlyAgBREMD2kw6oie
	DxvnvPknyg8DePYGlbSFrilp51YgqKv4ukZ7LDCIlwWZtUhehla5Ng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c50sg9j54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 16:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616FnQ7g009519;
	Fri, 6 Feb 2026 16:58:49 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186sbexf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 16:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdIBJejA61EwNWIyKFNf1kNef7JRx0oHNRbofZOCCjeoEah380/NME4l/5NyUjo/9FQn92LDewsFAcFXMyhMoP4A88jx+azeshMKhSlZq5wS7QEkV4ieZcKgmQ/KeUUX+oufJz02Qu8g/K4xfCOwer64YcbANkBzWJqw3UvfiO1FCMZtd8q197cP+UKK8g8dzYEzr27gOf4YhAaLezMyhzsoxs1mvj7CL0R4oj8IilXrZ2zRYQFnm0Ws5h2w9daO7QH5s3l6BwsGQftebkxyALjxhRskzWBjW0geDh5ob54xs5Me95leTVvX8VZTZA/jPiH8skymzLouckJ+AcZopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wyu0Zcg8f8GMJ/NrCzGjkTwr6cqHdMQOMJ0+RWO45IU=;
 b=Ge8LQR4c/1v8PciUG0BmasvVklEX4rkvJJMuxstP2RBIUoQe/iUX0FKYOg0XiU+pDYb+Gv08YiLcR6Nt8WInRF8/eoC7iFz8INyU+16iIDbgvQXGVtUO0Arw17CJlnQVIhFpTk804B/bzhI2mlOszjtHlXKJ/T8AW5HF29Kmz8aThbQVP9L7JjTyXAmaARx5ZZvl5Mib/BVmp89PAfTdPNoOzF56zMirnRkHkhi8xTaGAGdMugjB6Yl7P1cm0Rv6AHl86kf/TRxFmSwgJC3KtWEmBj5ffzvCx3ixF3wluPDYuG5AzfL1VCUMEoNm2BK0DQCi+e/xcrRvaXNXFFwbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wyu0Zcg8f8GMJ/NrCzGjkTwr6cqHdMQOMJ0+RWO45IU=;
 b=wPTuT1W53oP9lR/Ohc4g0SASotp0fzm7gwj5Ws6Q4NFvarOc7PAQLUpJA66R29yRfbpTFmGRafUO3Amsy21SKRgCyFuKGLy5SQpZ5P1bPdNKhEWFHPnIMq3wV2cDNeVTE+NQqlY5LEc4MU1Ifluo67W3aD2fgQvOVLjowrCOoKM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 16:58:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 16:58:15 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: skip debug_check_no_{obj,locks}_freed with FPI_TRYLOCK
Date: Sat,  7 Feb 2026 01:58:02 +0900
Message-ID: <20260206165802.17280-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0060.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 901ff273-28e2-4aee-7911-08de65a0eb6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?saq4nfBXEQ/4nrPcXg2F+dFgkWZKK8oANaQivHWrhzXfZa5vRIoYuPk1Uykt?=
 =?us-ascii?Q?in+CHpKcv6BmmprOl3hebQ0YoiXSyNIZyCSNCsvkYNt+3o3h1PXMRRFLaDqB?=
 =?us-ascii?Q?H64t3YUze7+JpSo28jveEwvvdhhJIQCvJvcAU0MWS1K3wdwjteE3ZKUpi1UA?=
 =?us-ascii?Q?YLuzU2OM8i6QZ5H0hCvPz/D+JKlTO54Q1kbRPACqBfpxQ4uhZuNqsGy7LNqA?=
 =?us-ascii?Q?WDHElnwlcZqlxX473k2LCGJWWgk5efyCnKzLfXCeIBep5Srp53VKuWA9mWda?=
 =?us-ascii?Q?phli0A1s0OpnkPlB6MPhi5ZdXuzbIbw5JdsNEOZJqEWNLQEKl1s5YBV1L6rX?=
 =?us-ascii?Q?DU/vY43KcxUWFAwQJyxxSHahRj1Sf7QDrvc8vyNQeA7Ce+CCLeM/cjwEAEUp?=
 =?us-ascii?Q?5b292BfwaSMhn9CeaMpemIttJRzn9WK8/Eho8j2m+290V5VYASPxuhgHYSWQ?=
 =?us-ascii?Q?a38EWcJptNI9BJhjPIg5EeYO9kOchnTi0vqTj/KLrJ3ahwMn7xUfokux/9Ez?=
 =?us-ascii?Q?Jc1zXIZ+f0mLhyJx670d8VLDnLkkIxbqXW/V7oC21I0mMvCx/znU2L2UbOmD?=
 =?us-ascii?Q?WIUbKX5YvHDJ0TKVrmyYLtRWzKLP/14HWXfccoUevUI4Qf+3wyjKCPXRydDz?=
 =?us-ascii?Q?9IaCDd/lW4PWsNZ8uPg0JX3Amr33UFgTCiAh/tYbPNxP4XYLdz53iM+6633r?=
 =?us-ascii?Q?nLGIDiMh10KV58yRX66i7noAzoCVaORFueQR1TT8saBs5tZQzv2Qr+ITOFAW?=
 =?us-ascii?Q?WxaNmr36s1atAI5TloqOzdhJsxbm6lyV1aUR0OibKSGg05ssBepoduz3mUJD?=
 =?us-ascii?Q?iuEOD5hviTFGZw6dk3lpt1PC3E5tQOlWL8PEOv3C64oP/GDLbVc9gH4qP9yu?=
 =?us-ascii?Q?KDOtEmZ3aPUjp8llUlHrjfZo6jaUuSbynsBlQD4WqTmkhOJ7PIAvKIx+9IZ8?=
 =?us-ascii?Q?Q1kzfpI2c8pN83d7i1MmeQxwGBOQUwwYeYga0cUpjLLirjiy31UzNX4/2L2z?=
 =?us-ascii?Q?qiZ5XkJY4+7B6greoM6YVeo1P38810ZiRzgaRh4OWorober+QJN7nrMtyu1o?=
 =?us-ascii?Q?MnoJaAn2fxmcQ50V/ykLYKfY4GFuOtMpcxSX02cyHZlGYV+SPyWrfEBm5+oP?=
 =?us-ascii?Q?JXwdKapKLWG2yA/Vsio0f887Kgp1/fsYb8TIdLQYRFlMf5NxUG2DDwiPyceO?=
 =?us-ascii?Q?8wuatoneTO+zFCQCWZmYBEB48kniB5FNl+OaAKD0FukhtE6lzksPgaiedQ2Z?=
 =?us-ascii?Q?bKWCrgX4eJTM09mSt59Ak7nWq0nkFeAB92YxvNrqt5t87DCt15Vv6LA72dWd?=
 =?us-ascii?Q?uKBxuQLOWTphO230j7d7ilakztD0nvPjPFsl2xzSbMjlLDYJ2FgmIR3L8LhE?=
 =?us-ascii?Q?kRFMVFW1mp4skzaFImZT9P4pDm5gp0J/mKp/rwFqrMEuBbeRcQ2FQsbgZthB?=
 =?us-ascii?Q?ZRCCSSg1fEdKCGnafXlZNA3CE7LImZ8wEoUZkJhgjitvunmjHHRoKYUjnBNQ?=
 =?us-ascii?Q?3jVBfaSZMJuhhCGhWMr6yc8HbNxMxou5NEr3SQ0W7hiU7HQ/+mF+1XEEzlrO?=
 =?us-ascii?Q?H518lPghBASjbxWctng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idEhTA+bSeKlyK7PBIaAPxbqW5jY/YGsptawjCtj8mqiQzgETkPXavHbEkjY?=
 =?us-ascii?Q?ttc1QqqDt2xN8w9+Ro9TtHVmx0tcqcsKoERR2po0sU327edHZ6FsIxvsB5Zt?=
 =?us-ascii?Q?plhJM3Rox3Q4dSc7Meu7YKwiVZCq2SHQIGiMGX1nZQdMRFuCO22aUgaBI9sp?=
 =?us-ascii?Q?xMJ4xV8tbZY2m2pVMyn+mXlCN2UWJytzGX6Z3Qe40xXOlwzyQN5Ryi1bNEap?=
 =?us-ascii?Q?oJ2ealgEbD9KCRK0GZdjDAehXJfj/E5+XORyE5CGBOBCgce0r0yf0KACDPrL?=
 =?us-ascii?Q?xeaN33M+IgePpi2xtqEUxuHO+1GjXLgY30UBeCcnbBorCOF2d3n7yVGtGM+5?=
 =?us-ascii?Q?BFmGOW4oIClQTWfVVtfqu5LSDJuVx+Y1sNxlZyMeu0FbJcwhtsJOu0hZREq0?=
 =?us-ascii?Q?2uJgFsfe4GMqy/mlUzWq4ibQcrrJ3EKKviV4byv+aZShmczKbFvRwXXbbFft?=
 =?us-ascii?Q?SUyThrPfH2qzPg8exJ3zj8OVLsB83ZDP+CtW4YeZbsyI8GT30jPHeIvn1jBm?=
 =?us-ascii?Q?wRyHKg781TH9FKEjMzcRgywZXx+Mx2eR+apAaD8rEVPiGb69lIgWRM9zRiiA?=
 =?us-ascii?Q?azA0LMcgm2W/KM7FZ5qhuFOwB1Q1CLGPZ7pJ8ej3V17zZ1mlx/seGiznYUbu?=
 =?us-ascii?Q?t92KNNazAhjMcPLYo9t0cdFeedE4aoF5+YdmyXo+2I4ZjZI35RlWMlL1NXzt?=
 =?us-ascii?Q?vimcjfBFk1nFMzoLYMh8QWUT3Z7cVBDTa7yvBB+s1ANaTOsSG3w/IYEI54YJ?=
 =?us-ascii?Q?nI1QiI8jvjm4SX+RH8s0KMLjpOKxGF0m6fjNdFNCQOgubzbc4eUjJXTm1QOv?=
 =?us-ascii?Q?3pctoirt5b60oTB1oRJ54nFS9lNKtJAAxz7JCbyJHqKq2CLrZ0ZTcMJzfxJ0?=
 =?us-ascii?Q?c6Ypd1A28TwukkLKkpzXPukF7C2rV4xM5bxEEXkoTpiWwSqvdliM7JuKe+6X?=
 =?us-ascii?Q?vfoZjuT8T3XBR5pmYh7Rxpu0zwn4ZOEjL29oQ/zLYWsxeKSv625A0dVzUgLv?=
 =?us-ascii?Q?J6BXwLBH2AmsKS4R2HMV771yPm4sEN8faVDIQzCfArQFMyXCer66Q+njzMl5?=
 =?us-ascii?Q?DHrnKgmDsFnc32udfpzJeZq67XUwE41LKJgOZqz908107e7/vqShuXKXaGS6?=
 =?us-ascii?Q?3BkvZChbbceEFrnSuEWpQHbZK1/dq4Y1YhYXuHRoWqt47myvdq7/aZjhcvWq?=
 =?us-ascii?Q?DH9hfHSYiU/VitwCqSHzb1B9Yx/bjfYJ3kcuZrDC66QP4Qsa7GhcARzQLqmg?=
 =?us-ascii?Q?73BRAleSXO8UG1oX8+X5my6cF6cgit2LTfGCZSCjwCtvjN29UXJWkxZDNJww?=
 =?us-ascii?Q?q66KKH3Q4yOimhKtBMKW6PBc5BsBG2ks1iCnktYU4W06ZrC2mwONJg2rHxFe?=
 =?us-ascii?Q?c6M9Bd1dYuMsZepFisrFXdNEKLEbr8WAsWtRBggDv6VAEelND/tUeNnhxJmA?=
 =?us-ascii?Q?S0Qb/gr0ojlbOpZrGBs8FaTWEue+0xIXWhP7k9zb67H/0dtp1oDVomkHdcKO?=
 =?us-ascii?Q?FFo18M4iQEzv8SKMYzxFXI2UO/3tYZyGv95UpofIyl95bowcKNG+nD880u56?=
 =?us-ascii?Q?z6jTc+QWH7QAYFULOJWPthedIKCl2qJFWTc2tNW5H6ZFjsyO407hK0zlLtdZ?=
 =?us-ascii?Q?fg693DMyuCegd3mnY75Gxeo0ev5Bsla5rXNzvp8OFL3u4uB0odRnLBX8XHdm?=
 =?us-ascii?Q?D0Ojq0vTdJIBQvJUEEmM4Bcp8d4J77HI8BddwL7k1peGh9o8ezD1oVVCywcM?=
 =?us-ascii?Q?EAYkvyaRkA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+pjea+e5a4Ja2ncq3nBEZ9qqs69gqDeK/alBj4XD8CJnubwiGbGQ8sB3xnOR0f73b8paBoRxyZGXAXKR9+Jt7UqCuLQNsBI97wFOD/1nYfY9r1PqF+ngdXTfLBmjXF9VKVcuStpmATPwUv9gmNYOG6tkI/JyMSgG/1XhRGmduVFM1OqzpbNzSP7TlwgjgfER9myYZ0F5tZvp52VSWp5u+hwnSdLoMF1tYkC729s4ssZyIkwPT6sPDbe7TPm01Ma9O2zwrvboF/TCnMnuFnFgfS5USVa7eh/k0FPBFQnPigFLl4z1H4s3OIoo6GZcSna82t8lZDKGRZUzTfGK7eiiN6+Zb1QWb8WZQr0cv2aytmrz1AStD20Ufy6C44u8UNggYU+KAPd45Jebn3a7ecEqNN8nwJMa+CE5+JEAlKbhtz6TZAzwhZhv5WfE++Zdt+C1g6g7BENnDkZRyIRjh6Il9MZ/KUJsRr8dECKj/3cL7jPe0xsAelGesFc8pC/vx6Mz5vj3gdyysD/fyvvCCrFl+ySGoMBAeHQbvKneu6+t6nF6L1ipZzzy0WLGN7h1xsboL9gX9QjP7gM9Ehvot+BHYKm74FKqdiVhNci9rWwFWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ff273-28e2-4aee-7911-08de65a0eb6e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 16:58:15.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFbO7aZH1nJdZtbNWWbM4mRLKox1vBHKF/IVwyLe5eNXBU/DTijH400G4tdIyki+GvHoPfccHcrfPvtDFFZbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602060124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyNCBTYWx0ZWRfX1XJncplA8Mil
 oziltzyLcztg2Flxc+WSyCBHrDIreCiDNwML4a06Zf0or3rGBhwJDHdUqzMFVuISltXdH1ufazz
 wszC5mYp5ET7QQJVxFs2ob4pjzgYxP6q4v5KtCkgjhulXRB32N7mZ+UrznQyE9Bc+0kmcufZE3C
 PrP+puXOTqyHSdA5CUZksNrgmuYRGCc7/7FwxkVRyMpmd2dPMKXomCeB2eSgo16Ki8nP1IJ6E07
 ulPC5ZB5IOxH27UzuKBlxFggR5izR9x5i4Ofri3bAJgo+I32JDotAM24yK2GC6Rp4LldoZ2pST3
 VdlzrSKq1oR2v/NnaXgwIwQowIK1K8cp7tGIiCxLSO/DVngrBVjCQkzx3cDgGEfCA0HkXTfXm82
 sP8rNjdR9OXhk3KZ+HHVT5rGElY07UuljtCF5z5iu6W9tJYfFRUpjLJXHc8KkLPIs9czIc1nSvI
 gS+cTFGKLmmVsICCH8wt1MVD+fX1c7vXtFQcknzM=
X-Authority-Analysis: v=2.4 cv=VdH6/Vp9 c=1 sm=1 tr=0 ts=69861dca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=L92Y-EZEwQ27Rhyv8WoA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: S2wr1lL7RlbRQfllMdy_7zs9z3Guw-bH
X-Proofpoint-GUID: S2wr1lL7RlbRQfllMdy_7zs9z3Guw-bH
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214689-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 78621100A98
X-Rspamd-Action: no action

When CONFIG_DEBUG_OBJECTS_FREE is enabled,
debug_check_no_{obj,locks}_freed() functions are called.

Since both of them spin on a lock, they are not safe to be called
if the FPI_TRYLOCK flag is specified. This leads to a lockdep splat:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-slab-for-next+ #326 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/9046 [HC2[2]:SC0[0]:HE0:SE1] takes:
  ffffffff84ed6bf8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_check_no_obj_freed+0xe0/0x300
  {INITIAL USE} state was registered at:
    lock_acquire+0xd9/0x2f0
    _raw_spin_lock_irqsave+0x4c/0x80
    __debug_object_init+0x9d/0x1f0
    debug_object_init+0x34/0x50
    __init_work+0x28/0x40
    init_cgroup_housekeeping+0x151/0x210
    init_cgroup_root+0x3d/0x140
    cgroup_init_early+0x30/0x240
    start_kernel+0x3e/0xcd0
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0xf3/0x140
    common_startup_64+0x13e/0x148
  irq event stamp: 2998
  hardirqs last  enabled at (2997): [<ffffffff8298b77a>] exc_nmi+0x11a/0x240
  hardirqs last disabled at (2998): [<ffffffff8298b991>] sysvec_irq_work+0x11/0x110
  softirqs last  enabled at (1416): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0
  softirqs last disabled at (1303): [<ffffffff813c1f72>] __irq_exit_rcu+0x132/0x1c0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&obj_hash[i].lock);
    <Interrupt>
      lock(&obj_hash[i].lock);

   *** DEADLOCK ***

Fix this by adding an fpi_t parameter to free_pages_prepare() and
skipping those checks if FPI_TRYLOCK is set. Since mm/compaction.c
calls free_pages_prepare(), move the fpi_t definition to mm/internal.h.

Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/compaction.c |  2 +-
 mm/internal.h   | 35 ++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c | 42 ++++++------------------------------------
 3 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..9ffeb7c6d2b0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1859,7 +1859,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 	struct page *page = &dst->page;
 
 	if (folio_put_testzero(dst)) {
-		free_pages_prepare(page, order);
+		free_pages_prepare(page, order, FPI_NONE);
 		list_add(&dst->lru, &cc->freepages[order]);
 		cc->nr_freepages += 1 << order;
 	}
diff --git a/mm/internal.h b/mm/internal.h
index 1f44ccb4badf..8fdffbe5cf1f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -820,7 +820,40 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 }
 
 void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
-extern bool free_pages_prepare(struct page *page, unsigned int order);
+
+/* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
+typedef int __bitwise fpi_t;
+
+/* No special request */
+#define FPI_NONE		((__force fpi_t)0)
+
+/*
+ * Skip free page reporting notification for the (possibly merged) page.
+ * This does not hinder free page reporting from grabbing the page,
+ * reporting it and marking it "reported" -  it only skips notifying
+ * the free page reporting infrastructure about a newly freed page. For
+ * example, used when temporarily pulling a page from a freelist and
+ * putting it back unmodified.
+ */
+#define FPI_SKIP_REPORT_NOTIFY	((__force fpi_t)BIT(0))
+
+/*
+ * Place the (possibly merged) page to the tail of the freelist. Will ignore
+ * page shuffling (relevant code - e.g., memory onlining - is expected to
+ * shuffle the whole zone).
+ *
+ * Note: No code should rely on this flag for correctness - it's purely
+ *       to allow for optimizations when handing back either fresh pages
+ *       (memory onlining) or untouched pages (page isolation, free page
+ *       reporting).
+ */
+#define FPI_TO_TAIL		((__force fpi_t)BIT(1))
+
+/* Free the page without taking locks. Rely on trylock only. */
+#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
+
+extern bool free_pages_prepare(struct page *page, unsigned int order,
+			       fpi_t fpi_flags);
 
 extern int user_min_free_kbytes;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0127e9d661ad..328c4d996ae8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -60,37 +60,6 @@
 #include "shuffle.h"
 #include "page_reporting.h"
 
-/* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
-typedef int __bitwise fpi_t;
-
-/* No special request */
-#define FPI_NONE		((__force fpi_t)0)
-
-/*
- * Skip free page reporting notification for the (possibly merged) page.
- * This does not hinder free page reporting from grabbing the page,
- * reporting it and marking it "reported" -  it only skips notifying
- * the free page reporting infrastructure about a newly freed page. For
- * example, used when temporarily pulling a page from a freelist and
- * putting it back unmodified.
- */
-#define FPI_SKIP_REPORT_NOTIFY	((__force fpi_t)BIT(0))
-
-/*
- * Place the (possibly merged) page to the tail of the freelist. Will ignore
- * page shuffling (relevant code - e.g., memory onlining - is expected to
- * shuffle the whole zone).
- *
- * Note: No code should rely on this flag for correctness - it's purely
- *       to allow for optimizations when handing back either fresh pages
- *       (memory onlining) or untouched pages (page isolation, free page
- *       reporting).
- */
-#define FPI_TO_TAIL		((__force fpi_t)BIT(1))
-
-/* Free the page without taking locks. Rely on trylock only. */
-#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
-
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1314,7 +1283,8 @@ static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
 __always_inline bool free_pages_prepare(struct page *page,
-			unsigned int order)
+					unsigned int order,
+					fpi_t fpi_flags)
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
@@ -1407,7 +1377,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
 
-	if (!PageHighMem(page)) {
+	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE << order);
 		debug_check_no_obj_freed(page_address(page),
@@ -1579,7 +1549,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (free_pages_prepare(page, order))
+	if (free_pages_prepare(page, order, fpi_flags))
 		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
@@ -2940,7 +2910,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		return;
 	}
 
-	if (!free_pages_prepare(page, order))
+	if (!free_pages_prepare(page, order, fpi_flags))
 		return;
 
 	/*
@@ -3002,7 +2972,7 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		if (!free_pages_prepare(&folio->page, order))
+		if (!free_pages_prepare(&folio->page, order, FPI_NONE))
 			continue;
 		/*
 		 * Free orders not handled on the PCP directly to the
-- 
2.43.0


