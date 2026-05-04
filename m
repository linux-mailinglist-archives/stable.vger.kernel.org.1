Return-Path: <stable+bounces-243903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ6LJdX2+GmW3gIAu9opvQ
	(envelope-from <stable+bounces-243903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F94C3555
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70DA1301A2B5
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD113FBECA;
	Mon,  4 May 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zN9nK/ht"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260683FB070
	for <stable@vger.kernel.org>; Mon,  4 May 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923791; cv=fail; b=JVxMPvzeST+p3RVVFluL5QGLsU9WhoVV6XijW+Bqd6asbqFDLL9HMFEVEwiXhoOURmjYu6WpmzhWiIappPMrSLdw27J1J28YH1O0NA9/mkp/IRnwb/sGLxbulFqqBfBZM5QV7zmkHG89AAVo2gNWGmKVsrAP63LGhjEV0//Yr7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923791; c=relaxed/simple;
	bh=eamHIa91tLSoYiOc5T/BWajDafJQTilvTxw7LNz0+TQ=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=H0D0pbkk+PGX/q93p7XFG3fA3C+gp89tx80Eo+7dXoLn41Lxnev2vpF9G4oylorVMN3cklRXfvFns+CkKYtb9NKVrKwVk46ibTr5CPsWs5VHuzEsQgz34NvBWX5F8VOHNIegC1IHCUdPvviSnNVAj/u9SFJu5e93y9t3xxEQ798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zN9nK/ht; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+PK3uyVWl7ie8GnLkFbIP+XeoNt8mDj79q/kOenlYtMtjJos6xk8nrxYFXXTA0U8kxnWep7H5q5qMO5O+F8AjqcVukcPxrReVqeVAv0RDsoJ6ZbEj0PyBuewFFeZNg4xPMnFAZ4cyfW3tIzG2jqrSZXGYAWRkVvng/M5atWVWKll3uHuWD7BmgqDIuYpgshVXF60V1HDS5ws5BXA5GDNass0s+lnXchEqQFV3h/LHwfSEHA7eQx24ALU26hsTIhvnMH+bQBAT35O8c7rZHKknNQmZFmt1rWYb9r29grYsbbB0PPwyNjDwDqLksTFQrpD4c0sdjKWRVYqKBkevzUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQuHTqx2rRpNidtQ78BRXTzgQNXsljd3Jb6hGgssRs4=;
 b=xsXQofJiQUI6lxMFQCwapYiU0QyME3fPoz6N21o/w0C45i0cEunC1LQwHlGcrSem4nnpOW2TVu8kNkL2Tl51PGTUBuKYD5fDAHNbq3Gn1WLYOGHs+kZzxPSicaAoJy0FKSOP96WzKdSjRmXVWZZuXyE0AW3CY1raRk3nAt+JFXMo3HV7ctD+1l6Yy31n6lqbJepCmCxUVsaqDPx/BZn7GrJmNVt2aa51OPl9v7zSKksGVNpvr9rLWF2YGppUE5hQkwitFsneZKlCpm6QDZCCQ30LYsGvVjyag844Tb/782ST/F3quHD9qMMSgl72h9UuAdO+aKJ5Kh9TWaWNQ883Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQuHTqx2rRpNidtQ78BRXTzgQNXsljd3Jb6hGgssRs4=;
 b=zN9nK/ht+VsoKEBQY5X02CmuoAVwfmtz6c9Nxhw0n2TP8JVfCiAnRzkcZe67dgd1BStBxLK9KJ0i8Tv76laVzU9D6GF3oImUsXAmjNl/ppDvLCRUXlsC6LWdAv979P1RN3sP0P/nfLUBTi6+J/JE9mB+4MBrMIhmBW4pwiyIHr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:43:05 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:43:05 +0000
Message-ID: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
Date: Mon, 4 May 2026 14:43:01 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [6.18.y] Missing TLB fix for 6.18.y
Cc: mjanes@netflix.com, "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:408:f9::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: cf20da3a-c897-41e8-fe45-08deaa155c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iqxsjtnYaYxjpsyKbEic9srRWIcJXLk2oKH+azVvkntQLXQmqBvssrlQhB02OORcstNMcNuLt18Trh+poei18ScfM/Dyn3Kgf4fDo0eztTOPnQvY4DTIYOINvS2omTlf0nrb6UwhiBkXV3/FyXYJPyeuhfdnsLxJrKYK4m3KdnqJyQkTeFYO0Upff3Q9jTKdj0iM2+EUC+7/inds06Npb67ilg9+fWUyiFkKT8QM+jc8a9AnLsLk7G0tN2ZHH6CFQUntwhuVo4XbsibOrXa/7Z4XZJrhx85bJ3ZyMDkdZFKO5oqx02dpIyYZ695pmRhVJGUO7eEvKJp1g9A1eD5kDH0aOcxRPQmjXaLQ0QTNX1A/m8ycnn3JIpdayFft/fdr/fY/dDTdbqn0LBGb7e/P1fyi3i7VMuSoeKXqFz3Lxi11561Wf5Fzkr/tp2rIfnYdi4+d5SLmxHlw3he/XAwaZwFh88SWpbGX4lOcgYdLC2044Kh20GzlwH1SwYKFvXIvccwoIBlBsmLcUYqyVjHfwBujOusAN+ru+7WvKJVpeU7sx2j7e66jm2GLY1tX8qFP2bgc+/IA7z4p1akmYnwVRnlb5oJ/iVzpYhbxALR8iUnNSSiZ4sm5uC41gEKLoEqVEuAUSWNPsqklNf4KnDg+7ZuJVxrdlygxlHaFL4SKidGynogJiN5HGjfQXrKSFcT8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFQrbDBWZUVleWhMS1ZkemM1QktMdk00b24weVZUUXZ6aGo1OUJKNlRaODI5?=
 =?utf-8?B?b25hZ1NJd2p1dUVHZGpUOTBRYTlnVTErR0gvZHJoM1lER3poUlcvd1g3L2Vl?=
 =?utf-8?B?dkI1RVd6bmhHd2xWdVFJeURDS1l1M3FlaXA5bTVVaCtSQVNtTEtGNWpzNkh3?=
 =?utf-8?B?eGtmUHFORlBsREtKQU1NVHhrVXlBcmw5dEwzR2dnWWJXVmlUU2h2em92VFJv?=
 =?utf-8?B?bis2SUdRMnh4MkRPUTNwMjBEWlZWdkJOOENVbzJJTnRqa1g1cnk4UE1PemdU?=
 =?utf-8?B?RGdMcTM2cjN1VkFHN3pabUtZQVlVYW14YTVxSTZQNlU0RUFQMFV6TGVneVd1?=
 =?utf-8?B?d1N2VkhPQ1dnU2laY1dyRGMrckdGN1QzZlJkSTlMT0xJZWhnZkhaaVN6Y0Qv?=
 =?utf-8?B?TGNtMXliR0JnM0VVVi9FUkRmcGo4Tk9ORmRVdXpVSVRwOGNELzlQRUxqRzE0?=
 =?utf-8?B?K1k2QnZ0ODl2TlB5dThkZk8xdHFEY0M3dWxkSnB0dXRTRE8xSEsxT3NkVXc3?=
 =?utf-8?B?S2JmOUxsTTBzcGRpWEFiT2RiQlpWWE93R1FYRHFMdlFEeWY1NERTMnBrd1B3?=
 =?utf-8?B?dXJZdXE4Q1ZhcDdpQmVVZ09nN0lxakVieGhBejhnSFNmeURrd1RHQ2EvSlRI?=
 =?utf-8?B?a2pSMk1qY2RxZFR1dHhab2lOVWI0K0JjQ045bjA1OFNDS0xwb0JrZk9mUDNS?=
 =?utf-8?B?YUNRbUxYSzQ2T1RPU3FXYThCUGdJR3doMVZ2WWQrVXh4OXhJWnc0RFI0UTJN?=
 =?utf-8?B?ZStPbUlRVWM3ZTkxVUZFV1F0SzJOUUNLbTF2QjcwSFk2SzM0aUdHNzErc0dD?=
 =?utf-8?B?enlCUkNxVjFEY3BmMXFXazJHVU1BQ2ZWeSt2K0tseTErRlRkb1piT2h6QkdD?=
 =?utf-8?B?emtxcEVWSlhmaUxxcHFObExHeXlPSHRUU3JhWTN6M0phUUNUZWxMa1FPODR2?=
 =?utf-8?B?TGl6TlQxdzNwUGRIZ1NWRzI5Q3dUUFgrVGR4dUU5TlpiY0x0WkVrd2EyT1FN?=
 =?utf-8?B?N2xpR0MyS3Y0Z0l3b1d2UW5wYkpXdVQ4U3QzM0xocnBPQUdPdTd6c2xWZ2s4?=
 =?utf-8?B?SUhiVUVOTEFHekY1Q1JxUDI0WnFFRHhJWjJiNUhtRzZ0U3drY2Q4blllc0Fr?=
 =?utf-8?B?VGFGMGttNXVmOU5vUkREL285MHVhZzRycTUxdlJ3bGhGc3ZBZ2d6N21uN09O?=
 =?utf-8?B?VEZiMThNWGdkeHBCMElmYXpOeDBUQUltOXVSSEQ4aGRMcytWQmxYZDg5ZFRE?=
 =?utf-8?B?RWhnMFVhNnpYTk5mQjh5dzAzV3YvRFdmK0dDaW9MU09nT05oNG03c0tuNFlo?=
 =?utf-8?B?ZG5xL3VRcHU2Y1FudUp1SzlPbzVlVUFsdzNxUU5mTXJuVHpLaGhQazFGUlVW?=
 =?utf-8?B?RTgrcHNnSWZhY01mS09iOTZSMUEwZFczMkpEL3lYM3RvOEZXbys3UkpOZDZp?=
 =?utf-8?B?QXl1MGs4QkZxSUJST29qblFzMXJsOUlSTloxOTkxTm9VY21QNXhZMHVpTXE4?=
 =?utf-8?B?bC9LY0cwV1RodE5zUldFdlNxeGxPbnc0Zm85RXhYd0tGYkNQWGY4VFkrMjBQ?=
 =?utf-8?B?eFNrNFVad1orUzhFREJMajhyazB5alo1Yy82R051eXZITHBhVE1mRjYxOXZh?=
 =?utf-8?B?TnJjV0kzZkFsdnZPNEZOUGNKd0lwOUd4c0JCZnlWbkQycExHUDZldWVFbnBM?=
 =?utf-8?B?VHQzQXpNUmxQT01xRG5VdzNaZEEvVXFLNk80YThQQ3JXRjNGQk5neUUzdm5m?=
 =?utf-8?B?bWJnVHM2MnRxYURtOTFqUTg3MmFRaG5lcnRJUjROSUxzczNzcWtlS0ZVS2Zt?=
 =?utf-8?B?MEU4UGFqM3hFaGZheXZvalcxTDAxaGtXWXRDUkJGcXpBbzJ1b00xRVdZUW82?=
 =?utf-8?B?eUxZUFkyaDA0NjJ4emNzRmJ2SWpPdUdSdTdtYVoycXdLTEZmYjJYZmoyeFNk?=
 =?utf-8?B?OGpKYXdnR0QremJWNWc2ZFlSV0MxVGFKdkYzNWhjRllnMU5TbGJpcDYxQmsr?=
 =?utf-8?B?QTVHMUNianpCZEp6ZmluT0Nob01yazRoYVJ0Sktxck1zNDhjTDZCLzd1Tmcz?=
 =?utf-8?B?dEUzS2xFWU5udHU2YndMYXFFS3hwZDkxYmx4eEJsT2lDTWhBaTNYR2dNaWdN?=
 =?utf-8?B?bFRuMmI4c3lJYzNBS0hHU3VEYllyTnJwVmtyZTlYakhDYURuNm1zK0wrZTdv?=
 =?utf-8?B?RjZubGt1OHZCTW01THZkTGxaTXR6MU1LeUM2bmJIM3Mxckp2dENUTldWenZz?=
 =?utf-8?B?YitPT3V3Z2NTZDNpUi9CVlNtVEdGNmRXbHJKR0g3VGNFN21oTmJHcHRKTXgr?=
 =?utf-8?B?c2hnUHA2NFFvQXl6UitUT2FrRmJnZDNvanRxVjBHVGRqeTQ3T1NWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf20da3a-c897-41e8-fe45-08deaa155c0e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:43:04.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3nFS/Jdy8Q4g+T9UwTr/tRVfW1oPeVPaQfyd+Ndduyuvh/8KMPaTCkZfn6DTAVGhPuAJHsl2ajdtMDVXxYqsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
X-Rspamd-Queue-Id: 117F94C3555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-243903-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

Mark Janes noticed that commit e9f58ff991dd4 ("drm/amdgpu: rework how we 
handle TLB fences") was missing from 6.18.y.

This went into 7.0-rc5 and was backported to 6.19.y but not 6.18.y.

This is because this was one of those cases that the "Fixed" commit was 
in both 6.18 and 6.19.y as different hashes:

b4a7f4e7ad2b120a94f3111f92a11520052c762d
f3854e04b708d73276c4488231a8bd66d30b4671

So can you please backport e9f58ff991dd4 to 6.18.y?

Thanks,

