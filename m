Return-Path: <stable+bounces-249477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEVIDBcMDGo5UQUAu9opvQ
	(envelope-from <stable+bounces-249477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:07:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1D578A36
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62F03306C4E3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7633B3891;
	Tue, 19 May 2026 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOWdhYy8"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED93ACA7C;
	Tue, 19 May 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174122; cv=fail; b=Eh0kAaZMTLGPYtOR/A4i943uKATTDDf1qRtIGA5eQLtkm67wQSs+PH/nnrdsEqjP3cjqa/C4qYxJ4dhhts0865HnkUutEmZpOiWy2x3p+nDMsvWDiiiyM9xYyD3UfAUvs93uGwjPoA1umaeL4Fg86dYhFgIC6py03bYBCCZMPHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174122; c=relaxed/simple;
	bh=H7MUvaHC16h5xtxaYDYzerNY7e14Lh7au+BUP4OVJac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IJjy/UkoZWQ4gvEDP3jxBcoC0fe6QASU048cTQzSoM6gkxhZkEwoji4bceY9L7qC8cJtZiq7kyXJ4Oi8Ina7I3XZWFuSh4CFHHSY210bJ0ZUjORVbQAwXo2DB6ktkJeLL7p2h+iS4KAm2vrKW0bNrjibKdm1MaKYygFehitbBj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOWdhYy8; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOzVogwtQKZl53onJhVp3WPM1c11XUW7pPpD6qk4zxn8o+Riym0ZmRKdQ39BY7qGhxWglPBLusLCYkyBJmKn725wl8+XSZqYfN9sP5TTmCKgHv8r03WQqduuZAxgd4RknwkxQ/Z0g/jW8gA2vGM/gOMKqO/9eKACrUaDi/E6rhK3wmwH36tzGX6EChfkCGVJIy93SPRz3HoGuaqkViuu18YkiPKJgImhXnNdko26PHIUfH4Drv6D0iCFsxsY68Km8qNriPtSeTpfPWGJrcYXga3GKYQWklSSotIFTJJ+nMKyanFtvuH46vxuap+LeswlgbomMu9oQ22+TmYJCUp1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh6f9uTVcHBbdoehvdvVz6yfAR2tEOWyN15RuUlAcg4=;
 b=dUrulDH1tHXDb26Z/V0qt2cBRXtzGp1qPG48Apj9H0aySzerEMBw/TT5ZRyD8MjpFujODuW2hVeLqstUplikjIrA9YgpHnQU8JFzUwPXadCXFyupYrpsPv/yKHyq9RK/+1ilaDpdTi78NwduIWqCpKHwqJTi+xocSr8RHoniAumVV1xprVRfN1bsFUnoNdMtJN7pH7sLFG0boLvxP/Hder4RY+ezr2efTlxqopTuDM4RmIvj/RhWVW4owgT3s/w4cACfraWEqC/Ac/7mhXZirJnP9OGGRi7wzW4eDfqeBA/Uq5izRR52m+mWXESBcysTdIVl9IWXNnb6DMUmZfJXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh6f9uTVcHBbdoehvdvVz6yfAR2tEOWyN15RuUlAcg4=;
 b=FOWdhYy89hDpcMwDegysfJOqA6a4g/bjs7u5KB7EZoqPH97KdAyd1vYMToUlmWunVx3o29Ri+SPBKEgYnq0FI/czbaTM62y/0xLuL3fIjPVxXDmxWjppT0qszfT6cUSg4oXwBO8SXiDlu7jiDxfYJu9W8ucMqBM6PhH5r1rWzUN2ztcM8fr/qLpj7PCDuzMy2WoJthDUJ9LXjvCoB3uPyPt4llKQIG5szFniMrHXg04KFGM6mg4vHomrWv9TIRmgEd9wUzCZs2XWseJkniDryiDAKU/eMmavsjZg+Og1FIRA+tlzXDFqN4mqSkZhDN8N53SwPShxw+3QXrg4GWeXmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 07:01:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 07:01:55 +0000
Date: Tue, 19 May 2026 10:01:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: ioam: add NULL check for idev in
 ipv6_hop_ioam()
Message-ID: <20260519070144.GA376075@shredder>
References: <20260517183059.29140-1-justin.iurman@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517183059.29140-1-justin.iurman@gmail.com>
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3a1ac8-93d7-4eda-f717-08deb57482b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	1Y29KuzScgPterEJsczzKlcpNKla3E3k9/wCNUKhcs93NaWV18wR3znRQULV1OjjW2pGdrLVRCPQtt8gWQE23vBjQEoInjKbv6eY5CG3xTU8wR/45HO0Sskliw/8BpZzlVDkqJ46agA2cokPFCnynoX+LACkng1yyk5Chl20bQWaPIx/c5OoecflvVNrxBMBJ1vG8MJ2hqP8LRtBmzQebtrOog1Oa8FnRoWc5UtUFHlBHVL8K2P9hyiupWaKyX18ReROPq6GUi3GWAaOplAIhpFTu2Ioa23EHfjnP8vtVKp9Fiqf2MdW6qYUTumh/InXkqqebCWNfy3KCedstTaEsVbT9sFetszQU1qCjUQi0tXDFX9gafVA6RDlirzq/3uv47oeqi6VtY4TxK7LIVOaP8bY/8cttI3CsFXHMUYAgp9w6eD1g3C+oL2eqjx2KSGqXAkKC/ZZcOPz9Oc+IjmRjNZCnjV6op8LcZ/k2QV5pPIRZmBds23OpgLzrzbDoDNVxo4QtG/48WewJfdGqaQsIRFqv/CiAzB+6bUFWfvEdZ67zTr6SSUwfgTP39SwsfIHiEUP00Y9BXWDCnU+0I5zRz+Zxt5gK+qUC80DnXKreV2lS2x4TryPi3KhzXAAN9Mmcv/0+oAatdwwtWm5lYFmVuXUwK7aRz+lcDQ6V/pInc1etUOn9jgaY1rdPO5E+o+3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MG7RW+h+kM4U2C3lxuGctDsKKPWo30w6S7PCS7wnxdtlmz33CO9Aij9rTS/B?=
 =?us-ascii?Q?K+oFSyMCiHKMkU5YQPp9eJ8gHdETOb9F1A8ePmRJTXGvRpzXx3uB6nz9HrKx?=
 =?us-ascii?Q?8uBTLmJZVVGIhZXGJWLbaCXu97VMG7LXUmwA7eArrwIl6+VKLxxIKWKdAh4O?=
 =?us-ascii?Q?CY709sC+MuDlzY9dHO7l4jONiAFQBykEC3c1cgJbgEIsDDAzpIEVqOQ3mM1r?=
 =?us-ascii?Q?kfsdXr92Cob/XGvqI9R+bUPmmuxLO0rIkOg+XTaJmwY+WFLEfjnTOR9Da5kj?=
 =?us-ascii?Q?zR9x8XEcTpdUQc8mI9ZVUT1F15aAUZDp9pincxj/txSGfLykVZDzMZQ+pQxF?=
 =?us-ascii?Q?A5noJF98k17ml217A0bqBTjz1Wpc2eqsy8E+ggCeQarEXlaDSJT/+3MIVZWF?=
 =?us-ascii?Q?NIrDgBoqSQDr9fh6s2QpMJ4OUUqrv/ZIBM6KcMySjDLYus2HSO/hy876upqg?=
 =?us-ascii?Q?6poQTT3WzRbDkgF0dnkVtN7Nnj0LoftWFhou8EAl6ockX3M+XlO9LEMG46zJ?=
 =?us-ascii?Q?XwsiANQPau+VsELFxRVI73Szq1YLaLRsuGqJNZD+nbtrrZyVWeLOVYt/qzy+?=
 =?us-ascii?Q?fdXU/adDD0Jq7R3xB1NMWt0vV4nfgTTeQMa7O8d/c2Q8pN6ozqnTxvWIwAHp?=
 =?us-ascii?Q?bqItmf+GxCwW+uOiI3YiLd9cNQ1UTIiHWl90gdU72NU/wexsV7fK7U3h7xKw?=
 =?us-ascii?Q?eKv7Ql63zSbMdewd+zGvX9I4xaxUwSSU5Di5ghMTnK+2yFCKoJY6bQir7vh9?=
 =?us-ascii?Q?gLQPpcOCtpuCHs2WA2BRT181j64z5g4ypXAjIDrs1aplDjhqhcdQbobBvlfe?=
 =?us-ascii?Q?YoaOK78DAtjVLppykYx4rRSXBeg0rYDSdhFvcCiX1ugossbYsoctOVWGHmhK?=
 =?us-ascii?Q?vN4SHMrI++lO1AUstJCuStL/FXEMcI0ENgRJqVHRpVWO2xeMaYCplcvn5FsX?=
 =?us-ascii?Q?x5/lCqmBsVh1yxuhF83R7qe5+P8gN5Ib05DWLL48oTHMJP7R3B27vcWs7+Fn?=
 =?us-ascii?Q?BVc7pr3p36Q+RHoL/9R40Fr92D8xX0QwpvFslfo75nSbqxH8dZwxVQSYIEeQ?=
 =?us-ascii?Q?kRkzKl9mocqoI/g2FAhASwrtecOEPn23PWJcZciBGCYTyliyfc5RYYDiWLbU?=
 =?us-ascii?Q?FMM1vEroPtbiKf0VCqwFcRBM87IpweRxrZMXo7FKVLRL5NsgeCZE4Zl2Fnzx?=
 =?us-ascii?Q?RMLOPNrTYGyiw+AXrBwqzS06yOTmGRVUzpHtLwmAyOOc0kBkF80X2bsDqCpk?=
 =?us-ascii?Q?3KhjnecFdooNVNDkUju+wtWR/VLMu6+vOY9lnIfGfU5x1/iiz1xOKzKsvnjO?=
 =?us-ascii?Q?JQ41fsHK4aQolWsTrcDijhzV6/9XDRuBh1EBfMLZprBSbShVTJ1CZzuob67K?=
 =?us-ascii?Q?kyGgDt7bWQ/G87HiYo8JF7yLfnLegLY+vnz+beIoVkwDxXav9za3jNugwFkm?=
 =?us-ascii?Q?mE9yKpTHKD51bVEtp1HnvUsL+x/fkv6dZF5go7pYNWyvMzW7Og6z99EU6/nP?=
 =?us-ascii?Q?1BSU2nsZiBIk6ZFsltsZs0ZOcO3WTtoHyzdjtwrnq4GJ4vBN477FU6YsOu50?=
 =?us-ascii?Q?wnfQUL2PcTeNDOIGf6fQ994j0zo4iyUGpVOEPwqjBxR52XE3g+qJV50QlduF?=
 =?us-ascii?Q?Ca/N0fR73ObmZCx3m3KwEcrVaHAcELPwLQH9w4qxRIGUv54B9dwSzNPRGAGq?=
 =?us-ascii?Q?bsIsFICOoaKuw8tcU5sV9XA6/dSrKMGD2XzPTD6iH87H2NEg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3a1ac8-93d7-4eda-f717-08deb57482b1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:01:54.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip4Ls15hGLRWZ7UXjNbKyOmgxjk2n5QdVVrui1sNiqjBUbHx0RwHUh0VM3ezyxBnR0yqpDJuyFvkMHJqY5esWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249477-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: B2E1D578A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 08:30:59PM +0200, Justin Iurman wrote:
> Reported by Sashiko:
> 
> The function ipv6_hop_ioam() accesses
> __in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
> idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
> via RCU, __in6_dev_get() can return NULL during interface teardown, which
> could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
> option.
> 
> Let's add a check and use SKB_DROP_REASON_IPV6DISABLED accordingly.
> 
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Note that Sashiko points out another pre-existing issue that looks
valid:

"
This problem wasn't introduced by this patch, but pre-exists in the
ipv6_hop_ioam() function. Is it possible for hdr->opt_len to be read after
the underlying buffer has been freed?

The hdr pointer is initialized to point into the skb's linear data buffer.
Later, the code calls skb_ensure_writable(), which might reallocate the buffer:

	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
		goto drop;

	/* Trace pointer may have changed */
	trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
					   + optoff + sizeof(*hdr));

	ioam6_fill_trace_data(skb, ns, trace, true);

	ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
		    GFP_ATOMIC, (void *)trace, hdr->opt_len - 2);

If the skb is cloned or lacks sufficient linear headroom, skb_ensure_writable()
will invoke pskb_expand_head(), which reallocates the skb's data buffer and
frees the old one, invalidating pointers to it.

While the code recalculates the trace pointer immediately after the call to
skb_ensure_writable(), it fails to recalculate the hdr pointer.

Could the subsequent read of hdr->opt_len in ioam6_event() result in a
use-after-free read, potentially leading to an out-of-bounds read and kernel
memory information leak since the length controls how many bytes are copied
into a Netlink message?
"

