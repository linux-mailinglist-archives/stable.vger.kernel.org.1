Return-Path: <stable+bounces-211299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCr/Iwd0cmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:01:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449D6CD79
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 20:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A227130062DE
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB7326D70;
	Thu, 22 Jan 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noGQtPRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i0aH0S9W"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42136605E
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108478; cv=fail; b=OtPZoy7Pj5ngRhuwTwQneRrSibTZotTvltEuHqR/C9ga495BuZZ9AjqMuP43dJ6wXTaEZXtesUidUnSxers87kYD+cXkHy22h3d3tlXeFHePHiVztWRLksPitJG5mYDIc+NVQEol9iaya7IpH36DPTjqUW+typPwgCo1Lbtn9Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108478; c=relaxed/simple;
	bh=VM3bksSJEzdRb+ez2Bqz9aHbqbsRSQIGwsAdRjZLh8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFNl4H/a+Ei6eWnqy8UJ8hE0+H4AGsY1GDWHrNQ/ybkqj73GTZT/Fa9isPwXmTbqCzmpTlD+pyEqYGZaRcFzSdawLuDvTG2IRj1sSfIYrtkIrYI4BBsXrsdK3x13ofH26jNvWg9JiBSOCA4is1cTd5IWGIrAFeeJV67AlqDgsMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noGQtPRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i0aH0S9W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgIRs197742
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UTs1g/uq0uHdA/6TS4iioqslvG1ErSdpR+Ss4j4LY2Q=; b=
	noGQtPRlAuKnsnZpGIWaRlyRPd8NIpHwDPkSxANEwxQ0kIeMNR5VZxK3uk39s3F7
	O5adi2/srGtFkk8+/0E41j98G1MLfAch1Hevq/ZVL5ROyYOqhG1wr35WQbWbGMxL
	UpsHo3tbFg69fbSfSvYpgZgb6WMJb6JpRjeGO432jNxilDh3aIyp6xqNUP+5SIAF
	N59vL9lzZTkJPwcF+p63RgqS5MyavBscwiqnh+e2xJbTOezS36JHjfBMfYuh6wxz
	wn25MasgZYk82aFkMmKM1/ZG8cLLCNGj8zaNqwvzj8ksZHVlknoeqNycbq5OWYQ5
	qLtuba724lK2i2k0oqJRjw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yq076u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:01:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MHqT20037842
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:00:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vd9fh8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0H7sQ/bm6x2CH11t3emmD/85evCCfltPFns0bLFYWtJIHqQav3/bz01MsJOgoPSKeYpfiF2umZTC+osGGIxWyKBkn1zY3UrTZWb3zpgv/l9agM2vOd7HCqkWw1HUNolrYxDWXLfQcDRfln3pUAw2KTb5enHcjXkX22+Y5EbR1ePPcsv6L0q8A2A6MA/JOnjcrKTmTXINBOrhXpLrAcuLPOctGvWejLZ2O6HWZvhYNn1yYO3BCRc6jUizDswo+DJ4XXZ7nBOpW6QCkE8Wx3w0j7NS7pCWGdE3poanwIZKkIEN1F6fMpTEaUXaHdQnFA4qoPvN6mGtHVUZKtFDwho6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTs1g/uq0uHdA/6TS4iioqslvG1ErSdpR+Ss4j4LY2Q=;
 b=lzc4Ca8oxjbqYXuIDUcRYULOERNIKqETZ/yrreCgzFQgAbTXcUv+wTm4u/gtVIxCaNIltvZ5e6KvO7RddyDYQ29ZMgQ6mnC5Gtx8FT+AYOcooClAkrKj1Kn5qeCj+6M/XdDjAyrQSwAHiEpUbCAJuLLtHfOxt8ctxW25Vob9ZAc2ZzaAtCxjo/TxcqaQ3Wy9rPNYoPZTwuBVKlOewPtpVUaFPqUqXwkHLwMSOzAPE6K5ENzUtYca7mvKmj2TVPM8G4FKPQdu4IH0bJY9Wlehm1AIS1BQ8LkdXzcEw+LC+5GPKV6U9fVqFBRCRtFt3Ui5aIekUkfDhaeLthD3PbSHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTs1g/uq0uHdA/6TS4iioqslvG1ErSdpR+Ss4j4LY2Q=;
 b=i0aH0S9Wjm6JvPNkOonlM5jJuL6bNdapQXygj0FWCNy65zI4E27CTATKu9+lN85VgDwCrNd4L4dJVy23Esk8oSxTdxDuq+pkotzMd+BUWUIPdCQuvSOWkzTSezDYbcurD8vLOxQvihplx45qRxLgdi3K45+YpLF6WNAEkI7owxk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA3PR10MB8347.namprd10.prod.outlook.com (2603:10b6:208:57d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 19:00:55 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 19:00:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 2/2] mm/vma: enforce VMA fork limit on unfaulted,faulted mremap merge too
Date: Thu, 22 Jan 2026 19:00:22 +0000
Message-ID: <98709f1c3e60b83b554a33d62744a13c15b3864a.1769108022.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <f1e305c89aaf15fc62c6160505eb6d19adf5d49b.1769108022.git.lorenzo.stoakes@oracle.com>
References: <f1e305c89aaf15fc62c6160505eb6d19adf5d49b.1769108022.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0565.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA3PR10MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: b55a0460-8bb0-414c-d166-08de59e89230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O2faLjAlnXNvxgzvGmn3B1quoorPvQBvQkPBo90NJq6RlMbjkxBYDHgJKkau?=
 =?us-ascii?Q?eNhNLF7LD9iZ1Ps0pWI39hagf5HOLetyNP3npFzv3cYHg5IShCslGYX4D11/?=
 =?us-ascii?Q?//D/+C5jXN9tatDcHw1Uc+ppIQhlrggv2T1laXCetTBPzdLJXzpnQiXHJlFC?=
 =?us-ascii?Q?htsqj+4BCXOv62B0ElvGMNWvfVJ8iNIwhtdUnYzX/cGK6K8D8uAuXwvNL6Hg?=
 =?us-ascii?Q?3ylp0STk0vnWUjIUT0IlWXiwycJ3/LjbRd6Ct8Ev4O/aJXIuKGftTSnVe2lq?=
 =?us-ascii?Q?PUcCy84Ww9IF9pHGktLw3xz1ULuGFMEANn3KlBFJjBQi+6v2UaE20eSJWu8r?=
 =?us-ascii?Q?rA6Q6L6qBrinXVMyE2YwAwtpvsjgwWk9nIGOV6wywRHXdZUjS1xPOv1nIMoX?=
 =?us-ascii?Q?btPDKlmpUT/QJx4ugTIgwSsuEMmELdRTHV4WF5McGLpW0b5h4z9/YNcqJa+y?=
 =?us-ascii?Q?Ynf+qKeFhzOrUAFYUs/V/8df7Hz+Qya80eMHTm2jCY0yPnr+2OTKaBVZ/WH9?=
 =?us-ascii?Q?v1dCPLMxzg+hiacoqPyShfq6NCLvDHMc6vgiZN3zh9j2P5x4QZRg4ywTQpCA?=
 =?us-ascii?Q?XrKMfy6HPxbDSbp/wL+uIJQI1a2/JnYEqrdWHRfqz6wv3SUBmPUGEp/ZuN4u?=
 =?us-ascii?Q?k+64ui8JbaW0471LSEm2+JJXvAfkjg2/cHRoefmcp1TN7xyDLCRavmrcZEEP?=
 =?us-ascii?Q?Kbd2S/mNEe5cwOIZATVhNiN5OU9ho7SfqkeIkJa9O8NktYdLyFjoeM1b2Dzi?=
 =?us-ascii?Q?T9qCyUYPfxS1m+vclKUoLVcAPgp/4yXhj+zFeB4duM80ZKDIPDmZBKRmOM5/?=
 =?us-ascii?Q?vZ/OI7LZpFA7E5kUQj8FULG4+BwKWFKHbEDe2NvrUJzBQ/X4GDSg6tx++jF3?=
 =?us-ascii?Q?uJFofY8KpQ2WhYCfNfnmhHBPaPM6DTRfygu0VTJmqDE7/S89ADxGMXa48b2Y?=
 =?us-ascii?Q?/apzhEju5X96dvRgLbvUydSRpXQdlR5EsTs0aLIqEUWeW53/nbAwSpgpyb7B?=
 =?us-ascii?Q?gbSyVP7pRG0A7607nByQFfN/9OD1FSgBa5tXFjlilorqSdWiY5v2CGJVdtSB?=
 =?us-ascii?Q?Bk486bKFsvpPfFdv/dc2XcE1v3CljavdRzTwckyoyAPgMXEvXkQTuN3vt7BO?=
 =?us-ascii?Q?KOeAx77FZRdxrJi5idz0IyNXF0iWB7qKjOCW5DFBXLQcefQ9b6jWKXmXQYGb?=
 =?us-ascii?Q?R4YLVeMtRIlMlpsIn858VJwo98nPmyC1DnDaCujnbuNlUmyhU8s1cqTEgmm2?=
 =?us-ascii?Q?hCIQWb+Ezw6KOM7maN1wn2CZXSpdfwmA6zrVjPnLIOV+N4AdxjhnaeWmnuLk?=
 =?us-ascii?Q?qQq83VhfIquc1wT1CkCkfa7BiJV9pPb/yyhBvLGXIvewMPjnMrcx7iH3Zncp?=
 =?us-ascii?Q?n37ePeT6HvGTXFsqwz/iP2RVou2O9TM/7G4uM9/3eOwrNrFsdJfWB7CAO4KM?=
 =?us-ascii?Q?wYQxieUkIvM6Kp5Nrl4N3Zl/jAxmKZ9phbBjPh0QPuMUCK9qgPGPp6b77eBs?=
 =?us-ascii?Q?uR27wCJcZwuCDZpd5wH0pdpF/8O8zciL2Nv3Ucj+dwDIhGPnXnep/KLnsDv0?=
 =?us-ascii?Q?qLbr81xfpCc4m0Jg8is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfCmvzpRJAOpRItX7Vaidoxf6ZxOiMWc+UB7M+Pj8X0kGu5HEm7Zum0BxOfb?=
 =?us-ascii?Q?EJBKDlEaofmyU1qNRfSI2cS58oBxfWHVjconUl8Zjvd6VNtzrnXaLuAwIrv4?=
 =?us-ascii?Q?xT1KinGkgFp955qqNAX0P/jWPTD+XYI3z4bMk0uwVjZfv512EpMwZtof7O1V?=
 =?us-ascii?Q?29Ka95EFfn89MnGeUazdr8MufRt8ix7ROrTE60VMYpSCQ410aLwKA5+ZzMUt?=
 =?us-ascii?Q?28hIxv/jLohtcHnFtt8ieHTqB2Azmz+nL6yhIs1JYONGOVf3KsxJlYATxO4Z?=
 =?us-ascii?Q?6Npiorr3Up1Np6uk/gWh+0jjyv4pUv6G5ZRcEWHoxxxQikRALLfkak6C59nV?=
 =?us-ascii?Q?xPylCXjTM0jozDFb83C+xzpx3xF2VlpS9v+S/rRfaw5TtrylOb0WaH4P/ZZK?=
 =?us-ascii?Q?UEvkKtCWtieizOHu7U8bRPZr8O1RhKbAZGyfIWlgKBCkwIIZKGb4eY5Z9DkN?=
 =?us-ascii?Q?BORI4j5zIqrQZPNm8Ya4YHdWqPBe093sl/7NrblRtD0utyvwnIaDzz+qk6P8?=
 =?us-ascii?Q?Ex3/p7NVNOfFuZlWr6NnTXlUvVh8FTPdFwkZ6tm7q2z26Ko0/d8kvZ6I6BvG?=
 =?us-ascii?Q?fkzZ72NCftl70KMMh2eJIyKvW5OnENCsfEoY5hOvMBuMan+nfBBldap/rnCT?=
 =?us-ascii?Q?apqlzlbftiOjW/wq/Ue7shXdpu46ae5PwOgtfVxI5tUgo8aoDppOJAnV5PcM?=
 =?us-ascii?Q?+GNqvbNukw4ALSyxrsohVfwiDYeU23+wYl1KJiCJQcUqGHOqM/AVCIcxBBOX?=
 =?us-ascii?Q?cjD5+1xVSsBI4Besdfra9qlXGo5ZsKar/CyLWE/72tLkam8n79QxJQeJrIn9?=
 =?us-ascii?Q?s1JzOczM4m6WQS1mlWLRQS7zxXZCoi6FnCAGKVPuc6kEEOouvsPT+vC5iWPb?=
 =?us-ascii?Q?GoBjZyPGqEiguhysqZapEt9n2sD4v1WZzXqYI/ZCiX6CjMgNAURxqU64LYVN?=
 =?us-ascii?Q?kWP8GVkSw5s77TmLYODLZylqlSKiqAa7SYrnyL0CrWGUKVGcRCaej4ypdMHB?=
 =?us-ascii?Q?vQuI4p8l2/gQP8b9aG1p0/oJ65qryJqISSKtkHp3FSr5LQuSPPCZsy2XAmBR?=
 =?us-ascii?Q?pR8LJAfIO9K42znn3jehScmhTFIHLHCy36j/imXF3u3Dqanj26/SiGU5xw3m?=
 =?us-ascii?Q?8OA6nPa27BqVpIzf7jUYKbmSf6pvuT/MlIb7thHd0Xp/PIL7FJbVSKopp/k6?=
 =?us-ascii?Q?qvpQNMKgubzpxckFz7Pe54zLoL1mExw43X6JxHB0wzgtlYX8j/HaydW+wUUT?=
 =?us-ascii?Q?VYY2NJK5HulOLe7rQ0gKAjRe4pQxUgbRO4gbzFcR+2wF20TQoNnSrARRCffY?=
 =?us-ascii?Q?Zg8P8pnLZp3epz8RWGKNuUn9AWZqQdMMEtp3KcBDduiqPzEC6aRK2ets+bb5?=
 =?us-ascii?Q?l83tVjskNm3voJVwdsVdVPjyhAuD42wM5uFBlPBcP2tXP9OIAfTpOmvSxFvQ?=
 =?us-ascii?Q?ZQGGjkLEGPjE628pInAN5zmk5LYqLtNdf0kflBfwY621GEzFSwmFalZxGqvW?=
 =?us-ascii?Q?ranGogSYYShVec3uUDtcG6cBL4+iRQpISKmh4wkIP9nw2z8fYjII2Varsvze?=
 =?us-ascii?Q?ss4xHy2i6TL8110kvCyEaaqfslem7BqrQklLvftYP/WSyURlnL+AgP26xMCH?=
 =?us-ascii?Q?WveXov4qoiPCmjPyC+L5YOwrFhCO9bMY59I8i2yDvs2LXqUWTGJpplw+dj1O?=
 =?us-ascii?Q?RPg35ImGSo84zDzqQ4gznK0aNbizryVCr2ggYuOxDDeR349ngeWfw/VBVI1T?=
 =?us-ascii?Q?eXtgkSbr7ln0PFZtk368dm6Gpa9xARg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zJRNLae3KaGdZcc4qMwa6bAl3jWQHP1qy8VDhdVmXmXTv/8mg1KqzrGOjM0q3EF0gbRP9rziBGEiiS3cnbKEc2KbPjMknYsMehfVJ8yYbCQl2j5jSlu9GM4uYWKdr3eoRvp69XzfMxPVgOblLOVwCWxG0udNEd5LqhcHqtMg070lzbv4isivFIMv5DXvweHSGM3n4ZHSSQjolrKlsgwUG18KkqOILfpCdWbyoV91/fTxoItc/HybDdQFinLpqiMHSHWEDdIr8qNJ2bS+KCPYINy2J+K3T+BB/nsgW5x/t+jXz4eVajANnabg21f4syygKfO4i9AgJcapnJXrvcu0mfBF9f0dH+zXuw2BEy1SY3iX7HELrKHf2DB+q2zUehHVDcxlZ7xddz0EmO6R+NzMne+Wu8ziwBV+T557CpCkxiH7p5pF3GZMTpERkDzPs34ctQqFhvMpHg4IRFJqdcE+VyS8sAxkK7uBnL5KJe/zMATXOGmsqZ6DrGXXmywUiPs0xS7Gzruo/Fm5B9qEeYRg+YL5Z59/nOX8zufC7jyhSP1rWgVVnZUwedq1SWtYosqDH9W907rq9MPfGDU8gABoaEJIrGk55NmtYrGSRJFj4iE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55a0460-8bb0-414c-d166-08de59e89230
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 19:00:55.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVQ8Lum8Rs9bR478CW67bn03Wi/3FoNR72Us8orXazB3GyW+h6XOlZg6JiZpXmfVT1ZFpTkYByHQNgGpsbJZnmnmksdJN1CoEQkTuUBla/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0NiBTYWx0ZWRfXyMl9pgbO7xMa
 8fZ0U1Nf5/Bl9eORJiD/PzHDJkrZkz4oYh3K2diGjwDgMCWtYtBTstOam+tUAk37Mbxe2lySeyP
 8THNuFJNBRdel1ti2p5obGOZNe+ydgcG+nmlNxMR4keck4mTvQRF1yEx5YJ0hDb0DRX1+p845FG
 alRmr6sFsUDOxlh+Am93rtcMtieHuhfikigo8H73TEF5fgbDlpYBu8mvbtxnNhN+CVgOnJnEKwq
 YT+9f5+Bm0QrVf5ZyeYZhqIM8gWZndVXxL+OHPSLmr1iCU0dNj6VHh+9cM8GEXdw6kc0BCIhLZU
 pGOGFCga2Ca6jpmLwAw3yjfV5mh8ySt6nz7s8dd4qLIsnbWZXCz0xMpY98gLyDehp1UmANAGJpk
 lw4E+7gapMMxq7VPPgTYBgh9U71dQmgOXSyvFP1LTSOsX6eVygfIarx9biZqwsC3NJlpqn+/zXR
 eEcSO0gfxP/9ch62r+w==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=697273ec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=fwyzoN0nAAAA:8 a=7CQSdrXTAAAA:8
 a=Z4Rwk6OoAAAA:8 a=2gQd8Ctu3wjniymgDV0A:9 a=Sc3RvPAMVtkGz6dGeUiH:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: cL8a97_D34xDagi_HysHRU-dzSqCqxlX
X-Proofpoint-GUID: cL8a97_D34xDagi_HysHRU-dzSqCqxlX
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211299-lists,stable=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,surriel.com:email,oracle.onmicrosoft.com:dkim,suse.de:email,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1449D6CD79
X-Rspamd-Action: no action

[ Upstream commit 3b617fd3d317bf9dd7e2c233e56eafef05734c9d ]

The is_mergeable_anon_vma() function uses vmg->middle as the source VMA.
However when merging a new VMA, this field is NULL.

In all cases except mremap(), the new VMA will either be newly established
and thus lack an anon_vma, or will be an expansion of an existing VMA thus
we do not care about whether VMA is CoW'd or not.

In the case of an mremap(), we can end up in a situation where we can
accidentally allow an unfaulted/faulted merge with a VMA that has been
forked, violating the general rule that we do not permit this for reasons
of anon_vma lock scalability.

Now we have the ability to be aware of the fact we are copying a VMA and
also know which VMA that is, we can explicitly check for this, so do so.

This is pertinent since commit 879bca0a2c4f ("mm/vma: fix incorrectly
disallowed anonymous VMA merges"), as this patch permits unfaulted/faulted
merges that were previously disallowed running afoul of this issue.

While we are here, vma_had_uncowed_parents() is a confusing name, so make
it simple and rename it to vma_is_fork_child().

Link: https://lkml.kernel.org/r/6e2b9b3024ae1220961c8b81d74296d4720eaf2b.1767638272.git.lorenzo.stoakes@oracle.com
Fixes: 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA merges")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ with upstream commit 61f67c230a5e backported, this simply applied correctly. Built + tested ]
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index ca0425518d02..aa57d6522f9c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -65,18 +65,13 @@ struct mmap_state {
 		.state = VMA_MERGE_START,				\
 	}
 
-/*
- * If, at any point, the VMA had unCoW'd mappings from parents, it will maintain
- * more than one anon_vma_chain connecting it to more than one anon_vma. A merge
- * would mean a wider range of folios sharing the root anon_vma lock, and thus
- * potential lock contention, we do not wish to encourage merging such that this
- * scales to a problem.
- */
-static bool vma_had_uncowed_parents(struct vm_area_struct *vma)
+/* Was this VMA ever forked from a parent, i.e. maybe contains CoW mappings? */
+static bool vma_is_fork_child(struct vm_area_struct *vma)
 {
 	/*
 	 * The list_is_singular() test is to avoid merging VMA cloned from
-	 * parents. This can improve scalability caused by anon_vma lock.
+	 * parents. This can improve scalability caused by the anon_vma root
+	 * lock.
 	 */
 	return vma && vma->anon_vma && !list_is_singular(&vma->anon_vma_chain);
 }
@@ -121,11 +116,19 @@ static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool merge_next)
 	VM_WARN_ON(src && src_anon != src->anon_vma);
 
 	/* Case 1 - we will dup_anon_vma() from src into tgt. */
-	if (!tgt_anon && src_anon)
-		return !vma_had_uncowed_parents(src);
+	if (!tgt_anon && src_anon) {
+		struct vm_area_struct *copied_from = vmg->copied_from;
+
+		if (vma_is_fork_child(src))
+			return false;
+		if (vma_is_fork_child(copied_from))
+			return false;
+
+		return true;
+	}
 	/* Case 2 - we will simply use tgt's anon_vma. */
 	if (tgt_anon && !src_anon)
-		return !vma_had_uncowed_parents(tgt);
+		return !vma_is_fork_child(tgt);
 	/* Case 3 - the anon_vma's are already shared. */
 	return src_anon == tgt_anon;
 }
-- 
2.52.0


