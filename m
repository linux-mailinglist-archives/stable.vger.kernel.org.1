Return-Path: <stable+bounces-66054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961C94BF9C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FE4289574
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231418E740;
	Thu,  8 Aug 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LuwEzyWP"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F12770E;
	Thu,  8 Aug 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126905; cv=fail; b=H8K+uZCazSy154dUEGn/b9UaTgfNjqmcZ9leoFkogWiC9/EHkdZBp5NWhYfoHaZBppR49+X+l7lFr5x7+wmpvfUgtjrntO4UBIfU2lVsF/fNDk+Hdb1FzydN2uCpvb3lFnRMgvue+PtK9C1Bb9kIxFTo9IiWlF0P57QuGf2V/Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126905; c=relaxed/simple;
	bh=8JclNzV+320YwS2Nw2AM2Sgbk7sIN5bKxA5inC44aMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVJHtWUBRSORM6+iVvfzpP8EsJLINzMFMiIxtj+pdX7Q30JlRU/HGy+nPpLNnKDlrhqVaU/v1F5VNgbSvvS3EKYoR8DIbYYn14h6Ft0Txr7882Wh8r4grFzres/abf1QL3EIBcmFiAjkHVORIjj6h5SC9lTHA4B5QS2NTu9eAFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LuwEzyWP; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA6FYIY6Qz8jJal6mNbvlyO0OZCRDfUTqsSi0bMY3uNHdNnHj5NPBJTHsjgdAAexIjRQuOPSjjnOFeVptA0yWILG8qMtYcgQ9Dp0REqT8WXyzxBpskKNRw4tnHPwDg0souGOr4o9Lfx3cywRiEWC3oWJQaQpUQquCeDQZ2upVwKOhgR5eua/3xPj5PaYH9JYbtJSyk504djNF/xQ2ntjlFwEm0p5zemeia83/3q9PmcOZEyd44c5fh0QvNPUV5dej6Ptxrqe6yoJ+hiuxl/GftoVbZFbIEh9AjkyZ/IL0kZBADmhFgoJMpjACGAlh98/BP5jfFN0oe7kf2nNUomWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0vau1mjaqX/M0iZF0cvJUgMSzWpqIFmar0ObLlJP88=;
 b=sVA9CzCMLfu2tm4MZuA1iQzW6rSPCh/F8RiIte3RT92gADsP4TWfQ89zA6seyp0v/4wetVU43LvCcisTI+9Igtt/00bsll5i7TkHslzZ2adLgl5p2BrwWBtUbt30XN2q5yiqTo5Rf0Sf5J0Bhcm9gS+cJ22SGKrAdUBt03sPxewmDTpEN9DY3tXFxPpj8aKMep4vVd3eJs0f7sTKbFewQA+VhT4zO/Z7ieFy20sDaeXuieGdw9JwntW0GiX7K68JSwR+51L71TNTp3Rc6P65WZchR8QpYTAs6iH9OVAHvIBqL3S97wFf1DUBGLkovVucE4jerBjjXksnqqvJWZpP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0vau1mjaqX/M0iZF0cvJUgMSzWpqIFmar0ObLlJP88=;
 b=LuwEzyWP1IZAwuYhkRT6pMrlM0aiT8KUswD/Qrdj17POw8tdVndS+yHkgy/aefdqGc4v78qgJxdoWoPqO3TQEeZQISTO+G36bSpU3zf5+XnIQubOAk1e0vaw4DL+ZDAx7iwhaZ5qbuVZ9ffBpCfvjBm/NZ129zQ4ZNg8yfhe/391/qm0NZEofR1MgB1LFSInpwko+04tpS1ozghPKvrcnaCluJpZkDC8xbr0QF9WR/YhKXrHGXsc7P9aiAAVX55Ut6BXuZBFCeF/xhqbb1oAFuXpd4h5ilKb7ZuEyhHHapvJUS6a7eYNGAHuFPWALsu/Le0oGxiuDQyRdRjT1uJ+/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.33; Thu, 8 Aug
 2024 14:21:39 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 14:21:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 "Huang, Ying" <ying.huang@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Thu, 08 Aug 2024 10:21:36 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
In-Reply-To: <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0EA17B2F-7900-4ED0-803B-8A33F87EA02A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN9PR03CA0459.namprd03.prod.outlook.com
 (2603:10b6:408:139::14) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e140b39-1cd3-4735-1eb2-08dcb7b56b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm5yWFJWK2xQcmx2Z0s5UktvbVFaa2lVRjIvWlRDM3VwVmRiTmJnN1BsTmJ6?=
 =?utf-8?B?NnFranNhZkgxOUJubkd2ZmFUZzU2ZjJRY0NPUU0zUS8xclhKN2tqSXdHYTRn?=
 =?utf-8?B?LzErbGlxK2lNM1YxZ1dLV3NQOW5vdzV4UUtSMWo4MFkxa3JoRUxQQ2JaakRj?=
 =?utf-8?B?K1lmdnlCL2hITzhUdFdqN1FsY2h2ZHcrQnR0eWNDaXJXZmRKbVY3ZHBOZVhC?=
 =?utf-8?B?NnNQMVJrN0J4QzNXM2N2SWJrQkR1bHJIUjNEYkpZZmduM2Y0WVVRakE2UlBs?=
 =?utf-8?B?bzR4cXMzNHhQT25WalFOQzdEKy8raFpudWM5cnVDTWg1dVVNQXprS0E3MlZV?=
 =?utf-8?B?N3p3Vi95U2hUYlhSdjdIQ2lNQzJLem0xVlFWdDJneVN1aXVPUEZXNWwyZXdq?=
 =?utf-8?B?dWZmTkpyQ0dLQ0xoN0lWSys0Y1ByUDNSaHhWdURlc01BbmdlNHpLcmJHSmI0?=
 =?utf-8?B?OGRQNHZNRllJSVF1azdlUW9BSld4Nm5KeWZNcWg2dGc0b3VVM25tVWJ5bE5D?=
 =?utf-8?B?TlVLOWx5ZnV4clphSTBRaU9PQnphRTF1R1pzUk5IdWNyaENhZ01mRWY5T3Nz?=
 =?utf-8?B?VDVpemdvK1o0bHB3SDBGeVB0RVNaY1A2NVFGOWVxbytvMi9OR1JHa09GcDdj?=
 =?utf-8?B?V2dWc0NmdnJ2QWMvWGZpRE9ZK3M1VitzZHN2a3B4UmVLUTlObm1NRHZFU1B2?=
 =?utf-8?B?YzlSQkI4MkxTaHQrTzFTaHcraHlGMEVsaE9pNFFLZEFGTTludHFYdXQvd1VN?=
 =?utf-8?B?NVljQ2c2L21SYU9UcnBFWEZVTzJoZVFTbUN6ZHZwYTBUa3JIamlKT1ZFVG5m?=
 =?utf-8?B?NFp5MW9xU2ZGNkhvYnY2cFN1RTZKOERNSlFFcE5HbFNNUjNiNDVoUmgvOGxH?=
 =?utf-8?B?OERoT2ZjOHV4ME5aandhOGRiRzBBUWdJZkJidzNoUnF5eHJiRG1uRTVrMk9u?=
 =?utf-8?B?dUdDOGZENVdXZ205aGVzYkUybTZCMEtidHlYdllqK21MeXNMU0xJZ2pReHVN?=
 =?utf-8?B?SUNPd2oyOFdCaURIdlprVmpveGxHVXFsRjZtbkt4Mk4rVWFUN1hLWGtabjlu?=
 =?utf-8?B?NWtXTEw5VXM2dGtiakt0RGRUMzNBRHZNYWxmdGw1SkxWUXIyNS9xRkxXODI2?=
 =?utf-8?B?d1FoeGxxRlhKMlJhME9CRzVIcWhtUDFkbTZzYmQxTzJGQkVFUVFXbXVhRnVj?=
 =?utf-8?B?ZE9UdnN0WDc4d2dpNDBldmNwSkZOZHVGN0lzQ3JtT21kd1R0VVJxeHl4UmhM?=
 =?utf-8?B?ditDYTBMWVQvQnY1NTYvREtEMjRVeXd3RnF6TGt4dng5emRjYlpqVFhtRXJx?=
 =?utf-8?B?REdvc3c0N2J6b29kWHBOU1FDOUVsR0FWNU13WHdEbFdDVzZGVmhoNEFDRkhD?=
 =?utf-8?B?Qm5YbXhRMDNOdHZJREp6R3daWm9kV25vSGFDMStXdnZKb0EvVS9SMnhQTHBH?=
 =?utf-8?B?UUNpRE4vaXlubmFtdWlTZEYxSStmQWNIb1ZhOEYxZGRrUERXSjFkV09ZQWUy?=
 =?utf-8?B?Wjh3bWFRNGxCeGp4MkIvdXphbGZkL3g1Sm1od1hlZE02K3kxY1J0bkt2WXpS?=
 =?utf-8?B?L0NFN2RRTWhpbWdhVGtabVdLUUIyUExhVEV1ZTAvTEQ4MTRJcWF4VTFTL1VY?=
 =?utf-8?B?S1N2RzkwVkhZbkhDai9uVDJpVUxrQWtQcVA4M1JiVHJGT2o4OE5Ma3ZtR0Ix?=
 =?utf-8?B?M01lVC9YYjRDTE9aeGJCV2tsUVcvdkN6UTNNb0VobFd6UkY5T1V2d1EzVVVn?=
 =?utf-8?B?MEEwZWNKWU0wRkZDVE4xZFJlNXd2QU5qcW93WGgvdkc2SnBGek9jSlZGVnNK?=
 =?utf-8?B?VXhUQ2lQN25XT2JuRkltdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3lWVWhzVnpQUnFGMFYwV25kQVJsbHFHWUpOTlRmV3FQUlFJY05wNTdTZEpy?=
 =?utf-8?B?STBvSjJaaUh2bFI3QnE3RU8rczhFb0tNL2dYaituU1lNdTNQakFIK3NuZGxz?=
 =?utf-8?B?L2JvTlBNSFBHR2E0dFNiSWRMV2pSVkhkK3dkbm1HQTQwTzd4d1dQcnFWNnFw?=
 =?utf-8?B?Sld3cmNnVnd2T1p3Y3ZoeGM3dFdUV3ZFZWdPMExvdnd6ZWIrVkVCblhEVnZi?=
 =?utf-8?B?WERPQ3JkYzZ2c0gzTWllSVg0RDU2cEVsaVpKYjVmMW11a0hoRWh1VXFXdXdX?=
 =?utf-8?B?SGhZUFV2NEh3azVIcEtudk8wZzM0SjU2SDBYV2g0UWFiUUxLU0Q2TWw0dkNk?=
 =?utf-8?B?OHBiVFNJZ2VJcWpKZ1k2RlZTYnNhVXg2N1N5bG9QU3dHZ0pacGpqTjRCYlZX?=
 =?utf-8?B?cEVzRWdUSHhhWW11VzAvZEtLdnp5RlFpUHQ5RU12YWVyRW8wNFZtK1Bwem9r?=
 =?utf-8?B?TXRpSThod0hmT0NpdXZUZnZ3M0NJNTg5bGp0SUE0czBuQlkyclRBczhKRXhL?=
 =?utf-8?B?dlRTZjYrTzcweVpKSnEvWnkzVEZndkIyOGdQeExtbkFUckMzb3ZxemxBSDBG?=
 =?utf-8?B?NFE2ZkREZzZqK0xPZVh1NzBqRDRudy8xcW5hNFNpUWhCbU1XQ3hyQWR5dThS?=
 =?utf-8?B?WGlCdlpZRTJIM0p1ZzhMYStYU0cxN3VBR0VXYTdjNTZOVURTL0YvVG1aL25l?=
 =?utf-8?B?TUxsMmFBNStVZWNTaGNmVG9ZazV5dmtOZnYxRFRrMnlnTzJZam9aMExxbU9z?=
 =?utf-8?B?SzZVbmh5U3hBWHByR1pBZTNHay94Z0d3V1dVYUl1MXA4N3Z4MEs4MnhrcmF1?=
 =?utf-8?B?RVRBek0zQjEvVGdoSEwzSWVoaFdnSmRqZ0Y1ejNJTnd3dlN1RmdSVEdraW9z?=
 =?utf-8?B?WFN5NlQ0Vm1rWktLbXV1YzRPTnQ0NEp4anpiVDhOc2dVYmRyY1dINURrOWk5?=
 =?utf-8?B?K0lqdWRXVUZLR3diUXR6YjZXa2dsZTEvOUhJbjZSZjdRMzFnbUdMS1M0UnI5?=
 =?utf-8?B?T0l2Mmw4OFIySGZhZno4YXd2ZU1WWU1UYy93M1MxZHJFV0pma1ErSzFvYzk2?=
 =?utf-8?B?QXc2SGxEejMycGFldFhaNFh1RTIzL1lkaDhsOFV2dGw1Q1B4T3dYMjhPSklS?=
 =?utf-8?B?VjY4SDhjaG45NEp4M0xidVk2NnJsVGl1YmovVkR5bDdSSjBQVE5EUFBjV1Rj?=
 =?utf-8?B?cE1lenJWOHVXODM2aUVrSDBGR3F3aVIrdEZ4RDNaUVpGZW9pYndUdWwvMXg3?=
 =?utf-8?B?bnVRMHU4QXZpT1h4TVJSZEFjSXJJcFdBUWdiVEs5SGFRYzRDWm5wckpXN1RU?=
 =?utf-8?B?ZkRtTmNVMEZzaDdxdWlqTENqWUV0dC9Oby93NitiZ1orTWVVRmFDbVY4WDJN?=
 =?utf-8?B?MDlBMU1iNEZtZFA0b0U3c3VmY3YvNFBkZGdGdmlRRjdxMVZVb0ZrMTFKN1NZ?=
 =?utf-8?B?Qnkrd3UwaHJFdFR3Zk5RZHpIUWcvclE1S1VPQ2hYVVJlMFlLL1grdDVZd2w5?=
 =?utf-8?B?WjQ2dmpKN29UY204LzZTN01ZV3VMRWdkSTd4STJaczlFSWNBbFA5bnJwREN0?=
 =?utf-8?B?Q3RFaTZLYk10R0pPM1pkYVJNTUJxK05HdjRxdTRYbmVZUm9LQ205ZDdueFls?=
 =?utf-8?B?cWJCbGpkdG40cm00NmhJcGVCYkZhN2NwV3VaMUxmOVQ4N2xYQkpTMGMyQzli?=
 =?utf-8?B?WnJaMlBEVENqaEcrZG9lemRVN3pXVEwvMUhndWhzL1VzVkZFUGNFZVduNmVO?=
 =?utf-8?B?ZTgvaCtobXZQNTlmei8rNHRNRnMxQXNPY3IvRWpBOTN6bzM0bDN6YjYzSUR4?=
 =?utf-8?B?Y040c1c2R0ExSWVBRTlNUXJ4ckJ3dFVZOVh1ejlhRXNkWnBLaG5LcjRHamg1?=
 =?utf-8?B?aUZTK0ZTUElnalFZd25xbkFQZllISkE0UnRmckF5U2prbUhLNnJVTnowM1VL?=
 =?utf-8?B?S0R1ai9SZ25BM1VrNTYzVFRWQ2pzUnZkQzE5c3RkU1djZW4weXhrUnVQc3FB?=
 =?utf-8?B?YUxUUThuTjlGcHFuSU1DY3R2Nkt5a2EvNi9tYS9Ed2piMUF5QVk5L3J1YUYz?=
 =?utf-8?B?cWxoRTB0RnoxNXk2YTB3eTAvcDAzZklnNXZRY2pKRCs0UHBraVFHNGU3dk1t?=
 =?utf-8?Q?gDCnkkw23x73nOU3/maDUEH00?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e140b39-1cd3-4735-1eb2-08dcb7b56b3c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:21:39.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QLHZ80nfi0G6PaFgXAdafA6IIPNcrSYXgRCimQj48Iwnxc2LA0OTy1R7J4SSHOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654

--=_MailMate_0EA17B2F-7900-4ED0-803B-8A33F87EA02A_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_F46D6761-64E2-4125-B759-50F83487BA76_="


--=_MailMate_F46D6761-64E2-4125-B759-50F83487BA76_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 10:14, David Hildenbrand wrote:

> On 08.08.24 16:13, Zi Yan wrote:
>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>
>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/8/8 02:47, Zi Yan wrote:
>>>>> When handling a numa page fault, task_numa_fault() should be called=
 by a
>>>>> process that restores the page table of the faulted folio to avoid
>>>>> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: re=
duce
>>>>> TLB flush via delaying mapping on hint page fault") restructured
>>>>> do_numa_page() and do_huge_pmd_numa_page() and did not avoid
>>>>> task_numa_fault() call in the second page table check after a numa
>>>>> migration failure. Fix it by making all !pte_same()/!pmd_same() ret=
urn
>>>>> immediately.
>>>>>
>>>>> This issue can cause task_numa_fault() being called more than neces=
sary
>>>>> and lead to unexpected numa balancing results (It is hard to tell w=
hether
>>>>> the issue will cause positive or negative performance impact due to=

>>>>> duplicated numa fault counting).
>>>>>
>>>>> Reported-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-des=
k2.ccr.corp.intel.com/
>>>>> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying=
 mapping on hint page fault")
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>
>>>> The fix looks reasonable to me. Feel free to add:
>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> (Nit: These goto labels are a bit confusing and might need some clea=
nup
>>>> in the future.)
>>>
>>> Agreed, maybe we should simply handle that right away and replace the=
 "goto out;" users by "return 0;".
>>>
>>> Then, just copy the 3 LOC.
>>>
>>> For mm/memory.c that would be:
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 67496dc5064f..410ba50ca746 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>>>           if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>                  pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -               goto out;
>>> +               return 0;
>>>          }
>>>           pte =3D pte_modify(old_pte, vma->vm_page_prot);
>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm_faul=
t *vmf)
>>>                  vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pm=
d,
>>>                                                 vmf->address, &vmf->p=
tl);
>>>                  if (unlikely(!vmf->pte))
>>> -                       goto out;
>>> +                       return 0;
>>>                  if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig=
_pte))) {
>>>                          pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -                       goto out;
>>> +                       return 0;
>>>                  }
>>>                  goto out_map;
>>>          }
>>>   -out:
>>>          if (nid !=3D NUMA_NO_NODE)
>>>                  task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>          return 0;
>>> @@ -5552,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>>>                  numa_rebuild_single_mapping(vmf, vma, vmf->address, =
vmf->pte,
>>>                                              writable);
>>>          pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -       goto out;
>>> +       if (nid !=3D NUMA_NO_NODE)
>>> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>> +       return 0;
>>>   }
>>
>> Looks good to me. Thanks.
>>
>> Hi Andrew,
>>
>> Should I resend this for an easy back porting? Or you want to fold Dav=
id=E2=80=99s
>> changes in directly?
>
> Note that I didn't touch huge_memory.c. So maybe just send a fixup on t=
op?

Got it. The fixup is attached.

Best Regards,
Yan, Zi

--=_MailMate_F46D6761-64E2-4125-B759-50F83487BA76_=
Content-Disposition: attachment;
 filename=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-ID: <CE12BED7-1CD0-42D1-9D7A-99A00B7F4332@nvidia.com>
Content-Type: text/plain;
 name=0001-fixup-mm-numa-no-task_numa_fault-call-if-page-table-.patch
Content-Transfer-Encoding: quoted-printable

=46rom c0494d569e77291f7f51abb16c2ceff0976371f4 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 8 Aug 2024 10:18:42 -0400
Subject: [PATCH] fixup! mm/numa: no task_numa_fault() call if page table =
is
 changed

---
 mm/huge_memory.c | 11 +++++------
 mm/memory.c      | 12 ++++++------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3c018f2b554..4e8746769a97 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1681,7 +1681,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 		spin_unlock(vmf->ptl);
-		goto out;
+		return 0;
 	}
 =

 	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
@@ -1729,16 +1729,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault =
*vmf)
 		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
 		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
 			spin_unlock(vmf->ptl);
-			goto out;
+			return 0;
 		}
 		goto out_map;
 	}
 =

-count_fault:
 	if (nid !=3D NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
-
-out:
 	return 0;
 =

 out_map:
@@ -1750,7 +1747,9 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-	goto count_fault;
+	if (nid !=3D NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+	return 0;
 }
 =

 /*
diff --git a/mm/memory.c b/mm/memory.c
index 503d493263df..410ba50ca746 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 =

 	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
+		return 0;
 	}
 =

 	pte =3D pte_modify(old_pte, vma->vm_page_prot);
@@ -5528,18 +5528,16 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
 		vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
-			goto out;
+			return 0;
 		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			goto out;
+			return 0;
 		}
 		goto out_map;
 	}
 =

-count_fault:
 	if (nid !=3D NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
-out:
 	return 0;
 out_map:
 	/*
@@ -5553,7 +5551,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	goto count_fault;
+	if (nid !=3D NUMA_NO_NODE)
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+	return 0;
 }
 =

 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
-- =

2.43.0


--=_MailMate_F46D6761-64E2-4125-B759-50F83487BA76_=--

--=_MailMate_0EA17B2F-7900-4ED0-803B-8A33F87EA02A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma01HAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKM9MQAKFkXj61C+HLmAvZP31S4hb/H4OwCf2mjdw9
1WKwHAJQZjtFm6A1b88bk6bvu/7dOxW9V5VhbRASfZGqSjQEMI3aS5KjeAAYIk3G
IB32EAXfiBsUWGHc22m/4qZfiBb7KUqigFZWqnEwEQkOpTd6QqPGwJHaV7X+xV34
u9gj4QSRvSpvARJQOMmuTvdrcB8sc2FCfVNLPdooFNEVBuQ6CfP1fHJMlAj4085d
+34gnMUXPvvBBD811PwORcnsAHb0XckQdtDu/HaWuhM4kyBZBA+dWQqnosGWtJD8
QGN7/CiSYSqip5oDCNi8UgaKxaF6t0YDA5i2Oe5ZDIuyUYBkTeF1xXCmq7+KOcGa
xQO+8SMXnRGUNKtLlEACVSQtfJhXoHZOzcKCx8CBBH90uylCDeqIQSCYEzPMmetb
anYQ2oo+DWbl0QN2YV58vvIDgcM5sunI9dpK1Db7ziFXAsVikNqOWjvhVIMUkBgy
LEtTpZsXiozF1stujgue+azL5vCAoCxS7GIWIe9aTEKRqfSdhxpZ0q5I7obwrLig
SSi+WmfVoJspqywOguAbhBW4M+KjInx3BZ1zlaxeH2dRXpzHsRyT9ctcnGxmNJTF
Oyhzuft7nqnIk73+XEuJQl26RpMz8obFoRR2AfMXEIPW5vQzTH1FVUd0/y6Ll0ki
DdJkpUnU
=fF9s
-----END PGP SIGNATURE-----

--=_MailMate_0EA17B2F-7900-4ED0-803B-8A33F87EA02A_=--

