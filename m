Return-Path: <stable+bounces-253904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BsCuCLZDEWo4jQYAu9opvQ
	(envelope-from <stable+bounces-253904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED85BD632
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0600F301917C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC71F5825;
	Sat, 23 May 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3/1dMQs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CWUaaxv9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683133438B5
	for <stable@vger.kernel.org>; Sat, 23 May 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516336; cv=fail; b=CV9Um1YQJNfmM56Tz8fpK2Rz9e0FigzkF3zsfWnW5z8rzONfz/HIUFhmAL9wU3QVndKJegu3HarI93BxBfxutIPPJIAHcW84efKTo5DIAXyAkWMzLlWXa31Fdmx+G0Y1ZXkZJ1q6gmtVgwfdi8083uo8cGsAykTUEqRyuJm7uLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516336; c=relaxed/simple;
	bh=x2OA47KIGANC8olxqywj0HofyYi55BhzEBVjsK3Oqw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=koF7QOlPudJK9uUWb+C4fomvKUGP/+Y65lDeHUfrfMdQXBWAJQppP2DVwz+4aGII7yV4fk6gqQnZLG/C/4CIVZhj02X9UebFjv4IJibS47h+25WazeXNF62ddzYk7UtFAHlovVsETCHWJTfIx55vIo7VwnIEKUCD9OFP80ZVPg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3/1dMQs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CWUaaxv9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N5vgpE2870334;
	Sat, 23 May 2026 06:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=goLhSBEdcWcqw/uK+cHqeMKUD42CDBAnL7XzoBkVusM=; b=
	h3/1dMQs/TqnEfABADnRTtb/MN8kx/Z5QmUUPYthZZ2/uQsg8QDIPCF7hkc8lV/D
	Uiq/coep8cSdBwzHsf9aIy/88m9BEBq/dzQwpmvqygwkZru2G26XYIv+dLEa8ghJ
	12/1Yf8XaQiaISv+eyiZuqLQvkyUATq98rHuaCYqBaeQidoWNA7p5M3n1FLpfDLl
	WbEk1FTs/9l4U8RH51d29OMcDx8/t+KmF/Z/MEg3e7u2j8LbWidIWbVmcGgbo1i0
	Mk3mlQkCeASSH7bvYBHecweRpY0tths6sRY4LSqwrZzZVOdwPIqeI7TB1EletZjk
	wruv1HOAqNW6AuQ1lzf/Bg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4aw82e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:05:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64N64jiP019610;
	Sat, 23 May 2026 06:04:59 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2pcmkdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:04:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Btlxxrv1Vw7VjeFVmNFjxXAH6CxGkVJuOyIureaB+Q2xyAGqh8udq34dRkRby6QfnMt+gcbnD0CzzlKfB0j/4OWo2XFIOFBsBJxoSeONuiEKIpNgBUHKdGUCLpgGy5L80FAQddlMD25VH+D3VhnLT4ke1/Jp6QjdvM7F3AW41oS38AHbpHpAtVPH2QOOVS2aAJGKK1m+Hzngs2Jqwp7glmJIkj0BcObYksrYPG+pDxRJCxLllSKZcwnYvZghUWvDvONGMxaxuwN/cZ/qId/sTB11LhLHRWaNBkZvhkPW1oUSxK2Xu2Le44JflC7EpxWgyGnFJBFKuNAT8wEfPKBFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goLhSBEdcWcqw/uK+cHqeMKUD42CDBAnL7XzoBkVusM=;
 b=jEjPe5YNiEH8tRkb9g2oyEP5fH/3j3wiEkgcnjq4LoF6iXGQC7Et4Cm9xoclXcbLHzrPOh2EcjdsSMY6DQ+NvbPHMFmQzB1k5/r93Kpyy1AUkDj7ZokfiOiwffwhMACTQb/RtohIE+TpCYv6IaSDyWfR0A0MZ6VbFvSkap7dbrNsCS6jHfqRUgsxWK5G+HAf1TZsr680r73vwzAiLN0AI+pwg8XkI6hgRbwwhdwUsAB0I2+/ymXgDThHIMBwld/AN1iKRPSOZMtr6KQQjyrx9TBHiT01CJV3glj73aXyqBXpfQskU4ADAqHAGQ4VJ7HyAClciNFBTMySmXPJYVWEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goLhSBEdcWcqw/uK+cHqeMKUD42CDBAnL7XzoBkVusM=;
 b=CWUaaxv9e8wVnf73ZgPteU1Sg44Kb0WV6g8okTrarmPBpSvkNAalL9zh0xYNhtnKVQ9jtmsVWVrXGScYR2xYaZKl1oN6agkL2jZdfVVzWv9ui3D9La1aFFrbFoXXP3DWlNi0a4U2UGIISiuO8dRLUrErbjsB+rRTDSpRZbM8S28=
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10) by IA0PR10MB6865.namprd10.prod.outlook.com
 (2603:10b6:208:435::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 06:04:56 +0000
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a]) by PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 06:04:56 +0000
Message-ID: <100697a1-8351-45f0-acf9-8e000d7d6f68@oracle.com>
Date: Sat, 23 May 2026 11:34:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Ben Hutchings <benh@debian.org>, gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
        malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
        sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
        stable@vger.kernel.org
References: <ahCyf28nWFO49oDZ@decadent.org.uk>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ahCyf28nWFO49oDZ@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::19) To PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PR10MB997710:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 42440ff7-534b-4191-7671-08deb89136a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2lUMIqVrUaFf7bc7QTxjgBdx2W6sjBlgNdOg0AmLboDLPnmM9WIo2lJHrEJwCoiwxon+BAbgUzey13FoHhgMPvomiGMBmpT1yg+jwSoKRJzsQ7Vy+/9HlJkIBa//71I4JQzNe1Sc8fQwKs3rncIRuHTqKySVh8jFXzo8qskkPeDBc0L2Gbiz0C+UA8uTDivwMyCNz2lsC94VEetL6jC2ASqkgbf4yCnadVqJ6WHGWEtrFBhtziMzRI30S3RF+/CLyf1bXFOImeelCa1witfQ8/5DZ9BlxHZULOTtbYHcNJKr4Gn3YCQA3Gz4YAGIxH9399Ui3nKgjqa3MyeOJrvclgmT3W4jNlGgMjPRWkBEBt3oBzIfQpBdHUwISoOeIz0FVTjcYPEDasWw4nIpabRSX09vJs+VTVM7pN0VxyoUPO5s5bApbF/qWcOJrnqiGBtBhBkRNlSBjERU7jfUMaGL4w8z40/eu8WS9YXALBcMxSY6yXYHHvcE9EK/y8KxalA7SghHnpR9LK8K9TGJQ6b0rVgFTBx+Vl1tKV2XxQ96iSfPNev3o26Fpd63WVe9MnorIBXX3ce4fu8L4b2p0Oxy1+GD2zGSFgGjtqnExKf8bOBSDD6aGOQKI1e9O9fVOT9cT5LFnzkjnCIt/ckB1xnFTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH5PR10MB997710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkw1eU1Cd0Z2Y3JhYUVUOHl5bHdlWk5iYmdxTXZIVU1JQlRwZGV5VUVmZE1v?=
 =?utf-8?B?NUtpRWxTcktzYzlJQW5KTzlRT0lBajE4SFN0WEhXcitSRWcxZDFGNkorUkJE?=
 =?utf-8?B?cFZOSDdkVEFBN0JzRFF6aDF4bmc3VEVScW44TzF2eElobzlnejJnRDRPNlN4?=
 =?utf-8?B?c2IrbVBFUUdib0t5VUtVdENHRHVVTURTM2psYzBaRjRjNFRqdWVPNllUMHhM?=
 =?utf-8?B?em9CR2lhVHBtaW1CYVhocTZFRzBZZ1cwcWdIa1NlVlF6amhkUFowd21VRWpu?=
 =?utf-8?B?eHkzYWlLVDFtOTVMSDdWbjQzQWFwVngrWVFZOEpGMndlcGZTaGoyUnlnaG9B?=
 =?utf-8?B?NVFvOGwzNUw0TXhyamJlTld6cUhldURia3RsNzZBSm1OK1J4Q3p3ZDRUREJw?=
 =?utf-8?B?UmROY3c0b2VzVi96ajl5VWlUMjhJVm5mZGd6S2JwYzdhaFFLQjVROFZKT3BG?=
 =?utf-8?B?OC9TbjcxdE5JTUowL3JTUHlwNENzN01NRmRqb1hEMFZxRGpqUms2WTNKc2pG?=
 =?utf-8?B?MFRvOUVYSkxWNmpYVlV0cTlUdldhVHVhcWJITkE2Ui9IVytRMzNud2VxemRh?=
 =?utf-8?B?UVN6MGRYdkxweXMwQ1ZKdkU1S1VBU3gwdDJGYXVsV2tHY2pxODhrdm44MExQ?=
 =?utf-8?B?aXpCM2dLd203emwwNVFFRTRrTFZtaXdTVzBmRVdVbnNQcnhmTENDQzV4eHFL?=
 =?utf-8?B?OHMxWEk1UjF2UEJjZzBQRHRKS0RxcERGOUxyWWdTUnpmOGxYc2dVdGhhKzZG?=
 =?utf-8?B?cnFSbVJMS0dRME5oalpabWxsVGRzSWlIVTY0VENqalJ6VzNwQ1oxMU5Nc3Vv?=
 =?utf-8?B?WTFoZlRzWHA0ZytmUGdabHZwczhDaFhGNm1xMUd2WFRCYmtZSXozWFpLNzFs?=
 =?utf-8?B?OUxkV2pVTkVOcGd5VWF3cURTUXdnQzZUeUxLL3NnSUpGVCtYWlJha28rVjVX?=
 =?utf-8?B?bFVUNTZka2tzSllUU2I2d0t3ZytEVTZuR1JtQlorZ253azlqM2d1TnBEVDB4?=
 =?utf-8?B?c3RnbGtTaC9pNG1VQlNVbE1yaE1yQlgxMzFtVlQ2NkdTSWc4dFhOcGJxL1Nw?=
 =?utf-8?B?emQ2My9ibURQMjBvNWFlMkRrYTRiRm1zMVA4RmpyZXVSenFjVVVlQmlnbG8z?=
 =?utf-8?B?a1VXRFBoeHo3ZUE2cVFxVWxMT3l0Wm1xNEQwM0lkUkdGRlcyTGVXcHpGUjVZ?=
 =?utf-8?B?SXlkTTdWWjJVVDh5Nm5JTE9lM0QvdWJmaklZV0ZpLzNuZS9BRitoWklGRVMv?=
 =?utf-8?B?VlBXTEFGSUgyYzRYa0V3dmV6RCtVeE00a0NqTTNFV2s4QWd0ZUgwT05wbCs3?=
 =?utf-8?B?dnNPQyt0eC95dVA4b2ovdUluK0tFMUVkWGVDeGk1RVN3Y1lGeUd0RjgvRUJI?=
 =?utf-8?B?V2hpc0lWRnQybWZiSXB2SitJb0ErQittT08veWMyNGNnc3I2UjFvRDkybFpC?=
 =?utf-8?B?Y0EvVWZ0aWRxd1lxTzRtNUFnM0xDU0x2UzlCZ1FLS1hJWERPYUhUejRzWllC?=
 =?utf-8?B?ODk1blRrK2xmQ3I1VG5zejEvYlhxV2ZXdVF3WW5HcThkNlF2enZnb2VDcHNZ?=
 =?utf-8?B?L0ZqYTh6ektVaHNlK1loSHc1ZnRxenZKTWo2QmF5MkVLUFJWOWp0YUwrY3Fp?=
 =?utf-8?B?L0hOWEszNjk1SGppalBkL1VMcmpoWDQwUCtjQU56YU9FMTJDQ05iQmhYNXN1?=
 =?utf-8?B?dGpWS2xqTytUdVFhV2NHSENmRmlKb1hjbTNqRUpPTGZIQVg0ck1IaGFqZ2JO?=
 =?utf-8?B?L2dNUEcrYmlRMEpBOHZ2WjduWG5Yc3pMbDAreWYrVStGK2dDNk5Ed3dSaDE0?=
 =?utf-8?B?UU5RVm1sVDg5c3dUZzZpQWRzSmZZMXNGcjRPNVlCelRUaFZyRklPU2dreTBv?=
 =?utf-8?B?b3d2cGVTOFBuUFhoaG5qaVdPUEFrTWFEaUJhUW9jcEFIRU5tblUzZHh1Q2Nt?=
 =?utf-8?B?TTRFbDFNUzhrWFlpWVJ2Qlg2ZnhPZVMvdTRaaWlMcm1kNG9lRWRFOWprK3dN?=
 =?utf-8?B?NHZrblVDNklwVzM5cnFoRk9PWVF2dUZkdHdlSGxvUG9xK3dsS1ZlYVJ0ZmNj?=
 =?utf-8?B?NEtzaEowUGtaUFluZnZGeWJEN1pGYmsrOVBQOEs4Y2JFU1pBWTVQLytRbXhT?=
 =?utf-8?B?Sko5Unk5Z1k2dHE4TTFreWd0NDMzWmcwbG5CK2NOeUROR0FncW1qdWxCVkM2?=
 =?utf-8?B?TTlFL2U5UmlMYUhQNzE2ek5jT01MQUJ5QU5Sc3VMYk9DM25DT0tTb0huZVdD?=
 =?utf-8?B?NHJrTTlNaUVpWE1FNStxMVg0WDZpMzZtYjZRMGtQWmhTNURYVHFMdmdrS3oy?=
 =?utf-8?B?Q2lEYWhrbVhXSEFhRDBWYXNPUTJ5MnlwU2ZORnpJWkVMUk1vRUUvK05EMEsy?=
 =?utf-8?Q?8bpckOQUBCfORaXArBKMssaRUtLyJb+6oYjOd?=
X-Exchange-RoutingPolicyChecked:
	Rz1/ZifIl1Jisu8G9+4TaBhtuk2sioJyHsX3zrg4M7EowG5cf/rTYvPWCCahiUVjOq+3fofW6IC/GdrZnGYPFSWPEJtkunnEnYsBmdwHiSKT69HoD1We8nhb0PuG1bZfmjcilYOXIMePljLpy0LwIyG5XlVJ3uixroAkc8NuMWOplnAmYnmst+hftuOKMMzIfmf6Av2v/id9VjHk5ip4x4vOoENVywEjOiqSBgM4fOzDn8Fb0IkhUGPhmlw/xbveBSR4WPOS5yizapXRabx2+n8+08G6DK1TDhrWjiwWWNwsbOdkbaI/peyX4ekt9OvxSGO8tXNOHtUAtGXr6uwpuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cz3p4d/1QXOjVgjtkr5H0hmCMdwRdH1munCEUdXvslrPaZ/Zf+KtJqr5wWdKZWfNMcaA3PJvhpL97CTgsbn37XYFVJjYZrV7QuMGSL3CwcrFpK2VVsH3ABygru2TyeFv4EFqhc7zIXBk4pllV6evonI9U2niEJfBNxFg0LFgdlYx8czy6+b500MZj4ISP2P3rpozjA741C9TujSX66aRXXCcHOZJN/Qvu0EoJHm7Mjwu2XnbCCMMK5EzMXN7cQ0auBKxZpT66Zfcp5rMlIxgQABtU7RzFg32wi6ldz5rP8FsZRnaP/OYtReoi92rbWAJz28VhO/77uwy5/SRjY4n7DJOL3IvFTyreizjCz4MQD7mcihF8Xd6Q634WyRLEruru5xpBnl00VYJFoqEIbPif0ote/sVzQ/yAkvs5ZBQQUo3HlNGxvxdGctE8dogO0AspeLKcHsKLZriSW85opjF7sVzvlg1bVANh2G/0uww2Z3ooAIT/tttnAugFS5w5begQY8FyoOpcnks/KA3BNz+oF6IIdCxLf5FwrWYxaK7uNzsOyUrRTBGDw8dNN5k0XEEOpDahCW61FucR47Sk4f/BpxUuma2U/LOWyLkAqRgHFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42440ff7-534b-4191-7671-08deb89136a5
X-MS-Exchange-CrossTenant-AuthSource: PH5PR10MB997710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 06:04:56.0957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /R4QNJZvoFrBgGCpUjxSdQI9A+v9v2c1gBu4GIS/aFdt7vYPrjGW2q/q71qOrKbKZ/xWH/Vth8wKQT9VuHTkb6y4EwOLIRgoTP1Ui5i9/zWFsgdpjrHkzYVTWsBM4mRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230058
X-Authority-Analysis: v=2.4 cv=QrluG1yd c=1 sm=1 tr=0 ts=6a11438d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=bC-a23v3AAAA:8
 a=pGLkceISAAAA:8 a=AeCkNC4mAAAA:8 a=Ia0HVi91AAAA:8 a=8T59DR07AAAA:8
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=xNf9USuDAAAA:8 a=ONza0irlawQ2XfZdcIYA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=3H0rhiSm_XezoJcgKFaR:22 a=dzohbJX8CEHOwgtOZ_jj:22
 a=nH4QB3FtVBqZfhiODIJV:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12301
X-Proofpoint-GUID: lQGoHiYxIVEHuhNZKuLw8UFX0RKam47e
X-Proofpoint-ORIG-GUID: lQGoHiYxIVEHuhNZKuLw8UFX0RKam47e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDA1NyBTYWx0ZWRfXycn7G30uTQ6L
 OvrSYtCFq1rLn3iepBP4mp7YKuXVIba+aEeX+6v3sZoy+0CLsHaWq9MQyamUS4je9GgsV+/1tWt
 Igiw4LHsPKnEeQ3MDMb84BnvY7z5if2kO22S3iZayKcyZFHFwvdBPtblDCj8tPLPtoIWN9DUFzw
 FmBM4Vuodz/G3h2Z33CQBIXo85p+bY0xEnkDv2T9f7Pbk4PQT24CDTrQczDp9AG7zSY406WJnRV
 9AuCkcwFkYAu6Q3ANnWqY1El9/hGeFhf2sNo/hYisk/529biAyrkHGt5XCwdlH0l+lLzadbGoeB
 0xjDg5yCWuInHKL+doiSeXPxUkeXxUFTm6/4+vIVFcvBiLUXFUASJB9hmSHczLkgaXCjnTiT0wJ
 Kz718dDjn/cBmZfKa7PPWr6IpXwL3G9Jir1X0EZUSHe6WQJp2vU3QlgssGTKXNc8q8UtG5qFzI4
 nZo0VEJFwKhUs88RtHyK8WGbO/VekHhAnhWJLklY=
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253904-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7BED85BD632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/05/26 01:16, Ben Hutchings wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> commit 48f6a5356a33dd78e7144ae1faef95ffc990aae0 upstream.
> 
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> The same omission also exists in tcp_clone_payload(), which builds an
> MTU probe skb by moving frag descriptors from skbs on sk_write_queue
> into a freshly allocated nskb.  The helper falls into the same family
> and warrants the same fix for consistency; no TCP TX-side in-place
> writer is currently known to reach a user page through this gap, but
> a future consumer depending on the marker would regress silently.
> 
> The same omission exists in skb_segment(): the per-iteration flag
> merge takes only head_skb's flag, and the inner switch that rebinds
> frag_skb to list_skb on head_skb-frags exhaustion does not fold the
> new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
> so segments drawing frags from frag_list members carry the marker.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>
> Suggested-by: Lin Ma <malin89@huawei.com>
> Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
> Suggested-by: Aaron Esau <aaron1esau@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Link: https://patch.msgid.link/ageeJfJHwgzmKXbh@v4bel
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [bwh: Backported to 5.15:
>   - skb_gro_receive() and skb_gro_receive_list() are in skbuff.c here

right
>   - Drop change to tcp_clone_payload(), which does not exist here

right as we don't have commit: 736013292e3c ("tcp: let tcp_mtu_probe() 
build headless packets")

>   - Adjust context in skb_shift()
> ]

Right, looks good, as we don't have commit: ede57d58e6f3
    ("net: helper function skb_len_add") in 5.15.y


LGTM.

So from a backport point of view.

Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

thanks,
Harshit



> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   net/core/skbuff.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index aadb87aa5e7e..a8d09eff26f1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1661,6 +1661,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
>   			skb_frag_ref(skb, i);
>   		}
>   		skb_shinfo(n)->nr_frags = i;
> +		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>   	}
>   
>   	if (skb_has_frag_list(skb)) {
> @@ -3650,6 +3651,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>   	tgt->ip_summed = CHECKSUM_PARTIAL;
>   	skb->ip_summed = CHECKSUM_PARTIAL;
>   
> +	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>   	/* Yak, is it really working this way? Some helper please? */
>   	skb->len -= shiftlen;
>   	skb->data_len -= shiftlen;
> @@ -4017,6 +4020,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>   	p->truesize += skb->truesize;
>   	p->len += skb->len;
>   
> +	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   
>   	return 0;
> @@ -4251,7 +4256,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   		skb_copy_from_linear_data_offset(head_skb, offset,
>   						 skb_put(nskb, hsize), hsize);
>   
> -		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> +		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
> +					    skb_shinfo(frag_skb)->flags) &
>   					   SKBFL_SHARED_FRAG;
>   
>   		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> @@ -4268,6 +4274,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   				nfrags = skb_shinfo(list_skb)->nr_frags;
>   				frag = skb_shinfo(list_skb)->frags;
>   				frag_skb = list_skb;
> +
> +				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
> +
>   				if (!skb_headlen(list_skb)) {
>   					BUG_ON(!nfrags);
>   				} else {
> @@ -4490,10 +4499,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	p->data_len += len;
>   	p->truesize += delta_truesize;
>   	p->len += len;
> +	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>   	if (lp != p) {
>   		lp->data_len += len;
>   		lp->truesize += delta_truesize;
>   		lp->len += len;
> +		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>   	}
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   	return 0;


