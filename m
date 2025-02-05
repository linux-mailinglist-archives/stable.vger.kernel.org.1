Return-Path: <stable+bounces-113983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC2A29C04
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0071691A5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B521504A;
	Wed,  5 Feb 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zsf1l7OS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eIkTD0G2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D8215043;
	Wed,  5 Feb 2025 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791672; cv=fail; b=GOMF6fikVM38VViLGFJh5pnk0hSwSpdPkck48RzRXz5knCZT0UyGInEcCmh9o1KvXLLXUwWofqon2NsTg0jrN7Plyni4Pa/EhiWt4RSX8aC3M3HG9z2qWqv8fKNw3gBKGKS+mJ1vwrVI6kZI+oNDp5iBXNNLPgoi1guNfP7jEHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791672; c=relaxed/simple;
	bh=XMnQkDcMsdKdRd/cNpc/iafd/BEfDKI6qABx0P38OsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8OuCuxQrQU7eifNeL3h2D6g4lkZCwDl4QMzHUEdlQ4UO7DB+8e6GtUP8+y1LNKS5re+ol20MjvJLdKejWbvlCWU7g9280fkuHjcS9nBBJ5kb4vKMpkUwn/Pr52HHDB5YOH48rkQAavQ6q+k870zgy4S++jm+TjYjANqZz3pL0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zsf1l7OS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eIkTD0G2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfi6R009599;
	Wed, 5 Feb 2025 21:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vHj3fSQSysRpx6LR5Q2QJEeEBlEJS9FD/mnd9WE+S+s=; b=
	Zsf1l7OSuBJG2Xj54VnS8zdUzPCOjS1bXlzmMZHOKUMLiqMvfopTnofKjpAA58Ei
	o/KocwoHfL+tQJ2vakUUh87grTMo6s8QJCYKZTYWO+aq/vxlW3V/KPp+CoLAN7aR
	+9z89FvuvVJO1d0URdVSg8qDhPofr/Snr4SDV7bU8OS3Dux4/WLJmsSGQzxo9dSR
	kMXQXLV6AjOU8gKSprYZoawQzpgJsS1FpD0eexno+Cv89Sa9D2sAnRzPUYBtbhKi
	yfw0ruLA2D0Mwe5Rnramj969ogwyBBL1GDdlVYFPRKUe0tuQQjNdhWQ1annMoDZ4
	oIJtiZ1v+xzSEr/dL67j4g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ube5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JuAOC020733;
	Wed, 5 Feb 2025 21:41:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr083e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMjMx1szw/gMQadYG+nAaNGr59h9AFoffAeWCgJwWjzs5CC40fXRWEj008Bv07DYJSgdvslWR/mnmHW7OyzcCHGMejKv1SIakLYslrMZoZM/pq/PPLof9pWD/EJXsbGkQXqlEXd/dbNeLodWrulC6njDwqvTWszPBcBcuTjYC/nDmzhIboAwOPFp/vj9e5sSiljPscFx4QS7xHqHbFxHhq23trcOPzK45SiEcoTYirOjSBi7XBEsPs5SRiHTTvb4+isq2D1E8/yEtCWKJAKODIcg+2QQSNQbdykyNV/AmkPIegq/Rr0Nqz/ATZqA8a0EwqqjEtMods0P3F5SLHUxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHj3fSQSysRpx6LR5Q2QJEeEBlEJS9FD/mnd9WE+S+s=;
 b=ad2Krzf+7LBflyDgybkMx6nnci+hSOmG0znGibMOulNdrchRk+l5umzVZ8Ha5ttLK6fknXqhRLQuhozfam3DtjyXbjdI0zDzqNaHJM6/1KBKsRHZcE4H4iMP6d4KMN4DTI51s3rIVtMkTNZHb3Fx3erGKuN4eiy+50rGeC+WqSyBupeaOyMFJ7QcXjpy3XlyaeUYOHFzEjXC8RLfzaxpnBOSEivhlgGZcd1bsIJSGXb/FfpJMCQGVjbeoLwxDVLwEyGkFEccgD0ITaWSNwVPvcxs35Dv1xN4zSBZLPODCZxGjSGx5TpHdfa+309utn6r37mx/bED9nAmUikmSb8BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHj3fSQSysRpx6LR5Q2QJEeEBlEJS9FD/mnd9WE+S+s=;
 b=eIkTD0G2pgZ1bn4RMoE+zlw0eiuZs/bSpRG6sQqfhzHyYt+mFCpnQUF6iYk5Lv99G35BzCxc4ABabzwEEZjnCVtSp1SoRLibGnmXvpAeXTdfFUT+R11nWxJu8njU4wupb68C88DJbZ948jl3Qyb+ozRyt37M5pv3QLM9lo+iUgs=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6320.namprd10.prod.outlook.com (2603:10b6:806:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:06 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:05 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 17/24] xfs: pass the exact range to initialize to xfs_initialize_perag
Date: Wed,  5 Feb 2025 13:40:18 -0800
Message-Id: <20250205214025.72516-18-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e09de3-03c4-41f6-4b24-08dd462dcb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txQJZli0HfWWAR03kHP2FUTjrTzjT/JBi3y7Wx6Iw36iASWwbQ/NESQwD5LH?=
 =?us-ascii?Q?9Bo6+kGuNaGxt9qNMZHSX8b1P5qjm5L6awMzkHVKzWa0iGxsv5xYOrLhWb1z?=
 =?us-ascii?Q?/f1dJ8Kke36PM97SvJU69yMdhvzZBErfmreCPj97CgLOpKt2QdDsqs+xfpOF?=
 =?us-ascii?Q?Ju2BiSY1pWHi9YDbKuQbbOFCiVnViAgehfQqiX4X2/SgryilEdmCbkdvT2se?=
 =?us-ascii?Q?kwzDV0OLwoO6EZfmgeaIcjvqWxcDsLJa1QgkS+labBAar+THgxBLKOe4aCXy?=
 =?us-ascii?Q?OuPYblIpuqc1+yR9S1xMi+corhPpvDoPnvG8VfJS0StJg3ndK/64WVbLE6Lv?=
 =?us-ascii?Q?kjSBbT26pv05De+6duV7mXN9/u6K0XCOITGeJNAbtp+voJNcl5laLkoO1o9J?=
 =?us-ascii?Q?OwlJ3Qus4UcYtJ11LgMLLEtGuxlv0hO+4SJNmiDLy2Zn+UJRU9hJob1kik+V?=
 =?us-ascii?Q?rRaWXpBIXTbVXCJhTSci/aphcN2T9gDGBgQ4xUBa3vi5ZlDsCUjlAcYwjWaT?=
 =?us-ascii?Q?iMbDi7ZQTPp4zDPYlamJEfGeomBQWf7ixw1UCwbqmaXTFCL2N17oxAX0jP9Y?=
 =?us-ascii?Q?aN1Q0OeXUxQFYle2SPi86+Q3znhGpkrXEgkrVcJmblbU8Zx5Xhu4q1/9QsW6?=
 =?us-ascii?Q?wodVu+/+yDEb0hX+KmE66XerlWrQtwmZ0yzaPb4W5jnMRSdUfIBjkb5IlTZd?=
 =?us-ascii?Q?IdeTWK6Ab6+nGLUjhsKAPh3uZrTmUfxxzG82l9Hwc1vpZM0ak4a/o/2DtuQK?=
 =?us-ascii?Q?m38N6m/YEC5aemm3juwRochDv/qcwLGqI5qrJhYd16QXqHl1iIIFhnrpOkFg?=
 =?us-ascii?Q?ot+mk8VpAnGN3aCUp1N+4v5XZ5TD38wABRSjowlkhHTK/2sZizWUxt7hmMIj?=
 =?us-ascii?Q?tUIHgXWUgAeaRGaAkvVuGkL0gb2sLFTSvQfAQoRcFYB8qJzAQcADkbdCliY0?=
 =?us-ascii?Q?pA0Uv314jURmsbzmMTCK0kqgNqrCvgrWoFu+m+mMGxl5mrJ45E0jxr28rQOY?=
 =?us-ascii?Q?SeVaI8VP2kuJKiw2Chk1xT3XmJgkXsItxYDI5PhvpRtVIyqIDwgnl7nqSE1K?=
 =?us-ascii?Q?ZfWHLKQ2GKw+2Jj45fQLjzleSm+BKptYktyB/ZDRfyZ2EjKo3U2rU0Oul3bd?=
 =?us-ascii?Q?eYkPQjGdDkVHho3VAHTsTcew73GUx2jsLmtXzgDNy9YRfqj9PuTf2QQRJ4NR?=
 =?us-ascii?Q?ZsxrKtfTxvZ4fTNDYVeP9W/dHv+iq5wwDdzwCD8t/Y8xzH9FGCKUivOgl0LK?=
 =?us-ascii?Q?avz9mMApqEFF2whQJUnxM3e//fsB3yVxJQh9xYhfGuUW5m9s7mo2v1fd3WJ/?=
 =?us-ascii?Q?EYkd4T3K8RplBLl51XdOb2ylS97y91OgUln5KDOV2p2LxalcT21c51uaNA03?=
 =?us-ascii?Q?L97SenIZrlNx1dcLDeHQ7xGmljCL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6twPv7tXppW6DHJlPIAZl1HL4sEBCz/AmyRqFWl1JwThYmlf/wJI8+d5Ybtu?=
 =?us-ascii?Q?I5ohz942AVzTh9WxKjzysp8KXNyYmeHWUGP0mdGfMYqLPcOjTqalJP39iOSc?=
 =?us-ascii?Q?7uZrKLMMelr4H7/DEvbGGH20n4qDiRpt2CJTz/+67eFNYaSqljqYVkcy08sE?=
 =?us-ascii?Q?+pniCcMnQHqh8Jj+QfG0fo13EXEK1PD645DMbRXhWdPiDh9HTKlbeU/PupPT?=
 =?us-ascii?Q?EvknKA7CZn95ZGPSQNBJUDr2cS7xHn5iNCcLByubmIoP1U5DCNYYbhGpnjbL?=
 =?us-ascii?Q?nCBYkVPONWHci/tXxvPxgct2zVhgXcnjPbd/d94F7rq1qxI/nY5BLM8/kvgy?=
 =?us-ascii?Q?MVOTw7XpCRyCwKrzt2TC+0CCAzlYLHD7fwGW1w++ntbyujNdC/n5mxXTRM+k?=
 =?us-ascii?Q?xo0egmKtVn7RelCVFRyKA1uW8XUH1DvBNyB4LwZXpJr1Beq6JCFKqhToRyLg?=
 =?us-ascii?Q?rqVs9T+iMoSZtqsFSPaHAeLGOeHKbpLZwFORa8kaGpz8ZIRQlWok/fpU/24F?=
 =?us-ascii?Q?0qDI0Ldd7TPxnhTZMJidxBlVfPcDfDlAWkWJ8yQ0AdRVpnHcgvSGCOlnggSX?=
 =?us-ascii?Q?uwa7ZQNLV94q5PgEnsJGW7H7JW60WXMyYBm3HQeDBP+t3MGazVsXprCCVIoa?=
 =?us-ascii?Q?kYrLJIVqF9oeu6/KqHqcfqimsYELkeLrfVhDmOW4QPImaOVLzbR6HHtrxwed?=
 =?us-ascii?Q?ywtQRPJariXI7kAPaRPYiIIvDFloyxvYBIKL8AVjSVc4NUoW9w56M90zJrVL?=
 =?us-ascii?Q?Zb7l1iKSeoGRFOlqk29kNLBhdiz9vFe6shhNehQYc7DfBMQR0aCHSW4cptXK?=
 =?us-ascii?Q?qQt1N1qLRmnDRdZjLOEtrC5zGeXJshnn5Of+HyUVX+BXk9QMeWVRlXmBMgve?=
 =?us-ascii?Q?hEKS6bZ/M7qdkC3WCXWttqLrjOyArVvt7o25aGtE14GSbIbBv38hoepuMpH0?=
 =?us-ascii?Q?hlRqfOcz942VCIiLtFoa8vaB7kaNwomlBmM3bu791xWjHOqcNr/dqHmX9Nrb?=
 =?us-ascii?Q?q7zISv/R07sbcRb50l+WFgCcKPD+eY4t9xKqI8Y3+RoEoDKpSwxghi4N/Byg?=
 =?us-ascii?Q?R7S5/FA3V5OP5+KAvFdycpK2X96JlN29V8Ov+sxBCflZjCphw/Wef+8Zp9hK?=
 =?us-ascii?Q?Hm6dbpZoTW/Fk9Ae/yX8WrmULC57dX7wb9BjgkJmPmL8PAyeSvxcgGELKxXR?=
 =?us-ascii?Q?HCJWJotGyd8+FdwmEo72AvCED1QdMIkEkoBLsRqWO+fXVtiqw8J3/kFusiPd?=
 =?us-ascii?Q?RBTLSL1uu8YxE86g8lxavdIw/zEt/3QnuHXNXVmyuEHr+931jcBpXWCVXRFV?=
 =?us-ascii?Q?nMMA1/6u6WnIM9LDEEE8yIfjT1/DK+hsPKk9+s/8fcEwTTZTuIbUX6Dai9y+?=
 =?us-ascii?Q?dOs8F+pVz786Pztgr5yevVz3bBVJSaPywsSoSsZd7Mn3rAzWCBISpWg/n/3i?=
 =?us-ascii?Q?wciJhyPeEZ1w1GjPoHUmhiS+lIUFWnqLG0hwE8ByZErKowYPafUlP7TKFOE3?=
 =?us-ascii?Q?lj2DwHbW9dBMU9Ah7tyRietD5w2MgyL7X5JYFxWBx+hUXtvS1QpkSrMfa0Sq?=
 =?us-ascii?Q?gImbHiNuAAzTNmWPCXG7Cj4uTlHo+PKWLK9THcNclpttm3BEgMZQyKZtdpPg?=
 =?us-ascii?Q?1DmV7aCOwvez27zRor91ECB8rTEMzuxnAnQwybjC0Qx3lEjUFZJatJufI7ns?=
 =?us-ascii?Q?PTqkWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HIpJvW/gzw5lP/L9nZu1ucDNApK8HDgi2Z1p80ZL/wvod3AAH0I9scnuzDehbhshlhpZbc9kWZTgXENFBZlBV4b4Q+wx8YbfNFJEX8e2DAkE49imieNxdTtm/R0W+JWTomxz4mBgMNGexstmTi3Jv0rQqbP92Wipcx2DOURg+9N3YY3QYF0doUEfa4T3DjLNLJtj1tVpufE8Qm20c4aFxUgPg4qjlOr9I73RReQ1MwO8tOpSJHDhluVzbhOXk1+XSkO1frgfRsVh0jaUsCijpzf1vaNhoS0mv2M9RMKMmMv3vQvEl/VeI7e5dJi63g90JS4g+wpOEO7sHOpuAAN8yJBYM1Ow1iK+NciWaYKWkzTvGC/3504+tWaeVw40QgHBplcMm/8xoI/fW2qDKidDLm5bWxALY/KClcSszdRBkQta6psI/X242B3GnVPLfmN7ZNTThLiJa+qIlm9HhSjUiv6VW/jbZyjUUqJ/yIJoMA8h6hCZZtHeehnioXDoN0/dQJaqX7ihEvUk3gWZvbD5u84vpamXyHb2OwWEjOQpAwvUAik0dvEdVAzuTkZV9/BFC8L+MiyiTf6ellL1Bc6K6Db0AMw+lVKEC5cpZ0YMRhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e09de3-03c4-41f6-4b24-08dd462dcb33
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:05.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCNSsVB8gIuzRP30x3bw1IqTOdJPR71AJtfopTbv7XXd/tHTwltIjJQwpRuqla1imLdnAxMA5d3R9deTHKJrINc8YWkgOR5QFMWmpdRd+qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: XCFtxuEIt9fN_IkzMzeSqRG092HT2uHH
X-Proofpoint-ORIG-GUID: XCFtxuEIt9fN_IkzMzeSqRG092HT2uHH

From: Christoph Hellwig <hch@lst.de>

commit 82742f8c3f1a93787a05a00aca50c2a565231f84 upstream.

[backport: dependency of 6a18765b]

Currently only the new agcount is passed to xfs_initialize_perag, which
requires lookups of existing AGs to skip them and complicates error
handling.  Also pass the previous agcount so that the range that
xfs_initialize_perag operates on is exactly defined.  That way the
extra lookups can be avoided, and error handling can clean up the
exact range from the old count to the last added perag structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c   | 28 ++++++----------------------
 fs/xfs/libxfs/xfs_ag.h   |  5 +++--
 fs/xfs/xfs_fsops.c       | 18 ++++++++----------
 fs/xfs/xfs_log_recover.c |  5 +++--
 fs/xfs/xfs_mount.c       |  4 ++--
 5 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index 1531bd0ee359..b75928dc1866 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -360,27 +360,16 @@ xfs_free_unused_perag_range(
 int
 xfs_initialize_perag(
 	struct xfs_mount	*mp,
-	xfs_agnumber_t		agcount,
+	xfs_agnumber_t		old_agcount,
+	xfs_agnumber_t		new_agcount,
 	xfs_rfsblock_t		dblocks,
 	xfs_agnumber_t		*maxagi)
 {
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		index;
-	xfs_agnumber_t		first_initialised = NULLAGNUMBER;
 	int			error;
 
-	/*
-	 * Walk the current per-ag tree so we don't try to initialise AGs
-	 * that already exist (growfs case). Allocate and insert all the
-	 * AGs we don't find ready for initialisation.
-	 */
-	for (index = 0; index < agcount; index++) {
-		pag = xfs_perag_get(mp, index);
-		if (pag) {
-			xfs_perag_put(pag);
-			continue;
-		}
-
+	for (index = old_agcount; index < new_agcount; index++) {
 		pag = kmem_zalloc(sizeof(*pag), KM_MAYFAIL);
 		if (!pag) {
 			error = -ENOMEM;
@@ -425,21 +414,17 @@ xfs_initialize_perag(
 		/* Active ref owned by mount indicates AG is online. */
 		atomic_set(&pag->pag_active_ref, 1);
 
-		/* first new pag is fully initialized */
-		if (first_initialised == NULLAGNUMBER)
-			first_initialised = index;
-
 		/*
 		 * Pre-calculated geometry
 		 */
-		pag->block_count = __xfs_ag_block_count(mp, index, agcount,
+		pag->block_count = __xfs_ag_block_count(mp, index, new_agcount,
 				dblocks);
 		pag->min_block = XFS_AGFL_BLOCK(mp);
 		__xfs_agino_range(mp, pag->block_count, &pag->agino_min,
 				&pag->agino_max);
 	}
 
-	index = xfs_set_inode_alloc(mp, agcount);
+	index = xfs_set_inode_alloc(mp, new_agcount);
 
 	if (maxagi)
 		*maxagi = index;
@@ -455,8 +440,7 @@ xfs_initialize_perag(
 out_free_pag:
 	kmem_free(pag);
 out_unwind_new_pags:
-	/* unwind any prior newly initialized pags */
-	xfs_free_unused_perag_range(mp, first_initialised, agcount);
+	xfs_free_unused_perag_range(mp, old_agcount, index);
 	return error;
 }
 
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 40d7b6427afb..ebebb1242c2a 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -135,8 +135,9 @@ __XFS_AG_OPSTATE(agfl_needs_reset, AGFL_NEEDS_RESET)
 
 void xfs_free_unused_perag_range(struct xfs_mount *mp, xfs_agnumber_t agstart,
 			xfs_agnumber_t agend);
-int xfs_initialize_perag(struct xfs_mount *mp, xfs_agnumber_t agcount,
-			xfs_rfsblock_t dcount, xfs_agnumber_t *maxagi);
+int xfs_initialize_perag(struct xfs_mount *mp, xfs_agnumber_t old_agcount,
+		xfs_agnumber_t agcount, xfs_rfsblock_t dcount,
+		xfs_agnumber_t *maxagi);
 int xfs_initialize_perag_data(struct xfs_mount *mp, xfs_agnumber_t agno);
 void xfs_free_perag(struct xfs_mount *mp);
 
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index c3f0e3cae87e..a2c1eab5fa4a 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -87,6 +87,7 @@ xfs_growfs_data_private(
 	struct xfs_mount	*mp,		/* mount point for filesystem */
 	struct xfs_growfs_data	*in)		/* growfs data input struct */
 {
+	xfs_agnumber_t		oagcount = mp->m_sb.sb_agcount;
 	struct xfs_buf		*bp;
 	int			error;
 	xfs_agnumber_t		nagcount;
@@ -94,7 +95,6 @@ xfs_growfs_data_private(
 	xfs_rfsblock_t		nb, nb_div, nb_mod;
 	int64_t			delta;
 	bool			lastag_extended = false;
-	xfs_agnumber_t		oagcount;
 	struct xfs_trans	*tp;
 	struct aghdr_init_data	id = {};
 	struct xfs_perag	*last_pag;
@@ -138,16 +138,14 @@ xfs_growfs_data_private(
 	if (delta == 0)
 		return 0;
 
-	oagcount = mp->m_sb.sb_agcount;
-	/* allocate the new per-ag structures */
-	if (nagcount > oagcount) {
-		error = xfs_initialize_perag(mp, nagcount, nb, &nagimax);
-		if (error)
-			return error;
-	} else if (nagcount < oagcount) {
-		/* TODO: shrinking the entire AGs hasn't yet completed */
+	/* TODO: shrinking the entire AGs hasn't yet completed */
+	if (nagcount < oagcount)
 		return -EINVAL;
-	}
+
+	/* allocate the new per-ag structures */
+	error = xfs_initialize_perag(mp, oagcount, nagcount, nb, &nagimax);
+	if (error)
+		return error;
 
 	if (delta > 0)
 		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_growdata,
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 9ef5d0b1cfdb..79fdd4c91c44 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3317,6 +3317,7 @@ xlog_do_recover(
 	struct xfs_mount	*mp = log->l_mp;
 	struct xfs_buf		*bp = mp->m_sb_bp;
 	struct xfs_sb		*sbp = &mp->m_sb;
+	xfs_agnumber_t		orig_agcount = sbp->sb_agcount;
 	int			error;
 
 	trace_xfs_log_recover(log, head_blk, tail_blk);
@@ -3365,8 +3366,8 @@ xlog_do_recover(
 	/* re-initialise in-core superblock and geometry structures */
 	mp->m_features |= xfs_sb_version_to_features(sbp);
 	xfs_reinit_percpu_counters(mp);
-	error = xfs_initialize_perag(mp, sbp->sb_agcount, sbp->sb_dblocks,
-			&mp->m_maxagi);
+	error = xfs_initialize_perag(mp, orig_agcount, sbp->sb_agcount,
+			sbp->sb_dblocks, &mp->m_maxagi);
 	if (error) {
 		xfs_warn(mp, "Failed post-recovery per-ag init: %d", error);
 		return error;
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 0a0fd19573d8..747db90731e8 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -797,8 +797,8 @@ xfs_mountfs(
 	/*
 	 * Allocate and initialize the per-ag data.
 	 */
-	error = xfs_initialize_perag(mp, sbp->sb_agcount, mp->m_sb.sb_dblocks,
-			&mp->m_maxagi);
+	error = xfs_initialize_perag(mp, 0, sbp->sb_agcount,
+			mp->m_sb.sb_dblocks, &mp->m_maxagi);
 	if (error) {
 		xfs_warn(mp, "Failed per-ag init: %d", error);
 		goto out_free_dir;
-- 
2.39.3


