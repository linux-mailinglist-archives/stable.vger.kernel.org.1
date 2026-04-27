Return-Path: <stable+bounces-241241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IErFAp0O72kq4wAAu9opvQ
	(envelope-from <stable+bounces-241241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:22:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879946E499
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24153300252B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71EF370D7B;
	Mon, 27 Apr 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7MdOjhx"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C9364949
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274519; cv=fail; b=U7kOxMwlQGZ3aNTKtoCMxaYsEZ4MYbxl70oRZmLRTN4n8ORWkkScqbj51Tt1MhD7pvzYFNO+T/IE5acetmhLqVk9ZHa98dVce7GnZH+9lxZg+D670O0gO9/QvouI7AJrEQeVga0tVQjy4u7U4QlU+sMQAKh5qtnVuvCzuHpXAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274519; c=relaxed/simple;
	bh=nGOQf2OrGNJ9FgESXzbQzVyNakSiG/3VKWVyF0nJouI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A80WE6ZDxXoYc0YJwuYH590+9nag19tA/68dR43GG+2zgX1qbZl7t/8rAHI03bidGYKGhDSUu7GpgOA58NAr87pVosVkT+BcIQSHFOpflTnt4FHjDMVRuJKUSnsN/H5WKoBFaYzkVmzVDcE6MBmgSZy6LDST4751nHKj1DF1zqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7MdOjhx; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZjRTjFJvJr5566fpgdY496c2W8GF1NVg91Un1EExjojC+MRMSIVG+rQbjSmUzfXmWQTAP/qhvoIlLdmqcP1PGjcEk9gqNbmIgUvv3UZ65khJU6HhNBRF/tAZt10BE2UvhmBk4QJN4NC23KaojdcaGHuKeZYG4uDsGyBTw5uMNPHG7sI5jst+b6Ep/JcGqbgIygiVtBuoP9XKtprz+9PwZ0XNw9vm2SydqtN7/aqmZUfq8n8LYmDMcBbLXwkMK/9cd6zyjR/SGpBKF3uFQLU9PYhuq4UNooA4oh0ds6dAZ1rdv58639bxJLI7tTwIfqiI1pZmh2pdRyv/CCv0wYnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq7WXEt7cDg5fbzyh/8/J57sh0VZlCDL0xFFgcpMgyM=;
 b=Jqp6YqhTqhvcR/aygIbFeXHzqrHk+U8aAnso04waqlzHqZe9DoIYawQHhb74tuGgK11wkLDtFhWZRIpNrcIZ/zpOFt9mZguDBwGjMcrGi6B+qQqKcyKnJcsEpjQpSKJBYzYyGUcR1Evd6JB2F1TlSCMhK7EiOqG/6l2KjQKf4Trv8bFgtbSVHgFacVaW6xozKFxZRicDxv4Lzdb9wVf1znNSH0pTIug0Pdcs3VpL32bm3CsMOYMP0SWi3zMYCqlL9+X6zp9Tiu6C3PySjO3H/nwBUQR4GzbIa0Ls+W6K+MsaroQge69JMMGYZvHFGa8EQJ2CORWVoqDkuX5QcN7Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq7WXEt7cDg5fbzyh/8/J57sh0VZlCDL0xFFgcpMgyM=;
 b=O7MdOjhxoQ1fRpQtiAfUzwrpp0wgidFvwnnwd90N3hTG8tdx+QLkxfRxPtvk+e9UXTqKfSlu7x9FpL7x052HGdGVwT8f/M4XeY2zj0EgC//Ntub556WPIzW6HlKd7fi1KEOjH7rMuTSFczOMAtVMthOJVWugiJblaLYZlGFGbe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 07:21:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:21:55 +0000
Message-ID: <874953cc-c673-46cb-87c4-c7d80fe850ea@amd.com>
Date: Mon, 27 Apr 2026 09:21:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/sdma4: replace BUG_ON with WARN_ON_ONCE in
 fence emission
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260426215256.50722-1-jbmoore@nooks.dev>
 <20260426215256.50722-2-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260426215256.50722-2-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 12868984-b569-4d45-6e8b-08dea42da8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6FfVQUkUHhiycMSyq2Lbdh182M9ndpMNW2vvphEfpwhV2b6DmPjZy2x93+5y8W2AQelSrau8k0VN38EYQjR8Bo4npFHF+wRS60zwUzmyiu9me30Z1bGKPBdKSO8CdMibDouwzwDntQLNtp/GsJBd2+5P2nZYPIIigvAUk2192Jqr+ZpnGz2ix55ziqG1JLbWSjSh0esRtmmaZ3zhEGSnavWCr1DWZUzo4eIFMK2gbYU3CCit5+JQFTbibqeOcz/SD9ynm2ZRb+2UVsJtnRdRwyVT/iL9m5ma/Cg5N6dL7R0McbjHWBbmhCPnfeNrGLbT4sp9JtHiO6fzbVVb8ToOFRndwFcSiCMbpJZedkU6c/N+X1PUwPm0Ch2MnUjGW5Snp6ctWAdL/4BBXmMI6EPFRj1tyKEG1jsvTs6Blk+fKTXV5yzwO/AtZlg7hfGE45Mp3s2dYgt9wlGGKgUkuu4NclzYN+ICtqJ5SmpVL9zSMTbykdC3cgnFJ3Sj8lTpYqhEKWtlm19M5zYrRFODxF4A11dRFBvjrTUqNLnevzdyw2MU6yDtW3k+K4vP8K1VdCX6xNIH8Z6mAA5aIHThHcZFfYsU5hn3x39qMWbQm3wQnFVKPxLnc7pnZpQ3ou4wNCV+4YXl6H/1moCk7CQyodjXLxK0ZhLK2nK3W0ksclILOFAPCGgry9FZTb9JUEr42VwLcVxjtx6QcGC/MNReu2Pt/JQo4Lv0H47MgVcHJ/iYevA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhuUTU4RDEvZnQwMkFRQkc1WnpDVHBSaHF6NXNJTjY4dldWWVY5dVViZWlV?=
 =?utf-8?B?bEcvK1dpbS91NGRuYkgxOUdzSUNMczFIUG9VaGkwRkJQZm15c0R3WFdTTk9Z?=
 =?utf-8?B?SGFKWjU2ZnlqbDE3UlVGS3JZUVArWVlvd2pmM2MrSjJTL3dmeWg5bkVnVWtk?=
 =?utf-8?B?ZnBIQUJVd243MnJnaEZJbmNYV1RUcjBzWnd4cFkrU2QxdkxBNG1EN0U4YTJq?=
 =?utf-8?B?L0FkYldleW5hK2tzMW1mTTl3MFk1VU1SOXZXdkZKM1lnWXRTQTBFUFcyVzNQ?=
 =?utf-8?B?a2RMVzdxWEF0ZktlemQzNS8wVnBKRm5tZGVKMjNQc0V0dFlhNURDVnM0N3pN?=
 =?utf-8?B?b2s1aTJOQlZQQnpST3VYcytRcHJ2dVhVSDZLQVJmZVorNzY1a1p6dUU4a0Vs?=
 =?utf-8?B?ZVpmMmVpZGErYzF6cHBNUDcwaElaTHY5alNOcURoeE4yUUYxQm5JYXlFMlZn?=
 =?utf-8?B?Q2JtaThMeFVDOWMzcm01a1Y4ODRKTGllOC81ems0YVB3M1FDd1hNSjl5dUFO?=
 =?utf-8?B?eTgvT0lyc3NLRWZHK2xMRGlwVGNobXM5OXBEOWI4M3J1RlUwcFBMYnFKdDlt?=
 =?utf-8?B?VDNLTDVSekFzYWhqRW1sMGVoWml1VnZNcHJscDhJU0VlQlpJZnFoQU5qT1o5?=
 =?utf-8?B?V0FiUWthd1g0QTUyUkhPekFIbnNPZjRBOTRwVTRIV3NTSGRuNUFuaUw3WHVB?=
 =?utf-8?B?UkpMeXVHZU1Qd3NVOWg1bFl2NU1vZk9RajRLZWVPSFQ2dXVjWFM4OWJRVitW?=
 =?utf-8?B?OThoUGJOT01qRkY1RkpFc212MGdxVHFzNkxVdk13VjRCWmFqa0dPOFdlcDNv?=
 =?utf-8?B?bDVpSEtsUSt3aFVXNGVKc21UbitZa0F3M1pLdC80QUltMEV0M3daendNU2pn?=
 =?utf-8?B?aFhOemxZVFRTelpWMEN1UXA5REM5d3VOSW4zVjF5MTl2TjJqWG5FNlRpZlhB?=
 =?utf-8?B?anhEaUxkV1NzQXhRRmhCV2krN1pvclNEcDYyVGxEZEZRZ21mbS9ReFhiSW5L?=
 =?utf-8?B?MjVoWUJKRlI1R0F1ZkxETE4vWjFsUlJ3akdUWnRYNkQyajRoYVJMRHBlQUlH?=
 =?utf-8?B?SG10NG5tcC9lbzFaREVETHViZEZTMSthYWl1MllSRHF3OS8wMEJ6SzZMNnRz?=
 =?utf-8?B?aUQxc05WZHRrKzFjc3ZnODlBalNTMmVmTTRBWS96RmRyeUp5aENrSFJsci9L?=
 =?utf-8?B?WUtvd2VsZ0xBT3M4SG1VcVNXU2djMUNHM3YycWlHdVJKWmJnWU1Va2RFUkox?=
 =?utf-8?B?ZFNpWi95TU1XZkpvam9OS2FRVTdLUTArU2svQnBWaWRpUllKK04xSm4zNjBk?=
 =?utf-8?B?Nmd2c3JlL3laMVlkR1Yyc0xVRk1vSTFLQnh5dXRGUUhUc1lGdGFoTm1obTVx?=
 =?utf-8?B?VjViNTR2MFQxTVNuSDhxODJlUHI4Tk1uVVZ0ZWRweDhEMTdqUGxzSHphZVlB?=
 =?utf-8?B?QjBRUjh3ZEEvN1ZvK0tNWkRGVXE0UWJ2eU1ua0RodjR4Tk5KV01JZ0pVRm82?=
 =?utf-8?B?ZGVyQTZXRDVaUXpqcU5wdEZ0b1o2SXd6TE1BVzZYSm42d1lQZWFMb3RnL0xi?=
 =?utf-8?B?NmJnQmR0UXpYWnNMTDFPaVBOblBoNGtvNU4wbS9oK05vdG40QjJwOVZmZExG?=
 =?utf-8?B?SWtiVWRqajZnRGw1a3M5eEtPcFdzTmp4SktReTRJUjFmQ09jaWFIRXRIbnhk?=
 =?utf-8?B?alFmZlhTODIzZXJqcjZlQW8yUHlTNmlabENma3IyRVhYOGYzTmY2TnBrMmRz?=
 =?utf-8?B?V0x3cm5EdDY4TjRGTVhKQUh2QW5ncVBJSE11S1FBOGVsbU9BTCtlbVlleUFi?=
 =?utf-8?B?QjdPNkJ0NXFKM2JnbDdMUUx3V1EydTJDeFFRd2RQRG1qWlY2a0NVdnl5emlE?=
 =?utf-8?B?Wmx3S0srZkJTQTR3WHhwM1NMVWpQcmxVcTd1ZFRydHl3UXRMZlJ6K2lBOXlL?=
 =?utf-8?B?ekdQYjVJL2FLbVRuRXdsMGoraUQyaWVPZkdqY3FBWmprVEVKMGQ4SWVZbVll?=
 =?utf-8?B?cWtSMDVrbVRzaGh6b2VKSHA1QUlPY1NmMmJNTm53c0NiVUw2a2plbUFnTDVM?=
 =?utf-8?B?U1JpbXliOER1NGRXU1ZKb3VJdW1hMm1uRFNJZ2hWV0ZycGtIMzFzQ0w4TzR5?=
 =?utf-8?B?eWpQVTNpZk4rTC9Mbi9peXdlUmVlUktGdHNUQmY5WVpGSXRIekI1Y01OM0Mv?=
 =?utf-8?B?Vy9WeVAvS3JGT1o3bWplM25VYVh1bzBvNXVNbzRIdTlBSUZEWXlaL0lSSEti?=
 =?utf-8?B?eStmU0thekNuYml4bHc1a291R3BKMDRhMFhzbVpwLzJOODJ4QW0rNWxCYnZr?=
 =?utf-8?Q?AD5iVxHqazJaJ3gILV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12868984-b569-4d45-6e8b-08dea42da8e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:21:55.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RznGwfP1ZYrdIQ3tld2RQjOS39htygawcDaEOtbP55vwcRc5HjDNWKP9rNu6+NUj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-Rspamd-Queue-Id: 0879946E499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241241-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 4/26/26 23:52, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> sdma_v4_0_ring_emit_fence() contains two BUG_ON(addr & 0x3) assertions
> that verify fence writeback addresses are dword-aligned.  These
> assertions can be reached via crafted DRM_IOCTL_AMDGPU_CS submissions
> from unprivileged userspace, causing a fatal kernel panic in a
> scheduler worker thread.
> 
> Replace both BUG_ON() calls with WARN_ON_ONCE() and force-align the
> address by clearing the reserved bits.  This logs the condition once
> per boot and allows the hardware to proceed without crashing the
> kernel.
> 
> On all hardware that amdgpu supports, bits [1:0] of ring buffer
> addresses are reserved (they historically encoded byte-swap mode on
> legacy pre-amdgpu hardware).  A misaligned fence address indicates a
> driver bug, but crashing the kernel is never the correct response.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.
> 
> Fixes: 2130f89ced2c ("drm/amdgpu: add SDMA v4.0 implementation (v2)")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 8a2a4e618..dcb7e4219 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -889,7 +889,8 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>  	/* write the fence */
>  	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
>  	/* zero in first two bits */
> -	BUG_ON(addr & 0x3);
> +	if (WARN_ON_ONCE(addr & 0x3))
> +		addr &= ~0x3ULL;
>  	amdgpu_ring_write(ring, lower_32_bits(addr));
>  	amdgpu_ring_write(ring, upper_32_bits(addr));
>  	amdgpu_ring_write(ring, lower_32_bits(seq));
> @@ -899,7 +900,8 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>  		addr += 4;
>  		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
>  		/* zero in first two bits */
> -		BUG_ON(addr & 0x3);
> +		if (WARN_ON_ONCE(addr & 0x3))
> +			addr &= ~0x3ULL;

A WARN_ON() should be sufficient here and I don't think we should mask the lower bits.

It is perfectly possible that the lower bits were re-used for some other feature than byte swap.

We should just make sure that the CS IOCTL filters out all invalid submissions since here it is clearly to late to do anything about it.

Regards,
Christian.


>  		amdgpu_ring_write(ring, lower_32_bits(addr));
>  		amdgpu_ring_write(ring, upper_32_bits(addr));
>  		amdgpu_ring_write(ring, upper_32_bits(seq));


