Return-Path: <stable+bounces-113984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4CA29C05
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0421888889
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C04215043;
	Wed,  5 Feb 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V3Dt+1Wi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="azqUDapq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1E23CE;
	Wed,  5 Feb 2025 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791673; cv=fail; b=pOxk/P5XRioibFLObSVfTRN6IgK45H6JlLn+upqfy0I8yDK/SLqea+oFTK6cBGc5uXMliDFzA2jewx/+gkvPU/dCGr28ao6/cOXfgauZgK9qAWzpVndHDsyidt/DkMGZ+DCOjjn2CVO5px/x5Q9qouHBcjrFvBvC5hp+wLZrDNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791673; c=relaxed/simple;
	bh=1f5w+PTAKtOES7ZDyEcrb/rkadh9QiuanBtu1AGaKWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8S0kNIDn2seoJOqHvDcyfILK6+OdLY0JcC20uI+KzNy1Aj3F2X+WQU4+PGEHjbsY+SCoRf6y3QfSDnxbUpfRlQPD/WVASRVynv6y6aj/fq84+0ciSNib2WIY7IY3L4BNQVRx1IClW5dUb5Tpu5jtqjBhwDx0R55gYWQ7gw7WCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V3Dt+1Wi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=azqUDapq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfo5r001110;
	Wed, 5 Feb 2025 21:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+LeFBowd+xwvwpQg5KrLl7L0uXlaezeSvMDZiMsq6GM=; b=
	V3Dt+1WiPsqDaAT0cMDsC+1OZnacXpcRf82CyQlcKlKgTfut41gY//Qz6BKUk7O4
	iUMoisoPqAdgoPVOLOsrugmJVS+S+HHBIXGNVlyNMHAJ6PekXLg0vQq0oOr10Gkq
	ryd12I1ssCQjw3YQxXrE/+AhaYMwJlLzGw3gV5WAKrgw56WKIu0Bc09adOhnFTc6
	GzU33ji8TRRGd8SfIEIUky3IknLfV0GE0alwJN2r03F/4MvYPZwxcSVioNEEKyLm
	gxzG+wU6MIJB4N4Sxa6yXE6k9aJU9gF/3F9cKJ/wfI5zX3jtfNb61RYVzn5m3O4x
	7s2tu+9DYX8IDWLRgu6Zvg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy880jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JuAOD020733;
	Wed, 5 Feb 2025 21:41:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr083e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnRROaRPVoh3gc69RP49URxOVRVP1X/e6nSe41f5+vHgd6SlKrXGfIjZztnFyfHROZLaQ9NlNjMNcveT7oqW5OSLhrKk/uKpIjQ8WBXH4FdbFKjUouiL/+JHagT+dU7eO6NJDPXDB0Aa8dtvz3OJi4kN/RKRHTJl+ud4mYrLsctcCs/vgRpuf+75sIbm+Cu/nblZlv+ickgCrmiYN/lVpYtOaBUbvfm5dUQ8laQOumwFc1cM/CrCyKzlM4YXedB0Cfvn2NIegZSNP6DfrE4Wkzz7MX0gmgYJXcqlbLCg2FS3wM76n7/2fkGhQu/2qaEYfgeqs379URwF0I605pISnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LeFBowd+xwvwpQg5KrLl7L0uXlaezeSvMDZiMsq6GM=;
 b=DMt/qnIN1oBGF4vvdbXq8veDUEfoAC5/4i5WQGcNklcPQQWEoKyLVk1WnADozILUVWAciw/V0Y6bmLSXf55t5IMiISfCF14xT8k5Z318p7A9YcCH/fjxINKDiOwtbWZVH8HTkJPTSa4CDqEtF+prz/+2BtrlK96YCfYs7ZQOqZ/bjLfx8KRhI4zMi9zHL7qy7/cmMj0eO5cUBZd5FMqV/JLuKgJ8j7HyhPQycnzbCwFDoIdHT9XuzIxnrzjMew8qjqqcc6t2ATTnI6BpXKL7dzUWmuJVTvh0npV93olnmu6Pc+Jb4Q58BnTrP9cvQfBARtF8HiLhCrX2I7Wm+Bz6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LeFBowd+xwvwpQg5KrLl7L0uXlaezeSvMDZiMsq6GM=;
 b=azqUDapqvD7yt3WiShE041PMCw6HEX/FTvp9oJlD6hyGiWFKDkIBuCsUJq+baRC8b43ijk0Cn4Yk+bIhyfbDlzAx3+o3OTkSIWPf7NlQpxBSh8Bd0CfbRbkGai6HGtqIYl2+j5CfZSVHs94OtWDyDq5rlhBgGzYC2ObVGWZED44=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:08 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:08 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 18/24] xfs: update the file system geometry after recoverying superblock buffers
Date: Wed,  5 Feb 2025 13:40:19 -0800
Message-Id: <20250205214025.72516-19-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8634ce73-53e2-4f1e-12fe-08dd462dcc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XAcd7KNDJ6c4cVGQKlEG26g9pr324dIutzRP2JuL12xPArdXQjAWBuvKvvfR?=
 =?us-ascii?Q?k1lgwJNxetWQN7++K4ON64gGNFTRSdaYBIrVXIt0TX+h4p/nk9YNzYXLrSoK?=
 =?us-ascii?Q?bSFHEvWmYZKSqnk+qWKm9rFnIEkiRSGg7q5QMEkT6kKESuxYq3diPPg85it9?=
 =?us-ascii?Q?0JXBDAsnlZ7xz+VfgGcw/7TyLNrAoFj1kgSXnQYvwQ4EeLeMoJ3wqttBI2xr?=
 =?us-ascii?Q?n7eEcB5ifovJogbPTGJnqAUQOEJV/MmgOD6KHADF7quY9kT8LzMlUHPTX9B3?=
 =?us-ascii?Q?v/HLSKJvdUF355ySig6He2sT9hoa0QOy4ICUSjm+S1R5gryKkAoqrWWlFhLw?=
 =?us-ascii?Q?FMzZBC9C6z5kDLEOIehq0t50fiCab4rsZVnKyG9RDtlIhWxY9RNbO1et62uG?=
 =?us-ascii?Q?7BCp0IuLKhvc0tvLKjKrTAl+1Vat0eeXdYfmBRotNg8OBlsaYO/QnywB8lgk?=
 =?us-ascii?Q?xKHUjpTbRnFUmNXp7nJKnhG30mdOlpepDHowUXemdmg4WAhX7E6F1OxubeWF?=
 =?us-ascii?Q?XQ82FEr//EOtPHQJmjsBAEXEAkCFEzN8lfdO4w0D9s0KLibLqHhXC3Bnu61W?=
 =?us-ascii?Q?8pvWP86uSVE48gwjyoPEFOtdSMv/h3crkcYKGivhomU5/ryscsR0kiyr1C86?=
 =?us-ascii?Q?64ZAwDCFOxPw4s98/OCLTg4KFHAPyON415O1U0kTWzEWs0F5se58BWNIcPWi?=
 =?us-ascii?Q?ocsbMzw6Be+ONhN+xw2n3KTWhoRzqXnMDN8HRTi0CJGRURB+UI8KVy9d+v8k?=
 =?us-ascii?Q?EfWFNvB67Bd8f0+6DG71vnRN2nOXip8zMuVWhdSA8f4pywm1jI/drkf139nX?=
 =?us-ascii?Q?nWm5Org1Y1PLSTDxtSW/sYTxUpIX946RUMyTBL2IADD7AA1bY4yNenCZKgRU?=
 =?us-ascii?Q?g8WxxFdl9IE4GrxiYKLKCsoidO5A4GSIGZVfxI0h91BN2j4pkVdTRLB+XJWL?=
 =?us-ascii?Q?ZSTubFmK09oAo+tKS3SxDHnqGNW90f6PiKEkhketqzWAt4XDjq/4AIBB3/RJ?=
 =?us-ascii?Q?tBN2MC0tR2UI/51bbccJWGqN8tfnh0g/7Kh+TFEMAu/exj4HyPCc1GbbgN6K?=
 =?us-ascii?Q?w/qQIi6vRTuxBNma/HYNWWQIYts7WJmkxm16hcz7VkZDg0tgaCgGRaa2MK4f?=
 =?us-ascii?Q?RPYKMIp1IFTbl71Yi3lnedVQaUK9zk6du5pVB140nmWYxLaZn2dyJLlsDCII?=
 =?us-ascii?Q?20kWYVMRV/0Q+AE5dP/OGn0jFYCLY0zdEyqqqAVu9ulIX5Isi06R+H1pEush?=
 =?us-ascii?Q?Ju6EWDf3Fnd++QJ81XQSLN5i5z2r4RSrNFpof0LmKhkNwl5MUjDbhmtpT3dm?=
 =?us-ascii?Q?ouWFcg5WVF8WWPCDITFwrPQd5ayCfKUFlhaOrcO4QU/KtqIvDR9ZatgKRnuB?=
 =?us-ascii?Q?aF5Ae0IwQk7MUaCQDuB2y0XhwjAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWZ5TVL9itnaHN697C833eUGUxJ41SWEO1CpapyVmTDSAA1qARCySPYnjszG?=
 =?us-ascii?Q?xKgYGYJw/lkGj1E1E6Wx67BmvVMqSw9eJFynS3aRPNAMnSSGwQAUiHs5bNte?=
 =?us-ascii?Q?vCm9uBv+IG5i+zaD9swHppU4DHs8zY4unZVsvUdgVqF2RULYqV71XfOar06z?=
 =?us-ascii?Q?axl4abVEGIUWy7euhm108ki4SIOmgGSGJDUxG0H3MkfyZoUMi9plk2jn6C9O?=
 =?us-ascii?Q?th0FuUAam7ymKl5P5t3L13Amjvg86gFW8uVzIXxmux8T6G2xNR05rD1pw/3t?=
 =?us-ascii?Q?INatQ47LnYENsMFTu1RbqhFlzbqZKKnxN0kaWkg7TYkYrkLM1+ncey9yQt5+?=
 =?us-ascii?Q?YutTmT613o3unwtH0sLU0iHeTHJEKf+h0cHe05O6gzFzfIU/nVdki5AOqkdM?=
 =?us-ascii?Q?HI48AXU/QQs0bOi6pKr1nyjaYiy/W4bucW0TUmRm4s3vMqnEjsYaNBV31BvC?=
 =?us-ascii?Q?e0BDyrss2EEV3GyXNWCmkWPj7TGFB8X2iwbmheRtnsg4QrodWi0ROe7KQYCh?=
 =?us-ascii?Q?rf+rrS9vYn87Yzp8T8uHEE34m27XEm//xaEGfeYJSETvEVNGrqjWHMsUR0bv?=
 =?us-ascii?Q?olTVCYijqjCkL1XFplpdbM+iLoL3rfCQZ/RDQcpD+fIsax3ZLAOcmueP21Cq?=
 =?us-ascii?Q?k/7N8+kT5EmX5HdZ/1DVcJLEw43x1hanIaOiZXwV4N/8xH5pAEE4YxQKv8e7?=
 =?us-ascii?Q?85YvINfikmwVJU2E0anH7MsZPG6i6GYJP4wGC7kiUitpQD2mJIGn3GE0h/sQ?=
 =?us-ascii?Q?Z5jAQ2wYaUTaw05aMtspnyY8UElP2JpIV5AwPuX31oggldhuNfmgZHTmC1+X?=
 =?us-ascii?Q?+x+KlZvDBnOceB6z0qa8+H+nYLKi1uqUeJG5wrVf8+jfaPsY7HPDJWk6FOFh?=
 =?us-ascii?Q?LMU2bewiAvML7NPwtRjOC1wTbXNKcnm9UyFbPsqAT0NtMoCaAKDcqNKXePhy?=
 =?us-ascii?Q?LFNEXISa7aTWD6LR081Ub8/eiBaLwk0m/JOVlciOTuI1GrhpI/eZWg4as3N6?=
 =?us-ascii?Q?nCCxAWJHz33cdquj+yPU6BHWML6zbaac3mxTTY2QjwIVPEt3lFfqg8/xSJVJ?=
 =?us-ascii?Q?bRiAaGOXIA/TZXscuk8Tky16beYIyPpkJDpFtq+xo9r40xaUXFlDhpUyVYh3?=
 =?us-ascii?Q?pUM2x+s6+KdSmaoZL8Uth2xlUAocY/Awwql4QyavPGT8dyp/QL5D/crECnxM?=
 =?us-ascii?Q?VzfNLazEuKjUlhscVnQix7/QJLmU8gLz42gWsVcV7jhTFn4pUoVG0QKJJvmZ?=
 =?us-ascii?Q?DCp+4cBLCXpVRC+W0z908Rr1xTiUJ7E/EMp4KgEyMcXCInW+GmumK2xGUhyy?=
 =?us-ascii?Q?vc5A3DppQF4cNK8rJjvg2kkL9E9bsNhiQpgBmhZDiLXtIfYuuDZnRN1ISQL4?=
 =?us-ascii?Q?uOoPYpSUHlM0QvVJQldjGnm4GhUhEZtIjqUzbWkbLh8uvhrfRGam4dIB1oeF?=
 =?us-ascii?Q?eUfKRGSWzJihjJ3m+6Oi/TlKJSY5BobI3epkKx0BYwIEwD3dWMtAq8WF8YQ7?=
 =?us-ascii?Q?S7UO7fRAELYDmQldjy8QzhDlk7dyAAcB5LcYrHgR+9eHIdfJQkofzrBwKgGo?=
 =?us-ascii?Q?oNhFV4d582yyjddHNwaXwtRZWrv0rlZeOnF1Po/K8Dx/MQvfUC03eckmQv8c?=
 =?us-ascii?Q?+HmGRevQ7dxAWtWKjtCggnthgE8jRS3J+GpE0rIoyDeVNwZMCmwmf+/+DfUP?=
 =?us-ascii?Q?pJknPg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V7H9gCYShgqljWX5zkgPJ8jhVQStIVDcqTiZLQFyRPmV0vcNNBCCQTP+XwLI1mJQxMEp/ThJ6t3XZ5rK41BWG5NLnJUEi718x0VDP/uCGNyNvWZ5B5NO/pQIo5q6yQqAdJ1JOpbAkPBGwgCN4IIWC6DCM+w2340NSsqBkTKDcl3g4jO5JvYbMtSGhPW3qiwG29vCAM0pKCGpPe3PeeTPQlCmkWaVD9RAVOQEXf0SkVGnMEmg11Yn4+6m7YulE/fJk2yC8A82TF/XpSOIwgiT/RTGjuixFQJOXevmm0rLUODPpxjKsgVsHjDnYK1ySPnvc+XQ7hF7mk7kIgfp/dSF6gcPavxXrIaanB8xSkB0E+PJh8FljWdwaKE9kk0gxdtXDeMgikj7Jb0UaduXzBZaFeHxHa0WOBqf4nDGb3W6a7YeLa2z6+cftnGBuy6udcQPPd3LRv5fntgHQkooucsD/9JbkQsoMTjOGefJDiQ+dQkPi4/RzmO9SmpXu6hOCZ7OLyV0hPsMOtZaeM/SYR/YkGK/fkVMh9yOoNZYSNi5FgkymDTiFk7ngOaY5nlyKgLUOXzANHuyjRfOIUj7KjSCM49iW3zeIZ3YLo+9tQNVc4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8634ce73-53e2-4f1e-12fe-08dd462dcc4f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:07.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u6Ez7Udym9OJ5NzCIfybq5L7ajxopXZ+Hi+INjfcK6CtwLON001uRsASJxuxJxTjAwmd00/1F+vfDElNdTOzPS90YCac4zOnDRjprB7ICs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: LZy2haYqM58ijA8Vl3Nnx3WVwP82vv1i
X-Proofpoint-ORIG-GUID: LZy2haYqM58ijA8Vl3Nnx3WVwP82vv1i

From: Christoph Hellwig <hch@lst.de>

commit 6a18765b54e2e52aebcdb84c3b4f4d1f7cb2c0ca upstream.

Primary superblock buffers that change the file system geometry after a
growfs operation can affect the operation of later CIL checkpoints that
make use of the newly added space and allocation groups.

Apply the changes to the in-memory structures as part of recovery pass 2,
to ensure recovery works fine for such cases.

In the future we should apply the logic to other updates such as features
bits as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_buf_item_recover.c | 52 +++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_log_recover.c      |  8 ------
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 43167f543afc..b9fd22891052 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -22,6 +22,9 @@
 #include "xfs_inode.h"
 #include "xfs_dir2.h"
 #include "xfs_quota.h"
+#include "xfs_alloc.h"
+#include "xfs_ag.h"
+#include "xfs_sb.h"
 
 /*
  * This is the number of entries in the l_buf_cancel_table used during
@@ -684,6 +687,49 @@ xlog_recover_do_inode_buffer(
 	return 0;
 }
 
+/*
+ * Update the in-memory superblock and perag structures from the primary SB
+ * buffer.
+ *
+ * This is required because transactions running after growfs may require the
+ * updated values to be set in a previous fully commit transaction.
+ */
+static int
+xlog_recover_do_primary_sb_buffer(
+	struct xfs_mount		*mp,
+	struct xlog_recover_item	*item,
+	struct xfs_buf			*bp,
+	struct xfs_buf_log_format	*buf_f,
+	xfs_lsn_t			current_lsn)
+{
+	struct xfs_dsb			*dsb = bp->b_addr;
+	xfs_agnumber_t			orig_agcount = mp->m_sb.sb_agcount;
+	int				error;
+
+	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+
+	/*
+	 * Update the in-core super block from the freshly recovered on-disk one.
+	 */
+	xfs_sb_from_disk(&mp->m_sb, dsb);
+
+	/*
+	 * Initialize the new perags, and also update various block and inode
+	 * allocator setting based off the number of AGs or total blocks.
+	 * Because of the latter this also needs to happen if the agcount did
+	 * not change.
+	 */
+	error = xfs_initialize_perag(mp, orig_agcount,
+			mp->m_sb.sb_agcount, mp->m_sb.sb_dblocks,
+			&mp->m_maxagi);
+	if (error) {
+		xfs_warn(mp, "Failed recovery per-ag init: %d", error);
+		return error;
+	}
+	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
+	return 0;
+}
+
 /*
  * V5 filesystems know the age of the buffer on disk being recovered. We can
  * have newer objects on disk than we are replaying, and so for these cases we
@@ -967,6 +1013,12 @@ xlog_recover_buf_commit_pass2(
 		dirty = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
 		if (!dirty)
 			goto out_release;
+	} else if ((xfs_blft_from_flags(buf_f) & XFS_BLFT_SB_BUF) &&
+			xfs_buf_daddr(bp) == 0) {
+		error = xlog_recover_do_primary_sb_buffer(mp, item, bp, buf_f,
+				current_lsn);
+		if (error)
+			goto out_release;
 	} else {
 		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
 	}
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 79fdd4c91c44..60382eb49961 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3317,7 +3317,6 @@ xlog_do_recover(
 	struct xfs_mount	*mp = log->l_mp;
 	struct xfs_buf		*bp = mp->m_sb_bp;
 	struct xfs_sb		*sbp = &mp->m_sb;
-	xfs_agnumber_t		orig_agcount = sbp->sb_agcount;
 	int			error;
 
 	trace_xfs_log_recover(log, head_blk, tail_blk);
@@ -3366,13 +3365,6 @@ xlog_do_recover(
 	/* re-initialise in-core superblock and geometry structures */
 	mp->m_features |= xfs_sb_version_to_features(sbp);
 	xfs_reinit_percpu_counters(mp);
-	error = xfs_initialize_perag(mp, orig_agcount, sbp->sb_agcount,
-			sbp->sb_dblocks, &mp->m_maxagi);
-	if (error) {
-		xfs_warn(mp, "Failed post-recovery per-ag init: %d", error);
-		return error;
-	}
-	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
 
 	/* Normal transactions can now occur */
 	clear_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
-- 
2.39.3


