Return-Path: <stable+bounces-150607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B1ACB9F0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EE2402864
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B02AE6C;
	Mon,  2 Jun 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F6x1FFJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="omfTqxWL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EEBA49;
	Mon,  2 Jun 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883726; cv=fail; b=H0tUlFG4CqEM8s7OG03AE/bEZ31VYCWdKTbCBfCWgO4LzezvoEXQ0DaWROqDmeMdeHxi/EsfMMx26MhbdzRZ7NStPT1aYW1KmQuGDZR62rRFV90rPwr5gAtOYKUkwaRjsTGSpgeESpBL7i6ZT7Pacmtxqiwmkp01PLynjJJX05g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883726; c=relaxed/simple;
	bh=MwH/KxF3su7cA0XurlYWK7g5MUYDx1tO/HNJFX4f9o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J92oxlwVoXPSWL+v2KjrK93xQrXu9ZA9f6UB++umVoWO3rY2YX8mqnq9AoiNDY+N6ppv0VC589N6Mwabj275altWezeZ2HjF/fjhIsAsK98bYi1LyEDunMVDBhI1KlWmra9R//rnlC+RXmDUunSK9iZBnQcqgmNoP6XAgbtJocc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F6x1FFJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=omfTqxWL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4XTQ031289;
	Mon, 2 Jun 2025 17:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=58SKQ+rjGpcEX2H6Za
	rAUYycW0ipKmJs8W57bmQreCk=; b=F6x1FFJiaOktFDzLs2I0+ZnHcNNEVc3KVO
	OdfVh+T+f6KVZ3cyTDj/5uiYjY6LE4V4puwgkGSOSfpueB9VHZKkZMMVNLzYm/BM
	vVA06wmNT1xsZxjKe5q3NkOqZkJkPs5ntSZjlG8+50X+tEyRdAvUmRSpNg5NAKDT
	qf3NLbuNpl7zntwdZjnKxVKjS3Fb4B7k3laexG2Y7AATxyH0f8tHzHZ5rvG3EI0K
	01KhEYu0lOK7uc5zqKqp7JxpLQQrg0AdXMvn1k5jvABekhZZ7mTSrPEiX8hXtHjL
	li98hXdjwNt32kxeYP1uJTVqVVyiZpFXbosPS/RkhKh08KiqSNHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrpe32cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 17:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552GoJSo030620;
	Mon, 2 Jun 2025 17:01:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7886yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 17:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq+j2hDc875dAo6kT1JfN7Lqq4m3YZUwyJivDKWOU51ITMR8yOnOBFy89f9XSPvUZrljBm2sHVx3cu3vsddPe7BNEIHv82KBGY55iH2C/5+QfYOIdh6s9nzM5eBytr8oNOHOMwfEh2BQZboLsEj6qIYEf30iCYsERzagnE6/f1t2IyBXJVe27aW6U6nZ9jJ2o/b3gR/SJvgUV9V6mVesoteIOiOvxG/YUuVFQSlb0b/11wFr5XXmHu2b+uOvqaI++dI6zLvMchZQgS7QiEDfFT10A1zcypet/VBFOG26q8m5lpUPfbge8eGAPo8VkFvEgHRvYB91tZs0UxUSndmozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58SKQ+rjGpcEX2H6ZarAUYycW0ipKmJs8W57bmQreCk=;
 b=yplTMJBqU+IoZm1+j45Oc3CgaZHoTQ1LBh4sr540w8Ne4SNBlsRE3UTFeGF4/d3Ws4BvijKBJK42gQ7LAA7S3V1mSNKpAH56N7tdfIVWbSJE7AmniiZasHfgKSWkT2Z4Zsuj54DkGNn71O9Vwywcuyo7pv9hmSOJaLgIlpEHlp6E5xSGRWNGcmmpvq5zzaolIabPOZVbdbcKEh1GwZcm3A0nCwKL6bFnZerHtBI6DofRH9hXppRzJ4pfy4VwWoNWnx0FwEKLw4b0YGU1g3NXELkOb6KsyUlH503zLPY44JfJ+xRWDFLVEXTwNeU56EZh2H4nMYC+WavfwTA4ubiKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58SKQ+rjGpcEX2H6ZarAUYycW0ipKmJs8W57bmQreCk=;
 b=omfTqxWLfkUHgph1uVmrJdbopR8zLM2KEU/BjTsGW1XQaCom9zsr0F5ar+nUOskH7kjI5Akt1srd4w92Y4Y5OXKugldLvKyQ59anGvZs40JcZ9ii7uUBxyDgM7QhWRPskzIBTeRhs45n81H3daTFdIPrrldN6kimqzOtBGqm9uw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Mon, 2 Jun
 2025 17:01:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 17:01:22 +0000
Date: Mon, 2 Jun 2025 18:01:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
Message-ID: <86b7cfb9-65d2-4737-a84d-e151702895f1@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
 <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
 <009fe1d5-9d98-45f1-89f0-04e2ee8f0ade@lucifer.local>
 <6dd3af08-b3be-4a68-af3d-1fc1b79f4279@redhat.com>
 <117e92c1-d514-4661-a04b-abe663a72995@lucifer.local>
 <702d4035-281f-4045-aaa7-3d6c3f7bdb68@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702d4035-281f-4045-aaa7-3d6c3f7bdb68@redhat.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df7cd63-7a8c-4d2c-ad98-08dda1f71a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oj6w48dhry1JgHeydTSwQcLrzAUuOUJYo66Z1grK9jpw3xT92+vCV6Vh9PkH?=
 =?us-ascii?Q?JmVuRow2xEDgfuj6m0ceWgxPn1DJxGyYThBxIFIKbEbupZyc3HsCRMZMDaaQ?=
 =?us-ascii?Q?FAHcE55LQQ6FeQ+/nh7sXx8xgeIgYAaW1GGdqAcxsAQyPBdkJvjga7g0i+Pp?=
 =?us-ascii?Q?CBV3VlS2SD71qMDsjGFb3O8NurRkJtpcc9hny2nqgoA1L2ZvLah9pf3uJK3V?=
 =?us-ascii?Q?9kEy/Zqv+q4xtTo7k88CXGrt9OEtzoNY9wgUQRCR3eoGvFpXYjZn7tu9jbyI?=
 =?us-ascii?Q?VO2XKbLsIqGlWJ/5VdXrkQnSyh7eTioISSSpWWnJLcaUTDBYnTgRrHadXaX0?=
 =?us-ascii?Q?CZjmmN1l74FoZSAm5nYzBk7JIA8kiXWxpF3FxDDVJJJB5AJJw7xQaGT/u9Fr?=
 =?us-ascii?Q?dJPTgyS7a/jh9mq0Z0WvleECweMCT7DkthxMnFtILBTJOZ6eiid6BI3Gr54z?=
 =?us-ascii?Q?MID+SbvIEf19PgiGQrIXTDNXAjKskGW57qoNJ6YR0sS7rT52u/IUwgD6e8wu?=
 =?us-ascii?Q?8ET7gtUstrSioCcSLl44TOo9i/sIXBHXo3MZScWxYUWablQgBWR4KViU1rWa?=
 =?us-ascii?Q?HvNq27B6G7TKjpmpq4Lfn9yTlyNXIKt5qiBWeIXFkBbRfJtqXmetXRrDHeiq?=
 =?us-ascii?Q?bTzZ4hrzJTi2tBifLj4N5pNPfJ15KOET7ejSBhMiO9lsnILOg8pYS5I6X/A5?=
 =?us-ascii?Q?Tef2irdfhr0ZE9oiENaZJrapU1Q6E8RuSGc7DVWH5r8SqafMqNoesiCBuP+w?=
 =?us-ascii?Q?4FzPi/Pq1J1JlpvuR7MsPlWvK88u+BObSYNfaXIkUDiJjbi08/p/kEQ8b2jD?=
 =?us-ascii?Q?HSYu3BLvnruhb/EOJ9ng8nXg5MfZ4vcg2BjAuB75FQ6BxqIryXvcvbTcD8mQ?=
 =?us-ascii?Q?F/a6EYxXxtB8cHGY3s6P6zcvD4xGCalRbK5wm2bk+R8emALb+hDak1Kbt0J+?=
 =?us-ascii?Q?/xFJbV6DeQIWgGHqQnG8LLCssS5DYC8yTQwIIBqf/9Jqj/YMFzFbU+uDJTEO?=
 =?us-ascii?Q?oBSerOj6s80/woWYa/DzpIuFC9RIwSC0oyAtM7+e1HWeogz/MJULTU9a8CEh?=
 =?us-ascii?Q?5wrRB3hwF+VsDg7HuYfMjiYobRjI0qV6E62n9Gm1fj17+MGew9Rxw8vKrS8S?=
 =?us-ascii?Q?SzbYXX95aM2Vgu4mkQPTD2U05E+tDDIOnKkO6Pus2M8ZECvLu+b+tM4u6fve?=
 =?us-ascii?Q?ioGJIaIKEr3vDs4+9OsOeIMRKfTL4+eYggFfPmQgsKSUH/vbtN0sA2Z3Fz/G?=
 =?us-ascii?Q?h01c6nEv6sojtN9RxUUk9EKbFe2rLMA8HypfIVHNZLWk/yvQpu81jnNaDruX?=
 =?us-ascii?Q?2AiHHHd6T33ZaavyoQ8JEPs9kGoaMS9oCW+0OGcRNTcdmdT70Kb2vMZtN3NG?=
 =?us-ascii?Q?kUPfrwoquGORMe00OY+8F0QuO7wlcjmC7Xt6VivMI5SP9+ymUoWN3RCuj3G9?=
 =?us-ascii?Q?GtiDnLMu7LU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4eNWBgE7BKh+6iYi/DAUoWTozE8nBPCcy8IdxlEtk7kXXhThFOl5gsq5LCD?=
 =?us-ascii?Q?RdLoRrm9SfUBdV5fs5mwaRFYYc2PhoebzjGZ9S1LlYg9vnJ2wYXezkjVQMqe?=
 =?us-ascii?Q?5JuwN69DtEtpNY/NzGSDodFcddaNnwMt/5lYzk/DbDWHvAvmfVUwJnrKAoHZ?=
 =?us-ascii?Q?/FvOOWoLzjLcw9OWrCjEW2y1oB8aWCGGYeszKrLcs1XoA8LIRjBkTQi/X4WV?=
 =?us-ascii?Q?yrXj+fxC+FoFs8gpBjQoDhde1Uxsx/eBl6JMj1yRBN/H3DyoygABZ+R6XUJy?=
 =?us-ascii?Q?vVbv4KpqdrJH0ASv59RXRbflZgeC9BZdf5H4qUOuYYiJPigFeuCRW4Oqgbs/?=
 =?us-ascii?Q?4PB5wKdUMzVNVn5SZsWxFL+TshpeVOE98ODfmNw9iR06/85w2pSTmg10W44x?=
 =?us-ascii?Q?zZsqW+BYae5lMuc5ccNSnfIvyBG2/oWnKDFv9xBIb1n202QYePgBjpzFngFs?=
 =?us-ascii?Q?JbKOaT8C6EcNMYgRtumQ0CgCxTU2TfbiUsJCujEDuBuAgI1VoMeA2Ryy88NJ?=
 =?us-ascii?Q?wXFTSFEUtKCG8rByiM3iWCU7x/rEthFpSFUZ2hS8G1niJB0UBEddMSRTYFE+?=
 =?us-ascii?Q?dO2luScgccSNkIZHRxHIgU0wx53Rg91jk1RVI3Nu+PxehJRSek0rqCg4W1pA?=
 =?us-ascii?Q?FA/PwaAEgx37ucfCSVeTEyTv+ciCWldhkLI49jroa/fthu7bnv2OpsgyKOIt?=
 =?us-ascii?Q?x03HuLoAyNRyuvvjoboPA/54XONHEpe0RFwRYC8BgZUCP3FfJTx9OMsE62+D?=
 =?us-ascii?Q?o8qUZTD84uYLk+zQZwvzOplv2epwIsuS2b78FbXdJtgigMuHCCXba+8yGSz5?=
 =?us-ascii?Q?evnDmU8quCTz1Bll6DTomKl+ayp8MA2jp7xiaH6o7O1+y69nHqkPsFnGcoJA?=
 =?us-ascii?Q?F2tCVoIxFv7bCdupzfdt7T77Bwi2I8Z6ME5r7LqMPDPrd7+EixVRScIRgsae?=
 =?us-ascii?Q?YV6aKYvcKTW2/3/1weqvXHECA7VpAFgM4eP+LmYU3fJbyLcj5VbG+/qNS3yo?=
 =?us-ascii?Q?goWL7TPjd50FtBsOEUWwpSAOpteoC5Y00jmDDs//uNpiBkFwrSWEkdW8SzwU?=
 =?us-ascii?Q?AHQmvqM5452D3Py0Lrde+QOe5vAR1sotLz0YWrlb/uCiLaMzuegn0HL3kVFy?=
 =?us-ascii?Q?0G/bPyob5Zvkdx4aXYLRF/ogjQMgekb0Q119YxdEoy7cQPpqh55R0lsVxL33?=
 =?us-ascii?Q?RYdTS/ANjzlzdNS2ojeUyjInILuI1BkzHT4eLa8uETxrbryDMCyevp1STwSG?=
 =?us-ascii?Q?eONnJTY46ygZuCe1/BFvBTVTVokAZffZ4usvijh4VWhlLqBcJuJpLzBUgu4G?=
 =?us-ascii?Q?Y7ujfCEEL4bhLwJ/snCPiZ2dXQV/mBePjxuqL/YOKuHCok3u8KwiTzT7jdVo?=
 =?us-ascii?Q?4rQAtaNLj1w3BQyIubuQKLusaMPs/4gQV2HEfxO6rvdaY2ZP2ZVb/tQdhvHg?=
 =?us-ascii?Q?WUT3YDb3D5NvbT9l7Vaqb/MHMrWqMdIjcbOUlRWUyOnKkgtTNbHODLEZrcSR?=
 =?us-ascii?Q?j080qI/onmMN8xz5KlDuLs+ifKpzVIsa6WBQkWKFP4C2rdyxZZiIxdS3Xntw?=
 =?us-ascii?Q?/wP47QAQEFBU5iYm+4aGHTdVgVGYDeRUd4lQ0F6ArsD5OSpIujgyU25K+1fW?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p99cu1AYEgJ2sv2OcEIFjD9+3hfW2dpG8tTlwH5F2v/wCv3zVkDNOXaHgYzAVoEv/XhzDUVYVt3lWC7Q/J4Uz25yJXB3FsAAPJo6KD+3X1WLjjlSGCfqAyWmDuLOk2ctPvhWJApvQB9KIl9TsrK26VTupjiUEvz7C3TRj6uJpiwoHe8pnbtCn30K4yFwfxiKKdg32ml89yp0L3T4//Z81dSk+pmCtHTSYEnYMvJbkKfFjtrg/xhc/B4SeqEUUJXdA3/1zfKBgoqsFep3EA7qQznectjyu+PUfpfKjv+JubyEMk5i/+KXsE0C246a64HTdOHejY12J+SRbBqtpOfpbUehL1b+hQfezCVcqas0gEsg0TYlYlyhkNDJVOFuDM5IctjDSgrM3i28QvX/eKPZDUWD2AgWiXsFdWMLOY4FLIol1U2QGL9gFFHIcctwh4ag+jqn56kXqC9euVgfVK4XiQSOSFWr8NDUDaWLXvrS8rNMmV5f5vdEPsw783bdFRUnPAMlwD9pawk8ntIKUODbvpQbrewUYbH/4VGwsy0pgeFjQFc4UEdK+4ultV+EHZ1JweeeYcD78BGV1EAE2cTSnVcrD786MzX6h0BGcVZD7+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df7cd63-7a8c-4d2c-ad98-08dda1f71a1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 17:01:22.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09UXDfescAYyaFmM6MrH6YhelZMPinUCyVI49XNODQ6ZWQZR4xSZt/2Bm6n+65Iq3GJNOOTMSyd70InQHBGhBFwK2+kBa0YI+Mm5+uK1rTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEzOCBTYWx0ZWRfXzOriS6O7+5Sq eFsZLsthpDAAqjOZcMZY89mTjHdDA4sA5hyb3Pj93aOxYYnulbJsVr3C5cbWnr3FqArbgZnI4Hh 3wr29rUW71gpwRj+Gg1v2yvoR1nR/KfSRPCU3ZGTqX4vWMXMQc0d9k6Fzw7/9eckvK/CQxFpo5e
 A/iz8kZaP7ye3FVuhgyumCyRjC0H9p1HvE88zRDWMK4QJh/3woiNWjDVRbNeEi3veyuX93HhsDg ClY37XeDcAgmGSY21Nd5aVHtF7GI0Jf69PlArtpFCsGnCFl26BdN1CUwauf/ClQFx4THHnal/C2 HIOZLqbzf6uyQpYZNdaUwZ9yHwT4kOjX+VlwhFIP1IR1OuMKMoJxcl+QjaBK+bbhY4iv2im/eDX
 HrYOp97FEAY5zibp5aMkwdSIH6h2HDgAhRD+FqlfzkYyLzW1j4DmQ6q8oHTCw/e2mAcNwt0r
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=683dd8e8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JKzNtrQx2KmTOcwNqaUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: RBeii5_5vapF85TCxdsYOB8ktqI7jxXS
X-Proofpoint-ORIG-GUID: RBeii5_5vapF85TCxdsYOB8ktqI7jxXS

On Mon, Jun 02, 2025 at 06:28:58PM +0200, David Hildenbrand wrote:
> On 02.06.25 15:26, Lorenzo Stoakes wrote:
> > On Mon, Jun 02, 2025 at 02:26:21PM +0200, David Hildenbrand wrote:
> > > On 02.06.25 13:55, Lorenzo Stoakes wrote:
> > > > On Fri, May 30, 2025 at 08:51:14PM +0200, David Hildenbrand wrote:
> > > > > >     	if (vp->remove) {
> > > > > > @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> > > > > >     		faulted_in_anon_vma = false;
> > > > > >     	}
> > > > > > +	/*
> > > > > > +	 * If the VMA we are copying might contain a uprobe PTE, ensure
> > > > > > +	 * that we do not establish one upon merge. Otherwise, when mremap()
> > > > > > +	 * moves page tables, it will orphan the newly created PTE.
> > > > > > +	 */
> > > > > > +	if (vma->vm_file)
> > > > > > +		vmg.skip_vma_uprobe = true;
> > > > > > +
> > > > >
> > > > > Assuming we extend the VMA on the way (not merge), would we handle that
> > > > > properly?
> > > > >
> > > > > Or is that not possible on this code path or already broken either way?
> > > >
> > > > I'm not sure in what context you mean expand, vma_merge_new_range() calls
> > > > vma_expand() so we call an expand a merge here, and this flag will be
> > > > obeyed.
> > >
> > > Essentially, an mremap() that grows an existing mapping while moving it.
> > >
> > > Assume we have
> > >
> > > [ VMA 0 ] [ VMA X]
> > >
> > > And want to grow VMA 0 by 1 page.
> > >
> > > We cannot grow in-place, so we'll have to copy VMA 0 to another VMA, and
> > > while at it, expand it by 1 page.
> > >
> > > expand_vma()->move_vma()->copy_vma_and_data()->copy_vma()
> >
> > OK so in that case you'd not have a merge at all, you'd have a new VMA and all
> > would be well and beautiful :) or I mean hopefully. Maybe?
>
> I'm really not sure. :)
>
> Could there be some very odd cases like
>
> [VMA 0 ][ VMA 1 ][ VMA X]
>
> and when we mremap() [ VMA 1 ] to grow, we would place it before [VMA 0 ],
> and just by pure lick end up merging with that if the ranges match?

When we invoke copy_vma() we pass vrm->new_addr and vrm->new_len so this would
trigger a merge and the correct uprobe handling.

Since we just don't trigger the breakpoint install in this situation, we'd
correctly move over the breakpoint to the right position, and overwrite anything
we expanded into.

I do want to do a mremap doc actually to cover all the weird cases, because
there's some weird stuff in there and it's worth covering off stuff for users
and stuff for kernel people :)

>
> We're in the corner cases now, ... so this might not be relevant. But I hope
> we can clean up that uprobe mmap call later ...

Yeah with this initial fix in we can obviously revisit as needed!

>
> >
> > >
> > >
> > > But maybe I'm getting lost in the code. (e.g., expand_vma() vs. vma_expand()
> > > ... confusing :) )
> >
> > Yeah I think Liam or somebody else called me out for this :P I mean it's
> > accurate naming in mremap.c but that's kinda in the context of the mremap.
> >
> > For VMA merging vma_expand() is used generally for a new VMA, since you're
> > always expanding into the gap, but because we all did terrible things in past
> > lives also called by relocate_vma_down() which is a kinda-hack for initial stack
> > relocation on initial process setup.
> >
> > It maybe needs renaming... But expand kinda accurately describes what's going on
> > just semi-overloaded vs. mremap() now :>)
> >
> > VMA merge code now at least readable enough that you can pick up on the various
> > oddnesses clearly :P
>
> :)
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

