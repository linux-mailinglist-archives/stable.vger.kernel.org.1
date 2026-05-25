Return-Path: <stable+bounces-254159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKQ/HI5hFGrsMwcAu9opvQ
	(envelope-from <stable+bounces-254159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B75CBEE6
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E74302C904
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44B3859D2;
	Mon, 25 May 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUS0y2oX"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B24282F3E;
	Mon, 25 May 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720441; cv=fail; b=WBFI2ndNmtWohzRB03Y9cRMdqZnygNgq0Fr6oVyKC0BNWjq79L8fV5OJsrafb44N+ZgVhujZZnPj42QemjsLeXMAZp7KxZUnPsO8Zwd4EdNvKTnTKUCT5mviwWZvDvnxnKeKy6RynhvkTM5AYh0LyJXzzXhpX2TWX835u6tDIww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720441; c=relaxed/simple;
	bh=5zIFyBSpygckQR1mqVAzGdAd4PmQ7QNFKg/C3dmuFhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QzTJ80xR2X+VJxmgGXKi7OSmXHDAe9iWqw+qkgebIbEjqC01gT2MnVl7vdBelZXt4uSZLy4qz1bo78xfjLY2ve6FrogTWymy+5pwA/QmJhG7jIkXmNO6QZOlxUXYA2Pn3gGVFrqAsEUt10wUAOvCcii1zcyXM0RKbESQgc2yvCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUS0y2oX; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB9h5ZMONRoponTJqAILzfsA6braQRUzObkz+9ViHujQc1EoYFnk0dXp6CAzsdzLihjLZEJr6gR63ONkwC4GzGIAgLO0qdascNQ7ePT6cU6MlL4uZr1C+QaNrbFDh/Q8uUxKZf+ZPFEDiCnToV9m0qjAmEYYW9cSeC0+ZWvVzdspHnr4po68R8JEP1YkFABLqKGb3DSaF+/Fan0L2CTeDIChPu9DtHJ7evphPxnzDXuBfPyJwp0yLp6kVfo0/yfSD3VgcH1gVvodWZ+AdWpdow1TirKiU2A1zf0V+sNHKISSMN3UEo+6SJhRCGeJd3rzcCR6KxQSf0TlMUi+kzBimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h++5jPG/NxrGGbWTPKOdmzJOOCQn3KFIXkWAJq5hgpg=;
 b=BQEtVeUQFLeopAGpQmsXNqmxCz6KGQZlWekK4XnrGzmphjwdRzfNyJZ0BqHjmhpHUYoDnM2K9eJ6ym+Bdhtymy9rXD4mCpJmHJFBqb90KrdkdkNpP3lJPnBwZQRdOyPuFw+ts61CVRyi0Q14tAonqRw2Y1TiALmngx+2gaTL6W/UQdJcHE8SB71tVNRSxhnUqaz2vdjZWWS1ro5A1OIE7TiS+wLtP2zXKHoUvBupZAH+EP3jysJVdlPx/AhQFg2+PD+X5pu+dNLQgnRyTthYgSLKDisj1F8MTAlKt0f/ez3jS4503mBxAxqM6rcYGfA0ziQfTe3HapVHdEIKUNhE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h++5jPG/NxrGGbWTPKOdmzJOOCQn3KFIXkWAJq5hgpg=;
 b=UUS0y2oXJBVQlIciUklzFRqKk8taq1o+a1s9GXi9V9akPPoVZpxzEBXuD0MSd8867Vz5VKjvxtY8Q4ooWt0i2GZqYqGJn3Q+zPIr5+03PjJEMUq64yIUU/H4Z26yh4jxaGJWMeUGriGn9gdx1KODdpk94elluXGRr/H8EuegHV6UUZYeVwGkAR+Qs2ngSw78KccwHPUP0q0Z1uIXS/IjWuPnpaM42FcPugJJ/CZAgKSUjeHeqx7ayMkLOvjZsR612Zrp9IRSIofgLlG1gtd/HrbRXtOli0e3UYi5fLcB6Klo/QFbEs6pgP6+dkzDffGODxXr2QyZRDV51YqAakbY+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 14:47:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:47:16 +0000
Date: Mon, 25 May 2026 17:47:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de,
	lyutoon@gmail.com, stable@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/4] ipv4: validate ip_options length in
 __ip_options_echo() against skb tail
Message-ID: <20260525144707.GA217485@shredder>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
 <20260524041442.2432071-2-tpluszz77@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524041442.2432071-2-tpluszz77@gmail.com>
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 14584141-6739-4c5c-d7ab-08deba6c83f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	KpZ2fHRzBtUCXQM/LSQODf7m/9RQ8qLHoerWCtE6L7MoM9oe9k6Rrf4wggTVLjDdU9gnyt1M87E5Og1cbqnbl/xcBbvsdsY4KBDnwXg72XpsTpEP2TA0RCQZCRKggA6rKxQtnFKRbPeaSyNdCJaLELwgxcTf4x5SbMa/bntu2sHOwqWmu1J+FbykRl3IY5kNj0B2nkusftfTw7oXl3pEApvNUr08sU9ndDZa2SFCmYop+RS3X4Y+lZXaCRvF7fa8pRK0M6uUJYeZP3Xis9j3xvgMAjYokufK4whh/xpEfcrLPCleK1qKFir5bLxZSA9MT0tsoC9rMS40xJldHHFQF+Xl8TwHmsU3b9uc86ZhGwycSmqXkq6BmcPzhfLY4WG63WSJW5dk7zOI1j45o30aZ1WrLr12xqz/7NndfLEjoJ/tTKMVjBUqr6JFy9WJpPF5UYzWn+JnMTHLqxi7ia3nOkRvYZtJlO+imPnvxPzjtIqHlckFk5eVsSjB/oNrmjIuuGe6Scx40T6or+luv+XsWidwqbx84kjg+Wv0CtgMYtCnE6nhy3N+S6VTgIRtoWDQU2z/l1QOyk6MfhQnNMZktqgjTDCOzDTX4HkCi3JY51ylnQHRpV2HwioKdl0QNUqm8wE/KL+QM+XNps+2QTl0oJEZx69NJHt/2Wf4dpqeMr23oj+ZBQsjxUnsVf2hBDj+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eeVZmkkqWIZnf7JLfrE1UFqAc7QvIEGg+fMlTnLtB3neSaoDgihb+nKzfOab?=
 =?us-ascii?Q?YvRCj105CV0aPmdCLsqqzZ6CdAmlGqGJBqQua62wLFmJgEMT+9f9FRUNOlbU?=
 =?us-ascii?Q?O82ZrYGMkwtfG1KF3h9tTOgfZnSnonZCHI7De3bzJec4v4ZvGLKckO0sBDwc?=
 =?us-ascii?Q?8hnHvo0RoRzKSk4d//+pQQHcgfW+W+4U8Yw6St21uEkQQ6IPZFM/+IXGgir3?=
 =?us-ascii?Q?NoSsLXKeqRvuXzXQE2LD63ECqnZnzi+eKJ67BTINyuXzBBy8fLaVU+Zwj8ep?=
 =?us-ascii?Q?uP481mRr7gIUF7Mt8orU84H/DdZa11IyseRpIisI2fzhoQB4oTS6W0OzpLtR?=
 =?us-ascii?Q?V/Ym4sJ7zEhSwSQrN6eoqTwAD77/+sGjkqlusEJRChENn8IlH1m0sE9NLLl3?=
 =?us-ascii?Q?kdQWd89Rc7K3wDUfhyJe3U8YJZh2elqFwIIBTmG8YTMJ1UFL+W3oQORwkZGg?=
 =?us-ascii?Q?SlRLV3zSzPApZa2+ZnQqCjmUfU3yolzDt/WiiZkip9itp/qVSgUj1kGs6guK?=
 =?us-ascii?Q?mCaPPTCbK0LEaPGwBOsW5w1/7yxEkPBo7xRGs0Y1cLNKhNJs9XEMGOhEBMft?=
 =?us-ascii?Q?DZGg01HGxp8w2CnUjvrFtBjZdx0DO0N0K3bf6zn8m3jWQuVcus2hJMeCIAn/?=
 =?us-ascii?Q?6UJdPy29IZIAiFDyEAD9d94JfqiwBIYPgmTHyaCRq394Og6v8HH56kFeHrdf?=
 =?us-ascii?Q?R/+wn9dcsNDm5YNQb1y9FOP/g+RTIWgbdAfdPAq/exmy3GEuaogQSafpN5mF?=
 =?us-ascii?Q?qNFR0v3YHeBnrUT0dCZPSvfgOZRa04xr99VbvuurAUG703MDVnumojuUw6wS?=
 =?us-ascii?Q?oQmUxI7+lVDrP96hEcQ76FPlO6eY2VULvgUKqYrYcqrRQUUPqh4reb9OGUve?=
 =?us-ascii?Q?DQUJzwudirWcQeoge09gcCkTG8ixUo6xf4mQ+vNfb50CvIBtznqAv3B6ehb/?=
 =?us-ascii?Q?hO2hn7jB/9l8wiTWA50LBWqSU/scwpT7eu/2av2vV/uEqI07nhc+k8D2D6aJ?=
 =?us-ascii?Q?qPWQfI7O8+FjYETqbAQG4f35iHie08BMAhqnO9UMolmZvzL0Px7BnXHbPH/J?=
 =?us-ascii?Q?QqtHNjaFPjnRs1wqR7M38ppnCyiVEe8CLgP0t97tcpmhz+KljpkChHU8FAEZ?=
 =?us-ascii?Q?zop0pof3k0rD2MLxtnnmjMH2WzUmIcXXfJZ8moDfQ7pfOpvWrl3qk/a9Xs6J?=
 =?us-ascii?Q?FeRT2auFsAQTwkec5CguMVJcz75XIl20iG/ecV6l/MrzA1rTkro7kFumg7kZ?=
 =?us-ascii?Q?C86vjAJvIhOoURqpNkDtkZA7vUFCWMC2ZKNn7BMn7zPm8ORc90Vw4xFAoeye?=
 =?us-ascii?Q?nMxsxyKaiutsxNoD7BkvicvnQgS3k9qetkeTYaJX+Y7D8bZ82UQ0c/iGqmP2?=
 =?us-ascii?Q?CZyvf4QxC+LOOriGzXNPI7llXb8Z616OwCL+AfDzV6tc0vM+ABxXVzEmsAAU?=
 =?us-ascii?Q?OLnOHiuTBvdV+PWm0KUzpXO4f93bYjbJBY/5t2TpVK9y+bobu6xZc1DwhSjK?=
 =?us-ascii?Q?zB06FW2IthuPHJ/pata9gPmAYG2pWuD5OGwj8aSFJZSk/Ydxkx+cur/I+lse?=
 =?us-ascii?Q?Aj/dOQey7qHxMfR2JFmKPbnKSsuu+RJAEhs1u2hoz4BVdEL/b+uDGn+rvxLd?=
 =?us-ascii?Q?/8e90iXzQVGF9iKwmskfDh1gZt9AhJVb+p7beSWQrywXHfcKM5RXNfvssXbV?=
 =?us-ascii?Q?/t4vmjcFB1b6qSVnjRDqVwaAOieqd3BcGlx/UR3b5vQxjwDk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14584141-6739-4c5c-d7ab-08deba6c83f8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:47:16.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRd8RL4nT/HIpXHV1wv87RVk22AXvmGSk84qqXb2yJw1x9C0oCZmo4/vTMgoSF+BWfiQjG6aRq2IuNI4us0a4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254159-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,strlen.de,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1A3B75CBEE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:14:35PM +0800, Qi Tang wrote:
> __ip_options_echo() re-reads each option length byte (RR/TS/SRR/CIPSO)
> from skb->data when building the echoed options into a 40-byte
> __data[] buffer.  __ip_options_compile() saved only the option offset
> into IPCB(skb)->opt, not the length.  An nftables LOCAL_IN payload
> write reachable from an unprivileged user namespace can mutate the
> length byte between parse and recvmsg, turning a parse-time validated
> 7-byte option into a 255-byte read.
> 
>   unsigned char optbuf[sizeof(struct ip_options) + 40];
>   /* in __ip_options_echo: */
>   optlen = sptr[sopt->rr + 1];        /* re-read; nft can mutate */
>   memcpy(dptr, sptr + sopt->rr, optlen); /* into 40-byte buffer */
> 
> The destination is a stack buffer in ip_cmsg_recv_retopts() and a
> DEFINE_RAW_FLEX() buffer in icmp.c / ip_output.c sized
> IP_OPTIONS_DATA_FIXED_SIZE (40).  KASAN reports a stack-out-of-bounds
> write of size 255:
> 
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo+0x7fc/0x1310
>   Write of size 255 at addr ffff88800a657950
>    __asan_memcpy+0x3c/0x60
>    __ip_options_echo+0x7fc/0x1310
>    ip_cmsg_recv_offset+0x58b/0xd10
>    udp_recvmsg+0x8da/0xc20
>    ____sys_recvmsg+0x1b1/0x620
> 
> Validate that each re-read option length stays within
> skb_tail_pointer(skb) before the memcpy.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/ipv4/ip_options.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
> index be8815ce3ac24..1cc6096e6dd9d 100644
> --- a/net/ipv4/ip_options.c
> +++ b/net/ipv4/ip_options.c
> @@ -91,6 +91,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
>  
>  	if (sopt->rr) {
>  		optlen  = sptr[sopt->rr+1];
> +		if (sptr + sopt->rr + optlen > skb_tail_pointer(skb))
> +			return -EINVAL;

Both Sashiko instances flag valid issues. Please go over them. The most
obvious issues are:

1. This check only avoids reading past the skb's linear buffer. The
memcpy() below can still overflow the destination buffer which is only
40 bytes.

2. There is no validation against the original IP options length
(sopt->optlen), so we might be echoing bytes from the skb payload (past
the IP options).

>  		soffset = sptr[sopt->rr+2];
>  		dopt->rr = dopt->optlen + sizeof(struct iphdr);
>  		memcpy(dptr, sptr+sopt->rr, optlen);
> @@ -105,6 +107,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
>  	}
>  	if (sopt->ts) {
>  		optlen = sptr[sopt->ts+1];
> +		if (sptr + sopt->ts + optlen > skb_tail_pointer(skb))
> +			return -EINVAL;
>  		soffset = sptr[sopt->ts+2];
>  		dopt->ts = dopt->optlen + sizeof(struct iphdr);
>  		memcpy(dptr, sptr+sopt->ts, optlen);
> @@ -145,6 +149,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
>  		__be32 faddr;
>  
>  		optlen  = start[1];
> +		if (start + optlen > skb_tail_pointer(skb))
> +			return -EINVAL;
>  		soffset = start[2];
>  		doffset = 0;
>  		if (soffset > optlen)
> @@ -174,6 +180,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
>  	}
>  	if (sopt->cipso) {
>  		optlen  = sptr[sopt->cipso+1];
> +		if (sptr + sopt->cipso + optlen > skb_tail_pointer(skb))
> +			return -EINVAL;
>  		dopt->cipso = dopt->optlen+sizeof(struct iphdr);
>  		memcpy(dptr, sptr+sopt->cipso, optlen);
>  		dptr += optlen;
> -- 
> 2.47.3
> 

