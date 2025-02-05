Return-Path: <stable+bounces-113980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C2A29C01
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B983A793D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB2215063;
	Wed,  5 Feb 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b0eTJ5TA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XB0O7Nyq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB4215062;
	Wed,  5 Feb 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791666; cv=fail; b=GYu0Y3CF4zFIZhWes5TujIzzb2CND0zhOuGpxiLMa3ZZrKeqR9u1iiKMEOAdwt2pPiNlB3lUlrIUHnP43MvD8ro5Rkqv2a6kb2PBpxi+SF5HLUw5qq149NO0KCsW8UQKQctkMYTPzvf15aRZDa7F4fQ2UvVu0cAtpTEsFLiLi5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791666; c=relaxed/simple;
	bh=uhHD3SBOKQLOSE8hNrHJ6EWpTmwJrvpoO8YbSoHqbZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncGG5IVi23Pz5tLRbaZ/s0M/gRdNHVL+VJ4neTfV67bYSw4enTVu9pHkeYuBJRn3PpHtn7TKlkRFDLWRxaiX9PQA/AVV9rexWIj+HeZPoumc17YJL4RQ03XFN0WLHbLoKbiotfvWmzZao0wA0DFsOQ/EiSz/7V3miEBT1dqL4m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b0eTJ5TA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XB0O7Nyq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfpuO015241;
	Wed, 5 Feb 2025 21:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+vbNEjnbCfE9zP/dhWhzAAsiXw4gdth+m+/XptQ1lyE=; b=
	b0eTJ5TAjVDS5R48IB27lfcvdfmjvZTlhlprnAeAxCXBYqcVjd4/U/WrNNm3wewD
	I+wyw+AZDHDuT3/wF69feenzWX1JcjWqo62kc2miKNnCU+HNDEcHTBK3gVvv7Qn4
	tPS+xph8YXU6BeJ2N6D2yEyMrtV5Bq1zudriAKslBYkNM1l0mIgjxJSrowCNCnwh
	biMz7q6FHH1ocXNWcTpEMqH0u8ghk5C8LWzHywUxuEcs4mVRPAgGMtRmp7xBaPCQ
	V6Nrt+yPpuTguRn7OYBNLlf55eXdu2aXIaRVEwjKVY5LxuzYkLG1niFiHme6iKBC
	d0BwIeGM5MstHij5zyEYxQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u9f0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JoXgx027781;
	Wed, 5 Feb 2025 21:41:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dp8byy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZRrsvF9LSKAHQmXsm9c0QLuZy4LJkEAMh0J2GrWiTJxsVH1Hx5tfQOF+gL+Z/6pFNzS6Lx3D/WXlFFQcqHhkDlC4iiV9beVQJrA6UKnxSW3LK+FEolevXjAAtrG+v0LHksrYg89VSB+71rsvWh3D6TA8I8WHqqg6kVk3sSkQp/NCzQeuTjjCqabNEhqFEn1/4NhdynMmR2+EvAfZ43R+vGYJz0gPCL/2ttkZJu2x2gDumos+ht8X53m2qsE0igAYKx8letECB7M4inAcvgJVsnFpr9om+n/cBL22WO/NTn2MxKnGrac2IQrrJ2t9px/hTUrGwR5a6LXIzgjRXDKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vbNEjnbCfE9zP/dhWhzAAsiXw4gdth+m+/XptQ1lyE=;
 b=YgsmA4YQ4HyrZqRuU6jRabcwTUnjbo5nCuTu6LfK5DlmwHfb/XoJi9QMym3E6WWVJq3+x9Z9svl6Qu+Mtxop5kzSaVbm8lPl3lUwxWg57lcPm/XKHSzpe/wWQdb7gDiZNpfyE3dO7FjDKds515N2RnxANUX3endImUJD3WN6aP5zNbYtAFD1Qzo1lRND9s/e/Il1WTE5rBgsorWC9ycwAhc6Gy2Q32elzOJP4rQfgVrjHRY+dpu5kDdNO7380fATUOD9PPPYtlzUQQFcaA8ddGjonrOn+gc/spvOHYXCZFeElkF0DhKTpeXen1WGR0DY/jnYphUv6yAUF5bZpX/c6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vbNEjnbCfE9zP/dhWhzAAsiXw4gdth+m+/XptQ1lyE=;
 b=XB0O7NyqXem2zZnobrdXHWaErBcC8PPn/pbWjTSStpp3Q5UrmF1fvRODzsYAhHGzeX4w0eHvmqifKN8pFbqifw0gkmRjax76+UKK/BHxgt8WMytdJqCKqH1QjW/RYZ+fLNPT1FiE+c2NSpfM5e3lmtNpq7BBcYlMJ/eQdGWmyjc=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:01 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:59 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 14/24] xfs: support lowmode allocations in xfs_bmap_exact_minlen_extent_alloc
Date: Wed,  5 Feb 2025 13:40:15 -0800
Message-Id: <20250205214025.72516-15-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e82d9c-a264-4b6b-52c5-08dd462dc79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ByDKcFzdDlIlOUjKCacYFHmZq0BX1v2baiCKzRAlmkhMcJCoCrQtj+5MtpaC?=
 =?us-ascii?Q?EhuyBPfRAAzCcxdOZH6JBa/LYYbPuTUYv7/bHGo/CGWDkYDDh/vKN39ST8WD?=
 =?us-ascii?Q?8HBTW4W7aJihIyrv68tuyBVEQ59waYartNj8ckd+lMR6EEvWvdBc5DcMkQQ3?=
 =?us-ascii?Q?A1X1lhdUHYZqHBHyBRQTRkatZVLn6lQT0iuoCXGOb/OCrpGw4imhBp8la0H6?=
 =?us-ascii?Q?oWppBMJRDQojzptaXTUMUWnVczHMG6WVzbB7CfJPlLGEmlLz8SPDdr/hpr6z?=
 =?us-ascii?Q?oc8K2D1vyZJKMTXb10IuMoXqMnwkg540n1L86kgCdAbyV6KNYadA/8k/h5GQ?=
 =?us-ascii?Q?9l2n0SDZI/MAshhNwt0JmmQoaiBWfoGYnr0X7yZE+i/aKXgPRI/SA49qYyab?=
 =?us-ascii?Q?+A7J2HZLIvUgBM1Lc97mGEhA7d4K2qmfor8G9JfhTURgYflHNGIzL/ED9ODC?=
 =?us-ascii?Q?viuwWfjrxypfHhr/yugYMB+3qnZ8/3oIfBvES0UKAqe4NGJxZf9sHYhgbWso?=
 =?us-ascii?Q?rga1Ka9V9G4N7v6rOv5YiJymoKJpNj5ZWNim10O0fO9vkDZxC2efDDnLUC22?=
 =?us-ascii?Q?VZTFWzdTQ2Vxe7fB0IWitQdMlhhbICVLHVpXrceA+ibzNxL3G+XXE9+2RHrX?=
 =?us-ascii?Q?bQ3ZfKcNwdQBvg5X80qRXTouxNDyys9/d4SCj3teKP3GdRLLQ3tq2PMXcttM?=
 =?us-ascii?Q?8WQYKrTycZ3oJ9DmegbS91/+YWsITZngicRwfNQm+yKqjXa+V9Fb6yZVeXUp?=
 =?us-ascii?Q?e4ejOfXqUYaqfqjtd+zMa9CtX2VAjnqjyRzK+AsnrEVgB6xJ7/XfOD3FAW8v?=
 =?us-ascii?Q?h9yrj7Y3YjKw4dBKmnY3+FwjNUT8jPUAlmGo5bg3pDRYDPMOalszNJ3fXJz+?=
 =?us-ascii?Q?EGnN7U1ERLgnqNdDX3Q48FCWjm1Ol1qmXxIy7dT7YHvC7MKDe2Q3f86kfEZ8?=
 =?us-ascii?Q?AF0+PvbTcSAvWUFgF5g4uI36GjFVJ9x1LTNu3wNt76BTe29zjtEOSN08mWwv?=
 =?us-ascii?Q?zFLs55Hq0gtN53E9UylrO7yibtz8oVihm52YShFjXwtC+IbWhHNcI2pm0Rru?=
 =?us-ascii?Q?PiiAjwfHlWuVmTCuJ28As9TbLoIkDTttuTbviVhLmliQ16PMggxD6YnOZr+j?=
 =?us-ascii?Q?X5uqvhnXqM9otqxh1PsaAPznRNOSMJ6re+diSGcj8dKIIEIDuZV4l7iEcFNA?=
 =?us-ascii?Q?FUnuyatmm6F24XmL3zb3E/BzftjIdii09+2RBST4m7NQnA1S61z5YXJKW1Df?=
 =?us-ascii?Q?55bz2LnetY5p+OklxBHrEtUVK+eGHsjQujjpLZiimVPHZfNIw8hIKyJKBLzC?=
 =?us-ascii?Q?gUHTiTzlM9oMrgEFomALsvihosXjCMJW9skUKCDyUV6lLQyKr798yLNnYQCl?=
 =?us-ascii?Q?XIAH0HLdTXzSXkykTbtStx+Zm8mf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4R54BVvwzh7M1oe7tg/l2uMvtNLTFuV9grWlwgtsmzTvbFaybich5EJjNpn?=
 =?us-ascii?Q?ghXfnrE7ASYgylrVOheqHyYUwR//J3pTl3f3fdQ8SpHa5/FYE9crGxG2ipoV?=
 =?us-ascii?Q?Hk8NXGrLU6pxpC3BXE3R3ROTGQ1cSUNkXSnY7fBV0yogamV2105cdHsd14Lh?=
 =?us-ascii?Q?IcIkQPDE5Ixbm4gN0yHE4X5+ZyRlzS7MA+ScCia1X9u5S7rP4BPljx9gOamc?=
 =?us-ascii?Q?/Y09CyjOtumjqF8RcxR/7lMCXsMF0vGbWnhvOI3mNm7X3tQky8WnMS4iQZ2y?=
 =?us-ascii?Q?pdzgA57Ih2vNzztZuQ4rztRskDCVbIzsmaI5vtK0aS6xdn9N84tGcqYBqljS?=
 =?us-ascii?Q?jxjocSfhEiB1t8XDq+0BYzkXq5z3GN6HFQbIiCohHgmODIIh9ZR+BHB1ma/g?=
 =?us-ascii?Q?2fn/m9Bhqxc2OM6zrXwIMcrsOFFAuKcD5PZ5K77Ow2QCEn3KS0EWvXK8owxT?=
 =?us-ascii?Q?QDgjLGj3reshuHDpAh+2hGOeB3nX7sw/31KNi5kwRYyjgHBbrEzpWoCfO2LT?=
 =?us-ascii?Q?ctYYg5UHlUSGARb52GCPtTh/kVtsggHdhccUx96fdU6oDJuNpIkhf4wQkvW4?=
 =?us-ascii?Q?SMhY3v4zNnI/I6h1iK6VVa2KwE+Y8/YUNxd9mNF12zuqGl8/F7aIZru6r9Ua?=
 =?us-ascii?Q?S40SfgTjTUBP4BNhVFUiwsKMvvwjNNgEtbUv9CWtH1M9PhT8nJECpn1shINA?=
 =?us-ascii?Q?XPRjgoAQSPhOFu0fxOywfFIAJopxdbW2oz7Bmu5uEKsP60ZBIs3v1UY613CH?=
 =?us-ascii?Q?fCI6z+cTI7Xr1jZZzgnNCbNtt0xMuUrB0+TG2x6MMF9R2A+5O66dImD6JZvB?=
 =?us-ascii?Q?na87WUuT7IlkktfifBxpJ0j1Ju0aywG7o7CLHzRGZPg9C7CNgRzMmKZe1x0e?=
 =?us-ascii?Q?kC7HicUjYql57IfUuicjhJpxInaCVlIHC6QKb5J8thDxJK1Cru1XAdG71NQ7?=
 =?us-ascii?Q?+0VyTz25OYEOvGuzd9nutFny5D0QieFdMwppPQMCO8mdrwbmLhjWl/dUECdI?=
 =?us-ascii?Q?lX+jQ3Djwl2RNoTkBsT7/tLCLwDZE6R3z0OHiUEO72ItEZMQmITgFVCXkgnt?=
 =?us-ascii?Q?9ydAdRomrwsaE8DY/rCPwf0ZMXIT5zyRVbf+D7CCpQem8QzuQKPa6V86v8TI?=
 =?us-ascii?Q?QOd9+jCLWlM1KpqhYbXxJkrzoV4sG42UndYnSq2zVz9fVeP3mTNaQX5epJms?=
 =?us-ascii?Q?kljZOQgjacAX4iYfnM7LG2/wPO0Ai7kVT/63HfawDJmtu92rszQCdhQfZFeb?=
 =?us-ascii?Q?v7SAoIuQQS6bwnWLj5n8VGpbzbnhCoKwvlO5ehsbJZ0qSICLsZAPM4NHRXt3?=
 =?us-ascii?Q?EdaGUoxPlAyinhbaUpd0pbuDxCWFIuHEcBIoQ8PO+mXV1ei7D8LguX49M46N?=
 =?us-ascii?Q?NjUyaLQBPnYxc8DU4pa9Virb7uh4jj4V2lif/Nd7N0rjS75AE/Go+z5GIAN8?=
 =?us-ascii?Q?xC3e+OQmD47Uhe5YN9dTM2DvidVcM5o11Es+kMA+sI9PcqiyWjpyyy5kmsqD?=
 =?us-ascii?Q?kdVUtwbvHfQr+LkhXmxWJaYUEubRo00yUSGO7adBZ4UJJU53v83OyrQuJI/0?=
 =?us-ascii?Q?VxMpp7oCBsHnjjzlppw3k/AJVsxAjInWx9R90utqxg+Pr3UGpPQfxvYq9b0C?=
 =?us-ascii?Q?LdVTK/L1+WG1TZada8I0OkRTbqE2E8mxNahyQ2o4r5uSytYWhsvdQWNE3hko?=
 =?us-ascii?Q?XCtROw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VXhK0UBJYl4tpRq5dvOAeb8WlKD8frvf31aSs/JdPiYO9i0q00BaoJSVhIourX7aw+1wNzlyooU3zUVJA2H3o0OH18zYOuNHNAGDG/k3iM/oCMRnPemVvsyEPFIaIA35M9nDPSvTPikvb1KkzfTGQqtgBpg27LHews2AiQNvIn0OQqeYFLyPTlWueU+hKQJnsXsPSioUpm++YDU1gp5C0ZXp+//PSEP9p1+BpPFWqhpuWeMfia/UQMGdyg9sKLTmET84kHb6J2VZHE3S/joyXHjv9fWzHeCjzrBKJIBkHjX5vbwjAZxzMPChetgpcT/RG+RvzNQdhpuHNtWRds60qc8lbRM1TNDsixWW1xbZVr8N31fJXS73dYRRRbXQHZQiAKu9UfPnjsYY5nllCXWLc+BB35MTbWuV/wsMKTbgJZEjUdGm++nuFH3UOHpNHORKhojszeWVJNzyfOdqmOgRxbIje075RcXucPxszjQwpJNyeXLc+sfKgeMBy+L0Bu7pNvi4r2+alZX4k2zYJ8FVp+mz+bIa8Ml7AppEEI9qPa66PKnaVIw5PcaapZTXoyA+JqVUmmztrD48DpdtG+l2CWZjNL5WHSZGl6OsqAtYot4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e82d9c-a264-4b6b-52c5-08dd462dc79b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:59.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adReoRV2DmtY2n8A2qe2niPCVp1Ue7U+J8rglVFJ3UF6YiruSaw73arZZiR0khRStiAU2aMYA4TfoT2F9BgB6Gl0gKFi9hfCDkYK1UbukCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: Z4n2Zkmitn6ga0DzU6nO_vLx7d8YRK5v
X-Proofpoint-ORIG-GUID: Z4n2Zkmitn6ga0DzU6nO_vLx7d8YRK5v

From: Christoph Hellwig <hch@lst.de>

commit 6aac77059881e4419df499392c995bf02fb9630b upstream.

Currently the debug-only xfs_bmap_exact_minlen_extent_alloc allocation
variant fails to drop into the lowmode last resort allocator, and
thus can sometimes fail allocations for which the caller has a
transaction block reservation.

Fix this by using xfs_bmap_btalloc_low_space to do the actual allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 8224cf2760c9..c111f691ea51 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3412,7 +3412,13 @@ xfs_bmap_exact_minlen_extent_alloc(
 	 */
 	ap->blkno = XFS_AGB_TO_FSB(ap->ip->i_mount, 0, 0);
 
-	return xfs_alloc_vextent_first_ag(args, ap->blkno);
+	/*
+	 * Call xfs_bmap_btalloc_low_space here as it first does a "normal" AG
+	 * iteration and then drops args->total to args->minlen, which might be
+	 * required to find an allocation for the transaction reservation when
+	 * the file system is very full.
+	 */
+	return xfs_bmap_btalloc_low_space(ap, args);
 }
 
 /*
-- 
2.39.3


