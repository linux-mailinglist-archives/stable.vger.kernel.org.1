Return-Path: <stable+bounces-81480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E58993814
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B328548B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FA1DE3C1;
	Mon,  7 Oct 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DuISihG2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6cJw81B"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A061DE2B3
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332323; cv=fail; b=DMw8ZP4dzXmMZVmirTVW1saB/0bgn1e3AMMcpfqpmNMBATfjbU/JIawURJMhQ7ohE/XVCgkePv9dLzxol9UduNkW23ty/DKE5a33fKo9QOXv4CUBNGaf40B5JeVDOHRsQiBwERc9fYkZuDCYT2Y+zwEtabJE/YUrFoQkluIA29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332323; c=relaxed/simple;
	bh=RRlfjnHbLZ91x4L4/n+aMZjZFVWyNKAayuCKS4tQslk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aRWsjQ9AazqxWYVwF98Td7tGuRlmUS+ZhtSMZipwN8XBdpkOo2gvzayiIE4xYqiuiI17xXOkJrhz2TznFVtSiI1bNXeZExtq63kU8IuHFmbVkkgGo8u3Ln7EXnh1xYtoEDJMeSRqHgbHZmy8HJyYI/tOyOxNlSaZBEOg/ymCd18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DuISihG2; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6cJw81B reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0XXZ021911
	for <stable@vger.kernel.org>; Mon, 7 Oct 2024 20:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=C6/ER/7VLcbK7F0Fc8OWx3XfjBWgGl/LQUp9/X1PyNc=; b=
	DuISihG2WyZpbNI5k6DcpxteUMqW6zDTbBQ4FdhV2p6KZrtMaRFBmtFH5duRAuYt
	L/IgTo3Shtj7Tu/lRJHI651tIsHN0prgu1VzWyN+jDKuE8Zbl1YapIgKwRkwEQUX
	8JtIVeoKLe/c4FoQCn4Inn8qPfgQjplOiSZGtO0kAMCcdqEGE6Ux3Dn7bv4qDMeI
	++YimzbpJlpx2S0mx/jylmLI8e90QYCpStoRVDggD/iZhAEnr6Szfr07ccIYgeot
	tj1xsoCJGjmNng3IhhNKi3wGfA4+Z9o/3RtJQwlj4kXTHaItlLSnn6uCwFbl2309
	3IhLDLf+WXhhuLkCprROSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034mfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 07 Oct 2024 20:18:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497IlxWG003035
	for <stable@vger.kernel.org>; Mon, 7 Oct 2024 20:18:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwcj2yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 07 Oct 2024 20:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APXpgqELEntVm+K0m7bP4yeyoAotOdi/AuODSoksmxpofThLe470KMfAdgKrf1YnHAKoAMcQb/fCoQjHD/b9cYDZCv5vqKI8Z8Z3Ua3FxhZwY4/u/aowiGAIZrQjukN7g1umVjDIKusxVEIoZ+KGaVBBy3TG3GX19J1QBLOl5tBLWRNaM6M7nyk98vm4s0DPvUOD2G2sPx3GcXFrD8iw7Zs+cMkQSbY1hcvGQAB16OtiVVEWGUdJHieRs9A8g8kMgEFIS2LdQsEC6oOSDxmaySqBI16u5X9EzQNhXYjo5xEaziDDeYqjPXfJVA/xbwQZMb1S5jbI7MOTkiEHpq/LbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLii2agax/APdHHnfEKbYiTa0pYN8hwX3uM2OtI05hg=;
 b=b2rhsqdwtGd5DFNY91ozC4UhffUeaCyGeWDLdMJeobraZMdv4wtNK5pnCiyYSaqxo6c3zY/ERNeKNPuAdB8G79wCA/E74HSN07v7/kLUhkfBFQoirLtCyyWmI7OCxl6aa2hJCMTI1xP8iMQzX0jUxIFPRqLsqbM8jdQbJAhsgURMDjyMv8Rdz0gjZ+pM8+N7yfTC8kSUw7BGQFCCHMQQ1sa5GOpVfHt9U/4etkquZdMxWEIyMDBZ3b2psJCTAxHxFcWeQRNtHMLt9DKoeBXLPcvq1Edc0lKExJPjzsFmdW4623YKyAy3cONmtQAzN5jKryRqh1g6zBsI9MYsBBurZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLii2agax/APdHHnfEKbYiTa0pYN8hwX3uM2OtI05hg=;
 b=w6cJw81BlYyHYnGkbiASAJDdfDOp40Td1Xu7K9CQK5X09qmo8Jotb/Hxko3NsevqLHjvLmmJAlK7QIx8l3a7R//ZVcNgZYWZm27TCACbOnrKuk9a2qSyGmN1dPmSN3yQXnHQdjyLHUzT+UmJR8IQd6nPwn2Qr2AnlHhoqer6bac=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 20:18:14 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:18:13 +0000
Date: Mon, 7 Oct 2024 16:18:11 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-stable <stable@vger.kernel.org>
Cc: chuck.lever@oracle.com
Subject: Re: queue-5.10 panic on shutdown
Message-ID: <ZwRCA4RWiow4zTjV@tissot.1015granger.net>
References: <9D3ADFBD-00AE-479E-8BFD-E9F5E56D6A26@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D3ADFBD-00AE-479E-8BFD-E9F5E56D6A26@oracle.com>
X-ClientProxiedBy: CH0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:610:e5::23) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bd370a-1015-4bc2-6ca9-08dce70d2be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?0btxQdiCFZ8BZyFMNpgh+TaicPfwpDiS5yfhMs+WY9sw7NK/MGefzvQ/WK?=
 =?iso-8859-1?Q?N83nHi5XaGcMjDZbpADlhyO5ZoTDR3FyekeWdjIWzwY7UbOiKcGN/CE1Jr?=
 =?iso-8859-1?Q?1mC/8ahrbhrQmSSm58ZbvIOef4BsJ/kJhtg/cH7odateVjWU3UlJzIxHCn?=
 =?iso-8859-1?Q?RENGtYUa0HJpCL0WGQXdnYXiDTGumPgxw5xO60183LSZ84yICekMnttBdk?=
 =?iso-8859-1?Q?w5Ax+f2pC2meAnfeIiwO8+J7j/24/GacrZcQaFZnQo9vfTa4kZdix70JWJ?=
 =?iso-8859-1?Q?htSua/vepGZTOeXyEBL7DMvM8Scyj3Io6LfFiNL4W+GGHMM7qp6SuEMdw9?=
 =?iso-8859-1?Q?CQUot9Jo1+p4pZDeT9+ixMMWGUUpXFC+xRZdywY0jFEs4UL7MQjgiysAbu?=
 =?iso-8859-1?Q?AfxtteyN1fpi0hUX4bKiuHNdtaAlooffp3RjwuaUDdT9NVjITFeaQhyavv?=
 =?iso-8859-1?Q?DeJeoO5JgIkrF5EYJFzMs30gNq4Gra6oRcMCkCxB2eWt8mo+0mc4D/TVOf?=
 =?iso-8859-1?Q?ysDGXdMNxtRtPwo0DEPt/RTeRt7u86D06j66PLuT6Qlbh2dFUZRwP/Bom0?=
 =?iso-8859-1?Q?D2MFH+0gPAZpElNQM5/w9Pn1xTMwmFeeU4QxkbDs3Un+YuQOdvYw8rKzXu?=
 =?iso-8859-1?Q?WaK0b+tw7PiqGtGGibRSGa6p04BBYq5K3AWGQBB2d6cj7jaQHXk8GzyaLg?=
 =?iso-8859-1?Q?AFrQ2Z945fPZh9AFLq9TwI8JAfYLJONz3uEQIda5t8wGReJkVtbxQ0FOXs?=
 =?iso-8859-1?Q?fpTjOa+oyRJrbi7+uu852BJ62mTyKGwiqe/q7AGkVcYgUKoUJDa1q0YxOW?=
 =?iso-8859-1?Q?mZwoqYml26IiXtsIEN8l+hv1BtL9Ne9j1APgv0BLrbMz1XBBUD98Tx7JRM?=
 =?iso-8859-1?Q?s202HxaFKUBo3NkitEyk6QvjAY4JQ/O55f1zY1XygQWS7dY5iiR/E5xzMM?=
 =?iso-8859-1?Q?xeucVRJNqBDPlj8PJ8kfhKe9KFEcnyZTjIc4I205zMpAkds5voF0gcci9s?=
 =?iso-8859-1?Q?pJX5rOrrYRf1SzH+GthdVs/K0KNsMzZzUdGDLc3Q3nQx5BuNVAPqNGN03V?=
 =?iso-8859-1?Q?8O8A5ibSv74vr78E1ES0m789hgMI5zD3PrPTXrEWzeU1RP6jc4ihL50sLM?=
 =?iso-8859-1?Q?q3LoZQIn6wlkt+wCSk0v2X53cQWW3oLlGa2LbwLvj3Zf1judO2AAWtchG8?=
 =?iso-8859-1?Q?0tMj6+x5eQEQ2JGRspzfCWNnOD+6/cRRlPtzIdRo8vZ5UrpZpKILgC9z8C?=
 =?iso-8859-1?Q?WjaJEl8iDZTKlI+euIQvggnoj4TUK1IJxFRo0Re3Jvu+yM6+Vb9jOA5ZPC?=
 =?iso-8859-1?Q?IXTTx5b847ZyBeyIQ28CUsY8aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?hDExN5SnTH2UPlnTqpNdBzSBeAbqO6ytdl6G0sdj/0Adn79lZjSFCkobgE?=
 =?iso-8859-1?Q?JzobEFMbf1s1ffVTe/w1LUa/I4KShMYUtQatSMK5ya4lEZg+nXLafipwxQ?=
 =?iso-8859-1?Q?T255iRcpm2Wbyd0KJzwOdodsdKlgOg5dDXhQoQA4kTOqfrPuB2DOUA6qOd?=
 =?iso-8859-1?Q?OI1CMl0JW+nf4P7yuBmeCokuB/jyJltu0TE7Oy2amxgkUrL5+yUhL6Itq4?=
 =?iso-8859-1?Q?uca1M3/ZGTrOIhi9xJx6A/8w24Adyz/CSCTYew9T3lh9uK18hsqlGaDBS7?=
 =?iso-8859-1?Q?+gKDK0AliJGq92GyI8Y0P/zJCCaJMm6CzBJXppCSEw+PGmI2C+1byVLC7X?=
 =?iso-8859-1?Q?G71tAPW+wKKzgAxzYZR28Qvz6G+wk/tjpuwpMuM6ubbfRR3tAsScrQUnAB?=
 =?iso-8859-1?Q?ReWxqc7YrIHoDGattKVoUPQRK6ySxj4g/u5VEsWM/TIE3o9EakyYBq7myl?=
 =?iso-8859-1?Q?S0dSbzqVug89OG+2KUFYFOCkJKE0Hk1Fh5HyiC3+o6mRsfkAb0Wh8UEMTF?=
 =?iso-8859-1?Q?SClVhVwL0fu5M/mJYEVUeSaN3VhnmKan+SdExBJ5nNl/wJb9WjDc/f/nyY?=
 =?iso-8859-1?Q?nFc6voEZZ7OmnFbkG4tUyCsI33yVyPEs3B1PIghRjd/TTDwQnpR+A9W43p?=
 =?iso-8859-1?Q?aQ3gjxURK0BMi9PknpRMuaq5zmnXij8NZISWhDDNnixEsOtiK1yK3SFj43?=
 =?iso-8859-1?Q?Bxth5AeKhP3WyU/gDxgXfBiow/5EG6KZ9gklVrjon04v6E5n5iJon+XuUu?=
 =?iso-8859-1?Q?BnpgBThP6t0FfhrMoRA+SKRTKvHJJUSeRr/nrkHwh/DhMxpjhgju/4avCY?=
 =?iso-8859-1?Q?5xw+lXKW3hOiMPyiN31GTurQxaxAH1ny+HWy3uJ2LYyMatRS6wZA5i/cN9?=
 =?iso-8859-1?Q?WAlnlLA5/JhK1sXqy2rN98L7FWh6hLhIATM8SPfs+sAonmPalrQYEAqcrn?=
 =?iso-8859-1?Q?3tnREa6OAdDIwFCaJ4kCm0EohfjlsExUk1fLfe5IU+fYe64QQRKs8jks2H?=
 =?iso-8859-1?Q?120UGpG1Tq+LahkOHGE80fbEQ0sYyKN2cWoCDqlrqymGw/HpHozaaqJcLX?=
 =?iso-8859-1?Q?p4aCoobkmNXCLpn0ngPnALR1i9bieBWm7mBnAFczgil+JDzFnN++9qEi3h?=
 =?iso-8859-1?Q?T4EWct+M1dDlnP6QvcYyfpye8Ki4i+DSRisTW1oY8iS/DeZAppgaZLd9x8?=
 =?iso-8859-1?Q?xvCFa6hQfjodzSK4VTkV7FHWptWoZGfWeNEXaW/ZNmQPy3rwE5kIz5Ocx2?=
 =?iso-8859-1?Q?7ECbX50zDHzgro/0VlUD2xYYBc2o5U3rKP96eR24UBA8Jj1GbypAo2lmix?=
 =?iso-8859-1?Q?RW+MZ6IvBtpNGi5UaRtS9oij/Gg2mbEXSH2LMav9Tbod6iurP++Cti7U3P?=
 =?iso-8859-1?Q?Kueoc853inxM7EhdZIeI4CNTb0XcFTyAdwLW3R5QAH6I9TUIfDZgqIVlV1?=
 =?iso-8859-1?Q?+Zm9hP+/dHBiuWZ7f0QfCCQwuXTMBbfhJO6xaag5TGBScsWqrLipqaV9cB?=
 =?iso-8859-1?Q?cU0qzjgwzoq7qYiXa4Qs6Fqeppy5vAS6K9T4rGoLnPb25nNMPix+scYCfe?=
 =?iso-8859-1?Q?hGmjCNRdJ5JOZeVuji1UGtlhyT3Wuwmis+UM6kz4Dgj8gT89JWpYhYeezy?=
 =?iso-8859-1?Q?FPG4/OiNZF75s/3QpUDPeJlDKlJHvapfT0MP+hZ2vrlhh98Uocn91fiQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6lN9EUqTcgPnglT8//trXFI8DdoIEoP1JDMTkC00b8Tn8sb5drR7DzRbsHeb7yNJSQhZBLQbENSoZdDM7qBzOizHbbYhe2g1myH6txAHDbtfsIx/3hJ/1JC2FSWpIEd4tkRraR2NesIONZGhrLvXa/wqdkshpCY0Jpm6qGCpop30VOGtAbH29cWBfzXDQYYAfVxNzkvEiFJzSXi33oVxtpuanOrTVI2LEqN7PuT7rWCSr25VeqRb3quOytOJfrNnuNIK3s5K0LHvXk6Yfv1yiNc5OlJwWK9BbfOW1ZWk1AnaKjxoXo4nHFH+swumV1vElKPcRBc/iOScUSGQ38mtVUP1+V58B/yjYcbrh/VpfqF64+n+5zwrMJZVbEhcsA3ZCUi9kdr7JcYE79K0acORaL/nXz5OOYffHaQLJ9/PJdyqA4ly6Y6FtEfwlXRcZdeknsJBGJ4GmdwofLn1N/Psd8Q+lh9+RWoNzPElxp9pm1GU7urVNbOheZh3Dllb+CK4D7FbPzsDsJcaoumHujKFRIrmqqDi2RSUdzKWIPYiUpjr7CZoPn05VrtZgNI61qEu2/ktw1X+s3fiWGonI35yvkp9p3Qlij9NTCZeill9qOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bd370a-1015-4bc2-6ca9-08dce70d2be2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:18:13.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiSzNd4Tz3D5XIHc9QJ+4/crgzbDVUaDrY3jd0woY8LYn1CnopsDZY8DrxZicXk3iYh8ynGOwglIYZwPWRHRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_13,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070140
X-Proofpoint-GUID: R4dRthSbdH5T2-v9dMODhtWuAJQL4jGr
X-Proofpoint-ORIG-GUID: R4dRthSbdH5T2-v9dMODhtWuAJQL4jGr

On Mon, Oct 07, 2024 at 10:06:04AM -0400, Chuck Lever wrote:
> Hi-
> 
> I've seen the following panic on shutdown for about
> a week. I've been fighting a stomach bug, so I
> haven't been able to drill into it until now. I'm
> bisecting, but thought I should report the issue
> now.
> 
> 
> [52704.952919] BUG: unable to handle page fault for address: ffffffffffffffe8
> [52704.954545] #PF: supervisor read access in kernel mode
> [52704.955755] #PF: error_code(0x0000) - not-present page
> [52704.956952] PGD 1c4415067 P4D 1c4415067 PUD 1c4417067 PMD 0  [52704.958291] Oops: 0000 [#1] SMP PTI
> [52704.959136] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted 5.10.226-g9ee79287d0d8 #1
> [52704.960950] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
> [52704.962902] RIP: 0010:platform_shutdown+0x9/0x50
> [52704.964010] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
> [52704.968215] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
> [52704.969426] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 0000000000000000
> [52704.971095] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478b6010
> [52704.972758] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 0000000000000000
> [52704.974433] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6ba0440
> [52704.976083] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 0000000000000000
> [52704.977765] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:0000000000000000
> [52704.979653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [52704.981008] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 0000000000170ee0
> [52704.982697] Call Trace:
> [52704.983309]  ? show_regs.cold+0x22/0x2f
> [52704.984223]  ? __die_body+0x28/0xb0
> [52704.985076]  ? __die+0x39/0x4c
> [52704.985827]  ? no_context.constprop.0+0x190/0x480
> [52704.986940]  ? __bad_area_nosemaphore+0x51/0x290
> [52704.988050]  ? bad_area_nosemaphore+0x1e/0x30
> [52704.989082]  ? do_kern_addr_fault+0x9a/0xf0
> [52704.990098]  ? exc_page_fault+0x1d3/0x350
> [52704.991047]  ? asm_exc_page_fault+0x1e/0x30
> [52704.992041]  ? platform_shutdown+0x9/0x50
> [52704.992997]  ? platform_dev_attrs_visible+0x50/0x50
> [52704.994152]  ? device_shutdown+0x260/0x3d0
> [52704.995132]  kernel_restart_prepare+0x4e/0x60
> [52704.996180]  kernel_restart+0x1b/0x50
> [52704.997070]  __do_sys_reboot+0x24d/0x330
> [52704.998026]  ? finish_task_switch+0xf6/0x620
> [52704.999049]  ? __schedule+0x486/0xf50
> [52704.999926]  ? exit_to_user_mode_prepare+0xc3/0x390
> [52705.000840]  __x64_sys_reboot+0x26/0x40
> [52705.001542]  do_syscall_64+0x50/0x90
> [52705.002218]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> [52705.003356] RIP: 0033:0x7f0f1369def7
> [52705.004216] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 af 0c 00 f7 d8 64 89 02 b8
> [52705.008496] RSP: 002b:00007fffcbc9eb48 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> [52705.010235] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f1369def7
> [52705.011915] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [52705.013593] RBP: 00007fffcbc9eda0 R08: 0000000000000000 R09: 00007fffcbc9df40
> [52705.015272] R10: 00007fffcbc9e100 R11: 0000000000000206 R12: 00007fffcbc9ebd8
> [52705.016928] R13: 0000000000000000 R14: 0000000000000000 R15: 000055a7848b1968
> [52705.018585] Modules linked in: sunrpc nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill nf_tables nfnetlink iTCO_wdt intel_rapl_msr intel_rapl_common intel_pmc_bxt kvm_intel iTCO_vendor_support kvm virtio_net irqbypass rapl joydev net_failover i2c_i801 lpc_ich failover i2c_smbus virtio_balloon fuse zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw ghash_clmulni_intel virtio_blk virtio_console qemu_fw_cfg [last unloaded: nft_fib]
> [52705.029015] CR2: ffffffffffffffe8
> [52705.029832] ---[ end trace 40dfe466fd371faa ]---
> [52705.030908] RIP: 0010:platform_shutdown+0x9/0x50
> [52705.031972] Code: 02 00 00 ff 75 dd 31 c0 48 83 05 19 c9 b6 02 01 5d c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47 68 <48> 8b 40 e8 48 85 c0 74 23 55 48 83 ef 10 48 83 05 01 ca b6 02 01
> [52705.036245] RSP: 0018:ffffaaf780013d88 EFLAGS: 00010246
> [52705.037474] RAX: 0000000000000000 RBX: ffff8f91478b6018 RCX: 0000000000000000
> [52705.039143] RDX: 0000000000000001 RSI: ffff8f91478b6018 RDI: ffff8f91478b6010
> [52705.040827] RBP: ffffaaf780013db8 R08: ffff8f91478b4408 R09: 0000000000000000
> [52705.042463] R10: 000000000000000f R11: ffffffffa654d2e0 R12: ffffffffa6ba0440
> [52705.044135] R13: ffff8f91478b6010 R14: ffff8f91478b6090 R15: 0000000000000000
> [52705.045784] FS:  00007f0f126e6b80(0000) GS:ffff8f92b7d80000(0000) knlGS:0000000000000000
> [52705.047637] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [52705.048992] CR2: ffffffffffffffe8 CR3: 00000001501be006 CR4: 0000000000170ee0
> [52705.050655] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [52705.053432] Kernel Offset: 0x23000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [52705.055871] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

The bisect result is:

7f4c4e6312179ddc5a730185dd963d9ff4af010e is the first bad commit
commit 7f4c4e6312179ddc5a730185dd963d9ff4af010e (refs/bisect/bad)
Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
AuthorDate: Thu Nov 19 13:46:11 2020 +0100
Commit:     Sasha Levin <sashal@kernel.org>
CommitDate: Fri Oct 4 19:11:25 2024 -0400

    driver core: platform: use bus_type functions
    
    [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
    
    This works towards the goal mentioned in 2006 in commit 594c8281f905
    ("[PATCH] Add bus_type probe, remove, shutdown methods.").
    
    The functions are moved to where the other bus_type functions are
    defined and renamed to match the already established naming scheme.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Link: https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Stable-dep-of: cfd67903977b ("PCI: xilinx-nwl: Clean up clock on probe failure/removal")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/base/platform.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 1 file changed, 65 insertions(+), 67 deletions(-)


which even seems plausible.


-- 
Chuck Lever

