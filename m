Return-Path: <stable+bounces-214794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACyvLvJUh2kRWwQAu9opvQ
	(envelope-from <stable+bounces-214794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:06:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6424B1064ED
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2476B3006152
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4062352F89;
	Sat,  7 Feb 2026 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9bAfm3p"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E68352C59
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476783; cv=fail; b=n9azulBm2qMzBqiFlRHcn/dSPRzb8SLu5yRoFOkoAkxkeZO0IzzRkz1XRAaW8Vjq+URizNqS++BGyLiXg/GSfD9nQa6JlluaSr7jNk2mWAVubJDe63SmHNyHBjN7ycQUWwbUATnCrMhZABGouZMnBP/UAxg7eCbSja579qtfKbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476783; c=relaxed/simple;
	bh=lSCvmpgrz6plczPMDZ7PMWPhVp3KY5Lqs04/z7T5G+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdatCLreWv6JdcdB2Rhd4zpzvHzE+U/ODR0p9/hhWNvldPRxbIo/9NCpWJQRIN6RYmsTCMMqkWv+BFbXsQwy8gA9ZUuzWJJyPQB2Ys4AEw5aXRvjCvIOXuFdF5OXLzJdvGa9xPIiSnJh5JJof/5pdkbPhMUE1CGToy8ntwUdLHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9bAfm3p; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdxCIgzqvYc1n6Iv5+KOAK8exqaFh5kt3COdaRksV+AzkRDWb8wUllC5h08m249SkNs+iZuw8HSjI0zJTTalqQcpzi78yIpKLoObOJQBDFUUy7IslJJ2Xx4pg3T/vYLoly+cnMiH4NkTWeU5TUozSkKBeVVrnKipGOD3/sMgrCscTJnP/405zJQxA6HseCztjk2nvxIo/+0cb4U/orwYuBj3Gv8mhuRrIRFb2mbzfoxt3bpDZHPIgbsJ/yaksxrpklXMoX6GNkAFWboeC3mNIuLYp8oUAxdEq2pq96846vZ+UKTfjDa2ZdAUX98BknK732Mbid4qc8JxlK0B1Owykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSCvmpgrz6plczPMDZ7PMWPhVp3KY5Lqs04/z7T5G+o=;
 b=kvFrculRCNQOItH817QXNt2v/rroeV0N8XwO9FARsx3ED91mzH4uilgtcTehpBfvCH5fuYNpTzMrYEf9yW6B2DyMXXtxkN7QaRyQZVjzP9g5b+W+9yhXUj53DJ2ScFGCpmpIR41xB00QOjKVhDsH07ka4JSAppEaZ2EsFf68DB5+OLqTLGj9OGiJ+B01EbgUPERdGj9Dhzq3YWKHTlbche93oIQknTaJShNQQeHy2+tuDxrCukxzwd5d8YElbaqtwt7M46sP5Vxyq8/7fn0wRjgHRLnuAbwf807m4hNYQDC0QbJTT7imlde6yVHlYbXq81nvVvTh1N8Z0Nob5O/8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSCvmpgrz6plczPMDZ7PMWPhVp3KY5Lqs04/z7T5G+o=;
 b=n9bAfm3pT6vTAi1lzS1m7x04Ih8OMa1b7nq0KYa+s+9OFjV1Njpg1jyvwmfzwFaZkV8bTa5bH4jG8kLtVzKRPA58WH44yyx3U891gfUAHjyNN8H7wozsI0dHLuw0A+csB/snT8yVhwwFw7342LmXXX8lgIgL2f8D/a0H8q4EbICeCGubz1fbLiIj/fwuHPjhHI0B5jmPFOsdvZk9TTAncCevfArRo3SZ8jd3mrx/WAvQrtAcFp2uQO8Aw1ZJdE/EFAtcWI7bgsRTGdA2vRb/9az5VmsFpmMrHA4k7ViexLgaxw4r6JNIBbJ16eCsLeWPKUtAI9RhgH6nGjIJhuWXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Sat, 7 Feb 2026 15:06:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.017; Sat, 7 Feb 2026
 15:06:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, chrisl@kernel.org, kasong@tencent.com,
 hughd@google.com, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, surenb@google.com,
 Matthew Wilcox <willy@infradead.org>, mhocko@suse.com, hannes@cmpxchg.org,
 jackmanb@google.com, vbabka@suse.cz, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
Date: Sat, 07 Feb 2026 10:06:17 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <17A126A7-BACA-49E5-8A89-F8E665981136@nvidia.com>
In-Reply-To: <CABXGCsMx5xxxaqsLMHrRE=K2-QQ8AsYWbpo=eCf+PKBEGXSZXw@mail.gmail.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
 <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com>
 <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com>
 <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
 <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
 <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com>
 <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
 <CABXGCsNyt6DB=SX9JWD=-WK_BiHhbXaCPNV-GOM8GskKJVAn_A@mail.gmail.com>
 <247E7FE9-E089-43D1-882B-81C7134C2FFE@nvidia.com>
 <CABXGCsMx5xxxaqsLMHrRE=K2-QQ8AsYWbpo=eCf+PKBEGXSZXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59d71a-df6a-458d-7ccd-08de665a72ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnI5YTdzdEtzNEx6MUhsWGc2SGZldDRUaU5iWFNwc1dud3MrMEU1amZDSER1?=
 =?utf-8?B?WWJsMGF5R2x2OXN2QU94UTJTa3JGQmxnWjlJMzlRRTJ5WjR1a3k4UG5hc29k?=
 =?utf-8?B?ZXUwRFNvZjZmSm1pdUh5YW9UWEVWS3k5dS8rN0U3NzZkMzlOS2pENnJzMWdx?=
 =?utf-8?B?SlVpSFoyQ2FaeG9mK2FmaTRTdHVNU3BqRGtxYWRVSm5MRXA3N3FOT1pBa28x?=
 =?utf-8?B?RE1CL2wwV0xYVjVTWTMyYnl5bWQ1eXR2dVRaWWJmaVpVOERaSWZTTTIxZnhK?=
 =?utf-8?B?Z0R1TDVOak1KS28yV1dad001d0crZ2RzWk5jOFlDL0g1UXdLdkxpSnh2UlpU?=
 =?utf-8?B?Q0ROTjRNZU95c0R0ZXVEaGZiaU9ES0xWQVZhR3BkNVM3aUpJa3RnUk9YVEZ6?=
 =?utf-8?B?aWNzaE1KdUM0bG9BNE1uSUFBM0Y2Zkw5M2RFd0UybTdnUlNjQVMwUnJmWFRN?=
 =?utf-8?B?RFFNRUllc3QyM3FkQmpzQ0dmSlVYNEY0eElDU2NQWjgxVXlqRHJIMzB0WDhj?=
 =?utf-8?B?RWdTZ3JmcHZuMlZUY21XZE5wc0tqNUt6a2huWGwzb3dqeXo2TUlUOWZPTDQ5?=
 =?utf-8?B?cm10SDdKNG5iRjd1TmFZN0xWT0NReC9TWThxb3pyN2t4cmVKeU9mV0ZzODF1?=
 =?utf-8?B?NVMzSFJEejNTdkpLclBxMjNYRSs2K2JwLzlpRjk3N1UydEIzTERSYUtKQmhi?=
 =?utf-8?B?QVVhMURROFFVWjZSZmNWRFkwOUtieldRM2RuaU5qdlBxdXl3dWhpN0pSRWIw?=
 =?utf-8?B?ZU9RWUtoSmFuN3pPc0c0MUxLVXpWVWo3WVA5OU5WY0JxTzRscm82RHI2UDM0?=
 =?utf-8?B?V2lHZW44dnpmUmp5L3hPaTBZb09qUWRhSGlOUEFyOU9JVE9DUmZtUVFyc0NU?=
 =?utf-8?B?bkZuaWpzbmJkaVVxQ3hBd0FjRXNRTlNqWVR3dlJsWEQ2blZ4c2Q2ZmZIZWp6?=
 =?utf-8?B?UjQ0bHJPellIcUtzT2podU1qd25LT0xkekhXMG5xZVdlZDl6WDdpUFhaSmV1?=
 =?utf-8?B?TEw1ZkswWkJsYVZYUVRJRS9iOHJ4Zy90NGFsZlJlUC9zQUI0Q2xhdGlNOVNY?=
 =?utf-8?B?U2o4SmtqUGF2ZHZhMkw3ZWNRRFJ3TWRBNWZkNHYrLzVENFdjbUlqQ0ZHNHRI?=
 =?utf-8?B?Z2l4bnhlUVlwWWExNFJHaGVZZWxNWmJUYXlFSnhuNSt1U1NOeE1ZWmZrYmpX?=
 =?utf-8?B?K25xVlNsTjhWVThXL3hDdUhCeWFhdFp3K1J6N2VrL1NhZmdJYVpIVzQvMWk5?=
 =?utf-8?B?OGlxOXZXZWR6NlRqODFsdXlKUGVab1dGMkhrS3VabDBnTnFsSVFsWEVaMmNt?=
 =?utf-8?B?Y0lHM2VFOW41bWpCWkY5Rmpvck9QRVYvYUoyQUlBTDJOMGUrU096cURHRnI3?=
 =?utf-8?B?Z25TU2tyWHg0aHh5am1lTVdmM1hnVGRDL0gzazRtbWU4c29jRFFHWnhLK0N4?=
 =?utf-8?B?d1pYUmhIUnBZT3lwVE43UE5pVUk1ZVRpWUVKWVB3UHp5d0VqYzFYVEFIK1Ax?=
 =?utf-8?B?V1gyTVcrWXZZemxxcm5BdXZWWDNiczRvZHpkdXRkREFXcGp0ZDJzQVRHanpa?=
 =?utf-8?B?c2t5ZEN3amw3ak5sdzVzd1FlM1U0aC9NUk8rRFB3eDZPWVdyN3ZxT2VyejMy?=
 =?utf-8?B?NnZzN3p3NjVEdGdqbnkrS2tmYkVzLzNJRndNYkJ4UFdjZDJQOERpeGROOENN?=
 =?utf-8?B?Vm9FNG1yazlMTFpFUGJucTJWVzM4ZzBOWUpqNU1ZRkZYZDZ6TjZxdVd0MXlk?=
 =?utf-8?B?eXh1aWtLUGplalVwcUNFWTN5ayszNGcyNHZueUlGOFozMmVRaWEzdGNFb2xW?=
 =?utf-8?B?NG1PeWJCclI4M3hhUTJ3cmJ2andtdUJyaTV0M3k3NTF1UitTYmYwOHZWRlVv?=
 =?utf-8?B?d29XdDFiOVcvTU5mTmVNdjNsMURta2hySU5HV1dTZlJLQi9tWkd2TVVDbWtW?=
 =?utf-8?B?R2tVaExIS1V2MmNRR2VnbDdDS28zZnFGVUlsUGxYVEpMc3cvd3RLT1VTNzR6?=
 =?utf-8?B?MlA0WCtUcVM2ZUl0RHdtM3hVMWtFc3BVa2kwQzZjOGlxWWVJQWtQUmpvdVYr?=
 =?utf-8?B?bXhRTDcvakNpYmNXMG9BblVkYkcwdEtySlpIWWNzTW1EbFpKNE03dUIzaVMx?=
 =?utf-8?Q?cqyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0wvdzdQQy8zMzVCTEpIcjlFVGlaQ3Arck5qYVY4d0NUZGhST0RNUjdybE50?=
 =?utf-8?B?UzE1UEczbm5CNkxxcmZtLzRkZHI5WDA1cG0vTVhmRWw4VlZOMm5zMWJtdG9O?=
 =?utf-8?B?UGFWUm5RMWlXRnloQ0ZLSUx3MmROSURuVzdPbjh5K1paTWdzQW4rUjRaeXJt?=
 =?utf-8?B?YmlHc1RnY2V2Zmt2Q2w1Wkx2VzI1Y2lvOUt1V3UxMnBFN0lHdnZCcmZEUGQ4?=
 =?utf-8?B?Zmt0QXpKMTluMzhSanpkWGc2Z1RvMEtyeVhnaTBWaUE5MjlVUmdUV1dRTGdD?=
 =?utf-8?B?NmFPWUNyVzZNaFIvdmVGUFExbVhNbmFXU0VOTG1TOHZOOVd3enRNdTJSTFVY?=
 =?utf-8?B?SXR2TE5ka29oek92UmwzWTUxenAvQm9sWE5sR2kxZVAxNnBncTNQcCtpdW04?=
 =?utf-8?B?OE5QVlVPM1R4dEdMcEs4cFNQM1pUTkpYbkNNZUlYU1lJbE5NQjZQdkoyd1Ns?=
 =?utf-8?B?bThuUi9ZcVFmWTFpbUZ6cmF6cE50MXRpSzZiSXhuMEs3WHFuRmc1cE51MkFB?=
 =?utf-8?B?Z291cnJ4Uytjb21uVWR2N2RuN1VPZlkySEQyRXhXMU81dkJ0UHorQmRrZE1Y?=
 =?utf-8?B?dkpsU2RPbmRXaUxjOGs0Yk9oZUR6VXVYcERGYmc0czB1VHFHTnY0U0h6Q2Za?=
 =?utf-8?B?OWtRSEFNRFlvRTJmbHo1S2FEUHNhcUU4bDRmTXo5cGN1b2Njd0ZYckltSFVj?=
 =?utf-8?B?R3BqV1ZSb3BzbnExT2NjeFJqUG80eDBhUnBEQUpwK3JKemFrQXRXRGtkOEVq?=
 =?utf-8?B?YzJLZk5jbERvSU9lejdZRFZXMGFXbGJuOXVTRFlZWFIxbWZmVTlUdlBoKzhW?=
 =?utf-8?B?aUYyY3V2UHBkWWM0QWxOQzdsMFdEYmwrRTZOb21TL3QrTzA3R1RaaGE0ZUVv?=
 =?utf-8?B?SlpocE1TZ1c4eDRMamdWZERtRDEveVRxdG50dTVYWGRRVTZ6UlpxWVNhckti?=
 =?utf-8?B?d3g5ZVMvVHhDZ01xdGMrSDBrMUE0RTlGRjdYY01JQ3VjbUFNb3FkNHR4S0ps?=
 =?utf-8?B?YW1mK1NjeFlWS2ZvSS9Zb1NGcGlOQzNkaFZVWENSUUdMWHh1eTBkOHNjNzZD?=
 =?utf-8?B?UklBZ2FucWEvNmN3MVlrS1h4UERSVmxvSjUxQ2hyQWg1Y28xcStmQlBlc3ps?=
 =?utf-8?B?MmUzZ0dOL1pFbElGNXcxVWsvdzZsNTdkR2xMVll5Njl2Vm5PMHg2RjdTMEhT?=
 =?utf-8?B?aHdQY3d0VVVYUmwyRDhRK2hiU05iUkYvSVQ5NmFCcGRSdVgya0hXV3FqemVE?=
 =?utf-8?B?ODdIOGNQdWkrSFp1dGhuY2VmSlFLVC9NWDJvd3V5MTd2NDYrVVBESHhxU3VF?=
 =?utf-8?B?cVc1V2dEWkJERVNvY051Mis3YkJaYkErZkQ5cWNtUTdUN3FWR2RJZEdkcXlE?=
 =?utf-8?B?UW9RR1c0cDdsT3B5TUtwYWpzSDh6bTBCNTdudHdwOUFVd1JtWkNtZitpZW5w?=
 =?utf-8?B?Tks4VWwwaHBQOUdKZS8raHVTb1ppenk2YVcyRkZjVXJIUThVbnZIRFI0SXYy?=
 =?utf-8?B?VUdWZlJvYXhid0JlMlRVU3JpQzNvc1gxcUQvZDlJYmF6SnFqeTVUQ1lndi9x?=
 =?utf-8?B?cjkzc0dTWUFNY092RGxON2t3N05TN2swU1AwSmZzNWlWOVhFSmRBMncvc3NH?=
 =?utf-8?B?ZTFlZ0xZaXB1ZFZ3STdKeWV4WGtPMzA0UWwxcEQwVE5MUjZ6aFNPY3pLTUpC?=
 =?utf-8?B?azAvY3R3S1JTWlBTMER0OTJXMVh4NUkyckgyNytuZktIYTVSSkFKUit6Y1R5?=
 =?utf-8?B?Uys3UFJPaFNxbFZRdEUrcjZERmNRam9McGZkUUQxOEU3TmZzeWF6YlNhRk5H?=
 =?utf-8?B?UWdMU1FMWG9RcEhJL1MwTHpLVkd2cTN3aXNCTzJxM1ZMOHZsZVZYejJoSUdF?=
 =?utf-8?B?aVl4MEMxbTNocjBmNFEvUUFndHFhQnhHYlpnZlJyZGdPcnM3L2E5MkNudnZZ?=
 =?utf-8?B?T3hoM2llUkVqQ2NQeTFTNHJibDQ1Sy91UXR1cDRDOGROV3RHM1VKQzdTU2w5?=
 =?utf-8?B?QXVLN2srMFNkcFhoQ2hxOTZQMXAxcUkrM2FkNUt1N2RoR25pOXhtdy9ZU3JR?=
 =?utf-8?B?MjNraW9MRm9KUDhBZGIvZmFWeWVRV0g0SThWUjNsMEFBNHVVcTRZbVZWRlc4?=
 =?utf-8?B?aUJieEJLckhwQlZuaDJJdGkzVkQ4TkZ2aFI4eDQwelN4aGZKUVJwREpuOExI?=
 =?utf-8?B?ejJnNENkVHhqS3lidEFVRm90QUJMKytjaXFGUzdkaVdYQ0lCeW5VZFNrQ0la?=
 =?utf-8?B?RUFhR3Y4N2h3d3IxUmwyWU5pZmNYeVpKYThqNEFJbCtjS2VEQXRqSjFXSXEr?=
 =?utf-8?Q?vbB5J4yxtyTiNbKGRS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59d71a-df6a-458d-7ccd-08de665a72ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 15:06:19.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slVUOXe1uoPFpa2ocrSgibseoM+scLNUbY0Eh3ANDyiq9XIPkqxeuOdbVTtk9d72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214794-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6424B1064ED
X-Rspamd-Action: no action

On 7 Feb 2026, at 10:03, Mikhail Gavrilov wrote:

> On Sat, Feb 7, 2026 at 7:32 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> Thanks. As a fix, I think we could combine the two patches above into one and remove
>> the VM_WARN_ON_ONCE() or just send the second one without VM_WARN_ON_ONCE().
>> I can send a separate patch later to fix all users that do not reset ->private
>> and include VM_WARN_ON_ONCE().
>>
>> WDYT?
>>
>
> Makes sense. Ship the quiet fix first for stable, then add
> VM_WARN_ON_ONCE separately to hunt down violators in mainline.
> I'd vote for option 2 (just free_pages_prepare without VM_WARN) - it's
> simpler and covers all cases.

Sounds good to me.

> Will your patch include a revert of the split_page() fix that's
> already in mm-unstable, or should that be handled separately?

Hi Andrew,

Can you drop this patch? Mikhail is going to send a different fix.

Thanks.

--
Best Regards,
Yan, Zi

