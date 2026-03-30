Return-Path: <stable+bounces-231259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DE2Bjq0ymmE/QUAu9opvQ
	(envelope-from <stable+bounces-231259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:34:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539C35F552
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5F330470D5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4C37C0FC;
	Mon, 30 Mar 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nRPNRrvg"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1537756C
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891990; cv=fail; b=mJRD6iv+5IzXof7cp98O/gYiNIJ1Q1UJKjj7KzwgJvvraGwWLnCTTzCxKOzD9xvNhRNUHbTC3zlh+7WPM1iDmUAaUt8+xgnkRcs3BeBbMvcaXH8w2J2f9Hf2H3W0uQbsFmL86WplTMTNTceBiEsTHfBESV/LJ/yZYtlngNqsinw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891990; c=relaxed/simple;
	bh=t2mJJu9BHDh+581rSu4fqcoCrn21Odm+NaCtH/3cuP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HM2rMeA16YcTc2BYe+SZcIcf/YTiIpZRn8BlCgNxbx0vThXqStUkH4/ak/XMbHOAS2XxC3xxSOUxGBJdFJ80A2Qk5KPBDJemGpQAotvwStTG+xq5NsN66jflc8Jghw3i2PtWFi8jft1y4R0kI+C+h2LD9VzRWsfMgaARloOWqyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nRPNRrvg; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEe/oebLxXYZyHP9/b10j4m2n81u5y9tGyCVJaMW6NvlC+kXKq6+g4PFnsnbB2umgyprMWA5F7PausdE0UYqIrBuHjJP/HueFBtILvgccJWiSxwjrFSfFf4KhTRkvlMK6WeYtlKZKBh6UO7e5gzzn1dSJ7sVlaUUVd9JtEl6IYVISNWqub9FqwoKrokECXB7vh7ObUe7zn5z3NN3JeAqdzxoerKJTEvRYDn4Ujuiyda7gS1UBqRYhRrDgbPDpGx7Z9RGlcsypGEZVhLbBrI9L0rmEqh7XE4K3cJcMwwgf7INzM4y5Pmh6bOsfzFGFUu3+0snEGhFeyYYzfC8n+LGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AUiNbPgAVIsThPBGlE6dvPHj3nM0x2QKDI2NwNsm/w=;
 b=rQFoEGsBjztAySj0fD/SRX9H1cQTzrh+SAtSTcidffAom2u4fL/nhIvbx4/0usZximQ5srR/Y06qdtOldVhWppdrrc3s0hBEax4GDnDRimpGMGYixmxiVKLG24DzcA0eOs6xaC5eFSJboKI0ThxKxmSkmk80Jv3ocGTWMcypWPxba4Y+oYLiyFLMxXXuc+SWOp6ZYo3pZSKtZL5/GVMf2lquinsR5Y/3A6O6ptANXcr9MVXP6OF7yBjA1Fex9EfmmJOIVviTdRav0sk91gGSiURtRXOEpAvFJ1o0evpjGt0nf0cfII4/wG8KMAltcjdsGEkLD0stoLpJIvpI/IaRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AUiNbPgAVIsThPBGlE6dvPHj3nM0x2QKDI2NwNsm/w=;
 b=nRPNRrvgX39086JmMK8/deBqscdNF4c7Fl2zX4PUYibHYlULAQZYdiihSZj6YtZNbue/a/J3rMbbMknYxiummsB975IPN2JzUv35kifiarMvFG3uccPXiAfWTrjM4zirpNCxv4F59aXi5ZzUisEFP+OX6GxlTpiqnDrtAQN2o2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:33:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:33:04 +0000
Message-ID: <d05a9c56-5248-462f-96b5-44ad167f284a@amd.com>
Date: Mon, 30 Mar 2026 23:02:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: df9d6451-d972-4a06-ff56-08de8e826612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DXPHs48bh92dhJcPzL6FaB3Xq2xCzlpK2jnaOU2BvsUTnbImJZLctogHW84+qVMT3bCCr7LRPgfPw2rB+eWLwJcb4rlp/tHBVLuxqUAE7+4FXznY2DL4dQsZZcfx7/j6D3dhTqn5uo/yxp/F7poZ39saJOjqJugUejjPvkSiBI0/E8c0rpjRXynMS4R/OGhIAT/0LmIXJByLNNf226PJGlBJLtn53RSt+rieq4GbbOqiP1Gg1W9a80oFmwu1NIyhIEopyvL2ZQbUj2jt+Hq+bMzyeahDSR0i1QBDF5eARWMJTDjDQvNjNw43twiJCLx1s7rWfK/3IS4CCK2QLr8zCRCtaalAwR05j/y1CY4UuW1YSW+QsFRugsOHklpSeiqHV/WcKHu63o1FeKDDlEGaLcCUrFafd1VcxnEXSArw67v7Ddln1422HtKRcrjAPlm+4OhWrQEClmNAPJdK72PDj739DL8nkEml5PcnSVPGEbAHTURyVb1Yl2KZMxZ/V09BBa9c9qyRBlilMiUIsPAgYKr5kc4a2dPhrIZ96sb4XumGXBcO6n/xPKdjfkfYGZaAm+szKJ+7DjrVYnMSWVAV0/SHgS3u1c++A05c665CAfsPG5zUryP2uuopCFi2UJNJHOFRtahGDBmVz3RzIXuz7Qo3NZFJesRkimm7uwPcnANAzmMaY0uBjsqXYS7k6DO/MjGXjc3yBC7vfiebSYX8eM/Er/HjnyHF5eBL9UUrKXTMyjqvvYtBd1jPVLHumG4e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c21iTnFkVzU0d2J2WFl1K2RhZGtJUDVOZzVydFNwM2J1TVJBb2phTXQvTW5W?=
 =?utf-8?B?WTNwYzBGekxQdmZ3cGxDMnBqWkE3bExZWW9MaGZScXV1Uks3dGIvaWxLTXM1?=
 =?utf-8?B?VFFxVmxqUFRaWHJCMzdKVVJFLzkrQ3YrQWI4U2tMSnlUOUdLS0g5cTN1ZkZU?=
 =?utf-8?B?SVpBNWxacG5SSHhqK2V4V1BGY1J3UWFTaHAxNDJnSEtKVmg3Q3Z1NGFDYWlY?=
 =?utf-8?B?SmtQRkpmNldHV0gvZHhwZFpkNStTMDBCdVJjdUtWUjJ4NTZ3WnJCejR4b1Rx?=
 =?utf-8?B?UkR5WDJId1R4bVFmajRqWUh1QUcvNnd2Q1l2VHZyRjlFVUl5Vnl2MnNYMzhX?=
 =?utf-8?B?Vy93cS9wUW9JOVZpZEhPc1RXMDl1MTVtKzF6dnNBQjBPNzh1N2RUK2Ztc2JX?=
 =?utf-8?B?VDVDVlIxdFFOeVZJVlpNRlE1KytXZkpmM0VnNlNBWlVYbG84WVA0cWFsOEdt?=
 =?utf-8?B?MGlyY2laZlFQQXJ4Y1VCQlo0a1V4dm44TXRrU3JhR1BMV21DbWVUYlZBM1pF?=
 =?utf-8?B?Y1lZZ0t2OGNuQlRTaGtOWEZmUTZvSml0RlZqS0RTeHZoWTd6ZjM4R0E4elBN?=
 =?utf-8?B?cEFIUi9nNzYxVmxMUGVMQUVaZktWeGlTcVo3NEZzbmN4N2hKK0VpcmgzbDdm?=
 =?utf-8?B?ZWp6bG1wci91YkNYK3RzcUptbzJ1OVZrZmQwOC9VWGlONlBzN3dzcEo5ZENH?=
 =?utf-8?B?UWpqU0RCWWwwRnFrYXVwQzcwb0k4S1BZdnBnc0pmSktHWUt2Vm5DTm5HSHVk?=
 =?utf-8?B?VzRYMllJWFRhK0Y0QlZkbUM4OXA5UW9rM1VrSmp1S1kzVEYzSUxOQndIR2NE?=
 =?utf-8?B?WXBwRHgwSEVmVHpnVEM1WldoNFNJN2Flazg3TS9mMmdsbVg1Q1VXMjZCWC96?=
 =?utf-8?B?aVFva2FtU3A4UHI0OEY0QVJVV3dha0Rxait5WEMzbkMyM3c4QTFMOUp1WEVp?=
 =?utf-8?B?OHd4OUtCamREcnM5M0dCOHptMFVJN1Rjd1NwWHdpWituS2k2UGF0RlJUOVUy?=
 =?utf-8?B?MVV3QlFSc2xFRm9SZGVBNHVoVERLV21RSXRHdVJvcUgyVWFCV3lDNFdsU2V1?=
 =?utf-8?B?R0JMU0c4NkNabEdPb3ZNZ29LQ2p4UWNTYnBXTWZ3bkxYVnpIWWlMcnFvcHJ3?=
 =?utf-8?B?WDFzbi9ZbWR2TGpHSHN1aTlBdUN5K1dwcHJVVkFWRUFkQ2hlMnlibkNxT1J5?=
 =?utf-8?B?TE1kRlk1K2wzbzJwNVMxRlVwcTRTNWIzRGpEcTB5dXN1M3p5N1F3aHRybVN5?=
 =?utf-8?B?RTcwdWpFNWc0K2hwTVBWN2pISTZqclMxVHVza2ttU2FGeTR0dERCRVUzNjNj?=
 =?utf-8?B?V2VadHNiaVFwN080Q2FyeURyQ1BuKzlhR3IwcUJ5djI0ZDh3Tkt5bFhXTk1S?=
 =?utf-8?B?aGNTcTdvMEg0aXcvbVdjTlU2KzkyVHBvWnV6Vm1SUEN4VUVzait1cDNIVnk5?=
 =?utf-8?B?WDYwa0RGSnJzSC9jQXFURUgvZFg1Q0oyZ0N1dnROY3FUSElUUkQ1Rk5BMnFv?=
 =?utf-8?B?VXc0dXlYOWFIak1pbHNZbjRnb25QNnBzTHM1SjhLb2VRZ0x2S20yejRjNDB4?=
 =?utf-8?B?VXVTMUU1dHl5NVFhSnRxaVdESmVWVFNsaC9Rc1JsajZyVFp3WmZUQ25QS0dH?=
 =?utf-8?B?UlRVdGZpRHh3NlVyRk96UkpMWW1IQXVDVis1b1VxQ3RNQVdPYW05SGR3Q1h6?=
 =?utf-8?B?c0Zic3M2MnlqNGJYbkhFNEM0VE8vZkR4Zk5FN0RDQUYwaHd2d1NLSkZEc1BR?=
 =?utf-8?B?US85QjNYWWJpVmpOdXZreTZ2YmVLcnMwMi9SYmZ5NE1Gb1hQTU5lVi9tVFpp?=
 =?utf-8?B?OFk3bmVDdGpacFd4NDRwdjVPTUdHT21nUTR6Q3Fub0NsbFFORXFKY3R6WDFo?=
 =?utf-8?B?N2pRZ0JWaCswd2tmSVYvWGZoS0Jad0l2ZUZ6eE1BWVVwN0o0bWFLdlZIazdr?=
 =?utf-8?B?d1p0S212NlhCbnl0WnREWWhlNEk4TVVmYzdxVkF1M0xubTdURXVJem9lMk9t?=
 =?utf-8?B?ejN2LzFXMVhNQzMvTkVzQ1FtWjRlM3lBS0pHU2VScEpidGFja1U1YmdyVFlo?=
 =?utf-8?B?c1dFTS91cHl3R1h3d2x4dkxrVWRVVC8zN1IvYk5Wc0xXRy9FT2duZ2orRmhz?=
 =?utf-8?B?bmxGU0N3bUgzN2grVVhlMVFGdlFmbDlJR3ZQSmcyaWhKZ2hYTlVnVk0zRlUx?=
 =?utf-8?B?WFNtTklYN3gwdXNOY0pwMllMaWFCYzRrazV6SU51Rm9iSS95RGtEVUdJQUtD?=
 =?utf-8?B?K3d0MEdFYVN3Y3VLWUhVdjREN2s3M2hIZzNvclNXWkFLZWVVRUtpc0FrTXI5?=
 =?utf-8?Q?u5QbU/jlFBmD5+3y2Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9d6451-d972-4a06-ff56-08de8e826612
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:33:04.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4qGojijs+geLiiyl7HPwJNoYss5bfmolTxXPKEwCWzliG6/Ssi81DVbs+1c3c7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231259-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5539C35F552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 30-Mar-26 8:20 PM, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
> 
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>     which can sleep.
> 
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>     fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>     with plain spin_lock() in process context, creating a potential
>     deadlock:
> 
>       CPU0
>       ----
>       spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>       <Interrupt>
>         spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>     The hardirq call chain is:
> 
>       sdma_v6_0_process_trap_irq
>        -> amdgpu_fence_process
>         -> dma_fence_signal
>          -> drm_sched_job_done
>           -> dma_fence_signal
>            -> amdgpu_pasid_free_cb
>             -> amdgpu_pasid_free
> 
>     This was observed on an RX 7900 XTX when exiting a Vulkan game
>     running under Proton/Wine, which triggers the fence callback path
>     during VM teardown.
> 
> Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
> GFP_KERNEL pre-allocation and IRQ-safe locking internally, and
> xa_erase() is already IRQ-safe, so no explicit locking is needed.
> This fixes both bugs in a single, cleaner conversion.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>      xa_lock_irqsave, as suggested by Lijo Lazar.

Sorry, I didn't mean to confuse. In v3, was only talking about 
alloc_cyclic call.

As per the call trace posted, amdgpu_pasid_free() has a chance to be 
called from irq context and that may still use irq save/restore 
approach. Eric/Christian, could you confirm?

Thanks,
Lijo

> v3: Replace IDR with XArray instead of fixing the spinlock, as
>      suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>      lock inconsistency (spin_lock -> spin_lock_irqsave).
>      https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>      using idr_preload/GFP_NOWAIT.
>      https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 43 +++++++++++--------------
>   1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..2b63b54eaaa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>    */
>   #include "amdgpu_ids.h"
>   
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/dma-fence-array.h>
>   
>   
> @@ -35,13 +35,13 @@
>    * PASIDs are global address space identifiers that can be shared
>    * between the GPU, an IOMMU and the driver. VMs on different devices
>    * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>    */
>   
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
> +static u32 amdgpu_pasid_xa_next;
>   
>   /* Helper to free pasid from a fence callback */
>   struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>    * amdgpu_pasid_alloc - Allocate a PASID
>    * @bits: Maximum width of the PASID in bits, must be at least 1
>    *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>    *
>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
>    */
>   int amdgpu_pasid_alloc(unsigned int bits)
>   {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>   
>   	if (bits == 0)
>   		return -EINVAL;
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>   
> -	if (pasid >= 0)
> +	if (r >= 0) {
>   		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>   
> -	return pasid;
> +	return r;
>   }
>   
>   /**
> @@ -86,9 +87,7 @@ void amdgpu_pasid_free(u32 pasid)
>   {
>   	trace_amdgpu_pasid_freed(pasid);
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_erase(&amdgpu_pasid_xa, pasid);
>   }
>   
>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +624,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> - *
> - * Cleanup the IDR allocator.
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>    */
>   void amdgpu_pasid_mgr_cleanup(void)
>   {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>   }


