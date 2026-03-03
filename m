Return-Path: <stable+bounces-222837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMO4C2ylpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:10:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C01EBAA5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0CB23068380
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106138C2B0;
	Tue,  3 Mar 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="06lMb3gQ"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73583382F0A
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528944; cv=fail; b=Sy0QS/Ggy1qOuK+MbV219A5K3yxTkOzw2fzLTapG/pHIjo+pPrwnKje+C46/DyQ7UlUio4SoCe2/g1NDTA3o1VvnBIIzCDqbmS+i9bx90M5bAU17zeFeCEAJ7WnYpYgJxirMUOuOkQ5B5ZDh2ylzqS37/4kbwFbwOiETuElkwVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528944; c=relaxed/simple;
	bh=HofrrtrBxooxQoto40CZxCUAa5rIBkYIfeadAq3P0kk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iH2TkSTQVs1xkSFb7mZ7n2YESmLf72GmqrbGaMNligttXwzvTsqj+fjVwz7dTCi3VHXkhrHhpZSuW2MAKbOEfURS7ehDTroHS6m0EpiHcAoZn4SwOWcODzTovhcIaK22WhgEAhe+zvlXYc3amRhXN2GYQXLLcU5XX1IAAI++KC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=06lMb3gQ; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3yJq+ZD/dvUfwpwbHAE5q3zPyCVa+jcJrRfs2itH17A26uHmI0e2ojP0+3K3qC70v+r7gsOsfx0fJWaWX5Op0R/R/i34TvZW+zhJWTPpkmnbeXK3efUxrVR2n8lwsmyzqHzjrXuzjF63IFnNsYRcxOy4li+fzqACfrTxTiRebz5GxDL77svqGSEaWmrgi8Y88VeoTJKnMM1tpp5GUW1sWmrrNNM7Td6znSU9kNoMfpx72dK4Tyrb2ykAcLKgmB+KsolI3x8ovlQ/M15E7OSCJylVnKWpxlGbrulYbHt9PcrFvmDxIG3vs8B6GND7ZkJNqBXoCPjB/N83ARe4YIcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUEv4TUhuJllRuD+Fh6KHKOIQfl5iR2UMzsgG5Lgt58=;
 b=VZbLeS+E/HAi2+omlnVh7MvMMmsTWIRaosF9RnIIFSDWmolXDIkvyMHTjaThqz/Q7RoiIgR9zNBySXKSc5H51paWxkwo/rsMPhn5wVhmxo+mbmdacJnSH4TBHFah745O85TQAAPccoR1r2aUWcTvPtZ2uiMf+72hje1CBxl3Dz4wKUB6dZBYNrb895dL7EDwMInOo0oUHWDGwHcjn2+0oUXnWQxmZr6G0LdAnPvr8BuA/ktdI9usbBgnXii5pbTXgb9a67yle/ncBQfUlLYbXbhHtGJLBhKP0Rq5yUaVCArFZETxsqdk6BpzkBHBXVc8Q5JW++HHHK6oWLyR8ULirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUEv4TUhuJllRuD+Fh6KHKOIQfl5iR2UMzsgG5Lgt58=;
 b=06lMb3gQcPIN70efwlcvkmNAzIKSbsLXoNRMAt/db+/nqWlyDdwoOcumMHgc6eWCcA/1RJ5P/mcIh0D9uSrZhFi1F0agfZFN+n1OtwFytW2YqKnRM42smGrRn6fAr8t/bnJ6Q3GBc87MAxhGbobdJcTYr4ugG/ZZ0haNlM3kgbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 09:09:00 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 09:09:00 +0000
Message-ID: <91d17b5e-af1c-43e8-9e61-ebd608f67bea@amd.com>
Date: Tue, 3 Mar 2026 14:38:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 2/2] iommupt: Fix short gather if the unmap goes into a
 large mapping
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
References: <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0210.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::16) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c3f8cf-e598-4d0b-f758-08de790481ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	L+jBVPgJVrx9+SS4rPd5/cpvvyJOCDtuqK9vLPFtpxI/9Xh/mGJNialMJbUW61+OTh/DXtsrc+i+8AFvrTedCbn1B6LdlVezFKkEXAjaVsZgTzbaPDx0bvf9QSniBEsxjXO/ZqciTmV4fN93u7VemcJPkOt+TQcfUpOTbDeaQu572pZhr8jCUD8Y8Z8bWCGfh4zw1t6jNbKnnx7tTMv+rEZ3etQrbzrbxnrEZ7zwL8lnoD7CWdIr5oYsd6g05Ct0mi5er09iW6HdX/+zaCf1LdrzOTh2R14yvrbki+kjYkUnJXVjc/2Vd8Kou5lc5icZECyYB88bB3YvFX66vLF0TGiu+RXBQIUfz4oj/Mt7A6iBq2RRS2wxzGGgUtQhChHpqnEz8793817lxtAU5cZtDMvALpbHAgPxjyVXICxnv8nQOV1NMWw8/h9jXs+qpzwisoMyGJyNp1x9qc6AvG0sqOgxk7J9YpZvELa0+NDv2k3dv1PbZHeE4y57DugYOD+LcJtqiFcd+LrO1RQ6PBpZ5RCl/ViPgTdLVxrBZMdi1XaGx+oLkID1tykyYxk5A+nY/dogoYEQzNC+RAWwEHRpAn6uvahOTda2iDlNp6Kmk7DkLcQ0HdBSqKUX5DcnVcGB03eib/IZ04RNTyJU5QgegcFK2PCLp0gsdlb3iOdwRMijoxGWWnZiT/lWIAoeB6J4TnYcyGODNthlPtKHNLjbKvz+KC/JyFEPKodq2HdMZYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXhMOXV4Q2tPcnN1cDgzbysvTHhSVFlsam1oYVBGVnNhZ1Vid3F5YjA5dkNU?=
 =?utf-8?B?YnNRU3pnaVZBemJ1MW5BMVQyaktuQUJGaCtON2dYb2VVMVJ6ZktIcEJKTXdu?=
 =?utf-8?B?Slh1V0NlcXZBbzNNU21IQUtrUXJidlI1aWp6QSs2MFR0RGMzRW1NQzJjbzBh?=
 =?utf-8?B?MDBURmxMV3h2OWJqUjlCYmlKamUzczZRNHFFV0xWeGNXSFpzTGRpR3RSOGRM?=
 =?utf-8?B?cDcwMC9QNnI1SjhnamY4T01hTFRRQkxyVVpoeUVla3R0ckhTVmlycXBQYnZZ?=
 =?utf-8?B?ek9FQ21vaS8zbXhGV0RuZzNsb3B3NSs2SGRLQld3WmE1ekl3MEUxTTl4eEpl?=
 =?utf-8?B?bkc4MXJNUGtQbUVsVE1hWlJSdDVneUNaSkc5Q3VMNi80eFQ5SWFmUlNTL0dL?=
 =?utf-8?B?aklLV2UzZllaZmpSb002KzBCNmMvY1RlM0ROaEtKMS8yTG5YcHNzeDc1OUxH?=
 =?utf-8?B?YmhPWXJDUXd4aStHd2pCVTRZY1c3TXZCSUlaOXBUb2VTV1Z1TnI2Q1lITTFC?=
 =?utf-8?B?a0x2aHdORWlVanhUbkVTR2RNdlVpTjZTWWR1a1V4ay8yMTZGU3VxUXVBM1lp?=
 =?utf-8?B?OHlMMkdLSStrWUREVTIvaUFVT2JsbzhGaThiTzc0Z2VveDB6NDQ3M0FRUk5K?=
 =?utf-8?B?R2x0MmJmdWV2eW1HOURLVTZNaXIwblp3ZGFCODUrY3BPbGN4Q1NaTGUxOG9x?=
 =?utf-8?B?OWN6QzhaR0xSMzFPTG0xYVljbGh5SEN6MElac3VCME0wZDY3aWo4dktJdnhr?=
 =?utf-8?B?Slplb1NWWmUzYVM0WjdCdGo4QzVDaFE4SnhheUZ5K0JvSjhxeGNkWkhHaExj?=
 =?utf-8?B?N1BQRVMzd2lZVlBzNGdPaWZHNm1PVG8vVlFibUl5M0Q1VTgybUpZbTNPT3FJ?=
 =?utf-8?B?cWp6U0NjU1JXZEcwazhEa0poNWVoK3dWRHUvTVJZTFVvcTVwdnE2VWxGejE3?=
 =?utf-8?B?aU0vNEZUZGhVcDRicEtkQ3hpdi9LSUEzRU5CY1ZWY0todzlXTDYzSDFZcFQw?=
 =?utf-8?B?UGxaeEdWWm1Za0JHNll5SVlxb1k3bDhiNmhUWllBblFINThpTjVldWJLdWVB?=
 =?utf-8?B?TjNoc3RINEgxR1J4MFp6L0VVWmh4SVc5SWpYWnR6ZGVydjBwTStLbVZEQXlw?=
 =?utf-8?B?bTF1MUFhVUpIeXZpelZtWEtZbHFEbEEwM29jNThNY09Ubkt4eVpIdkZUb0h3?=
 =?utf-8?B?Si9mRGhrc3p2U21QTENJTS9qOGV5WDgrRUIzSG1aRHRLQnhCSlZUNEZ3NW5l?=
 =?utf-8?B?czh0YzJNSEVLZHlWYytjTmJ2SFdWQVlHeVVvTUlJNithM2pVTGRuamVESVho?=
 =?utf-8?B?N2FQdk9JMXdpNVpLbitxS3JXWjZwbVFoTDh5ZW40MTlmamxqQzk2cVFjRUc5?=
 =?utf-8?B?b1BuWmNkY1ZVbTMyTFkvUTEzK1l2eGdMcnI3amlDcGpLUnRVYlZxdjNMMUc1?=
 =?utf-8?B?MDkzTVFNWFFWT2pEVXJNY0ptbkIvUmJKK242ZURoYWlPYVd5bjMyTyszcXV5?=
 =?utf-8?B?clpNZWtUN1dGR0NEYjlVenBuOFpRMU9zSlRkUUFRVmZlcEw5OHBpTzdGZ1U5?=
 =?utf-8?B?RFkvVjFQVnpnSzFYckhkM1RkaDlxTkNwbTRUZ0l5UGZjcGFUK1JZeGpBRHNh?=
 =?utf-8?B?Nk9BYm8ySm9zdUlaNHkwUm9lTTEzbmpZNjJyMmZ5ZjUwVEFGeHNHZjhaN1hp?=
 =?utf-8?B?Z2ttRnhRQ21sQ3pGTThmZmxTNHo4b3V2VU5lUlhLVlppTm94ZEY4QS91Qk16?=
 =?utf-8?B?bHdhSEwrcmhJUTdwRW1ncSsxQ2Z1NExSWUJZOHdLRjdWcGpxUGdFSUpqTGxr?=
 =?utf-8?B?SHJ5LzJNZEtpZEppSXpkdlQvWVdZQStFcTRTMFFZRXcxNUxXakw1cVg1c3dR?=
 =?utf-8?B?eWJrOUJSN3hrUG9UaG1rSE1UQklmR3liODJ6Ty95WjVkMXJna1pwY1hiUHdL?=
 =?utf-8?B?SWpNZjJBZW4ydWZCdThnNHN6SUJkUjJyL1RETHJKallINncybXhJUWZtZDlo?=
 =?utf-8?B?RnRpTmt6dkJ5L1M3WWYyOWxySTVUVUhVQzcySUhFQjhCdm9SeEkyVUMvaVkw?=
 =?utf-8?B?SzVWZkEvTndGWUxWYjBXMUlNWDU5S3N3NWFIdzlzb2c5Y3c0VWNqdVhVTWg3?=
 =?utf-8?B?ZE45RlcvWU1zUjZaeVZmNjRLQmJSZnhnNGFoSGM2L2p0a2d3eXZqcEFHcGJW?=
 =?utf-8?B?U1haaXNwSTZ4OERMTyt1T0ZDOHBOTFNVMGtMSWNrNHlaODNBdnB4TSt6ZDJP?=
 =?utf-8?B?THZIVURGT2FoS3owNkh0NHRJNmxXQXAzT3A0TnZwVFk2YldCUXl3NXlNTXUx?=
 =?utf-8?B?UGxQV1FQT2JGNGJ0M0szQkVGTzIxeEZxT0RWTkxGaXhQNVpRVGJydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c3f8cf-e598-4d0b-f758-08de790481ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:09:00.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQcsqF3ouj+zvr+pdJ9oUQcxXvJCC9M93nuTJ9Ldu3DkKySlHt6+j2FmO6A5E6cwPNwIyj1wthRvhdDNQU/LFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
X-Rspamd-Queue-Id: 9C9C01EBAA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasant.hegde@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

On 3/3/2026 3:52 AM, Jason Gunthorpe wrote:
> unmap has the odd behavior that it can unmap more than requested if the
> ending point lands within the middle of a large or contiguous IOPTE.
> 
> In this case the gather should flush everything unmapped which can be
> larger than what was requested to be unmapped. The gather was only
> flushing the range requested to be unmapped, not extending to the extra
> range, resulting in a short invalidation if the caller hits this special
> condition.
> 
> This was found by the new invalidation/gather test I am adding in
> preparation for ARMv8. Claude deduced the root cause.
> 
> As far as I remember nothing relies on unmapping a large entry, so this is
> likely not a triggerable bug.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



