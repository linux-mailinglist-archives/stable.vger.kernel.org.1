Return-Path: <stable+bounces-212821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F2XHKvje2nBJAIAu9opvQ
	(envelope-from <stable+bounces-212821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:48:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A971B57F6
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F1EE3001A65
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C836B05D;
	Thu, 29 Jan 2026 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mt3S7gKY"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01536A036;
	Thu, 29 Jan 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726886; cv=fail; b=AAHaoFnPKN8pciAwEEFmpkaFOET1nKp0eMdjhSqAjR5rahLBqNY/W0GJdJJK0xd/A+fo7GP58boMtCQxWk/V0noLYLEWQJ7tVEzOd9qMdA7zmR6b+hNn/dMjIv5sw86tNoCZ+5YJhxZgEoP1wJHe4igmK36vubKvwt8PMF+0HFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726886; c=relaxed/simple;
	bh=1W9uQ9kvgGTZbGmIsb2QmOmg+WiHIYMnsqL7IyKqyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D31cYHN2gKi4ERA69o6kVdmFK2CtzJqbv4DBwozonYBKzprTywj7q+aoHrHpwQbBu8k+wAhNanoKn6tIBIsh5XHAdeucbzb+Iim9Sf700bQ7Yq+u3YAto2ND61TWn1/pdS6Vvx6lq9kWt1hDyeMIg8Y6onc/24Re2ZLspdrcUEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mt3S7gKY; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXXMF/ckf0Fz0g6Mvk1+aYlh0axNUyJKt0KUcrw9jKOuSycOel1sPryeLmlYp/JJ8JfkwOKT53mo20XU8T0bnKHEd52q0JOHoPlu50+EzVfP6rdu9vHfueVn2NqP5f5O9wkAuD+/PPbTuL1YjVpWUupC01Uo+jnuQJoC9M+L6sgVFUFHf6ZVVpwi+72HXdOcOxusaeGTkdIpSx+oAyvIuzALYDftDMb6UNqGeuhPrFHB2WnD+4xTwne/4FbhrSD5lOrorSowLzscC0jmi7qJFjUzdIzpT1dCZUwBs+wcqJqMi92LgM68Yk3K5c5h3a6ixIHp4TFzXbFI1DqSsLGRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag3URFhfq1u40oFDr797e6vyU1lcqj+IZ9xGQ2wMApY=;
 b=yj4Shu0yN7U4gN3vzshGPwJm2pjrAdJ0XceTgWddmrmfWDF8rrFBp6Wo428W3J62WrEZsJWjxgxj5T4lIxOVMcgUwpcCmXcDA71ZpbJFrSGOjDbmOZCaO60D4du4kmNvPiDz9M0XIReKCfHtdNc2O6dBn5zE2R75PYRsJzTu+6O2Y/EYEXdNF8HxLfNJTCqaSqbXkMPJCv35WU/m7teqSI1LasAkeUe3zG2LET+PHoIoWY5lkY9UlAvTsmoDuZMGhPBzhOtNLOziQWP1SKuStdknUez7Zd+5L5S6UJ92jdQ/v2gd9SfGYsV5+FOmUSXz0jWA6n8js2+hQ5mOa2hoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag3URFhfq1u40oFDr797e6vyU1lcqj+IZ9xGQ2wMApY=;
 b=Mt3S7gKYAmK3hmn2KdlA6Mr5+IhPKDGlLLcoXAIvSLeM+vRIO/F5motEIIDiRDEYZJ06+z93ku01PHE9bxX+mtWZKmVTgfks41lp9pXIgDzrrxfpJzW+/O8AgXZnun6AlzL09kkd+hPWbCXLPYIixt63yqrbet/dG9S3zBV7yPUX1xh4VH9kl1DEhNy5sn2HBbTDf9U/S7oRgx4ziYB7K8CZlYwW7VwyK7gTDEWlIRcTa1Hsl3/m06SF+J5f01luAas6iguEydC2oklXrUe1xK+TAd1qSddPmwuOCToxP56mpaCADXqwh/CMbLxKj9kjUfuvU1YUDHsNtLttD1kKdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 22:47:58 +0000
Received: from CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f]) by CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 22:47:58 +0000
Date: Thu, 29 Jan 2026 17:47:57 -0500
From: Penghe Geng <pgeng@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
Message-ID: <lxp6wsa6mgx3km54hpdqaeoe6gery54ad6ulc4k2futkmiod77@i5sutp3dpdjd>
References: <20260115214648.168365-1-pgeng@nvidia.com>
 <39569ebb-d9a2-4f81-9abe-aec98f3c9f67@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39569ebb-d9a2-4f81-9abe-aec98f3c9f67@intel.com>
X-ClientProxiedBy: BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18)
 To CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9630:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1055fc38-65ce-4324-3dba-08de5f887330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnRSak9KTEdZaVFnQW8vWnpMMnZQYWxVUTFxc3FSMGpNV3ErZURmelBTZ0hZ?=
 =?utf-8?B?ZXdxZFdCVVBwcXdidDh5dThZeFhQclV5ZjRObWFOQlJEaDBJRytMd3hZZzFZ?=
 =?utf-8?B?bDNqYjF3N0VPcVRHc0k1WnNQT0djdHRvT2hkWkRzNVQ3cnVlSUhoUW1tdFdU?=
 =?utf-8?B?UC9xNGFwUTZUdzRFbVd5cFRabTVDb1NWL2VJWmVKRDdQL3FyamRLSWNheHpZ?=
 =?utf-8?B?VnpCN24yeXFRa3kzT0R6Q2lzRUdqa3NHbkFSR2RsV3h1bm15THE2TmtvZXJy?=
 =?utf-8?B?SmlJUVo1a3RnenEvVlRSRVR3SXdWQkpZTDRhenhBZGhFKzQ3L2lzcTAvWVpG?=
 =?utf-8?B?MkVoSlhwZDA0ZnlLL2E5R3pRM3FDcmowUDVBUXl5SnBVbG0rdWJqT0tTUXQ0?=
 =?utf-8?B?TmFDMXFGS3ZhVEdLSG5DT2k2a1gzM0ljS1NySktlaTVpSGdGL2VWb3pjOEJs?=
 =?utf-8?B?Y3JjRXgrSEFqajJDcEZZTXFHbGhUMlFtSnAvbCttNXd5YTBjSGt3TUdvTGNa?=
 =?utf-8?B?WmY4bG9WNGxKYnkvYzY4RkYzR2ZlTU9vekM3S0s1aWJRdktQaWZpZ2g1KzZM?=
 =?utf-8?B?Zi9PVTZkZkQ2aDk0SWYrRmRvalBHaHYyNE1pYW11a2ZqNHNIT2JNL3YxQUJL?=
 =?utf-8?B?MDVzcTU2eUFZTjJyWWNKUzNsZWNIQjU2dk4reTdKb09GUGFrdGcvYjBsWjd5?=
 =?utf-8?B?T1E3ckZuTHhuaGVQVjFxRk1odXp1bUZHMHMwOC9wN2VXRExUeG9ESW1jNUE0?=
 =?utf-8?B?WkdrZE9JVVhMS1pncC9NOGdtcWxsK0ZEcjVKdXV4anMrZS8zenhYMjNKT3kz?=
 =?utf-8?B?RTRFNzdoc0xiVUV1V2RUSERnZGxkMllzOTZJZFNRR0dkY1dPMmVXQ0VtcFdr?=
 =?utf-8?B?a3JPeGhWakZ6NEhvbmNPWWdBTGxvZXEzQXBtcm5TTnRUL250MElreWFoN2dU?=
 =?utf-8?B?WDBGOHQyMlVyeEczTEd3cS8wNWFtQkxoRmtSTDF4K1VjdEpCbVE2alZLa1Zy?=
 =?utf-8?B?NFcxK0NWOTMzNWhQanJWQXhtay8rTHdUTWVNQ1BwNm5BbW8rNVhEM28rVCtu?=
 =?utf-8?B?T00vODFvRHdCMm5wTHU0YVF3ckNpdDhLT1o0MS8yN1U4L24yUElXdFJvWFVp?=
 =?utf-8?B?YVRUdzUvYlNXazJ5TWpqcGtsSENhR3JNSXA1MStTUWU1M0pCeEVyazl5WUlK?=
 =?utf-8?B?TG1MeENXelBSbm5TeVRLR2tUWGV2VlM2ZkdhRW5HcHpSTmw0aVJURFlSdXg1?=
 =?utf-8?B?ZG5kYkppdkUzV3ZGTldLMlIyWWVkdllHZjl3UnhWVlM4bHRiVm9vZlVmNHF4?=
 =?utf-8?B?M1M1YmxpWVFMZm9LenNJSlFDOTVpYWRnWHBRWXFtOVBhYnJqOEttZWdlMGQy?=
 =?utf-8?B?bHpTS1BWTGd5RDc1YjJaRjF2UVBmQnFpZGsxbUtkWDhZYzN4RkdWVVZ6OHhK?=
 =?utf-8?B?b21nY0VGL3BpUGQyY2NhYXdEU0xtOXJqTDhQWDRXQ0M4RUtZd0pGTzBMS0Y5?=
 =?utf-8?B?aTFvNEZycnNqdkhxY2NObWpYU29DaWJwZVRXT1ZNNitHSDVhT2loT2VMc2J0?=
 =?utf-8?B?SENvN3VUYi94TUZDbjJHWDE1b285Q3kycXR4a3YvVmp0alFwS1ZXK0ZxbmRS?=
 =?utf-8?B?dk1CZDNTY1ZhTXJseXFWdnlVUWNYeGp6ci9kV2R0M0Iwb0t6QlJURlFIUEVp?=
 =?utf-8?B?WEpHUFZZdWI0aDlhWUpFWU4zd2pjTEtoNVZObk5VOXBOUUNVV3FabFRnMVVY?=
 =?utf-8?B?ZU9nRDNVWjRWY1JDRENZSHZhcU1POVZRSnJ6QVpUaW5KSUwrc3pnSWJZYzZl?=
 =?utf-8?B?RGZEbmw1UUNQQkRxRGtsWlEwdnNYQTF4TXl2VmtWYnc2SU1hYk4yaDhNQW8w?=
 =?utf-8?B?NWJldFBmSUg1Zm5ETkVuSHpKRjlJMEh4L09hMFpBWU1pdmxFLzZ2Q05ZR1gy?=
 =?utf-8?B?WE54bUZtNnJDUENPMUxzNHJrOE04bXBYRkhKaVRkb2RjQ01iQ1p6bkpZMSty?=
 =?utf-8?B?NGYrL3hsRWVCdnRYSHJEM2lyOHJhMmt1REhCbkZpRVlrbjNnWkdHbEk4RHVG?=
 =?utf-8?B?Q3JyY2tEU2NuYU1GNjZGV25sRDcvY09vRjRnZy96Rmx0aVBucUJoQWdxMU54?=
 =?utf-8?Q?3W2I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZStUbjk5NWRLU05ia0p0ZHB2OVlkM0RybG1SV0xIMkdyRTlYRVdPNldhWmc1?=
 =?utf-8?B?V2l6QmFmZWU4VGJkTzlwanpFUWtibnlVNlU5eCtwUEtKVzFSU2FEVVlObkdl?=
 =?utf-8?B?QUFpRzRvYit4K05FRFV5S3RVdXNpUXpXaERPZmVjbFBkUHRhR2poM2cxK3Bm?=
 =?utf-8?B?RlRGUzM3bXRoWitTQzUvcFJGQkxDanpZTHB3MEZHeUoxMHRLUjNWcDRKVVlS?=
 =?utf-8?B?SVA5WWVSbGlzZTNVOHpiN0cwdjBMZ0Zid0tSRWhCcnByY21sSDdpUjRuSGgx?=
 =?utf-8?B?Tm5YWEZtUmxMRFNnUVVEQ2NPSVZNTUJUNm9aTFphcDVVSTVZZnBMVTdlenJG?=
 =?utf-8?B?NmxxcU1yaUhUR1pqVXlyTStpcTJTNmJPMDM4NXBJL0dUR0taUngyNU56Qi9D?=
 =?utf-8?B?ZGwvbmZXREF4cDV4MkN1SjRrcktmS1lmL0xqbVMwaFBBdTZud0pMc05BbFVQ?=
 =?utf-8?B?bEliL1I1N01SSjhNWXFIbTBpNVNHbmFSZEdkcG1hdzRqVlN2dFVnVHc0a1hr?=
 =?utf-8?B?MjhKQ0xBK21EeUpraVlUQ3lxNHE2TDhXczNIMjRwaENRM2Z0cTV2eWZHTjE2?=
 =?utf-8?B?MmE4OW5HdnVFYjgwdWlUQzB6MHJweXcvM1c4OEJsd2ZRNEZmVERZWUdWT1Fl?=
 =?utf-8?B?NTg4bHBhc1pzK3p1MkQ0QllUNjY3cVB5Wk43QXJhcjkrb1R6YlNDTFF0NWlW?=
 =?utf-8?B?ZkNJaXJvY2h0Wnp1SUFaREVNNjdZeks4UWZ4a092dUpZY01DeHhHYXRjOVdp?=
 =?utf-8?B?NU81UEU1dytWU3dRMXk3M3hPN3FjMDhVd0Y5SkpKekdRckdIdDQrUmVZODVx?=
 =?utf-8?B?cnkwN21NN05yZ3NzTEZNcU5Kd0hhL2ZWZjNkL3luQk9DeGg3RXJTK2pNd2Nt?=
 =?utf-8?B?c0dRWmtFMklBQkNKSnZWTW45a1VyY01QaGhIdTR3R3BYd3htT1Q2T2pWRzBo?=
 =?utf-8?B?RGhlK1ByRk1kUGxEcmRCMFlFd1QzUXlZWnIwUktKVmlwcXlrZWJvRWViNWFn?=
 =?utf-8?B?Y2NSalMvUC9Rd1cxeXJ6aVBzR0ZreVNyVWFnd3RCUytMWmhOSkt1dnNjMC80?=
 =?utf-8?B?WXB2WSt2VEVTb3J2M3pIT2t4MExsa0d0Q3Zlcmx2QnRJZDZkM3RIZlhLaHFh?=
 =?utf-8?B?V2dKNHdJQkI3VmRYTG5QaTN3dU1OMmZLOTlMZTlyNWdlSCtQd0R3TXlMZ3JC?=
 =?utf-8?B?UmpDVlZSZmRFN1hGTFAxbys1YU5MSjhybXFWQXRvbUxzUTNFczh3WkRrZThY?=
 =?utf-8?B?Ny9uMEM3dEh1ZkVDNHlkNzBTa2oySy91a1hSQWFxTEZvbEprSWRheVhBNE1W?=
 =?utf-8?B?N3Uzb1VxdDhMN0xab0dkNjJBdVhYNC9HejhrWDd4N0VKc1ZUNHlqYVJxNThy?=
 =?utf-8?B?N1VHODFCakdJaXRZWUpnRHFVc1B6Ymdra0pFbmZaTmJiaFFGNE01UUVaOFBX?=
 =?utf-8?B?ZStyaUdmTGwzTFduaHlod2FGeCtFbml2NEtJWC8xVTdFdDRvR3N2M3Joc2pU?=
 =?utf-8?B?allhY283SlJNeXFuWnRYN2NKQlc1M0U3eXBOYlM5Y3ZjM0NIdS81TnlsOXJB?=
 =?utf-8?B?Q1lIVjRPUmxoQXFHQW5JcWhidkNPcW9yNHBmTlJYTzFmb29oaExSZU9BMVBn?=
 =?utf-8?B?T0hGNmJDcW13Tlh4cDM0UUs2cnRWZVFuN0FNb3pCZFBSZjNUKzhuTGdMVVVu?=
 =?utf-8?B?OStsNTlhWnN3bHBZUThtckhPWGNzWElERVZHUVhyWkNobVJzc1V1TmZZa3ln?=
 =?utf-8?B?b2JXU0FFMnlZaHMxRWNKbE1zanVYR1dqTlhESlZ2TXdRU2pFVGJTYTU3TlYw?=
 =?utf-8?B?dCt3a0gxVzM3aG0yMFA0RE9OdzE3SzZwd2dCMlc1T1hId0F3bW5aU3dIN3Fu?=
 =?utf-8?B?b0Q1SzNoOVpCTXgrb1pNMDRieTR0dEdmNkREdEllczVOc0JKZEV4NHBMdmM4?=
 =?utf-8?B?RFNVZ1k1SUhPTitVUU5XODRvbjBvWGdiSkdWUnE0N0ZBZnJvc25FWC8wdTRO?=
 =?utf-8?B?QmFiNjhIcnpSWjNGR3pRS2kzWU14TzB3MWhnVlBVUHVxYUVtUTRJdExLd2dJ?=
 =?utf-8?B?VW9KQVVNVzVTNW4zNGswbmltVzFlTnRwRURTaVFHY0xtclcrU0tiZFdoYWlh?=
 =?utf-8?B?MzFCcTVxUXJsb28zcDhHNkpaWW1IaHhUVkJ3dXlHdGlnc0RTRUJyTGprdGN4?=
 =?utf-8?B?NTkrdVE5RnlZN1BxeGMzNnBicGl0VTNxNTQ5cll2T0d1WGgvS1NwcHMwOW4r?=
 =?utf-8?B?NXpHOUZDUHFkZzBNRHh2Z0IwWW1VNFBRK3N0cERTcTdFNjBraFlhSUw3YWI1?=
 =?utf-8?B?OHZValF1aThsckFtTTVUdGRaOVFLYi95djdxMm4rR051bUFJdkZwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1055fc38-65ce-4324-3dba-08de5f887330
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 22:47:58.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi5oJAw5rgbRodczFzD0vnfXzHRb/dNx/haSMSaEc5j3SWA7zteX/1s8DTKlplSUl/dkBAhMtdS0Ogyihzcycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212821-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pgeng@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9A971B57F6
X-Rspamd-Action: no action


Hi Adrian,

Thanks for the feedback. Below are the details you asked for.

Kernel versions:
- Seen on 5.15.120.bsk.business.6‑arm64 (custom tree).
- Also observed on 6.1.0‑11‑arm64 (Debian 6.1.38‑4).

Media: eMMC
Controllers:
- BlueField‑2: Synopsys DesignWare MMC (drivers/mmc/host/dw_mmc-bluefield.c)
- BlueField‑3: Synopsys DWC MSHC (drivers/mmc/host/sdhci-of-dwcmshc.c in‑tree) and also with OOT sdhci-of-dwcmshc-bf3

CQE:
- Not enabled at runtime. CONFIG_MMC_CQHCI=m.
- lsmod | grep cq is empty by default.
- modprobe cqhci loads with 0 users and no CQE/CQHCI enable
  messages in dmesg. So CQE is not in use by the active host.

I/O errors:
- None observed around the WARN.

Repro:
- Intermittent, mostly during boot under stress.
- Roughly 0.1–1% depending on distro/platform.

Example stack (BF3, in-tree sdhci-of-dwcmshc):
------------[ cut here ]------------
mmcblk0boot1: mmc0:0001 Y29128 31.9 MiB
WARNING: CPU: 8 PID: 240 at drivers/mmc/core/core.c:349 mmc_start_request+0xb4/0xc4
Modules linked in: crc16(E) mbcache(E) jbd2(E) nvme_tcp(OE) nvme_rdma(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_core(OE) nvme_fabrics(OE) configfs(E) nls_ascii(E) nls_cp437(E) nls_cp850(E) msdos(E) efivarfs(E) nvme(OE) nvme_core(OE) virtio_net(E) net_failover(E) virtio_console(E) failover(E) mlxbf_tmfifo(OE) mlx_compat(OE) virtio(E) t10_pi(E) sbsa_gwdt(E) mlxbf_bootctl(OE) sdhci_of_dwcmshc(OE) virtio_ring(E)
mmcblk0rpmb: mmc0:0001 Y29128 4.00 MiB, chardev (245:0)
CPU: 8 PID: 240 Comm: kworker/8:1H Tainted: G           OE     5.15.120.bsk.business.6-arm64 #5.15.120.bsk.business.6
Hardware name: https://www.mellanox.com BlueField-3 DPU/BlueField-3 DPU, BIOS 4.9.2.13576 Mar 18 2025
Workqueue: kblockd blk_mq_run_work_fn
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mmc_start_request+0xb4/0xc4
lr : mmc_start_request+0x68/0xc4
sp : ffff80000932ba90
x29: ffff80000932ba90 x28: ffff000081b3b308 x27: 0000000000000000
x26: 0000000000000001 x25: 0000000000000000 x24: ffff000082aec000
x23: ffff000082485800 x22: ffff000082aec000 x21: 0000000000000000
x20: ffff000081b3b3d8 x19: ffff000082aec000 x18: 0000000000000000
x17: 0000000000000000 x16: ffffbab212913c40 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000038 x12: ffff00008f06b000
x11: 7f7f7f7f7f7f7f7f x10: ffffbab2144acbc8 x9 : ffffbab2130ad368
x8 : ffff000081b3b548 x7 : ffff000082aec000 x6 : 0000000000000000
x5 : ffff000081b3b458 x4 : ffff00008a4b5e80 x3 : ffff0000824859b0
x2 : 0000000000000000 x1 : ffff000081b3b4c8 x0 : 0000000000000020
Call trace:
 mmc_start_request+0xb4/0xc4
 mmc_blk_mq_issue_rq+0x310/0x8fc
 mmc_mq_queue_rq+0x154/0x3e0
 blk_mq_dispatch_rq_list+0x13c/0xa44
 blk_mq_do_dispatch_sched+0x2cc/0x33c
 __blk_mq_sched_dispatch_requests+0x154/0x1b0
 blk_mq_sched_dispatch_requests+0x40/0x80
 __blk_mq_run_hw_queue+0x58/0xa0
 blk_mq_run_work_fn+0x28/0x34
 process_one_work+0x1f8/0x4c0
 worker_thread+0x180/0x580
 kthread+0x128/0x13c
 kthread_return_to_user+0x0/0x10
---[ end trace fc3df73f08f7c8ee ]---

I agree the bitfield usage adds complexity. I can work on a follow-up
to convert the retune-related flags to bools if that’s the preferred
direction.

Thanks,
Penghe

On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 15/01/2026 23:46, Penghe Geng wrote:
> > The host->claimed flag shares a bitfield storage word with several
> > retune flags (retune_now, retune_paused, can_retune, doing_retune,
> > doing_init_tune). Updating those flags without host->lock can RMW the
> > shared word and clear claimed, triggering spurious
> > WARN_ON(!host->claimed).
> 
> Thanks for finding this!
> 
> The design is that those members are protected by the host->claimed
> lock itself.
> 
> mmc operations are primarily single-threaded, protected by the
> host->claimed lock, although the block driver does allow multiple
> transfers at the same time in some cases.
> 
> There are also other contexts like interrupt handlers.
> 
> Can you provide some information about when WARN_ON(!host->claimed)
> is being hit?  Including the stack dump?
> What kernel version?
> Is it eMMC, SDIO or SD card?
> Is CQE being used?
> Are there any I/O errors happening also?
> What controller driver is it?
> 
> In any case, the use of bit fields seems to add complexity unnecessarily,
> so we should consider converting some or all of them to bool.
> 
> >
> > Serialize all retune bitfield updates with host->lock. Provide lockless
> > __mmc_retune_* helpers so callers that already hold host->lock can
> > avoid deadlocks while public wrappers serialize updates. Also protect
> > doing_init_tune and the CQE retune_now assignment with host->lock.
> >
> > Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> > ---
> >  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
> >  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
> >  drivers/mmc/core/mmc.c   |  6 ++++
> >  drivers/mmc/core/queue.c |  3 ++
> >  include/linux/mmc/host.h |  4 +++
> >  5 files changed, 94 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 88c95dbfd9cf..0b6b4a31f629 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
> >   */
> >  void mmc_retune_enable(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->can_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >       if (host->retune_period)
> >               mod_timer(&host->retune_timer,
> >                         jiffies + host->retune_period * HZ);
> > @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
> >   */
> >  void mmc_retune_pause(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (!host->retune_paused) {
> >               host->retune_paused = 1;
> > -             mmc_retune_hold(host);
> > +             __mmc_retune_hold(host);
> >       }
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >  EXPORT_SYMBOL(mmc_retune_pause);
> >
> >  void mmc_retune_unpause(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +     bool released;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->retune_paused) {
> >               host->retune_paused = 0;
> > -             mmc_retune_release(host);
> > +             released = __mmc_retune_release(host);
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +             if (!released)
> > +                     WARN_ON(1);
> > +     } else {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >       }
> >  }
> >  EXPORT_SYMBOL(mmc_retune_unpause);
> > @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
> >   */
> >  void mmc_retune_disable(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> >       mmc_retune_unpause(host);
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->can_retune = 0;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >       timer_delete_sync(&host->retune_timer);
> >       mmc_retune_clear(host);
> >  }
> > @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
> >
> >  void mmc_retune_hold(struct mmc_host *host)
> >  {
> > -     if (!host->hold_retune)
> > -             host->retune_now = 1;
> > -     host->hold_retune += 1;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     __mmc_retune_hold(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  void mmc_retune_release(struct mmc_host *host)
> >  {
> > -     if (host->hold_retune)
> > -             host->hold_retune -= 1;
> > -     else
> > +     unsigned long flags;
> > +     bool released;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     released = __mmc_retune_release(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +     if (!released)
> >               WARN_ON(1);
> >  }
> >  EXPORT_SYMBOL(mmc_retune_release);
> > @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
> >  {
> >       bool return_to_hs400 = false;
> >       int err;
> > +     unsigned long flags;
> >
> > -     if (host->retune_now)
> > -             host->retune_now = 0;
> > -     else
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     if (!host->retune_now) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >               return 0;
> > +     }
> > +     host->retune_now = 0;
> >
> > -     if (!host->need_retune || host->doing_retune || !host->card)
> > +     if (!host->need_retune || host->doing_retune || !host->card) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >               return 0;
> > +     }
> >
> >       host->need_retune = 0;
> > -
> >       host->doing_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >
> >       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> >               err = mmc_hs400_to_hs200(host->card);
> > @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
> >       if (return_to_hs400)
> >               err = mmc_hs200_to_hs400(host->card);
> >  out:
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->doing_retune = 0;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >
> >       return err;
> >  }
> > diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> > index 5941d68ff989..07e4f427fe15 100644
> > --- a/drivers/mmc/core/host.h
> > +++ b/drivers/mmc/core/host.h
> > @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
> >  void mmc_retune_pause(struct mmc_host *host);
> >  void mmc_retune_unpause(struct mmc_host *host);
> >
> > -static inline void mmc_retune_clear(struct mmc_host *host)
> > +static inline void __mmc_retune_clear(struct mmc_host *host)
> >  {
> >       host->retune_now = 0;
> >       host->need_retune = 0;
> >  }
> >
> > +static inline void mmc_retune_clear(struct mmc_host *host)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     __mmc_retune_clear(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +
> > +static inline void __mmc_retune_hold(struct mmc_host *host)
> > +{
> > +     if (!host->hold_retune)
> > +             host->retune_now = 1;
> > +     host->hold_retune += 1;
> > +}
> > +
> > +static inline bool __mmc_retune_release(struct mmc_host *host)
> > +{
> > +     if (host->hold_retune) {
> > +             host->hold_retune -= 1;
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >  static inline void mmc_retune_hold_now(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->retune_now = 0;
> >       host->hold_retune += 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline void mmc_retune_recheck(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->hold_retune <= 1)
> >               host->retune_now = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 7c86efb1044a..114febd15f08 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >               goto free_card;
> >
> >       if (mmc_card_hs200(card)) {
> > +             unsigned long flags;
> > +
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->doing_init_tune = 1;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >
> >               err = mmc_hs200_tuning(card);
> >               if (!err)
> >                       err = mmc_select_hs400(card);
> >
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->doing_init_tune = 0;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >
> >               if (err)
> >                       goto free_card;
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index 284856c8f655..5e38759c87f5 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       enum mmc_issue_type issue_type;
> >       enum mmc_issued issued;
> >       bool get_card, cqe_retune_ok;
> > +     unsigned long flags;
> >       blk_status_t ret;
> >
> >       if (mmc_card_removed(mq->card)) {
> > @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >               mmc_get_card(card, &mq->ctx);
> >
> >       if (host->cqe_enabled) {
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->retune_now = host->need_retune && cqe_retune_ok &&
> >                                  !host->hold_retune;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >       }
> >
> >       blk_mq_start_request(req);
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index e0e2c265e5d1..e7bddbafd1da 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
> >
> >  static inline void mmc_retune_needed(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->can_retune)
> >               host->need_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline bool mmc_can_retune(struct mmc_host *host)
> 

On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 15/01/2026 23:46, Penghe Geng wrote:
> > The host->claimed flag shares a bitfield storage word with several
> > retune flags (retune_now, retune_paused, can_retune, doing_retune,
> > doing_init_tune). Updating those flags without host->lock can RMW the
> > shared word and clear claimed, triggering spurious
> > WARN_ON(!host->claimed).
> 
> Thanks for finding this!
> 
> The design is that those members are protected by the host->claimed
> lock itself.
> 
> mmc operations are primarily single-threaded, protected by the
> host->claimed lock, although the block driver does allow multiple
> transfers at the same time in some cases.
> 
> There are also other contexts like interrupt handlers.
> 
> Can you provide some information about when WARN_ON(!host->claimed)
> is being hit?  Including the stack dump?
> What kernel version?
> Is it eMMC, SDIO or SD card?
> Is CQE being used?
> Are there any I/O errors happening also?
> What controller driver is it?
> 
> In any case, the use of bit fields seems to add complexity unnecessarily,
> so we should consider converting some or all of them to bool.
> 
> >
> > Serialize all retune bitfield updates with host->lock. Provide lockless
> > __mmc_retune_* helpers so callers that already hold host->lock can
> > avoid deadlocks while public wrappers serialize updates. Also protect
> > doing_init_tune and the CQE retune_now assignment with host->lock.
> >
> > Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> > ---
> >  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
> >  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
> >  drivers/mmc/core/mmc.c   |  6 ++++
> >  drivers/mmc/core/queue.c |  3 ++
> >  include/linux/mmc/host.h |  4 +++
> >  5 files changed, 94 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 88c95dbfd9cf..0b6b4a31f629 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
> >   */
> >  void mmc_retune_enable(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->can_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >       if (host->retune_period)
> >               mod_timer(&host->retune_timer,
> >                         jiffies + host->retune_period * HZ);
> > @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
> >   */
> >  void mmc_retune_pause(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (!host->retune_paused) {
> >               host->retune_paused = 1;
> > -             mmc_retune_hold(host);
> > +             __mmc_retune_hold(host);
> >       }
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >  EXPORT_SYMBOL(mmc_retune_pause);
> >
> >  void mmc_retune_unpause(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +     bool released;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->retune_paused) {
> >               host->retune_paused = 0;
> > -             mmc_retune_release(host);
> > +             released = __mmc_retune_release(host);
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +             if (!released)
> > +                     WARN_ON(1);
> > +     } else {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >       }
> >  }
> >  EXPORT_SYMBOL(mmc_retune_unpause);
> > @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
> >   */
> >  void mmc_retune_disable(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> >       mmc_retune_unpause(host);
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->can_retune = 0;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >       timer_delete_sync(&host->retune_timer);
> >       mmc_retune_clear(host);
> >  }
> > @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
> >
> >  void mmc_retune_hold(struct mmc_host *host)
> >  {
> > -     if (!host->hold_retune)
> > -             host->retune_now = 1;
> > -     host->hold_retune += 1;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     __mmc_retune_hold(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  void mmc_retune_release(struct mmc_host *host)
> >  {
> > -     if (host->hold_retune)
> > -             host->hold_retune -= 1;
> > -     else
> > +     unsigned long flags;
> > +     bool released;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     released = __mmc_retune_release(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +     if (!released)
> >               WARN_ON(1);
> >  }
> >  EXPORT_SYMBOL(mmc_retune_release);
> > @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
> >  {
> >       bool return_to_hs400 = false;
> >       int err;
> > +     unsigned long flags;
> >
> > -     if (host->retune_now)
> > -             host->retune_now = 0;
> > -     else
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     if (!host->retune_now) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >               return 0;
> > +     }
> > +     host->retune_now = 0;
> >
> > -     if (!host->need_retune || host->doing_retune || !host->card)
> > +     if (!host->need_retune || host->doing_retune || !host->card) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >               return 0;
> > +     }
> >
> >       host->need_retune = 0;
> > -
> >       host->doing_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >
> >       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> >               err = mmc_hs400_to_hs200(host->card);
> > @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
> >       if (return_to_hs400)
> >               err = mmc_hs200_to_hs400(host->card);
> >  out:
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->doing_retune = 0;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >
> >       return err;
> >  }
> > diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> > index 5941d68ff989..07e4f427fe15 100644
> > --- a/drivers/mmc/core/host.h
> > +++ b/drivers/mmc/core/host.h
> > @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
> >  void mmc_retune_pause(struct mmc_host *host);
> >  void mmc_retune_unpause(struct mmc_host *host);
> >
> > -static inline void mmc_retune_clear(struct mmc_host *host)
> > +static inline void __mmc_retune_clear(struct mmc_host *host)
> >  {
> >       host->retune_now = 0;
> >       host->need_retune = 0;
> >  }
> >
> > +static inline void mmc_retune_clear(struct mmc_host *host)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +     __mmc_retune_clear(host);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +
> > +static inline void __mmc_retune_hold(struct mmc_host *host)
> > +{
> > +     if (!host->hold_retune)
> > +             host->retune_now = 1;
> > +     host->hold_retune += 1;
> > +}
> > +
> > +static inline bool __mmc_retune_release(struct mmc_host *host)
> > +{
> > +     if (host->hold_retune) {
> > +             host->hold_retune -= 1;
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >  static inline void mmc_retune_hold_now(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       host->retune_now = 0;
> >       host->hold_retune += 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline void mmc_retune_recheck(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->hold_retune <= 1)
> >               host->retune_now = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 7c86efb1044a..114febd15f08 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >               goto free_card;
> >
> >       if (mmc_card_hs200(card)) {
> > +             unsigned long flags;
> > +
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->doing_init_tune = 1;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >
> >               err = mmc_hs200_tuning(card);
> >               if (!err)
> >                       err = mmc_select_hs400(card);
> >
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->doing_init_tune = 0;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >
> >               if (err)
> >                       goto free_card;
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index 284856c8f655..5e38759c87f5 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >       enum mmc_issue_type issue_type;
> >       enum mmc_issued issued;
> >       bool get_card, cqe_retune_ok;
> > +     unsigned long flags;
> >       blk_status_t ret;
> >
> >       if (mmc_card_removed(mq->card)) {
> > @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >               mmc_get_card(card, &mq->ctx);
> >
> >       if (host->cqe_enabled) {
> > +             spin_lock_irqsave(&host->lock, flags);
> >               host->retune_now = host->need_retune && cqe_retune_ok &&
> >                                  !host->hold_retune;
> > +             spin_unlock_irqrestore(&host->lock, flags);
> >       }
> >
> >       blk_mq_start_request(req);
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index e0e2c265e5d1..e7bddbafd1da 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
> >
> >  static inline void mmc_retune_needed(struct mmc_host *host)
> >  {
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> >       if (host->can_retune)
> >               host->need_retune = 1;
> > +     spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> >  static inline bool mmc_can_retune(struct mmc_host *host)
> 

