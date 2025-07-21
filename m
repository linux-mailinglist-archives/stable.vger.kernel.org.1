Return-Path: <stable+bounces-163616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F0B0C865
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE97D7AE8A2
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD62DF3F8;
	Mon, 21 Jul 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIwEEp30";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OW0YWHAv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5C2989AD
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113818; cv=fail; b=iA2dBQzMWMPwMHlguCGKCR6Inddm11yt0BzpBmR2B9iLkesZ3/InfYVK9FOWr4SvRiI3robd0h7swMCgrxGcYzJ22bo36qEa5fyIQEh/YI0raFu3/85xiipxj/zy/9+z/ahLnmpbZ6C2VT7bFilQb7dONM4hqPB3dCU9X7kNxJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113818; c=relaxed/simple;
	bh=ECwYkvLVPwt0R9pfuQIKkcM+0kCf/bGF0Pp1EbVKB9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RMbm3BrEMBuEBC53U6gVwkWdUka+I6CyzRrpmJ2G3gi4v6Dty9ncbMIEXMSnhaF0bu8TqZaH966K+zZ4ELFdZShXWLNDBTS8ce20iIdDPNjHQPkNsGejcFBSAY0MgCJYNTRVkG1EFPtVFf5cd9xu1rs++Ipxcap2HIxqu54z4J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eIwEEp30; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OW0YWHAv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQd8b006851;
	Mon, 21 Jul 2025 16:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TtxqL54qjPApCgelaB8VLkZ8D1GdshKBGvm3rilEa7I=; b=
	eIwEEp30ol3W4dHcq9joAksuKmDE1GUgiaKYdgeGO5wW6EoVgvBsDMNV0vePalKU
	bguDQrwPjaigSVY6bvbYsPP+3bnLnPs6fd2FHNFBZjbVbLXtkoo1KPL1VhMKD8XD
	EUelZzMdFBf/xxMRFoW8Vgw6qcUMUeocajIAon+fNyeXe4fg6jOZOfrTxO9NLlKb
	/j+PlD/1RGs5gqKneWki9nXsdieqrpHDLoopZdu0o8VinnI7LfyHQbzAfnAJDcib
	B22xBl/R4T3/2CXG7AaaDqzn3Bt+Z9I4xJGkvO8PyM7111Xru02nLv2axi9N8VED
	j9IksS1CdIdmkV4LZ0eVRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qu5ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 16:03:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFCD41011419;
	Mon, 21 Jul 2025 16:03:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t87bs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 16:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6LGxo4ClRjiIeZQYGwY0HE7FwJIsdDl6VaSpWh/AXGJH/9ETn961PGf74Lz/IBeYxioeNnt4WkZlxiLN9bLBB5gMIl7DO4clXHd6f65l0audyCOgfCdQJobPytLB30/bLB7g23V4tfitKEL0dha/AN3vRGtottXC8523cA3h4Bdv0M49DQgNOIsX6i1n18w5dKr0Xwg5lQFCLajaf+p/bDv7g+pjIwJHJpYBN804ZSm0NPVwIpyRKHABzBfPHKD5p/PJoyhlenc9yo9V9YP/oKVI6Wz68XXLn+DTmpBK+y0U6n0mp50po8E88HBskUJL7ltgjvIqU3WxshPNgCgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtxqL54qjPApCgelaB8VLkZ8D1GdshKBGvm3rilEa7I=;
 b=x4PB+mCLSlywsdc9rnL9DoGfUQbD1L+rAXwVgODkZOdT3L/+xsdc1KA6GtLbrIGgT6XwMgRdYtNLeqLxxAIc0nC5Y/ijv/5NOrjiNlEyMXc+R6Yzp5QC6yi/84U353YGNuBih7x/Nnjx0jwk47PwyXNiHWOG8QLt26gbIepQ+oGBGYg8n66ZOoINQfCywgPvEiCOYiT08+lQl2f2Ryk0Gttd3y76Y820UsJ5ByBFu3A0cmFdxoW+ps9we/XZdcr7inKgn2x2/PblkJn2wVAVSeMNBxL4m15V+XJw0vVHKEgcwLleUdjMg2BuxxkoyONYDJtkwiT3DRam1LabdsjVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtxqL54qjPApCgelaB8VLkZ8D1GdshKBGvm3rilEa7I=;
 b=OW0YWHAvENo449bwdKE1QyqHQdKzzL/G+kIpENge4/E0SFIhbd1SDrHOJ397ndGNlue9Xv55N3o+Her+6UaHmLk856kPJh6KV78lI1dzKEGRYLLsqHavM3V17jE0uVR7B6ttuLmJrc2g49lkwtmxnpQhTF0EX3vdxx5KTKQ+Fl8=
Received: from MWHPR1001MB2317.namprd10.prod.outlook.com
 (2603:10b6:301:35::22) by PH8PR10MB6316.namprd10.prod.outlook.com
 (2603:10b6:510:1cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:03:24 +0000
Received: from MWHPR1001MB2317.namprd10.prod.outlook.com
 ([fe80::ad6:f772:35de:63a8]) by MWHPR1001MB2317.namprd10.prod.outlook.com
 ([fe80::ad6:f772:35de:63a8%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 16:03:24 +0000
Message-ID: <53640837-9c42-41a6-a200-f4074e0931e2@oracle.com>
Date: Mon, 21 Jul 2025 21:33:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] usb: dwc3: qcom: Don't leave BCR asserted
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable <stable@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2025072117-left-ground-e763@gregkh>
 <20250721155109.855693-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250721155109.855693-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2317:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f86cd6b-962b-4545-7a91-08ddc8701e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJpMG1TY3lBcm95cG91K2JSdmZyZ3BLSFpkRDhLVHc2Mlp6bVB6eWgzakw2?=
 =?utf-8?B?OFJ5eG11NnNhU1A0cG5hcGFSL2QvTGR4UDdrVUxjUTFUU0x5U1VrclZyR3Nn?=
 =?utf-8?B?NmhMYkZUcGEzN0FacDljaVYwUW1scE9Qdmw3dWVYUlJFb09VVkpMb0FjTk9M?=
 =?utf-8?B?dlV1bFcwdXljdkhhVWhEZHR6bVVwa1ZidmhkQndKcnRYeEdtc3FQSTdWRUF2?=
 =?utf-8?B?SWFiNVFKTjJ2Y0NvM0U4S1JoZm43NnFNZEJaVktXUHI2VnA1Tkw2YW1NQVNV?=
 =?utf-8?B?cVAzQUNiUnl3a25PclVqb0Fpd3E0OGVEK3Q5ZGZxNzdDSFArSG1BUmgveW5r?=
 =?utf-8?B?akdUaUhGeG9rTHNEUk5MUno5U3QrRnRlSUFuUHlKd1d2ZlpsMUZacUtHUFQw?=
 =?utf-8?B?UmJjZmwveThnOG1RZjBjN2lPOTFMb2U4Y3dvTW4zYzl1Y0FMeWs4S3AvdENE?=
 =?utf-8?B?OWdVclFTQUVqQ0tjdkZWZVBqYTgyUlJHeStrZWVLLy8xT2lnZVY2dGlYcDFP?=
 =?utf-8?B?STQ3K010bmRORW1zZitBaWI2WVdNM1U5ZFpXdFpmUXBMQmJNOHhyR2UzVUZF?=
 =?utf-8?B?NVJuZ2w5Q1pPZU5jQ0M1ZisvNDJjUjYveVlQdmErckJia01Bd1lQTGJuODYv?=
 =?utf-8?B?Sk53RVl5OTRxZkdaWTEzejhUcnJYYS93VklJQmFVdytCb1FUdjl5cUtlbnRS?=
 =?utf-8?B?RjJLZHZTckZ0dkg1OHgyZkhYbTJVQW9GN05Xd21uTExReC9mRFZWb1pFNmV0?=
 =?utf-8?B?bGoxZnpubGlyOFFMTy9KM1hVNVNmeUc0Z3dwVWg0WUY3ZkwwZGIxRFZZWGY0?=
 =?utf-8?B?SHFqd0FSbGd5V1lOaU1FeUNWUGVuQjlOVkp1bE13RjFXNlpOamMyMjVQRlhC?=
 =?utf-8?B?YWs0Y3FHZmQ1S0xlSmVRcGkwQnN1V1RyQi81S2VFWmFDaXlkWlB4ZEdZcitk?=
 =?utf-8?B?U3RsQ3g4MVNCcmV6K250UXVEY2tIdmpWbGYzRFdKUFZlNEZFVkhSVnpYV0Ev?=
 =?utf-8?B?SzNhK1ZuVjRjeDBCYUJMWTRsVUhUZXVPRFdrRzRnSFNZYUxyQWtHSEJNOWRE?=
 =?utf-8?B?dkppL3lJUnFFcjNwR3g1MmhXYnpWS09hdTNCdFJrVlFnYThRNjg5aUFBdk5L?=
 =?utf-8?B?cVlqVVJ6eGUzTmdrejVBUnZORkthSHhOaGNncHRlUXBraEdCZVpFWHR0eWJX?=
 =?utf-8?B?bisxZUVlUjB3eXh3Vi96OXJ6S3NCdkV6MnNiVWIxanhkTnVoeTBOOElreTIw?=
 =?utf-8?B?eDFZdExyLzMrN3JOYndWU05VV1pLbWVqb0tZZ2xtVDAyL2ZHVGJOd1JZMmZq?=
 =?utf-8?B?Y25kcVRHam1sVDZJSjVvbi9lTjZYV0dhKzkreDUrUFQ3b2FKQ2xsNjZSMkFu?=
 =?utf-8?B?cGFPYTBhZ09ubDlaaHh0RkNjdk1nQlppbnluTEdWWU5pTHMzampXMlo1aDZq?=
 =?utf-8?B?aCs2TVJXalZPWlNvdndvT29BR05HYlhaVndnalJBUGZUWjNldTkvSGNYdGJx?=
 =?utf-8?B?Z3hpaFBTZUNPaDE1bzdIdExJM1RYZU5nSkJuU2wvOXBxRzV1YUM2Rk1EWFBu?=
 =?utf-8?B?OFdJSEN6eGt2ZjlMUjdXeUw4MitCY0pxdVMwdTc3TlRLK2VWWXczOU9tZFNP?=
 =?utf-8?B?V0RBb3oreUozeis3T0JhYXlxdlgvZXN0WTNRMHJGWm9zOE5hcEVtNXF3Y1dq?=
 =?utf-8?B?cmpOUm5FOXV1VG43aHNXR0NYL3I2SW9CdHZEdjcyMkVpb2NodnQvNHJjOUpI?=
 =?utf-8?B?Z0x6TlB5R0tzaUFEQ2RCaGpIS0xhMEdqeTg5VDF5SGxTeFBaY0czcktvYzVh?=
 =?utf-8?B?U1phazN1L2xnT05iRDdoUnY1TmR5cE5RNVVCakpOaUgwdUJCYXdJWHNWQXRR?=
 =?utf-8?B?OFpCVm5CL1piM050UlV2QytrWkQrU3VXTDVlUW9tZmhEbkhFVDUwNmczRWp6?=
 =?utf-8?Q?DbJ4Zv8G8+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2317.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJ6Yk9kSXVGMG0vdWRlZndlVzBsR2IwUkRPazV3R1dmZHViRzkxeU1nSnk0?=
 =?utf-8?B?aC92ZEhiUDFUaWxTOUtmMGpsMXA1cU9ET0NqUUFVaDFQU2t2eW9EbnNHLzM0?=
 =?utf-8?B?QURaNUt5UHlTUmdORUdRL2k1UTBPNGdQUCt0NENZbTFhRjdZYWd1ckZYbHR0?=
 =?utf-8?B?OU5QNWNlRzlNWDR3UVV4YXM3dVYrdWcvNWFNVm5oNFlVSlk3VlJmQTdWNXBq?=
 =?utf-8?B?ZHVFVlpkU25vMVNER2RYdllBRUIxakUva1FtTStFM0FqeWsrL3ByTStYc2Jx?=
 =?utf-8?B?Wkt5TGxod2ZpOC8xTVArYlRiTEdWUmpabmFVQ3Z6Q1J3cys1ZGFGamFlYkVG?=
 =?utf-8?B?czhzV2p1M2xIU0VBSXQzR25adkQ4ai9nbXRsdVRjbHNmbUs5eWJNRjY2WFMr?=
 =?utf-8?B?cmM2cFRta2dHRWZqNjg2V1haZHJmNzdVQVB4dDJhQ3Vycjh0WjZPUW5CNU93?=
 =?utf-8?B?a3ZHTExIUlM2YityaC9zdVY2RXI2S0lkZ1VOcjMvR3BLWDUxTmVONE1wRlpB?=
 =?utf-8?B?OWxBU0VoWGZWKzF3WGlWZ0t3eHJNYVQ3K3l5VXNZVmQrT2VLYzc1N3YvVXpk?=
 =?utf-8?B?WHN0cVNsOWRVbjJYcEVZZUFsNktXaWN1elZqUi9ZZUN1U09SVkRLWE5OS084?=
 =?utf-8?B?TnUwTkZVSmtBSHZ4ak0wTFpjcFpSM2xGbWEyVTU5dHFZc2Qzc2hCOCtZc0Rh?=
 =?utf-8?B?enJyaGRhRUJLczJGTGdMaUhMSTNSYUEwWlFXbEhvbVZMSHlPV0NidGk1bmVs?=
 =?utf-8?B?NlJSQVA2cWQ5MmhkZWVWMkQvcDJQdGxKc09uUVEzcVA1MWxaZ3lVUll2QUdh?=
 =?utf-8?B?UjV1VHozSDRBVGI4RVdJS1VwVDFQeit5OU9nODJZMm1qZHZSMW03SXlpelVp?=
 =?utf-8?B?SngzRWN6Z3YvbTlESm1CUUN1Qms1ZFROSTk5T1pvdjB0U1V5ZU8ydEMwemZo?=
 =?utf-8?B?dFdrZ3Fpb3JBci9taEpTVjJhWFRNNU5sdk1manJoUnJzd1VFWmpTMjhHUGRn?=
 =?utf-8?B?R0NwMnY2NkdlRmhPOHdWMkUxRW1YRStQZGp0Ui9CeVhaR00xdGlFMkNQMnN1?=
 =?utf-8?B?UHdjT09wdzNIZVJpdmJLTHRVazQ1bDUvbmo1NGJmeldlczJwWnNmRDQ1ZVlr?=
 =?utf-8?B?ZzJ2cnVlUWhsK3g1NFgwQ1Nja0RTSzVqVUdXK1RDV0dHSkdKVDNYWmdSeTg4?=
 =?utf-8?B?NFpXbWI2ajZXNVJ4VnJTeWFpZkRKRXNxdlhVQlZoVDZBNjh1cURldnovckNW?=
 =?utf-8?B?aW8xM0drU3pEYjZ1S0gzZmxlZWhUTnZIYzdtejFFWWJSZzlLMERGUEJXMEFk?=
 =?utf-8?B?VlVqcXIrQndWME0vb0pDNHRLTFJzdnFkeWNrOG9HUXlES2tMRVBwdmdjcCtC?=
 =?utf-8?B?QjN2VEsramxMbmhvcmhVM1hQRVhCY3FCbnQ4b3RoayswOXdjdVMxRUljOEtr?=
 =?utf-8?B?OHl0RHRab05mMWFMbi9rWFVhcXFwSHdBYjNSbVZWNlF1cmJFVGxlSHJwWEto?=
 =?utf-8?B?dUhpUDRnUzE0TE1CSXQwOTJiQzN4eHNFdGxuSnQ1eWJkRTJ0b2FMVkJ1d0t3?=
 =?utf-8?B?Z1pDWEVXOUkzZmd4YnhMZFlZVkNxQnlZaWV1SkNHaWdzVlZEc0NjT1UrS3lC?=
 =?utf-8?B?QjA0MTRiaVpuQTAvaG53UVk4SFVEVUQxWlhUektOekFKTnlMRzBYS0htakdh?=
 =?utf-8?B?ejFIZUdtZW53MTNYSkp1QzNqZzkxTXUvWjFCcmNXSnNHSkFEK2FMMVJVbVln?=
 =?utf-8?B?d2Z3bkdZYlluNTNFOWMydDlycUI4aWpaQmh5Z2hDVTNKSHdXMjhWTnNTWDZa?=
 =?utf-8?B?aDBNYWxiK3VvMXdHOTI2ai8xMjJ1QnZZS0o5aWNmUEVOcXY3eGdBQU9melRs?=
 =?utf-8?B?Q2w3SDZ2blcwL1VpZXJoTWs5SW5GeDZCejdXamgvbHV6RVBhekgrK2pkUzE2?=
 =?utf-8?B?dFI1aEpnR1c0a2lUK3Nmb3MvWUM1V2VoRCtaT0ptVm82WEcvMzVtck9TNlUv?=
 =?utf-8?B?azMxOVBVWnppeEZuZGQxOE85YnJQZWwrNzBHdFNCYUdsSXdSREhMd1hGNFBF?=
 =?utf-8?B?Y1BaVXJLeHFBMDYrVEhEbGs4VUJHcmJuZ0k1d3Q0QkRhckJmaVU0aXFWT3Rk?=
 =?utf-8?B?OWhUMmZDbGlON1E1ejZXbU5zMG5NUS9qa29wb2FtekRjQjllQkloUWVSNVlr?=
 =?utf-8?Q?OhvMwzX9HCP+zG7+iZlQvyE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	adEoevkc/6Tj/3IokF2LUaH1E1ymkJQ33MTUT8VZCfOQZTnVBZjVn9BxRGFLvWC3mwij7ziq/eZ6M/fucQ3JyhZIEMqWqufhKjpZ2hYbeWKH62MAmHEl7mw8Jfpv2/2K4tD4eDvOa1MqAU4Oee2Eku/AfgNMVYRqzqWt8TDwg9FFhVsnoKJr8IsAqrLuIcNSk989dZeCbQMtdSMLs6gSKuaT7FNmvDi4+OEH1x2Kf0+umIRHT/jvfYTrXN2tOBS7FeLfi567IU2Aye3V29KpPGWonpmYNh+jI5Gxl11S1zWAHDCNIcY595clp0iWNSDeZYdMwUC0MfXaJJ2LozW0L5q/ZKwBa9h4ppyWDaDrhRCEi9/AtDYqVqSiE6UrL2HHZbOO3GBr2n3NHqDVh48dkWFe/peDh1dO5pm1ejQCl5bardm9HsEDHOMROPFw40VX/m/rSToQiisR9U8CJvaOIoIXiDClAST+lga837wqfxQooMr/bKhCBE/3tkiyjs9KzysKvdBgQoOa4rhOrSoVlJB/YuO5fNgJPNf3ddFQo4aCYsAtWGxPmqEHPY2ncVhvkioTG607/WCMcycYNA2xr1zMmyg0tsVZ3mprSPTyaB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f86cd6b-962b-4545-7a91-08ddc8701e28
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:03:24.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG6wNChonoxTMoHrLvoiMO7IafSZKjccTekTz4Ad/KUZpx8O6ABj/Sk5LQa+jYjpAkhtvikE+Fn2zDC5tZdlWtZhnIbfhHtTcGhNJr8proKWAP0qmhGlNVJeP4wEvBTI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210142
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687e64d0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=ag1SF4gXAAAA:8
 a=CVdMSXH7w2WU2oR_e4cA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: 1vG4JKEfBEdNAjAJFseP0jmBY_FYzCGY
X-Proofpoint-GUID: 1vG4JKEfBEdNAjAJFseP0jmBY_FYzCGY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE0MiBTYWx0ZWRfXxqxGyfgE/fXe
 CFoIT/iazVIBwSzPhjFloMm7HpnnJfEEfRAJ7CjnF0Y9644ecYqNCELGEMKdEkjgvVWHs62o/MG
 Cx/qnhBEw01buJRiPxB1nmHG/ovwX+5C7gz83clwa5IAPZ1DVtu9H5O29R/PVuCtOwRUZY4XqCy
 0dprMmUXDos7/VMmabGevzNimRinG3s5r3EDlU7FefI9XcX9lRKJjHsaWcGS+3I2ab/K9loG3r1
 VK76fTG1DxGIPvJnbiLyVlfOccbLDxdN+QLpYtHh0xgqHpGnZRsM4AfAG3A/y38KF+AfRaIt9Hl
 ALuqM7rqWtXCH7Fd7bMjNQP7wEwasQQ2ddItDvV6totgrv4HRVq19oMD1DrHsyY9jlh1YOhDPqa
 8kTiv2rBJSi0s0H6/xAcklL5k8CQu0LoB4cIxF1mBiaCL+1QS6/CxfLqVu4QYA8i+8RXJ3Yh

Hi Sasha,

On 21/07/25 21:21, Sasha Levin wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> [ Upstream commit ef8abc0ba49ce717e6bc4124e88e59982671f3b5 ]
> 
> Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
> blocks any subsequent attempts of probing the device, e.g. after a probe
> deferral, with the following showing in the log:
> 
> [    1.332226] usb30_prim_gdsc status stuck at 'off'
> 
> Leave the BCR deasserted when exiting the driver to avoid this issue.
> 
> Cc: stable <stable@kernel.org>
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ adapted to individual clock management API instead of bulk clock operations ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/usb/dwc3/dwc3-qcom.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 742be1e07a01d..4874a6442c806 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -615,13 +615,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   	ret = reset_control_deassert(qcom->resets);
>   	if (ret) {
>   		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
> -		goto reset_assert;
> +		return ret;
>   	}
>   
>   	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
>   	if (ret) {
>   		dev_err(dev, "failed to get clocks\n");
> -		goto reset_assert;
> +		return ret;
>   	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -700,8 +700,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>   		clk_disable_unprepare(qcom->clks[i]);
>   		clk_put(qcom->clks[i]);
>   	}
> -reset_assert:
> -	reset_control_assert(qcom->resets);
>   
>   	return ret;
>   }
> @@ -725,7 +723,7 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
>   	}
>   	qcom->num_clocks = 0;
>   
> -	reset_control_assert(qcom->resets);
> +	dwc3_qcom_interconnect_exit(qcom);
>   

^^ This part of diff doesn't look good to me. Can you please double 
check the conflict resolution ? (Probably shouldn't have addition in 
this hunk)

Thanks,
Harshit
>   	pm_runtime_allow(dev);
>   	pm_runtime_disable(dev);


