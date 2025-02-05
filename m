Return-Path: <stable+bounces-113976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06EA29BFD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC34169166
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A352215062;
	Wed,  5 Feb 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FpFx0qkD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SE2fgTIn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163E21504A;
	Wed,  5 Feb 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791657; cv=fail; b=J1xLtjKQFEPBpvl8ITQwiONvgWSp8GLNnYtX4VhPIntBj95gPxahVf0kBtO2CE30NQXyjbrUU4fPQelHRZ0zj4/mAzR4Oq9YrvTb3cvcIZ/9GlED5mBUsAhJEyRIDgF1fuwPXnCLXQsrfk1qCLYMWJwijgy4h3O9311zreuQVkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791657; c=relaxed/simple;
	bh=2naflg6vN9a+JPHs1ct1QyAM2rix2l8ABItv8Lz+KqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APWISuJUuyDjTWWv9UANnqtbRq96HQT1bzjJPuXpPeERbHHVAcox5d6/g7j9U+Tt0pv3M+ISRgKWTn2gUDHRUPBqlbTTGbdR7rjuiaA2aTnsXkA2gPTKZkVD13NsIhGfJaq2/fmejWN7WE21ApPJ3iekkITfsKtGTu66TJRk1yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FpFx0qkD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SE2fgTIn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gg1SV016288;
	Wed, 5 Feb 2025 21:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=951HZx2ifxyQK+6u1k4vbOPFC8AEWC20D4UaT/QTSEQ=; b=
	FpFx0qkDrLRj0XJPoYYN5SteVR3VDKCZvMgBGuAKi0YJJkqlejxBKKsXkOnMn4Qv
	2XvxX7WwkWbPAr/wIHot7838yqdN7dljpE7fA6F4v9cZ0FqS8T10aqe6UooJeTnq
	KMgw74aIhVn/oaGxPbnNrPNNPpuzXAVsqlRweJRXYJWS4y4vh38E13Rv/EQF9oss
	xDboEUpAy015QFPrctc9l/IxOHalmkGJ5iyrAXmZwFkisD6DByOtnNtFMRwm+3ya
	IIivqXBBEFLWGOrMmZcDSWa3gM3c8DlLSfsttVih5h9JJQFq9sQObf3XltoseLit
	jVSyrG2b2vtSjazu28DT3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u9f05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JoVU4020619;
	Wed, 5 Feb 2025 21:40:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fr07r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAy+UlFwYq6GVwQrDM7+ObPjIvHMVXTe5ElOkwNd5LFA/8yFOG4wA+m32Pg/3XBnWntBcavDjU0rUIc38iK0ukUF9+K4HUlMS/Lv40TCdhMUBMh/gN1XQxX4zIlb66AUErLCQqMTvay8eu5d5VAdmBivCG9fw0WyNhcKzj7EZlZJgCpB8paMTMT37KouMkjQhy4QjwUCWSil45igsI91P1bc2h46EKkw0Fsdc/wh7OCi+clrNK+83YFt/zF0hMPBv9Pc5vmMdazfUIQ91DaZ/VthjeJffjXrKQsnSxkT6GAg5lnXQs6xw8QHf1OeP8GqRLxI/TcTLermNd73Az+emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=951HZx2ifxyQK+6u1k4vbOPFC8AEWC20D4UaT/QTSEQ=;
 b=FXjaYB5c3HbKEVnKXRtmngv6zxdy93gx5yO/2Twi/S0I4L2wUh1vcjwkweiih6v6jQ+1Lc85sBfwytf2qxNsCR+DaycfjwiePCNzKsbJz+mm7YIhiUfdDwyPwnK+Gj5UNcHVKmqBA/pzo8+Q2TksXuz2HSjHY4b5sOjjl9IHVaIwRoazMgZu8uxP5CgymU48r20/i2sPjNmY6F9Vr3HQ7KEl3yfHCQl3atFmasRhHKjqCmURAjLTTyeQ4xB6vBaLkkG6xG+qlTdD1ehgKtt+Xo4WC55gnKtQK+h0s/TCbUIVZALjC8Fypj94ar4UEvLsYaY5sJ96EdDDAsRcPs8Qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=951HZx2ifxyQK+6u1k4vbOPFC8AEWC20D4UaT/QTSEQ=;
 b=SE2fgTIndVtKJJX4EdqmzLluxNBujv8b4CL/KYZwqoL1Ubw4Z7X6K8kfY+n8QpSIWEOOKDkYHo0RnBSAvJ1nzEKzt6rmDgGat7JILdT8P402uK/Wmyfo1su0Mu/VopPwfrmDO7vRtKBrXuCJq0FdgdQCKF9A6iwWCHcCwmv0t4M=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:51 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:51 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 10/24] xfs: distinguish extra split from real ENOSPC from xfs_attr_node_try_addname
Date: Wed,  5 Feb 2025 13:40:11 -0800
Message-Id: <20250205214025.72516-11-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f13425-3c1b-4647-fdd9-08dd462dc245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cg9UkbkQrEKJWI1P9QVY2ogcctgLLqAXoWqNhGvgijyPxv9JeDGaExyWOU6i?=
 =?us-ascii?Q?qFiZIiuj2yMPhdInJIcwYd2CU0TknV9vDClKhu1/xxIQ37PWhEhdu8CFGh4Q?=
 =?us-ascii?Q?jmXkgisCweF+UrpHxOF+Ls+zLCVJIOEJrUbO34DwGRG8RtUlYSOhfmn+3WgR?=
 =?us-ascii?Q?j25dmW/0ZLG5Gn/VUwyr+/hVlyrFxygpa+my4tTfCe00k97id7vfr85UrbrW?=
 =?us-ascii?Q?rTVlCYXDq97pZ+7IJwaXCwFLR/xD5ORGF0N6AP1WLLu6lJEHii6OjxaQ+P0T?=
 =?us-ascii?Q?NVPaBZ4PjbLLkCrKtMN0mfEsNo6wPaa+kHl9/bOi9zLqYb4Ou3nVmFKPX8F8?=
 =?us-ascii?Q?EF/pSS+RjMPzYhsLMZ2g8V3L9Sdn+9SxySacQl0s/J4BVg2+RFN5NypsSdWe?=
 =?us-ascii?Q?nvOfsBPL4UvKKngkPwnWsh+90rIAKbjnHARlTTUrNxPb9xXzOc/FTPGNb7dB?=
 =?us-ascii?Q?q0gMkhbWUyrh0YJKfEq+tUjSgvU87UyRfn520rhAACMqmG/qjjtxoN0KccuE?=
 =?us-ascii?Q?huL8wfqXYxaZV/kfECTjk2VEAYnGbG3+l+Khh2sFw6PMIwQjTOV3rQ2BNqiB?=
 =?us-ascii?Q?bp5EvpNZ1m2+X7qVZKl7hvsrWWdRNVl0qk4T6bzYX7i/xvCcuktYCJtBr6ji?=
 =?us-ascii?Q?OLJ5JC1WVOsP7JyIOOA582ugJLoLx4HaJraTPcXm4TTbW2bo89B5cfk8Pt6B?=
 =?us-ascii?Q?0VxaopHpo65x6+32NjOcngBjpLxvnwzO/lJigg3sIaFXh7pNgtlNR2pWyx13?=
 =?us-ascii?Q?MYnBNen+Akd8s9sIwc50KoIDfvpjME/paotnEWXOgPC6T99245dKjRAHTr63?=
 =?us-ascii?Q?0//R7nr1KpVNF5yuBjp9Fm4Z8kjVTjvLw43pn3T+xOOMKLyrzxXsnGXojPx0?=
 =?us-ascii?Q?LlyQIP8lcocMVP1lBBXXsXzgpURP+Pj/tQ3neaHK/Tg9X8fWZ85i1x+4nKlX?=
 =?us-ascii?Q?bXx+t8voUOyb/nP1INzuW5p4t0wDFVkYFq/uqung8iHNxFj8JRgq41C3Mcfh?=
 =?us-ascii?Q?qbRnj0aH1P43Qonwsqbrim/jGrgcd/L7QwipNHeoks1pRMiUr7ZKrdoWtX8x?=
 =?us-ascii?Q?EWlnBhYoExDm84jgGOC9kdlMUG9GPFaQYy0Lb4P2oTXzYtXs2kKme8s4M4L6?=
 =?us-ascii?Q?pf2YKn1KhlVxp5fkcvwZ/TVs/W/PspB7O09o1+RmToofjwhX4BTGYjlzMoWw?=
 =?us-ascii?Q?X+qXxFAiYvAay2hgmrDmkAxq+bwy2AFeCdX8PWQerdp9otnhe1F5mgB/DLuY?=
 =?us-ascii?Q?pTeibvUu5CYPHKYBJ5E8yJX8lMW71pAUEOBvzEMWjdx5XaPcGY74l6Wvee+l?=
 =?us-ascii?Q?rs8WqPO9z8e8a/NAHm2H55hvoJjZhv3EKFu2pKLMZViijME1x2nF7MGR3pc+?=
 =?us-ascii?Q?dc4aSxmsNo5l43YUovs8YsLfHaFF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YB+RifsULMozADlT6H1t73hSLfioLtv5H6OkNiriUWRNWLEtHo7LK/FnYcYP?=
 =?us-ascii?Q?xHGCk9VNhk34OHYZfHXmXJ5bVixG1ozBwYvTYeLgek0ZWNKNhc3VBBxkKE0S?=
 =?us-ascii?Q?e3v3GTlIqR2kOzvjWt0j3XjU+BA/GObHLHuRwj8G0xYAx89aEYbvfzFG2Dqt?=
 =?us-ascii?Q?lK526Z8qWzlC/aRmYYBuP2G1XHA7vG4Y91Vo3LrYOBy73WlTuF+o0c8UWdbS?=
 =?us-ascii?Q?hsfyCSAF6Fduh60agu6MR9nsiLbhbSJFdcSWALXPS3yRW6bjeC8oeBI492Yi?=
 =?us-ascii?Q?DA7j9kypiiKhvvablkwPxHIxhr8VKnRPWpcvmBDXmpmU/DNhqWv5zka2in33?=
 =?us-ascii?Q?rj+FcJCXfe2VmPEIjvm5VaZkOKZy69dHNwbEYHh0mfG5tjdSOf6Rqcftgtta?=
 =?us-ascii?Q?ZMOHT289NFWXFYJhrmi3GGq24ZDhSw5tDuHVOgGINS8uZnPhhNdQyI6rCaX6?=
 =?us-ascii?Q?IzZtuM0O6loyCPRygIJYqZj0CQbIXKO0nj9MCIHBrNBOZ1FAB0EbDeWioZaH?=
 =?us-ascii?Q?Abq92geNLgTtCZaFKKPc3tt9Gg4hQou6yLqxj+wFsKQ1e1A7aF0a3Cask8bZ?=
 =?us-ascii?Q?DAj+K1iPorF1aRuQ+wjSG3RfDvaaOWb+jPLrS+F/KuwbvvCnGwif3UnnsvBc?=
 =?us-ascii?Q?HPjToHA+y1WgeQ2bVZGGdPKpnnC6UjoNtSh93tNnnMRypFJf+znN5sByrHcO?=
 =?us-ascii?Q?VkrmoqdtOwldWzAxJgwOZFNkL5S6TXadBSUdUmRrzFHcgQVgu6CttYCl3yZk?=
 =?us-ascii?Q?ywv2V/SxGAHdXyljLZQGHdNBF2y8mc+7lUNN+R/JqklG9vC9Se96azWP2w44?=
 =?us-ascii?Q?H52TY6fKI9mujcRmubsTngbN7YDw1b+xoOK1PkVKdlnvRfo963yURhRKR6AK?=
 =?us-ascii?Q?rY8Pc2/7SOHLGarvo8F4wGi5DzEDlygxN5OofVvv3/Bhjo7eU8G/w75pNu6p?=
 =?us-ascii?Q?b47lI3UceQmA3jEzwltJUr1sR+z1FpsrZ2tfwa1edAfFvXV9ISAP1XYdvyie?=
 =?us-ascii?Q?GtXpdoBruHLg/DnhjzhF2gZlYtID1cyxvhFvyMMFsa7OrbQTeFvIvFfI+QVT?=
 =?us-ascii?Q?0TA5f4xnT3o3jEmEAOh6o6qblM+9L6LpPLSdFDvCGaapo4kOoALa4Y1T+208?=
 =?us-ascii?Q?7hm9a1So3lgwwGuQgf2UPfF/EPClIK/HRn1WBGSYNd4JyVaoEf1seAoVnriT?=
 =?us-ascii?Q?RlIDgqvRcDkMSxNkQBsL9zkOYC/HZ58ZpfLYMUSc3zDr1z6VDo30mMqlE3sw?=
 =?us-ascii?Q?jGh/+gu1Z3PMMJ9eusVdMjHXntLJh5pt+ZvDM5tSPEfc4UJ76fvgvtjzacoM?=
 =?us-ascii?Q?IT5xpcuUVMcUiF8+61opQGQj4yHgcAofPdFU+pczxnz747nDetCcHMGGqc08?=
 =?us-ascii?Q?SwDRnpHrwwVqW7WacIB53IXo9a0n4jsWKZwwyNjTtLzwFKNc08EMKWT3L2T6?=
 =?us-ascii?Q?7C3lbFIP+l3wZv4IaClWMhEle0A2LdEAqMxzUGGt4Fn/jU6xyJnBEqWHbXrX?=
 =?us-ascii?Q?7yy0Z2OwB0797U6PgpUr0M/mDBs1csNeAxtDM9GaLtV8uoBtkkMhCpSGspFY?=
 =?us-ascii?Q?GDJkaU0f38Jzks6EMulcZDZwwvVTIHGtktGH+zZMC4gAc739GjxQn40Qn1Uo?=
 =?us-ascii?Q?qiiRgYWAfFFiA564PpwPMGa0TDpkWnHPaaxXw5ZxACtGa+6eNsbJqytBq/uk?=
 =?us-ascii?Q?d6cqBQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wKQHBfhcqenWlS1jVKdY9ooSRsNCA8r5HFaeHHhLTluMlgKFmR0Zwf7NsNTQtKhVPVuAnemItUDF/rLGQEpjMHtrgYI36ZvDddqsw86RwDxislKOSBmni1zyVw9bTvzPjEov+zHN+hJMyQUJ5lrVurIPa9l2zuWfkoL9bA1o275P513qaygxx1GumPjG5RmMEyZ9l4kdyNCrOng0Yjb3JxXwBTJKc8tPBUM3PXFcrfBCEpcJj+Z6xepQEviBXzjxeR9/u+KBodIx9f04BxL5b6lBi+N/dLYPW4UUQA4+aepAOk+7v84SdHvkWXEXXmmb12XinDwPLpwecS9yF7P7C/ZDaZUhWlzxPfk6NOQ2TB5rsxdxwdv3IZRo4Y4TddCWo1yB/oqNaG1GqiyCAXBXPdfaaNBRnzQO4IqajMu6b8Toy6+8nELviiFGs707q3yU19gDO5o/vsvlII3bfdL7KsOzwVoNQLgr4yRQcMiaGdx4jiSyN6YHhZvgv+uUNEf3BQGOwQNbfwiJMv4kLwu+Ydpw3wC/xQz8drI1W9+JJK6dFzO0X/xfRS4tmW27Vr2W94XXKyaIVBOhvfqEapkuimxuNZHU4PzrqNWbXHiiuu4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f13425-3c1b-4647-fdd9-08dd462dc245
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:50.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeVle22wegdD0bK7IWUnPv+NPoiXgYPqyhfPK0O3OebSkRX+yryapaFOAo6YkouJiEkhK1Wik0eivYTicLDzaEE/TIwgU+/DtKbjPYnUqZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: DtydLYfRMEDhNwtpi1zISYy9kb1-ohcB
X-Proofpoint-ORIG-GUID: DtydLYfRMEDhNwtpi1zISYy9kb1-ohcB

From: Christoph Hellwig <hch@lst.de>

commit b3f4e84e2f438a119b7ca8684a25452b3e57c0f0 upstream.

Just like xfs_attr3_leaf_split, xfs_attr_node_try_addname can return
-ENOSPC both for an actual failure to allocate a disk block, but also
to signal the caller to convert the format of the attr fork.  Use magic
1 to ask for the conversion here as well.

Note that unlike the similar issue in xfs_attr3_leaf_split, this one was
only found by code review.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 1834ba1369c4..50172bb8026f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -543,7 +543,7 @@ xfs_attr_node_addname(
 		return error;
 
 	error = xfs_attr_node_try_addname(attr);
-	if (error == -ENOSPC) {
+	if (error == 1) {
 		error = xfs_attr3_leaf_to_node(args);
 		if (error)
 			return error;
@@ -1380,9 +1380,12 @@ xfs_attr_node_addname_find_attr(
 /*
  * Add a name to a Btree-format attribute list.
  *
- * This will involve walking down the Btree, and may involve splitting
- * leaf nodes and even splitting intermediate nodes up to and including
- * the root node (a special case of an intermediate node).
+ * This will involve walking down the Btree, and may involve splitting leaf
+ * nodes and even splitting intermediate nodes up to and including the root
+ * node (a special case of an intermediate node).
+ *
+ * If the tree was still in single leaf format and needs to converted to
+ * real node format return 1 and let the caller handle that.
  */
 static int
 xfs_attr_node_try_addname(
@@ -1404,7 +1407,7 @@ xfs_attr_node_try_addname(
 			 * out-of-line values so it looked like it *might*
 			 * have been a b-tree. Let the caller deal with this.
 			 */
-			error = -ENOSPC;
+			error = 1;
 			goto out;
 		}
 
-- 
2.39.3


