Return-Path: <stable+bounces-232745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GfqABjszGk/XwYAu9opvQ
	(envelope-from <stable+bounces-232745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:57:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3A37817B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BB8E30AAA04
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185B3D6CD4;
	Wed,  1 Apr 2026 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PbBH/X6l"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016227E05F;
	Wed,  1 Apr 2026 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036488; cv=fail; b=mUXxJwSW6vdhdCGUFl9KsGHXlIPif8Q5JWGD2UINFiV4U/jRadjdCvv/DFp1OWqtiPa4Fzx0uKKSJUCoboeiZV52n7u22b4l9nqXV2Ywt86kusl9I9s11GEH/O3El7GG4hbTuupf1pEzgD31gvwyZeF7d3hYtFb/7q2LdkDwKT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036488; c=relaxed/simple;
	bh=gynynm3yjGtKtEk+ivV7oEw8CmvF87WKKaLUctvadYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RaKzQJ23w/8NOkMYyk7rbZlR69B7yd2Q/9ALodWyRX2x1SRA3vPyKkTcRgPmftqYld/jhRF8hR75v+ggrDM5TK8hCzK8bVB8zd2tsDBBBm6dPsq5lH7Ftof0mfWEcMec8feND9E8Xbb8fq+gMNqdGWzZG5y2kaNdyHz6+9gXCY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PbBH/X6l; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvAo/7jEkSYam7EZX/vtDrnLwjPEIUQI7Ejs4KEXxEf9rIReTtACDdeP2IsqmdSMdm5C0On7nvV++k5TO+K05XYhTUP3eGsSOFhe3a1BIgydmx8+swGcVSxkPN83Qk+tIzthlrdhaS7kZhqmxmPBzyB/qVkm6SSXdx3mBLYjU+mHxAm3UPPoh8JnO4eu2YQWyAmp/Bmt5QvHlSIyS0M6jXV2dQM0rggs355xGU0QHoBPSIXfrzPDmHdmcCIq+F1U25y+7W7YtCyQhq5pbcMxAKsZlrtKw/SIuhbIrPdKAR1Xppgq3bIwuQyl5eCDR4Agx4jZkADSrFXwkq/AEOXzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFGSHnI8hSuVeWM4haBlD+5o4RiQW95LJvrLGffnIXY=;
 b=oegSeJak4sep108wdfTsNDTrlyyrNj44Up+jDaUMIIO9wVpO2DH0uD/lyti66Yt28hrYxZqKSHvzkngkgKYHi1HqhwMbaTgVANyrgfFxLwVDr4CaKET2yH+jfX2i3nSaRZW0zx5T2GvbLtwlJA30MVV6uv7Szj/3Ya9W5HthoAlXlxBRzuV9Sawv8ZVBwp3c4HEBahcVJCXSD5HkwufavXhWNl3c0zGgko/ktwDGLeSM2aOZBnZ53xR138gpsP6HSuAPMlSU3LnzVQ6JFzQC7F4X3FCyzTcEGpmlgMfPMsbkrd1kNQ/ssf5s+02ymFH2FhJfCwL6bWEjZBPFzq3c0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFGSHnI8hSuVeWM4haBlD+5o4RiQW95LJvrLGffnIXY=;
 b=PbBH/X6lQnuDWKIAcIw/zbd6KZkBkyNoUH2IHIahUSleBAdaRX6xFywlilRflikyoAMmsUDc+9KehjFTQyt6UKlbFg78RrzwmNQI1Cj5xpKzGzUhP6Psa4Jm9vvXFzfl6sa4wdlMl8IgxoUWU/yDsZ5QZ/RbcaZ4wC0Q+JiNaEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:41:24 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:24 +0000
Message-ID: <e9f01579-fd53-50b9-996b-cd1d3342f453@amd.com>
Date: Wed, 1 Apr 2026 15:11:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] vfio/cdx: Fix NULL pointer dereference in interrupt
 trigger path
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, nikhil.agarwal@amd.com,
 alex@shazbot.org, pieter.jansen-van-vuuren@amd.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 217480df-3192-452c-5958-08de8fd2d6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FzS0zlk339iwW0eemu6pCGiqZxYrBNcYRENFb2QonqwcnSFerOn7wN6LqmpeUhlw9DkrMpZUtTU5QpTwmcwZikhc+6mqlI5fqbf2hQWxDHbVX8s8zqxtG0qz9ucwzylz3zPNGD/0jLZku6q50IjL+4PkSbtgfqkd4Lb5sdqHt/AOSPoV5kmKmcaQolwt27AoS+SM5Syf+wf1O/JBg3PGriJndyLzdwe6Ed9W/97RGjXYKdpBS1jQi94vQbbBFpkEq9oOTa//D36NOYIoq2TU9tKfJX83Kii0ipzYo8ViY+JprvT6mlnCnDcRnjiaaInDGfD44yECRGXHOopcJ91CAVLOnox5XrN/8UPVz0TOg9iP9rpKn/Z5FH9DY6IIdK1/FZqEVfH1VUHjWaqtsuvjdmwzjHYUfMxoyzLC/moUMH3N+49GLxZBiSbm8e++HRqJg9isZxU9MXZlUzQbnn7c22wuHNqT3X0UcK+is/bPHbKzF40dfwrhrR9yjxPADsxTPkrGKggJwQuamTNZKmcoeJjtPOc2HrgjvpDlMCnYxigAB8bgMhB08QLfYRoDy3k3QoYz51SdBVUPh2dCy+iOcIHgRu+87Bt5u8fZvw9u3u209sK/hM0ob1L+evOMt32iYMyTImulK15DJA1B/yp/O1jNG0s4hSrrYjba3sEcmLhhBkXkIprUEK7eTF/d6luenN/Ye0FZL45ERDGoQ/gobA195GGipd4aTTrYApzvJQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWpIeDlFUGpyRkdsd3VwcW9nUTdkVVBITW9Ub1pQeFJyU0pOUjFqOVhVb0lu?=
 =?utf-8?B?VzBVN1NFUUNCSnN6RXVZN0tPZUZyMkdhTU9KR0dGWUk2d3lDK0xUWlZRTkYr?=
 =?utf-8?B?b0VwZEk3cnVNbWh1cExMM2F3b3ZCdzZWQ3dyZExMSEs4cUU3WThGMWxuN09T?=
 =?utf-8?B?cHVKUFFtTGl4QnVmNkFKNkViYnBRdE1NRnF1aWVzay8zOFYxMnFGbTRBMitp?=
 =?utf-8?B?VFJYQmZvL1NuMHNaRis1Ym5pd283TS96SWlrenhqVlpTWTI4cDM4RDlDMC9R?=
 =?utf-8?B?b051SzFxZDN5Z0l3WTJpaWpaUFo0Q0J4Y0FhcEJRQ3krZk1UWEtBN0NxYVNh?=
 =?utf-8?B?dkdPU1RoaDFpREkzSzhSdjRvSVVRL1VSSnk5N3hMUko5SldueGZFQnB3a3ZV?=
 =?utf-8?B?UFpTbFpqSGVhVDluSkJLWW1PZHQxUXdUL0xCdlVaNDJaOVFzMmN2ZDJpRVBI?=
 =?utf-8?B?N05IdEdtRXBjZTBUVFYyakRlZm14WUg2RCtPNUo5bm1OQmFaRE9sR3NLQ1J6?=
 =?utf-8?B?Q1NqdGVTUXdCeTBEZ21iZ0grR3ZEdktzZGdmRGxPRkloYVFxcHRiY3hvMDVV?=
 =?utf-8?B?OFU2SEg4V3pXZ0dxalNlQVpMQ1dpdXRoZHFvQVNqTkRxU09KWFR2eG4wOXph?=
 =?utf-8?B?alJCZzVqT3FSUjRQemJXdkJkYnFKLzVTaG1CbXVjQmFJSFFaUGFZcFhvNklE?=
 =?utf-8?B?TEhJUE9PMDNWbVVIand0bUQxMnN5MFpVQW93MmMva21DYUZTWmQrSVpQZ3Rt?=
 =?utf-8?B?UktaaWIwbmNLRjVXUnIrZXR2SUNZK2hESjBRRDF2QzBZcEhFV0p0SUhQUjN3?=
 =?utf-8?B?YVNUbFEvNXN5U0FIL200amp0WktrbjlBa0hnNjh0anEyZGE5UmRUSW96YVc0?=
 =?utf-8?B?ODltaVhrcTB1T3ozemp1WjF5cXF0KzM3VU94eFFvNUVrNHF1bUxRUW9aRmFJ?=
 =?utf-8?B?N2J1Y2p5eWRWRjdudElWS0hTTU1rLzdwTmNjRDc4ZHhZdWhXbWNudXFKaUw1?=
 =?utf-8?B?MTFCR1NXVXZCSURwTEszMTh5SDBVV3RKcXJlWGdIcm83Z3VzV0hqZWR3ejlW?=
 =?utf-8?B?SG1hejNMQzBudHdXSGtpTzBxdnR2andDR0VMbGQ5RXhKZDdkVzB5cjJEeWZM?=
 =?utf-8?B?Ny9xT2JlNEp0S25wbTdxMjJMSnBKVnJQcXJQbHpTUWdoWFFTaWsxWHJ2bGdH?=
 =?utf-8?B?OURqQXVTeEZaRm0zcWNxK2p6dzA5QTA5cEpBRTNvcTNybk54bHZGTTlQU3Bx?=
 =?utf-8?B?L2M3Nmt2NHQwNVg1cU4vZlNDT0RtczFzOWd0emF6MENpOWRuS01Hd2dvM24r?=
 =?utf-8?B?QnRKUFg0YVRlNGZvVzNKOHFNK2ZmOTQ2NENydE02cythRmN1RnYvSlBPNjJt?=
 =?utf-8?B?b01BTXFJV3pKNWx3cE4rTzZlK01saEJOZGxsei85RzBsZUgzenlPTmFTaVls?=
 =?utf-8?B?d084SmR6dkpwbDhoQ2RkU1JkNDcxaFAzK3RqOCt4TkNuRlVJTDQ1RnQ3MDZi?=
 =?utf-8?B?ZzR2YVhBcTBtakZ2eVoxcjBWbXlrM3pvSHhrdFdJSjErcWVYNVFkQW02Z0xy?=
 =?utf-8?B?VnZrT3NtK09uVEwvZXBxQTFEK0hrZG96dTltN3g0anZMaEtUenJoRXVzLzdP?=
 =?utf-8?B?NTh6Y0VJU3QyZTFXUGVadExpcFpiTTBIRjdkWDZVOEYzU0kwVUZ2aHJqVkZJ?=
 =?utf-8?B?ZHNDVWZSRVdBUE1GSld1UzBTOFBjMjNDeEM5bWNGVDk4TFhkSkFNNDBCS1hY?=
 =?utf-8?B?VUlEd3hzNEpNY1d0eFJzYWVwSXRic1VwNy9EaUhHNDdCRDdyRE9obmJCVzVH?=
 =?utf-8?B?eHg4bDRESjhTSmk0MHhzY0cveCtFTGh6R0Z0NkRaeXhwblg5RUtqTWxNbkhC?=
 =?utf-8?B?TDdBL25VOFdvTmNnMWsrY1ZubXJQQk45SVBsb1M1cWl3WVR3Wk1OVDdOU3hX?=
 =?utf-8?B?T2JOOXJ1cTF5OHROSk5Bb1V4bFhBdzJnWjd6Q1haa3o0Wi9HcVFpOU1kckZJ?=
 =?utf-8?B?clhPOVlGVVdBV0J0MDdFa1pLUlhFNHpiUXlIZ0lZa1BEN0FSTWR4OENtakk4?=
 =?utf-8?B?UlAzUVBSK0RVbXJOV0tObWhRTHlLVW9MQ1k0VXFSTzJYcFBoeDhVQjg1aTVs?=
 =?utf-8?B?ZTdzRVdJa25TdHBjRGZXbXVmWUVReUIrdHk1T0gyV3M1RTZOb1duSkdMWjBH?=
 =?utf-8?B?Z0lMckR2eVpWYVV6WjVPcU1BRjk0VGFnWTAvcHh2SW1TZVUybURPU1NpVHM5?=
 =?utf-8?B?QUxsaGREVCtETHpXYkx4ekRJVDFKeFlhQ2ptSGdiQlVmMWlOV2ZRdStLSGlq?=
 =?utf-8?Q?UuhoYgUirf0MOgxMuq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217480df-3192-452c-5958-08de8fd2d6ad
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:24.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55GSg0rrwqOYC7E2UL0AqrFWwjfhHJ8BKBdLqnUbKH5k5iI1rzZeAQ03gtC4YH7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232745-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nipun.gupta@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 5DD3A37817B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20-03-2026 15:49, Prasanna Kumar T S M wrote:
> Add validation to ensure MSI is configured before accessing cdx_irqs
> array in vfio_cdx_set_msi_trigger(). Without this check, userspace
> can trigger a NULL pointer dereference by calling VFIO_DEVICE_SET_IRQS
> with VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE flags before
> ever setting up interrupts via VFIO_IRQ_SET_DATA_EVENTFD.
> 
> The vfio_cdx_msi_enable() function allocates the cdx_irqs array and
> sets config_msi to 1 only when called through the EVENTFD path. The
> trigger loop (for DATA_BOOL/DATA_NONE) assumed this had already been
> done, but there was no enforcement of this call ordering.
> 
> This matches the protection used in the PCI VFIO driver where
> vfio_pci_set_msi_trigger() checks irq_is() before the trigger loop.
> 
> Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>

