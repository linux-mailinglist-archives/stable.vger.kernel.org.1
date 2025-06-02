Return-Path: <stable+bounces-148943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA7ACADAC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA50196047A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8B202978;
	Mon,  2 Jun 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LxyaN/1n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fr8IxjCZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A614F70;
	Mon,  2 Jun 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865371; cv=fail; b=rKpeUj2E+R5GEGHX+1xGXNEYbOXypRg48rZm6GKyg+MB2udy4emZAKjM4jDp87EHgUOaJeCixQgjQMe5xgFec9BRa190h/seKhqKRtb0zBvbv5/cHEfxspemKrXwktvUpcrH2bYn1fQb5sw+IwT2R8QsmdazkVU2u5yvP6uqf1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865371; c=relaxed/simple;
	bh=ZwT00Tiq9rdXaW61nOhJIKIu3Pxstpk/ESd5phIHp/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qCzTCfBnfLM/qbMCTGZ7mSNLMTrCEsJ+gmYQiQuSPglaOYTOdbje3QTgz/wurUGhQPJkCwwjKS2DSon5JYMu2147rxfsqruFEL6k0oSPyAY8RZx83nl6NSZWBs/FC6xsp9eIsB/1QmaXpEhdcpVtr9uv/R3VE41JV4KljxJclN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LxyaN/1n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fr8IxjCZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525uXMk010038;
	Mon, 2 Jun 2025 11:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9NbxicMWCj/FN3UxhI
	/LnQSt+IGpD8BURSwbuQTWIkU=; b=LxyaN/1nyQB2swDz/HoyT5IvKbZEOeqCoH
	edt87kDwhMMotM5FZKEmQOOpDotiNjNeO90DfYgxfSP+J+XQRQfyTH4+oqanRXx9
	Qv9j93RDRwKwp5FNKXZGpLsS9jvZqnUURVINvIh/Ef66prGurnQb48SEO1lItwVo
	JdN69Gxr3IrEUNeatHv8srNau4B7j9SdpiOh00YOif9wNrkmY7+BGAYO1+EeRP7U
	JEX+YaZ/08C4u64+jueZB6EkBQrSTfYnYEXIFFQ8fmykk7b1KbrOr7+PsrG6jcVL
	lzNyvWHGFgSaoOhYVNo56uKsjVyGk/xmfi5A5S4uQy/BDFvSGdBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrpe2fgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:55:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529iFDV040646;
	Mon, 2 Jun 2025 11:55:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr784p2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lsqm89mehkmL1wSBk42JCQ7PjGane4bGNSjgWd1MTIHU4tN+MK8g+EemWFHJCb1ON6zbYRu/JxUJpU3RrcKU3W36K4+OYdPgFLOogBzmSwxxUBx4r+jN9INq1vo7oXcRnujLIZLgYVVtax9aSJvC9pcSGuhImC3eF2rU+QmwRNn6kgiwneTPt0vMD5H0udWd0PDdUrsRx1KZAzNOHOLjqmXBul8/LI2s25if439RaECq5NvKo8kz0iWRDE1KYG5WrX0E3leApfuutZdqqM6W/Tc/Y1Y4NsQz4+WcG8r4QoQ1hwpyelIZ6k9Eh6DkafVZWicRFuoBY1UQbHMkmuw77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NbxicMWCj/FN3UxhI/LnQSt+IGpD8BURSwbuQTWIkU=;
 b=YOXetqoa0kocOvHjvzjGJSGEBgRr3HjhTQTqWWhM7scQInJCTIwwNp+MtzL/RpE3yq/NpJro5DutGEf30xqcNr1kYey/UwTpshiWz6rj+YKtcpf+EupshgSKb7TA+6HrmAgsm8cM6SwmtAuvwrtFIevHOqA/mKgo+hsg9PQZZqeE+Tu45dD62SUxk2dxXF4vd7n4+Oc2KIs4dlfJoKhgFf8gBfc0uyoiH7Z5UEP5RmjBnRz6mwkebPzhFPTi1uxwArUOE9pwf0HT4HWanqy5pqjqQkl79Dt33ruOB61ajTAoE7V9KM0+35/2zuQV7Mi1TPgcSVO7p1qCe+m6gQ4M3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NbxicMWCj/FN3UxhI/LnQSt+IGpD8BURSwbuQTWIkU=;
 b=fr8IxjCZ3y8dZ9KGz/xyf4BZeEK4pRWlVFGhgIy6cK2wAZnpiLciPMZ20DFHt25F5bGRJPsQ5+FyBcRWHRVZznPs4Z1oCaSvbQJIxfb6HcyTWYjT4zXCgWsV6apX04ANumhcTNaNvVIC1onTArXANlSVMQzekwgHkhs9YAEESwY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7727.namprd10.prod.outlook.com (2603:10b6:408:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 11:55:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 11:55:32 +0000
Date: Mon, 2 Jun 2025 12:55:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
Message-ID: <009fe1d5-9d98-45f1-89f0-04e2ee8f0ade@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
 <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
X-ClientProxiedBy: AS4P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: c02e2140-8065-420d-4561-08dda1cc6082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOoAOfBqf9X03rkzj2FjBrKN2+kl9jl0wmlxT4WDypBkHXyDCRFGwGRdZ1iN?=
 =?us-ascii?Q?3VVxU3QZ5ISq2C/RjmyyyS4s94B6/XROHIThCjwSeYHQw0cBjxiX3oWb4isV?=
 =?us-ascii?Q?I0itCMi6nZeGZ4QT/zM1vtMl2zCeO7ulVsM8U3wYfEcjbX9ywSGLw4/KlkyV?=
 =?us-ascii?Q?9YW+fQKyM1gT32dnliyW1LYgPMfO49ul+GbcmXcYJ2JftSYy/iAsJ2y5pFzb?=
 =?us-ascii?Q?z/Rl3zq09JSI9GAOjoSH/Qv2+phZP++SypgHusQXqlX3Zv4rzdrQPYuWMP66?=
 =?us-ascii?Q?XpoTYbr3zIKW5VTpuIoMpmSphRhtgUon0YbXvaAZPjAEwFGPlWFLTdYOMXB5?=
 =?us-ascii?Q?Xzki7O5hfOuXVtc1ED/Zu63Qs+jcnGP9CIZjaZL6KoLOIsCuo+Bit3q8XBA8?=
 =?us-ascii?Q?f05js8rlnprOqNVCSuouUhGH7xl+uQ6ynBDNf+vQhKMBcsDEytLBPZKf3vXA?=
 =?us-ascii?Q?fCGTtov1TMLtiKYQXdReGlufX05ov1CuY9IrZG+mcI72rA5dMtO1tluwJJtY?=
 =?us-ascii?Q?Dx6IhlnkV69b1WtuNE35Uk3So14kneAO8WxVmF62G565TsRop3pyTMDtZSQG?=
 =?us-ascii?Q?vKAe7KFK94GrAJz9tNkDgOEPR0VLyfyGOBX6l6hrbao89ONGQBt1/Lojusnz?=
 =?us-ascii?Q?1i9o3O9M8kgXgXzE99MFSPNLkVmmsaSn6WVycCaNQmtJQw2rFpV7lh9H+2cd?=
 =?us-ascii?Q?ZtGS9nC2c4sWPS6+meoO6+pcDlpecLAwp6j8AiB7onbSjWVig5f4fnTUQFYo?=
 =?us-ascii?Q?y8TnDZLrWJkzGyrh2Yt2MifGotORX4xPtWnT3vp+4AXZ3v/zGkaGEVpsn/l0?=
 =?us-ascii?Q?dj+tNjVOXY5FQA/u/4BUEf9TAAVS4m8zU3FKdCSE6QPQ8bf9WxPuOf9vDzUb?=
 =?us-ascii?Q?FhGURgQCsluBE4HZFtgcvtbEGrElDb5c70UHaifWWM2bpu2yYvzTdhb4P97u?=
 =?us-ascii?Q?jf3v8Zzd4gHR8TUSk+JCycVCaCvu3DExREK6KTIIIPMtEx04AV8KLs72sJ6u?=
 =?us-ascii?Q?8Y0jYO/UkrS6Fx9Zwrjrfgw8YnNAZe2A4KeWBBmKptl0kjaq2rrNnGNgsk9n?=
 =?us-ascii?Q?jbv+4HwkHdU5QJ1EV4GcEsbg3BujHGf1Pxk6Y5hVMAaIZsosb5i5T6EgAJmI?=
 =?us-ascii?Q?FTALRN1qT9gbfNz6ANb+aKqJLE5WZK+D0InvoYIJ2M045WJCbbE+ClZk2dm+?=
 =?us-ascii?Q?JnnYYyOND0qhyMV95OZIooGRiGGwdCPukjLeJUFiXNdvyPYtyHP2hzudx2nh?=
 =?us-ascii?Q?7oHou1DreUF6s59uULNb+MRBS0F9gUxNbzcDlYa/t6XCtPtunwFRlVCjZYb6?=
 =?us-ascii?Q?3aKqAdg7AbCRz4dNbtlSk3dNlBdriNl555rPzZ3zCOfz5YikIiaBQ1lO6JhP?=
 =?us-ascii?Q?hH3clieisibZH2eYcB23HAilvhF3JkfjZNqcDKadKd2OA9jhdWy+8UCygWhw?=
 =?us-ascii?Q?zph9ZIdffd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkamcRoiwzhKi0CE8ox2LrO79bgdEPgsJFlitrVZ2fgw7/LR9Rwwnvn/7dt+?=
 =?us-ascii?Q?wbazGaXNGHEGCv4wsERsBYomdg/QE9JroqDhxeMKr0czj8XKWq2yLRaK3SGD?=
 =?us-ascii?Q?Xmi+V4Bnm0v8ScP+wQJ8K8DlF/QagPTsmtv34IL4QsKS9hE04MvXYA1B7rtR?=
 =?us-ascii?Q?LV60xnCTaePDMEnWpr9qeOpkvhMiRsoqqwGSQNMeuHemVC8kPzjcdpJsr707?=
 =?us-ascii?Q?zE35TNdb+z7zJjMFKGtxfNgMrv1EjJ7WYC0nRKD5zR27Rr9oHmhzeeCNiYes?=
 =?us-ascii?Q?MBk4x1SYCmmSiN0KgGzJ0r9TKI4nwxxAVvKDQdxg3O8tfa5Dxd53w0MQ/cEV?=
 =?us-ascii?Q?l9zc/Kgr+j5sR379/lR2XWOUp+T5qGgMHKXLsM+PYAPfmmXVBf86pbJwLS+c?=
 =?us-ascii?Q?3v9MIoxTta/lWLkquQHp0p/CRrCwF1mwKm/chOBqH0TUzv4RNgNeFhxCha5V?=
 =?us-ascii?Q?Qye1ojZKUoINav+cgA95kzdrsBtptjjHDkkq9q6P2YPyFy+IUNqhzeEQrtrN?=
 =?us-ascii?Q?BV/mHd4pfySPobjgTPL2k0Wl8sx/ZKowZKbAQ7b6D70mFUzeXlBpwsbFVfwm?=
 =?us-ascii?Q?6eTSm4DC18aXCUU8M3kW5KjesEs4+5wpqEaX7zCwBGjWiFcsuJ8RqFmPDqM4?=
 =?us-ascii?Q?JeOBDsxzGrnVllCLaSqLcl7Z1U6+duyZYJXqUnGhpouqAUXviLi8EN1A4YOG?=
 =?us-ascii?Q?Z/P13PCqXPT/mUqxmjJguz47/bqNr62P0U2NwJTZ+KvGqPLPidVc+qDxaE9V?=
 =?us-ascii?Q?9c+zLr4D9QyDyeWoPCGZWHIy4gIVFBl/XPDbxFozP8bPkErFQzcySdyxMA93?=
 =?us-ascii?Q?/u7zWvfcNyTJoFwo16kG05txfP4QE318J6aLaucY7net7cfvsRqeBDJzpvF0?=
 =?us-ascii?Q?2bfzZrqT2hxPrxuBM76hB+JDKfUxWeQ3RSc4Qp3XsIN8JY+6nwTD0omlrdyS?=
 =?us-ascii?Q?qb9AZ0R4ba1WUkx16cCJHOKOdx22YTmG+FXQKoDrb9fFY0fJTbjfcZ0xkrvT?=
 =?us-ascii?Q?fOmaMgh0EzKZy5cGpRH/7k96UB0TETS+TgsVn94BwB1egTLjAIIqrV/9dNRT?=
 =?us-ascii?Q?b+RuDxkZEEzNXeZfGFA5DYzUNUwfDKNrkEoN1MOnXUKMY/Y4WLiNCfI9e4jf?=
 =?us-ascii?Q?0b0h8pfUsPucBCAa0MXnQh+kO5sA+3FnXyGskqDi5GvzJlsQq1M6fdr6d4a5?=
 =?us-ascii?Q?W34UUB9/jKO3WGt9PC/ezgnzaJCvr4DZ0nU5BCgV25HQWg2sYGLh6J7PG2j8?=
 =?us-ascii?Q?5iAgeoW0KXCsdzoZ1ubVhg1EF1M5WbfKsESIXpHKOpAHGi07ibHqr6v4bcW6?=
 =?us-ascii?Q?69C+3bhajJCfXEEJBE4OypZveN1sFUNRK0AOBlc46Uey5U2TfwGUQ5LfdFtj?=
 =?us-ascii?Q?NdQ3aCyOur3aD+MLE8XDrPtUCLCTQlLvR0X4jpnhNE415Zn9LugLEyCmWLhy?=
 =?us-ascii?Q?cmRXQDmMqO0ZYN7sRGR4h8A+LI7ZX1xyrO0DtP57I7W8/F1o2HPQ+KECIo21?=
 =?us-ascii?Q?MGDTTnBRuYEUcHdfBIdD1I4EVnWRqm08zKn1m5B2jkg3kfVIT7SWaVldAwLD?=
 =?us-ascii?Q?VVx5c7UViRoleWsuQBMN0QiSLrbIiX5vzR+qBoo19NGxMurFnD5g9L05P1Jh?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l4a/hM3GUHwHF6OFNM36uryrNu70zw27813ewpuRF3JWJ709/lAdLo0wZ60PGEkRBhrxPWWZvCBHM+krKqjNZzm6kOqJLxsPrUwXkqpJt62qvtXORGrzKzh0O4GM69HUZnvr+kePs6Amr3z/IBQyRRJmtPFc73oZuNDI8zrkn2rMQr3CrKdMpMgD56AW6ms5a6o9bVorgA212b+ZlCtBzxTcFvQCWs7yTQNTMA03HLFTJKixgI17pWBJOSMgVhnR86oNjMAL0SN+q5fdeqhh4PUT0wmKl5FppIG9dk9nSRxwyEDqfWlBZmXln9Be5t44C4H3OuDinZedT3I2O2LLG2hNiRbA9yoYAZ3YQfenx2921YERhOl/hVx4RA6o3TLIagZLI3VELu3dRUCCytz1CW/WH+Wp6hN6N2PmKLs+GcS36WTLaS5vuKAolmdxObDt8ZDgRilI0ZwLFywxFL5boi9iUwwTgqNw4kpVopD/6bsmInsNE4tiVuJTU89nz6F9/X+o+R9OKLmxw8Oed5BvRpqZU/i70isJGz0czrsagBQDdvVPZJQt4Owgs0Dx3wm32XOZJSip7s6B1UDvmCqdFQmTUnd0Z7/Mstre74AkwHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02e2140-8065-420d-4561-08dda1cc6082
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:55:32.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02tiTZ0j6bbUUpLPZRNAaE/Vn/BOuzMOvuQ0NxzBVjs2/O4eUWaLukYyXp5LCezjK9djV0Ds35kuGPPK5Ubjfk0P9XjGnFry5v8jJJhgkCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMiBTYWx0ZWRfX6dtR1fGt2KcI vmEpbPmuw3TCYMSVZ1XUmQfgq8oYSTwlqSlDDr+leqRDn/TBujeqM1/glOvsQ3xIgcc3xo4Rt8j 1Xn+8aRo3a/qT4sDF+Mgqb/B/WuOoofinCOsd0ztK4fVq63gKFDCN7KCQ+vKrMiENGu/bNDjerr
 GD5n+C0XGa6QrSNhnpADdh8Qox3HWm8k55/XAmCZ9psF7dUZZUdU+AEkQX3iOGXjYQ8xNOskk5e 97RoEdJVzZZ7P+wTISfXd7JMa31iOPiKdNjEDdo98CNFToKV8VOhsptjm1+iWinO++YNbPCsEoN fLglJQuDm42ZXmw7s4KemsX/oC4dOPzBjLBXzG3P8EUODkiIdi42YjNnV1oLapOLGASnrSNGKfc
 nxNwiSrXFdr5ScOBUGSoMU6UdGD4PyjRUowNHO2NWGAiyS7LGgPZbEknAzhNXlZmnjg+WVYw
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=683d9137 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=7eMUWuoGsCo3STKGuYMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: 1Vr_r6nCyt9vZI4jbpgjXdYvgXeXlwTU
X-Proofpoint-ORIG-GUID: 1Vr_r6nCyt9vZI4jbpgjXdYvgXeXlwTU

On Fri, May 30, 2025 at 08:51:14PM +0200, David Hildenbrand wrote:
> >   	if (vp->remove) {
> > @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >   		faulted_in_anon_vma = false;
> >   	}
> > +	/*
> > +	 * If the VMA we are copying might contain a uprobe PTE, ensure
> > +	 * that we do not establish one upon merge. Otherwise, when mremap()
> > +	 * moves page tables, it will orphan the newly created PTE.
> > +	 */
> > +	if (vma->vm_file)
> > +		vmg.skip_vma_uprobe = true;
> > +
>
> Assuming we extend the VMA on the way (not merge), would we handle that
> properly?
>
> Or is that not possible on this code path or already broken either way?

I'm not sure in what context you mean expand, vma_merge_new_range() calls
vma_expand() so we call an expand a merge here, and this flag will be
obeyed.

vma_merge_new_range() -> vma_expand() -> commit_merge() -> vma_complete()
will ensure expected behaviour.

>
> --
> Cheers,
>
> David / dhildenb
>

