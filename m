Return-Path: <stable+bounces-113982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F4A29C03
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DC3A79A1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A121505F;
	Wed,  5 Feb 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8pbwveX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vgam8bvy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2A214A96;
	Wed,  5 Feb 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791670; cv=fail; b=QiDeNrcwaRV6scYJQssM4kdgzYv+sHURMiOsN2t3mSxOVhF2cG767cR05wASid4YFwVeyNtfF75JfdEa0WU9QcZOYSWqMshu4D8UhvCjbV2Wrx3srVDiz3K0P7kMxeCodj8+0LgZBNvyl4GbbaamkR/YR580QlOwPZsx8lTAb5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791670; c=relaxed/simple;
	bh=dk1d92PnKX/ukcpo9aGivTbKCaC2sGERLYtE7SJMQdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbhGHbcoXwlJLBuNGg/qe3JFvOILzAP68FUvF767pFYaXA+Y4EvOB+NsNb1lTfv1yqagskxzVy6uK6VbNM3jL1uCwfMRMOK+8JbGyigDryRAp01Yag52aYNDhakfu0X/KBzueZJ9Yi25KrYwH2HhZ5gZp0f5OiTPPfy9HRLLFf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8pbwveX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vgam8bvy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiGF009549;
	Wed, 5 Feb 2025 21:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2iIISFBUFOY9GYYE9Xo7av14nSPBVHM8RhxKK7tXByg=; b=
	n8pbwveXoL3BMYyU0aIuea0KQOyEjtAGXR9i13DxxyOCj8kMcFhMKD6KSPCqzaky
	vJk5Mcdn/6IiBYxJjymshwwDAxSLUshuQQr5QNtdY6OgAfB8lhciVxa8vYvwj/wz
	OpMZM1lGiaGTXgPWdODyGYPVGQKdj+r03IB3VUwm2sL/4gAOrsReSkJAMx5VCLv/
	ccaKyNXAlg55GAljULHsjKudorsXnjSvvJ48McJpaF0e7sPgIxR19meYptW4rYGA
	MI9TOqHYzVLIYIkwmIStCvIUKs38hw8f89EpmDw4UMylYa6Me2pYfkdb8sxa07cg
	5WRldcdvpKfEPcCCXsbYyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ubdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JrdLI020654;
	Wed, 5 Feb 2025 21:41:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr081b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSuNdT9Axot8Ht1wkaS8gBaLM+dxGoXMedBrgjbr+MexMoueQT6GoFIwa90eKl/WmlXWx8L9jR30EbIdNC340NkUshXduS2YigDdSczsDuZJMMDbH5se/IEt1dtbOZSL5tgYO7VZCBije+eXQ4BdkXUehnl8y7Q6PhxsFc9CHnHSZEPUKl+drWDyMmi1cc7P86Z9n4V50N43Sf3KxuqcNkRdyLyeG4WJmD57ZXb8vmMM/ycMFCVXRsSM2AbEB+SfE8CyjfaFeIwpgFr9WR7HGm0teWkf3yKIiM2DbV+EC4P2APjNfLXZEh9db2cVp5x59kcw/0uCDTkyGMECDN4www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iIISFBUFOY9GYYE9Xo7av14nSPBVHM8RhxKK7tXByg=;
 b=h86T3iq62Jv3n5JwS0gNHXEewALgfktQWbWSdOp++m/ECLMGximSsSTqIK6uuyox30VIqNPOy7oJZWnUecHMKyaWAXLacy4T2yFTQ2P5uJkDR23VHGEJPYppTVx0V1bcuKMyZc9m1nIjYCvXhtKZVr915pjZ8232Qnk/S8QkLfEgUDM1/VCGz92cnjPTpLgjXbpQ/toOj5nOOjuolNWD11KN+P3T7munp6HVGxLJfMRANmqaV/hBAkKke/xiy261AnAh8AL8WLfEEphfhJ8kjdClFU0NS8nAlX+ql93iwXaxUsxR6dxEIh8suZXDiSpYP+uik2/y0VuN7dKt0au9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iIISFBUFOY9GYYE9Xo7av14nSPBVHM8RhxKK7tXByg=;
 b=Vgam8bvyH+rCmgRPXlzFBXoVt6Zg5HOYg8IMe5UEpn++YW7KrS8ZL4/nwRtOM8c5120vnXQH1jPfFyEBqKyb5axi3ayET1w8FgH4X/XhLIBS6RM6yVrYqT2SPyNXg+O5X7PuQKvPRrrN9P0yprFygX+sxjrG2LXx4YNOd0NCLbk=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:03 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:03 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 16/24] xfs: Remove empty declartion in header file
Date: Wed,  5 Feb 2025 13:40:17 -0800
Message-Id: <20250205214025.72516-17-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 444ff70d-9627-4555-4b4e-08dd462dc9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0OUYt14yvRuSaOHgHAJgIpHY3nY31xdDKIftwWxPQJnXQFel1RlKnGfbSFjg?=
 =?us-ascii?Q?O01OrgDGXbS4G4A8pwU5bssr5DJSHA3d5E19POg9z85htJ4CotrJsy9N4HLn?=
 =?us-ascii?Q?BR/KwbVXWmzT5t+PCV6SWJ6QB4zTeJVwSLIYDrkdmRmbc4XCr+gkZHuOR/fR?=
 =?us-ascii?Q?sIljmd9l3xjsAtc5ekeAepGKxqInZuOLXh4hv13grRM9jHmwzVzn4yxHG6JQ?=
 =?us-ascii?Q?u8Rs9fdxEscma63s9wWL1FWIYSB/XRAyvgtmLyXHmEcntaSbFqENH2l2ZbYp?=
 =?us-ascii?Q?ev0fQYD5K+VedOk/lYcJM6FrymwAIqMkbNqISjgkgh/USeppvyHAIIMyhOwl?=
 =?us-ascii?Q?7Ze5hEmIv4NvToM9ekVbIEcOgcpUCbDStShbUq/snrMppmDzGGhtoVpx5jzW?=
 =?us-ascii?Q?8t3ATd3Y0Vx49anHtOZ74vx7G8OgBasPMkJs2rwhdJWJ1ANuenYID2iMu9nK?=
 =?us-ascii?Q?5hKTz0C+P8shJMaoXxbjjrbkIo0Uz3G8F+N5TxR7/HWphpNNijpkpD8GFzDW?=
 =?us-ascii?Q?wMx1L5lzN9Ah0nYDykhsAVmjhtCKJOZD58ziPXSt1tmDSRTcrMHh7Z2D6P/u?=
 =?us-ascii?Q?JRwJT6PSWF2d9vVe+bsUBtzD8WRcTVVtEHnDgeILEDA9m+EZf5LGfmRnRXvl?=
 =?us-ascii?Q?JI57+x2YHtQDyi2vXZOwbMu4XzqT8cUA0sHvYAa+qlRr03c2VWzKKLsA2bcg?=
 =?us-ascii?Q?WpVvK5uvNJQMGcDKg7Qzx1dYMKmL1Ggwg0JG15KJrRI/CXl1zmXW/vl0hFXU?=
 =?us-ascii?Q?CpM+pq7sjjHsioD8UgsZ+UKhQZCmLXDksTJcV3FAF38UgPN/x8Ofj7w1yFKM?=
 =?us-ascii?Q?NaHM9YazRG+k0UKqqPxsKeRHKuJCfr0ZuLakAY1ixBlIBQjqWpePFbf4GTX1?=
 =?us-ascii?Q?UX9PwYHjYbYjK0mO6gcQ+ainz9JYCvucAbMUpJ+UIYwLMGerLV9PuBQroKMj?=
 =?us-ascii?Q?WVTocmapmm8XTjmj+pudc1IYVfOiX0YsthJQ/rNP8kL21sIkpyxoBjTDFNzC?=
 =?us-ascii?Q?dZcBwiyTgrM5oE2muIymC5PPtz6iorsv+whUusCEhbOmSYKH6aJlIQZcjEVp?=
 =?us-ascii?Q?cWsysYZ3m93XK0Rk9PTWS+z1uCgSZRbSPYWxCMh5hLe1L4FKJtdlLq8CL560?=
 =?us-ascii?Q?V0VbAmF7bJnc3ZJT+A6QVJQ4Y9y98ACYpMqszvcZ6SXK9IT19UKukZvRXVqi?=
 =?us-ascii?Q?gA7Hf9+WvmvEg3S9x4zRHAX7rVqc0wtoIxtCwoxzXT7hOasMRwSwFLM/neHp?=
 =?us-ascii?Q?onYF2HLUEvtVDIfqSc1WAlzXZ/fVTsci3LjlH0FObcEVuEusuWnE2TjVhZxK?=
 =?us-ascii?Q?nFKCjzTBFLw1/m+CcftJIq2tzj9zImbGujyAG9j5tiNkriKMFw6SqMWK2n0t?=
 =?us-ascii?Q?9csj6L4/vaku4K+zgfxt0M1cchDa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z9kwZJR5Anvu8tbZ+m0w01E4vGCelowcyWnjewWM4rKbmBS3bJBeUoeKLF59?=
 =?us-ascii?Q?QHpgT9+sOGTm21pyAe3hnHhZLiANM8M/zrann26lo5jZt0oNwH1/0HnDF3qJ?=
 =?us-ascii?Q?fFc+EfQYVFJkNuwvwq4iy6gzUds0Gb7xejJqdzTM1oHEG3i+KC2tE6rreWgw?=
 =?us-ascii?Q?q4bksA7yW+rb0I8nwGWDykE1xmgjIy+eqyxvBa4zrqAUntWvMkFWgnZBQ96m?=
 =?us-ascii?Q?/Jpvb1AC7LXWTldFDG+5RHXVE/h8tFXn/8pNT4ukW9B/FiUQMDbCw/l+OGy5?=
 =?us-ascii?Q?E7uDhKhvHybzclpuQWFqyJJafnyFKqus4LnXFAnPuU89dAeIdeaH2qH9o8Rv?=
 =?us-ascii?Q?GlKva10hXNICclDvABlPSAz3qISq/lRzSUTEsY1Fb6iT2MG1i+Cav3aWAc5C?=
 =?us-ascii?Q?ni/bYb9dJMgrbdKtaFzWF1E21lD8OV3RSkwsHUhYLZV8zTzhP6VlM6uE6YW/?=
 =?us-ascii?Q?TntK/xy+bwRUE62eIErdo202C4/v0jaieIIMUKJkmdqiC3ilF10/CxaluC/8?=
 =?us-ascii?Q?4ji4Srxt64DdBugbdnUEVwkYjlqnwpEBJKKxznb+Fr0FIZ8rj1AGJgMVmATx?=
 =?us-ascii?Q?RDWLyIhkH/bIyhhX0FvypjqjniQaba6Djmr/b1OUY07OPtzQZ8UgH47Ke9C/?=
 =?us-ascii?Q?deN6FZvT2CXK8VbFk1yLiVw6TotHvtLncbAapik87srAJAHb+uim3AfRBghO?=
 =?us-ascii?Q?StBfl68R9ubgYsRJgbPtc9ld6q9OWoQOQvq1frexdBMd8KtQacy1OO13JwaA?=
 =?us-ascii?Q?cistlaPmwltk9rvSlqRkYFgOUl/QyvGqK6kKqvye3ZIAGFxsnA8exl7KS1Qa?=
 =?us-ascii?Q?9e4CSC2w38cjRQi2A45C6CG9ssQSKVaI+5r6B7x04JSeafHUTekhlKrHXRQ5?=
 =?us-ascii?Q?WwLi9b0WzUR+GwmefH1tCSiJnTkl/RZNcct44FZKnYK4qynPqXKKEcUXtI+w?=
 =?us-ascii?Q?7+UhkV4/C2vUVModoUM7xQydkpDgTxTKCqv5VjDkZsLJiu0CkIhTrxSu+Slw?=
 =?us-ascii?Q?tWXdHKJsR4OXLbGENNi2PBp+S9gXztbs7+fpiabsK9HKDSDiPq1Z9Bs2oewY?=
 =?us-ascii?Q?gFXlAIkSX4/gQS2i6mq0u8qo1J1FISkaJCjMjoHfpdarD6oS+ng5zKGdaOad?=
 =?us-ascii?Q?JOiC/ClyYWk8VjovOWy4rDyu89e8WRtkobWCGS9S9GmBJWIFfVYtmq1emOFX?=
 =?us-ascii?Q?9D1HLag4hYJFSwiapmZXajpMKi4lMME8xP2f7oP/F0gD/xuYVPZG7Y2qtcjW?=
 =?us-ascii?Q?VRrF6JKLMh93z+qUUMUxcDX75kUvpmL+uAGLDHBhlo2jKpYpNry0Lxh3gDcv?=
 =?us-ascii?Q?DjpBIZcEWlB+R+An2ut4ILTrU07JtC+r5LWAtgRiLFlnNgHkcPuH/e8MiIXI?=
 =?us-ascii?Q?89xA7QqSN7IEVFO4M+NpK3/LNsFcg/sgl52C2onaCcnrjUL16HdLh0H0poCD?=
 =?us-ascii?Q?fzXOixQwqlWnCuUipEf2pvpblUTqtWtkuAHc6zxhhh7LpBuYvRoL8KL0jl8R?=
 =?us-ascii?Q?e4RL9JONVtzx9tXsH2J2iN8paAgyJXiMf/FwVieM39gjBDPYCrRqlPqATRhC?=
 =?us-ascii?Q?VlYQlTGPA9GDUHY+1HvFKuECgmCjKGrJ0mNZGkYo94oAz+z+ReIWFgMztbGY?=
 =?us-ascii?Q?lqYbdolKTMZ6xGGjFL6mN3SfHr/nxdhrE7dbX4ABNzu5A65+kYnuKnz/c98+?=
 =?us-ascii?Q?SO0eXg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jo7EtNOrddBl3Qnw420MxlhmT0kGqb/brLgRT364emmw45+aXjzyhnLHrwW6WW2CZEESd0bTSxLSkYoqVe6Ume+rDFlg1o5gupGmSZT5ApUBDTyjuZ5i66S7gsWHWNd3CtLbb0GsLMR1xmZLRIMBNPIrFqVe6tqFgYYtq9YWyiBhqOKJZIBK5cTLwehFx4jjXzG1tuhyrKiyVt8MVPW7sL0jawrQ44nQbudm7yHcRFpi4X0eo8SC3RfH+q2g5EKpjCASYzln7ktqgrGDl7eLl6eAKrAudm4Fca4CdweabgQoCtoamGM6SDhyf0Syys5ee+FYWoy2hYToOsS7keisAY5Cy+vvn8QtWUwmQaKUpYYKwDhBpIwNnCEPUyP8mLufhA9M6ovCVMr4Q+2+Zoi9jz84W8AFwjVRynyyQ8oZq1RK/pxmZ0ozTMNrq7pA56YWx344zuXxsAm/kSUnVqk1Ts7cw7mKhKrC4Y9K1PGAj8LNhg9ZMbGACl5w67S/8BXIVPv15gzlqvaOxYmyrAMWJdGGUSW62gQuG7enIEkKUVEvWJxoz3NQTKWIfhhuHOfcCwNThZxxTSS7ihXVxMWe5+YBkCjHFZ5nqO2pzYYi9bE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ff70d-9627-4555-4b4e-08dd462dc9f5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:03.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq9NwUQbKafOQZOlnXrKN9tfMrpRkX4KGwDilOW3dDOBiB7XorsbXfaVBc561GDDbdfAUx8KnsKpVKT4Ka8w+iizGKD7ssVv1Xeb6ljXWOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: xMKWtdnZRRaXLhd43xNjHfqNPmA3j6_F
X-Proofpoint-ORIG-GUID: xMKWtdnZRRaXLhd43xNjHfqNPmA3j6_F

From: Zhang Zekun <zhangzekun11@huawei.com>

commit f6225eebd76f371dab98b4d1c1a7c1e255190aef upstream.

The definition of xfs_attr_use_log_assist() has been removed since
commit d9c61ccb3b09 ("xfs: move xfs_attr_use_log_assist out of xfs_log.c").
So, Remove the empty declartion in header files.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
index 2728886c2963..8e0f52599d8d 100644
--- a/fs/xfs/xfs_log.h
+++ b/fs/xfs/xfs_log.h
@@ -161,6 +161,5 @@ bool	  xlog_force_shutdown(struct xlog *log, uint32_t shutdown_flags);
 
 void xlog_use_incompat_feat(struct xlog *log);
 void xlog_drop_incompat_feat(struct xlog *log);
-int xfs_attr_use_log_assist(struct xfs_mount *mp);
 
 #endif	/* __XFS_LOG_H__ */
-- 
2.39.3


