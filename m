Return-Path: <stable+bounces-154570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DEADDC45
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F801940ADB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEB28AAEE;
	Tue, 17 Jun 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lrGz2QfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kLqmoPiR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD52EF9AB
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188414; cv=fail; b=XpI5NHzW7s9OkdgucD05H7QAJyJ1dnNWcrM/R0IDkj3t7T15JH2CBoCnNJlZ+Sg2vYBnZcTuUU8BiZ6HPKqpL2ZQF8Di6978o2he/phuge50DEu2bk6LwiHCPo1CGKtmO3mseEsfEWtACXBL9HE/0i2vlxMg876AFiS7jgES/ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188414; c=relaxed/simple;
	bh=N+PeL5qqkrQo0t0pjAwhp1J/qda3w9hx/tiVyq9uPz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1aT5GqLU/as/wb8KwZuGcpq1Mp/dM0GawWoleJ2xmOdScq86bIMlF8d5N8iy28tajpEP7NNJVZrUnRT5M0lX356qvuzMxnUcPGTizdp1NbYIFS+wAP8gopWbbRtzvNtYkZPRi16V7EuMlQdKhqy0o4IPlz5NP1fxV92QoBC7Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lrGz2QfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kLqmoPiR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HHtZNI000893;
	Tue, 17 Jun 2025 19:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/fhaldADsa4HFkkzlEd4PVfKj4pxmHJBXsvi1k3MQWY=; b=
	lrGz2QfQtYv9yVwcY4NBxnT+ZUXW6hymvtxn4/P+UiVyhu0ggggOIlaWAW5U9uYH
	oibaaL/BKIUp3aROWWM5Iuzb1jpO3atUgsA4R8Jf8sxHTCuXikEQeIwQO4q7DRG1
	CQTfVZUFr9ofFgjHZa7pWmVhsEVwcLYYQcZkM02w3slfAUpTN826rhe8DUgYUuWQ
	42bK7nv9apDBsp08sDDvfzq7VJl4z4Ecv9o0uj/wx5xDnxgHc4U4TUHe5Dy+FUiR
	B/ERIXTBMj24ROfopueCeQxz/O+ifluvdeAt8aOQGTp6CsCnxolj1sM6UonfTrIs
	/shcWaHKqhUOXw4OPbaNlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914ep5tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 19:26:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HJ5Kb3034456;
	Tue, 17 Jun 2025 19:26:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh9eqtd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 19:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLk2scJ47NevWa9stJNLihn8Fa4h2I1KGz1CBijvmeKrDJ5QJ/bab+DYLbnRjn5MbzaBSryM0MNKcI31EnjtxOfsw8PDoIIoSqkuwivg85IP8TuLDr5tbKOGLAkQSOsDMVfHTii7jHZrboOTHnPyAdTa/TqM57Yqjh6BJMt1OJyPkBXyPccOkV9ScDMH0+8XXerFa/nkoTpZteR9Dq/+DzpxN19/py39eInQtF7BmVh51xYvf+FdfAVezO2ihLfgqu0m5k+5l9xzdkheXMl8JJ6WCUXhrDcSft/NG/yijbxag6c53Xj/UpO6Rj7+Z71hQFGnscNM5IGIGuTGJrKeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fhaldADsa4HFkkzlEd4PVfKj4pxmHJBXsvi1k3MQWY=;
 b=TIOG2jrfU19FKHg49SfrWoJ+SxUpT33XkxbiOTZ4PnsymYG2exKXbNA6S520Yt6CNz+RjuMThQDCpthA9OH0mL0PJavPdUSVveHKEX2DGh1c/JzyHG2QnYP4E1YdRnlrqY+Z3Ipj01VaFhPuIw46Xxgzselm3bbQrZL1J0O6jrt1AKw43Vj6v6cOtavQs2clgLLcPhvoTciOGoA4KgZ1wrRVOYiET9JJDC4Z5SQ6xBrf/T17yIDoxaXVTJ67XvkW0F1mRaTT+UaZ0jNSwlxeU8o3Cej+m5eOnnZ6fr8tSgScKV3jmeEK8sL6oW9ELisNLXhxBArERHhEIxjpLxBI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fhaldADsa4HFkkzlEd4PVfKj4pxmHJBXsvi1k3MQWY=;
 b=kLqmoPiRLiN6z4hS9kovjw3j/8w4Vo6MhMz4ziDIUofZcVmK+baBucWAVGrsphx+sOyXphm/jvRjznWavDeqDUi23N8jYWSALCFAjglFTsEE1iufN+pEqydVTiD6rU4IupNXGTwfePDFerVHij1RIlJ7+zqw/pBNtlIgE4Ii5XQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 19:26:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:26:41 +0000
Message-ID: <68c36a30-9d4c-431f-95a4-309fbf4696f9@oracle.com>
Date: Tue, 17 Jun 2025 15:26:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sunrpc: handle SVC_GARBAGE during svc auth processing
 as auth error
To: Jeff Layton <jlayton@kernel.org>
Cc: tianshuo han <hantianshuo233@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>, security@kernel.org,
        yuxuanzhe@outlook.com, Jiri Slaby <jirislaby@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        stable@vger.kernel.org
References: <20250617-rpc-6-16-v2-1-9447e6bf8124@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250617-rpc-6-16-v2-1-9447e6bf8124@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:610:11a::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ac1b4c-7638-4702-825e-08ddadd4e35c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkJkT0RjYUkxSm5nOG9KTWlyNit0MWNJWVMyRlVjY2JsU25ncmszY09qcUtB?=
 =?utf-8?B?cWVuZEtRZWtmeWk5QnRVeUJqOGNoZkpFQzBhZGNyak9DNlNrYkc3cGZXUHFt?=
 =?utf-8?B?bzJGbVNqclQwQkxLaXd4M0lkNzEzVWovRUpORFEvUGFUd3A4Z0dlVlRYR2Zt?=
 =?utf-8?B?dW01MlBQSE5jWUVONVYwSFpoelM3UWhnS1cvc0FuWFFDbG5KVWdMS1p6TnR2?=
 =?utf-8?B?Um8xNVFYa3d1M3Z1R2RnVlhHdnZ3cFdHYWpsT1I5eFF3a0xsaEdKSFQ4dWl0?=
 =?utf-8?B?cDRCajVQOERscEptYnI0WHc1d2ZvTVZITW5KV3YxeXpNRkZnK0E3QU0vbldH?=
 =?utf-8?B?cW42SXNSbjNCN2kxQW1SMThGcHFjeVRVYWgrRVpoTXovQUhPZ1pDUFNhWStD?=
 =?utf-8?B?WCtIQzVYN3g2bDQxaDJDOG5lSGxsU1hrVDNCREdOVDc5ejFBV0p4dGpvVVRQ?=
 =?utf-8?B?cWJwZXAyeEpWZlFGQ1htd1RNVm1iTzRzZFFlZi9jREVXS0UwcXRrWHdidUNL?=
 =?utf-8?B?VFozaE03aUZmMWdaMjN5bXpNbDVvR2ZyWm9SSzJrVHAyaG9UbWoydHBQM3ZX?=
 =?utf-8?B?UmNNODltK2M2YVVUM010ODRjNVp4MWFxanpNRjJqN2diZDJ2czBWbC9GL25o?=
 =?utf-8?B?ZGN5N0ZNTTdBeCtkc3plYXh5UHhYeDFiRFBJSG5URG5ycG5Db2ZXK25jYnp4?=
 =?utf-8?B?bE4weEhpR1JIelRnckRvODRiUWZLbWFabVA4WFVla3dxbWs2ektDVTBvdjRz?=
 =?utf-8?B?WlY0clI4ZTkxcU0veFZaZEo1TCsxUkRqUHBQaUtTYlFTc3FxeXQ5Q3Rlcngr?=
 =?utf-8?B?b055b3dtbVIzRyt0UGtGVVU4WGwyaTVUVVJmTHNyaENYNkxSSllScUlIZHRJ?=
 =?utf-8?B?eW9JRk1mR1Jrelc1dnpkSUpHUWlhT3VSSUpESkwreDNLdG1VTWlUYW9RUXZ1?=
 =?utf-8?B?MllOWFRvVVFtS3BWUW84dTB6ZEh5aENFOVFrQ1ZoaGs5dmltTlpMaTdiUFJ3?=
 =?utf-8?B?R2hlQXhzZnpjOWNNS2lTZjR4TFVUSi9JeVdWZFpNSlBjQkhScE1QY0FsSE1S?=
 =?utf-8?B?SzQvWHJSaE5mSmY5TWRnV3RoTjNnSlNhaUs0MFZBQjhNdHcwMUdWQ2hBRmVh?=
 =?utf-8?B?VllmTlZibXFZQzR3bFlqZldacUY4U0hmMFE4a081YmVWOEU1ZThQeTVtVnZ3?=
 =?utf-8?B?VVZING5lOG80bldXUzdBQzdSWXBLTWJQdmp2MGZtc3RhRWo4REdERTF0UUJN?=
 =?utf-8?B?elZwWjdlN3NFMEx3UU1rM2dZWDM4eis0TnBTRWEwa1haZWhjNm5iYjF3RVpT?=
 =?utf-8?B?YzlnWlo3bzA5Y1c3a1lJV01VeTVKNm1DYWVJZ25yUTNBTGFGYjFjMzEwUEhS?=
 =?utf-8?B?VjlrNDVzSit4Z1ZnQkE2U3hmaVlSY2VSRnBDVC9tUktheW1HYUlzdDlseVVk?=
 =?utf-8?B?ZFQ3ZzJEcVV2d2drKzc1YTdCaWs1NVh0VXdLeVZqSS9qMWtxOGVaQ01zNVE3?=
 =?utf-8?B?cWZ4QXptbkE5SWFPdkd1ckJ6ZmFydG5LZGpPeVZSKzc5QlNnM2h2TjB2RnRY?=
 =?utf-8?B?SzBiTlJMODZ3Z0t2UDNDcjNpTHJZYXVNRkpsU2JjMGxzbE5DeGFIZlVaOVFU?=
 =?utf-8?B?VUI4bWs2YVlPblQ3NVZUb01FcHBSY1V4RTkyRG5WeFd2ZGNEbDg0dUtEN3d6?=
 =?utf-8?B?VEJIL25COG9QbENwM3MxNlNOK3dIMWU0cjZNeGM4NHRva1NORGpXUlNCZ0d3?=
 =?utf-8?B?cldGQllySEVQdk5hMGI1MWdDa2Q0aUNYQytleWdqdXF6UmdRSHN1RHk0ZC8z?=
 =?utf-8?B?WGErK2VPVWNaT3FpU256Z0RtYU0wYkFjb1FVV2FHZjBkSWFiYm9BTVBWVmt4?=
 =?utf-8?B?TlpMUGo3M0hsMnd3aFM4SnVLeHFqS3c4Z25XaHpoOWt3MEwzWEZIS1E0cmxi?=
 =?utf-8?Q?8IoJkIgfIfw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NlZ0L3VYa1BnTE1PNGxxcVdsdlRFK3VoWXlRbWV5c1Z3Z1liTTY4eEN1ckth?=
 =?utf-8?B?OU13OXVjcEFGWXluZTZHaTdKSkRrb28vTk9Xa1hUZHpPeDVFOGt0VGxTRnVX?=
 =?utf-8?B?bXF1d2g1WlIxenNWeitVM1F4c0oxZXNXUlBpV0hjNmNWVGNwTXFqa0FMRGVw?=
 =?utf-8?B?eDVSa1RJVXBWWjZJT2FLS3VrMGJ0aCswNEpWNkdDdm05SzNrM1ZKTVB5UmQy?=
 =?utf-8?B?YmpmSWtxTmtwSS9KVDVQZW5BdDZUZ1hPNVRKdHE5L1k4R0Rwb1ZEREt2cGo3?=
 =?utf-8?B?aHh5RTBPZjd0MHpGVnJRS2FXYVRjNVRXZW9pK0VhQWMzR1BBbEpIemJBRmtQ?=
 =?utf-8?B?YjNQMENXd1kwZ1plRG1NSm8rZUYraWVNVTBPM05kaERmbHBLaEV2UUhlcXgw?=
 =?utf-8?B?UHJtaE56cjM3Zlp0M094MG9OWHBHdVVJMWE5bWlqWWhQWWdEbG9VQk1GNis5?=
 =?utf-8?B?aHdMQ3Y1NkxBVDdTdTg1R2h1ZmdFRXhSeXlCZU54R3hKN1JSYmkvekdFQWhh?=
 =?utf-8?B?a29EQVhhVENxMEw3c3JTWEY0STNTSFU5VGlrR3NLQmFlb2xQRHNBRUxrOGlW?=
 =?utf-8?B?NW1hbThkek5PTWxqUUoyUGZ3ZHpTbHlUWjdRYTZrMHBObTE3d25kNDFkb0lJ?=
 =?utf-8?B?dFRzZFNrUkRsRENDNHBOa1RqWjRGaGNQOUg1QmhwUVF4MXRrRHdSRHFEOFY0?=
 =?utf-8?B?Mm53aHdDNVlSTVZiVzAzbVhXR3Bid2wzdDJXOS9kUmQ0MnRjTWROcUdqelpN?=
 =?utf-8?B?UDlTelVTbStudzJkajhqbzZMWXg1Vno1YnZxMjJrRVNqcVBHa0h6STkzUmRw?=
 =?utf-8?B?bW5yMEhzdTJZSTEwWTlpMG5SamlnOW41TWRtVGg0V1VaMjRzTUFRbUdHY0ti?=
 =?utf-8?B?djhQRFRwNFpMMXpTcUZVc0ZVWGNSdUMxQzV5dkdwdThSWVNzNzNBWG1Dc3NK?=
 =?utf-8?B?SklmY0NTRUt2dkN4czI5QUZYNmZwUEVQd2hOb2NlVnZ0azRhQzlFK3ZCQWVO?=
 =?utf-8?B?WVphNFlTMEZHUkxRY0E3QjIzem9KOWlPRmN1T01jbzlCVUNPNTRtVnNaLzhY?=
 =?utf-8?B?Q2ZuWU9qcmRqdnlXSmRTL25rNG1KQlJIYVVGTmRhanltWGQ4dk0zZFd4OVJq?=
 =?utf-8?B?eFl5SUFKL3R2RnYvR0plQzdSQnJpajFnY0ZMaHBnRWxVVWtDaTdOOHd2QnFm?=
 =?utf-8?B?dHNHMU1FdW15Y2xQTVJmZmF5eHplQkZhQnJoMkZjUWF3S3ZqcU1qNHVxWFgw?=
 =?utf-8?B?c01iZjJDQ241Ym0vWC9ZRlVkYU9aVDUxM1ZMVTFmZ0NHUTdXUmM0dEFraWtO?=
 =?utf-8?B?a3Y5UzRQazczcmNHNHdWNjVZZUNBSElCcndYanB2dXpYTkpaK3ViQitzc1FJ?=
 =?utf-8?B?SWpxemJWbFByL2JNK0taNDlqOE52TG95cTI4cjRFM013N0orc1VWTE96UU1a?=
 =?utf-8?B?bzFwU3BNTkhRTXpLZndYelVNcUpUU0t5ODJtbDBNRmRadlREN2tYN040UUNz?=
 =?utf-8?B?RHV2SzlpTlFzZFNxaHJoK0syT3NYNEpUTHF5bndMR2h2UkhNVkJFNVJhUjMr?=
 =?utf-8?B?QlJneUdCbGdqS1R1REpoakRhc1BCcTROVWxzcTZ5cytFRkVzblZGYVZGeEJS?=
 =?utf-8?B?THpMWEpLWnFHSUhJYU9JR202ZnNodDBvTlZtMnNhWFpqYkxXalliS1J1L3pY?=
 =?utf-8?B?TmdGWkFXZFFyaWlpMUE4WGRtUjI3THd1cmZGNEd0UGJWUjQwdjV3UFI1aElk?=
 =?utf-8?B?cFhIelU2Ykl1ekJkRnk3a1BjWWFYVklZQ0Q2VHg4N0l5N1dIaG1RMUJwVlY0?=
 =?utf-8?B?TE1OblU3MnYwMDJPVFZObGoyZXNJT2V5U3k1ZURLYWt4L2hGZlBLcUVMVzhp?=
 =?utf-8?B?WkJsT2YrMFdia3Q0OTVRYVR6cmh5RGo5bzFWalVWc3plU21tZjVRNnQrcEVY?=
 =?utf-8?B?dDZqTytDVkcxZi9vSFcwZld6d3Vpc2xJQitKSys0ZEVtWkNMT2tseFJPNGZB?=
 =?utf-8?B?K3AyUFAvejk3YkNvTDRLZzNWVUlQa0hUZTRXeHZMdTlsYXZ4Smh6cnE1WnUx?=
 =?utf-8?B?eEpGazJ2UGY3blU3ZHdDVWdYYU5BYkVzeWZBdGdkSmoyVkRuRVJsMHhjMGpI?=
 =?utf-8?B?SEczdWNqejRTTHVxQ3ZaWVoyNWdlVi95aVRWUkRYMWRXcVdxQUxHaVZmRy9W?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AvoDaHLdUcBvbUNclZfZFqPAaP3hq+O/XbGwsaeZbc7w3A3KOhmVcDeKhpHjmPKhAtONsfN4i2tNPYeRxV6lnaar+s2xLyX3caWrQCvPZg/XRE9mzrvdIiwpLWSLVRo/P/A6yFt/pDu3RHIkcr95AZV+rsSnld3hS1JlBV6JFFqSv0ayfLSZqzcagVT8j4OkyS/AjuZBBUYlh3KllZgRzFqi3RYOW4Rt5pP8NX62NtFXKm/ZLP91b+XPHpF8BpRdEtjp5UEaGTZ4loVN6wzFZACBA2gC7EgR5tFtt2op9T9eCWspyvodBWVaWU6g6Ia5no6Lg060hAYR3fgywNNBkhecGgbYUf5cZ2IYt1zUlSLSmbvneKeK9fBBhCxTo8s8+4fkpqJRoWJAC3EWXSauMqXUtgequUD0UOu+UVGjS2ir7PY0ahrV52hR9a7aKmF3JL6NAZG+93X0WB6d4doIAglHqM4bxSmbdnn+wL23rREPBciXYWFXHSHn3939VSAE5ngmwiN3S6ZX8InxM27o3kCQlnM5zlqa7bf4lT/Y8JbT6/uB2JH02U+hScPCRLKzhRGCfYOMPBzyE48HQ9yvMEtk3VJOjdoyouLO6Q1BfH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac1b4c-7638-4702-825e-08ddadd4e35c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:26:41.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25Kgp1T1dM2tpmZHiofF7r6FaLQmmtqNnPrpxblupTiQpr9qHNbKqqK6x0OaUfO1h5VPCIPImcWzQhEilXQ9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE1NiBTYWx0ZWRfX8dv7VIpbq+Lc o9BTeTmY0OdceXnaugjSWBHtp4sCZIENX1z5QhbSxYEaDtxjvresxXj6nE5LZj4EIRhdHPYOdLm ml2nJv2uqhKglNj2pHmmkm5y4MuNu1Kg0U6l06KnGxMnbuWw4FwAe7yk1IPUwCv5fotEeNYcbYl
 ssd6Cihk7vsp+31SflbdSAn2tzt+7AKxZw05dintxQq23UID6Eoaq8nMmN86yj8xNEgaebiuuKl 6IdIqpSn7IWEtCU2B/ePomE43/BpFz1vPKr6WEerCMyQVn/oBKI4laNlDVIGhyqnHJPrpe3HyNm 7YcsMrCavLM5OGKWTA35nuW7Yfde78qmg2awGIIT3t95BztDCtrljNb+V2MWv6WzQCpVt33cU7Z
 SekzAxQWuJFSKeScGR0Zz26D1Q237C7sWQrSNU+AxdlXL9vc0eighMZgM9hkQx8OOsPBqopo
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=6851c175 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=mjoYJOt_0wGypc80EIYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LLYCyK2JyZNoVQm5n990iuG5Nmj57_UP
X-Proofpoint-ORIG-GUID: LLYCyK2JyZNoVQm5n990iuG5Nmj57_UP

On 6/17/25 3:21 PM, Jeff Layton wrote:
> tianshuo han reported a remotely-triggerable crash if the client sends a
> kernel RPC server a specially crafted packet. If decoding the RPC reply
> fails in such a way that SVC_GARBAGE is returned without setting the
> rq_accept_statp pointer, then that pointer can be dereferenced and a
> value stored there.
> 
> If it's the first time the thread has processed an RPC, then that
> pointer will be set to NULL and the kernel will crash. In other cases,
> it could create a memory scribble.
> 
> The server sunrpc code treats a SVC_GARBAGE return from svc_authenticate
> or pg_authenticate as if it should send a GARBAGE_ARGS reply. RFC 5531
> says that if authentication fails that the RPC should be rejected
> instead with a status of AUTH_ERR.
> 
> Handle a SVC_GARBAGE return as an AUTH_ERROR, with a reason of
> AUTH_BADCRED instead of returning GARBAGE_ARGS in that case. This
> sidesteps the whole problem of touching the rpc_accept_statp pointer in
> this situation and avoids the crash.
> 
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 29cd2927fb91 ("SUNRPC: Fix encoding of accepted but unsuccessful RPC replies")
> Reported-by: tianshuo han <hantianshuo233@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This should be more correct. Unfortunately, I don't know of any
> testcases for low-level RPC error handling. That seems like something
> that would be nice to do with pynfs or similar though.
> ---
> Changes in v2:
> - Fix endianness of rq_accept_statp assignment
> - Better describe the way the crash happens and how this fixes it
> - point Fixes: tag at correct patch
> - add Cc: stable tag
> ---
>  net/sunrpc/svc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 939b6239df8ab6229ce34836d77d3a6b983fbbb7..99050ab1435148ac5d52b697ab1a771b9e948143 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1375,7 +1375,8 @@ svc_process_common(struct svc_rqst *rqstp)
>  	case SVC_OK:
>  		break;
>  	case SVC_GARBAGE:
> -		goto err_garbage_args;
> +		rqstp->rq_auth_stat = rpc_autherr_badcred;
> +		goto err_bad_auth;
>  	case SVC_SYSERR:
>  		goto err_system_err;
>  	case SVC_DENIED:
> @@ -1516,14 +1517,6 @@ svc_process_common(struct svc_rqst *rqstp)
>  	*rqstp->rq_accept_statp = rpc_proc_unavail;
>  	goto sendit;
>  
> -err_garbage_args:
> -	svc_printk(rqstp, "failed to decode RPC header\n");
> -
> -	if (serv->sv_stats)
> -		serv->sv_stats->rpcbadfmt++;
> -	*rqstp->rq_accept_statp = rpc_garbage_args;
> -	goto sendit;
> -
>  err_system_err:
>  	if (serv->sv_stats)
>  		serv->sv_stats->rpcbadfmt++;
> 
> ---
> base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
> change-id: 20250617-rpc-6-16-cc7a23e9c961
> 
> Best regards,

LGTM

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

I see that stable@ just snuck in there.


-- 
Chuck Lever

