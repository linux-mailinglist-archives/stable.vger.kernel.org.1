Return-Path: <stable+bounces-253377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJDwFGAUDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-253377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:06:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241859925A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F8F130465CB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467634F26F;
	Wed, 20 May 2026 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmYhz8hU"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746C3431E7;
	Wed, 20 May 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307610; cv=fail; b=ETvMOYOLTEPp2tGmk+UkxBB/wlUX+rPTzjHS/8WWK8PsT/Dtl5T4/Hd0+wuFOE2OjTx6r+9bCh5XD+59f350uE3ncT1rpsBQ58AuaoNa6jIwFp+QgkF/uxvpsFt14KMDLJ+o++WA2I9IjQfj7VTUm/8lYS0eEmCayc5dJ39DlXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307610; c=relaxed/simple;
	bh=oQ4Zo+kVD+LVcvQFB+oiWxz5tnlbkJY0mpdIkhMLdyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZAqjYcEVaaUIFk782E0Xe2AYD7HdMVVwc0Yck4QIa5Zoxuiw0pCZ8QolUUzXuYu4ZXaIuhpvm6ilQkVF3HIgAM/tYvHg11kELQjxnOMZ+0sheSYk1zae98NitoNCpTHnZGyurJFHgdI36HQOixbuPLKPUuNWG4Doa++XB/VUqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmYhz8hU; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxMlS0O+LTjJrKF/qvaNdvzPvQuFUvaY4FPAuAaXTr4icTNeV7GGnAYbtSpvlcqe70ejIVCXFSLRjiCGrLmzFkhbL6N4HkyAGjEu/b7HZ5tqNOl/hU7rMMJ9PPjL5mLxpWF4iJEYO2siZTLMdBf6V4KdZw2NiJ+Bc+2RH8a+SZRGOs3uXZf+736teB13AapZIF/W6D7XBJSz4YRw+VMFWI8a76JdiIoLCP75yEhd6ZktOXSI11sxE9lRg1BwYvCdP9ztTDs9t2EoUwA5J8YuPz0NfB0tHaTcpHzTwPtKbVDw9UsPg66gP+nYR3VA9zs8dlYKHv3wH0mnsiu6h11Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxGJt7Pk5nQ33hrjVRUhs6kxzJEQNHshxohBv/KdHnk=;
 b=QLYgmRxYzm7+vId4LUiJsEyK5d3JGwW2ng7WdZ+jec5Z1LBfbOFUNek1+Wj2BvA+2KUbX5SIimE4Nd79Gb7bu0P/kOOLNeHWqKDEfBb7Bok3D7pd3lpgScLYi/AFXJ+up6EQA+z0rK/3M8NjylsA9xWh06DugN/irdhIqiUJaCk0V6Tx1d6OpXzaGVDP0qfQEyOOqi4U0eTftGloGpxYZDVvdZeg2eZcYTLY2xlf/IjVKXGQ8zXIc0Ia7WMfdpT99fZU4AqFnHgH9Bpyl+xOqu1svP8k/ELmNZILcuUyfF8ibZZPEY/vyva0E8BkQihtFJrbiCRkGF9MmVdjcfbhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxGJt7Pk5nQ33hrjVRUhs6kxzJEQNHshxohBv/KdHnk=;
 b=CmYhz8hUZF48H3GdOie0PyndohNco+RWxgNBLBdijMCfRl+8q6pRj5+bEeEHXaiObh+enJ8xmHBrT8z7heJPvqK/ObKqP5tUE1PZVbDfzfVtD0vMO7Bptx2e8zVOXjCues6+OT0Mszhi4Qb3kYu1LZm3JiyWGwrAranqLt7VAkd9mhZ/ofpVPTBAS1Einyjq1g7+WFZ+D06IunMdXljdMgNcF2kz18wTEDDwAmb0YZcEHUCf4zhsqtX0IKsIZcOGxaigFe5+lDR7LFeg56hkkE90auKiu3v2qYlZG1+ZmPQqLMzdIY4LsaQJco0kSTtyaOWaCm1FLZRUWUaCFvwdSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 20:06:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 20:06:45 +0000
Date: Wed, 20 May 2026 23:06:32 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: ioam: refresh hdr pointer before ioam6_event()
Message-ID: <20260520200632.GB738586@shredder>
References: <20260520124242.32320-1-justin.iurman@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520124242.32320-1-justin.iurman@gmail.com>
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ffa4f8-baaf-44bd-8b80-08deb6ab50e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	xjoxx8kDkMzqlCE/mUVPx7I/D5nsR8MvMH6AGzw6zZbj4IWGyMoevhUyo6jQwjQM3jIpYG1Lrxe8S8moKoCUUvpQhJ7YW9qUZRzbf0kvy/pl98ybwo/fOpfEzXl1LU548H64PISF8sSAP2LF73c7CevJLv+RPraUNFUfykqtrsO7m8DtzCv10tJcNOFW/+C4VnrTicPkx5JZhm1gIQmcHBDSoE8ICjdaLFf4727kCR8zRHnGXEV1Ap+zz6SPzKGWuz1fnTbO9psjZ0bR31AqB0eDCDq5mOOgUP5f9HwHmF/9RWNlKr/1Ra4Y2Fo7RxdqoDGNgMQ4AvK/nFoI4gYZmJHF+qZLXdIaXGKEe9DBummx95b8wsWG7qmlbFRvmMSWHU+fHQFImok3qsNnPAyLTeCbNcyR9imjpeX5iby1JW+xbWs3boFS0T4ZSSBiEsXoBoDxOokcpWdUpW5YAPu4wGItiEg5e+4wDQhMFw9hlsZmKY0ssmgEThChzbutxHXiLLEWqnNKD0ZCSr1IkX4ENPutEw6VDemwKsM09Pz0dUX2OGEVxJ2/ZpS+Sxe9kEA8EoOVft/QBYdhCPH3ijumuiVU6iEbMC1PzPb2BYXxxL3IRLA8iuLK3bXoUcNti8tVMS9EGxbs/jco8JQX06PWLFhLpf6bzpJ756zqxRLSEeWfX/+4JQIueIe0iDrGP23A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9H11yvwt/5guk12v8hKu/1WAp24YLJKV51M9P3FhM+YRLbajjsefK/D+TxU?=
 =?us-ascii?Q?nyqhU4i8p1L0iuhWF5vU8TJkZepAYHZwKz3luJyvfbFIfmzoZG7gz25exwVJ?=
 =?us-ascii?Q?+k9AamELzISNe/5Bi4VS9qT/5wGeK+Vps0a6l5vVDcgKTxDeDsCUY2KSXZQy?=
 =?us-ascii?Q?IEPatZ2II7tew9+norVpFS2HSrgqRoeFvh4XT6501ZMTU3dzEldz0ftZVr7T?=
 =?us-ascii?Q?V+K+COTiowCuIldIx0T0h+BIfZiSOBfNHe2w6sucvWemCil8quZMGRbMeM4c?=
 =?us-ascii?Q?LR5QUIrzCqTErbhRG9fl9ubkhPzXwNgD4GGqC6s3HPG6WYcNDs1/g6ffdQaP?=
 =?us-ascii?Q?O9IUADiSOOpnq4TGlz5dDZsPidRvtMQ6E1g1PGzdUaz0LaqXDC7ZkyLGmZsy?=
 =?us-ascii?Q?oGdR6ChknjsXWi6d1oew9cyv05O8fRg+qnxfsl2mlpR+vNh6PpUTETqOHgMe?=
 =?us-ascii?Q?wgpMkz3mr0gpK3v2HLgma0Wwc9Vjhzbu2ZqDplFSzYcoDH5Be+h+qzpENXv0?=
 =?us-ascii?Q?27HjUvaHZ1B3sXLqqOn14umEoaBVgWMD6gP9+wacBpZd4NLXajr4/Tm9bJBX?=
 =?us-ascii?Q?CCd2bHoGJtLtgqtWS5UpdhZBUPpvhYCHs1+2BN8itipnNgLw3QttOlHmDQ6t?=
 =?us-ascii?Q?x9Fv7e0VyuEMk916wd0NLvv/E0g+J+do7hOYbc0qqcbM31VYd0CluXyF2iZ2?=
 =?us-ascii?Q?v/iHprhQlJmnJSqBRYHpfvYt2sLs3FpWRwYAqWdyHpWtyt7dKBgS2mOy7bUs?=
 =?us-ascii?Q?Vp8BoOEUtIUyNO8ZF6Zv6wuw4CwSRmGsx+t1FPr05Sjj7aUE4qCaXLuRtaRT?=
 =?us-ascii?Q?YW+Z8voEixZumyNfa3EutuD5fCSak2MnXFAixv+6ZSGXuD5HCUMlXwNxsvyM?=
 =?us-ascii?Q?QOacEiawwoRomQ4CfxY/ssHo8xzJTNYRAUvP6IMIQxMNnd/sSxNup8JwVDum?=
 =?us-ascii?Q?OsaMEXX/MpS4Lf1q0CeS25nM2j5lBB6FrClvpl9hT5h7+24ijH2eeZupSX1+?=
 =?us-ascii?Q?smHw2LgTZVG5IfEb4I0HIwca/gxOCNMLD1fCX4Vgv9b8JAY9oVtjIoGYO7la?=
 =?us-ascii?Q?hL8ZU98M26ILw2rX5HXSisDs7kwVc2rUZvifqfrKKYxVzwr1dAe5tXE4pWuW?=
 =?us-ascii?Q?jMX9+RtQvXjqzFS2Wdz+kaDAGckVj9knOxhx+t5FZqSsifRjbOhrLPdMNybd?=
 =?us-ascii?Q?trM25iQm3vvdyZDsiGIBVhXBxUXc66HNKkKFZtvE10f/klDQ7mcjnB6/gwrz?=
 =?us-ascii?Q?UtclAbVIh1aS91Nx1/O+QsDq+kC+80pZ4VPCmYrr8ds2iyqegD2w9YxKDelO?=
 =?us-ascii?Q?bS25Przjm5jrn7tospKPG/rTdnahgWNe1wu9Gsw91qPcx9ZbpKH+bLFTerqz?=
 =?us-ascii?Q?N8elootQLYTBi5ZJ0qbeZHLWwo18Nrg/6WXjH3ndjNuONBLoFSmLzUfMFrEs?=
 =?us-ascii?Q?lr/j+iZzF4ToU1VLohBkmVThnAKqiS4XR8Kz9PdRijl3yyNQzRe8c6SZjt4m?=
 =?us-ascii?Q?PAx1mgaScevzeINcHPDazEb/D2tx9cizD6BwRpXi9eks90hwrKpV9pbVKbBH?=
 =?us-ascii?Q?EXOFJSB3anckaV6rdBHcIm8m/Z0a7ZDo3gvLOP4YJqEzTVEO70v/al/9zJla?=
 =?us-ascii?Q?tLLvXQgNb5x6yHWTF5LdIQsYiKm3Hf/t8o63635VHX2QfLbHVD9KRycR+F+r?=
 =?us-ascii?Q?1A537z6jDvZYH2e50n0v93G732XG2rWDH1Iu68zZQMfqZDkZbnKLhP8iOHiv?=
 =?us-ascii?Q?y3R9N9rvBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ffa4f8-baaf-44bd-8b80-08deb6ab50e8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:06:44.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW872oIE9cZvgPKFK+npSpnv67I30kfAbbrN0qu9rlnOrqVFijvlJsDEfEj4gJxDWPTlMpDkLRcjiBb9BHI0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253377-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1241859925A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:42:42PM +0200, Justin Iurman wrote:
> Reported by Sashiko:
> 
> In ipv6_hop_ioam(), the hdr pointer is initialized to point into the
> skb's linear data buffer. Later, the code calls skb_ensure_writable(),
> which might reallocate the buffer:
> 
> 	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
> 		goto drop;
> 
> 	/* Trace pointer may have changed */
> 	trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
> 					   + optoff + sizeof(*hdr));
> 
> 	ioam6_fill_trace_data(skb, ns, trace, true);
> 
> 	ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
> 		    GFP_ATOMIC, (void *)trace, hdr->opt_len - 2);
> 
> If the skb is cloned or lacks sufficient linear headroom,
> skb_ensure_writable() will invoke pskb_expand_head(), which reallocates
> the skb's data buffer and frees the old one, invalidating pointers to
> it. While the code recalculates the trace pointer immediately after the
> call to skb_ensure_writable(), it fails to recalculate the hdr pointer.
> 
> This patch fixes the above by recalculating the hdr pointer before
> passing hdr->opt_len to ioam6_event(), so that we avoid any UaF.
> 
> Fixes: f655c78d6225 ("net: exthdrs: ioam6: send trace event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  net/ipv6/exthdrs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 47c5502a34a2..2f991c974395 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -967,8 +967,8 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
>  			goto drop;
>  
>  		/* Trace pointer may have changed */

If you need v2: /* Trace and hdr pointers may have changed */

> -		trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
> -						   + optoff + sizeof(*hdr));
> +		hdr = (struct ioam6_hdr *)(skb_network_header(skb) + optoff);
> +		trace = (struct ioam6_trace_hdr *)((u8 *)hdr + sizeof(*hdr));
>  
>  		ioam6_fill_trace_data(skb, ns, trace, true);
>  
> -- 
> 2.34.1
> 

