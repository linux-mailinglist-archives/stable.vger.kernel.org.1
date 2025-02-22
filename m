Return-Path: <stable+bounces-118672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6DA409D7
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0088517D08C
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491813C81B;
	Sat, 22 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GGw9u6sx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FgI+yBOC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA611CAF;
	Sat, 22 Feb 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241223; cv=fail; b=JljqjBJZTiE0XSDyWeZ2if/Pu6yJKyC7aIo7kTgOQczSK2rWI2DbfYhKiT6m9BfapKwBuYPoKl8eEKow+JF1PzaRwKsNfKPrUrRYompLFmqce3wZe9aNxZVn1jq9fGA7RTnjzACBSEVsCuwxUvC74e2Id9h9usjozW7J0qmI0QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241223; c=relaxed/simple;
	bh=GMvJKAl0Nb0PiCUr3dLFGCBKK72SC+WNTBA/aLoM6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kvHXkQBWYIJiPq1zD7hu9rT27kHE32bFvy1j0xGMHoMPeLfLOXu2f+ACosLZ05px1VJSl8HbnslL4jx+1PFKNcLhGpmoFWZx8oLxeSu5FzmYnvjliwh+GLKfsmZ5JBw/ULK4i5CFr5drTvgK4Tz5+ueQEIbcqsizD10op1/75vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GGw9u6sx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FgI+yBOC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MF01tI012495;
	Sat, 22 Feb 2025 16:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=7Gt5eSG22Xb+Arv8
	Rt+7/DyyZ/M5IjGmN4eQmN1A6pE=; b=GGw9u6sx3uPBJEOwHDW7Ov/ECODUD0Fo
	WmPYRsQcgYwnkaw5EaWOhtW4+nlw0sttOrzMDW+tO++av60l/YUj4+W1vo+cptn4
	vaZMXvtAmSGn5iWnjcO8DQBGpvzvLK4jtzijWzjZtyT4O/UKvCfk/kTzdS2TxSOw
	2+mGAr7A0jhV4HCKqpJqHj18VUYb9uckU3b54EMJcegaTRSBa9RYSMw4BdkCof80
	PuxEf1MFDy/E2nJUI0PkkDGMlYWXNSJ/zEWk2OKpS/xZ8+7wB3Mv0sOWwKcq6MDh
	5EnMz63b0y1NEcn6+Rl4nncu07MZvF3NQSUx7ysIc1FQzR0PNAsN2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t0c50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 16:20:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51MFCxCs008160;
	Sat, 22 Feb 2025 16:20:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c5tj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 16:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFSa4Oij58PFqU6aVbBvMqF9lodwOhF7uZiVreFxzWYrzK9V8TmbIXEt3AegFXt/I1DG8OIKq+qbZu0Ph8c3x+vQzD4zEOtwhd5wv+IbeT0ED64p5zKdS/96evwUkUI39SMZ1CqbXnzAKusvAz0Lht8W9kh4kg0/T55Sgwv/BYq37XAgq6Z31jUOuOabdDdjb+sNTrm2OJHDq/gmQJy+EBjtwrtX4uDPxs3qLToVb2FMDya2DaeUXUxzLL/nbRhCB11FQWsv8thaJCBAs+WUpl8Un1UJxRtRlWIE0H9F7EDd1fRNRSZ2EaMgqZo8Yde78ZQt5reHeBQKXtqLUa096A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gt5eSG22Xb+Arv8Rt+7/DyyZ/M5IjGmN4eQmN1A6pE=;
 b=KWsXlxFsfpvPgfloZMHOZ587CZPs3YIc2zj2QNnnTBsXvcpc43gkGd031k2mqHRWRf6NqP7ueYsNPGp082I14scKPCRvV7qSt/P/F512ROeasy3vf94lZDbIrQqhATtJ/fwbtpMq3tSrgqurpQadtOPuY8cGaBmUusPPGFZ7z/07dby+GtuaQ4lWgeV306eWQe2OT4EmNwCvvFkIktlQEumfbC5eBMJUy72XeyPDP6ioshiTCdN4KOMNlZq/Zylw74+FTXHF33SqRMPwVcN0YmMz/xHIVG6wsVBhQS/OttY6Xqqe1/HukQXaHqd/Ga/dfo+t4ftLZ4E+N18gafHLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gt5eSG22Xb+Arv8Rt+7/DyyZ/M5IjGmN4eQmN1A6pE=;
 b=FgI+yBOCIttcXZgqEQWyvxdwtxZ678CjHqFMdp8zhf76zDGJfj4xhCOj8U1acJmdys453q2FA+4bN1q6K0bIQAzN5GHpMPSlj3YIwqqbCtFNTXZTozK0dFxmajbxF+KEJgpGz3b0f0JOBVGFfd6ymoyqnEtdrXZQuFcwqcTbnj4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 16:20:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 16:20:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Brad Spengler <brad.spengler@opensrcsec.com>
Subject: [PATCH] mm: abort vma_modify() on merge out of memory failure
Date: Sat, 22 Feb 2025 16:19:52 +0000
Message-ID: <20250222161952.41957-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0315.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BY5PR10MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 055d44b3-ed27-49c3-4193-08dd535cc1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vxy3lXs3z5y3k0hYJWirOxGed0/0/lHoYiJOGarhNBBtGEjy8UuPOnGJjbAo?=
 =?us-ascii?Q?kZ2V8qME0CfuY3yo4YhkYPIp90fK95vnVIUiLunUBuM6+il08VZr5ObkQhs1?=
 =?us-ascii?Q?QtdLVdLr1khzaxXr/KCvuoz41yyJUhMpKoUy0E1xfNDn24jP0ag3Vs/ISt1i?=
 =?us-ascii?Q?/TjeqHMPSVTKO5Ixdu+tsOUm7G2/0Em6cUy+/z+OKZDI2tZOyxzY0vIpIQYG?=
 =?us-ascii?Q?7hLST/bEuDwa668//IqkjHl7Z9NxpM8jtMBFsq9f46hHA9qNEyZHx8Gaq+lf?=
 =?us-ascii?Q?WTJ2O1VBsiFU7KjVajGxp94/wo/4kZmbvsg9deiTskNgj4n1CM8HbtNbJH3F?=
 =?us-ascii?Q?r2R6PrNrPMrsARBHX8uc3NW+jdCx4sSiVqqhjW9Syk+hUqdSgqWm/Asv9lQu?=
 =?us-ascii?Q?t+aowIETI2pgbQla/Yn804AbfnKezYgWNsgdzB548oamGYTBfuZIExciSBpu?=
 =?us-ascii?Q?EZi89UbnCUNFQydgeVaGMfW+TEozEZIcpJy6U5lUbQafzrC9cjIqN3mbIh9F?=
 =?us-ascii?Q?5HCPD3bTHo652SqqV5O32iOJBCHxJiooFX7EsvabUSs30cXssEMOk6w+jFs3?=
 =?us-ascii?Q?g1cjNKeuAxPA6s5tiAHP7t0Nn/k/is/cDsvnP+zJuaUSw6heCIVOoTD/LqJG?=
 =?us-ascii?Q?A+xAJCuzaytoYVXLxgeHauGKJ+6UW5woiOPVBge9302usdDMZV8hjkQXwn1v?=
 =?us-ascii?Q?OJIW1ANEFLKMF12TZf1aLfJbeQ1MJTk2+Mp7MQgRFMxO1yUs9UwUqzjSiu8w?=
 =?us-ascii?Q?Hu6Rs8NEil77HOpXi47/zpO2S4gY/RrAYE3rV+Mc9WFEz6CaUaK3oeSdOthQ?=
 =?us-ascii?Q?ljYZN7QMNGcBtuml7JaOoRTG1yRKhUafTL+nUsIQQB6U+cIDrmoAN49BdZzy?=
 =?us-ascii?Q?MgehAxWYGuUnqsh9xpBGEqP+tkCQsIWM1F3iRtqVWWxPPCb3kEWTK14O6XUa?=
 =?us-ascii?Q?EBxkz2KsiKZFDkzGSje8jPpToyFXdJz2MTL5PY9mfXsko14pA+7LoLm7Mqr8?=
 =?us-ascii?Q?0bVGaqXnlPUL+DsPDEx9e1QiimD0XOwARXIBZ8cxJanKBW3yqiE0qhCvDy+W?=
 =?us-ascii?Q?N8FUpzYCF9X+NH2LoeBjqz9z2Xmmq+QJoZ39meBej/ZasmcXt1t25vj9Wpco?=
 =?us-ascii?Q?tlPQmn6AkZ2qGjoqfSmLbBt7sQlIkhBNa1KJZ2xmRXI+GQaPj9O0r3D8Su0j?=
 =?us-ascii?Q?DaYZ2e16wajttu8oFwsB/zuHZtuGtsU6EGjLP5YAodINLlrhFZdMQJrtp7bP?=
 =?us-ascii?Q?IZna6vg1eOrGaEy1GK0sqyQUJxtRfsriuy2CRPEL7gH+jmk2yE0NxVoDlfjp?=
 =?us-ascii?Q?VRBMPC++jedI7jFX4xvlbmulyd4OYEUuoqEkpwWSW/O45P+F+a1U47tyI5Gb?=
 =?us-ascii?Q?vnqAaPLnJD+zxusRL/cRBDoRv+17?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puvMpe7tWyxVqXu9jmbrqK/qSKAOef+9B2tlCqLike1QJ0pNJyJJ5xhae4Vc?=
 =?us-ascii?Q?oAKAigrEON7JWqBh3jbSWNscCTHBPlWlFMV58T5M9RpmmePAkcgzl+5KObPD?=
 =?us-ascii?Q?PVUczeCMgc8sljnKHNLuM0JMDnuu61QH/bX3K47w82okYid0ztrBJsg69f/0?=
 =?us-ascii?Q?5eI2LBePFaCYplFXoaAGZV4xA3MThuzgEIwvQTbV7Qzs7misN1uiuebQk6mb?=
 =?us-ascii?Q?9xpyxq6h2QIs89ta/jEus+wE/Wd23Ooaq2h7rQynMsVzi+2ztUuGvzqjvvJK?=
 =?us-ascii?Q?BH9blO7GPicUV8NEreQvmUK7V6uVLSwlpQOEqTVfSKUZqqk/Ow6LOudMnNkf?=
 =?us-ascii?Q?9R8cUo8NMPa99tYWB3OonRNbJndomXEPpxA6U1/TrDpnCUb70FLom9Dk01Q2?=
 =?us-ascii?Q?8sebEMmkF72jnVx/ISDXQuWNp+W/aKtZavqIOhaC0EStwS208+k/Hje3/1Xm?=
 =?us-ascii?Q?fY5yGpFb0iee3wJPp0GzSNvrgncRS+B/3BXwY5QNYyjyZWnq9Y1wkcOcSYpA?=
 =?us-ascii?Q?MjYVB5aK1C5V4afB7dwXVQb3g0WUaqbWsZWGK4vpHRldaraq+DMOW+mp/1TT?=
 =?us-ascii?Q?F1wmUHuJ5sF2V11Zwu0KRCxfAX4eIaDEoYJSHGOHFFJ1M+f2N8kzZEvVBYTv?=
 =?us-ascii?Q?Esef0rSufljqnfxjFHUPzjgAUdV+6ow/54Ql++QtaZYRRjIc5d9qgazSu5qt?=
 =?us-ascii?Q?XhH2SX5Ne5mY+hCKPXyHICNnGQAihDobukJpxxA54e6s1wnSBKTNYk/nfW6O?=
 =?us-ascii?Q?nk+xKbDcuxZucXOBoBLZwuOANWV37lxhx7FPVG0gZ1YCTq8cKlx7jk5mpUOe?=
 =?us-ascii?Q?pZ2ab3iQTCiKZKNJZl4Fwf9YK+qVX8+8QbtE08kavvM66smB04K3q1wUhc5O?=
 =?us-ascii?Q?alxlppEoKSPb/8/IjbiNOmmIFJ7PT7dXpgITvfoG8odYxXU6VNM1HBsamXlm?=
 =?us-ascii?Q?QA7YSQDkRSmLBB1bG3zlMvfwkIQ9z578Z90xzucE8QF+cvWWJZpAMbRuri/H?=
 =?us-ascii?Q?qDJ0agC1F4MX4KGGy8SAB/ZqGd9R+ipZHFLF9C8zPn4tO3cgkBTvMKNNCoe1?=
 =?us-ascii?Q?Qi6EIKuuJRDw0c2ffB9uJTPLqn3a29vc1dG/hOmtRW7wlcMBYocLF+v8PT2B?=
 =?us-ascii?Q?F5MkRjZCjQdk2DauLv8vFczwuCRmiBgwfIaPkIVhkR/w/G479qW6BFdsekLU?=
 =?us-ascii?Q?z/c8Fw5jEpXCcEtt7adytnHt5dtouyR8h0uujBNQgcAPjwQwj/vEY897s4PH?=
 =?us-ascii?Q?IE7Fdw6EXavscJp+4fQ2Pl/Ala+Jwmlbf76jukYlMhjW4LGKidrqLi8C5FoW?=
 =?us-ascii?Q?kB4LJs5e/quPzmeTho+10jczwl89YoKwTAcacwxkiqCE+UuXkA45fF45CENZ?=
 =?us-ascii?Q?TLUJm5NnAlPZYAj5O5MuCJ8vIugx7OYE9LJ02T5o+sIWbl1phVFZEYxFIzkD?=
 =?us-ascii?Q?oDpDYbCM3HKZZ7t1QEYvyuiNvk9/HBKykK3/jAq8ZBFHiaKghshzX/Kyvmp6?=
 =?us-ascii?Q?qMVaZM24mn378eLYXshIHvCS7tQ+gMCH/BQG1qOXrB0rhFUk0VNIp3ITJakC?=
 =?us-ascii?Q?729PRPPhdCkQBEskmpQMIxtuDpKuXkaEVJqSD7CLgP35nzrsjjH1tHUiZAay?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9aff0LRsb5FYM1+DGEKpFkV3wrLzouPPv4CScybrljYn//CtCjb8/nzhTw+tTK2pnheO/S3rPYdtBFPB/D4duKkibdfvASLj+4hpBHGSzAhPTFLqOmj56Udxv77okp5jQvOTDJPipfgmbRWNoGk8chHyhMEqigyPbwrk0qKYOGIe3IjzdryXU97WqqyIA32WckrFY9Zp7SKABi+fZFEISz5yhgOkLVRJnOdMOs4TLf/lA8b2IdMjUlFvjldGKXawVtUIGWMiFuFvdTFj026yiGiDPrsPYkoj6e5+5xzTGLYAtCUPL36uz0wxo4wRTJ7YMqtEQb/Zn0/nRN2uAiRh0h9eHYp0H1/eXUcsnRegcbuModmvBAml8o4UX/4t62KOuAOBWEuU7vY7ehn+rlu57SFChtZwohrJC0QC6GHjahrWusEj79vUtsLF2O8EnFnDmxLRIPWRSXEJQz/O3Cznyi5qxrDUtOx6Az1mfIx2iai5k21u1xI/0AvWI9gn8By7JMH2BwDc8tVAW+g7Bhf02xU7g7zL45lz1d//2fKJPL9SUuvcFbOoHF4/hgx7ZSilDbcAlyHAdu0PzSAe0gViXccOf/tF8adXCFyk8nvCg58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d44b3-ed27-49c3-4193-08dd535cc1c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 16:20:01.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOWaLhoTSa5cyGmljfyjCRstm/QuVDhqaToxd44EwUFpLO8T6pRTZvBawcEO9KvbZ76KovsQD9Pi+KNtCO9SDNStix8AMHts6/7/IMoJ5/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502220130
X-Proofpoint-GUID: XVWnFJCT3fzkr89H4MF3Mrv-ZQlYtDHN
X-Proofpoint-ORIG-GUID: XVWnFJCT3fzkr89H4MF3Mrv-ZQlYtDHN

The remainder of vma_modify() relies upon the vmg state remaining pristine
after a merge attempt.

Usually this is the case, however in the one edge case scenario of a merge
attempt failing not due to the specified range being unmergeable, but
rather due to an out of memory error arising when attempting to commit the
merge, this assumption becomes untrue.

This results in vmg->start, end being modified, and thus the proceeding
attempts to split the VMA will be done with invalid start/end values.

Thankfully, it is likely practically impossible for us to hit this in
reality, as it would require a maple tree node pre-allocation failure that
would likely never happen due to it being 'too small to fail', i.e. the
kernel would simply keep retrying reclaim until it succeeded.

However, this scenario remains theoretically possible, and what we are
doing here is wrong so we must correct it.

The safest option is, when this scenario occurs, to simply give up the
operation. If we cannot allocate memory to merge, then we cannot allocate
memory to split either (perhaps moreso!).

Any scenario where this would be happening would be under very
extreme (likely fatal) memory pressure, so it's best we give up early.

So there is no doubt it is appropriate to simply bail out in this scenario.

However, in general we must if at all possible never assume VMG state is
stable after a merge attempt, since merge operations update VMG fields. As
a result, additionally also make this clear by storing start, end in local
variables.

The issue was reported originally by syzkaller, and by Brad Spengler (via
an off-list discussion), and in both instances it manifested as a
triggering of the assert:

	VM_WARN_ON_VMG(start >= end, vmg);

In vma_merge_existing_range().

It seems at least one scenario in which this is occurring is one in which
the merge being attempted is due to an madvise() across multiple VMAs which
looks like this:

        start     end
          |<------>|
     |----------|------|
     |   vma    | next |
     |----------|------|

When madvise_walk_vmas() is invoked, we first find vma in the
above (determining prev to be equal to vma as we are offset into vma), and
then enter the loop.

We determine the end of vma that forms part of the range we are
madvise()'ing by setting 'tmp' to this value:

		/* Here vma->vm_start <= start < (end|vma->vm_end) */
		tmp = vma->vm_end;

We then invoke the madvise() operation via visit(), letting prev get
updated to point to vma as part of the operation:

		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
		error = visit(vma, &prev, start, tmp, arg);

Where the visit() function pointer in this instance is
madvise_vma_behavior().

As observed in syzkaller reports, it is ultimately madvise_update_vma()
that is invoked, calling vma_modify_flags_name() and vma_modify() in turn.

Then, in vma_modify(), we attempt the merge:

	merged = vma_merge_existing_range(vmg);
	if (merged)
		return merged;

We invoke this with vmg->start, end set to start, tmp as such:

        start  tmp
          |<--->|
     |----------|------|
     |   vma    | next |
     |----------|------|

We find ourselves in the merge right scenario, but the one in which we
cannot remove the middle (we are offset into vma).

Here we have a special case where vmg->start, end get set to perhaps
unintuitive values - we intended to shrink the middle VMA and expand the
next.

This means vmg->start, end are set to... vma->vm_start, start.

Now the commit_merge() fails, and vmg->start, end are left like this. This
means we return to the rest of vma_modify() with vmg->start, end (here
denoted as start', end') set as:

  start' end'
     |<-->|
     |----------|------|
     |   vma    | next |
     |----------|------|

So we now erroneously try to split accordingly. This is where the
unfortunate stuff begins.

We start with:

	/* Split any preceding portion of the VMA. */
	if (vma->vm_start < vmg->start) {
		...
	}

This doesn't trigger as we are no longer offset into vma at the start.

But then we invoke:

	/* Split any trailing portion of the VMA. */
	if (vma->vm_end > vmg->end) {
		...
	}

Which does get invoked. This leaves us with:

  start' end'
     |<-->|
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|

We then return ultimately to madvise_walk_vmas(). Here 'new' is unknown,
and putting back the values known in this function we are faced with:

        start tmp end
          |     |  |
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|
      prev

Then:

		start = tmp;

So:

             start end
                |  |
     |----|-----|------|
     | vma| new | next |
     |----|-----|------|
      prev

The following code does not cause anything to happen:

		if (prev && start < prev->vm_end)
			start = prev->vm_end;
		if (start >= end)
			break;

And then we invoke:

		if (prev)
			vma = find_vma(mm, prev->vm_end);

Which is where a problem occurs - we don't know about 'new' so we
essentially look for the vma after prev, which is new, whereas we actually
intended to discover next!

So we end up with:

             start end
                |  |
     |----|-----|------|
     |prev| vma | next |
     |----|-----|------|

And we have successfully bypassed all of the checks madvise_walk_vmas() has
to ensure early exit should we end up moving out of range.

We loop around, and hit:

		/* Here vma->vm_start <= start < (end|vma->vm_end) */
		tmp = vma->vm_end;

Oh dear. Now we have:

              tmp
             start end
                |  |
     |----|-----|------|
     |prev| vma | next |
     |----|-----|------|

We then invoke:

		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
		error = visit(vma, &prev, start, tmp, arg);

Where start == tmp. That is, a zero range. This is not good.

We invoke visit() which is madvise_vma_behavior() which does not check
the range (for good reason, it assumes all checks have been done before it
was called), which in turn finally calls madvise_update_vma().

The madvise_update_vma() function calls vma_modify_flags_name() in turn,
which ultimately invokes vma_modify() with... start == end.

vma_modify() calls vma_merge_existing_range() and finally we hit:

	VM_WARN_ON_VMG(start >= end, vmg);

Which triggers, as start == end.

While it might be useful to add some CONFIG_DEBUG_VM asserts in these
instances to catch this kind of error, since we have just eliminated any
possibility of that happening, we will add such asserts separately as to
reduce churn and aid backporting.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Brad Spengler <brad.spengler@opensrcsec.com>
Fixes: 2f1c6611b0a8 ("mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()")
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Reported-by: syzbot+46423ed8fa1f1148c6e4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/6774c98f.050a0220.25abdd.0991.GAE@google.com/
Cc: stable@vger.kernel.org
---
 mm/vma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index c7abef5177cc..76bec07e30b7 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1523,24 +1523,28 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->middle;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
 	struct vm_area_struct *merged;

 	/* First, try to merge. */
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_nomem(vmg))
+		return ERR_PTR(-ENOMEM);

 	/* Split any preceding portion of the VMA. */
-	if (vma->vm_start < vmg->start) {
-		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
+	if (vma->vm_start < start) {
+		int err = split_vma(vmg->vmi, vma, start, 1);

 		if (err)
 			return ERR_PTR(err);
 	}

 	/* Split any trailing portion of the VMA. */
-	if (vma->vm_end > vmg->end) {
-		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
+	if (vma->vm_end > end) {
+		int err = split_vma(vmg->vmi, vma, end, 0);

 		if (err)
 			return ERR_PTR(err);
--
2.48.1

