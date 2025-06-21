Return-Path: <stable+bounces-155232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB0AE2AE7
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 20:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1243B3AEC
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33514B06C;
	Sat, 21 Jun 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NnaMfW9C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nCilV40g"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0BA95C
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528857; cv=fail; b=daKT38zHuiSiM7c/Tg+Ex+Hrcxhd3S/56PJ4r9b0Hptyas45ZxOSngz1KT/rKl39XYPpZypckYlziqNb5b4zFvpb9yFL1Ua6bG6ClSyD3SzWjVcOC900+WYgajjnZnUFjBTz1JfzjGxkTl96YVgtqeSjHXdkPpcoV2uLdPGcxhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528857; c=relaxed/simple;
	bh=9yFIMqb8p4JIuo9IGragqg5Tq6lJU5QCsjqwsNQv6l4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lcpxp18ZNw/edwSl1vt4Lwy5jCbRWyEjmaCY99WtTQRw+zBF8w1X/+Qw7utDS4lFmo5XqjtPMwszy53rEZtfqdk5xTc/fmo5B3rUZCOyCJd/Phea901N7CKRbdn7+NXbZocKaBcXyKWg9/DAqvHX+sCyoIFIirkOBjj1Mwf3Czo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NnaMfW9C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nCilV40g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LAMvfs015399;
	Sat, 21 Jun 2025 18:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9WWUSKbH4UDCWSbB+HGWuv/Sz+8WEdq/TJOMTENGhpc=; b=
	NnaMfW9CcLDwP4slVYX/oEuIpeaH+aPUHnxwTUh0Nd6Ds4WhOSAqcNn7pkrnZkts
	vpZFohJU5d3FGEvahYlH4vkhR0tYc7zbVj6JYP9rkofN0gK2kNW39EDQMNnm3Rjb
	XOjhKwL5nEIPV9Yt40Ls8JubqFlSrO29EvhwL2ajoJItxguy7KfPzKk63TaPUZNY
	avidQCicIdxIGUMnBomSWCx7cnR5RWY4TuAVInMbO+X45momcj8V+2KXJO/fZ4+f
	MI2ykvl62MpkyJfHL1n2EZP779mcm+rs2Afdbi88bqBi1KIPmUqWxZwBgtaQSbsb
	6rr0HbnNZUhmbZ4mkbEDig==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87rb0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 18:00:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55LECG6Z010715;
	Sat, 21 Jun 2025 18:00:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47dk67mr8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 18:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAEuVoU7kZUmc13tnTO3W+OXJMfCKghwYFMOCqPFJaWO7Qu+raee05baTaBm9DQdmsR523HcWrIDJt7rl0hxrMd8SxTTpL/r1UqhFQvRt+fVhZn0v1be06tJ6GeG7E0BlO2Pv8zvr5klfn0WzJ3qA/TepTb+KerzVqJ+k9/bK9ijfGewjMALBjIlQnPxtN7Ro9yYAoXkCj5qXSnK/Tq5yGdLFg4AB3mP7zltQf3McgIc6K7hZaEI7wACWXyFGyBlyz6Zu4QZUJAiWuDX8OOSGqgcY4CjoVXgLFELFKuBlB/HXsJTjYkS3qbWZdCZxJeQCfzlbCezS9VMkpz8j2mIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WWUSKbH4UDCWSbB+HGWuv/Sz+8WEdq/TJOMTENGhpc=;
 b=nHUgYQjKrTp5olG0DsyVeY6WalQhSMOV5PrhQrBGa3QHjBM2IWUElRDiEkpp82gRlcvu++Dc1CNWqN4YlIfV4tk1wpJPdkalexklKdiQJb7xLy5HTMzk+6Zx8U++4+A1VWSfbnt30tUTPgSu/Ej/qBBdXAvGKBniYacHtkuszfDHkGiHccyS+3EtE2Wv4saAvVJ7V2M9INnss1s9PPwYTRuc0xh+OnXZUDtJCZDfdvg4ZhO2n28Q8fS8WnReq3RSTXu8MsR1f5KDjvQWfbTwlPvB9VO5vmT83XaPylpaxD0WowIsABN86lnj7uouGjKb16GUGMZw4XEcLAH4V00bsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WWUSKbH4UDCWSbB+HGWuv/Sz+8WEdq/TJOMTENGhpc=;
 b=nCilV40gTxE7K2Wa2kWppCFNAuiVEJ9wq1LK3uqWr42oF+e2I62DuNXcFDAhZMDuWT2TOCm7k+eRBSkF0Q5Y7XUP2vYgqpUeVudzd1fGu7BHlC3kV/qIKjnuwgpR79pvbRzMe1tBj+bXl9ncu/ftirvEB5y3xKqMXaQvC2j4i+8=
Received: from BY5PR10MB3828.namprd10.prod.outlook.com (2603:10b6:a03:1f8::17)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Sat, 21 Jun
 2025 18:00:47 +0000
Received: from BY5PR10MB3828.namprd10.prod.outlook.com
 ([fe80::bf2c:d4e4:17a9:892c]) by BY5PR10MB3828.namprd10.prod.outlook.com
 ([fe80::bf2c:d4e4:17a9:892c%4]) with mapi id 15.20.8857.025; Sat, 21 Jun 2025
 18:00:47 +0000
Message-ID: <9ddde997-df26-41d8-b51d-90572eb2c9dc@oracle.com>
Date: Sat, 21 Jun 2025 23:30:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 0/5] Backport few sfq fixes
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: tavip@google.com, edumazet@google.com
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::19) To BY5PR10MB3828.namprd10.prod.outlook.com
 (2603:10b6:a03:1f8::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3828:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: e88e3e7a-66e8-4c53-5373-08ddb0ed8a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dElSM25TUWhCNzdDQU03TUNpOXVtU2hXbEZYUWR2aVVkMU43b0NNQitmU3lS?=
 =?utf-8?B?aUZaNktwY1kzbkJISGUyMS84WkNWRkVYWXJZUlR4MG1oalh4MVlOM1kyR3Zu?=
 =?utf-8?B?aFk1MWcveVNQVFNrdGkyYTd5K2p3amhLVm84KzJkYk5HT05jRlA4L3pWUEhz?=
 =?utf-8?B?Z2VkdFpLKzBQeHBkOWJDbGNXSVRKTVFFUmxiQVltOFJaVVdwNzhJdUM5ZERN?=
 =?utf-8?B?OGhTVlZ2K1p0bjErd0VXcE9laWt6alVTTGx5dlVBRlVpdnJkWnphTEM1WkVM?=
 =?utf-8?B?djZqcHc4Q2tmNThnT3M5aFBOVnNrYUJEWWRySlFDc2RjSVJDeE5pcXNMeEh6?=
 =?utf-8?B?V3NBWWhYSlJpU21ibWl2cWJXYXAvMDByMkoxUXB1WDg1TnN5VW1kSnpJOHYw?=
 =?utf-8?B?NkFRL0lhUWYxRnIweWx3dE9LcUZlZHIzS0QxQ2lQMFZENG9kbnpoVDRTYW5W?=
 =?utf-8?B?VnFmbTVOeld3RGIrVTJ4MldQVmdRaTBwbFo1cGV5d2ZrU0tXODFKb2FCenhp?=
 =?utf-8?B?VzNDZU82RkR2TXV6emdMRXJIRTRFcEJkb0htQkNMUjdBbnU1Mkx5TlNYaUJs?=
 =?utf-8?B?M0ZvYjc1S21oY0JKRmc4ckNCR3NHaWNleHIyQURsNkd1VWV3YUxUWlZ0ZmpV?=
 =?utf-8?B?Tk5QQXZHanJ4eWdIaTFtd0hNV0dqSG5seCtqdnBOUW9tZUl3SC9YVlJlcFk4?=
 =?utf-8?B?UEwwWndkK2daKzFKQ09SZWdVWm8yOFRFMy9hd3lJVmNhbG1zV2lOMWN6VGJL?=
 =?utf-8?B?VUtKdWREdWVINXMwQStjbGw3T2ZOWU41VFYydXYwMjY1V045ckI4dkVLVGk3?=
 =?utf-8?B?cm9MQTdtcTZrVmNuN1J3SGhSQldvb3RrUU9jUUgyaWVRTEd3bDQvL0RrKy9E?=
 =?utf-8?B?NUtmZlgyWGJHb25rVVY3N05pZVNqYnBYUWNLQy85bWgxbGo0NVJ6VGxRNEpC?=
 =?utf-8?B?NkFyVFRaNGdnTUd3VmpxM1pteTE0RXM3c3ZVTWZQZ053OEVYNUFXOU51UTZY?=
 =?utf-8?B?cDF2blhnMGdaQUk0RHl5M01qUlpWU2htYWYyT1hrZ0FDZTJsNS85dDFmM1Fi?=
 =?utf-8?B?ZkxrY3hVVVprbTR4a3NYWFdJRHNyMm50ZmRqSER6ZVRTWWJPdmd6V2gzVE11?=
 =?utf-8?B?MmUyTzkrMTBBQzhrMGdpQXVTWHZ2MFRWMUhWOEEvZnpsL04veVZYUVFEMlRt?=
 =?utf-8?B?SGtxOXA4U2sxTlBLNWx5VHViUUhFaWdYcjdScDA2UTMzZnZOVHNBVE1UMGFT?=
 =?utf-8?B?VlY5RElEY3dKcHlsUGQxaVFSRThDeHUrMTd1aDhFN2d6L0RkM0dkTC9Sdmh0?=
 =?utf-8?B?T2VCeXlnUVE0ZFp5b1E5UWNrc1I4WVBOV295azNob2JlRTR0ZGJla0VZYTRl?=
 =?utf-8?B?Y1gwbExzd1dOL2lwKyt2SmMrbmVTQWlyYmNJdFY1UDhHRE9GamRLR3B4UEtx?=
 =?utf-8?B?Mm8zbHJNMWdUd2VaVG5SK28zV2dVT3lQNDQzQTBwamJUOWNwMkMyaEkrNFVm?=
 =?utf-8?B?aTZYMHZhOVpIVTNQa1pNZTd1cWY1MmRJSDY5ME1PekErVDF6dlRRckV1V041?=
 =?utf-8?B?L1Y3d2ZxRGZ6VTVDRVVOUkVVaGdMRkFaeGpkdW5DU2hBdFp6ckhZMHFIVkhO?=
 =?utf-8?B?Y3dCaHEzelVTNXpveVhjNzJjcTAwL2ZKeVNxUTNCa1pOK2xvYjY4elZSQy8x?=
 =?utf-8?B?cjQ1SlZiTGR5NDI0MithRG1MQmtwM05ub2s4TjJnd2o0bXI3UkFEZENTcEVz?=
 =?utf-8?B?Q3hrTVpOT1kzWnVzVUlYMFQvcytIbEoxckNBNWtNdElYUzRZMEZDbmR3a045?=
 =?utf-8?B?cU1KRUFXMHhJZGlvNjNyclpuVmtYdHNyaFRQaHExU241MDdFQXUzcVdaSXJk?=
 =?utf-8?B?cGVTeU1ya2hNRHhKcWw1R0x3c2NxL2JhNlZwK3A1Q1k4d0M4cFhWbEcza0g3?=
 =?utf-8?Q?PnbyXYAYWwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3828.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWdHSzdLVm5BS1hjRXltSEZiSnlMc1V5MjNrNFp2TFd1UXJQMzVibjNmbWd6?=
 =?utf-8?B?dEM4NUQ0VXVQQWlwMzlHUEl4Z3BCLzRRODRGREZhenNWUjdRREZBcnVaT21n?=
 =?utf-8?B?SDlxZzh3SGdWWHJxWnl0anNiQ0tJMWRjZjVoWXlWckh0MVlJZHBNZmpWUTQ0?=
 =?utf-8?B?dlNOQXFtK2pPNWZQQXBzMFpHYk9OTGNHSDEwRFZnS2tDNmRIbTU5TlUwN3V3?=
 =?utf-8?B?Z21DZFFmYXd3d284YisxTHI3OGY2L2ZIOFFlV0pUbzd2UWxGazlKT0QxNXFK?=
 =?utf-8?B?aFhqUmJuRG5PSk43TnNYSGZ2bmxnV3EzbGxGL3d0M3JtZzdyWS9lK05iY252?=
 =?utf-8?B?VUJySU9hdmZySmd0YzdEZFYxM3ZzcGllcldqMmxjNWZjb1VhWUtaNkhsNjAr?=
 =?utf-8?B?Tms1WWRWYjAxUGxadWRzLy90dEp3WU9UZEdyZ1hlZlN5MEc5L3JCWWFDdXpV?=
 =?utf-8?B?ZDFINHRWWC9NK0dxVCtTQlVDN0taOXdGREJSc3k3Z0JjTXQzVHF1TlltY1lk?=
 =?utf-8?B?NTBYcUd0Y3FEbjZ3WjZqYVgzeFh4cFUwalJ6aG9BaFZOYnRuQ252ZGFHZy9k?=
 =?utf-8?B?b21VdUxJR25RazFiblEwa1NYRExlRzI1bW81Z21OMklGcWZ5TWI2K0RxK2tJ?=
 =?utf-8?B?SFBTTjlSdGJrL2QxVVlUTHlDMkdUQ0c4UXN3SWVWOW1ZaEk2SW5Md0hkV2hH?=
 =?utf-8?B?ejdVYkkzZ2NEV0VZbmo2TzVrRGZSTTFpaHUra2YyRlkyaW95NDF3bkZEKyta?=
 =?utf-8?B?OWd3QVMra0V1Y2VPa1RRU3locFVpUWl4cmJwWFQ1czRMY254Z2ZtYmdoa2pR?=
 =?utf-8?B?OTByVTM4UkFXOE9YWGs1N21VWnd4T291TCtoTUU0VlFEVmg3aTZZbHZWR0xY?=
 =?utf-8?B?dnR5SXRpa2I3WlZSQlorU2tYRW5odm4vbkxzcmlTdHY0Z05LNXpoM0ozcGtB?=
 =?utf-8?B?L0E3aGVhTDM4bXZCQzhHWEU4ejByZ3VKaWcxUlUvWk9jL0l4UG5VRnpqVmV2?=
 =?utf-8?B?VjJLVWp4RnUzS1dPblpjOEx1SGVtSVhGaks0YXV6RDNuNHNPVGM3QU1sRTVi?=
 =?utf-8?B?MmtONW41Ny9zMFNWalROakpMaFdGalJseC82NWo4cjZoZFkyUHpSM1pjRUYr?=
 =?utf-8?B?OTVhMlpvbnhRWWdBK043UHpWU0lMRXBKT0EyZmpwRGNOenZLSXNOY0lzS1Rw?=
 =?utf-8?B?NmlNSFFxRGhUWlJhQm04MEpwRTBib1dsbVhzdUZuTUlLN0JFWnltRGpJaHlG?=
 =?utf-8?B?YXlsdndacHRrazdMNXpmcGUxWWFxdkdaZnhEL3JObk14MmxaTDkvN1dTNmhB?=
 =?utf-8?B?a1ZPM2hlZHdWWElwWDVXMk1hR1ZBVWNNOTN2RVVxdXFBeXBxTTFqdWFrc2dx?=
 =?utf-8?B?d21BUTA4RG9QN25LWlk2aUNNa1VwWWtPcUJ5Z3VWZmRwUGVwZFRlWmZjbDNw?=
 =?utf-8?B?RGpEZmFqOVJ4S0ZpVEM5MlZibUVyUnhMaXhOSHZublU4ODNPejhydWc4NXFo?=
 =?utf-8?B?VUVMT3VuS2lWVmRCM1hSUXdIYVNYUk84MUQyZ29qbWIzQnNCMDBXQlNjRGpa?=
 =?utf-8?B?OXZDNmkyQTc4YitlS2c2WDJjaHAwUTdiSlNZNzZOcEFTR3VvUERBVmxyUUd2?=
 =?utf-8?B?eXFGVjc1UXNtRW84ZUpibUZsVDhZSWI4Z1RaSGM2Mm1EbVFQVUV3amswZFFx?=
 =?utf-8?B?dDM3ZmZHZCtrR2U1NFFjNGRuTmRxQ3h4RHA5NVBDK3A5SStOZ3BJdDBWRGxC?=
 =?utf-8?B?WFdCaWdEM1lEKy90OFROSHVKaXR0UkZ6TStOVjFaZGJOeHQ3WHJvNC9xdkFB?=
 =?utf-8?B?OTczS1RxdHViWC9GWXNjNVIvMHJJTzIzazRycExYT3pTZEZ3TXkwYks3YVNP?=
 =?utf-8?B?VGxUcytFRDYzK001dXVMVXhqOGRTejkxQU9SL3JLNElEdkVLdUxWRkpNSVlw?=
 =?utf-8?B?S0V2d2wweDBRS2psWllDZU5aeVQxRTdubkNpWTdtbEJSM1d3eEMzNEF0bFdU?=
 =?utf-8?B?Z3VudnlrMERkdHNRaDRvZXArTFpkdm1CcmN3YzJ6aGZlNGpEVW5tdWVyUGxs?=
 =?utf-8?B?R29hMVFIWFBNdjlrRzVyZW03clNXZjZiZFlZeGp5a1lhYnl0WVlwL3pEY1pz?=
 =?utf-8?B?VEJTMTNRTlk4SzdVZnJkK3JVOWx0Ry9USFB3Q1dIR0svOTBXY3ZiNmEreDlX?=
 =?utf-8?Q?L+UoM4ls3/+shqM+QhLH01c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/4BWLpCVQ1TRTrbQ5YkELTB9eg9/XHdxMJzOpVhkxnTdAV7mRlulWsukdUuT4FNnBr1Gs1g/06ImB0pbYqf3if4hVf95XtCkx0OP4uibNwqXtEZqOfdXjZDaeVKFPzqF+Jlidp0dPd46AkoWlFEa/nooRYWH3kslleTRZo4YOAwDKfV9F7ALyzZ+MsqOeORcpazDErmQfNuNy9yxnPrjpqFW03bdjXj6g1LKbMEqN/P2Ob4eoACtQxOM6FyMIW7WeRalhSnU+FP6wky2bWzJ8rivizcMVlQbzHkDU3okMF+3/y+VJiPqg8eHGEN1rv6k0GKK26KncM5bqTiRNhCyqrDKzI6hr4FZuywKB/kW1bfhyIoGZADSHnD7wQVe+7yni7hT760+UarrHY9n32JbLR6ZzX6BWgi+kgXR5PGVMXIcdrosIttamHbO8kV37HhsnGkWRgfvSL7PE5jpiof1hvSyPsCbbFnF7Eo/iDyBrg8ek4cvRW4OyIp9VNO17frcZpHkHezcOkHsAFkYuIeKUnGl2OcUC7HzLgaDAC/hwPQhoSMlDhsrtyMns7kKFHBdd2VMg+zGbtsb1zZLHJuAo+XGib0dPsURG4rgcaInwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e3e7a-66e8-4c53-5373-08ddb0ed8a87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3828.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 18:00:46.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz6e6NR/7anLmP11FlRe7iuVRMwZXHZWMKk+BF1dCEh2uuSZYC5qJ/nzqXDaKmfunlAowanr/VgXnRQTcIkPo7dkPYYiC76M2m1EjtuEn82W5bCKeXynY5QvSwg0gE6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506210114
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=6856f352 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=iHKe3FVa-5AzQ3UgXlMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDExMyBTYWx0ZWRfXxBX4exEfVCQu n2dEeS1dLRmc6uFW7YVtah2/rej2/jb2eMPIWFpZoS2Y2WBtoSKGjMXUb9izcE+inO9JTRy0IFS hcaSczw20Etj6pKBj3v8KKPBHT9YOea6ZGDmublpO5pApe6DQOzY17LbcJSFLKvugSwbLohUZN/
 lsmCBdjGs4FNOojlaHiFnYS8ZCYTvurMNQsNR+dsVK7gX7/9ElLf1bCshdD8evwDtX+tkVLUtCY NQqkMkbHTI+8lLWKPOhQTwhdGVs3TGKSf4Bmd+k4qqKm6yE0Kp9IzDyTNBBXpkHEQWu8VoBQ9H6 7+t3OUEfyhtMb/Xf3f+t225JacJwKhKTPOvYvhJPCDV5Jg9/Ls8HsGggQk3o2y8L32DncSwKtZz
 nV+H3q2consq6ITX+Mq4RDtztchMjzdHZfYtZTFGgpGekgMSfHqltMBCN1tqb4hBcXgVZHAy
X-Proofpoint-GUID: O46Wkdqmu3-L7ZWUNQiICBAVZAsxcNHc
X-Proofpoint-ORIG-GUID: O46Wkdqmu3-L7ZWUNQiICBAVZAsxcNHc

Hi stable maintainers,


On 15/06/25 20:54, Harshit Mogalapalli wrote:
> commit: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
> fixes CVE-2024-57996 and commit: b3bf8f63e617 ("net_sched: sch_sfq: move
> the limit validation") fixes CVE-2025-37752.
> 

Ping on this patch series:
5.15.y: 
https://lore.kernel.org/all/20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com/ 
  - [1]

5.10.y: 
https://lore.kernel.org/all/20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com/

But looks like Eric sent these 5 recently as a part of a 7 patch series 
to 5.15.y here:
https://lore.kernel.org/all/20250620154623.331294-1-edumazet@google.com/


Just to avoid any confusion adding context here. I feel like Eric's 
patch series is better as it includes two more new fixes than my series 
while the first 5 backports are exactly same.

Thanks,
Harshit


> Patches 3 and 5 are CVE fixes for above mentioned CVEs. Patch 1,2 and 4
> are pulled in as stable-deps.
> 
> Testeing performed on the patches 5.15.185 kernel with the above 5
> patches: (Used latest upstream kselftests for tc-testing)
> 
> # ./tdc.py -f tc-tests/qdiscs/sfq.json
>   -- ns/SubPlugin.__init__
> Test 7482: Create SFQ with default setting
> Test c186: Create SFQ with limit setting
> Test ae23: Create SFQ with perturb setting
> Test a430: Create SFQ with quantum setting
> Test 4539: Create SFQ with divisor setting
> Test b089: Create SFQ with flows setting
> Test 99a0: Create SFQ with depth setting
> Test 7389: Create SFQ with headdrop setting
> Test 6472: Create SFQ with redflowlimit setting
> Test 8929: Show SFQ class
> Test 4d6f: Check that limit of 1 is rejected
> Test 7f8f: Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)
> Test 5168: Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)
> 
> All test results:
> 
> 1..13
> ok 1 7482 - Create SFQ with default setting
> ok 2 c186 - Create SFQ with limit setting
> ok 3 ae23 - Create SFQ with perturb setting
> ok 4 a430 - Create SFQ with quantum setting
> ok 5 4539 - Create SFQ with divisor setting
> ok 6 b089 - Create SFQ with flows setting
> ok 7 99a0 - Create SFQ with depth setting
> ok 8 7389 - Create SFQ with headdrop setting
> ok 9 6472 - Create SFQ with redflowlimit setting
> ok 10 8929 - Show SFQ class
> ok 11 4d6f - Check that limit of 1 is rejected
> ok 12 7f8f - Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)
> ok 13 5168 - Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)
> 
> 
> # uname -a
> Linux hamogala-vm-6 5.15.185+ #1 SMP Fri Jun 13 18:34:53 GMT 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
> I will try to send similar backports to kernels older than 5.15.y as
> well.
> 
> 
> Thanks,
> Harshit
> 
> Eric Dumazet (2):
>    net_sched: sch_sfq: annotate data-races around q->perturb_period
>    net_sched: sch_sfq: handle bigger packets
> 
> Octavian Purdila (3):
>    net_sched: sch_sfq: don't allow 1 packet limit
>    net_sched: sch_sfq: use a temporary work area for validating
>      configuration
>    net_sched: sch_sfq: move the limit validation
> 
>   net/sched/sch_sfq.c | 112 ++++++++++++++++++++++++++++----------------
>   1 file changed, 71 insertions(+), 41 deletions(-)
> 


