Return-Path: <stable+bounces-160212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93868AF96B0
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0512B1C87852
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F11917D6;
	Fri,  4 Jul 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="evECxpVW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X6FTLnuI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825D1C6FE5
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642661; cv=fail; b=s/26Raa60VpTwLEG67vHTCHnx7ZISnBDYuDc0rWDFeo3g0lEJSLHSTbZKmN9ccWvVxJRGTOC2PzhWDf1BBte9+DH08rvszRx1adrFmyZwhMA+n+5KGqA1v1Ba7mXfoba5fEjosG4Cziq1OFfCOYIxIEfIoYxeVvYH8NDYzNgnF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642661; c=relaxed/simple;
	bh=d9Zf7iwmkmQdAZ/EBUiCL3Bo28lbx+B1CM1RLeIvszs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJuydBOQKTDlqjNm22Bs9FjrW36V61I8Xzn5jB/oAfRCq0PjktA03aISvsEA9LOYR3BXXDe5FYhl98bxW9FAGoZsMUrTLqRptQIQPY/GLdvLeqddWNs1YQOhCsez6XKQtU/PMYuHxO2auhxMoPzpeOUUq9iGbJC7rd4OoH6WKTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=evECxpVW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X6FTLnuI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649Yucn032640;
	Fri, 4 Jul 2025 15:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7XQANMCGmb7GonGXL4pFcEfrEr3Z8+yTeeY0q7131wc=; b=
	evECxpVW6ygjQ1UgeVQOXSt9ieYGOtxDpY4U3ZUx0cZG6bW1FcQKrzdM8WCztco5
	nOmjS22T2n1/gEyvPQ86r+AkDVrgnGzOr3pfTp3rirtjU95R39wajBgFCwMTVatM
	C5xlnDZaC+pmXqkjdzfcEmIK5UEHOnzVK+w4jQFJDHiXfBR9iNm1xRR+V9ACgFR6
	nfD+cB1icIHTDJj8TfQq4PaFJfKdDtzwauB3FZEfgHkC0Jz/2vITe+LEwVDqBCxf
	LG5G0WpGVb84odT52QKWnqZ6CYW++yFqWjdG9b/ULFqv+AyW1OO29oWKIrhcluoO
	Yu6A9CVujj1ug39LYZi1KQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7afay9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:23:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564Eq0t8023980;
	Fri, 4 Jul 2025 15:23:52 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1jqubu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNWiDWdU3cjMoIx1zOWzT0jpG/QkeiGYoCesbmP8HI+e/52P744Klf2AAXucYyVPVfs+BNO8IbB187FELlNKt2aMVzLnlFPKrrmyW7mRFkimukyFIs75/GLU2MoCFzAcZkdCg+q4n9JsfejjgXW4CbMLcoOSqHClypdi3b04j0II0MwtWKbrhH+8irlWXl4A6mLVnlc2j9axldCkk4QOneK5vPBY49muyG16+JTjNvAPadlL7/rxCF/Vz42iPqhVeVoxQAfjDg+Q8M5+Zb+Pq4EsjIY9N3XqhObBLJpEWmoWGyt4S9gsHZ42YmzThaC87MPPB+TfQ5DXKwh7gw80rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XQANMCGmb7GonGXL4pFcEfrEr3Z8+yTeeY0q7131wc=;
 b=LINCCy7iOwMSBgSwJWEHx3ap6y/kJSuSnw+HWXNReLZjFw5epT+hy80FOaPjyMdQaoQ0quzPtBeYfphTsdaoOwAVlc2+DJ5Zd11ojRfixYpSHtS/dmp/Ef3RFrvOWG3hpe+jSgm1h+WPgBhwyTbTrzG55FgzHQkAWKbOddl58gg3AvScUzX54JMGgb/Ja67wyMleZZDJUnM/m0hjFyTyzIQtygm6JSoCs6Y90WuoV3uLbbu9EVOqxqjU9XP2U/SFjW7dViBVu6DBS4S32OJNO8gLphmjVEh/Veb3CUBYxAnlncWAdtzvjzH1Xi2ytmJFUaEjUnqX7NVLVK44O3RMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XQANMCGmb7GonGXL4pFcEfrEr3Z8+yTeeY0q7131wc=;
 b=X6FTLnuIGDY/suqBcRScroaElV8KSAeOTmiGqOFbLd3ONtOLpjWzjZNRry7R4uzkflm83GGAfXG1VwX8s3a+NmxVIIi6tEldvxiOLcossY+gYfY2bghglHi8o0rrFLCck9uXDHh0JB+s4YrU1HsRD9qUyHIkxyIid4dmMTmZvqQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA3PR10MB8589.namprd10.prod.outlook.com (2603:10b6:208:577::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 4 Jul
 2025 15:23:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Fri, 4 Jul 2025
 15:23:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: stable@vger.kernel.org
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Hailong Liu <hailong.liu@oppo.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        Steve Kang <Steve.Kang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
Date: Fri,  4 Jul 2025 11:23:36 -0400
Message-ID: <20250704152336.143063-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025063033-shrink-submersed-b5de@gregkh>
References: <2025063033-shrink-submersed-b5de@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA3PR10MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: c044ed43-bf1f-48ad-66b9-08ddbb0ec5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbygdudZde58E4Fpvgrtk8rMRM35P16LoLtl7XijBg/wI4ocqG/PPNa6cHTn?=
 =?us-ascii?Q?cBwPfHSiASskvKdKS4tzQCxAmQKEAqBDVL0cnyhBpihjTgGDiLSlplj3PePz?=
 =?us-ascii?Q?3KEUh/BgZfqFmvgpxp4VtmPI4Xah02be+nd+K1arqdKc3MNhMQacs0UCUsV8?=
 =?us-ascii?Q?Sdi2SXwdhFKQCWDqJ8bhMnrk5Dw/U9Hvze/7IMgijfu7Yitxtqaww/qdhRXi?=
 =?us-ascii?Q?QQHCODhDDt1t/dXFCFMN7V0kwDyFJxh8CbPDUFKKgZJZc+LhBSlRRZGBqroi?=
 =?us-ascii?Q?MxTDwBqnb7OsCcQHM0w3yFMk+197u27ljDxo8Xl4PqRwZKM8xhkUHZhlzlo7?=
 =?us-ascii?Q?Uo/DecgsUvtbj/3sgEBpvq6OGdBycGQIGb5QFPRpUxJcPLdPl4HgkH594IV2?=
 =?us-ascii?Q?jOvFyX2/QkLplUNhgwXs+dCORWbg7R4ynHMKIWc0XBNh0uXEYOBerFnnjnDd?=
 =?us-ascii?Q?uZ71Fr+eaC4txpbaNtZ8Ihg9e0/ft6Au+YBNWdLU4etjRWQl2DMFfAbzjsZ2?=
 =?us-ascii?Q?piqV43u2XMbrQ/jJeAxYfWY4mmWT/JszZf0bnoub3kUzIy4haA8NgmnpIfHL?=
 =?us-ascii?Q?+UJVAIjxESTwMy7VLjt17PZMbQTfmMOvm7M85jsGQ5zbRCzEYbsu6um/kj6u?=
 =?us-ascii?Q?/sdLKZ1TqgdETBcSq6UF6qq3k+filAmrSxbIptpM3PHZKnKnCuPZw7mufAZy?=
 =?us-ascii?Q?gT5mpqlvry2B3rHJAWDrtCsJebuyPEwLn9gPdTHi7VIJIemqGeAofK5OuGpd?=
 =?us-ascii?Q?iUSCdEIkIGF2467c3OYGjnANpUg+husqPFVtObZe2e5Jap/7aX4ci6iB1tkJ?=
 =?us-ascii?Q?obEUTESSU7ArKf1ZGauMUI4EvBvyh1DbdqTo1+Ds44m/vFRKbfjU5XYlxHNX?=
 =?us-ascii?Q?qMZeUza8yiGQpB1TlZSoTngXVmBUnw9N+yTkqBiF4iLcJ6jqzRz6lhtUa/oo?=
 =?us-ascii?Q?088ohU2Gc6e7x8RYtQNmoBzbl96ICL1d5Vb9C/OkUa4qfsKHQoZALSKOogJN?=
 =?us-ascii?Q?ly3octa58gypidkQtjdEiKeVSwFoXSK9+aS/ZfeS0EDfM1aJbX0NoTWL1QVB?=
 =?us-ascii?Q?P19rfzbSN4PBh6WLHbcUo41HdbxvS+bOESDfzdjDrpGVdJqjAWHM2l65ouSJ?=
 =?us-ascii?Q?/m9aN6nwYjgqqCHRyi1Xl83kh+zjjgEWwlEQjARrXqaA0qWeeK+5t3GVhTpl?=
 =?us-ascii?Q?9vs/65jxXBE/rG2kKR+ZFNf9LhP1gGAbUK48ANjyx6fg1Qdr5tU8EHAcQqlR?=
 =?us-ascii?Q?/iGXA/srL229xOnVlE8QUbKTeQOSMSJKqnGnUSBUMwTq/BC+H+WH1sfEnS6i?=
 =?us-ascii?Q?MSmFGiq9mWq+mI86nid9k4PEAMocCMvYEBAFdeacLu0YBRnmW3J6sGOmu95v?=
 =?us-ascii?Q?T8JDDCYbsd4CYSe4dziz51lEFp0/Wi1anpBWWLlE/TEYImKMTwV4UKz/eU4R?=
 =?us-ascii?Q?KlDe0S4pdoDkLvLapxTbz9hOcvU8wv++?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4i2W9n1v47Z1vp788D/LDP0lYO1fcCgMk2omUYZDnYCIuf4QX95UI/uX6WLx?=
 =?us-ascii?Q?iPLR0HE6trZH9rfsKn7Z9pGx3toqjVDGBNTteQKz5CxmMQ6sFpwvl86lJfwZ?=
 =?us-ascii?Q?S7gnabz2Rsvtm2ZwfMJZPuvdiGc/YfG8zR332tc6s8o7ISdzBK8ZBnnzckQs?=
 =?us-ascii?Q?6ExvV4wxD0443j90x+2oG7z9XbXXdlhNWuEtZHpHB1G8VoB0LJqQV3XoECBK?=
 =?us-ascii?Q?yCFOUQcUw9zgA7jvGsrAUFBen+u2Te7Wk88dWyeXY1PdxyQqHnQuwgiIVZQF?=
 =?us-ascii?Q?vBheB/Jg12jLbxDvowJggyKnoRcdUcvjDCe7IKcu0u3DQS5QDw3C/YvSLEE2?=
 =?us-ascii?Q?4ylnh1gOTuwrKAtwss4j9lky5y3C63eyVUkal+FfledK2sCHaFWhDaZxFF+P?=
 =?us-ascii?Q?k9YSqR5ltqCi6WoribPXLugqeBMoOlGt46Euq9ZOT0Bd9h5CdRSQccN+ctg9?=
 =?us-ascii?Q?9LUDGpWUkxkRgDZAOcuOHktK5zT5hsI7rXOy7b9WP7GGyD8FlSjd9j6A1ohe?=
 =?us-ascii?Q?GVdH9ZbXzGwgAiCAfaoQHdRCWzYSLlEeMh5TMF//ACm+jdNmW5+XJYXHlfK7?=
 =?us-ascii?Q?QCVfSGznhk7jH6auEl5BpOFsbebiX8d58OLkfFjxLL2QczrV3RcVLolZLh2i?=
 =?us-ascii?Q?Jr25RberJSnsDLjKhTrUlRCByu0yQHol3Oz7D1WSYgTaXPruMBGdP8zlH5SB?=
 =?us-ascii?Q?TCtJV4AW9r2mdJm4zawfDHwiUrejDFZdXLtWG+/Nw5r+RO7UcXlhyLIcUlVX?=
 =?us-ascii?Q?6GEy2rijvaevfnUNv6bWTUNfshzfyCGYsjpI2XohHv0Sy7W1trDgp/WC9ipQ?=
 =?us-ascii?Q?vnkrzdCOKbZOJHObysub8iFUhzgB/KodC8IyzmCh2TUyQnP56hw4aLJR3hQM?=
 =?us-ascii?Q?7Y1TglD7Jwdb5+u47MYw6YMb9HsglGJ4FdYBweP5jV87amTukRS4ud6h0Wuu?=
 =?us-ascii?Q?PS+NF+IVOB+iNd3tueayIEcpia/MTy+8bgIGIkjCBL8OFXWQw1dcBg8DVpJF?=
 =?us-ascii?Q?ZaDa8j50HwE2qf3Pq+hv4NuVEpyChHgiu4IswnG39ldUwHSoZn8mylQmJwUG?=
 =?us-ascii?Q?rZGzlFuGAoL3jjSFbShwbX2H5pzyeRQ7UeeCGp4LL5XryfEprZ2ohK6jkSBZ?=
 =?us-ascii?Q?JzxfSlO9N0/edGwZPaKZ/XBPp/KZZzFuwDlXl4UaiApHdH0OR53q8r8oFhnD?=
 =?us-ascii?Q?+R/zHiJ8+wtinoiuZ5359eqoclcdtdph1qX4P02Kz5sYTUNVnKx/SsT2+7jv?=
 =?us-ascii?Q?flcnRMXfdGFYkbyTeZVC7TkrD/MwI7FoXT+cZ6iOk3kqBtBThy4ZvNN9UqpE?=
 =?us-ascii?Q?jF0EcFCARgUuH8Df322MU04vRHHQ1SmpNc7u84WaGEiXNT9d3eo5Ba3NDrB6?=
 =?us-ascii?Q?KYcygXf4qed3XlhVlps3a2zS5xOgchQV0BXDAnDa3KjECXZDH57jb2QTd3gr?=
 =?us-ascii?Q?01yJFzU0UwgsUFDRMOF0jVL0do+THDlsp6oIZ/t1O1JcR+VUPXXvm5dym3be?=
 =?us-ascii?Q?WmxDVmfE0HCcMChEpjmMlKxrhYrT/XF+HTfX22Fm0r+fRhbTnqX3uoiqnmre?=
 =?us-ascii?Q?cyRoB90B+9h+7uP9hJpTShN9MlFIkN5Qub0E4ceQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FDeGXYHuBkDAU1YAn1p+xr+ti2u51VDdxI9emBeTE8NJOEa0e9JD/b+iUuBk8bCVnMjq+2LSZaPsjeIm1tuIrKp5MSqj19DK0Wq9tHreXLWPTJ0It0rFsm1lzJznQEO6F6fyn/pneaC1YvSy8FHse46KRoTuyO438/BZLoi1jXGrRvYAUeq5g62obVVn5CFuisvkDk6Sg9qEyW5pP9GlvSSG7I/qqZrhD6fwonegMypSWsES1cAPgTKBf5eA0clllUZDxhRcCO4VJNl1kfmFizL8T8Sc6rxJnFyNkYS2VHu8+HGdZezvG6auWNR8GtmUvDm5xvkDnRVfhBgS7c52ze2qlVGmjj9Jq23DLIaL5v1LiKXRfBjrLbQA03zP39azQ16NitjbHEusaT3UShZ/dg5mn8ZHjjfOTv8mBNPHZsQJGLsdnnnwHA7vYL3CIC06herJEUgGpx3ZcfMjl0xI6hi2PzZ3nW5ZH37kHrMFU3NuzsTnGljDXOmL+XWKewpeqnQjSJZBqTiVnlV6MWZ2AWZbsnwXtZqkTe/Y3F05Ti9v2fuizwkWgC3m/LGRD7tdB+NSCl7zVwsnX58SakDLdGiYII+B3Vm7/uuxs/rypQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c044ed43-bf1f-48ad-66b9-08ddbb0ec5d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:23:48.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl+ehxbx0EljSMy1C8SqZBJ1qnUr6o8uttAb5I8VyfnYRbYezDbRBOprzDX8HD2GU80TpYkXJrXpdl7X9aOGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507040117
X-Proofpoint-ORIG-GUID: nnrdtDEeZbzUUbxccgggoV2u0urcy89Y
X-Proofpoint-GUID: nnrdtDEeZbzUUbxccgggoV2u0urcy89Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDExNiBTYWx0ZWRfX0Dqm5OJwOqaG UW+P7acIodP0ut2ZW3RyI+sBiq8Z/i4wiK/heUk0c3GGMnkiItEsrNu7gFkAxcwlh571GWeBtst kQq56OWr5SJvT6z7UbHrzYVj1FYxAN4/Q3+t7Rt5RJHckwc3Fk/FfXACYVmpFwg9Td0Uy5AYSQ8
 UC1bSzQHP9Ay9yYE098e9jPnVpArTwTlH/L7Rzf/Q36uOxW6WS3pAXUimwx61sKF1co1juccpDg 8EPVpkL7XIHgh2WrEX6pKbAwsefQP8pOKT/Ua44PyvR64RqjIjVVfTeQzMu3sw4xhzP9WVT68fw LWV+B8jeDB4/ho4JbOIwHxbp15Ww/q2Uc9n8DrTMBSvZtLEIjhvXFwrhmPgcI8yo7Hn/VWeJuLH
 F9qAr0/lCSeM18mzmDlb7PBD1jiByqYn73o1kaBdJzZhdhiBI+5iqlu0xSjddhuvdvb069Xf
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6867f209 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=A2pY-5KRAAAA:8 a=icsG72s9AAAA:8 a=1XWaLZrsAAAA:8 a=968KyxNXAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=wTtCSAouwvD0ySbqfS4A:9
 a=T89tl0cgrjxRNoSN2Dv0:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12058

Temporarily clear the preallocation flag when explicitly requesting
allocations.  Pre-existing allocations are already counted against the
request through mas_node_count_gfp(), but the allocations will not happen
if the MA_STATE_PREALLOC flag is set.  This flag is meant to avoid
re-allocating in bulk allocation mode, and to detect issues with
preallocation calculations.

The MA_STATE_PREALLOC flag should also always be set on zero allocations
so that detection of underflow allocations will print a WARN_ON() during
consumption.

User visible effect of this flaw is a WARN_ON() followed by a null pointer
dereference when subsequent requests for larger number of nodes is
ignored, such as the vma merge retry in mmap_region() caused by drivers
altering the vma flags (which happens in v6.6, at least)

Link: https://lkml.kernel.org/r/20250616184521.3382795-3-Liam.Howlett@oracle.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reported-by: Hailong Liu <hailong.liu@oppo.com>
Link: https://lore.kernel.org/all/1652f7eb-a51b-4fee-8058-c73af63bacd1@oppo.com/
Link: https://lore.kernel.org/all/20250428184058.1416274-1-Liam.Howlett@oracle.com/
Link: https://lore.kernel.org/all/20250429014754.1479118-1-Liam.Howlett@oracle.com/
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Hailong Liu <hailong.liu@oppo.com>
Cc: zhangpeng.00@bytedance.com <zhangpeng.00@bytedance.com>
Cc: Steve Kang <Steve.Kang@unisoc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fba46a5d83ca8decb338722fb4899026d8d9ead2)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b5d216bdd3a58..63037ea4394fc 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5802,10 +5802,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	int ret;
 
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
-	mas->mas_flags |= MA_STATE_PREALLOC;
-	if (likely(!mas_is_err(mas)))
+	if (likely(!mas_is_err(mas))) {
+		mas->mas_flags |= MA_STATE_PREALLOC;
 		return 0;
+	}
 
 	mas_set_alloc_req(mas, 0);
 	ret = xa_err(mas->node);
-- 
2.47.2


