Return-Path: <stable+bounces-243905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAh5BVL5+GkG3wIAu9opvQ
	(envelope-from <stable+bounces-243905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893CA4C3603
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D913022AA3
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359F3FADFA;
	Mon,  4 May 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UWzvg5S3"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7D3FAE0D
	for <stable@vger.kernel.org>; Mon,  4 May 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924404; cv=fail; b=ONjtmXEtac9cPupZ3Ri8uqBcH1iV6ITYQ2jlZkzhOGoO4rXrnCmEfx+IwqdPmQxiWBuL6FpGWJq5S+XR7VhpHX4F3s+CkO6VlLav6kMGoHB7xWkcnhM8F+4lSuyGEYgQ6qWFmQKsZZjBp8wg86SwYoRBI/Yu2Yr9m9m91BLf02g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924404; c=relaxed/simple;
	bh=XK08sKZsZH9ZAgnVOXCjjwHqDbBqhD2tj0JQkuVOlyM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=beXqBrwz7RYSdazII2uXCzviNib74Eoe1L35hfEuLlCIzbRA7FnKT/z4gDmGxhheQc5aMgvuyWIRgr67q/43HFWmOjCp2PpAa2/oZo0vwT7fHRczR9dIJXCvQVt/4AePs8R8rhhfmmsZThg/VsY2jp0cN1rkufKNbS+OvAlKFek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UWzvg5S3; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz4LgHcOO5ZUHsrpWh66SsYCbn/IgwP4LAkh/mO/oFr/Oht5vmejM3iXsga4y6GYaTU855OjQyF7BGfPbT4jLwOpqRdnzYneoICjcKn7e4WDua4RDeszqPxHX4nKoqnc5zaRnFH7awpVArkAnQjmQkO5xhNjgXRjVNb2MbYE18Tv1dW4CnZNDOxxe8JE4r6zXCcvbN9T1wzhq1NFuB5qAWHS+ZGjH3uqVzcmLJbhqSoKYQXMKsZeIq6UPK4ZLaC3mhaEokdiiCvu+DRrM+JWb/eCzKfydfTi4oEMnHfmMgUirdOoAL22OzlFdBK2SzMoMi6TRK+kPAlj+vc11wYrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm8WTX9NofTiFh51W55mkcWzqls/w+L4gjET9Mc8E8M=;
 b=nQyYklzytONrdKxyRrIQOHkqGos7cSBsEw2VgJInygx3HvphbmCUoo0vEkYW0XT5RFxeIfsjQ/4lMGgRySYwgCUJJqlZ5ICJ0xEng0YqwAoLA+GTCz+uOp5sH2dPx9lfOuJQ9EFZGOGThT86ogoSH6rMcYP4RtkeM3/Bi49k3gZra7JEKLx6mphP3hh9C3bWgebEYY+LUTO/Z70EC9Baq8oSI65yR8nq3oPdiXrZJGRvYpexI13nE0wzEtgDoERb22jK7yelSl8ffdHTt7KJbI0sWpDr+h5mP+YWXOfpRW7vu01s136cbil7W0MA9IjiVQQvbnB5Nfk4auwB5S1pmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm8WTX9NofTiFh51W55mkcWzqls/w+L4gjET9Mc8E8M=;
 b=UWzvg5S3thXwRvBCtllYxXC3n9csLe6Byo2Kb6Me8roVlRbH1Vxvfk7YpP8B40Z/AJCtMGjm/Jvutm5UfI67wlq0xKWhMmtvLPUsLB9K0qNgnhd/q1nZ5Kwz1lK9r/pE9Lc3hNNW3zBBo011097M0RrXOO6OdlrbQcqEqCnt2ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:53:19 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:53:19 +0000
Message-ID: <ba6a67f4-086d-4e05-bd86-fba464778d8c@amd.com>
Date: Mon, 4 May 2026 14:53:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [6.18.y] Missing TLB fix for 6.18.y
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: stable@vger.kernel.org
Cc: mjanes@netflix.com, "Deucher, Alexander" <alexander.deucher@amd.com>
References: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
In-Reply-To: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:805:66::33) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e572f6a-3114-4e87-a0b0-08deaa16ca89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uGoZRokDr68xOWgDRFcTCW6e7uOVPve1W6/niEq8T6Fg0AhGHdpz+H5Eiu/SQOoAlTNi3ySYbrPkyZ/DBk783PZFzjAudbG8OB/c4t8SD3OKjHojFJDNRVlhH55hCmSH9MN+nO3GsXpoeGJfxNx8I/gmtaNYB2T9N9Hw3+KCRebLCQlBfijrvT3cSM6DBpRYcgxb2/j65jrc0tRtQXEudaqxJM7XYEStvc8dijMXtz/aLenVe09oRNbq8N+ZOjmXjJN4JoZXanhWIQqa4zgVbkVdC1PDWndtl9qYX6ZUTWigv2z1gN6baHy1trcFfcN4ufVTSJiMIPpaytAMXQkdA90UgqrOHb/QGA5bQMCjUjlKn6KP9vBk32CK8gWjKvlxMKPfB2akMAfAvWwThNksmX0KWO43DUDnYlpF/IhEoeA5LYEkJCRzQvOSMgeBHtf0TfibrtNp4kBJo2vGN4kFkIOy/sQOJHLl5NxbkUSnz7cmd4UT7XKhpI9Ni+O4bvGO0y/4mAzdWqHSIVlaD6Po2zQ/eeOBJLASP7od9mYpJqdRotQ7OB+LdefiWmZzvEuSLRmhVOwSfP7CvCrKRO6qZmOMioRZJwZSj4pHOquycCmDeT6ZtoGb1JL6DHemGkJVQE01zafkjAj8zZAbJmbnSr9rSNv34k5nsk30Sllc3/LW21Wl+49UgC43IogfpHsG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5oTy9kOGxtYnRsOHJXaGEyOUFrbzRyNzk0OWdzT0QxZm9xM2h1SXlvOXZi?=
 =?utf-8?B?d0tDQ3JRWlBycUQ0MWhNd3lPcWRDRGxnMXV0a3BiWmgvN01tWXVjZFdnVURa?=
 =?utf-8?B?YUp5ckw1Vk43V2NWdFNJMElhNk5ZRnVOOGJGZE44eVhsTVBCa2ZwbE1GK0ta?=
 =?utf-8?B?V2RybmhLMHVsYkdMMUJZT3JiS1kwbTRBSTI1TDJQRzBsMFUzZ0pPNGJFN0lI?=
 =?utf-8?B?ZjI5dE9LR1A4MVIzZjQ5c1YyQTFoNzgydm90dDNUQ2I4V3dEQWlnTUgrVWFz?=
 =?utf-8?B?N24yNWthZDZrNVJnUUhZTkVja1l0VWE2TkxZak5VRXQzaG1INWpJeURPNXpj?=
 =?utf-8?B?RUdSb1gyMkpTdVpBalM4ZFZZZkNIZjJiU3dVNmFtTHBzWEs4MEhTQzZBRzBl?=
 =?utf-8?B?eGwrU1BYbzArNkVtY2cvQ21WNTB5OGM5aWUwdTBYS0VPOS91cUJBY29WdjBP?=
 =?utf-8?B?dHlGQUYzeENJM2NPNCtiV0x2UkZ5dXN0azJ3eVJRR1JMRmdUZVB0S3VCNWZ3?=
 =?utf-8?B?eFdsQUNCVG5uRVlaS3VQckVoYnNWaVVyTjdRK01ZT1hFdFBuVlkxNVZCWFJj?=
 =?utf-8?B?d3V5SEwvV0ZKQlVzVE1iVjlJWWxBMmVpWll5S3hxWENRZ08wYVRJOXpSSm4r?=
 =?utf-8?B?WDRDdU4zOXV1OTN5cmhJVXd6M3l6RWE2T01sT3VxUVN3dTJGaDVnaVdBQzFj?=
 =?utf-8?B?R2t0cW1EN0VFTzRsVENMRHpVSTFPTzg4c3RwakxSUjNnRkNYWURsMThGbUVv?=
 =?utf-8?B?bTgvSVFvVnNDNURMbVNhSEViZE15K1duTXpMeW5lNXFmOXFGQmhYdGlDRWdC?=
 =?utf-8?B?bWJKRytaNE13YmcwZUxRcURkem0xRW5UTkZ6d2xsalM1a0xLYXJKQWpNMThK?=
 =?utf-8?B?N0xoOFJ5R0x1ZDQyeHlGY250THNYdy9lTEVUbHExYzAvMWM3UHdmUG1hWWE5?=
 =?utf-8?B?UGNrMEdBd2JoNWdFelZ4eVliY0xXNEhNVXZ2NUpCcW9vM3JFMXUvdzBKbGdW?=
 =?utf-8?B?c1FuM0dBdy9Od0Q5Q2dFQmxLQkFkK005RWhLamFQdXlKMVhWMHUyeVByMXJq?=
 =?utf-8?B?alY3QXRYZ2tNSkloeld6U1VSclYzZEh5SGx5NXltS1lPc0Z5SmVmV1RFNzBy?=
 =?utf-8?B?RzhnclZubTZ3SHpCYVdSZnpKVXYyZjdBdWtSeDBqT08wL05BdzhNNm9RaXFl?=
 =?utf-8?B?QVNxNWhHbTlvWkNNYjMva2svU1AvUG9kL1prc0duY2hwN3NJbExsTzJKa0RZ?=
 =?utf-8?B?NVVxVHpWTGJMeXZmMmdlaHY1SjR1R1A3ZVo1RFdLazF3c1BHcXFaaTBUaVE3?=
 =?utf-8?B?aW1UdUpSdVhMdWx3UElsR2pNK1lyZ1liM3hWNFpmajlSS1A4aEhIZVFzSjNK?=
 =?utf-8?B?aUJ5MGhGS09DVnEzRlRYRjBsTUdUaGthTGYxdmRpNkZhMFZ5SzJFOWhoUDVM?=
 =?utf-8?B?am0rdE1BVHcrUDNvUENtdG52S0Exb0J5azYzU1RJMGt3RWNWekdqdUZ0QWc3?=
 =?utf-8?B?YmlwaXhYWGpOcE1rK1lTZkpubENiaGNoMVBFcG0yRGI4UWNxYjlqamZiWTlV?=
 =?utf-8?B?ai9JZ3FEandvS1Z5TkM1TmMvZDN2c3pyWmdDV0dCNWx0L0dqT1ZRckYyOGJ3?=
 =?utf-8?B?WTlaRXZ5UmFtc3pycitUSGtnZm5UaXp4c0Qrbk5uUDA1SmJkUXZaM1lCUGoz?=
 =?utf-8?B?YjNpMDMzdjljZEFBeHNoZmJONk1pRWFSV3Zocyt3a3FxT2ljQWNnMUJNYU5l?=
 =?utf-8?B?a2twWlRrYjJZNEtLdzZyS3hpM2xqWXZ0MGN4QmxIbGlLai8wTUtQYUxXYTk4?=
 =?utf-8?B?UnI3YVpYbXFUOHNUT1BOL010RENGa0lkb2VtZ3B4WWdSZUhJNVZmclZwS3c4?=
 =?utf-8?B?cjZkTHUvc2JQa1lUN3FnVUdVWVpNN25CMzRnTkxkNGYvVE1SSUlaWFg3N2ov?=
 =?utf-8?B?RHBkb25iQ3c5RUZib1k0YnNDbXRTdEk1RGFoWFU5TnBOYXh4YVFYYlBHOC95?=
 =?utf-8?B?SWZCY3dsdm5FRkUxeXowK1J1NVJTOCs4d0NHNmNNNXA0NHVFT0JrRVpIU3Zx?=
 =?utf-8?B?SmJTVFNydTFkK0MwWml0WTdVYW9aVWdsN2F6R3lRMUpRZWZlTmtzRVpBL0RO?=
 =?utf-8?B?QmRKN0o1UnVZWTJnbzF5Q3dCVXEvT0grRmYwVGVhQ0dXY0diVFNyWU14Z3Ex?=
 =?utf-8?B?YlY1b2dqYm5XWlpuSm1QWEliL3NSMGo2RXJKWlpycFkzSWs0eFFicGpsWHRz?=
 =?utf-8?B?YWl4QUFPdSs2SFJyRXpSbzJpUkN3R0UydmYva2tMV1lPV2d1QXl2UURSMXVK?=
 =?utf-8?B?UWtaRks3RlVPL1hSOFdPazFibk5nNVozUmFUU284VkhKbUFocjc3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e572f6a-3114-4e87-a0b0-08deaa16ca89
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:53:19.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZhY4ZRcssuAUzKhHa4KwKb852wM06eCTcC6jW236IxBa0OwjTJZ65cC2lIdow5RjLL8kIAfAyzjp8a/rvwlUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
X-Rspamd-Queue-Id: 893CA4C3603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-243905-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 5/4/26 14:43, Mario Limonciello wrote:
> Hi,
> 
> Mark Janes noticed that commit e9f58ff991dd4 ("drm/amdgpu: rework how we 
> handle TLB fences") was missing from 6.18.y.
> 
> This went into 7.0-rc5 and was backported to 6.19.y but not 6.18.y.
> 
> This is because this was one of those cases that the "Fixed" commit was 
> in both 6.18 and 6.19.y as different hashes:
> 
> b4a7f4e7ad2b120a94f3111f92a11520052c762d
> f3854e04b708d73276c4488231a8bd66d30b4671
> 
> So can you please backport e9f58ff991dd4 to 6.18.y?
> 
> Thanks,

Alex just noted there are a few other dependencies.

f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for SI"")


