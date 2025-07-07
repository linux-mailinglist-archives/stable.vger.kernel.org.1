Return-Path: <stable+bounces-160376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAACCAFB74C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623884A3188
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FC2E2F09;
	Mon,  7 Jul 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTBea+5T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zb2XUJvt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D62E2EE0
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901975; cv=fail; b=BZvJ8qBrt1kuO16Su4GX1eXR3lkVzlpCoeIgaK28KvIaGrd52CHURhom+yMnGv1bNIIHjjsaz+ZO43++HSnsbfu8LNfD4iP/Wuj9kY9mnJ1BTbWgqT/dIsZ56wE9to9PLrbWTGyNjkAY419iqGh66WwDgJKrkE9mIcCTlcbki9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901975; c=relaxed/simple;
	bh=2M+bXDNfLv7VKAIqpZbDaK4bNssyVKXuxXsgs9rO0O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=antXcHuGP2MF0V8380ofzeX+pqkSlvXW/sHzuO+kt7IUHc2uEE/jSdLYd2v9z4Rms1xo6Ha8XfDt9zmzK2+4rPTnE2jfnpRvCHNBkNHL1AyvYeHXorUC93v7dblNbT7XMe8n3BE781Tj+BD4uuP9MfZ6dq1HRmOyiIvUnxISgA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DTBea+5T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zb2XUJvt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567EMnxZ015982;
	Mon, 7 Jul 2025 15:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nzx+GO/Ae2bqzpxWzPmGGtlgjvwfdczW9on/92Tnx58=; b=
	DTBea+5TP2wp2gqlaOqKGdCTZsOJ6yFHDYqQitDmz/1t2K+yABS938u0DPBFyyxe
	QAu5H3LdFT8mmF9LedXSEz3PxpojqHyGfJXZx5P9YnD58OlA+1sB4vdJsGfJ8FCq
	86grqSO80PyPra0NK/8k2grNt8TjMBwcPH3pdzFRXaLfH25IqU+7qCe42Zpx5C4c
	O6Xoux+93OeCU89ZlCUgBhMpt0jc0C+YqiC06eqvoI4CJmfKTG1Ztgya6BFZlYG8
	Opd5Uk1L3ez4WtxLAEbqmDO8YJfxQiS8WxtKuNsMXLXrn55klyAaXQGUyCE+FskR
	0MdCO0MPXcGUlmtLLalOMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rfxgr5fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:26:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567EVKWr014128;
	Mon, 7 Jul 2025 15:26:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8cx30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES7wbnpKPk3zl6JZAJOcHaEEUHQuB2bDBtzR1y9Qq9A8oHUDAMeAbX+nmJzi/kJn9p6s4m2qGk4i5ehRaeFQyAqSzfFpuU3GQ4OjEN7jWDuzAwMb5vS+FdGpKDkQTQiFERWedubLIXI0gWf8m9f5U1IFsAlbR4Xw6nmSEiaYngdU2GcWGxL90/vjUU2EiBXsF42qsSI9VrwD/WgDROzyu/Pm4Ba6oduS1H/+qcKa4eCo7M4GUTKBTY7BMPFilSlTJg6GRUIpXXrHVoCqRLArcf2y7huFTv00Qeax/axXHVJM9UFaNKL3bE5A24ESp7g1njkKzNrw7/3nqdpKkQ1CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzx+GO/Ae2bqzpxWzPmGGtlgjvwfdczW9on/92Tnx58=;
 b=kwqmPQddbrU4GWTZKAYUWlnqAtUFemtXyY0Dl5m2i+RAZydFM0aaSkKFPKT7H4mMKOc/UN5kazh4Ns7bOOCPpSl3EMpfiNHiB1szTBeTjgjQjEpeZXIVL3BLBPDCMcUYVk11FQnNHOIwUNwtDV1YGiVvuNz/RS7B7aM0i0YyUciS6qaKU0P2w8KwM/RR9lpAT4QmzpzTJc2nMVszR+78ksBMHkAySRumP+TemDvEuS9bHhMhqYmPYcfos4IoE2NYyhX9p8ztP4BRtfqOD2bPLINp6f/r03aJs1vI46lCYJV4wlT8E2G0weDvDZ3y4m8cKblO1N3W9vjBldlo3OstdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzx+GO/Ae2bqzpxWzPmGGtlgjvwfdczW9on/92Tnx58=;
 b=zb2XUJvtkrf8EZzkR6r2npMoGzKyMkbcJuL5Fn9Ji1gLQtydzk6OJQfl6W5a2BLRrcTQ16bpwEPLq8A+OPQwHf8jv/TJdYKb0r+GLcphDScfWG230q30hBGZayYhacTqXseewfBgl8Aoz3d5I6vR+W9Y9Z/bckEHTIv1F7N1B2Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY5PR10MB6117.namprd10.prod.outlook.com (2603:10b6:930:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 15:26:06 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 7 Jul 2025
 15:26:06 +0000
Date: Mon, 7 Jul 2025 11:25:42 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] maple_tree: fix MA_STATE_PREALLOC flag in
 mas_preallocate()
Message-ID: <74wl433nk3eyihyuwmxxdlj7sdw3pnahknzl5vpbcrsnyoc2pg@fi3fdjhqrskb>
References: <20250704150826.140145-1-Liam.Howlett@oracle.com>
 <20250705095844-448fdd14a40518f7@stable.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250705095844-448fdd14a40518f7@stable.kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY5PR10MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b5fc38-9a77-432e-99ba-08ddbd6a9762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXJtNFpmcStxc0lFeCtZUVp0TzU4bysyQ2VGY3VORit4U21vaGxnejhESC91?=
 =?utf-8?B?bnROMkduc09GRk9INzBVanZrTjJNMHFNSTY5UDNjNUFHaVBacERoOVgyKzgw?=
 =?utf-8?B?N1RmSXpoMzFsWjYwWkZwYWRXK3hwTk9SUlBKWFZZUWk1MmQxSWtjZWhueEJC?=
 =?utf-8?B?T3NCUFViVFlJVXJvMlRQcldqK2dKQ3pwYlU3cEpuMW1zbXU0M05OZW83Y1Zw?=
 =?utf-8?B?Z0k4WE5pRG1ocXJIR3BxeS8zQjBiUlFIOW5RZXEyOEMxUkFNSmZ5OElGMUI1?=
 =?utf-8?B?TnBsMUIxNTM3a3VOSllmYTdNaWZSVkNyNnVHTmVxMEhKV0dDYmV0VktHYjdT?=
 =?utf-8?B?SGRSRmcxcFYvYmtDUUtYclh6NDMxMDNzVEhDQ3RzdHVaenNkQWp2ZTdrWXE4?=
 =?utf-8?B?NTFFckk4eUZjbzhKL1p6MnJnWG9mUjY4LzBUWTc1TkNKdVNjVkFiRUxaMkNZ?=
 =?utf-8?B?djlkUEZveWs1UVRKTVFBTURXVSt5dzhVZ1g4OFllV1VHQzZxTldTNE95eGp2?=
 =?utf-8?B?SUh6M01YenMwcGRYdmtLekVCbklWUDVJQVNXRGtYRmU5YTZzMWdxZmlvSnd5?=
 =?utf-8?B?dDgvR1hmNjJNendZRnpkUDhybUlmUmN5V3ZTU1paMnlDTGs3TWdqRWNaOWtK?=
 =?utf-8?B?ZlFMSXYwd1JjdU9ydGl0VGJKZ2x3L0JqUmh3RFVVRHB4SDlESGFBejV1dHJ4?=
 =?utf-8?B?OFBiNXdLc3VVQ25zYTg4MnE1TjQwRVZPSG5tQ3gxYzc2V1l2NEZCMXEyTVJU?=
 =?utf-8?B?RW9odXJrblphay95UXFCWkZvQ2R5WWF3VzIzL1NPTEFIWm5TTzFWZWhLM09U?=
 =?utf-8?B?QlNqajdhSmFlblBTQXAxcDQ3V0plR0pJZW52MG1oMUdBY0R4NGZubTJMWVVi?=
 =?utf-8?B?alQ0U1ovQXJBRTN3R1JKeXNwelhSemZNSm5YcTJ6M1dlSzFrcU9KR2RrNmFs?=
 =?utf-8?B?UnROTkxaNlZrMG01eUFEQUNUbThlZjdPRUZ0SzE3dXg5TThKNVlUczFiRk43?=
 =?utf-8?B?bzY2MkFtcFlYZGxDQmZOTXF5NHB1UmpTa1BXcXpGMXZpTGNsbFo0bVY2aFVz?=
 =?utf-8?B?bmxneTQ3TXJ0Ykc3YStRZ005QXlYZEFhdTlralVOUi8rVGtab1E0cGgySDVJ?=
 =?utf-8?B?WW9nb2Zad3VJOXVaWWhBT01wbk95Nm1aQytZVTIzYk55SmJnT0ZGc1R2YXFz?=
 =?utf-8?B?KzZqSlJwNFdMOWx4SlRuanI3aVFEdE1jS3ErYkN4WkY3MEEwQWxDOUtzYjVF?=
 =?utf-8?B?UVoxMHpiR1FCVkhlZEJab1BWTStCK1RuaW5RdmtlSEJQMFFLRmFsQytqSjhK?=
 =?utf-8?B?YzI3V3l4WWtWTVNJcEdzTDB0cm9uOS8rdVNkTUpqcFJSd0ovUG9ScWFLRTBN?=
 =?utf-8?B?UGtzZmlwZG5kRnJuMzExWUFMY0x4c3ozc3F0cDBrcVgvenVHRXpLYjJHYWRh?=
 =?utf-8?B?Z0txcnpLU09yVHRGNmcxSUwxU2YxRHBjZmRzamQ3N2ZCRCtKL2RIOVZlQ0JH?=
 =?utf-8?B?NTdpaXJ2NlpaellRVWdhcWdTK0hZemZkakZHcDM5cHV3dmlWN2hSdWR4Y05Y?=
 =?utf-8?B?NzN3am4wMWxyWWVKeVNvdTVJSGNzeDFlL2V2OGhSeHE4QmVyNHhXK0s3R1Bs?=
 =?utf-8?B?bE9RTTJ3ZjJUSUt0NUN6MW1mV1V1bnRhWE5BeWt4ZnEyRjVLVnlQZ1hZZFpr?=
 =?utf-8?B?WmZIUWlSTG5hV2VBd0dxUE9RblVDZzV6LzFscFlKS0VySklwTUxlYTdtMnhM?=
 =?utf-8?B?aXdrL3p2UFJzWEZUeDcyV2JwWmFpRHRrOTV1clpVa0g1SlE1dFJLeVNPeGVP?=
 =?utf-8?B?ZkFuYWFOL3QrWmNNTGcwNWFOdHRseE9QWEFMdWFtODd6dHB0OVFIR1BTZzRC?=
 =?utf-8?B?S29kd0RlaDIrNTM2NjBwSEtxY2djbzkzR1BSblUveXFEMWZIeTB5Yy80WWZJ?=
 =?utf-8?Q?9m4vRLFwErQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUN1aTdmWHJMMHlsSW0rTDFlTjcyUWtMdXBlb1ZLK1pSMTBRVXZMNEtGQkZS?=
 =?utf-8?B?QjEwWlNiRjdDVkIrbzVSZnJ6ZjZodjRjbDFBa2NWN1hFUFJDYVhTMlFGTjVL?=
 =?utf-8?B?RnJ5VUJuNVpyWVlYQURpV2xxTlh4cEx6ZVd2RTFiL25yOVpJWUd6NTdONzdY?=
 =?utf-8?B?eks0bUxEOW5melpYM2NEZEhwOUM4NDYzMWJ3LytoMC92dzh0QklMbjZGekdM?=
 =?utf-8?B?ZUUwcU4vbW84T1lDcGFXTTRNdTJaY1NsQmlaWEdXNUR3SjQxMG9nZXo3VkV5?=
 =?utf-8?B?ZzVnczBlRE95QmxZZjBLZng0bnp4ck1oNjZTZm50S1NLQ2xKNWxMKzhZYUs2?=
 =?utf-8?B?TFRBeUI1aDlMSFd4cTZkV1hmSW5kQWR0cTlscmprK3BGL2NBTEQ0a05yTU45?=
 =?utf-8?B?MmtzUXZWbzZDMWVqK2pQb0R0T1RXdWx5cVhQemVGZ1puTnNNbnNUWENTc2J0?=
 =?utf-8?B?cDYrR3Evd09xNUdFZWhpZ3RQa2RzUTllU0lBTEFHZ1ZqaVBQOXp4ZDV4b2tn?=
 =?utf-8?B?eWJRZCtQTVZVWTBtay8wc3NWZGZ4czZycUpUNWN2V0duYko1akhGc09TRWZW?=
 =?utf-8?B?anprZ3NpWHliZlhaWjF4RndCOC9ZQTJVbmE1TEsyOEZIaWNCYTlPdC92SGJX?=
 =?utf-8?B?Vi9IWjhCdTVOOTJCMlpHa1FOM2w1ZEZqMHVJQitOOXJWSkdsK29lL09JZTNj?=
 =?utf-8?B?eWNEeHVnaXBHMWdmbHpzdngzTEtieEpJS2daVFJwZyt4MFVjUU5oZjNoVEto?=
 =?utf-8?B?WmR4N0R5b29SN3BhSTRVMUJVOWRjREZiMlpjK1BTOWVrNHlUYlRkNkJFbkgy?=
 =?utf-8?B?SWRaa20wL2pNdnRXVjJRUW13bVFyTGdvTHgrdzFBWThaTTlxU0hLZEl6MUFs?=
 =?utf-8?B?NE81QURzdVNJU1JTR05ocUtETmErL3hPRmxDSURZS3d0SW12ZktjSWdiTWlQ?=
 =?utf-8?B?Y0RKWWE0RTBHLzViZENlcHI1cVBqejU2ODZOM1RydmtGc0NvVUZDdmhWV2Vz?=
 =?utf-8?B?RFZEdHpTYlNqVUJxTk5WUHNleUNyaUJoN3ptV3FkUkFock9GUWJFSFBPeTVY?=
 =?utf-8?B?Y29WVmpKSkJ0NGp1UzZudmROMnZTNnFYMnRxYTF1eEl6aXE3V3dzRTRjSmNJ?=
 =?utf-8?B?bDZDeFBoODIwd2U2TzJ3QWo4WDdEMTVsNW91RU5nTnREWEhRZlRwVmkvVmF4?=
 =?utf-8?B?UkhiOTJVSEVKUEVXODNPQXRjL3Jhek5QK0xKeldIcFNMMnA4K2xqMWJuSksr?=
 =?utf-8?B?cFJFbHdUYzdkNU1FUHZjeXd4cWg2YmxLZDF2K2t3bVIxUG1lTGNaazBZa3BX?=
 =?utf-8?B?UFJHcnVNRXNuamN4WTlLVDhFMmE2eVpXbmd3ekJYQlNwNWw5dWhha0I0Q1Zy?=
 =?utf-8?B?UWNVS1dvYXJ2UUIrT1R5WmRKRXdzYWVFei93RjVYNDQ5N29qbjNiZ2xydWEy?=
 =?utf-8?B?NStoWkRQRC9sdDE4YXlzTXNTVnFZZEIzSWRvYXE0WjNLb1Bvb1lmb3FKZmZt?=
 =?utf-8?B?VXBUTUZIN1Yrc0Jzc1RXQnkxRU0wMGc2RnJOZG94M0Y5UGdySlpwc2w5OXN1?=
 =?utf-8?B?VDdJVFpydzRHaGpaWUJ6NmxucnhJM0FldlMwV200c2lhM2dDUGxjeVc3ejNU?=
 =?utf-8?B?TFBOdWlBbTU1azFEVGxMMnBvOUpvSGU5TjRZcmtiUDNBVDFMaDBMUEovQVpn?=
 =?utf-8?B?bkNKazg0TTZOaGpxSGxELy9UcDFSczd4RXErNXlNOEYzTEpodk5tMVdTYzNq?=
 =?utf-8?B?OFdvYXJ2UTBUc1FJTjdXRXhyYlZDbThqd1Nta0ltcTVGbm1NMXlBR3dmeVhh?=
 =?utf-8?B?S1lzQkpBN0UvTTFrc2dkUjNPVGh0c0lPYzUwNVlmbXFwY01EOWJjeG9pd2NJ?=
 =?utf-8?B?ZmdCdDBMTVZScXlqbVR6NmRUQ0tOczRJSitRL2tVbmRTM2JjektSQ3Y1UWxH?=
 =?utf-8?B?SUZkYjVFbVlJR2d6amZTK0ZiUlBBa2ZqbWxNdC9KN3Zra1VJQ0VlVHoyeXFn?=
 =?utf-8?B?TlNYYWNpblBZZHRkZStNenpUdCswYkJaL0tab1NuV1FrQXlMSFp2TVduSzlC?=
 =?utf-8?B?dWwyUzZTTFozdGVCMG1tL1JCMWNWZ0ZxVWxXZFl0UXQwNWE5OXltVFV1NU1Y?=
 =?utf-8?Q?XPa9Y3rzQ09m2L4j8ojwDRZr8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	85WgLiCwGzf5dyFjhi5e2W27gDFMW6idz8G8A76IQDdA7wai1ShnBhmsJW0smWRa23p+w1qiaGC7W1PUGOLH8owBuw/tnjWDqD98JJPIVxvEFag+axIyn92k9bCO9HWlFo/VGqMXGV16csk0+H+Lg0githNhgW1qssZb4MVJDwetQXDt43M9PpK70kRq57pQFrwgIxQSqzUIvOfuVpmI8dCoskDjS/IyLMnJAMjmz45/HzNfhs2hqzPw0JO/LDjXXBhR9d7T69JA7b2j/tI1lDC0OsuuatKoCebzBFoOX3tofRcNuXxSgwDpdpU8f6gTETD9GqEtNhOse+/8Dew2UHOrYLgqEHGDp54wZpHCZgTZvFXGh6EmDEjJVdH3DJciE/3vXQ1Ho3v94SDLcqbkmWmcYDpgcrOkrKmEzgkfiElNkuOAaejhf9cACqfn5c9Ad797RFiUr9dDvztXPII8BmHJ6osu8Eu817astPMPPSP6F5gN299hrQYOobRd72ab48b1dmO2yI35dU8rINpUWst+CUPbypZDD79hSAqkJFyqz3WAV7kb3sfOzKd9xnuBJ8U/IN9RV+Qo4f7glUrGYx7n7Xulr1PKBXsDG+h6aNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b5fc38-9a77-432e-99ba-08ddbd6a9762
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:26:06.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a80ExHvADQTALFs3twu03z6wtrVBw/jpZabs/kDx/Iz0Kum8cphzTiC6n4BaD8GsUkk+WzrnnK1uD3JmP2y2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507070091
X-Authority-Analysis: v=2.4 cv=YMyfyQGx c=1 sm=1 tr=0 ts=686be713 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ak0wKcZrDdnAsEg-FNUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058
X-Proofpoint-ORIG-GUID: NeQVH7bJSl5lP4jz5G8dZZjtNM5mLprr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA5MSBTYWx0ZWRfXyp4ARJ386FR3 12LRatt1IEPpy+UnhI5ErBCFe2FX0/+kYYSFEWc4foxTPaX6ZmZfUkclBGqjcBW6AoQTsB0Ho5p OfK4mjsmSREvVIOifa10SmZ+gQ4YVUtRtre7Bk6MdVv8BL4XcSS3Pfrl0dV+m0kV5GF69fFbVV3
 kieQy8oGb46znJqdPxqGbj/EJ4LLV8DDP3mah97b8LegQXGtq/lVcU8HDnmoEmKKLdLSlP9uWia IKDMPSpjpZA5JyjXpOLHq44K0IPajYJugQ0q2mteG4Hg5ZIb+pqH0HiLDC/MGPePCfVkcZDfGTq 0jqAPxuerlrh5E8FKe01If362CBMZKk1bl0Q6u+DSVkoSeyKiEFXVZZHwBiwRQzbO/BWT2TgkYy
 zNNjhLC9IDP4jTKWruapYY81w3TXmr2zOHYmO4mrSsWWZB/4KWoJY14mgs01nI/XyUIxp8oV
X-Proofpoint-GUID: NeQVH7bJSl5lP4jz5G8dZZjtNM5mLprr

* Sasha Levin <sashal@kernel.org> [250705 17:40]:
> [ Sasha's backport helper bot ]
>=20

Hello Sasha's bot!

> Hi,
>=20
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing pr=
oper reference to it
>=20
> Found matching upstream commit: fba46a5d83ca8decb338722fb4899026d8d9ead2

This is correct!  I followed these instructions emailed me:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
 linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fba46a5d83ca8decb338722fb4899026d8d9ead2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063032-sh=
ed-reseller-6709@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..=20
-----

Git added this:
 (cherry picked from commit fba46a5d83ca8decb338722fb4899026d8d9ead2)

So I thought the process of adding the tag:

[ Upstream commit <upstream commit> ]

was removed since 1. greg's email didn't say to add it (which I thought
it did in the past?) and 2. git added something new for the cherry pick.

I will resume adding the tag to backports.

Thanks,
Liam

