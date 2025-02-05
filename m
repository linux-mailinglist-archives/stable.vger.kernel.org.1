Return-Path: <stable+bounces-113981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB585A29C02
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FB83A79B5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D86215062;
	Wed,  5 Feb 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hhgc8f10";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w2C06jqE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1621505D;
	Wed,  5 Feb 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791666; cv=fail; b=RllAY9bVczN716yrCb5MovhoJGujzVg2Q71q6iHqVcBTLYQVa6k2kkDuiNz2fgZ2XecBRbgJLhM3HIf4mvIjx2apqPsgcH2DPLDkLglKm/wnbh51blJbgne1Nfb3RqRyHkczGauGxZN+ZEMGEv1CFYrorqfCIgOZebC3+ep0JWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791666; c=relaxed/simple;
	bh=+mxJkzm5P2uHi79YjTkk1aCkjrqTVF/eIStTZ7KRiMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGOTca0i+hr1CWYxEzN76F9p/HuFCfkGV7YEjOn6WCEo26ouw4QHEHmgXVGg+zYA7ayBS2+YPKSjlFbCbWNjBrPc8XHdcZzkAJaSQwmLudacLlvjwhmXskRsZwWguZ0GJ4oswx2WJtCKyELGYBIv6EMcsXS5D84nkBl25Qbr1fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hhgc8f10; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w2C06jqE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfi62000951;
	Wed, 5 Feb 2025 21:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nDK9bzPF8cuI6+pN8XX15an1YrzZBccG0bsfzrRTaxc=; b=
	Hhgc8f10RCGEA9cZCuz44hO7D+6FupmuwE+vHvUswKNUOilkaSH1MQ96nJWpePXl
	/Fn1C+ISDvB6jmcPi74YDAzwpGqKL//9lZCph9DGMi9rlDowlfLixcYy0lWiJWH3
	fE1ZL1EX9XQ/ReP0C235BBppPg0geE4N+bfdE9ywx24Goe+1MyNaiyRMo8eQ4go+
	x2naDAcfiQSrxugOTjI4ZkhyVTl45kQRVgbOR0eegMrp+31YDXmxBT3bzfFKsrci
	BsXh6FE4SexaY1duLJxrvADT08FmRvwjaSQW5FgDtSHstzBWfDyEPI4lodYvczO8
	CKiZ1pWWEr1sFNPS6w+I+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy880jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515JoXh0027781;
	Wed, 5 Feb 2025 21:41:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dp8byy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ptrx61gIIPuKmYxevfk/uWb8n6aJzRdJDLEJK5tL8ajVOBQ8imM1mPdvzg+/gwVV9ft0qQ+ve7gL/VZwmomsaWy7G0rdZgcqiTXoWU6bVoCL2W3P9XGM0imPx02cbbCSuitqVgSCx6gtJPo4yUKS9pC+VkiMVc9W5ZWN2AwwvT0xaZ6uNmqc7uw77amG90l+hmkr0vL19I+VoxtA7K/4Lq93scm5PvxPk9EpQo+aj3sD+LIit8Q1wsMdPqSW6DYuXvpibWNpTaaiG/07LL+rqTVCpyQ08nmqNEAg/6gmYqXX158awNMEpXGmAWy8uyK8t10zmsZ5tXxxiEt8hNqZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDK9bzPF8cuI6+pN8XX15an1YrzZBccG0bsfzrRTaxc=;
 b=UdmJyS8S9frXn/f1/SvmnwHprQncx+qi4rAhTeBMsj8tBVebQqt8x2AKzGihuSbKuPWVcXFfRMn0thLNBk0cVEG6JDskp2NwGDGlDgPe1/wLizLn/DiY1i/6rn64xB0oFCRlVioHLOcvOIBaz8WwSX6YB5lR2sCE7ARnVjfJKv4EIjLBebvP4jBovzeHeBpyczjWrujNp5nDFSsmaHgieqsFYiqw0slOE4vHHE6CdkiCWV8gR+I+bNzQP52DfH4v/aE/266IymDSLJNrFKFCM77NGKN3z7QmYjBblFmhpdgDZmsJOiFuEOASmDYSUrgpGp+9+A1izpsGZ3oVdmG2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDK9bzPF8cuI6+pN8XX15an1YrzZBccG0bsfzrRTaxc=;
 b=w2C06jqEmDbth4EqBmMmzkn95GuYU2zABXg4M15AWp+a78ikdYSq5HgT4rpt26CZV02EtrB95lBEl9ZkrVzIuVGUy50wit1M4qRKMXiBJUxX7QYY3E0aIYNzC+Fj8lNvrNlDNyWUF1/11VcfgBwMLXEPCjdH2MBWcgQzoHg9byY=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:41:01 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:41:01 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 15/24] xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()
Date: Wed,  5 Feb 2025 13:40:16 -0800
Message-Id: <20250205214025.72516-16-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: cca811d4-8cde-47a3-3c94-08dd462dc8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fajo9mGCaFZpH8zqRrqQnWV4IWIpNLLiAn7GpQG1gviGdT4GWrqQIVVEkV5m?=
 =?us-ascii?Q?vtRKCc6BrEvkr4H3tsrokgXdAxFGSIk/Nsw890S3G/jand9MCgMUkdfz7FzZ?=
 =?us-ascii?Q?IyI9ubTxkzII/HeFHrLIgfQCUrEW+o/QmVtYWeQtfON+fRvMdHdLwp2+/6w+?=
 =?us-ascii?Q?Sma8wvHYvslTRWm1W6ViaWU6Lu/Vlu9FQeTz1XOZ5lx2JqmvRtKN5+BSRqDM?=
 =?us-ascii?Q?yZmWDBxShr6zTR6b0rtzgjRYGpoxu910fPB0tDnaj2xaVfFmX6NGx27BhQSC?=
 =?us-ascii?Q?BrBB3PoX7hpValBwnJTlrUb02rjA+rIeRBasJBXEXr40TW5bKJFlsMg0za7P?=
 =?us-ascii?Q?ekNSJtgJLeerNfgK0CkRq9oHp4XIw+UIvfPacVPQffMs/Y6+DzkeWDMvaYoY?=
 =?us-ascii?Q?kAX/cCKX0W6ByPN0wWJGkiY6tpNru3rh7alenFptCn7L7ONlX6wpQu+skmrk?=
 =?us-ascii?Q?DG/XMZqBBe3BOWa5XNHBlgBlfELmCUjhs7SXPeSZrOflugUpic2KoRIX0OXd?=
 =?us-ascii?Q?LY5+hBB/T4nl+PCWYaHIkhgKH4nNQopIRXtiCvuARVqu3RXfdVYyNEnSMNnD?=
 =?us-ascii?Q?ghWc5cdw1o5hFf87jGOH5MBooA0OSmKbibkUmmklKisTmuHDCe3EVwZErnH4?=
 =?us-ascii?Q?Fm3OwUrDefNqcmKaSBIY0L2fMGSLDj2TTpaXQm2kEHKN+P7LUTgowXtPjwZW?=
 =?us-ascii?Q?ZW75ZWayqT65wi7PGnfW9zOeSAlLRnU5Z4uHGL+n7BZ/KWXhfE3ZgHhqNWtP?=
 =?us-ascii?Q?VMVYZsxLdk2YZ4CCWTWSbhjr2JSKXmj6xujy5AoIaDoK0w/X76nzNAWsDAMC?=
 =?us-ascii?Q?Z8IHspTK7M6aXkw5g+dhzjJso5VIrj+WfYw6GgeVb/ayUBJpsL+QqPp5T3BZ?=
 =?us-ascii?Q?qWNSL5vlwFtfeQ/PYtS09+0ebreNw+72OIHSxKALYEhIq/FZUSfZUEpNCvCG?=
 =?us-ascii?Q?xTN33LLB+Z3waijdEnUjrrQXL7C/7jfVxO1CMAsUgl8hp6z1zuRuQTj0d1IM?=
 =?us-ascii?Q?1sdkpS8eS4YdTZYC7M6kuo6dPA1USMuCo3nkMINqB+tlca8SkweDvNoK+yPu?=
 =?us-ascii?Q?5H9W6yZ1Dg+fKaN19xh3AbFo66ChA7mUZEA71QioF9bKT9eEMvq10+vM3V6s?=
 =?us-ascii?Q?qe1pJoiijQaQkvBNBxLfRH3MYzkjaUOVADjV2LjsLPnnKCtAIncG3Hkfrz3G?=
 =?us-ascii?Q?CFZfp3jQjb3Fs9G+37HNIo3VsTIYwRFQrLqr1gdQJUf7OvQxWE/bSWbzDpED?=
 =?us-ascii?Q?ufpkfPZu5aZtGFAdtsvM27zD6+NpmU999GDn391a+Qd3+aDtTjrBXV1jry+R?=
 =?us-ascii?Q?LOVa6koOG/BrcECl+isPf7HGklL5I1EB7PIHGuC27yoQ8Qev/ij1UrPn2C//?=
 =?us-ascii?Q?/zBV19AGzhH1pslZ4Tecs0wJqO9T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyBIOZ151vP5NqfNeW+UGyxBAChsqSlTn/pjetd3gyR0aiZvT0Dx8pQ1uU0Y?=
 =?us-ascii?Q?Y1LI203MKcNZ8ws4hGW0/B3rg2CtWNRfWNWXjZmYHgqmQtKEnr6lWTulmZTH?=
 =?us-ascii?Q?G70/YJ/yZoPc0H3dm55YfUYr36gCz8b5mOoJmNuDOGg/Ga2kI8Yp0zmPKuCf?=
 =?us-ascii?Q?Rlph6sfabSbqNDr4bI3OI/ap+pWXW9vuRGJoBNJKfcMIRcdxMVSv0m2fKa4c?=
 =?us-ascii?Q?Ki/DnpFmxOa4j7Rp4Wk43Z5RzaVTB1cfhgJ1PsI2t+tlD9iDgF9WlDafhGJw?=
 =?us-ascii?Q?UXiS1H7by7tvDlSVS4qq42wvMxz42h2v/JbJs9H8dKHBgQUqa9VqbUiCJWMj?=
 =?us-ascii?Q?lOleNuF68Y4Hvoz+aLy+ciKzCQ9Tk/XB6tGBoozO0l69Eq+FlCkFN+bPMtxp?=
 =?us-ascii?Q?DuVYp8P+36PSZw6IDpxhNW/5quCz8QkVurIH1eevKI8miAn9ZbsBxOK1oJk7?=
 =?us-ascii?Q?CWbm8IOEjkmjz2FiUod1Eow8faiopzkp0slDsYNQEOJVbGLfRnNEUNcq+agG?=
 =?us-ascii?Q?cpSoEq0nYl4v8ZEd7scXPC8MKmShM0XgvkY+1P2YoB69WFC7wpM5zuOUfsOt?=
 =?us-ascii?Q?oPPxHBLJ5fyG5zIyzDBjZifmLGovs5eU42LBvluaFglSAjVKplV13ucLhVle?=
 =?us-ascii?Q?6ndgmwRQ+hC3nuMqEGM0gamBshG9cMwYeYD4grIW8CwuCBcj9LqvkSWd1HqV?=
 =?us-ascii?Q?a/v1p2zBKC7/X4aevKiCIIbvZ+5KUt7PhuPPX6KOEhI8ZOtyFbDjrwFrpMal?=
 =?us-ascii?Q?d0DWPfVEfikjc3v+pgNxq7nRWH2I00B07os+fWqszPm8vxgyv0p+TsT9lAuj?=
 =?us-ascii?Q?0BWZJSL61OUAMJMomtSkb7hor8mrTW1I2F2yj+sTyahIiGi6ztPMhTteDeuu?=
 =?us-ascii?Q?TgwEj60QpP+n7CLw2A6xrYSze1fSQKqohe7uRiijSvlPyu9l6DezJYT3H53M?=
 =?us-ascii?Q?2AAmV+irQ1Hc5o+ykKQ1M98nZEz0tKxNLZrv6H49VYc1hykXfUu5YwWeE3y2?=
 =?us-ascii?Q?xRUy12QgWrrcPGAp5dSU9sKW1RvU77oQj6D0JWYjx8NKcFHLmXy5tcyW1+50?=
 =?us-ascii?Q?++caAdXTrQeGSJYhNXv0jPDWoxFQzdMlCQIo523ND2rj/sSZVaYQJgYRGUoP?=
 =?us-ascii?Q?+1iJwp0y0kAyGpfD9MMxVtnnp/I0i9LBcR05FDD90sCt9TwuF7J0iyA0i8QJ?=
 =?us-ascii?Q?7XcYYgRWLWIQqfGZXhQkRui0yJpodqA53r2rBnqkLGgMOo3obaUKx5lMO8n8?=
 =?us-ascii?Q?40m0GmjJKz1bqKmB7DrhNpEMjOF5ZnN9Nc2g6aQtziC138tbR20RcTJyUOtC?=
 =?us-ascii?Q?T+HdRSZKo7xIUU2Jw7vvKbBTe14UmYFtqV//TyFa/RM4qPHDCpy7SSjbKRfp?=
 =?us-ascii?Q?wvzuyBFsCsO62Y5ERGEryIHxQPSlBDsekUQj9kGgkiQ56juqeqjoh0bDdzBh?=
 =?us-ascii?Q?q89zrmsNqQmCDpEB3Yw82r42mzRD5I4mNJldODH2UMigKMsXsbNyXOEagy+L?=
 =?us-ascii?Q?V92DYr0VlQFktCWzUBMEIalaXc9gqnAq5sBaH7jD6EgBTrls/fMouu0Kdgmi?=
 =?us-ascii?Q?z6uXj5yNmLvcbxGsR7yYXaI7CjZ+zCCiwtCoUW25knNRDUEHr1Nu4BUOOx6c?=
 =?us-ascii?Q?e3iH7WK5FTmBL7dwURRAlx1TqFYJ4Ld7LAYs2ZVQj+GcS9v3Or6/KFp4m+lG?=
 =?us-ascii?Q?dKUzSg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ztlRP2+78uoBegW5HYJFNUqIjxpes/SnDgB21+fWIgR5Cq1GJyqeJTTkGsMBWWBGdeV/mRv6FlUDTMLUlhTAsa4ike2bSgLty85rRyf5wsMtOHgffRMfAOSpDKg9cB4zsLkoKhW5ha9FxH5/5a4oKGj3m37uO3YfXZWB+QqyBNuRzLD2TNZmZ50gDBg6gZj7gRnqgNOp8hDXFo+hvdQAfZtz8XO+QeH3hq9CyZKMNgTjat02ngQJ0P77bOWwIL0y1YA547RulXReHsnoqEj73iQSQgAbPZJw7q+XvbZTi3x92WhCRbRv4CADk1ozmUHLha7NRszVjRX32jod1zV/Q4UH/p0CDvaq/Vb5Jzv5H5sG8vybLSoRzTLrcT7XIj+HZg8GBuTbkmmSIePB1oWI3/H27u2atl/dvOxOQY6up2wA4otwkOL924HrcR4G78/QTQB5oqYS87mHwS/wQ7PIr6AvDFxZkd62ebgjqo0gW9DrTckWzV6CHNl2AZqxT8iiQGbRzKz9snUNPsikxc7R28Q5qeCzKsJN2Bh08OZQi0Aw69QvcbpodzIzilnXssXeWUWX3nfRGvkqKIsYC3wfTLeOLLqaFfLjWhyise2twaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca811d4-8cde-47a3-3c94-08dd462dc8c4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:41:01.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: St5meupL4aPxgPtxImkcn7hnkxsw7Rbu53giKPENADBU706shd2GJvvs4Epn2PMx79HTy991Ob6Kjf/YpZPdbydNvT4KLd9TtbdcXuAB2PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050165
X-Proofpoint-GUID: cOJA1J96diUy8h9Vo5PxzGg2mUs-B1pb
X-Proofpoint-ORIG-GUID: cOJA1J96diUy8h9Vo5PxzGg2mUs-B1pb

From: Uros Bizjak <ubizjak@gmail.com>

commit 20195d011c840b01fa91a85ebcd099ca95fbf8fc upstream.

Use !try_cmpxchg instead of cmpxchg (*ptr, old, new) != old in
xlog_cil_insert_pcp_aggregate().  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg.

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to
prevent the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>
Cc: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_log_cil.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 67a99d94701e..d152d0945dab 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -156,7 +156,6 @@ xlog_cil_insert_pcp_aggregate(
 	struct xfs_cil		*cil,
 	struct xfs_cil_ctx	*ctx)
 {
-	struct xlog_cil_pcp	*cilpcp;
 	int			cpu;
 	int			count = 0;
 
@@ -171,13 +170,11 @@ xlog_cil_insert_pcp_aggregate(
 	 * structures that could have a nonzero space_used.
 	 */
 	for_each_cpu(cpu, &ctx->cil_pcpmask) {
-		int	old, prev;
+		struct xlog_cil_pcp	*cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
+		int			old = READ_ONCE(cilpcp->space_used);
 
-		cilpcp = per_cpu_ptr(cil->xc_pcp, cpu);
-		do {
-			old = cilpcp->space_used;
-			prev = cmpxchg(&cilpcp->space_used, old, 0);
-		} while (old != prev);
+		while (!try_cmpxchg(&cilpcp->space_used, &old, 0))
+			;
 		count += old;
 	}
 	atomic_add(count, &ctx->space_used);
-- 
2.39.3


