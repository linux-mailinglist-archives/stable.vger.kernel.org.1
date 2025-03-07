Return-Path: <stable+bounces-121389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53926A569D3
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8F7A20F6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5021ABD7;
	Fri,  7 Mar 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afIbCPZ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n3CiQAeg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382421A459;
	Fri,  7 Mar 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355996; cv=fail; b=bg36zTt7Z84L2IDaw999oJbPlopwvINqiuybM6pLjVpe4a0BOYKjTdoSvB7wvVzjcA6Xy6NMawm1OWjr3w+6w7QAeNbPgeBJAO5GvArj7WW3sTMrCoaJrB+a/eJCtuQhTP1lfnCWEsAggqeBvqB6PM/U7KUCbAdNgQCFRFaJc2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355996; c=relaxed/simple;
	bh=h99+u/xJaqhGbQukORaNcQuARBFlPbjti1gUzgKHf1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IPS9n+D5njfb+Cx77WVf6oqNEaezy/dFlC6gHbxUWHaIQK/urmc4C+hz6fMLol8bZa6FAfiLakmibEbjEEVqthPIdCH2pjgl9Z42XCE4lRHal2aT7cMdPoKFy3yFOICDBVomTRhAM5t1tu9//pa//4t39eBKvV8BQ6jqdbf3HCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afIbCPZ0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n3CiQAeg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271uV57030198;
	Fri, 7 Mar 2025 13:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9u2Ec9gRbhtIjMkAOG
	qThWfDUgHejiBJcXd2pmFobNc=; b=afIbCPZ0Bravws5NHTImEGrsPw2au3B6u6
	1i2vgIMwQz/7YplT33Owlvaftm4ECu2DBMrIGgcw1KJEmOd7OjbQR2sHq81BjjZs
	tzTEcgz4yiSUtfd+e2uzxWQL0uqJxL7Y9zFyvOqYixNSFJfpByO5L+gXqHRbggPT
	hvaVMHR1rg9NWCGvVhGg3P8Dwad45+mOV+dIpN8oNP46bamHxnaSyZfC9LmOfnjG
	H1q0bglWQh8+RZYslw62OhI5CeETj8k673WaOMVP9Ij7G4kvJL2YkeMoqxZ5kAHF
	QiWIZCqNbBYpTlDNSXmg3ITULA4XIbkGPNHWD1zFIxAkV9dnFU3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw4908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:59:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527DsPuQ040320;
	Fri, 7 Mar 2025 13:59:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpku5nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIOZJSzC/w5E3C3Wms0QgCOBm30iVZBLvVwVRj223X29O5BbB8Ls+ciKAajEAmC4I2HYf33pM++tus/RKcrLPmc6gklYwq3P37cmphPQGprDnytw7RCbnIWZ7FiVm8kSYOjVfTz8g+RawiR6ZYYCnrJxjK4LC0LUfMSoKxYg9YUNq7G/La1FYBhHZ0BoSW6dxQ8J7r/2uRtzonPv6u8sVrOoLdvJR9wZRIGIGWb8RSGAp9WaMlKQV9Eo9feL5JWywkzcYpnTLQBmC7abBQtHR/QQQ7T83maRy6GQfUFdNYadQRpgIpxC0t4J8E6kB7XNjI4zvExMRI+y4zBuCyugBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u2Ec9gRbhtIjMkAOGqThWfDUgHejiBJcXd2pmFobNc=;
 b=bHuwGuoX1lfzg5LC9ubK6NK/+lqeP9N7P0dz90Yad0D2i9xr9LZXc3Hy2+oTdz9HNiazm3q90fmmj5NEMQsW+x0P9+AbF+TP4gr6w8/Bq1O2c9XvQquiZts2zqJoH41EEkEjRizbrpZ/KLvD5oYvKdYJJvRqHdzjPjCYeK341+ZA0+Br04rpsRtiH/+QBEKhYlgy9olVJsVre5NgTxfmKhwvIv6EsHRPx3FOf9ZCj4DxzrBTLa/aXXXDApf3Nwp25Vo6oNYnfliwv0/yuQhW9zMRZ0BwG9Tqi8q9dGW/VZMP1eM5/DDn3So6GCBaG8WAQotpdP9VZKd/yRxbrnaKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u2Ec9gRbhtIjMkAOGqThWfDUgHejiBJcXd2pmFobNc=;
 b=n3CiQAegU2D8LGwEqQR+blkioAHMpjHP3xm+u4GgQUdNAM+yGBsSBM0GFgdUwxIZBx7Ke4P7xrKbbRyEQ6+PLWODh91YJRyK2agoMHqzvowEdsIa4pf2QuwjLbr6jkTKlMJLeEhzrQUakA1mNEJy3ouroFEBPRQ3Gb0JTo3Q83U=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 13:59:39 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 13:59:39 +0000
Date: Fri, 7 Mar 2025 13:59:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Message-ID: <3653c47f-f21a-493e-bcc4-956b99b6c501@lucifer.local>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
 <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
 <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03997253-0717-4ecb-8ac8-4a7ba49481a3@arm.com>
X-ClientProxiedBy: LO4P123CA0514.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH0PR10MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 073728c3-338f-4dcb-30a5-08dd5d804d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/ABdIck/TiTl1ruLlBIVLclAeTDmTsUW104tnjDuFMYoPMmVP+S5DnGzBUU?=
 =?us-ascii?Q?WliV8i56xLFt9/soeT55KOGFwkpVGpk6DAxN39hJMsV8KVi2Ix163DqOblFf?=
 =?us-ascii?Q?dsdvOZmMfF3EPNs0URZTd2iGa0bondgKve7DrazR1BjgZyWcQtIu2Pkxt3Ei?=
 =?us-ascii?Q?5Wb7fjW6EMdEiKeXrPSt4FD28ZdoTEbzgE340B/PhcWOKt15usG5aDoxDotc?=
 =?us-ascii?Q?exT6PsEV+W+DDXV158QREMPd5FaFRidNb83JqFOvdlfHrb22622meJEP3pnV?=
 =?us-ascii?Q?eCfp3vOIMtnC4RNrPZbhBaKZj94p7wMMm09IfB2ujc+LQEPQoZ8Bg1zZT8kM?=
 =?us-ascii?Q?gpJYMbUh7jaNNzugE8CIS8RIS58tohnmMM8jkSTKTp6HnypW67CuXnIrO56j?=
 =?us-ascii?Q?bz9zF4nwnaRO9teinoU04bJZXC2iTsqu+wFVYA2Co98U5k+CvS924wb8Qm8p?=
 =?us-ascii?Q?uu128sKVjX0JzOtID8C6UpydRNDvIIVH77ujCNGgoJRqnsFNxDUJOaC/FgSX?=
 =?us-ascii?Q?TnLcK9zUu9OdR06UN85mX54ZDrotGQXqU63Eq1KdgKGoyGNcXcfdNKI5TkTJ?=
 =?us-ascii?Q?1ycS+SlTaYoTx+QXNbJI5/0WejhmBGkQIgU0gwqXN17opktcuyAPAWWoNBEX?=
 =?us-ascii?Q?CosSWufIVCiu47BypIMmjdM6eE6NLH9pNVgjg8jq5FBZO8Q1M+BXrWVffKJ+?=
 =?us-ascii?Q?z4tRMCaJZpgrOLAwmgKSstLW75DJYIpv81z2WN3kvB6Oj+h/2LIZOtwyvgAa?=
 =?us-ascii?Q?nTFXBH9Ude4C6fEq3+Me+7IouIFUynhMpxdv/jiiT8FgiFd2W0ohZdnWZ46F?=
 =?us-ascii?Q?//PoKTQJlFOU7oD21WYMiwfNScZUpOLS8pb2syW34BAq3DyxYEF2V4QNjrB0?=
 =?us-ascii?Q?jSLgavXZCFjA/HezlJdGTooRk9vmfh/abzV0hsszMOskvUhdvV741QfyykEM?=
 =?us-ascii?Q?n7QeM2bRNcpCJLXcUit8cTcNLAqxu/B7LAClBrGz462N5kGU13XMXwjc2ETU?=
 =?us-ascii?Q?39eQt+29T6FTqqRumas9ucqHYMGVKeUAeH0icPdmWVQQjQ3lv8sSzBL3yOyE?=
 =?us-ascii?Q?p+BSHeGZzn5X2B9cLeEPKXMP4jWkjn/HVFgmw9voFt4aAi+S6NIQYXKO0New?=
 =?us-ascii?Q?73yYjkR10d5Pl9ng2COq4glaVLXE23im4NcioNyC969KiuN8rBMDq9h00X1v?=
 =?us-ascii?Q?1kw2Fp334cVnGSZx86O2ar381sTy/yA7s6/k4cg463S6FlFriPuWLLA+VJFV?=
 =?us-ascii?Q?beRzR4LcWJKxmEKC1oYytHsWzED4sF3AtbJkq91NJBHjnZ1E7jlqQViM/Jh4?=
 =?us-ascii?Q?eMhm3cI8mIrY0/ewp/LDaDu/szOhRrlf+hjMH+RdFwiaWabI14VTSucx9Mno?=
 =?us-ascii?Q?O63VF9rtgYUJkYwXNroGgjc5yuup?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DrWN+PjvPi9PDSNUQ/qU6D17it4mu9r3WFRbwDPy9Km7kNhfkNkUdAOa8RXB?=
 =?us-ascii?Q?dXkVg+FOGx6LLyzVdWUT7GCDU9c2pIgs1LKz9OEz7iLvWauJmxfBN9QwMe35?=
 =?us-ascii?Q?9m9ewAMmPhy7ZhxjDJRVtNEgpFbJNLOimzHsGIw0PY+p8ddZ+l3/mSBFarD5?=
 =?us-ascii?Q?BzBoHaXIwPS0U1dkYAj2tDU2gsyABHHrO+Z1IylHKdS+T1WcP68IUw52TzjV?=
 =?us-ascii?Q?pBVrNusASh2/4gxrS1NXwhYjd220NhznmVJtIDzA1BudEBR42F5QW3XwJoRS?=
 =?us-ascii?Q?mmmJGIwhaDhxSdeTLVZYAt1ZM1rngMqsy2Edli7wE84Z2NKV2MkyfEW2ocxL?=
 =?us-ascii?Q?qp0y0odFS0W5jF/osa1SXbC82mTT+e6kRUCWmYhz8/JFPsFV4w7Z67baMwjp?=
 =?us-ascii?Q?YnsSoZKQJUgbg1lXKTJ8IPVK7gESt9hqdlQa5hu4hc2Rrxqo/nv14vYUmxtW?=
 =?us-ascii?Q?9oSNLM/G5ucCTmVyEH389czJ2LjTL8s0ZkkYfqPIbIk3qCIl9RnY6nFJszXo?=
 =?us-ascii?Q?+mEldCV8v7X/xeY2fUxvR3pUNaGN3Bg+7tbMdOZOnRYW5a3swSG2j/ZI8yaj?=
 =?us-ascii?Q?nkx55Cn1u+0b+F/5BFEeM/YQkG86XmT2BOwW88Y7lVuRQpyFio020+Bp41sm?=
 =?us-ascii?Q?eJFJFKR0ySYLrgosc6bLI2pdtb86T2GSNeifSYR40rplhhbXIdQjAc7ktQOf?=
 =?us-ascii?Q?6Dkfgc9Zh7lg3Ke1avPZWb7MlNVseNIZ5Ms4CFwoQwPi0vgdZTCUH0/t8vCj?=
 =?us-ascii?Q?zE1UHEDinTERjocGkRu8VwV+vqm6bjuzD8Yv3JceF4i7bX+pfU9cGkidlmsY?=
 =?us-ascii?Q?7IlO3m6oJJoCXlMkCl9SfO71JtrIHEWX4zb2xOGqt15zHPwgeIdWPCwLWZY4?=
 =?us-ascii?Q?uvNSH4GOo5PU/FZsD513S5DGCA3AeIQuLPXwof7EkXjD2ThmGE5FaaKN+y1q?=
 =?us-ascii?Q?7VivG6D1zg7m7iQUIa3N+3nTkMuOJuyfLPjxJoIT6Mz0Z+fxVyaNwL9CDDLY?=
 =?us-ascii?Q?uttZLHtW1nwnG/lpOFeUeZ8DUvQzUmpjUz+WmzhOvuBHx3jCDETgRvirhmWe?=
 =?us-ascii?Q?mhfJ0d7BgHwnH+yXNWBB0Rn9ZLn+mH86Vj5URNNWMHHtnVJzT38SxjojJGTk?=
 =?us-ascii?Q?r7rA5xEBMOVmZX1/sVwlYfmmvtPx0T9TBv79Ge2rz96CnmkmMhljsZNnIb6c?=
 =?us-ascii?Q?JdXit5zhHyhHOI46+YjT61VaQ6sUXVPLXWXCDE6rYGleCR4qVWWdYjrB5mhE?=
 =?us-ascii?Q?KXC22GvtkGhFDiGpQIORw1ZN/GXF8OQVQLn+9I4nk4OZ0N57nKN+fPCDHn68?=
 =?us-ascii?Q?P1mXt5IBxv8iejvJ7b4I+cAMLfWOVwcmM8SZhMpJKSxaChqUAl2p1wJHRKZ9?=
 =?us-ascii?Q?elBAGdjDRW1VToAqkU1hhqAj5gkryClF0nezD8UUWB8pNfB+3+uGpY1eXQrf?=
 =?us-ascii?Q?FbNcHoMV4YsqkGFqMneDyZXKTApBKOpHmiEBRuo+L9z/dHd8hVQwhPGMjoy/?=
 =?us-ascii?Q?b2EDeHT1etZI6LgCFYK4lUlZVQMvvZ+RxBtqp7TsobBe/CvkVQpoKHOCHJyV?=
 =?us-ascii?Q?5dRTnV4UDJdemIZ5zW+BfMApOmBbUkWyjTNJHZIl7IlEtkedZxnzbazvaVuR?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZMKz5wIOi3ys95nWJD1Ej20gRZqXIS+/56AGdz7cT7D5LVr9x5bvwTK/nzFzl6EwLUIulm5ozyMl6MWEhPKskT9Y+zFT0Ftr4wgPGw+5p0VfXwAOsGmnbWFZqKFB9bIF5TQfxG93KamidzTnz/7EULfuwjS4iB6Duesf9AII0L0H4p/wErzWzpr3g6Fw7KKadDVbwwN9KPemAZn3uA3toffg7icnft18T2NGqct90NPKuPWyy9m6enJdZl8cn5UBalDuXhUFUTCvz1JSaTe5V5HcdZSuMoDxEx45UlLVfdjNFMr3aVmwGKfXMh2tIars+VeE6wNwWl1Nzbpa1G6xRNnJpXq9hwwdOujv96370tIkhvNdSRYmWBFJYqhTA6vQ8yEfCn+QR5HzloI4XQlSbM6x1R/nx+Ng3WlBnyZoAdeTHTfuwSzZqz5mCWTL2CTdE23YdqHrf+uRBvB1JI+bNeg9IvBzj/nQx5zUjljaAKSJZSScccHnHI1g5lkmIAHCIlGDcjQdjxoTh3mDiQ3mu6RzodH3fNbQf61bbrWgdSmV8n0MKG9eC5D5OcFSwx4z5JxZZNyx9jFYwo6LIxIBMJUya1xt0TI5Ff1GDJSUqe4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073728c3-338f-4dcb-30a5-08dd5d804d4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:59:39.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NupMXF4Hag9SgvGbQKY3H2UtosaH0TBYZMMGVJba0VRJZoziicZ4YjUnrfpwrnrUo4h2SCXVUaxykIOCB91cA38Mllb+tpi+/NZKFrTzc1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070103
X-Proofpoint-GUID: qQDmS7p_ECbF3ggZxPclGgIt8MySFReY
X-Proofpoint-ORIG-GUID: qQDmS7p_ECbF3ggZxPclGgIt8MySFReY

On Fri, Mar 07, 2025 at 01:42:13PM +0000, Ryan Roberts wrote:
> On 07/03/2025 13:04, Lorenzo Stoakes wrote:
> > On Fri, Mar 07, 2025 at 12:33:06PM +0000, Ryan Roberts wrote:
> >> Instead of writing a pte directly into the table, use the set_pte_at()
> >> helper, which gives the arch visibility of the change.
> >>
> >> In this instance we are guaranteed that the pte was originally none and
> >> is being modified to a not-present pte, so there was unlikely to be a
> >> bug in practice (at least not on arm64). But it's bad practice to write
> >> the page table memory directly without arch involvement.
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/madvise.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 388dc289b5d1..6170f4acc14f 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
> >>  	unsigned long *nr_pages = (unsigned long *)walk->private;
> >>
> >>  	/* Simply install a PTE marker, this causes segfault on access. */
> >> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> >> +	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));
> >
> > I agree with you, but I think perhaps the arg name here is misleading :) If
> > you look at mm/pagewalk.c and specifically, in walk_pte_range_inner():
> >
> > 		if (ops->install_pte && pte_none(ptep_get(pte))) {
> > 			pte_t new_pte;
> >
> > 			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> > 					       walk);
> > 			if (err)
> > 				break;
> >
> > 			set_pte_at(walk->mm, addr, pte, new_pte);
> >
> > 			...
> > 		}
> >
> > So the ptep being assigned here is a stack value, new_pte, which we simply
> > assign to, and _then_ the page walker code handles the set_pte_at() for us.
> >
> > So we are indeed doing the right thing here, just in a different place :P
>
> Ahh my bad. In that case, please ignore the patch.
>
> But out of interest, why are you doing it like this? I find it a bit confusing
> as all the other ops (e.g. pte_entry()) work directly on the pgtable's pte
> without the intermediate.

In those cases it's read-only, the data's already there, you can just go ahead
and manipulate it (and would expect to be able to do so).

When setting things are a little different, I'd rather not open up things to a
user being able to do *whatever*, but rather limit to the smallest scope
possible for installing the PTE.

And also of course, it allows us to _mandate_ that set_pte_at() is used so we do
the right thing re: arches :)

I could have named the parameter better though, in guard_install_pte_entry()
would be better to have called it 'new_pte' or something.

>
> Thanks,
> Ryan
>
> >
> >>  	(*nr_pages)++;
> >>
> >>  	return 0;
> >> --
> >> 2.43.0
> >>
>

Thanks for looking at this by the way, obviously I appreciate your point in
chasing up cases like this as endeavoured to do the right thing here, albeit
abstracted away :)

