Return-Path: <stable+bounces-113971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713DA29BF8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F1D1888888
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF8215070;
	Wed,  5 Feb 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WAYw4ziG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xfPROb7O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA7215043;
	Wed,  5 Feb 2025 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791647; cv=fail; b=ZMrHhC8mgIgXIcxqhUhBmGagSzXH07H9VwUoXaeCWTMMlsFjhrAEW0LURn3QvkHDJ15qOqC3qBxhuApXc8ejs/qCwnsaOV//ORA34Idnd75SzDuVjAwMcTMUX9NmmUmWA3l3IX4gSXqd7aGYeaMpgiZC+VJWckenWHQtr0XurfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791647; c=relaxed/simple;
	bh=4KUC4TZuxzHRGsR07fgLAsI42pQq9Hhej3vT9R96keg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pyXzR1KZaKvDRONhZCrcxIVqoJNQvYz0RJ2YOvmauY3vcfOp21eRUuL19ExCc9SB20Zq2uWRcN/TgYxX6ojuCvw9YkzXi5Od2GMNuIpaxNUBW3Z1ntJQrUym7dNP6M6pnIf8qT5OiwcasDs1K4lRRqy/ZJDVzO1PEz9XnC1rJlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WAYw4ziG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xfPROb7O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfpuJ015241;
	Wed, 5 Feb 2025 21:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6mqcIOkkAHjHMkEzdmfTTCz3FW8t0hFiGBDikXd9zRo=; b=
	WAYw4ziG7AX/klmM8CiwVcyOpO7j6kXJ/Lx4xslBBt0rkGr8xLQHuOhVMhko3Q1g
	yQBcxod26h0jdatQo1NB1hK7OX5qdVJxslY1l3TKLIPf/Ig6eJr3GMonI5pJ9iyJ
	dCmOD0bTA6zSRvz81btjIJL2cs3qnIBRBAS8SrT9Ywd3Z8XoBIoL9fRw3vocmpdK
	oNd7SsN5tW3R6dykznQ1iDBcITX8M7kblRe/n0wm1Jx79DZd+ULg3+xp3ZquP2/T
	HOn0lXgL5d807Ypz9flqVw9K3R0176I3cmoqAtrqgbZKmPIUDlhqU2tv8eMjudPV
	g//VOVgjYWKtL2ZyCGw5nQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u9eyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Jtrs5026923;
	Wed, 5 Feb 2025 21:40:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fp5a6v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgqZFDdHj2hwayO8GcTPEAcvPpQwvwH8EGYn7wjTULXHrwTgKrdSHdJko7GfnjYL/Gh7aHqs9EkqBFvPdyCxd8FweNuM9/zqQeIC3hbr2sLz+ZqSqQsZID1xnuPRl9A5SaFELUpcbVkDqnPuvOOXIvCPqBRTyvfo/GxAkr6Evt2hxfAJ3dqN+CRKJM0i66E/tn6dtnJycE8Cq/i+4rXlSaZ1eEF6YCpq4uqdWHcEQMfhRIaIiuL7ZjNcjWOWdgUb9bx9uE4jXwtgBBYJzilzfs/s2XIrYxPGDRkD4Mi78tw1iXuguu2kJwFzrQnXPnRTJl1qNtI74IEnHlg0HbubBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mqcIOkkAHjHMkEzdmfTTCz3FW8t0hFiGBDikXd9zRo=;
 b=g7YSIicMUGaSf/0eEpXzQ0fysh/9uUgd6eKgPr/E6ItWmHZqI2f1bIFwhofnNr/RknsGRzmjKmdBgk1RCHIHMXwOK8l12BuHlajbz7Pr5FqQvVwO1dcArpLoDchrrRh/8DfG+MFUhptEIW2i8G0oy7UexZ7wGyZl/rzkvtlkfU3ZZxOoMNBLNyUQni7yXEhGWDTWLQSMPVDN8FNdIHAcuHBQZqnYFg/GRzZByHLqyIfGMq9oYl0uXZzVrvjesSX4ov47ReqKA+3kChZ7qakLEfDZaN9iWZ7/Q2xDa8+Mwf7AQOZ/AJMIsl6tiO4YgpB3LlaaeD3NAK+EHzqL/xG3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mqcIOkkAHjHMkEzdmfTTCz3FW8t0hFiGBDikXd9zRo=;
 b=xfPROb7OTfOqYnZGAHIWp/+9LSma8CxqcEwqi373NQNAn8twNSfasvYsrFnY9q+cczPFZS6wmwMs19VSljrmismjWpPfTMGNTBMKCAGpB/Ag/NSnQXjNkfDcwx57p81iVhzl1+HUdGjkJT5awKB1F3iOlMuiQN83h2bmT7K9Fa0=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:40:39 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:39 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 05/24] xfs: skip background cowblock trims on inodes open for write
Date: Wed,  5 Feb 2025 13:40:06 -0800
Message-Id: <20250205214025.72516-6-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c784865-9d18-4fbc-0a82-08dd462dbabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Cb4EYyk45dMB1vsaKV8bLeXONqg14bXdZ5PjlBRep8xx6NDeOzDAFZI5Fzf?=
 =?us-ascii?Q?psGo3UM3CUKrKx96S2/kmMoEr8S8qzslJSQBAozAhaLCXmBEavF/T/31OIOw?=
 =?us-ascii?Q?6QhBUJwz81VPAGp5FtAdyZ3WMgPvtfxUURU1dhFPMxl/k9DIaGDmaxljZqN0?=
 =?us-ascii?Q?GDxoEs+JL6o2nCrYyFy0opcoJGhx3yD9JiE67tXCXLwzumiw+WfVumw/Dv79?=
 =?us-ascii?Q?RCt2h3rIek4PJBsu0h2snCyae+PiLe8buW2cS/sSDLElYJFpdeKmOXUZA3Mw?=
 =?us-ascii?Q?j2ZKezxQ9VjuTFs6wrrVJIfZto4x8yiBM6H0357stILG5eKIp4/FPM+r02KS?=
 =?us-ascii?Q?9ZNyVB4sPXTfNSAZukMTsJdfzb/ao8lbgaBBREE7eItPDzXDs19QJYiZRgE/?=
 =?us-ascii?Q?7VyKXPd7dH7qS0rl7l0ko0YpfNGy+1hchxhXsDHej1tsT/do4dqWSYh7yeGZ?=
 =?us-ascii?Q?NHiUFMEI9HKv5WEdChm9NUHsKW2Qcl5y9u6vuK9032+MLBPP4rUpoPSdi86q?=
 =?us-ascii?Q?G2n3CMyZoQHwrPbdnAOJHShgbw1Gl/6ZoZR7+U5LkbHrJBKIIHiSRBL3epqY?=
 =?us-ascii?Q?dg3i8LLikLphHQ1IIn6AYMN6+jfSRP+9+z+MBJvG8f3bm+Ntiri7yp4IU1Iv?=
 =?us-ascii?Q?WcCbhIJ1r/5se0JjJGmrho+oiDcUJSCmUrnDleArXjw6N+ucWN8ngbufjWGm?=
 =?us-ascii?Q?kLDQiOUkSSnXiHTHnqwix8WXiNxCHPzXLbpIsHG9TeAofZVP1ii8JeQAC5Nx?=
 =?us-ascii?Q?rxUbDMhCmeGmcDI2lTBVYyCAk11gc5EnKnuYzTqafiL/pmlA4qFA0Xt6WK1y?=
 =?us-ascii?Q?+5+ZUuH3pYTRmRxRnvdsj1zG9O/DGbqxE4X5GTMSL7nijb9nbWeiXDi4qKJ9?=
 =?us-ascii?Q?noCNeJmFF+9tXNnwmVbtLgc/TFuH8DfLgImNeHTXncF4qSrtoD0wGlgxEU9Q?=
 =?us-ascii?Q?vmwdk0dZyBTlE8kswYwxFrgq82zzTcHFAL1IF4lr2owr/JMhT/k7tfo0s+X1?=
 =?us-ascii?Q?IBlumG/Bb46JCG/qCYe/WTLi8UpC78YPMKlZVKrdkw6MLQKzOz6PHzDDX5mn?=
 =?us-ascii?Q?rKmVRICBmQHky8Pve3nwZRSW/lDa0L582Zv59/pHS2k6omBo7NtaVUuhi6p8?=
 =?us-ascii?Q?kU+C5AbyMkMW9br/myvl0WtNaj83aBEWKe6vEPQeweJ4uFOjuKULQe/TfvOn?=
 =?us-ascii?Q?wiWS2nb3s6TZ8w7LEMzrM1Tlx2pSCePvUzyG5DWh++VLr6nM2p31158s8ml6?=
 =?us-ascii?Q?lNN6J7QqtlSLRjPityX+CerfaprPgZra+RtSlblAz1HdecpAMZ+ddoLrFTHS?=
 =?us-ascii?Q?klPLgkhnG2XErQBjRXPPYKS2RDXN1CI0NOjuNYeSyJ1EjdqrGPsRanrZAceL?=
 =?us-ascii?Q?DL+arzTCljbaiRhRoAFDq4eaMH4z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBHMsJY3yw8vvTnziHjBsvkWSC6ZO1j3j3LZzusoVrLTUvPmqXE+ZDZP5QmR?=
 =?us-ascii?Q?ftOpa2NKQt2oXqDZ8uli8HuZw8DsaJevCWmnMpf8+QMcTf9iFsjLqXi0zaBr?=
 =?us-ascii?Q?Un08rp5wE29Ws3CqiDPF5FeAgY1EzF//DiHwLX1Q4kPygafjat8OU8nLm0ZP?=
 =?us-ascii?Q?qvWgarYuqYvZam2D80yEk2Im1hekY24c0duYGqvJGAkOXTOZFKeM+zGiY/wH?=
 =?us-ascii?Q?Q0CAl+LTJ9TEHihZeCtbmfbQdMxe+8CRrS/BAu96ksoO+xNl9U6HaGlUWnV+?=
 =?us-ascii?Q?m3mFZJ8fQhbpGFQjqFcLBP0foa3iKarzLANSZYHDprGYOF3YQ3+7nKIEfKsb?=
 =?us-ascii?Q?dA5SnUcG7llNvzcjso/VLfDplQipDpSXMtoc8/O9TTKmFAZok+hrMmrS/nvr?=
 =?us-ascii?Q?HrXLwqAMQt+7M+CUvsLADIXva21ynDZXg4DmXsfx/GuavOd3nc38KmZyxG0t?=
 =?us-ascii?Q?zmYa+dfHGRK5k3sYpQ3sUvtu6rYe4BT9dnJn4YRWmVtvM5qTGuyD3UEqaBj+?=
 =?us-ascii?Q?iaXvdZeINnSEfelqLTiii/RFS/UiTed2rJ72II4uNNXqo9zU/D2f0WIOidpt?=
 =?us-ascii?Q?7gw6kPhPg/sdLG70cs+5sJALzLOBEuUoYhaweRia4gNX7AuXrgfao99SR1BX?=
 =?us-ascii?Q?WYt33c7n5RRTGx3XLSel8ZeBt5ykJV2rGw52s9gvkGTf5CikS0SMpXi8i2DA?=
 =?us-ascii?Q?hSvf17IkvNg2tDsLBQNAI/2W5dEBlDtODKNHkwqrunILyh2ihiWpmIiKYnpv?=
 =?us-ascii?Q?sOkHHyFM6SUvwyoC4omfCJg3bvqDonpMShM4nCU2RyantST0K0jWCkp06e7T?=
 =?us-ascii?Q?wwHOU3+u77zf56klyj4f5ZsNwB1FfrHA0pRL1hWEJGB56NkvrmFz0PqJ5fqB?=
 =?us-ascii?Q?5ymP/Hxg55L0ygbv/sLLpnprDvJrATSJYWUHdX6WOaPmIx3a7kNQm3iSYRK6?=
 =?us-ascii?Q?2XeadFk4YnYSsGaIoi328k0/ZzHrduuLTb16GoybdBcfOd+qASm+4OZhA6pz?=
 =?us-ascii?Q?QoeVUfaT0guW+2d6R8oJC+vE/XDNvvdz3q1sO4Pi1VbRIuI++zPNrHNYvZoT?=
 =?us-ascii?Q?tbvaL7lXwfP61koedyc4Hd60xhOlnrnPR3XvKtAd5I/c96XJchDl5GuHyrSG?=
 =?us-ascii?Q?PP8L96/7HjyFzt6Xj2LWz3Ak+cORTFu1Asp90Id9WK6txT+8yDWJsYzeu3Og?=
 =?us-ascii?Q?onYPvhflf/ZCwbaQfm72/l8KlJiTQ2PKCTwTqgWcJH2Y2Z9162Zp0A9+gDQE?=
 =?us-ascii?Q?rJ7zv/7Bc33saDHS9P+ztDkvCLRQgoCmbGz8semq82nQrHgzSi6WNdnY1x+y?=
 =?us-ascii?Q?mbZbD49Hl+73wR+20B/jJpAwa3kDM26EdWO8uSyaskP1p6IY6KJtrcVpbmq3?=
 =?us-ascii?Q?As+FydSeHC3PLgefwW6uYLNMEdUsEw8nCnMzZQIq9RHEJVqjBsE4PPtxzjXZ?=
 =?us-ascii?Q?grf6d3UCo1/2+60CElkisLSm7BRf6VRoh1gcr1gQ56/SESz53dPaBB3+OAuo?=
 =?us-ascii?Q?4uvQ3CF7MANSBzk3HbyZhQk0jIL+JBBW6J9w3MvJzR9i5Q64s2g3cYPE7iyg?=
 =?us-ascii?Q?dqcylxqxYUMVYyW57G3iplLsnCm5rCGFz2mqz2zHfnDw4xa6JzPQl+eFH7zR?=
 =?us-ascii?Q?PAv903lvlVhfXVnU8DGHcUEZy8INosdLbSOWU7cEsENLXoTWhUsxLxfV1MG1?=
 =?us-ascii?Q?w8zfOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Dcgd/WIsDkZqDpAoqSirfQ/7aAbuzElpgK2NRvNhtdQE+Z1DnEJb6WmzUaZ6YK2Vkgo98qyT+Grtruv1xqhW7XajPDXdLhvOV/EZSom3XepiIX/+u+6wRDqJ/GTmAHcRqNLlOzHdifIi1upljDmqoQRb615aOBSClt18vwFg7KhxoUiyiJ129Eb8xcIAMQxmzrEHiRt1wxxpxxyULfrCANUFuPp/GjmFrhrG008kOmlp+kQBC2ZV2mk2Jq10lKugDGVy9Rzd+pqTkRNIKuNNvX0V5qGlGxFPEThnOpRZNeOCbHH7XluHu1VoSaSx/ndbu3YOY4jLBWroIf/4n/i0Vkz0wpetN2R+IJtBHqIkS8wn7mQxsPt/FA/yEJkLGiE+5QaThuJRZzjAHHm1aBrIu9SWas2d6ghveoo8efGKb1ITRak5d0L8caPECxF40CWfeQlH4uo/GiX6Nw9T5xch/ykaw7kO7bpqx2gQbDRsIqFCVBvwAcX0Tzy8GTAUgSDRqft245z9LKraIvrNBtUAIt4rz7uuEDjAB9oasOR4pSG775Sjq2HbU5Pd1oNKzq8IIbEo4rf5I8auqSzWeRQfEIVE0KFuCxP59660Ugrr6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c784865-9d18-4fbc-0a82-08dd462dbabf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:39.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVN1O6RQfvHZ5lcIiJi+aTWfZUIp9LKAz7/gzA1KJEYZIRwQ1KNP2vTO5vs8QU0c2ZNJJT7iSLxsIMuUfFsPN1/iezdQaEkAdiT7oteC7IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: P6N1Oxx6DEPTBXYLHShjxDRxNd-GEy1y
X-Proofpoint-ORIG-GUID: P6N1Oxx6DEPTBXYLHShjxDRxNd-GEy1y

From: Brian Foster <bfoster@redhat.com>

commit 90a71daaf73f5d39bb0cbb3c7ab6af942fe6233e upstream.

The background blockgc scanner runs on a 5m interval by default and
trims preallocation (post-eof and cow fork) from inodes that are
otherwise idle. Idle effectively means that iolock can be acquired
without blocking and that the inode has no dirty pagecache or I/O in
flight.

This simple mechanism and heuristic has worked fairly well for
post-eof speculative preallocations. Support for reflink and COW
fork preallocations came sometime later and plugged into the same
mechanism, with similar heuristics. Some recent testing has shown
that COW fork preallocation may be notably more sensitive to blockgc
processing than post-eof preallocation, however.

For example, consider an 8GB reflinked file with a COW extent size
hint of 1MB. A worst case fully randomized overwrite of this file
results in ~8k extents of an average size of ~1MB. If the same
workload is interrupted a couple times for blockgc processing
(assuming the file goes idle), the resulting extent count explodes
to over 100k extents with an average size <100kB. This is
significantly worse than ideal and essentially defeats the COW
extent size hint mechanism.

While this particular test is instrumented, it reflects a fairly
reasonable pattern in practice where random I/Os might spread out
over a large period of time with varying periods of (in)activity.
For example, consider a cloned disk image file for a VM or container
with long uptime and variable and bursty usage. A background blockgc
scan that races and processes the image file when it happens to be
clean and idle can have a significant effect on the future
fragmentation level of the file, even when still in use.

To help combat this, update the heuristic to skip cowblocks inodes
that are currently opened for write access during non-sync blockgc
scans. This allows COW fork preallocations to persist for as long as
possible unless otherwise needed for functional purposes (i.e. a
sync scan), the file is idle and closed, or the inode is being
evicted from cache. While here, update the comments to help
distinguish performance oriented heuristics from the logic that
exists to maintain functional correctness.

Suggested-by: Darrick Wong <djwong@kernel.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 86ce5709b8e3..63304154006d 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1234,14 +1234,17 @@ xfs_inode_clear_eofblocks_tag(
 }
 
 /*
- * Set ourselves up to free CoW blocks from this file.  If it's already clean
- * then we can bail out quickly, but otherwise we must back off if the file
- * is undergoing some kind of write.
+ * Prepare to free COW fork blocks from an inode.
  */
 static bool
 xfs_prep_free_cowblocks(
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	struct xfs_icwalk	*icw)
 {
+	bool			sync;
+
+	sync = icw && (icw->icw_flags & XFS_ICWALK_FLAG_SYNC);
+
 	/*
 	 * Just clear the tag if we have an empty cow fork or none at all. It's
 	 * possible the inode was fully unshared since it was originally tagged.
@@ -1253,9 +1256,21 @@ xfs_prep_free_cowblocks(
 	}
 
 	/*
-	 * If the mapping is dirty or under writeback we cannot touch the
-	 * CoW fork.  Leave it alone if we're in the midst of a directio.
+	 * A cowblocks trim of an inode can have a significant effect on
+	 * fragmentation even when a reasonable COW extent size hint is set.
+	 * Therefore, we prefer to not process cowblocks unless they are clean
+	 * and idle. We can never process a cowblocks inode that is dirty or has
+	 * in-flight I/O under any circumstances, because outstanding writeback
+	 * or dio expects targeted COW fork blocks exist through write
+	 * completion where they can be remapped into the data fork.
+	 *
+	 * Therefore, the heuristic used here is to never process inodes
+	 * currently opened for write from background (i.e. non-sync) scans. For
+	 * sync scans, use the pagecache/dio state of the inode to ensure we
+	 * never free COW fork blocks out from under pending I/O.
 	 */
+	if (!sync && inode_is_open_for_write(VFS_I(ip)))
+		return false;
 	if ((VFS_I(ip)->i_state & I_DIRTY_PAGES) ||
 	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(VFS_I(ip)->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
@@ -1291,7 +1306,7 @@ xfs_inode_free_cowblocks(
 	if (!xfs_iflags_test(ip, XFS_ICOWBLOCKS))
 		return 0;
 
-	if (!xfs_prep_free_cowblocks(ip))
+	if (!xfs_prep_free_cowblocks(ip, icw))
 		return 0;
 
 	if (!xfs_icwalk_match(ip, icw))
@@ -1320,7 +1335,7 @@ xfs_inode_free_cowblocks(
 	 * Check again, nobody else should be able to dirty blocks or change
 	 * the reflink iflag now that we have the first two locks held.
 	 */
-	if (xfs_prep_free_cowblocks(ip))
+	if (xfs_prep_free_cowblocks(ip, icw))
 		ret = xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, false);
 	return ret;
 }
-- 
2.39.3


