Return-Path: <stable+bounces-244215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH5nNVIc+mkJJgMAu9opvQ
	(envelope-from <stable+bounces-244215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:35:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66E4D1657
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E2F3054CDC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D348C8A8;
	Tue,  5 May 2026 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjdPK41l"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071B48C8C1;
	Tue,  5 May 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998674; cv=fail; b=nbXnellexVOaH5s7wCEMbuxmEXz+WBzbCwpTspY6hXK06gjzcjk9e7rgy0iCAMLrZZkwWNeAcX7Xilt0c/eg4aSzLiV6rfeag4P5kYDFu5+aDaV472tBtwreKgJ2Awe9Uf/vhX0eZAvVhYtDEmLx1sG+gVtLZjea7EoBJrz5cH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998674; c=relaxed/simple;
	bh=wsWxgrn/kHdq4l2uMbD/f65Hrk7tb1tLAVpWLREoRc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5X++W0C/TU8G/+3L/VDdoE8KOcGgUW6F0mO8VZJE1qi1qbrb0W0/nI7Qr/pSSW0ozykI5ogVTxXX5HI2c8O7cjgHfDR/9AIb4CKgPDLz0TK4QE8FQL41wBQaZz7pMc8AIDBKToG5lqnUflpS1xmjVQdXQDHUQxLBxR0vO/hQ7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjdPK41l; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnMQsX3cVvNM71bhSWXvNfb1/xPmmkYCPu6keoQ0ZG9BdLNlkoQ0rYCjCxy5i4DaZmuKzFqgS0WzsxDshQyxrguEYApwh8ipZVZgdSQFuRw2HE03FJ9CmJiVXdNDpTebHe9rog0NOTz1OWfbd98bxYR68Jiicmcq0MvhZ456Z39ZrBTzvEhiDZYLF4uM/5EGDDgwJNzKRntUhmzwVMxTlfzny+5kOR5zIKvxYJSr/AFFdjGs2UlM5Hcwdtle6Lf/XtN2xGXS5EMs4SF1WLW0Bg6ThlziPO7L6R2joHNz4ffkGZkmnBIvXMtUGnKN+CS0YGUUCpVgMziJQv1RXaBVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWiJzAIZn5/hqVS/2iMNLTYzB69nUyBfC5JpBllzJiY=;
 b=wfzZeflKeMudZxh3OtnkGsONQH7p+b6y8jDVQcDmu+TC52QHblUIUQhuwKnsffm4qzRrqRH+K6BQmZnS2TAkTLnBVCaTj97Xf75Sb+cIaCYRAIvn9Uii7IrWK7mMsibmeb0Yu/vNShwBD7qkJK7ywgsVUtY4lTDQmhrAe7qtbnRgINANYghb3BaavY0XcY55BKEK6tD9z0xP4GfS5lX2OcgIrMANitTSd8wq7O4MRhl5S45ZEe5tcHZoqrPZc1nXTuk2X52FQgTpA023ZNd5CtDCcFR6KLUVf9zXr7tXHmniBqxQvOYhy0ly/NzuljNaNhQ0ffyWEb+Rcty56hkbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWiJzAIZn5/hqVS/2iMNLTYzB69nUyBfC5JpBllzJiY=;
 b=OjdPK41l6uYKLgqK0/Xzb4BE+0MWnvo3KcsY5+NMg0/BH8sjPeeLi4IXFznqKnMkW4LecmZ0sfhAs3dRoIyPcimu6Wk14moNNV4xsICX8bH2L05YVAKdvONCoPkbxEZ2pp2X040XcPzJKEMciBxfrcFsYJCocftoRiNIWetYFhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Tue, 5 May 2026 16:31:04 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::c748:abd5:8638:f377%4]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 16:31:04 +0000
Message-ID: <6ca4ac03-7d6f-4320-8ac6-0556f408059b@amd.com>
Date: Tue, 5 May 2026 11:30:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn"
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, stable@vger.kernel.org
References: <20260504230141.484743-1-mario.limonciello@amd.com>
 <20260504230141.484743-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260504230141.484743-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:408:f8::32) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d21d25-579e-4ca4-2040-08deaac3b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nIUHYiB+vPlBPvkrOUtKYRsgPZpo0E+UjLE0kDSR9gOOOMqJ4/xXel3p5wi8676tMtSypOa1M49mgKnOFr86AiZ4VUA4Sbzgez91GsZK2dEx5dVgG5H122LdRrqZmJ85+9negpGDp0fGC4oXgZAvf/i5tgA3w49cIkIGZl1Dda1/MvR7x7t5sBAQESJ6tI1yBJpLqT1P2o0TKC8PMHpWRs5DAuLrXfLilAT5QmVox2knB4qJApthwUklNN2Vpuh5fsayzHudNkavyHnADek2EhpMuaU6xkNaPuYFhS9LmOyC2Icy0d+/QsH+JyNZnE3uRyrN4SewlKmbfDjVirmsJcxZ0giFvrG1QXE9UsUSkZ0dBXydTwcSdOlRELC6WiI6g+J4g2Vc2g1F/VZs2GWZ7kuIEJwKdAnzV33SU6wWqVIu0wXnYxZBA2UF1DECIq6Fd1gE7L+xxhxEppC6OEFra0V820srMh0VuuS2gHDgKTYDgsTKRniTpf+dQWwQqsEeXXAZVJJ7bONlC4GbJBzgjf8BYhG+1uCo75X0z0+dsYw1GGcuvKhtOYzS8ewV5w11m8nj9byiEs9xVFQ3Q26F4j/hs83sGVfQZk+9+3Wq4JXC54JNuRFit4MsYJDssMuCeL8+OXxRlHoTp0RhOSJkGLe44Qz8SGbJhChieR4arbv05RtzRP+GOuSioXpoHJpi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1ptTEZGY0RCd0VhYmJnMVVEOEVZYjI5MTdVcVU2S1JhSThkMXc4SnB3K2Rv?=
 =?utf-8?B?Zkt1cDQraDE0Q1oxa1pJRFhYRCt1eWpLRUNBT2xxb0FYRmU4aVExajlwZlI3?=
 =?utf-8?B?RCsxOUNodTlwV1I3TzhKdnVVMEFlTTBrb1BJdG1tS0o5Y0kySkluNW03VjBW?=
 =?utf-8?B?YjV0WGQ3dFFXMEF4ODd2ZHV1NTdDdExRVDE1YXNpNEltbzVncDJqTXJrMzBI?=
 =?utf-8?B?UjhDOFQyN1N0TjRJUy9INE1tZ2RoMzJJc0xjQzdsNVorczA5QU9YdTcvcEJ3?=
 =?utf-8?B?YThscy9sRGNHSlFKM3ExaHF5ckNGa1AyQ1hxeGxoNTlIZG1MVTVBaWpKVDhW?=
 =?utf-8?B?YW1ITDM0bUtKTjllWmVNSGVqeWdFT3RmK3lSMXl1bUUrcytra1oxUEFxb3V0?=
 =?utf-8?B?N0w2SHQxdmVUU3phRTNRcHZZZlNOb3JzVWZDOXQ5SWY1NTlTMXkwVXUzNlZu?=
 =?utf-8?B?ejRrYjNtR2VCaFRXODBvclVCd1huUnZRSDRaa1hobXRYaExRTmh2QndKWnJ1?=
 =?utf-8?B?TzkvMklFVzc5d0xvZVR5K2RFWkhsNWFoZ0ZxSFRmbTNMTC94VDRXTFVBMEI3?=
 =?utf-8?B?US9sUVFiWFNpbVo0M3VTUVdMTXQ4SEEvZWlLcnROazIweTkyNlR5OWdlUHVG?=
 =?utf-8?B?aFJZSUc5WVROVDg0VUxKaC91MXROcTJ2QUZNY09JRi9Qc3J3NWdFMThoVzE3?=
 =?utf-8?B?dFhXMHJCT0xjQ0tPY3JnZWh5elpOdVlGZUluS1BuSjBDY1VkeVBxOUhsLzk1?=
 =?utf-8?B?bXNkNXd4NC9yc1JUYkdrZHkwVUt5Qzcvc0g3eTZBM044eklySmpNMFJvK1VS?=
 =?utf-8?B?MUJMd2pZZW9TZCtRSm9jYzgvUnIwcEh1VVl1RThjdGpSSGRqV1EzQUdJTlpL?=
 =?utf-8?B?YnBxNEh6MEhSd3hXRU1FTEZoM1d2eXU3NUxaS3h1LzF1SHlDL2I4bzhwUUVv?=
 =?utf-8?B?Y0RPSXMrRlUxdjJldWhwM2lUVldodHB4U1YzbmRJa0h3a2JnUVpZeWRYMTkz?=
 =?utf-8?B?RUx6MUVZTjJ5TG83OUswOXFTOEdlTEZOQml4Y1NHTTU0RkJpb2hOQlBwakg0?=
 =?utf-8?B?KzlwUFRrR0NVd1VMWDhKc0daUU1jbDYxbDlCZ3JPR0dBVXNDQUVsNkVDdTk2?=
 =?utf-8?B?RHlsdXFZOCszZ0tUbXVRRzFJQ09yOGxCaG5LY1Z5aXdWNmtqUmxZRUtoSEpj?=
 =?utf-8?B?SmZNTlgwYnZJNW5vcEdtU3psMm5OT3N5dVVCYi9vbWh0VXpYTDcvVEF0SnZV?=
 =?utf-8?B?UzNoaDl0RFNSbTdNdXZzMzZBT2NMbXNWSGdTZGhoVGpJWGtXUmR3RGRJSFhU?=
 =?utf-8?B?c2xteEdodmxUZHlua204MW5lZTVWY2V1VE5LZmZiMVRHeGJLbVFzc01IK1JJ?=
 =?utf-8?B?QTZHSUdKYURONGUyVlZiQUU5UWxUaVFXQStYQXZTbWpFSjBKdUpsSUxZQ1c0?=
 =?utf-8?B?aVhMcFlhYkw4TmxYKzU5cHdWdDR2dUNFS0NiZ2NoQzlwTHBxZVc4VmF5NmFS?=
 =?utf-8?B?TS9MT1hYTExPZlYyMnkrUVh6Y1FGMFhxNC91TFRpS1BCcEN5dmpwMnQwWjMv?=
 =?utf-8?B?akVUVVZqNVRJRHVqNlpHSGFxR0dkNVhpUXQ3SnU3SHFvTUsrUmNIUUN4VFJh?=
 =?utf-8?B?T25hSGJ2Zmp3bVBWT0ZpMEpHTjk5bjdneEpHWXpsVkhrR3dnK0c1QUNFYnVr?=
 =?utf-8?B?MDRVb0MrMXN6OXVMdFN5Ui9zOEtIUW5hYTFFQ1pYYkthWTNTeVFER1VUOGVD?=
 =?utf-8?B?SmZaTSsvRHFRZnVqR0pGVGhGSWVwd3hSU1Z0aWEva0Y1QWM2U0ppT1JkeVd5?=
 =?utf-8?B?OEMrTTloZDEvUkVqc1FXTWpQRUpBNlBMQkFZZ2kwYlM1ck43Ky8yZzdCYkti?=
 =?utf-8?B?dGRvZEsweDRDMCtQTWdWdEhVdk02TmRncVB6MUhCYWhWWmlLU2FFeUNWOGdv?=
 =?utf-8?B?QUc4ZmhVaVBBbzJqUkRLdWszSlcxQkJ0Nzl2ZzBjOGgvUEJuZU10QmlLM3oz?=
 =?utf-8?B?di9oVEpHdW9yQ1JVenEvOUJCZVBOUjMwdThSQWFkVDVweThWeUJsWElRa01q?=
 =?utf-8?B?eEl1MW9wWEJMOER3QXpBYk50MHp6bHh0MEdHUHd6N0xYVzBkaUs3Y2pVTWww?=
 =?utf-8?B?dmIvS0VleXRWcThPUzZUMDZiNlFtNG9lK0RndHBhNmlWQytkamM5QVBVdW51?=
 =?utf-8?B?UUNYODNETDUxdG0xQ05Id3VHRmE5c0ZMZlVGczRpVU5NNXh2d2xicmpPMzNF?=
 =?utf-8?B?MlBoMy92R3NrNlFDOVl5bFlPZ1ZFSnROUEh5UVFyQWdBYnUvTW16aGh6MG4z?=
 =?utf-8?B?Uk9SZS9pdXpnMkFEM0M5eUhUZUdDUERHTUIwejNBTUtSSHNhdWFJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d21d25-579e-4ca4-2040-08deaac3b35f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:31:04.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggeJmfsQBsIfy/TKhMuIJ+hROUmgRgfnec60ok68aSJ1rHIDY9o3wRex7R27CKG3afk88CwweopPGUypYIxTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
X-Rspamd-Queue-Id: 9B66E4D1657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244215-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kim.phillips@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/4/26 6:01 PM, Mario Limonciello wrote:
> Some older systems don't support CPPC in the firmware and this just makes
> noise for them when booting.  Drop back to debug.
> 
> This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.
> 
> Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")
> Suggested-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Re-adding:

Cc: stable@vger.kernel.org
Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim


