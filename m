Return-Path: <stable+bounces-113978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF34AA29BFF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FEA169164
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F0215057;
	Wed,  5 Feb 2025 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gcadC6X7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Azfh+vna"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839C215040;
	Wed,  5 Feb 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791662; cv=fail; b=ZeAZPzVucOu/KJulnv5fDtQc0YmEui6k3HKf6Ld8R4VwiFQ5vN3A1z/VT3yfNBgc9zU73Xq4iQC5jYra0pDAyKatncwuHOeVm4tB0k3tLKwQXGjgv/rtZ5fY1v2J0aR3E/M1i1wlpszmf0h+2Co7FVgt5P7MsyK6qj1sXMFVVWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791662; c=relaxed/simple;
	bh=Yf2DLiFiG+m8JpwpDGjrreB4hXhYcna+pRzccYqh4wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaxILIuCPYP3vYnfrc/CFZeOYAL/QnxMBv0ffW5md6TMbCShZF6GO+3Z2PPMR/Y/ZTbX/neMJ2UA/o99zz1A6h3tn8lBzgd9YZZiTppnmPR34mBi+BEAhrBuKJaccnDdwHgR8v7QGNNjwiHZ2qJtFuLLZwiwiL2NYET/JbJKyos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gcadC6X7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Azfh+vna; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfiHK009534;
	Wed, 5 Feb 2025 21:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hJWZu/Alby/JS54V8ExVLbHchCmkeUTw9IwU6u0PuIw=; b=
	gcadC6X768eVnh3g930jFBcyGJKauGcE0B8iwGaaHOyN622luTqDbtSQAVJn8AOd
	W/40Zm71DceCaKbpnPy9CkgUGegAdasiclC6EytMIkOJIDixg5NJ8rkyq/D1Bimw
	Rv8en5vOa+oVfs3Y5fNcLKbiMzNyQZLv7frQJKlQrPLFhbUxTyuEyJoQbiaIaCQu
	/plqlrE50lxxwv5Sq/sxvWtCLlmj0oz4Amqx1HTY97blhY3aStzphvx+HtlhXJrv
	WvGYArTiuBjOU65FTc6QXmhhgtoSJhKw5l8yWYvGkb9byOe4AAla1E5wz50dtEAB
	mND8tUYPA+YVKTIPa/aBOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ubdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JwUUu023519;
	Wed, 5 Feb 2025 21:40:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gjwetv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av5Z5bQwwqx009k84i4UvamGkmiza2tlWbzg1p1rodHN68hfAeyYH2zrx37Mmup1o+YmOPLN3dABxGz0ChUzTx2C+PwzK2s7gESyJSasGpFdSoAvwZk4DhDfsiJIflly+q41lIBQdjQztLFS1CgonkvnocghMeq4KahuuTBVN8WQ1CExaPchHOMoXm+uXusACoR1lHret2NPrev7rbgnxbLB/pg2yRywTwXHo4rmlHxUGHhAntV6luV2b2m9+hamLtcnQlO/qUagANKX92RXtw7udlt3MkLCXw1J9QeJC88uwLhtIs6Rw3QKiA5aCngJa5YOlCosyzkMCEz6gIVJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJWZu/Alby/JS54V8ExVLbHchCmkeUTw9IwU6u0PuIw=;
 b=C6iCu1IWlV++U12WbOL+rLAcoPNpdtlbK5ndZNkdFj5XES3Swj2hi9BAp+2Xd6fRiAmtyuG2eLX2Af7bQloc8NkVq7MXbquZi7WVBHq3+FYgs5cLfEDxMqNcf9CpjU3fqwCj7H4V3w5HF8YNdAtwle+k8igq8/oDBcqHauFybYLTgZdE9kdwEbp+RvRAULTEgUoYgwLDB1EOaA02VIIsoIn/nJ7RGf3zhomC8fKqT+qwHaHSI4g1c5OXC0vh7iyeIizKOqjZIXF+vIgSkNcdM6yUKW2ir6X6JwyPqYr6036Y8/AIAqc45dLVUXTrL+KPKIOCNrP6Udj4w8ZO2MGjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJWZu/Alby/JS54V8ExVLbHchCmkeUTw9IwU6u0PuIw=;
 b=Azfh+vnahwydX44RZqDo7QIz3OS3buur7fEXauZvlAZLJsLaXcqpeEDoGbBsYt7L2lEquh4NJnpErx+MKOO9eRfTPvyrlzwRkeFKuN5/Qb3wTZxGmSnxOEBZiLiYLqgrO7JTY3RcRh1BLTW2v4i+XCCxUeu5ecRpDB620zusUWQ=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:55 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:55 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 12/24] xfs: don't ifdef around the exact minlen allocations
Date: Wed,  5 Feb 2025 13:40:13 -0800
Message-Id: <20250205214025.72516-13-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba184f5-7c5a-4910-a3c0-08dd462dc4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5k5FFiuG+PO2qE+2otsmvsOw8eC3xn1VdhMvXrFjq86pPrqptrKdC+7iful?=
 =?us-ascii?Q?MrdmWmDrwsyTCOZCHwx8UJoOxIJU4uiHt1q99lZ7oEscDQ6tnfRR4vPw5cAh?=
 =?us-ascii?Q?O/Tv0uFwh4yDPqXpYMhHON/qtR/7wrlsHW/bsJFhATF5XM8JXEBGx5F/FouR?=
 =?us-ascii?Q?qqbJw7Tm2LsxKrKftKknINxMCINCBLLUHiAQ/o0DE7Y0ShpSN82GwXopDaRP?=
 =?us-ascii?Q?dX1aOht/74CswwPu6mi96zGoZFko9K/bt9oIAvIKuLougMDmAJiNS8dIElIV?=
 =?us-ascii?Q?evdcW4BuYYawAntkCTrStg5adQhLCpQGLTraMVr+WJnlCu+ot2V6U7u48UUC?=
 =?us-ascii?Q?ufOqGlqnnGz9F+zjLCmBp38DR4yb7ebXoOhi9pPd4fMaQGZxL+DnNmbpzq2I?=
 =?us-ascii?Q?kQPhukIZODD8vSMGiE93Agbg41KLnqpAhX0d5LjgG4EhBYaErr8joPXrf1l4?=
 =?us-ascii?Q?m/hvyL9qxZFE8j8h2iadszqPum9SF9W+J5skyn6FF6XhvXhGqZx/PUqV8uoS?=
 =?us-ascii?Q?VlrTo5pnRk6yeS7puNLnJMidmMpwMg6N1EFSzrtwHlXutwAIeyUlo2IgyXb6?=
 =?us-ascii?Q?cf6WZQbRiArINwLXJH0sTAoqcr/4baS/J0IJgrscIdWKpBdvAGicFBPmEJdG?=
 =?us-ascii?Q?yPQniI7KC2byaE9BqJmXSWbiJIYeeuVVxmYsQ61OxeEB0hczMJbTZq9N/Lg1?=
 =?us-ascii?Q?JdAyMEr8jQ00ufIYFEUek6IqkYRVAr6gTJoelxV3UKGvqTAL3XKY8YwrkcGG?=
 =?us-ascii?Q?Fjd06aokYBOyHkcnsrmacwZKsdD9urLIFppsxMKRRPe3wuGs2LbZMVYG/YJx?=
 =?us-ascii?Q?1z3VC1kx0cB2luybLAjLtNVifN1+jBVK3RPAAZIvnTiKFrcaxReH2EhKMbUO?=
 =?us-ascii?Q?C2r7KE/yO2tyCyGVwm+pC+vHsOnlnPQp8NUgtcLy0UI0NG1tPOBux+gd7CDj?=
 =?us-ascii?Q?CDrNc7stFvAKjjZvi6MHPs4BfGFV93ygZ5urTY8hVO4/US6jyCkgt7+Mh2VN?=
 =?us-ascii?Q?FQPNA1hOKQKLpZCbm3qeeYgI3BfwuGRkgsLGPB+9YXQrkYHfH/lSSArJwPcx?=
 =?us-ascii?Q?5zj/CbGqStDAaj+Jez1QKvzqt5QJOpELlNi+vUbR9cYNynqMl2t+iPLfq1t7?=
 =?us-ascii?Q?etof3H64lq42uRGW5creA+/Eolu1Pvv4aRYaWALPTUO7n7Y8RrZr5cCSzlOD?=
 =?us-ascii?Q?9oEdZPqewQAScj0rFKQ4+wT5yOgsOpvJubguzkQbFnSvTZfRFz0Ty6+ZwumY?=
 =?us-ascii?Q?N8x30V6DIQDO5harF06e8WaiupgWiLxO2FFSNpl/cPcoyCORwrQjk5r5u1yh?=
 =?us-ascii?Q?nqgavhZPfnSrp9ykutgSXboBwmg3c/Ui+EzR6RKHf6pzALN0ugTdAD0TXZ7P?=
 =?us-ascii?Q?sp8+tHiaUfHCakg2CH2uvOsg7Xq/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BfHVwCsNUBG3NIf+RMwU5xizNfHZMMZTMnViwTTHb9gJEz3Vr0AnPPj2a5C?=
 =?us-ascii?Q?eoKjxLiq200Pmh1VqwbN/sJ9tsQ3d+cu2iVGokDOjdMFgzYfJQ9FcRAWV4XD?=
 =?us-ascii?Q?LT0ZudYIfZ4jgPQ+XwCaEA6ABjRJQnuvqS781eYsbaqUnOcg3V5ISaHs3nhb?=
 =?us-ascii?Q?NYGKHHLYU0KU8M4eY/RIZI3SQQcGoX2AbNWYfLJ8NiTUTzixr1qUO9WjVRxp?=
 =?us-ascii?Q?CVbn3z4ifiZD0RIR5E4m/alADexQuW05pq8e9LU3CmYr5Bx0aHuWL3emebdV?=
 =?us-ascii?Q?OliXfHki+U2UYutIR9Z2lMWbsyhdSeK8vgONeBi5q3liQdQhXq0vHs4XBLPC?=
 =?us-ascii?Q?nnHwIoJHK582t++/JQSuBX7fjgnroi18FERoNstTaCy+zPLNgZ7Hci3eYO5I?=
 =?us-ascii?Q?awM7uCeUXpuoH5FkYTjvIF1IYOEokEZfAIhgj91beg0OvemWSZlgnxqwYkSe?=
 =?us-ascii?Q?DLkNSG4w6Xsl4+NG7ar298QoKHhWlmgYHCSPfOoTPtmPvPRKmwig1rPLY8xQ?=
 =?us-ascii?Q?ueoz4i7NnNlf3zzLdQ6TmJGqK7NjRhTy6xYWmfyvy/oXOdfmM17mMAbU0r/7?=
 =?us-ascii?Q?zWu1j76JNG7U4jondc6YdsZ3k/dnQQhzxsXZvSvMoR5zApXW+wwURL1EJxuc?=
 =?us-ascii?Q?7FDnsbjU3yImDLyjeNHsD17lcXCClh/hWrQkz+eZn1UgZ1oN7p0jkOHxlXjG?=
 =?us-ascii?Q?IzW4vessO8WsfsMrB9nuDbDEmL1IlEfUmPxR//LlpRUETn5QyIXVhhU5qEI+?=
 =?us-ascii?Q?4GmEjuEfu0N2tER6xivybahWYNN7E5z7DXK33YZILHzdAe8YY7wssjWkJlWH?=
 =?us-ascii?Q?fGVI627kZ0lbxUf4heLcIIGy5fDt9ewwe4HHMCjYJE/rY7qMIsWD4weTM0Y/?=
 =?us-ascii?Q?nFtGaUwuuqpO2lq7Vaky1XnzHeiTuzBHe7nEtymf0Nw61icQx6qq2J+uw9ih?=
 =?us-ascii?Q?KkKMyfQ9f0OoSpQYdd/95gh2qyTXdjj5vOirumtk8N+8Yuo201XxFl3AfQGD?=
 =?us-ascii?Q?YQuDfM+iaRkckWfScO5+LL9OKMwFPJjzbgzEt1JNxT/U4mjfdwqtY0ehwdUb?=
 =?us-ascii?Q?jivTXLdif+1OKQAVFh3rwYj8jUVOTe/9j0IUNn7ACS7Vua4w9KOe8ozK4uxA?=
 =?us-ascii?Q?aIBtf5TFiz5ZrbBPXUnhQRqS1SIoC8Qy35cTqidL213IoutG4hpJYu7elYM8?=
 =?us-ascii?Q?kpsAVdkyO9Ei4dMJcnZ3f58d2UlPT0jVT6jhxzCrCugI+I2GKqmMAuNSz98n?=
 =?us-ascii?Q?Z6PgdBQ6MbOfxcBkV6lUvr5mNsdFAY1w+FST8A6tTPmFYlthKR34hLjlNutf?=
 =?us-ascii?Q?NGZxHmdkWA+uXbw9IuKQCgz7L/RHGxNVUl59CSayYC9cvyi0dumz6nxZnkN3?=
 =?us-ascii?Q?R5pgbOUGFkF6Hv2yosWTEJn+h9wMh5w0vlktqigdwT2WwdJPSStNCpGapxqV?=
 =?us-ascii?Q?g4+5cLpRglkzyBQzXmKBC+jGxfhI43/RiY4xc/9IQ04FHLvtYMwui50egFaa?=
 =?us-ascii?Q?yuedTSN3Xtp/2uw8JLRDOakpXcM70ZwU2II20Lw1QBs9kUTdXoJrifcEFfAM?=
 =?us-ascii?Q?cUxSQ5OO6ZKv5YZ1fyqFNpoqFyO4y12z0g6Am/7VSOvAF1fLLLNGvmHcmWwI?=
 =?us-ascii?Q?p0PKkKm34z5Hf+gpQhwGu7LcS3NBgSNWwiciXiJOEyjS7w4/70OV3BZF+uZ6?=
 =?us-ascii?Q?oYlQNw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hk2+g70/L07SR5kovwVg2GJZPVenB+Q0B+NpJQ3MFOpYsfaCYRGEOkTYbP3faQqoNFVN2EFNR6CWuu1Ls751krMsrl9eilek/N8LnNeza2XGtZvHP5pgi+4FrNbpV7BsL3Y3HieF4CVNNC693OG40q87T2sXPTz2KkygFRw/cgWrx6SJj15dmuEXwjI41mO5oEEydbpkh4Ealjb8NCCf+CQMzEpUEtBP0Snp+06h2M8jnLYHzGjPYuocr8XwMNV+gIETXaoWaU4Bbnahoy0+kNvOy0YQ6YhT2OEUtCzBQ9L8A7Iqr3Y6tx1H77/tzfRtjEdepN9f2iMw11HT91MdzcL3X6r34LP/s0oFY1YJCWLalnQ69W4rrKX2zc15O3FDr/FnxoegaMOPO1zgVL/UXRGUcwQUE8mv2TLtzUww7Ne6Ufdun7UIgwniOB3CZ0hy8I2hh/9ogisXFKpJID5itKJvYsvYnX5rLrUt1VnPpzsdf4LZrO/Mf01xbhU0MPMG3kR0U5VNpA1NRrH9kf9zFq/X8tiiy8b0YP9B8UPqMutiORsBcqPgnF6MZlbOUGwtKNKJ45tAzj/H+W7ULpB+6VEYYxRLiGKFub3bWAF/DnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba184f5-7c5a-4910-a3c0-08dd462dc4cb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:55.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1YpzFSyuCjr5rgLBTjqFAAzcGPQkMyL97BACCgvJxd0Z7yyC/4tJ9cL+kfFw9dLKlujP6JD1tl3BcMUgnGRf4ZUt1+jXLE8aR/i4yOiiYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: nCC8ctIkCSGd5ap7_ztm12UCd5XKnVs8
X-Proofpoint-ORIG-GUID: nCC8ctIkCSGd5ap7_ztm12UCd5XKnVs8

From: Christoph Hellwig <hch@lst.de>

commit b611fddc0435738e64453bbf1dadd4b12a801858 upstream.

Exact minlen allocations only exist as an error injection tool for debug
builds.  Currently this is implemented using ifdefs, which means the code
isn't even compiled for non-XFS_DEBUG builds.  Enhance the compile test
coverage by always building the code and use the compilers' dead code
elimination to remove it from the generated binary instead.

The only downside is that the alloc_minlen_only field is unconditionally
added to struct xfs_alloc_args now, but by moving it around and packing
it tightly this doesn't actually increase the size of the structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_alloc.c | 7 ++-----
 fs/xfs/libxfs/xfs_alloc.h | 4 +---
 fs/xfs/libxfs/xfs_bmap.c  | 6 ------
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 100ab5931b31..d8081095557c 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2581,7 +2581,6 @@ __xfs_free_extent_later(
 	return 0;
 }
 
-#ifdef DEBUG
 /*
  * Check if an AGF has a free extent record whose length is equal to
  * args->minlen.
@@ -2620,7 +2619,6 @@ xfs_exact_minlen_extent_available(
 
 	return error;
 }
-#endif
 
 /*
  * Decide whether to use this allocation group for this allocation.
@@ -2694,15 +2692,14 @@ xfs_alloc_fix_freelist(
 	if (!xfs_alloc_space_available(args, need, alloc_flags))
 		goto out_agbp_relse;
 
-#ifdef DEBUG
-	if (args->alloc_minlen_only) {
+	if (IS_ENABLED(CONFIG_XFS_DEBUG) && args->alloc_minlen_only) {
 		int stat;
 
 		error = xfs_exact_minlen_extent_available(args, agbp, &stat);
 		if (error || !stat)
 			goto out_agbp_relse;
 	}
-#endif
+
 	/*
 	 * Make the freelist shorter if it's too long.
 	 *
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 6bb8d295c321..a12294cb83bb 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -53,11 +53,9 @@ typedef struct xfs_alloc_arg {
 	int		datatype;	/* mask defining data type treatment */
 	char		wasdel;		/* set if allocation was prev delayed */
 	char		wasfromfl;	/* set if allocation is from freelist */
+	bool		alloc_minlen_only; /* allocate exact minlen extent */
 	struct xfs_owner_info	oinfo;	/* owner of blocks being allocated */
 	enum xfs_ag_resv_type	resv;	/* block reservation to use */
-#ifdef DEBUG
-	bool		alloc_minlen_only; /* allocate exact minlen extent */
-#endif
 } xfs_alloc_arg_t;
 
 /*
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index e805034bfbb9..38b45a63f74e 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3388,7 +3388,6 @@ xfs_bmap_process_allocated_extent(
 	xfs_bmap_btalloc_accounting(ap, args);
 }
 
-#ifdef DEBUG
 static int
 xfs_bmap_exact_minlen_extent_alloc(
 	struct xfs_bmalloca	*ap)
@@ -3450,11 +3449,6 @@ xfs_bmap_exact_minlen_extent_alloc(
 
 	return 0;
 }
-#else
-
-#define xfs_bmap_exact_minlen_extent_alloc(bma) (-EFSCORRUPTED)
-
-#endif
 
 /*
  * If we are not low on available data blocks and we are allocating at
-- 
2.39.3


