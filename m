Return-Path: <stable+bounces-93028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6E9C8EEB
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AC41F23184
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4F18C022;
	Thu, 14 Nov 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W//HZ/Re";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t9/vv8eK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDE18C014
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599503; cv=fail; b=F+u4xs2FmttHmI6zFNxiUSroXIVELFJfU8ndnGRlZp6KrSZ+b9DKwYR5Wwrd81gMx9xzHhQOjsox6ykDw6KEjb14ZYqzQ0KaAm2FlaSdVkCD0aIeDg1I33uYgrvlgNULOpQAaT+crMuThP/Dutpxt/UYuCcC7CQ12+QTZDNWZZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599503; c=relaxed/simple;
	bh=QqVWUlNyZ6I5HqEPmJJFMHUnD3eOCrtewmiEl89Lc7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hm7YUI2GigS7MjueczhzMRnEIYq5B1hrRjD8Sw/OucgJRam3sPQikyUgp87PJSTY3tz5W+gJkkvNVCaORAS2ulJSX5ZHy6mW4K/8ZImQd/AEKrUD+8dfmJuQ9XP9saBi78a1pNNjVzzFmxj7lsU+6JlS4HujyQZ+mJuhPtnFRfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W//HZ/Re; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t9/vv8eK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECSjJB008280;
	Thu, 14 Nov 2024 15:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lSowqtR1rcre7D86SWr39MKfInfxJpq9SB+ysq/OuCc=; b=
	W//HZ/ReHy6QqTzoJzZ46vJENwObWdrwORPPl71ex2Byib9nOc3/PiNPZ69itV+G
	UHva+7/pdrk6ioLYyk2mR42o3ktdpjWsWeVxBSLf8q5O7GBvXLtvjAyrC2JEP/K6
	fe/5jm6xwxv6TNZCQDg7mG4RUbkqfvQtmRmsdNT/MFaTpgyaRmdTYm9zGm+4cmxE
	Ia7mGAKOoLMUJK9IwdCSLZ3gSmW20uKU9KgccFxGsSxAnJPTuhcihcmZXsOGJklA
	+bFC4fTAb5Yj1mIcSdSvySipW3gzYz2FqD/fzCn0Nbl7qmA5P6rxZekawjEdC6Z3
	1S+2I4fx3QgslFRlgfYlow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51j38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:51:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEOZT2035969;
	Thu, 14 Nov 2024 15:51:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b0e9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4+yK0CTZzycwhG/0oo/hObOanPNV5/6C0jhEJEQ4ShZMwGi9lCJ6wy8giIshZhNSyxzeRq1cuI4MMLl38WMt4ElcC0FMVgkMD1P7nJqktPXbclwWZAHfTIgA0VKjPUS9YPEjy1hjbhsj/hTHrsow9fOMkCePwhu3xK17dsnHoAubcGBmuy8N5NBj1R5KjA5e3SKMptBg4KbbjHZniG/J9INkJha+1xNzHzQcgAdGnVgT/9UBkt/6IIVOlPN+hK/4w7SJ3LbDkUvTHDXLijMg3PbGwti58+iQrh3fsjHKT3UmpbgVZxUByCsuR6D/X/bfMoYKRAm8FhP8T4ZbeKnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSowqtR1rcre7D86SWr39MKfInfxJpq9SB+ysq/OuCc=;
 b=sBNWdHXkz1MUGrM7z0yGDK80B3Vh6EwMUhgeWDZ92SVD8FgEEGd70N24wyDpw2ElM3OL9c3td0od6b6mDBuK5cCP+SR63QUP6bbS1OBweUkqvc2Sfk+TCu1xZ4Dc2EAlJdpeCZzbJfM4R3NYrpS9C5wSRgK61bpTo1CeimQRnjpK7n14ZDGlpmcNu5EzTZOr2FIDSdXyVtpe1J2jX/L6UXW0EI7kUzpEe7RDDC/hj+DfS/PkTmvLev/5JFzNJzywubwfsyu/PdIlURE4pqwuDmINKuChLFuMHqFxkNsbnyQ8/sYjR4SJJji8mAdzuJY+hSJoEEeIortogWsmrAHgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSowqtR1rcre7D86SWr39MKfInfxJpq9SB+ysq/OuCc=;
 b=t9/vv8eK283BuAE2bow7ruamsTokfu2Ixq/xIwkWcT8/nIALKAV7HF7KvV1gSWz2epP52zxuPJDRbl3ZcoqWpkF+rRh9DLf8dxLZ5s0lp+G6xhsiFO37jGYfW8Jyl770c1LeC5DCVrhLsrjSebBh9hHYeErwLVhBkcjY7/oF3ik=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 15:51:22 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 15:51:22 +0000
Message-ID: <de4226be-1b8f-4fdb-86ed-b9b077b839b1@oracle.com>
Date: Thu, 14 Nov 2024 21:21:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y 0/4] Backport fix of CVE-2024-47674 to 5.10
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b446268-8c19-4572-2bc6-08dd04c42fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWkrSGlzMnQ1NFFJQ2QzcHdFVUZOV28zNytLQWpzY3gvdHFuZ1c2akpqNG9K?=
 =?utf-8?B?S3hNUnpVSlpkTUxKeUZwVmNWRDVNN2ZhWUw4dklrSUN6NllYMUNjeEV0eWRV?=
 =?utf-8?B?N3l2WDJaV1BCUDZXSVJCOGRrUnEzb1ZzTVhLVWJNR1VSY1U5ckNmWmNXTG1W?=
 =?utf-8?B?RXNhMEtXc0doa3BYZDJBem5IL0dqQlpHckdBZ0g1Y0VXdllrTTRqdWJndzIx?=
 =?utf-8?B?QXNCM2dHcVdkNkp1WXd5YTdjdG1xVU9nUTVMWUtUUXdVWnMzMzgrYzVSUmo0?=
 =?utf-8?B?RGc1RDVYckEyNU1OWVM4SXRmSlVUUGQrNFhseEV1WnU1MVk1U3hkNGtTWWZB?=
 =?utf-8?B?VmJNaVhrUjRacDA4eVlWbXZ3d1RjeUJnNm5JZVE2TFlwQnNFamYyb0pSWmtu?=
 =?utf-8?B?U1VLK1JHdUpVN3hUcHVPeXVaVlZsY1k3V2pFenB2VTEzY0ZodXc4R3pZU1ha?=
 =?utf-8?B?dDJGVXh3aHByMHFta3A2ZmRrczNpNTVLcURRanZ2OTVFSWpnYkdQN29hUTU0?=
 =?utf-8?B?SVErTXgwdnhzSGFHeStoT0pQV3c4VEEyMlZWLzFYOTVlejJxWldpS3I5RHRR?=
 =?utf-8?B?d2R6QStJanc0YWsxQlpDS1hhWTRwK0k1NmJ6MGUwd3BqT0lYcFFsY2ppOFBr?=
 =?utf-8?B?UWNOdEJkcWI4TUZBa0ZmRmpXUWcvZFh0YXNTUkNhNjFKWU5pWkFnZVZhdDNn?=
 =?utf-8?B?Mm9GMDR4OFdPNDJaOFhzNDNGVWl2anNhSHYwejJmQ2hTSDRiQy9hUHl3emVL?=
 =?utf-8?B?VlFYenZPbjVFL0dYT0RsRTNsWldxRXdUQ0V6N2FiVlIzbWs3TFFneEJrSFhv?=
 =?utf-8?B?MjhUdkREUFlpWWJlME9XSTdCclBuWTFKc2lHVzZ3dTBUaDhaVUtyUGtkQjMr?=
 =?utf-8?B?TEc2N2t2Ukc2dC9BQWFWL1FpbHMrVnAyb2RQQ1RtMjhYaDVXZy9lV2ZOczJ6?=
 =?utf-8?B?NHB1c3ZJRUdPV0VyRnYyUGpWWVZFNjJ0WlV4bHlPaUd2dUN3L0s4akhBbzNN?=
 =?utf-8?B?OFZuYWJnZjlNZnozeEM1UVlIWkFKNVhVekNIbmVxaUU2aTdoSXJwQnpKRE8y?=
 =?utf-8?B?UEFxK2ZJN09wblZtSGNEQmdjWlpJVHZkWGVHbk9xQjY3a2VBZGRVNi9jWXU1?=
 =?utf-8?B?ODBWNGlaOFdxWmRZaTFpcS9BM0p3WVcrUEVBenV6MHViZ0h5STg5S3JHWDZa?=
 =?utf-8?B?T3pVUmxNUEI4OTVQbDZiY2pTSlBad2ZFMm84cUVLZjMxbzB6dmVCOGx1Tm1w?=
 =?utf-8?B?U0YrcWloNys1TytGWU1tNkdTQTVEU21VczlCS0R1cE1CZFZuV0Z6MVJrdFBE?=
 =?utf-8?B?UlNISkJ0cWYzbSt5Z1V6d3paVUxCd1NmaUFkemsyM1lNM1dxMmQyVENPSTV2?=
 =?utf-8?B?WCtwQzRYdUVaWjNpQkJvUkZHSzdBaWpqanBhOThqRUFEZi9XbGpZQmx4L2JS?=
 =?utf-8?B?M2ludVZPWHF1L0VTSjBLaElRUGk5azA5WHgyMG1QdmN3MTJRQzYySm43Si84?=
 =?utf-8?B?MlVmSkl4aG1hQWYxZnpSTGUxNHMyOTMyWkxEa1k0Vk9DdWVrTnF0UnZtU2hZ?=
 =?utf-8?B?N2ZJc2s3dElzSmxFTDhXNDBHWllsZ21sQUE1eE45TTdTd2lEWEFCcVB2ZFRa?=
 =?utf-8?B?TE95SGJrUHQ3bGsyLzAxa0dzRmdiakd6WEhJWEJIWkhwMythSlFwMGtNQlQ2?=
 =?utf-8?B?ei9xUWJXbFAycnp0T2YwRnRGcUtaTXZTbDRqT1F4N0FOMHlvVEt5dytMZ1pz?=
 =?utf-8?Q?j17KIOkUQh/dgTTGe2AdKT3KryxIdade6lWEBzl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNabnRITHd3M2JxY3JQbFdlYitOUVZJcVdzT0k3MVdEMVdJTXRWY3ZvWHVK?=
 =?utf-8?B?VWVrTDNLT1NzK0xhdUo1Zmx2V3lNemhWYWhZOTVmTkwwam5CRENPWkd1bGFX?=
 =?utf-8?B?V1RRWFA1NlJCb2hnUHlMZVlPdWFTaWtFUjhPTTJWYnhkR25CMEdFMm9PL3Fk?=
 =?utf-8?B?Z2lEL3FmeHN4VTE3UmtTbmRLeDlQTnd5YnlaM0NWK2tNaFJ3VjdscGE3cGlv?=
 =?utf-8?B?bDI5cTV2aHZnYzYzRi9JZDgxSWp5a1lRVU1ZWiswSTRQRHZBT3lyWTB5Y1lM?=
 =?utf-8?B?MVZWZWxWYjB4L2tweEZHREI5c0xRVjkyMkFkanpFdGpnYzRxekl5cVhIZ2t2?=
 =?utf-8?B?VVFwTmcxZTdudEtoRHUxRzFHdXJnVUM3bFpkaXBCbjM2dW9VYUt5Y1NqS2Q3?=
 =?utf-8?B?ZERCbzUwL0dQeHM3SVRFUGllQlNISUVuVWl1OExYaWdSRjMxT1hscTJmdDFp?=
 =?utf-8?B?bWUwRWtmNTVtWDdlbmNEelAvcGkwQVREZHMvZTdCVldDMWs5YmMyQkNjRjBJ?=
 =?utf-8?B?KzE5bTY0Z3F5T0U2Y0pVM21jYzFJYTd4S3pRYXR2WHNrM1FoU0ErQWplZnpC?=
 =?utf-8?B?NWxFSFlvTjRueElobVExaHpVU2RGeDBkbzVjY3d6T21pR1dsS2J6SGVpTEEw?=
 =?utf-8?B?alhLNURtVXNoWHhjeitZMnM4T2paOHhxT1c0aWNNY3JhdGNETWlxU1BycEhP?=
 =?utf-8?B?MDRBK2lDOXR5ZGh6bGNnaERKRnNGYXBIRW1aVUVLMXl4TlovN2QxVTN0anI1?=
 =?utf-8?B?MTIwY3VTanBqQnFPbmVEZUU4dDIyZUl5NnYxcGZwZ2ZBMzZpL2NQQmhNNEVh?=
 =?utf-8?B?NW9NRjY0SFQ5SE5QVkZFMkpuaENXWkxtNTRlbnM5ZmtQNHZWOE5Na2RSVTNa?=
 =?utf-8?B?VVBqNTM3NG9QUlY1cWkzdndSY003TDhYZitaZ241d0ZUekY1T1Jab0FPVUl6?=
 =?utf-8?B?VFhGK3RHU0ZYMm9jUEtFTFlFck1DbHI3alBCbE9HK1pMYjJFY3J4QVpRbHdl?=
 =?utf-8?B?RGY0R1FHRkltOU14bEFQOHVmdm0rMVdXUHZVdGVTRzNhakdhK1Q3ZnJpRlJG?=
 =?utf-8?B?RnZtRUk1dDJGZWh0di9PNjJscC9GRzU0eDNtZmdmenVmZktRNFUvbXo5MlE4?=
 =?utf-8?B?b1FkMlZVY1llNTE4dG5iay80QzA0OG9XaEhydGFPRHQxd2NWczJmZWVpMy83?=
 =?utf-8?B?azljZWY0ZCtDdUx4K3dLQisvR2VUWDQ0MzlqRHRETTFGVVdJZzJJS096dkFs?=
 =?utf-8?B?ek01RlZvVnRSMGhsbFNUcTE1R01ta1pjb1lUVVduSm9TaEJLK05NUzE1Q0F0?=
 =?utf-8?B?YlpwWGFEM1NvVXIwOFNMb3JVQU9Ed1lFckQ3SjZLSk5UbXRoR0VrNTVuZjJB?=
 =?utf-8?B?U1dPdXZmci96alNTWHExVmt2RGxsUXQrM1VLYytONTlQWldqZjArOTV5a0ZL?=
 =?utf-8?B?VXdQYkgybUdoTXNmRzJVSzg4Y21Kb2dWOEdZZzR2a2tBYkJJWU1vejFBTVhX?=
 =?utf-8?B?dWh4YjM3cVVUd0RFYUJzR1g1NkZTNEJiQ294R0UxM2p6Y00vYnNzQkpiZ0FR?=
 =?utf-8?B?eURvV25WVjhINTQrS1pMR3orMjgyejNsTElRRk5xK3EzNzNVMUE0bktvbkhB?=
 =?utf-8?B?WE8vWjF0OFBzQXZqRkx3RXpQbkFkQ1hsQURrd1diNEtVM1pMMkR0TDFKTmkv?=
 =?utf-8?B?UmxKa2FiV09zN0xzQXN4blFPVmxnSGlsSkd0U0pnUDFEMjFKUksycHFxK3RL?=
 =?utf-8?B?VVF5eXl6UDU2UGJjMXUveTV4cHV4SEtValVTQnBYaEFvT29hdUllNDAzNUc0?=
 =?utf-8?B?ZllxYUZ5YVBKeldvU2s0RVI3aCtVY2ZlNWllQytneU04ZUM3Q2NKZEtsME9x?=
 =?utf-8?B?UlErK1lsMXFmdkN5dGtBakUwWFREbUN4QU1mMmdRcnB2eXVrUmEvY0pWS0hI?=
 =?utf-8?B?TnRRWkNFTnpXSUVSNFR6cUltNVFWcm9EUGFmN1hHcDhQVkQrVkcrTCs4ZGRJ?=
 =?utf-8?B?WWJqb003VkJod29rbkd4Ukp4Q3VXT2FqNHVWNGtacjRhRXhXNWhmTU1UTnlD?=
 =?utf-8?B?RGVjWGpkUDhVak5xK09FNmgySkZGdzNnRmtza1NETGtsYy9mWWZaeTROS3hk?=
 =?utf-8?B?YXk2U25XcHd0Uml0ZmQ1V1BYb20yT0NNMVE1ZnpJeG1tbTFCLzJZSFZLZkk4?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zf0kH4TKrxeEzt0XC47DCQFOQM2Iyej8QOmBsVu/F6LtXlnoyNhlrpl3JsqcAd5ycs1COu0xnme8nBXcNuEuBLMb/nCS9mX4lDBY6WSl2RP18Ae2pmhpNq6svCcHM04meKxA323r/4E33Jm1t/HtRtiL1C0wGMyQM94LR6MLYnE8DZRd/fUIPOWD9hzFAGwzB+7YQtiqDImQl9I53UicdlP6m5FX84NpNQsBMZjTeFKu+NQIoIsH4fa3pcsR7uW6RJYJKMUoWEIFkerJgjjX2Mj/IiJG6no459aU1VnpolY0el9c2y9Tmd90Zz0QplBA6cKmtPymXynD5w2p0183ts0HxzA78DEOGuhu9hjOKDKz7+1za0q7PM6FDcR1vwZySzbWEZbTQYHYeEt/KkATcFzNRKp15eDfQdX5syDbv7PD7bI7E3STXX/S+TXmobWgGpjz3nn9MPvHhklwx/f/jxDqsIjGhLZM+fOKE9VOTHymEje4TITx9jhw/GMoyvf/CzjA4jgHEjfDz9Vn4QJpgO7+qlUg6rEviKCpZ+kPWlsyKGNHzjoMlipHnc3rqztGw8JMFL+iCn7zf8hzTNxbmlFtRaAyz8tC+Z/AbpqU67s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b446268-8c19-4572-2bc6-08dd04c42fe3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:51:22.3877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxMw47pip8cQiCgn6pIPjbLh6CHkwGMzo7zlHA6gtzP7Zi/JgHdn3CvqFF8VQKIDcTKAxOJyNe47bSu4CVnw5TVl9YzEFFpl5DiuAZDz3ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=720 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140123
X-Proofpoint-ORIG-GUID: CizEgCfLWNel99hd2zvRK1m28eYHDfAT
X-Proofpoint-GUID: CizEgCfLWNel99hd2zvRK1m28eYHDfAT

Hi there,

On 14/11/24 9:04 PM, Harshvardhan Jha wrote:
> Following series is a backport of CVE-2024-47674 fix "mm: avoid leaving
> partial pfn mappings around in error case" to 5.10.
A small correction, the 5.10 here should be 5.4 and similarly on the
subject line also.
If you want I can send a v2 but I hope that's not necessary.
>
> This required 3 extra commits to make sure all picks were clean. The
> patchset shows no regression compared to v5.4.285 tag.
>
> Alex Zhang (1):
>   mm/memory.c: make remap_pfn_range() reject unaligned addr
>
> Christoph Hellwig (1):
>   mm: add remap_pfn_range_notrack
>
> WANG Wenhu (1):
>   mm: clarify a confusing comment for remap_pfn_range()
>
> chenqiwu (1):
>   mm: fix ambiguous comments for better code readability
>
>  include/linux/mm.h       |  2 ++
>  include/linux/mm_types.h |  4 +--
>  mm/memory.c              | 54 +++++++++++++++++++++++++---------------
>  3 files changed, 38 insertions(+), 22 deletions(-)
>
Thanks & Regards,

Harshvardhan


