Return-Path: <stable+bounces-225701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDoFJyVruGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:42:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF42A04E3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA923046697
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA33F0A8F;
	Mon, 16 Mar 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="I/9qB6xl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1613EF66E;
	Mon, 16 Mar 2026 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693683; cv=fail; b=tJPBeB3JVvSz6VrxUlMYZK2yU5Om/S88OZ5VgOdg0BRw+8t8b9xxueew1kGbCwfQ3WMy1Og08ShqkPmCU2y5GHYuj76h6G6RMEqpAIjpdK+7lgjfZLWQa7/jYVUeRSu0seNAvm4e7VvjlN3RkO8vqcdJnTNx9SfZZdwuUpxdXCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693683; c=relaxed/simple;
	bh=w7MTANz4hDH18YkZuqdfcweiQRXt38vvHvnoX9b6gxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyScZErO1ms0Fo2mJRXgkm9ImicFH4JQ+G6k5UZJv1sfsdvH5EQVe0XhqfNnPgv5cNw7gFBhwDyE8vwrhFhaAlK/VX2Vhl2GbJjpfKPmXuVlpRgIEpdI+hv1mUwH7K4IbK/Cq9Rbezr1q9Str4syYxC8oun9L6RkmSte/L2ZWQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=I/9qB6xl; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFM9qD3316600;
	Mon, 16 Mar 2026 20:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pxqxu98ezjpWurB1ugoGEjLHNS5pHUuK20Wqev9TkhY=; b=
	I/9qB6xltj+N96tqbWGGDrR43FGLrJ0hF3UovrqGVwS8AaCO1gSDBwRlIFZRajnp
	0v2E2KoFRvZxEZWpsSOgAraV20kgEoOLDsrWplK8P7SLnwtf3oJxb0aT1FVEgMTw
	JDW0HmIHVSVvYhYECoMP49ZbZKGCEbJ7D3d+vzzqSa52xiZmxyAM4dEwmX6IE0HG
	64VpvHvuMbadC01YBUZXRyXmCtFZ4J7m3QEntybrA21lV61Ew9jSITK3vXrngVSL
	WFP4E4dQOT64LHkGZtBmeOjtnu6ny7Ic5cxMtILmrxWWopjTLpBOo5a89BaUfnjc
	ODINlw7+nX8D0EYj5Izo4Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cvvvyjk5f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 20:40:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBNBSDKmNzygOPwXZZ3Yqgnhht7IQ35vkcoX9Lb1Sy/vpDhedD1IfvasLXhnhSIYXITakig/WpKCFtqxcGTtNSLT6WNVAhDUyNHFFe9r+oLYGVABP7usZvQUz6aerUMseqXV8kJ6hhbwCw5HuW5RRh5bP3sGPKBqXL9ZNAjhnNP1Cj5vue3WWUrdsXtn/uEAWKUVCZ3mzQbp6BRsLmw4J8kLyQUbBpVT9VXLtQKJb12Q+7u6dRVSjisjE5FvnHS5HAshHCsvCJPJ/hLrBi93YAyq5k8gx7cdpXPfjlYhdMe9VCuBB2j+V6CtNzTcYkGSCFxhDOmO4M5eCLNUWn71Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxqxu98ezjpWurB1ugoGEjLHNS5pHUuK20Wqev9TkhY=;
 b=eUJxphGa7vMIQJsoqIelIBLYKNvEjqeL9J0sX09WMed+eHXRd+r4ckcUcmtJ+V+QSCD7JiTecQSnHgNpKPFK9CZJW5k/2RyHOT9ohzI60W5g5kF4XsiAuyzoZC1jtglocQSkLWT0sDULyJCRuvxZA9Mo/b5j84cPeE3WcpI/ZQoq3ROlPBBcBHdlP5Q+61aiJ5KH+2jZWWpvGl66qLnpIQ2eWkDxs2g3LE9b1zvacM/XYtJvWPtUeDq1Tij2icXjAB4NLhrMy9WnLWomfpo91w126FIot5UvoljRJktPpCVH8i/9jCYrt2qtW7g+1sWiCoFYALVaFRUnOnVzOkVJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 20:40:19 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 20:40:18 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
        ahuang12@lenovo.com, iommu@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 1/2] dma: return 0 from dma_opt_mapping_size() when no real hint exists
Date: Mon, 16 Mar 2026 22:39:55 +0200
Message-ID: <20260316203956.64515-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316203956.64515-1-ionut.nechita@windriver.com>
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a0ee68-6c25-407f-b226-08de839c3c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pQmFQfROU3ShJ1mp2VRdQS7D5sCXJkA4QieNNn4Gg5z4sqNY/WGMG7EqmoGrSEpO7DuxjMA0aKMKQMWNUVYV1B3aiI2ZPgb/eVbw+lmw9qt2XrouxS4qS+e3awS89ufSU/Q98zqcKVYzMJa+mpeWzmnFRaI4pn6A8Iufg0/ybtmbqfXTKoQC+znWft3UJUe+zMCyc00J4a6A8g/ZLdD8qAd6sFaCx852HlKwUqsi7INXI8msZvSqkPdyVAND2Z+jAS67mv702sMOZMOHlBPsMEzWZhVQjMcmo7WvDiOY1YSkjpc/0ygkHob39vTwH8FMnQJA1d6ebbJI6QcRc9DunB4LwTwTjmWCN56xYVW3hChP+R7vN5FvwAQjVm5oIV7R0F971Yka2HTG0PUAeh3IfZJUd1Q6tN1zaCuLIxP5kmvsj/Xk3m3rNWmyd1xtB7tvU79AB5UVt4UdyTMDnc0+sncuB1ZYNyEWGX5f2q0xgMUOtVnTVTr/1+bk1idG1YxuKazrhws/qkvTXzaN/zqzwAC1ji9Zpdt7W1tOAwKW1+yQgVA0Os2iMLCCm/iwg/0hRSeC2XTxmgoQU6T+v9y4S9qwFn3WqL7ZBG7kbN80RaU44i/opQHa58tAvKSgaA1skEMPyIEwM8WWJQ7tAfsVKrIQIEVHbmlQVtzyfqy3sAx1kmeqwnfR2sj2mZtLontKBdqZ8G5+BxmwvkqN+RvcUveRgrcu1YT90h6LovhVCE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTl2dkxQTzNZQ3RUa1FMVEdSTXlzNXFwT3ByQXNibXhyUGozdnYzNEdYU0o1?=
 =?utf-8?B?U3ZKcmw1WHQ5b1MvLzk5bHU5Vy9OZitWa1VPbWRmMUpnaWlTZThCYU8xTWFY?=
 =?utf-8?B?enlxYnkzRUJLL2E2QnFxYjhOa3h0WHVFMUJCUUZQUy9VMTk2RWsrSlhOai9j?=
 =?utf-8?B?NksxUERSaHgwcDRMRFpicDBackZ5NkhTczhSQWZGL2RkL0tTd3A3aGZvRytH?=
 =?utf-8?B?dTNsZVExQWcydFhFbjlIeU9QMEEyaThSanJEQWZvZ2w0K01kOUZaYWVZN0lX?=
 =?utf-8?B?SFhHb2xYc3o3bk5xT05NTmF5bmxqUFpSZVA3dWp0S2tFaVhHY1lOVE1FNE53?=
 =?utf-8?B?NTdGWWgxREFPbmRseVFCUEx0SURsOGFFTUF6TFJBenl6OGNvaVdCOXUvY3RH?=
 =?utf-8?B?TkRXTHhLa01EcmY5SmJ3d1pxbDBXQnFTYzJCVWY5MnlFcnpVQmdNaFMvZ3NS?=
 =?utf-8?B?UGdxOFNTU2Z3VFREdUhNdG50WkJqdENLSTk2dEVhUkYyRkxmWndTUUFNRzNE?=
 =?utf-8?B?OFNjenEzSmF0SkowZUhZdDVDQnYrTysvbEJDNmJxYXNCUEdnZmhueFU3bnd4?=
 =?utf-8?B?bmN2UExyRXdnWkNqNzJ1ZHA2ekcxV2dBUnFFL2Vab1Y2QTI1YnIrQ3dSTEVP?=
 =?utf-8?B?YUJNbzN6OFVaL3BQNUl4RGtUSFVHNC9ieWorc0RLdVVac3YxTEJZSzdrRS82?=
 =?utf-8?B?N25QWlJMWUgwV2xueHQrMk11NjJkVjdkNk91ZUJXck01SldhU1FnRUpWZklE?=
 =?utf-8?B?V0VWeld3eGhhcHlaR1EybkdxOEViMFAyWUcxZkY5eGoxSFYyWDdYbHppMUtJ?=
 =?utf-8?B?THMxYUprRDNPNTZNWW5FQTludVRFZG9vekFNNEFmR05PRGd0cjRaT0dBeWdD?=
 =?utf-8?B?c3o5cFphM04ySVVPcm1mOEFRZDUyZWt5MnVNK0ZNcU1rdUFaUFlNQ1crZlFM?=
 =?utf-8?B?VTlhVlBab3Z5MmNPZU02aFpaNVUxYyszOVJiTlZORWx4bFhYTWZBZEoySTk2?=
 =?utf-8?B?Y0ZLQ1BwTGM3TGxITUtHMFM2dXRKT3NnblFqM2Fvb0Y3NDY1bFk5RGtqMmtF?=
 =?utf-8?B?K2F2YlBtdU1Qd1BuOXZqeWhHNWMwazVPMGFRMzU1QWZmbFJJTlU0ZnZ0ZFlT?=
 =?utf-8?B?WEpZQ0ZPMHhTNUY1ZHdmZnp6YndwbjJ6cTNiSTMxcUxHbU1kTG01R3o0TTlZ?=
 =?utf-8?B?YUw1SXp6Zm5LTGZYRVdUdWd2R2VjUHhsemFLUnZsMTZkNEk4bjliVm05YTFv?=
 =?utf-8?B?Q2FBb3Z2UXQ1cHdJeUdsSTRjdjRkUUt6SXluVFBFMGZ4SG80bTNHOENjbEpB?=
 =?utf-8?B?NTcwL2FJWHBLeG1VOFpIV3BiWG4zOXN6VnhkdjdoY3p6NGd2UzNOdnh6RUk3?=
 =?utf-8?B?Q2Fldnl2cXdSU2F5YlRTRjN0OG5wdVkrdGJUSE9HTnQvSmovenBtSkUwc0NW?=
 =?utf-8?B?OHlNZFZ1R0tVNWw5dzNMUVo5OTNYUGFrbEtFVUFlWE0vZW9IQ256OHdvcU1B?=
 =?utf-8?B?MkxNMkdnUWozeisvK3piekFVYkxFRGJ5Z3grZ0FrSjBEN0lyNUt1MFp1anJX?=
 =?utf-8?B?YSttejZ3bUVZcWhlYTVmYnJUMjBhREFwMTdRalpiUVRiOU9UTzMwRVR1TGhj?=
 =?utf-8?B?S1dVZlUxWTJkN2s2UGRFM2dXbXZYRUIrdTlhcFpreEVCbDdJQTBycW91YTNV?=
 =?utf-8?B?TS9OOEJxUFNKRWFIeUZoSE84dEIzcjhIdTRtYVVxbmprYUZVcUkxVmlmS2RS?=
 =?utf-8?B?ZGxhb2N2NkR5VzRxd0Ntd3ZnWGNzS3hBTGpabUhMOHp4WVFlaFUvT2xISGF0?=
 =?utf-8?B?czlPY2VLeGVabVJGVW0rM3lsUmE0MmtMbHk2dnkzQ0p3Qm91eFVzR29PWCts?=
 =?utf-8?B?WVlvSXBtRy9VSkRPdkc5L1RNM2c4Y2Y3cWtYc3BVY0hDR3NuQUVHMGRhRjlJ?=
 =?utf-8?B?SXgwaGVpYzRHWjJYdVhtQXQxQ0xPdjVGclRKN3V0ejlidkVaeFVtMFpyZ1VD?=
 =?utf-8?B?V2FOWlY0VUwvajZ0V21adWJkanhyUUZvbVVPdzUyUHpFbW0wR1hycXBteVJE?=
 =?utf-8?B?WXQvQ3o4c2N3NVJUdE1xdGRVbzNpeTArOEZEQ1VyRTVJbU9YSlZ2UjN1L0Vy?=
 =?utf-8?B?NzFtL3k1QUFYV3ZoblBxRmNVUnN6bHhjT2JVNnpTcG1naGJhOGJ1NytUc0dP?=
 =?utf-8?B?dksvMmEybG1YcXZ0NjJLZDJSallVbk8wWjhxOWxVMStaWlprVU1hYk9abWhV?=
 =?utf-8?B?NHF2dm94bTRWVWlHdC9Ud2hqNUtjMWU5YmxHSEhrYzIzWVVsRW5JQXVVMGtZ?=
 =?utf-8?B?N3FQeDcwQmVVQ000MDlTOFo2V0JzZlExNFVPUDJ4TUFMWkl0eTByc1NhYUJP?=
 =?utf-8?Q?DpwqJR5GCktzDeI/FS4EAJevRdQxpl+J0zqzcGM9FSBF5?=
X-MS-Exchange-AntiSpam-MessageData-1: 0R7Z9B4I/C4CouEeiqAzHHXp8vonhzzYNyw=
X-Exchange-RoutingPolicyChecked:
	DYAfROxrXYKyqzoa8SFaiPUAssVvo5ctnW8MGlIH6IVy0XFITQBpvVjcVGujAoZx/qecJ0dBsI3jhVMXCIaw8bC5ttONf/nfAIGqQOETro0jRLDxHfSxBjsHkcNZZW4uYNlciFOs1LSCzXcvENvM3EjpQK+PCMOhvy0Nozx1xwHDP+Vbk7cjzi2Tms2vS6x5rikGv+63CUnD6feGEuagag8FNH5UfTR3QJHSMSUdnFKh5d8jAuHBic0wdrSyaEzlszoG++n0wkjjY9mLfb7Z/EgHp4NBqJFj7F2T4gjW9/ULtIi9jWQXUCpNP/3LMVZFKF4Z3/WbVWq6pN8q7dUdHQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a0ee68-6c25-407f-b226-08de839c3c36
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:40:18.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqNRbExAIwF+63aZHa173iS4B4d2r7pO/e9fDElUaHKryUDmc4mdgntJCM2hk7W1Z/J2T6TZRuzDGLR1hcshBSm2XQHp7A6qpXN0z4Vvll8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-Authority-Analysis: v=2.4 cv=E4XAZKdl c=1 sm=1 tr=0 ts=69b86ab6 cx=c_pps
 a=WUa4KgmVXsEXRBJPWwSZ8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=hK6VChwaXY56r-QPk9MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2NiBTYWx0ZWRfX9EUSO1awNI1s
 oJaTCLOhq6V35D2Ba/QQtKSjByd2Ggj4praa3tyivfFclpW8NYRjd1e7CS/Y06z2ZTIKgGDzFg3
 IVV8W3t8zzZtDL5rJZv+qsIpa3PU1vWtPKfjbKOGOsq1YlHpNgKiBq34kQqxkdRLgLflu4CQlkb
 A8/TZiSkZlk63IkBa/eSV1IHVGCmtF+BlexPw+eNjRX65znHuHAWqf5xZEyQHb4ZWLp6ALJAa+j
 /SyiUEjAzWC7d6oi0mQWsAzGPwhXfQbZyVqyUMIRNj69/OmZrNDoNw7I6HHU9RdgKymaZOB+NG/
 c5iK1PynpK8z5a6UuWzeu9uFwboSNbgvEFMxTxItawoM0NbfVGVP7/GZXXz3iPW6ayIJvfjGzH3
 +cMUuBWYbELtsFQI4EFVOPTW0W8xZAuUgConzq4/uK32thLA8aQUEqTTfLzJWN7Z85XSb2Z2JZG
 EcJiKb5MsjywMRt3G/Q==
X-Proofpoint-GUID: Hm47-OmkI5v73OWdxJfyMShTUiyAgw5L
X-Proofpoint-ORIG-GUID: Hm47-OmkI5v73OWdxJfyMShTUiyAgw5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160166
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com,windriver.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37FF42A04E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

dma_opt_mapping_size() currently initializes its local size to SIZE_MAX
and, when neither an IOMMU nor a DMA ops opt_mapping_size callback is
present, returns min(dma_max_mapping_size(dev), SIZE_MAX).  That value
is a large but finite number that has nothing to do with an optimal
transfer size — it is simply the maximum the DMA layer can map.

Callers such as scsi_transport_sas treat the return value as a genuine
optimization hint and propagate it into Scsi_Host.opt_sectors, which in
turn becomes the block device's optimal_io_size.  On SAS controllers
like mpt3sas running with IOMMU in passthrough mode the bogus value
(max_sectors << 9 = 16776704, rounded to 16773120) reaches mkfs.xfs,
which computes swidth=4095 and sunit=2.  Because 4095 is not a multiple
of 2, XFS rejects the geometry with "SB stripe unit sanity check
failed", making it impossible to create filesystems during system
bootstrap.

Fix this by returning 0 when no backend provides an optimal mapping size
hint.  A return value of 0 unambiguously means "no preference" and lets
callers that use min() or min_not_zero() do the right thing without
special-casing.

The only other in-tree caller (nvme-pci) is adjusted in the next patch.

Fixes: a229cc14f339 ("dma-mapping: add dma_opt_mapping_size()")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 kernel/dma/mapping.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 78d8b4039c3e6..fffa6a3f191a3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -984,14 +984,17 @@ EXPORT_SYMBOL_GPL(dma_max_mapping_size);
 size_t dma_opt_mapping_size(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	size_t size = SIZE_MAX;
 
 	if (use_dma_iommu(dev))
-		size = iommu_dma_opt_mapping_size();
-	else if (ops && ops->opt_mapping_size)
-		size = ops->opt_mapping_size();
+		return iommu_dma_opt_mapping_size();
+	if (ops && ops->opt_mapping_size)
+		return ops->opt_mapping_size();
 
-	return min(dma_max_mapping_size(dev), size);
+	/*
+	 * No backend provided an optimal size hint. Return 0 so that
+	 * callers can distinguish "no hint" from a real value.
+	 */
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
-- 
2.53.0


