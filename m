Return-Path: <stable+bounces-144732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A9ABB3BC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 05:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8248A1894740
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 03:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A81B4248;
	Mon, 19 May 2025 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mw2n+m0B"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC41FAA
	for <stable@vger.kernel.org>; Mon, 19 May 2025 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626974; cv=fail; b=P+L+vDZioclcIPGf6BsP4YYU6PnEPwGRBH53lkB5tLpCx6fxdZQorad989KORQv/ETqMXFkjFBJEEudx1j+axAOXv45XzGrwPSfbhZrUdHoWMy6sG4FBnnKuIbhzF/D08YQWD7aXoQdeiAWUQhjVzPOwqei45cXb9bsn3H35JIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626974; c=relaxed/simple;
	bh=3BR8AwZiNsfwQEKhbmz9qTMx7POxhLlBRRvQJSWu5QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1/pS/AJrTOpopp8L4iGCQZTZoz/VnQq0Q9iUDYyWjt8IHw2Q6seG3ldQePYLi2fWFdlhXySLMwnDFGPVBk/6Zh+9h79zLWj+wVKY704E83+mmXpHG6Knr/QWjKWugFhsTBnPBbPVMBYVOxzi0pDpw/yHMWN584ReVv0xNMooNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mw2n+m0B; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/neOuJ2vYyFgV/2wfGLBlD1IdVhfYWF5Thkio5lrh/DyZdHyOr7gWz0ypCMhNo/yi6es4O2Ot75RTyXvP0kHK+naY3daEbQJOFIpHvr2quhrzEYaIlujctvc9EQtdbdj0w4/K8sCl2JwWU2eLlUx7iohT+1MZ0QBD8HAn5qygTkXwmqiTXrMZTUsnUMJUmuH9qs1v+lRzR1y1plGTwkJuB0zZ02jHcEqVhQdLRRV9cLCd+bcFk51T6eoNOgf6r1TrfNaf2Eq4hpKgo4usAoOOq398RdvER9a5m2LTSGMK7wCagw0a0t1UG2YCiMZkluI2khaw7oK1Kh8E2KNoe+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYdElmk5M85FvK4cCKAKVONq+eyM/Lu4A7j2EPFSxVk=;
 b=MimckIIIV0HDhyopH8mr3XnP0ng9lYEs6o0MA4w7k2Wt4iWTAst+6PRQDcB/XQDnz3mHSmK5+MLHpGpH3ltAdaWkTUptZPjbOLoAkQ/7W7GPdQ6Aav6hj3/rVdEgNQJuY7xz8uouMBhXxitXiTXBuvtaMdQzuQ9dugSOR133DAQ7PGObv222qAcq+IzAkbPzfm5Ziy3UWs2sfhoRmwiqKlmdwLgR9r1VKFfEI9VHGq4lSxezKIOvckj3uW+RABC5/M2h6PIEA4YqIHCGpwPdcaPwixNSWahcqZuQ2RSEaJ20I5RgQk7u/0YN46bN2a9G8qKR8eTNKJsyA9ztSpuL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYdElmk5M85FvK4cCKAKVONq+eyM/Lu4A7j2EPFSxVk=;
 b=mw2n+m0ByBbNWb9EiVrInMehp8U5XojhPomz4OnXr0i/GHzNcbVuYg+4St+Ccjx4L7mVoTsIm4ahO86n8USj1eAXACRQ6+RB3i84UILESWIl+UtrX/QAfpxCcNTDJ1LPiLsC5aA7xOt3G2RX7xNPGyPt3c7I9L6aQ+Kw6WW38LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ee::11)
 by OSCP286MB5970.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:434::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 03:56:08 +0000
Received: from TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4fa2:6269:5738:624f]) by TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4fa2:6269:5738:624f%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 03:56:08 +0000
Date: Mon, 19 May 2025 12:56:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: gregkh@linuxfoundation.org
Cc: koichiro.den@canonical.com, jasowang@redhat.com, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] virtio_net: ensure netdev_tx_reset_queue
 is called on bind" failed to apply to 6.12-stable tree
Message-ID: <w62qwanyhy53vhyhuguyn3eqqivwkjdnniywbkq6rm7jamfj6t@63d7g7qc27sz>
References: <2025051251-shawl-unmarked-03e8@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025051251-shawl-unmarked-03e8@gregkh>
X-ClientProxiedBy: TY2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:404:56::31) To TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2ee::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRP286MB5957:EE_|OSCP286MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: adc7ebe8-cfcb-4c1f-cf4a-08dd96891621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FD40De9dnb6ZhjwYW6HbK4sOSnRuZkRm5myDGiKzw5zjuCaysF8Wx+1v3aFU?=
 =?us-ascii?Q?nFkTKrbbDVlyzQg1Ie9ni95SrUF0e8bhG9QTkd0C/hU9TxgBISsS12j9aKIC?=
 =?us-ascii?Q?o1iT4tWRQCmMJCTd9naSbKMVgcjQSJLHypuSSoLaKm1uR9SVdm6X3V5hJJ27?=
 =?us-ascii?Q?+Y4HfAWgo92NGG5r5tNZzLkSuK5TTz7Tyz6ZUUNl5MuQgt8uTjuthBGuLLxr?=
 =?us-ascii?Q?p2nnwhppXXg6nICC59iuczOP1cqd4yF6Prh5fiNf2pKJSG4DLGAWWhe6PBzj?=
 =?us-ascii?Q?Oh8ncCVgFnZf4gptebmtNNGbxN7vzg0rrPkY1T41eg4AEnN9I6Z2VBPI6Zyp?=
 =?us-ascii?Q?5udP7JOgHzY8FZ7eGo9EEGkWaKSM2tJAYRglnXWMGkB5Qiu2zNdbXjOgcqsN?=
 =?us-ascii?Q?BrM6ZIe7P3/UqBwNJKJQJgHTXlaaJmLC05YoaeLgq7lQQenxBPuQDlExrS3x?=
 =?us-ascii?Q?mJsPysgxIEdrayA0LbEdo5Q/vKf/q09+EUKlPiogZrUKDivwD78g6TbwDOFw?=
 =?us-ascii?Q?yR8YqAi6FqY0K2ahkPzbiPJTsPOgmih8km1nagVy9WiSsK/HEShcPcmIxi/b?=
 =?us-ascii?Q?cc67kNS9CEUriiu7J+KPywdxGM7C8Yky4KsS86M4UEZabda+HHT2uxH5rW+9?=
 =?us-ascii?Q?1SF+JeXHoaQTYUzHcliJZFI5sXiOaYtnXg+Cj0aZV5CMzxe8pMAhbI3ZT/IH?=
 =?us-ascii?Q?a/nNYz+X0ThT0dfRF/vxmas/aiZCMWyE/yFZSL0Sm7XjdUbZGNPpYeOyCCmm?=
 =?us-ascii?Q?DUBpqNTzeoQT61ImyNhzNgLz6i9qBsk2elPyFNKihPr0lKCfm+1BarrYThd7?=
 =?us-ascii?Q?mCVERCXrofTZVZNr4Cr7X9nKVjGVPjgTWnHUmoU3zPyXfTbo/h77ga9YR7/e?=
 =?us-ascii?Q?fdS2n9pgx/Zh3t/YPDCHKZ/dkU1QrNqynPTB+muWNomSM9/HU9vV3TUJoe1x?=
 =?us-ascii?Q?Q5GW1pvk6TuD24LHCV0cvCGgUzXqB6hNvOOwMC8MiO8rj24fN8fyXiOMuNYt?=
 =?us-ascii?Q?LQvXgBKP/frexUbmZ8gwLN378a7OtbWiWOz0ICmbs+S7g36GZNlvMV+4acyp?=
 =?us-ascii?Q?EIJhrOdrn1k0HmkU57sjqXopF6UO0/w+PjoV9Fp8A1ClQNDI6UMth81zEROL?=
 =?us-ascii?Q?irZFqNLPxDsxGH8JLtNJdELs0pXJhgmuVKl3WldCODmTRTp55jbs3AOAoF7j?=
 =?us-ascii?Q?vgmhARMDy/F7zdE3krVA9MW7yIgi/4AIKfyYzozB5fvA1DNNiJdevh3ShhZg?=
 =?us-ascii?Q?l5JQ8p2wd7SBtZ/v/HPbXiqtMyeXliq7lZZAan9pBE0jfrP7z+08IJxxthcw?=
 =?us-ascii?Q?bCKE9c/sOGoire+ZgEnnOqBOI8v0aZ3VDRbmiZZvrsO5Fhw7pniv3WjVha5O?=
 =?us-ascii?Q?wC+QctE4s0CXcQJRDwQIGalADOnmEmRQImnbUbCR041Qg6rQo5m1GvIK4fv8?=
 =?us-ascii?Q?91qaj+ZpaQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OY2Tvt21o9Khgz0l/PX+tTxOHPZRqA5pE/6x8BrDa3z21a7s+JJEZQWc7gJ6?=
 =?us-ascii?Q?wRrfEDzskp8DejUdziqEsncKeO2bDHBRgpz1wvf4ZFNTdu8YcbkVkoaJW6WN?=
 =?us-ascii?Q?J7e/oZiv5z88IuMRRf9tnYiKnlCmAxgvcWqe8re/z18h+UTT5WCeQZnt1vGx?=
 =?us-ascii?Q?B9u0WJQOb06Yi5xApnP/1hdk/52nBsEDuaYIWe5/uyL6cYTvRitHWcZEbkoo?=
 =?us-ascii?Q?TlQUUlBS/3MX/PZqofZLfp83T0aRUpSJ/GOBl6cqKIHXJg/U7zLTJuzNCO4Y?=
 =?us-ascii?Q?TJQKlvu1oYfPFGyM6aJWEw0J6zIYu1rv6ECwtGRUW3xZoeGLfHfzvs6P+OVW?=
 =?us-ascii?Q?vWa/Yjk+EVaddEI8fylZJ8fHIhGqq3B6hvXycMDWGwAz+j+QOgYaZPUkxaJG?=
 =?us-ascii?Q?hRyxJzY3MznYAbSb4tEXil96qxrM/oWOi4Q3yGN5mk+Sp2sYVqMgtPQGU6Hx?=
 =?us-ascii?Q?+klaiiRV7yEYLz4uZOHRH2QyejI3kQMztsgMlvePbQz8AE/f13Nd8YJr9P0L?=
 =?us-ascii?Q?NoXFWqMqrm3tFD1SyTJFDBs2kTdCAVVl/lHbaaIrUoPoLF4k/wk53f5UzY4M?=
 =?us-ascii?Q?L0ptAG2jT704t8z1rR7oDidg6hb0I+87qf3uD/rwDXKLt+Q2n5Mi4MZNqwLv?=
 =?us-ascii?Q?TbJCpN7qXzGOqfpdlqeaLKUc0I3SXMFqGZtW7SPZKq8UZxF0myszeT+Nif3k?=
 =?us-ascii?Q?vjJkyXQXyXKBhV1J4rgKQEmTojrf3AAEuHZE0LG8xIcjLMgWnOkdZ7PdxUYw?=
 =?us-ascii?Q?z6+SnbjkXGwmvSAOG9p9jU3ght6KVK8UWvpqg4ZmoJkWSaS8LnohWqGXGrgf?=
 =?us-ascii?Q?puDZfBaNaAXaj5GmDRkriZPcxaISGf0cmE5+99GDaQb27sKEviFvkqGm0U0f?=
 =?us-ascii?Q?Tu9wzFnfZs/KlsX9aEnNkxAtqauqFpfG47PViMKtVefmQAo2hUXujrmoWk98?=
 =?us-ascii?Q?rI8LyE40sXS0eAAitx27dqFu90iK2upwwKNHq0aRXe6NeCgaGtdDzErp1WVW?=
 =?us-ascii?Q?WJUCZGOg6arBkQsv0X9s4s+d7EMbb2C/PIU962CwU6XaW1Jl0KyBUtxrO7mb?=
 =?us-ascii?Q?9vIFKQyDfJXD2zP/HblhwskI3SOH6hWaahMuSWbnpptZ/aQhxXzVHyheqWps?=
 =?us-ascii?Q?sYqjm8nosrmfV40S1sf+N0IYCw/eDGVgoK5irOiU6rpejnjFX0sq5h65tdG/?=
 =?us-ascii?Q?0AtkSfdfKkX8Bmmh+FlcvG6fRrR4H2iMpQq02Q13y3N8yNE91k8ErPnTntJp?=
 =?us-ascii?Q?MGJeaGHijWoLwPaxaTnj0jZaDp9EyCWpPh4EtaXD4Epcv3CqZixEc1K78Tep?=
 =?us-ascii?Q?SbQcGf6UhT4jaQYSnkGhrkdT70ZOMu8CfzT9b4Wxeilf4FfwH8YJP1eTC3Cy?=
 =?us-ascii?Q?KfjNqgYGwSb6VXdiDgYWq5LQQqbjXeYXdeKq0RuT/z5cwP83Tko8CV5Yw+Qj?=
 =?us-ascii?Q?+OPGnUBBJX6MHlDsuvG6gkFxnQoNrGZlCEuRTKRm//oY3gNBcwPwqtGCc2ZN?=
 =?us-ascii?Q?yxtDcE4GhXeHDjNo898BXiwKNKlJ7uSIEC4QFYGdl+Eyg+AuZAnZVRmkTz27?=
 =?us-ascii?Q?O+W1Pn6hGO5kghIaejgcMr5qlRZrYpU1nUCNx5Ck1KAPtrnBUWk4CLuepp4U?=
 =?us-ascii?Q?HsHsrOEFK9nVBD4K6guDHUw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: adc7ebe8-cfcb-4c1f-cf4a-08dd96891621
X-MS-Exchange-CrossTenant-AuthSource: TYRP286MB5957.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 03:56:08.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0JLd3AOBcXu2R82qEQAhScZPQoBX7lZazUa805sIO0btB5TT6qYlY9QhHKWzuPHemCPgO/PnEH28FDbNaifDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5970

On Mon, May 12, 2025 at 12:51:51PM GMT, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 76a771ec4c9adfd75fe53c8505cf656a075d7101
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051251-shawl-unmarked-03e8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 

We need the following prerequisite commit for this FAILED one:
8d2da07c813a ("virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()")
Both the prerequisite and the fix can be cleanly applied.

  git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
  git checkout FETCH_HEAD
  git cherry-pick -x 8d2da07c813ad333c20eb803e15f8c4541f25350
  git cherry-pick -x 76a771ec4c9adfd75fe53c8505cf656a075d7101

Just a note, I'm no longer at Canonical, so please reply to this new email
address when needed. Apologies for the delayed response.

Thanks,

Koichiro Den

> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From 76a771ec4c9adfd75fe53c8505cf656a075d7101 Mon Sep 17 00:00:00 2001
> From: Koichiro Den <koichiro.den@canonical.com>
> Date: Fri, 6 Dec 2024 10:10:47 +0900
> Subject: [PATCH] virtio_net: ensure netdev_tx_reset_queue is called on bind
>  xsk for tx
> 
> virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
> DQL counters need to be reset when flushing has actually occurred, Add
> virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
> to handle this.
> 
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5cf4b2b20431..7646ddd9bef7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
>  
>  	virtnet_tx_pause(vi, sq);
>  
> -	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
> +	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
> +			      virtnet_sq_free_unused_buf_done);
>  	if (err) {
>  		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
>  		pool = NULL;
> 

