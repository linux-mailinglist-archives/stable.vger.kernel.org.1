Return-Path: <stable+bounces-217604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKfLnfpmGmuOAMAu9opvQ
	(envelope-from <stable+bounces-217604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:08:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1ED16B5B2
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60284300383F
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7973310625;
	Fri, 20 Feb 2026 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTxz2Q1E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MAfNTyZN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA92BDC28;
	Fri, 20 Feb 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628914; cv=fail; b=sDxrwCKpfWmcyI8GtApa8H7lcnxECBHqpYhO4AdZO9LZ2OeZvoVkETfcpkBPn4zvqpV1tkRgRJ8MJPTXRB5NZiOW4TsKiM3f//oPkGSV6A+69v7Z7DZ6gVHtskbZ4duRhawNcg0KJgF7slt90N7EKmwytCdX0dUQCgDCQO6f2BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628914; c=relaxed/simple;
	bh=V3Vy5w/eLVtQDZQqAv616GBaUmweuA6CRkD3a/IpLPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGM4wE2b5QlwsQ+iAbbv6+GO8Cl3pwS6sJRV9f3IMsNnChQxdmQppWsip+wtmqTu6SQ9HU81DnguqcYx5O7Sl8Y6wGnqzPd3bDPBpDcNj8uIp9F0MKqWjKpOTDSurPtOftcaotbrMTAYPfvjYfEsFO55yEKAemUFpwsUYyZVY20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fTxz2Q1E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MAfNTyZN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDcXkX1057818;
	Fri, 20 Feb 2026 23:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YiDc7VM3wZS0FgS77x1h9qOWtdBEDEn9XPRt73jT2t4=; b=
	fTxz2Q1EtRz4mL6hYQweTsk37zVQZV4d6JjJnseeC+F0Bas41AxMGJJwiYKnD0Ff
	23gLW2E3x8aqbVl0AdEoT2tcnW+R0A1ri5lslHrwzVToAYjdmuERbUmLKfmi4uTH
	HS8xMVhQMCSA3MBkkz84M8MysMPijtNv8MYZD7ML8P7lfpKlruW5FuMI+diJSh/Q
	KrtUBmrNTUVytHXu2XlG31KqTaCAZNigaJmgqyFZqY8Kz5nAOcDksyrZ3cUTAC3D
	FAgwY6b74MgIX06B+fViaVH6TQ/2kHg+DvsBPaHb6dHFPqIcFKUWylXbTyVfYNso
	mnCiVXBw52zcgrxOV5qULg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5ra7mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 23:08:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KLYDgO014928;
	Fri, 20 Feb 2026 23:08:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb26me9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 23:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgoiulDMsVSzVU2BgcZch5J/Tw9HLg80JRzgwfy/MrtLtKU8LptYbM1ox4FfDmkR0l3wYM0nHzaN5+UEi71Y/A/MgCTvUspf13dPfrUBYnfOxrSn2JayiYYVYnRRvEeU/Czrllj4anMaiQ9Mkq1gBlU0UeAmii7lwR0c1/9fgChxrIH78Iert9CyA2B5wIMRs5t0Bc9Jk+mYwF6XWfaR7zAgs+npVY8S0CG7ChZ1oEA2LqFihQx91tSOyh28j+KMRRxIh4kKGmlyMB5rug99injzX/7CJWdetdvoeMu5KObmOjK5tc3kPBOTbmUOe3E6OwW5H0xKARUeWrvSZX9nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiDc7VM3wZS0FgS77x1h9qOWtdBEDEn9XPRt73jT2t4=;
 b=mPZYU7XMLVnVP8WHSLCyQZtNJpDfwLZUnHfjgKWotDOsXzlvUDDZPIBhWVQz/1GEnOBSOeWgXT1Rn+tsdJ4eo1JxSHPAsTXW0vmdgtxvviJnfMUPSizu4QObA5XBmbi3+E3UrVJkzhGR2TJrJ46rP5mSFMmTWSDbQIp94NEXDfCgqBCIxn9S/NDkzHV+FBOA1ADO34hhrfoWtSXvNvYiomJ8wQN1dW5AF5DENj/XLOaPsZqE+BrcZV23dYEKreZevPTvPpcmVlTp+UavIQSpeZEXzDl5xB0x63dGpoxeyluolG9YhRNkvY+r3YmPLV/kwv2yWHFARzIkZG+DlqPrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiDc7VM3wZS0FgS77x1h9qOWtdBEDEn9XPRt73jT2t4=;
 b=MAfNTyZNPWSU021wDqOOIRR6vmjX81d4oujhZjxukBgU1Sw7pkTFo4mOfRHbFLE20PMtDGoSiimcwf8QlpG0gJpRJLH3xa8ZYQgcZgTvmMhXrKeazwXYW9zmNIy2+VuhA7D+zztmuzaUW+17P+7qZGr9ngcewGZi+6mm+roLc7M=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by LV8PR10MB7728.namprd10.prod.outlook.com (2603:10b6:408:1e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 23:08:19 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 23:08:19 +0000
Message-ID: <e1cb6b3f-ab40-46a8-a338-70e4a18f687b@oracle.com>
Date: Sat, 21 Feb 2026 04:38:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 00/14] Address pkey self test failures.
To: Greg KH <gregkh@linuxfoundation.org>,
        "shuah@kernel.org"
 <shuah@kernel.org>
Cc: stable@vger.kernel.org, kevin.brodsky@arm.com,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        linux-kselftest@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
 <2026021904-unclothed-flavored-cdf7@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2026021904-unclothed-flavored-cdf7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|LV8PR10MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 71065473-50e7-4680-21db-08de70d4effc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1haSlZTZVhzUW5NZnJ6eTR0U2hJU3o3WkIrTmpBeVBaOVVoTFhyS0JMdzBm?=
 =?utf-8?B?dnBheVVBbkNQTEdFRitHMzh4SSt0SGRrc1h1WkYrNUc3ajdKdkFnVE9EdUd4?=
 =?utf-8?B?eFdOZ0ROTStpWnVjZjV4Z3ZFVS96Rm1hZGUzbkFkbFZIZldqNGJkQzNOOG9D?=
 =?utf-8?B?RExXemxSK2xVRDJINEJiNGZ2MWRkeWt5KytpdTF2TVd1VHVjSktEUHlXZW5R?=
 =?utf-8?B?UldDcG9pNG42a21hcmpWRjlSZ2psS0Q3OTFnR0VoNDBNNlhpa3hTVEZnMk80?=
 =?utf-8?B?S3UvMFFUY0NYaW1UVVJ4eWw1TjcwQUpOa083WEQ1VG1CUlgzSmtrQU95ejBU?=
 =?utf-8?B?a1RpU01hZzRxbENaMGJETlJ0UXZaUnZNbUdMR0FscXRLdDNJREUrVjBLcTBn?=
 =?utf-8?B?MHhaUUZBV1BISUJ4Um1HSmJjV2dyZStyR1I0aVNycXVIeXc4c1Z0ZXlMUTY5?=
 =?utf-8?B?Z21uRGFvWVkxRFJMNEppQUxYanNIL280c0t1bU96WDZoQUw3Qno0M1B6NmxT?=
 =?utf-8?B?MHJqVmVZMHRiNUhmY05LVUZyNlFYcWo1NU9ZVHlnaHlMNGl3ZjJKRkdaT1h0?=
 =?utf-8?B?K1ZOd3lMTXIxNTVvS0ZxclhLWjJaaTUvNldFWDUwdGhrZU1EeThVSVdhbmY2?=
 =?utf-8?B?aHFaYXNkYnhjT3FNOFRXdXZMTk16RkNuUEdIUTZqdHRnOGVjSXJzeTlHSjJX?=
 =?utf-8?B?RUJ0WG5wRURkQ2g2NkpFcFVMZTg4TnJ0NW9mU0NCT3lVQ0dmMjhuT2hTQXp6?=
 =?utf-8?B?Z1BCWUo5SDhYM1JIeXBVM1Z5TVkzNENhTllFUU5ueXV5VUYyNGVJVjZ2K2JQ?=
 =?utf-8?B?bEpTT1RUdG5xV0tvWjNqZHRYYnQ4bWlKU21Udm9uYVBlUExqS1dOYU90WGxC?=
 =?utf-8?B?cGZmOUxEcks3OWdSQnhFdlhJQXdsQlYzTDJhVWUvRnJoZEUzVHB2U0dxWlho?=
 =?utf-8?B?SmoxYVM0eVBFcUxFTlEzbVVHbS9KM25DK3U0OHE2dG04b25IWklDUlhsNDd6?=
 =?utf-8?B?TTAyVHlzYWlFejY5clZSVVY0dmlhVUN5Z1BWckJiR3V5SDZac2dKblN0MXJM?=
 =?utf-8?B?UFduQU5sSlQwNCtxc1BXQ1Z1dXR1UFFDcDUydys4ZnVLMktYYkc2QnpONFlF?=
 =?utf-8?B?Q0JGV3N5RmNZVjVxbDY5amR2cmV4UWpERWVMTEQrS001MDNEdWJtZDc5dFdy?=
 =?utf-8?B?dzdvendKN212dFBUN0ZKZnVRWW9pVDc2ZTlxdUJ0RmlLNldnVG1XRVdpQzRm?=
 =?utf-8?B?TDJMRDA0MTJDc2xwVkNMNDJydm43elA4TWpuNENDSlQ1c2J0YTgvUzlTcXYr?=
 =?utf-8?B?QmJXbkoxOTdzcThyZktVMmFrZGFyc05PTm1PQ2lyLzdMYTU1NXF3cHcxV2Yw?=
 =?utf-8?B?ZHJIaVZuenBaYTZDNVcyS2gxVVZta21DckpJVHdiY1lGTXo4ajE1cW9PMWla?=
 =?utf-8?B?eVNrMFBBQzV3NHpjUzFFa2NLa09ZcHZYdittSEVHSGJRQXZUTjY3RzRXakFy?=
 =?utf-8?B?Wkp4ZnRGNWxjZVpZaW9iNFhlRldXQ050RjhnRTNkR3RyV3Uvejl3KzRmaWR3?=
 =?utf-8?B?SUtLK0pQTUtmT21pd05YdmJhc1lGV3F1b0Z5Tlp6ZVpPbjF4NGlTZ0xLb1Zr?=
 =?utf-8?B?eUpFd1dEVG1DTnUwZytoY2NLUXpXdW9MaHZCM0JWV2orUXJ2c05RcGdGUm9p?=
 =?utf-8?B?WDNwWS9vMlRsOFpGS2JoZmwvOVZERWg1YXJub0gvQ0ZCc3M5RVk0bWUzWEZo?=
 =?utf-8?B?VXo4eGlBdnVLMFNpZUJ2bjc5elJ0WFZpZUpiVERLNzIwNjBteVUzT2dsWW9Z?=
 =?utf-8?B?UllwWEdLTWhXcmFLVUVXMythWldIbkJTbm04VTFoRklCOWNBSkJmN2l3eGlK?=
 =?utf-8?B?KzVBT2sxK3B1RkM2TmVEWUdZSjJmaHhmTkJ0dzQyckhRcFd6dDROWDBQa1di?=
 =?utf-8?B?ZHlZQXJtMkZ1ZHMvQ2dGK3p0OHE0VWJySjJnMnlGRlJ5Q0dIcloxeldWWUZq?=
 =?utf-8?B?NUYvR2dpSFh5eSswRDdXWUpUWHVnUGZReFY4MVBWWFE4QWtqbGJ4MEc1bWhL?=
 =?utf-8?B?VXdyUVRqbm9HaVVqQ1FqVWxoMHpOb0dVajh2ZlYxcjdzakpGb0JPallmU3VV?=
 =?utf-8?Q?rGEU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZGQm04NnZHRFRSM1EwRnVhU1R5d0NrZTNFV3lxRVBhYW5oNEY3MkxQUDYx?=
 =?utf-8?B?SlhjNzJlcmg5Smd2MWc1L25Fc1lZZ24yVGlzdllwbHJWTWdVTW5sdmhtRGdq?=
 =?utf-8?B?bGVFTmZqRWlPY0VLQ1psdEdxQjdkRllRSXpVbkpNM3V2aElnVFEwdWppcUhK?=
 =?utf-8?B?SVZKVzRVQTREQTBtTFhUd2dWV3FQWlBSeTAxb1BabFI5Umhzc3VVTFF4NXJk?=
 =?utf-8?B?YXA2ZXdZOUl4WE1CbEJ1d29BYndlUWpMQjk1cWNmQ3FncFE0TE1icDhMTkZH?=
 =?utf-8?B?c0xVSXpjcDdHVDRRT3p4SXhxb1BrVUhQMXBiYjNMcnlmUkk0YmUxYlQ2SHhX?=
 =?utf-8?B?TmVJaUVQUW9hNHVmYWsyYjNPK01ERW0xK0p2QTRPbUttK2JKbVNDWVpVWmRO?=
 =?utf-8?B?eWFYMkIxa3FKbTFUajdpbThSc2wrcXM0Z090OXhLRUcxYndXajk1aS9ZYUxl?=
 =?utf-8?B?VUdzT2x2MC9MZElMbE9MWG1DU3VtVmhjby93OG9vWHJQZDJOQjVqRnBHazdz?=
 =?utf-8?B?TTFUWGVhQUlGdWFEQXRmb3hyNGtFMm11aGdMYXpQcVFpR0dmeWtTT1ArN1M1?=
 =?utf-8?B?dnFxVm8xU2NBL252K0tuL1FxOUpMMGc1ZC9OT1QvM3ViNldqeHIyRVc2ZlN5?=
 =?utf-8?B?dEJ5dVpmUFFUa2FsRndybDhiNlFWM3ZiUEJWV3p5ZlM1ZTUyUWowWEdIRS9i?=
 =?utf-8?B?L3AwMElQdXFiZkNtN011YUhaZ1FEdEhXaEVlbWYxVW1hZEVZR0t0RW1MYXJy?=
 =?utf-8?B?aVlYenBRdUgzdjZOeW9HOGZQR3VBL3BqT2JNZXNzLy9yMlR0WDYrQk40YnJB?=
 =?utf-8?B?aHVLeWliYkE2NXlESzNqVHpTck90dktXd29MY1FyaFFOOE9FWTRQSkdJRUE0?=
 =?utf-8?B?b3JRR2taYm94WXFZZEhGS29vcEZ3NitFODRyaElVcWpqMlBhWHJNZ01lWUh1?=
 =?utf-8?B?ODNFUDdMWHArZk9HTklzTENEbkVWRXFLR1pudS91SGlMNVZiWnBNWjdGUjFj?=
 =?utf-8?B?cU05dTlKYmtlY05JU3V5azJ0S3ZiWC80UUhQMDBlMHhhbXJEdzAvSGJjZTZQ?=
 =?utf-8?B?K0Q4V2dWQnFFTFdsSUMrZy9lWGcwbnZlVjdRQ0F3UkRIWjFjUUZwckgyVTJn?=
 =?utf-8?B?VW9KUTFuV0pLM3dxa25IaXpLS2lrdDZ0R3N1VE11bmRlTlhsWjVyNHBwYzMx?=
 =?utf-8?B?N1Y0MHlDbkhHZGlvbFdIL3NsRHdkK1JZZ21oQTZqTHFreHZPa3RBeEdkazVM?=
 =?utf-8?B?cFZJS205dXp4QURudkZhc0g4S0NhYnU0VC9kTnRsTlYybHJxZUpCTFJrK3Vy?=
 =?utf-8?B?QTRMbnhRdGJrSTVwSklVcGE0ZnQzUDI5YytkdzZCK09LTnpBaGh5Q1IyK3pi?=
 =?utf-8?B?VytuNmFmaXBKK3NiMXVhT0hYZERIcGNiblNKTzRKR3hmQXZnUzZzMmxXVXho?=
 =?utf-8?B?a3huNmpFdWI4Nno0NVlHYWZkNURYaE8zd1VrS2oySzZOWWw4cUJ6VUg1V2R5?=
 =?utf-8?B?alpWTFJRVWVZVmdRZ2pPTXU1cW1kbzd1NGFuWUkzMWFxR2lZdEk4UnBEeVBt?=
 =?utf-8?B?YUxDTlR2TGIwemNtSU16TFlPa1UyUTE2d0d1Qysya09CQkxjMHQ5N1lCSVBr?=
 =?utf-8?B?L3l0UXBQeEN5ak55endlQ1plNStpRytYbjAvdS9UTXEvc3hUVFhheUFXbjhI?=
 =?utf-8?B?UTh1bitRZ2pXZVQ2VDhyWkhOamxoV215YzRZMlRFejlWVHo5R2lHazhSMXJv?=
 =?utf-8?B?RWQ3U3V0eWU1VkwxaVl2b0FtRjd2UHVWcUZZR1kwTU1lY1NRa29yTU03R1Ba?=
 =?utf-8?B?T01WWWhEYjNnMTRyZmc1WnU0OUE4SXZMT3FCNFBEdldzQ3l0aXhDdUs5REZS?=
 =?utf-8?B?Z0swNk83ZWVnZjNJaTJHbys4RlZFSUhhZCtTOGxyd2FoS2JqNko4djZvWXlQ?=
 =?utf-8?B?elpUdFFlSitzdXFoLzI3REs1WVdzRlFXaGtMTHNFVFpCQXVHaUlmL3gwVkdC?=
 =?utf-8?B?S3B6TklYd3E0T2NYRlJweTVpVThKNTkyOTVhSS9vbUJkUmhFWTZZZDRFNEZ0?=
 =?utf-8?B?cmRJRlJmU204VmpRS2g4L0JPS2R4NFBhUTl6T2ovTXE2cm9pL1d6SGh0ZE43?=
 =?utf-8?B?dWROWGNKWERnUnEyRjA0bXdPVys3VE1zVXZ4K3RwSjJITm9zdFBQSUtzNFl0?=
 =?utf-8?B?WWhLbEphK2V0blNCWTMyU2g4R1BJVU9vNEVEV0JBQ1dUQkRhUXNkNmlPS1RD?=
 =?utf-8?B?ZTJHY09TcWZYeW1kYW5Xb1I1WlZWY2ExelNGdG9qZWZWQklQTmhwRWtqTFJv?=
 =?utf-8?B?aXZIVVlRckFVNi9EM2tac3FBSndCem1HSGt0Zk5qZkdhQ3hWWTlDbFJPR3dI?=
 =?utf-8?Q?MhRzkTKJXwMjDEhEZqCBWCgKVmbA1dnHyOAbZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z13zL08H7vCJnhG8Y6n0iexw7cLxLPZqvFOi+C+zLqMKnK/ow4cGFUqckdHTc1wzaxWIfI0+43PYxvOfaSNQbwuKRHbBB0K7v7EJXHXNRIH+8JR09AGZ/KwretT5pFvVbnxkjYrI4rjRfnBD9iJWeMCsAcMMqswA1Bnt5rGYT4S+TIT09LlrhS4uFWC+4zH5p8IRDAv3jb1Xv7zUIuk9EvVpeUScQdJil+o/6cb8uQaaHKz2gDl2WtO+zsQZDtcJu49+aHiMtCLNlw+5CFNqx92qV52rLqnrBd91o3s2Du7wC0BmU+l9ULzbEy/VIqJzV6ULI7LnndV/PuXmRAA7El5OhF7Elp91CFVF/+0YerizqzFu+fIhUcbK2nbc02xqvooyaRIMdQ4veNFVGVAhzxfpC0qPHEfcZIPQeIt+N1ZNmSBl1wtiepS6XyMlpk0m+h0aB2C86sFPM/qoVzXlUkhpEBsGlMAay6MaZaC7Ih9C2RzAgNAEFxpbo9y4nVEyMliOUB6mcHcbi+fPIc8DcHSKb4FuT8YekXr5PuW5bNbT1FkI4OwX8i2GuauO6c/4QJLD/LuBPY/b995DbV63tZnWMMJBZWG5Ey+dqOFs9ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71065473-50e7-4680-21db-08de70d4effc
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 23:08:19.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqS3ImDt2FRBPx2i4CVFRwCYWm+CWpElKcqgccS9Mg0nUnfb5IIrQMF6kd/yXXSCC20zPtSzM2n1SYy7PA5FPhXqnNmp5oSfUSjL+GcQ2COrvgHRMeDdbdEBdB4+584a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602200190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE5MCBTYWx0ZWRfXxhE8wM7EZNtc
 GTRSyQcMVsNGxumBvElUWpeNGPkysZrzuvXOfIolelUf0bPWm+HViJojiq6Du9nbQVy7jb+gcQH
 NwfTaZOoYAerh6dyaeNmS3gbmAX9HH7LHoCXPw3GdyBS+BNrcrjP4FVsH5/Aw1jTGPRNTrqtLlG
 DPFEQxDpKyvUmzp6tEWLG7v0+7apoD3WHFQJeU4Nrm6kE+NQDlT7WJk/n0Otmutih691hB4e7CZ
 JvLWeG/BWDpefReyMgVDN191GoVDlTDy1OCRkSah6By5+bxEp6RJ5YscWxgxjmynXNSxXe8ostV
 wh3EkIqLx5zg42c3SKY7KZvpCXX3v4l0/p0lVcUG0V0JgJF0eKxCHXr7r0lwQrE/ybRq18dn4sr
 eiadN/+f5r1gn6MOyG3vJVpe78szih297No8PtRYZzZkqDABOxpVvr5Vbgc6P2+WINTJrq7DQ0i
 yvrq0SJw3/zkwPUIOcQ==
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6998e969 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=hFr-1zYbdyrkq6bfWFEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C1nRjOL5uK_B4Mwvd_p9yVfCcdevyjio
X-Proofpoint-ORIG-GUID: C1nRjOL5uK_B4Mwvd_p9yVfCcdevyjio
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DE1ED16B5B2
X-Rspamd-Action: no action

Hi Greg and Shuah,

On 19/02/26 16:57, Greg KH wrote:
>> All are clean cherry-picks. After patching the selftests the test is
>> correctly skipped. These additional backports cleansup the code and
>> avoids the need for conflict resolution and might help future backports.
> Shouldn't you be always running the latest selftests on older kernels?
> We don't always keep selftests up to date at all, as you can see here,
> but newer selftests should ALWAYS work with older kernels.
> 

Thanks for sharing your insights on this.

Couple of problems around this, would really appreciate your guidance on 
this.

1. Not all new selftests written might be correctly skipping if the 
feature is not supported in older kernels.

Simple Experiment: (very small subset of tests)

- I have installed v6.12.74 kernel on my machine: (Kernel under test: 
v6.12.74)

- I have compiled mm selftests present in tools/testing/selftests/mm/
./run_vmtests.sh with both latest mainline (v6.19+) and (v6.12.74)

- When I have used selftests from v6.12.74 [**]

==================================================================
# SUMMARY: PASS=53 SKIP=3 FAIL=1
1..57
==================================================================


- When I have used selftests from upstream-latest 
(v6.19-10669-g970296997869)

==================================================================
# SUMMARY: PASS=57 SKIP=6 FAIL=7
1..70
==================================================================

We have 7 failures compared 1.(the one that failed from 6.12.74 doesn't 
fail on mainline(it has been updated)

I have taken a look at 7 FAILed ones:

Some of them is(which are failing are)

==================================================================
# # Totals: pass:0 fail:73 xfail:0 xpass:0 skip:17 error:0
# [FAIL]
not ok 38 guard-regions # exit=1
^^ guard-regions test
==================================================================

==================================================================
# # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
# [FAIL]
not ok 40 process_madv # exit=1
==================================================================

==================================================================
# # Totals: pass:13 fail:10 xfail:0 xpass:0 skip:0 error:0
# [FAIL]
not ok 41 merge # exit=1
==================================================================


I didn't check if these are problems with the selftest or something that 
needs fixing in 6.12.74, but given that latest-upstream continues to add 
new tests and when we see new failures as we update selftests, it might 
be tougher to track whether they are regressions in kernel(because they 
are newer tests everytime, and older tests which were passing might also 
change behaviour due to fixes in the test) or newer tests not skipping 
the tests correctly.

2. (Minor concern) We have been seeing some compilation issues with 
latest selftests(maybe due to missing newer packages or build errors 
with newer changes with latest compilers), so always keeping selftests 
up-to-date with latest upstream makes it a bit challenging to keep track 
of new issues(as a new test might not be correctly skipping) on stable 
kernels. (thanks to subramanya for sharing about compilation issues with 
latest, due to different compilers etc.,.)


[**] -- I have to skip one test among (57) as it just doesn't complete 
forever.

> I think trying to keep these all up to date is going to be "a lot", are
> you sure it is going to be worth it?
> 

I do fully agree. At the same time, when new selftests don't get skipped 
properly on older kernels, it might be hard to track regressions with these.

Please let me know what your thoughts on this.

thanks,
Harshit

> thanks,
> 
> greg k-h


