Return-Path: <stable+bounces-241242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMTUBakP72kq4wAAu9opvQ
	(envelope-from <stable+bounces-241242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49546E542
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E70302BE0B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2A391838;
	Mon, 27 Apr 2026 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q15k4E6j"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17C391E78
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274691; cv=fail; b=GCWaC/IpY81Ddrx+SzAlNb+5e85wO9tQdNPAJkAB46MZo7ANk72r+66sa4VtM6fpjfqGvTus+hwCN0UqcY83p9z5ebqOVrOWSj/vkYyz+nlqHotRmmS2/sld89quzei8muuAl2zvtekEIp7BWM3MaTnwUVX9FEp2d5KEA5HS4Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274691; c=relaxed/simple;
	bh=6UCp78LVB9t7f+5y/78YLhY4beMYF8rTZFPN62GxLlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cj3nZ7V7DLQJp4iujNCOVPO+AW5NM2sXRKqxWVIFGoTlQJwJhiousQCLJ5oxnwh3n4/YEVWdpAw2T58nmrNZTicZxPgDlBv9HwdZYfaGfReGDJEEJjhWl7jFLGj8UrM9s2tkoEQN5W6jDWR9WjvfoAYfo2eM9DFJBuPuH58g57s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q15k4E6j; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMn5Nc2L1qxh5p8GPrXa/Iar8VJwDq5tpwHaiwsPfERzsXPTOuLr1uZcKWSP+OS+uH7ToUtMVYDuHMI36u6sr2jFLvb6ljeq0ErRgJq/XJV3Wu2FernNvAa2sxcB5XcPufBiFH/VIPBrWmTIebPgnaKiTSdfvKNKXrcFYfPP0iW0LudD4gNUzYxoZdIYgcbSs1EXAxfrrR0ebAUyaSu61YOpj0EsCCAs1PmAYEhay8PsYP1MbVveeE+x2Fz2RcAAp5QyHpsJjYFMskoOkaQcIX9JH8YdeC+ilD6qwAV5JdjCvOqiu+XdRwaiNcVB5YA2WLRAGY2XBPBNqCE1Nj+7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQmXfIk8q2sk/4bts7mLFi3m5Nx0m++5mdvJRbzhZCI=;
 b=l3vGjLJkLiiOUPWydrlyk9NrcyroKOGFE08AzQHQwk7KCX7BGwEZ6LBF4Pv5xpJo4iI1n+iKdaK1R+I8jWnTz2RXy9bKTqf6OFfuqxHGxTaKDv9YijmnzHQ2XijneGmNfMgHPYGtsfFtnnc/gkV8ujsYFoZcnPLroK4ZDqyPVnouW1uwzbTzqneJyK2TE0QloGxYmMaA9AR3DfIPBXGE+E5meypubBowX81rHl3ZvirknUmmVF4R8+D6npo+Vfol29DMkrrjvnZGoCxD9RTtXM9HuZThSyY6oQJg8Zb1cQvbiWI3+mIbv7nKVpgWdvFPyUT10T4KBoXZSPWtQpCESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQmXfIk8q2sk/4bts7mLFi3m5Nx0m++5mdvJRbzhZCI=;
 b=Q15k4E6jJTAVH1kJuKd4TPD+1liW+LtmCWfUrvksJjyxWuzxo1wPwjK41od4BHfVpexVLlsKCzFOICpiy+ppptZBeEXcQ7z+8SiZu3TDpVK+dR0kGMH2nS1fI43UordtBhW4gw1YoObaFZZjSqL9MfxLtBlIAI0RUTVSy/p7oR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 07:24:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:24:47 +0000
Message-ID: <eee09ed9-f989-4719-9f5a-cd7336c2161e@amd.com>
Date: Mon, 27 Apr 2026 09:24:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/gfx9: replace BUG_ON/BUG with WARN_ON_ONCE
 in ring emission
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260426215256.50722-1-jbmoore@nooks.dev>
 <20260426215256.50722-3-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260426215256.50722-3-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 14793f5e-5361-460a-7995-08dea42e0f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	99QnvR87v5/cZBw3xIBQ0itHj+47IaGCA9nwJF/x3NbyNfTABPHF8lwC6cAN7MacrmnB+rEw6ckiONPoC2iJ5Z4fplLFO7NZV5RW+CFbg+2jSVDtTzSCbc+KrMbiX7K8bHIxaVsj8CiZgu19+gbhD/q3Ent/LViYAkZBkJZfv/+7afGv2kJ8gK+T45YJTuyU/xuZLjVnERuWs+vFFzcxn/BAm20ZJIcA+5vlFIebCG1cx9AHPViPHj4JwtvLB4odIThqHYDqyLurdevL7cE+HFQq65hGp5tayAb+cQP93pwfWpU624tyM4wZPcwvlcuHxoIMKmeKr8NPch97rbVIq029vzDUIXMmpED/urHUY6gX9ZxPlmTEgKq/4G0jlZMuTovyp3Y48jBi1sbFGmurd6gfFkSavxBrax91H/+JwxvJTdEIagtgEeSPoQbSN3se7Tw22+/luEdhXZ9DlhgQ63Z8fnqebwbFgqg5ZX6y+Rt/DpYijYWKLfvj9uXlXyjJ3wIvz/bos5u9bk2jsaTlF3+xiO0smTjp1pMDRYEbyPXQ+90jzgYuwe/QfP+Mv7+WDgNo9p0B2Gm9phTKxWnCOpuOczYTl2SUoEn0FUvRqf1mUkmlvNgsMLPhQYJYguX4sc6xHD7LjiORbdpnCBg7IFsxyAF4muL/l0CPilhppStCaKtmZPCnXACKd7sV42hqVh+mAm5tq8JmUXnNXoV3MUH8lGXw2DyyXVox3r9QEcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUg4SGVQWWlxUHlpTEpxeXhXcFpMZU9mTWhlTzNUY0cvbjd5NmdJby9KWXov?=
 =?utf-8?B?R0I5RTVvYXEwSkI1S0lFZnU3WGJGN3hGVGYrYThub2tjS0szeEh3LzJxV0lQ?=
 =?utf-8?B?VXh5NWdUbXNOR25mSlJCNlVaaFEyOEEyZ1liU2k4WHljZnJkMVlEbmZKTGxp?=
 =?utf-8?B?b3ZwVEw3Wm5NQlVTdjl4MldFcnhQUWhEUGtFWmRWaXZ3cE11SC9OdFVEeUpp?=
 =?utf-8?B?bGNOQmwrb1BFK0JSUWV1V3NXTm9Db3FsMU5tcVBCam55RW9vWitvMGRodGtK?=
 =?utf-8?B?V1gyVk90R0dFQW1jMmRsV1JVRXhOKzlMcGYrUVM4MW43TG05ZmVQNy9lRkZx?=
 =?utf-8?B?TERSTU9WbXo1bGd4bk5pK1gwZGxEMlcxL0xhY1padnJqc1pqMmF6RThqOHJl?=
 =?utf-8?B?QnhDd0NGZFJJOFhNekxKWjVMVzJlaE9DVXBqOVpTc0dBUDQxT0RZeEx5TXBj?=
 =?utf-8?B?TlBYbnN3alN3WjZhSGhzRzBrQkVsREMzLzRqbEFPTnV6Z0M4NExHS25ZUDhk?=
 =?utf-8?B?N3pzZEhubEN3QVBwbzV4ejBXODBxZ0cyS2dUYkdiYWVvbnlvcllhL1I4MVli?=
 =?utf-8?B?T3kyVjg3MUUvZE5pczdvY2pUK0hDVkUzRkM0amU2dDAveEVvQ3VFOXhEOFds?=
 =?utf-8?B?dmxTT3NFSGlpNDNyRDY5Vnh1bjFiVCttNnVUeURSeWQ0Q1c1K2RNcTBhYVJ5?=
 =?utf-8?B?K3NxNTJPYUc0NTVjUDJ1VUdPWFZXUE9kM1hWb2J2aUhsWTdFdFlNbnlZN0NG?=
 =?utf-8?B?UXdNZGo1aTlQT2o4V3U3Y05OajIzWjNBLzZQTkJuM0Z4UndGam5HcVFCQWxy?=
 =?utf-8?B?N1ptNzJmTlNvd01ocUx6dWxsNEVqSXFqakF1aVlSU3o4dXoyVW5yMCs0dHZ2?=
 =?utf-8?B?dVhrVGNwbDdQL2QwQ1lGUzNTYjRZN3YxYzg2cGlhNVREQWQvRkVOZlJ6VjZp?=
 =?utf-8?B?dHpZeUdVQ3lVV1RkMjM3Qi9RclNuc0x4VWhSZnVYWFU4ampUblEyenRhRGlK?=
 =?utf-8?B?aHA3elN2cTZqTUdNOFRvTGRyVjJ0T3U4eUFiUmhKSnBsVTFIV1F6b240TXRp?=
 =?utf-8?B?NGhQWjMva1pqdTlobFA5eko1Y3hkdFJSWlJCTkY3MElaQWdoMXlYU3pqbEZR?=
 =?utf-8?B?d3NLUis4MDh1amxUd3BRNnNWd1BlUWhYVnRBdU11alRqQU9IbGs4ekxHeW93?=
 =?utf-8?B?TTZDcjJFNVNKOCtYcmR4Mm1rT1QxbGJWUFhwRk1TNTkwUC9MK2NKZkZwRnlx?=
 =?utf-8?B?eGJpbFpXWjFSbzhJRTZ1QTkxSlhXTHNXRkViYzJ5TWZsQlk2TGozWjVxUzlC?=
 =?utf-8?B?T3BxazBnTDY3SmhTOVdhUmVPZjVDMUxVWElzUlczbmp5WHJhY0RVL3RCc0dn?=
 =?utf-8?B?MDZ2Mmt1SnBSYWNiNmd6ejZWci9IR3RkWDVJNEZWVDczRkY2ckdrOE8wK3Bh?=
 =?utf-8?B?ZllKWHpoS29Kd2JIMkdzMUMzLzB2TVlCcnBGVnBabXhSYzVnS3ZBREhoSDFk?=
 =?utf-8?B?RG0zSHYraXVtR0FXT3praHlyNm9XSGkvOGVKVk9mVkhYdzlhbEtxRFFOenBC?=
 =?utf-8?B?TDdpRTEvZ3JvOXo4a1pjVDB5a3pib243Sk5ZTjExcEFnZlFpTFNBL1ZKbHl5?=
 =?utf-8?B?dVdaTzNZVWdCMU9qb2oxdjIycUVEVGk1VC95TkYyaWJUVVBnM09GOEJ6SlRZ?=
 =?utf-8?B?blBDYVArY0pQVTZkQWNONDRqaWpqRnFhT0psc0pJVGptU1lMdUF0OVB5aFFN?=
 =?utf-8?B?K1EzWk1EMzc3dER3SFo2a2pEMm0vQUZXQVRKODZXSWo5ZWJGUFlXU1dXdGFw?=
 =?utf-8?B?a1lreXkxVmJzbzNNemFRNEZjdzh4cGRzSTY4WS9NQ3hsZUJERFhvWGJ2bEZ0?=
 =?utf-8?B?b3FwSG1oMjFpd2NpOVBrZVRMVzV5NlBPRnFFcWFYaklaL1JkNmRYeG9xNkR6?=
 =?utf-8?B?R05aWkR5MjNJWE16M3BSQVZuM2VNa3c3ck1GSjBoZXpaNlZqcjBtaXk1V0lK?=
 =?utf-8?B?YVNkTVFJeGtETGl3S2hHcUxCWk53cG55bStxeElTY2RheDZyVkYxQ2xBbE9x?=
 =?utf-8?B?RGNnNmNDUXZyd1doN29GNVpkOEE4QmZoSFR3VjV2Rmx2TEwreXhXblV3cnJz?=
 =?utf-8?B?d2hWUTU3b0tOZkE1N0NsMHVqMkJPY1dnbndyeDFLZko1SFVYbHNodDZhWlpm?=
 =?utf-8?B?UUJFd05xeWNkb2cwekI0dUo2VEVpU2xna2RWeEpCSVB4YXlrdFllcStYL2JI?=
 =?utf-8?B?U0hEUHVMZG50cDFVcXBSSkIva0t5Rnd6L1BkS3FkZVFvWVVnWitxbjJwVXhE?=
 =?utf-8?Q?20BgqVNn2GUzy9X7uA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14793f5e-5361-460a-7995-08dea42e0f69
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:24:47.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bKsqlos6qvI3p1LiHkd7GloXWqRwod9Q+P5MkXzrHPSjgukD4TaY8kvmc2KD6Ne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-Rspamd-Queue-Id: 6A49546E542
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241242-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]

On 4/26/26 23:52, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> Replace all BUG_ON() and BUG() assertions in the gfx_v9_0 ring
> emission paths with WARN_ON_ONCE() and graceful recovery.  Ten sites
> are converted across wait_reg_mem, gpu_early_init, parse_ind_reg_list,
> init_rlc_save_restore_list, kiq_read_clock, emit_ib_gfx,
> emit_ib_compute, emit_fence, get_wptr_compute, and set_wptr_compute.
> 
> These assertions guard conditions that are either:
> - Address alignment checks on a deprecated byte-swap encoding from
>   legacy pre-amdgpu hardware (bits [1:0] must be zero), or
> - Switch-case defaults that should be unreachable but are better
>   handled with dev_err + return -EINVAL than a kernel panic.
> 
> Several of the address alignment BUG_ON sites in the IB emission
> paths (emit_ib_gfx, emit_ib_compute) are reachable from unprivileged
> userspace via crafted DRM_IOCTL_AMDGPU_CS submissions, causing a
> fatal kernel panic in a scheduler worker thread.
> 
> For address checks, clear the reserved bits and proceed.  For
> unreachable switch defaults, log the error and return.  For the
> doorbell-only wptr paths, log with WARN_ONCE and return zero /
> no-op.  Ring emission callbacks return void, so force-aligning
> and proceeding is the accepted pattern.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.
> 
> Fixes: b1023571479020e9 ("drm/amdgpu: implement GFX 9.0 support (v2)")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 50 +++++++++++++++++----------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2eb32f92a..47e81c33d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1182,8 +1182,8 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				 WAIT_REG_MEM_FUNCTION(3) |  /* equal */
>  				 WAIT_REG_MEM_ENGINE(eng_sel)));
>  
> -	if (mem_space)
> -		BUG_ON(addr0 & 0x3); /* Dword align */
> +	if (mem_space && WARN_ON_ONCE(addr0 & 0x3))
> +		addr0 &= ~0x3; /* Force dword align */

Same comment as with the SDMA, please use only WARN_ON() and not WARN_ON_ONCE() and don't mask the bits.

>  	amdgpu_ring_write(ring, addr0);
>  	amdgpu_ring_write(ring, addr1);
>  	amdgpu_ring_write(ring, ref);
> @@ -2107,8 +2107,10 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
>  			return err;
>  		break;
>  	default:
> -		BUG();
> -		break;
> +		dev_err(adev->dev,
> +			"unsupported GFX IP version 0x%x for gfx_v9_0\n",
> +			amdgpu_ip_version(adev, GC_HWIP, 0));
> +		return -EINVAL;

Mhm, that is most likely a bad idea.

The BUG() here is perfectly justified because the system will crash later on anyway and this way we at least stop at the earliest possible time.

Regards,
Christian.

>  	}
>  
>  	adev->gfx.config.gb_addr_config = gb_addr_config;
> @@ -2808,7 +2810,8 @@ static void gfx_v9_1_parse_ind_reg_list(int *register_list_format,
>  					break;
>  			}
>  
> -			BUG_ON(idx >= unique_indirect_reg_count);
> +			if (WARN_ON_ONCE(idx >= unique_indirect_reg_count))
> +				break;
>  
>  			if (!unique_indirect_regs[idx])
>  				unique_indirect_regs[idx] = register_list_format[indirect_offset];
> @@ -2885,7 +2888,8 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
>  			}
>  		}
>  
> -		BUG_ON(j >= unique_indirect_reg_count);
> +		if (WARN_ON_ONCE(j >= unique_indirect_reg_count))
> +			break;
>  
>  		i++;
>  	}
> @@ -4209,7 +4213,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>  	struct amdgpu_ring *ring = &kiq->ring;
>  
> -	BUG_ON(!ring->funcs->emit_rreg);
> +	if (WARN_ON_ONCE(!ring->funcs->emit_rreg))
> +		return 0;
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  	if (amdgpu_device_wb_get(adev, &reg_val_offs)) {
> @@ -5431,7 +5436,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  	}
>  
>  	amdgpu_ring_write(ring, header);
> -	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> +	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
> +		ib->gpu_addr &= ~0x3ULL;
>  	amdgpu_ring_write(ring,
>  #ifdef __BIG_ENDIAN
>  		(2 << 0) |
> @@ -5527,7 +5533,8 @@ static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>  	}
>  
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
> -	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> +	if (WARN_ON_ONCE(ib->gpu_addr & 0x3)) /* Dword align */
> +		ib->gpu_addr &= ~0x3ULL;
>  	amdgpu_ring_write(ring,
>  #ifdef __BIG_ENDIAN
>  				(2 << 0) |
> @@ -5567,10 +5574,13 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  	 * the address should be Qword aligned if 64bit write, Dword
>  	 * aligned if only send 32bit data low (discard data high)
>  	 */
> -	if (write64bit)
> -		BUG_ON(addr & 0x7);
> -	else
> -		BUG_ON(addr & 0x3);
> +	if (write64bit) {
> +		if (WARN_ON_ONCE(addr & 0x7))
> +			addr &= ~0x7ULL;
> +	} else {
> +		if (WARN_ON_ONCE(addr & 0x3))
> +			addr &= ~0x3ULL;
> +	}
>  	amdgpu_ring_write(ring, lower_32_bits(addr));
>  	amdgpu_ring_write(ring, upper_32_bits(addr));
>  	amdgpu_ring_write(ring, lower_32_bits(seq));
> @@ -5639,10 +5649,13 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>  	u64 wptr;
>  
>  	/* XXX check if swapping is necessary on BE */
> -	if (ring->use_doorbell)
> +	if (ring->use_doorbell) {
>  		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> -	else
> -		BUG();
> +	} else {
> +		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, only doorbell method supported on gfx9\n",
> +			  ring->name);
> +		wptr = 0;
> +	}
>  	return wptr;
>  }
>  
> @@ -5654,8 +5667,9 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>  	if (ring->use_doorbell) {
>  		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
>  		WDOORBELL64(ring->doorbell_index, ring->wptr);
> -	} else{
> -		BUG(); /* only DOORBELL method supported on gfx9 now */
> +	} else {
> +		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, only doorbell method supported on gfx9\n",
> +			  ring->name);
>  	}
>  }
>  


